#!/bin/ksh  
#******************************************************************************
# (c) COPYRIGHT 1996 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# <search_static.ksh>
#
# Arguments: file continaing all the CIS tables
#
# CTM Population Script
#
# Note:  You must be fcp logged into 225 to run this script.  
#        The remsh call to the 226 requires this.
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date      Action
# Marc Danneels   04/07/97  Original code.
# Ted Vreeland    04/25/97  Repository queries now go against AS88226.
#
#******************************************************************************
#USAGE="\nUsage: `basename $0` <codes table input file>\n"
 

#******************************************************************************
# function: static_table_search
# Determine if a column on a static table contains a CIS code value
#******************************************************************************
function static_table_search {
    print "Running static_table_search query"
    for STATTBL in $(<table.lst); do
        grep "$STATTBL$" static.tbls
        if [[ $? = 0 ]]; then
            print "Found static table $STATTBL"
            for CODE in $(<CODESVALUES.lst); do  
                echo "select 1 from C1_T4T3SIR.$STATTBL" > run_sql.sql
                echo "where $DATA_ELM = '$CODE';" >> run_sql.sql
                echo "exit;" >> run_sql.sql
                sqlplus mdanneel/mdanneel@sw25 @run_sql.sql > static.lst

                grep "no rows selected" static.lst
                if [[ $? = 1 ]]; then 
                    print "Found code <$CODE> for table <$TABLE>"
                    print "$TABLE,$CODE" >> fstatcode.csv
                    return
                fi
            done
        fi  
    done
}


#******************************************************************************
#   Monitor the progress
#******************************************************************************
function monitor_progress {

    let CTR="CTR + 1"
    print "Processing record $CTR of $TOTAL_RECORDS" >> progress.out
    print "Processing record $CTR of $TOTAL_RECORDS"
    print "Current table being processed: <$TABLE>"  >> progress.out
    print "Current table being processed: <$TABLE>"  

}


#******************************************************************************
#   Create and run the query on the 226 repository server
#******************************************************************************
function create_run_remsh {

    SQLCMD='\nspool out.dat;\nset feedback off;\nset heading off;\nselect c.dte_dbs_name from dectable a, wdd0d020 b, dedtelem c\nwhere  a.entity_id like ~'$TABLE%'~\n     and b.parent_internal_id = a.entity_internal_id\n    and b.child_ent_type = ~DEDTELEM~\n     and c.entity_internal_id = b.child_internal_id;\nexit;'

  #  TEMP2=$TEMP1'select c.dte_dbs_name from dectable a, wdd0d020 b, dedtelem c\n'
  #  TEMP3=$TEMP2'where  a.entity_id like \"'$TABLE%'\"\n     and b.parent_internal_id = a.entity_internal_id\n'
  #  TEMP4=$TEMP3'    and b.child_ent_type = \"DEDTELEM\"\n'
  #  SQLCMD=$TEMP4'     and c.entity_internal_id = b.child_internal_id;\nexit;"'

# This is a bastardized way of doing this.  The fcp password should also not be hard coded in the script.  But it works ...
    echo $SQLCMD > tmp.sql
    sed s/~/\'/g tmp.sql > data.sql
    ftp -v -n <<EOF
    open 170.248.88.226
    user fcp fork47
    cd sql
    binary
    put data.sql
    bye
EOF

    CMD='. ./.profile.synchro > nul;cd sql;rm out.dat;sqlplus -s c1_t3/c1_t3 @data.sql'
    print $CMD > remote.call
    remsh AS88226 $CMD > remsh.out
    print "Remote call found:"
    cat remsh.out
}



#******************************************************************************
#   Create and run the query to search for columns in the Oracle dba_tab_col column
#******************************************************************************
function create_run_dba_tab_col {

        echo "set feedback off;" > run_sql.sql
        echo "set head off;"    >> run_sql.sql
        echo "spool table.lst;" >> run_sql.sql

        echo "select table_name from dba_tab_columns" >> run_sql.sql
        echo "where owner = 'C1_T4T3SIR' and column_name = '$DATA_ELM';" >> run_sql.sql
        echo "exit;" >> run_sql.sql

        sqlplus mdanneel/mdanneel@sw25 @run_sql.sql 
}

#******************************************************************************
#                              Main processing begins                         #
#******************************************************************************
# Delete all output files
#rm *out

if [[ $# < 1 ]]; then
    echo "\nInvalid number of arguments."
    echo $USAGE
    exit 1
fi

INPUT_FILE=$1
TOTAL_RECORDS=`wc -l $1`
let CTR=0

for TABLE in $(<$INPUT_FILE); do
    monitor_progress

    # Remotely run the query on the 224 against fndrep2 

    create_run_remsh

    # Extract the DATA_ELM from remsh.out
    # Need to check zero or more than one row being returned
    # Only one row should be returned ?????

    grep -v "^$" remsh.out | grep -v dte_dbs_name > result.out

    if [[ -s result.out ]]; then
        let CNT="$(wc -l < result.out)"
        print "Found <$CNT> returns from the remote query"
    fi

    for DATA_ELM in $(<result.out); do
        print "Found Data Element <$DATA_ELM> for table <$TABLE>"
        create_run_dba_tab_col

        grep $TABLE TblCodes.lst > CISVALUES.lst
        awk '{print $2}' CISVALUES.lst > temp.lst
        awk '{sub("^E","");print $0}' temp.lst > CODESVALUES.lst

        if [[ -s table.lst ]]; then
            static_table_search
        fi
    done
done
