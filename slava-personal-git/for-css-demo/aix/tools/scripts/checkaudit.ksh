#!/bin/ksh
##################################################################################################
# (c) COPYRIGHT 1998 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.
#
# Program Name   : CheckAudit.ksh
# Description    : This program gunzips a promotion tar file specified by you and extracts
#                  the .csv file.  The script then compares the files listed on the .csv with
#                  the true contents of the promotion tar file. If files are missing, an output file
#                  will be produced.
#
# Assumptions    : The script makes the following assumptions:  the tar was compressed using gzip,
#                  only one .csv exists in the tar file, the .csv does contain any errors (i.e. 
#                  missing or extra commas) 
#
# Usage          : checkaudit.ksh <tarfilename.gz>
#
# Date         Programmer         Action
#------------------------------------------------------------------------------------------------
# 4/30/98     Gabe Abella         Original code.
# 4/30/98     Gabe Abella         Changed script to check for the existence of the SubType then
#                                 object name instead of just ObjectName.
# 4/30/98     Gabe Abella         Added CheckRemove function.   
# 8/12/98     Ed Deutscher        Added code to perform one-to-one check back and forth between 
#                                 tar file and csv.
# 8/17/98     Ed Deutscher        Fixed code to check for static and relat tables and to only 
#                                 print to the screen for certain recompiles and relat tables.
# 9/02/99     Shawn Hyde          Added code to handle POST_CONCAT state static table promotion
#                                 requirements.  See notes below on POST_CONCAT.
##################################################################################################

########################################################################
# Post Concat Flag toggles additional processing required to determine
# if static table promotions were succesful in the POST concatenation
# state of a concatenated client.  Turn this flag off at the same time
# that other POST concatenation promotion requirements are turned off.
# PS and PP EXT variables are only required if POST_CONCAT is turned
# on.  These must be set to the required extentions for static tables
# sent to both sides.
# EXAMPLE:
#      CU##TB##.EBC.CE.Z  -> PS_EXT=CE
#      CU##TB##.EBC.CE2.Z -> PP_EXT=CE2
########################################################################
POST_CONCAT=ON
PS_EXT=CE
PP_EXT=CE2

#######################
# Initialize variables. 
#######################
tarfile=$1

###################################################
# Prompt user until a valid tar filename is found.
###################################################
function prompt_user {
    print ""
    read tarfile?"Enter the name of the compressed tarfile (*.tar.gz) for verification:  "
}

###############################
# Check for correct arguments.
###############################
echo $tarfile | grep ".tar.gz" > /dev/null
while [[ $? != 0 || ! -a $tarfile ]]
do
    prompt_user
    echo $tarfile | grep ".tar.gz" > /dev/null          
done

##################################################################################
# CheckRemove: function to remove files from the current directory if they exist.
##################################################################################
function RemoveTempFiles {
    rm -f check.tmp
    rm -f contents.tmp
    rm -f contents2.tmp
    rm -f csv.tmp
    rm -f objects.tmp
    rm -f objects2.tmp
    rm -f $csvfile
    rm -f line.tmp
    rm -f tarobjects.tmp 
    rm -f missing.tmp
}

################################
# Remove existing output files.
################################
rm -f missing.lst

################################################################################
# gunzip the tar file and direct the contents of the promotion into a .tmp file 
################################################################################
gunzip $tarfile
tarfile=${tarfile%.gz}
tar tvf $tarfile > contents.tmp

#####################################################################################
# Grep for the .csv spreadsheet in the .tmp file.  If it exists, explode it from the 
# tar file.  If if does not exist, then provide a message to the user and exit. 
#####################################################################################
tarfilename=${tarfile%.tar}


if [[ $POST_CONCAT = ON ]]; then
    typeset -i PS_EXT_LEN
    typeset -i PP_EXT_LEN
    typeset -i TOT_PS_LEN
    typeset -i TOT_PP_LEN 
    PS_EXT_LEN=`echo "PR${PS_EXT}" | awk -F, '{print length}'`
    PP_EXT_LEN=`echo "PR${PP_EXT}" | awk -F, '{print length}'`
    TOT_PS_LEN=PS_EXT_LEN+2
    TOT_PP_LEN=PP_EXT_LEN+2

    PS_CUT_FILE_NAME=`echo $tarfilename | cut -c1-$TOT_PS_LEN`
    PP_CUT_FILE_NAME=`echo $tarfilename | cut -c1-$TOT_PP_LEN`
    if [[ $PS_CUT_FILE_NAME = PR${PS_EXT}19 || $PS_CUT_FILE_NAME = PR${PS_EXT}20 ]]; then
        csvfile=$tarfilename.csv
    elif [[ $PP_CUT_FILE_NAME = PR${PP_EXT}19 || $PP_CUT_FILE_NAME = PR${PP_EXT}20 ]]; then
        if [[ $PP_CUT_FILE_NAME = PR${PP_EXT}19 ]]; then
           TARFILESUBSTR=19${tarfilename#${PP_CUT_FILE_NAME}}
        else
           TARFILESUBSTR=20${tarfilename#${PP_CUT_FILE_NAME}}
        fi
        csvfile=PR${PS_EXT}${TARFILESUBSTR}.csv 
    else
        print "ERROR: The CSV filename could not properly be determined."
        exit 1
    fi
else
    csvfile=$tarfilename.csv
fi


grep $csvfile contents.tmp > line.tmp
if [[ $? = 0 ]]; then  
    tar xvf $tarfile $csvfile > /dev/null 2>&1
    gzip $tarfile
else
    print "\nNo csv file was included in this promotion.  Verification could not be performed.\n"
    gzip $tarfile
    RemoveTempFiles
    exit 1
fi

#########################################################
# Remove the header lines and blank lines from the csv
#########################################################
egrep -v '(Emrgcy|^$)' $csvfile > csv.tmp
cp -f csv.tmp $csvfile

####################################################################################
#  Cut out the client/host, maintype, subtype, and object columns from the csv file.
#  Check to see if the object name from the csv exists in the tar file.  If not,
#  print the object name, its main and sub types to missing.lst.
####################################################################################
cut -d","  -f4,5,6,8,9 $csvfile > objects.tmp
for line in $(<objects.tmp)
do
    codetype=`echo $line | awk -F, '{print $1}'`
    maintype=`echo $line | awk -F, '{print $2}'`
    subtype=`echo $line | awk -F, '{print $3}'`
    object=`echo $line | awk -F, '{print $4}'`
    comment=""
    comment=`echo $line | awk -F, '{print $5}' | cut -f2 -d"[" | cut -f1 -d"]"`
   

    if [[ $subtype = "static" ]]; then
         statobject=$object.[Ed][Bm][Cp].Z
         grep $statobject contents.tmp > check.tmp
         if [[ $? != 0 ]]; then
            if [[ $POST_CONCAT = ON && $comment = $PS_EXT ]]; then
                 statobject=$object.[Ed][Bm][Cp].${PS_EXT}.Z
                 grep $statobject contents.tmp > check.tmp
                 if [[ $? != 0 ]]; then
                     if [[ ! -a missing.lst ]]; then
                         print "***** THESE OBJECTS ARE MISSING FROM THE TAR FILE *****" >> missing.lst
                     fi
                     print "$object of type $codetype/$maintype/$subtype is missing from the tar file for the Production Support environment" >> missing.lst
                 fi
            elif [[ $POST_CONCAT = ON && $comment = $PP_EXT ]]; then
                 statobject=$object.[Ed][Bm][Cp].${PP_EXT}.Z
                 grep $statobject contents.tmp > check.tmp
                 if [[ $? != 0 ]]; then
                     if [[ ! -a missing.lst ]]; then
                         print "***** THESE OBJECTS ARE MISSING FROM THE TAR FILE *****" >> missing.lst
                     fi
                     print "$object of type $codetype/$maintype/$subtype is missing from the tar file for the Enhancement environment" >> missing.lst
                 fi 
            elif [[ $POST_CONCAT = ON ]]; then
                 print "CANNOT DETERMINE information for $object of type $codetype/$maintype/$subtype"
            else
                if [[ ! -a missing.lst ]]; then
                    print "***** THESE OBJECTS ARE MISSING FROM THE TAR FILE *****" >> missing.lst 
                fi
                print "$object of type $codetype/$maintype/$subtype is missing from the tar file." >> missing.lst
            fi
         fi
    else
         grep $object contents.tmp > check.tmp
         if [[ $? != 0 ]]; then
             if [[ ! -a missing.lst ]]; then
                 print "***** THESE OBJECTS ARE MISSING FROM THE TAR FILE *****" >> missing.lst
             fi
     
             recompile=`grep $object $csvfile | awk -F, '{print $7}'`
             if [[ $recompile = "Y" ]]; then
                 print "\n$object of type $codetype/$maintype/$subtype is missing from the tar file, but is a recompile only"
             else
                 if [[ -n $subtype ]]; then
                     if [[ $subtype = "relat" ]]; then
                         print "\n$object of type $codetype/$maintype/$subtype is missing from the tar file, but tables of type relat only appear on the csv"
                     else
                         print "$object of type $codetype/$maintype/$subtype is missing from the tar file" >> missing.lst
                     fi
                 else
                     print "$object of type $codetype/$maintype is missing from the tar file" >> missing.lst
                 fi 
             fi
         fi
    fi
done

###############################################################################
# Check to see if the objects in the tar file exist in the .csv.  If not, print
# the object name, its main and sub types to missing.lst.
################################################################################ 
grep -v $csvfile contents.tmp > contents2.tmp

cut -c46-200 contents2.tmp > tarobjects.tmp

cat tarobjects.tmp| while read tarobject > /dev/null
do
    searchobj=`basename $tarobject`
    filepath=`dirname $tarobject`
    chtype=`echo $tarobject | awk -F/ '{ print $1 }'`
    datamain=`echo $filepath | awk -F/ '{ print $2 }'`
    main=`echo $filepath | awk -F/ '{ print $4 }'`
    sub=`echo $filepath | awk -F/ '{ print $5 }'` 

    if [[ $datamain = "static" ]]; then
        if [[ $searchobj = "recsize.txt" ]]; then
            grep $searchobj $csvfile > /dev/null
        else
            searchobj=`print $searchobj | cut -d\. -f1`
            grep $searchobj $csvfile | grep static > /dev/null
        fi
    else
        grep $searchobj $csvfile > /dev/null
    fi
    if [[ $? != 0 ]]; then
        if [[ ! -a missing.lst ]]; then
            print "\n***** THESE OBJECTS ARE MISSING FROM THE CSV FILE *****" >> missing.lst
        else
            grep "CSV FILE" missing.lst > /dev/null
            if [[ $? != 0 ]]; then
                print "\n***** THESE OBJECTS ARE MISSING FROM THE CSV FILE *****" >> missing.lst
            fi
        fi

        if [[ $chtype = "data" ]]; then
            print "$searchobj of type $filepath is not entered on the csv file" >> missing.lst
        elif [[ -z $sub ]]; then
            print "$searchobj of type $chtype/$main is not entered on the csv file" >> missing.lst  
        else
            print "$searchobj of type $chtype/$main/$sub is not entered on the csv file" >> missing.lst
        fi
    fi
done

#######################################
# Alert the user of success or failure
#######################################
if [[ -s missing.lst ]]; then
    grep -v MISSING missing.lst > missing.tmp
    if [[ -s missing.tmp ]]; then
        print "\nThere are files missing from the tar file or entries missing on the csv.  Please look at missing.lst.\n"
    else
        print "\nOtherwise all objects that should be accounted for are in both the tar file and on the csv.\n"
        rm -f missing.lst
    fi
else
    print "\nAll objects are accounted for in both the tar file and on the csv.\n"
fi

##################
# Perform cleanup
##################
RemoveTempFiles
