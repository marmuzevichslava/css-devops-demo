#!/bin/ksh
#******************************************************************************
# (c) COPYRIGHT 1996 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# <code_code.ksh>
#
# Arguments: file continaing all the CIS tables
#
# CTM Population Script
#
# Note:  You must be fcp logged into 226 to run this script do to
#        queries against the repository.
#        
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date      Action
# Marc Danneels   04/07/97  Original code.
# Ted Vreeland    04/25/97  Repository queries now go against AS88226.
#
#******************************************************************************



#******************************************************************************
##                              monitor_progress                             ##
#******************************************************************************
function monitor_progress {

    let CTR="CTR + 1"
    print "Processing record $CTR of $TOTAL_RECORDS" >> progress.out
    print "Processing record $CTR of $TOTAL_RECORDS"
    print "Current table being processed: <$TABLE>"  >> progress.out
    print "Current table being processed: <$TABLE>"  
}
          


#******************************************************************************
##                              GetDataElement                               ##
#******************************************************************************
function GetDataElement {

    echo "spool getde.out;\nset feedback off;\nset heading off;" > da.sql
    echo "select c.dte_dbs_name from dectable a, wdd0d020 b, dedtelem c " >> da.sql
    echo "where  a.entity_id like '"$TABLE%"' and b.parent_internal_id = a.entity_internal_id" >> da.sql
    echo " and c.entity_internal_id = b.child_internal_id;" >> da.sql
    echo "exit;" >> da.sql
    sqlplus c1_t3/c1_t3 @da.sql

}


#******************************************************************************
##                              GetCodesTableList                            ##
#******************************************************************************
function GetCodesTableList {

    echo "spool getctlist.out;\nset feedback off;\nset heading off;\n" > run_sql.sql
    echo "select a.entity_id from dectable a, wdd0d020 b, dedtelem c " >> run_sql.sql
    echo " where c.dte_dbs_name = '"$DATA_ELM"'" >> run_sql.sql
    echo "   and c.entity_internal_id = b.child_internal_id" >> run_sql.sql
    echo "   and b.parent_internal_id = a.entity_internal_id" >> run_sql.sql
    echo "   and a.entity_id like 'CIS%';" >> run_sql.sql
    echo "exit;" >> run_sql.sql
    sqlplus c1_t3/c1_t3 @run_sql.sql
}



#******************************************************************************
##                                   Main                                    ##
#******************************************************************************
if [[ $# < 1 ]]; then 
    echo "\nInvalid number of arguments."
    echo $USAGE
    exit 1   
fi

INPUT_FILE=$1
TOTAL_RECORDS=`wc -l $1`
let CTR=0

#Loop down the file and perform a query for every codestable
#listed within it.
for TABLE in $(<$INPUT_FILE); do
    monitor_progress

    # Get the data element associated with this codes table. 
    GetDataElement

    # Extract the data element DB name. 
    # Need to check zero or more than one row being returned
    # Only one row should be returned ?????
    grep -v "^$" getde.out | grep -v entity_id > result.out

    if [[ -s result.out ]]; then
        let CNT="$(wc -l < result.out)"
        print "Found <$CNT> returns from the remote query"
    fi

    # Create Keylist for current table

    grep $TABLE TblCodes.lst > KEYLIST1.tmp
    awk '{print $2 }' KEYLIST1.tmp > KEYLIST1.lst

    #Loop through all the returned data elements - although
    #there should only be one.  We still need to resolve why
    #some codestables return more than one data element.
    for DATA_ELM in $(<result.out); do
        print "Found Data Element <$DATA_ELM> for table <$TABLE>"

        #Do a remote query searching for any Codes Tables
        #within the repository that also use this data element.
        GetCodesTableList

        #Strip out the current table name from the returned
        #list of codes tables.
        grep -v "$TABLE" getctlist.out > getctlist.tmp
        
        #Use only the first 8 characters of the entity id.
        cut -c 1-8 getctlist.tmp > getctlist.lst
 
        #For each of the codestables returned from the
        #previous query, grep against the TblCodes.lst file
        #for any rows that use that codestable.  Output this
        #list to a file.
        for CUR_TBL in $(<getctlist.lst); do
            
            #Do a grep on the CodesTable.lst file (two column file
            #created from within access listing out all the TableNames
            #and Keys ordered by TableName.) searching for the current
            #table.
            grep $CUR_TBL TblCodes.lst > KEYLIST2.tmp
            awk '{print $2}' KEYLIST2.tmp > KEYLIST2.lst

            #For every key value in this second list do a grep on the first
            #key list to see if it is within that list.  If it is then
            #we know that this table, key combination is used within another
            #table and key.
            for KEY_VAL in $(<KEYLIST2.lst); do
                grep $KEY_VAL KEYLIST1.lst 
		    
                #If the return code is zero, then the grep found something.
                #Ouput a record to a final file.
                if [[ $? = 0 ]]; then
                    print "$TABLE,$KEY_VAL" >> codecode.csv
                fi
            done 

            #clean up the two key lists before performing the next loop.
           # rm KEYLIST1.lst KEYLIST2.lst

        done

        #clean up the codes table query output before doing it again.
        #rm getctlist.out getctlist.lst

    done

    #clean up the data element query output before doing it again.
    #rm getde.out

done
