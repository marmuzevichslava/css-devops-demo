#!/bin/ksh
###########################################################################################
# ScriptName : iosearch.ksh
# Description: Retrieves I/O module information for a specified table from foundation tables
#              (e.g. keys, datagroups, etc.) and displays on screen for user.
#
# Usage      : iosearch.ksh tablename(in CU??TB?? form)                  
#                                       
# Date           Programmer               Action           
#----------------------------------------------------------
# 10/21/99       Mary Sanzenbacher        Original Code.    
# 11/01/99       Shawn Hyde               Modification to list actual datagoups contained within
#                                         the A io copybook.
# 11/10/99       Mary Sanzenbacher        Added error processing.
# 12/30/99       Mary Sanzenbacher        Added code to specify if keys are descending.
# 01/06/99       Mary Sanzenbacher        Modified the code so that all information would
#                                         come from the iomods and not from the repository.
# 02/26/00	 Dave Aucoin		  Modified script to conform to NM environment - removed project variable.
#############################################################################################


PROJECT=t5nm
typeset -uL8 TABLE=$1 
correctlength=8
C1DIR=/css/c1
XFERDIR=/sw/transfer
TBLDIR=/css/c1/host/build/source/copy/table
IOMODDIR=/css/c1/host/build/source/code/io
IOMODCBDIR=/css/c1/host/build/source/copy/io
CURRENTDIR=.
TEMP_SQL_FILE=./temp.sql
PVCS_DIR=~pvcs
AD_KEYS_TEMP=./adkeys.tmp
AD_KEYS_FILE=./adkeys.txt
ASC_DESC_RESULTS=./adresults.txt
AD_KEYS_FINAL=./adkeysfinal.txt
CUSTOM_CODE_RESULTS=./customresults.txt
TEMP_KEYS_FILE=./keystemp.txt
DATA_HDR_LINE_NUMBER=./applineno.txt
KEY_HDR_LINE_NUMBER=./wslineno.txt
BLOCK_TO_DATA_HDR=./datahdrblock.txt
KEY_BLOCK=./keyblock.txt
KEYS=./keys.txt
KEY_FINAL=./keyfinal.txt
END_OF_WS_LINE_NUMBER=./eowslineno.txt
BLOCK_TO_END_OF_WS=./wsblock.txt
DATA_BLOCK=./datablock.txt
DATA=./data.txt
A9085_PAR_RESULTS=./a9085lineno.txt
A9090_PAR_RESULTS=./a9090lineno.txt
BLOCK_TO_A9090=./block2a9090.txt
JOIN_BLOCK=./joinblock.txt
JOINS=./joins.txt
JOIN_WHERE_LINE_NUMBER=./joinwhere.txt
JOIN_FROM_LINE_NUMBER=./joinfrom.txt
FINAL_JOIN_BLOCK=./finaljoinblock.txt
BLOCK_TO_WHERE=./whereblock.txt
JOIN_LINES=./joinlines.txt 
HI_AND_LO_ELEMENTS=./hiloelem.txt
DUP_DYN_SCR_ELEMENTS=./dupdynscr.txt
DYN_SCR_ELEMENTS=./dynscr.txt

function main
{
    while read iomod
    do 
 
# ********************** GET IOMOD NAME ***********************

#prints name of iomod
       NAME=${iomod%.pco}
       print "\n**** $NAME ****"

# *********************** GET FUNCTIONALITY *********************

#calls functionality function and prints functionality for iomod    
       print "\tFunctionality: "
       grep -E " *[0-9]+ +.+PIC +X.+'Y'" $IOMODCBDIR/${NAME}W | functionality

#checks for a '3' copybook with '01  LT' in it.  if it exists, specify iomod has static screening
       if [[ -a $IOMODCBDIR/${NAME}3 ]]; then
          grep ' LT' $IOMODCBDIR/${NAME}3 > /dev/null
          if [[ $? = 0 ]]; then
             print "\t\tSTATIC SCREENING"
          fi  
       fi

# *************** GET KEYS ********************
 
#get key information by isolating key and data headers in iomod.  Then,
#retrieve key information that is between these headers.  if there is not
#a data group in the iomod, it uses the "end of working storage" comment
#line as a bottom 'boundary' and gets the information between

      grep -n WV-${NAME}-DATA $IOMODDIR/${NAME}.pco > $DATA_HDR_LINE_NUMBER
      if [[ $? = 0 ]]; then

         cat $DATA_HDR_LINE_NUMBER | while read line > /dev/null
             do
               datahdrlineno=`echo $line |cut -f1 -d":"`
               onelineabove=$(($datahdrlineno - 1))
             done

      else     

         nodatagroups=yes
         grep -n 'E N D   O F   W O R K I N G   S T O R A G E' $IOMODDIR/${NAME}.pco > $DATA_HDR_LINE_NUMBER

         cat $DATA_HDR_LINE_NUMBER | while read line > /dev/null
             do
               datahdrlineno=`echo $line |cut -f1 -d":"`
               onelineabove=$(($datahdrlineno - 1))
             done
   
      fi

      grep -n WV-${NAME}-KEY $IOMODDIR/${NAME}.pco > $KEY_HDR_LINE_NUMBER

      cat $KEY_HDR_LINE_NUMBER | while read line > /dev/null
          do
            keyhdrlineno=`echo $line |cut -f1 -d":"`
            keyblock=$(($onelineabove - $keyhdrlineno))
            head -$onelineabove $IOMODDIR/$NAME.pco > $BLOCK_TO_DATA_HDR
            tail -$keyblock $BLOCK_TO_DATA_HDR > $KEY_BLOCK
          done
        
      grep '05 ' $KEY_BLOCK > $KEYS
 
# *************** GET ASCENDING/DESCENDING INFORMATION FOR KEYS ********************
     
#look in iomod to see if there are any descending keys. If so, get those.
#If not, look in the iomod copybook directory to see if a custom copybook exists for that iomod.
#If so, look in iomod to see if the custom copybook is called, if it is,
#look in the custom copybook to see if there are any descending keys specified.
 
     grep -n '              DESC' $IOMODDIR/$NAME.pco > $ASC_DESC_RESULTS
       if [[ $? = 0 ]]; then
          ascdesc 
       elif [[ -a $IOMODCBDIR/${NAME}1 ]]; then
          rm -f $CUSTOM_CODE_RESULTS
          grep -n ${NAME}1 $IOMODDIR/${NAME}.pco > $ASC_DESC_RESULTS
          if [[ $? = 0 ]]; then
             grep -n '              DESC' $IOMODCBDIR/${NAME}1 > $CUSTOM_CODE_RESULTS
             if [[ $? = 0 ]]; then
             ascdesccus 
             fi
          fi
       fi

# *************** PRINT KEYS ********************
          
#print Keys.  If there are any descending keys, specify as descending.
       print "\tKeys: "

          cat $KEYS | while read line
          do
            withoutprefix=${line#05}
            withoutwv=${withoutprefix## WV-} >> $KEY_FINAL
            if [[ -a $AD_KEYS_FINAL ]]; then
               withoutdash=`echo $withoutwv | sed "s/-/_/g"`
               grep ${withoutdash}$ $AD_KEYS_FINAL > /dev/null
               if [[ $? = 0 ]]; then
                  print "\t\t$withoutwv - DESC" 
               else
                  print "\t\t$withoutwv - ASC"
               fi
            else
               print "\t\t$withoutwv - ASC"
            fi
          done

      rm -f $DATA_HDR_LINE_NUMBER
      rm -f $BLOCK_TO_WS
      rm -f $KEY_BLOCK
      rm -f $KEY_FINAL
      rm -f $AD_KEYS_FINAL
      rm -f $ASC_DESC_RESULTS      
      rm -f $AD_KEYS_TEMP
      rm -f $AD_KEYS_FILE
      rm -f $AD_KEYS_FINAL
      rm -f $BLOCK_TO_DATA_HDR
      rm -f $KEY_HDR_LINE_NUMBER
      rm -f $KEYS

 
# **************** GET DATA GROUP INFORMATION ***********************

#get line numbers of data group header and end of working storage comment line.
#then, retrieve data group information between.

      grep -n WV-${NAME}-DATA $IOMODDIR/${NAME}.pco > $DATA_HDR_LINE_NUMBER
     
      if [[ $? = 0 ]]; then
     
         cat $DATA_HDR_LINE_NUMBER | while read line > /dev/null
             do
               datahdrlineno=`echo $line |cut -f1 -d":"`
               onelinebelow=$(($datahdrlineno + 1))
             done
 
         grep -n 'E N D   O F   W O R K I N G   S T O R A G E' $IOMODDIR/${NAME}.pco > $END_OF_WS_LINE_NUMBER

         cat $END_OF_WS_LINE_NUMBER | while read line > /dev/null
             do
               endofwslineno=`echo $line |cut -f1 -d":"`
               datablock=$(($endofwslineno - $onelinebelow))
               head -$endofwslineno $IOMODDIR/$NAME.pco > $BLOCK_TO_END_OF_WS
               tail -$datablock $BLOCK_TO_END_OF_WS > $DATA_BLOCK
             done
 
         grep '05 ' $DATA_BLOCK > $DATA

      fi

# **************** PRINT DATA GROUPS ***********************

     print "\tData Groups: "


     if [[ -s $DATA ]]; then

        cat $DATA | while read line
        do
           withoutprefix=${line#05}
           withoutwv=${withoutprefix## WV-}
           print "\t\t$withoutwv" 
       done

    else

       print "\t\tNone"
  
    fi       

      rm -f $END_OF_WS_LINE_NUMBER
      rm -f $DATA_HDR_LINE_NUMBER
      rm -f $BLOCK_TO_END_OF_WS
      rm -f $DATA_BLOCK
      rm -f $DATA

# ********************** GET TABLE JOIN INFORMATION **************************
# check and see if there is a copybook ending with '1' in the iomod copybook
# directory. if there is, search this copybook but if not, search the iomod itself.
# grep on A9085 and A9090 paragraphs as boundaries and
# get information between.  then, within this block, grep on where and from and
# set those as boundaries.  then, within this block, obtain all information
# in between...if there is a join, specify tables within the join.  if not,
# specify that there is not a join.


       grep ${NAME}1 $IOMODDIR/${NAME}.pco > /dev/null
       if [[ $? = 0 ]]; then
          directory=$IOMODCBDIR/${NAME}1
       else
          directory=$IOMODDIR/$NAME.pco
       fi

       grep -n 'A 9 0 8 5' $directory > $A9085_PAR_RESULTS
       if [[ $? = 0 ]]; then
          cat $A9085_PAR_RESULTS | while read line
          do
            firstparlineno=`echo $line |cut -f1 -d":"`
          done

          grep -n 'A 9 0 9 0' $directory > $A9090_PAR_RESULTS
 
          cat $A9090_PAR_RESULTS | while read line
          do
            secondparlineno=`echo $line |cut -f1 -d":"`
            joinblock=$(($secondparlineno - $firstparlineno))
            head -$secondparlineno $directory > $BLOCK_TO_A9090
            tail -$joinblock $BLOCK_TO_A9090 > $JOIN_BLOCK
          done  
          grep SELECT $JOIN_BLOCK > /dev/null
          if [[ $? = 0 ]]; then
             grep -n 'WHERE' $JOIN_BLOCK > $JOIN_WHERE_LINE_NUMBER

             cat $JOIN_WHERE_LINE_NUMBER | while read line
             do
               wherelineno=`echo $line |cut -f1 -d":"`
               onelineabove=$(($wherelineno - 1))
             done

             grep -n 'FROM [A-Z]' $JOIN_BLOCK > $JOIN_FROM_LINE_NUMBER
 
             cat $JOIN_FROM_LINE_NUMBER | while read line
             do
               fromlineno=`echo $line |cut -f1 -d":"`
               finaljoinblock=$(($wherelineno - $fromlineno))
               head -$onelineabove $JOIN_BLOCK > $BLOCK_TO_WHERE
               tail -$finaljoinblock $BLOCK_TO_WHERE > $FINAL_JOIN_BLOCK
             done

# ********************** PRINT TABLE JOIN **************************

             print "\tTable Join: "

             grep ', ' $FINAL_JOIN_BLOCK > /dev/null
             if [[ $? != 0 ]]; then
                print "\t\tNone"
             else
                cat $FINAL_JOIN_BLOCK | while read line
                do
                  withoutfrom=${line#FROM }
                  withoutcomma=${withoutfrom#, }
                  withoutlastletter=${withoutcomma%% *} 
                  print "\t\t$withoutlastletter"
                done
             fi
          else
              print "\tTable Join: "
              print "\t\tNone"
          fi   
        else
            print "\tTable Join: "
            print "\t\tNone"
        fi

       rm -f $A9085_PAR_RESULTS
       rm -f $A9090_PAR_RESULTS
       rm -f $BLOCK_TO_A9090
       rm -f $JOIN_BLOCK
       rm -f $JOIN_WHERE_LINE_NUMBER
       rm -f $JOIN_FROM_LINE_NUMBER
       rm -f $BLOCK_TO_WHERE

# **************** GET DYNAMIC SCREENING INFORMATION **********************
# search to find if there is a copybook for the iomod that ends in 'S'.  if
# so, grep on 'PIC' in this copybook, this will isolate the elements that
# the iomod dynamically screens on, but they will be listed twice because
# you'll have one hi and one lo for each.  so, we isolate these, put them
# into a file, sort this file uniquely, and print our dynamic screening
# elements.  if there was no 'S' copybook, we specify that as 'None'.


       print "\tDynamic Screening: "

       if [[ -a $IOMODCBDIR/${NAME}S ]]; then
          grep 'PIC' $IOMODCBDIR/${NAME}S > $HI_AND_LO_ELEMENTS
          cat $HI_AND_LO_ELEMENTS | while read line
          do
            withoutprefix=${line##11}
            withoutlo=${withoutprefix#****-LO-}
            withouthi=${withoutlo#****-HI-}
            echo $withouthi | cut -f1 -d" " >> $DUP_DYN_SCR_ELEMENTS
          done
          sort -u $DUP_DYN_SCR_ELEMENTS > $DYN_SCR_ELEMENTS
          cat $DYN_SCR_ELEMENTS | while read line
          do
            print "\t\t$line"
          done
       else
          print "\t\tNone"
       fi    

       rm -f $HI_AND_LO_ELEMENTS
       rm -f $DUP_DYN_SCR_ELEMENTS
       rm -f $DYN_SCR_ELEMENTS

# ************************** GET CUSTOM CODE INFORMATION *************************
# if there is a copybook for the iomod with a number as the last character, indicate
# that there is custom code, otherwise print 'N'
       ls $IOMODCBDIR/$NAME* |cut -f10 -d"/" > customresult
       custom
       rm -f $customresult
    done

    rm -f $ioresult
    rm -f $TEMP_SQL_FILE
    rm -f $AD_KEYS_TEMP
    rm -f $AD_KEYS_FILE
    rm -f $ASC_DESC_RESULTS
    rm -f $AD_KEYS_FINAL
    rm -f $CUSTOM_CODE_RESULTS
    rm -f $TEMP_KEYS_FILE
    rm -f $DATA_HDR_LINE_NUMBER
    rm -f $KEY_HDR_LINE_NUMBER
    rm -f $BLOCK_TO_DATA_HDR
    rm -f $KEY_BLOCK
    rm -f $KEYS
    rm -f $KEY_FINAL
    rm -f $END_OF_WS_LINE_NUMBER
    rm -f $BLOCK_TO_END_OF_WS
    rm -f $DATA_BLOCK
    rm -f $DATA
    rm -f $A9085_PAR_RESULTS
    rm -f $A9090_PAR_RESULTS
    rm -f $BLOCK_TO_A9090
    rm -f $JOIN_BLOCK
    rm -f $JOINS
    rm -f $JOIN_WHERE_LINE_NUMBER
    rm -f $JOIN_FROM_LINE_NUMBER
    rm -f $FINAL_JOIN_BLOCK
    rm -f $BLOCK_TO_WHERE
    rm -f $JOIN_LINES
    rm -f $HI_AND_LO_ELEMENTS
    rm -f $DUP_DYN_SCR_ELEMENTS
    rm -f $DYN_SCR_ELEMENTS
}


function functionality 
{
    while read num funct rest 
    do
       NOSW=${funct%-SW}
       FUNC=${NOSW#WV-PERFORM-*}
       print "\t\t$FUNC"
    done
}

function ascdesc
{
      cat $ASC_DESC_RESULTS | while read line > /dev/null
          do
            adresults=`echo $line |cut -f1 -d":"`
            adkey=$(($adresults - 1))
            head -$adkey $IOMODDIR/$NAME.pco > $AD_KEYS_TEMP
            tail -1 $AD_KEYS_TEMP | cut -f2 -d"," >> $AD_KEYS_FILE
          done

      sort -u $AD_KEYS_FILE > $AD_KEYS_FINAL
}

function ascdesccus
{
      cat $CUSTOM_CODE_RESULTS | while read line > /dev/null
          do
            adresults=`echo $line | cut -f1 -d":"`
            adkey=$(($adresults - 1))
            head -$adkey $IOMODCBDIR/${NAME}1 > $AD_KEYS_TEMP
            tail -1 $AD_KEYS_TEMP | cut -f2 -d"," >> $AD_KEYS_FILE
          done

      sort -u $AD_KEYS_FILE > $AD_KEYS_FINAL
}   
 

function custom
{
       grep ${NAME}[0-9] customresult > /dev/null 
       if [[ $? = 0 ]]; then
          print "\tCustom Code: Y" 
       else
          print "\tCustom Code: N"
       fi
}

# 1.Check if have correct number of parameters; 
# 2.Check for valid project name;
# 3.Check for valid table name (check correct length, and if in dclgen directory
#   for specified client)
    let tablelength=${#TABLE}
    if [[ $# != 1 ]]; then
       print "Usage  : iosearch.ksh tablename"
       print "Example: iosearch.ksh CU02TB01"
       exit 1
    elif [[ ! -a $TBLDIR/$TABLE || $tablelength != $correctlength ]]; then
       print "\nInvalid table name."
       print "\n"
       exit 1
    fi

# choose which repository to perform sql table join statement against (searches through project's .ini file)

     grep "ClientRepository" $PVCS_DIR/$PROJECT.ini |cut -f2 -d"|" > repository
     cat repository| while read line > /dev/null
     do
     REPOS=$line
     done


#parse table name into numbers that IO mod uses (e.g. CU01TB01 --> 0101)
    firstnum=`echo $TABLE |cut -c3-4`
    secondnum=`echo $TABLE |cut -c7-8`

#tests if user has permissions for directory (to create and remove temporary files used in script)
    if [[ ! -w $CURRENTDIR ]]; then
       print "You do not have the correct permissions on this directory to be able to use this script.\n"
       print "Try to cd .. (back one directory) and 'chmod 777' on your current directory.\n"
       exit 1
    fi

#find corresponding IO mods and redirect into file called ioresult 

    ls $IOMODDIR/C?${firstnum}${secondnum}* |cut -f9 -d"/"  > ioresult

    rm -f $TEMP_SQL_FILE

    grep 'C*' ioresult | main
