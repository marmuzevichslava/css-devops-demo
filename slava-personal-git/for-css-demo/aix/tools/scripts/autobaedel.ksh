#!/bin/ksh 
###########################################################################################
# ScriptName :  autobaedel.ksh
# Description:  This script cleans up multiple extracts from the buffer and detail tables
#               of the BAE, deleting all timestamps older than 4 days.
# Usage      :  autobaedel.ksh <time stamp>
#               options:
#               time stamp - 26 character time stamp to delete by.
#
# Date       Programmer         Action
# --------------------------------------------
# 06/10/98   Jeffrey Meissner     Original Code.
# 01/28/99   Tanya McEwen         Updated profile to run so that pvcs cron job will be 
#                                 successful.  Changed parameter passed in to PROJECT.
# 03/31/99   Tanya McEwen         Added dates throughout the month
# 07/29/99   Tanya McEwen         Resolve problem with using pvcs profile
# 07/30/99   Tanya McEwen         Added Oracle date functions to resolve problem with
#                                 end-of-month processing (BAE issue 61639) 
# 07/27/06  Suresh Pellakur       migrate to AIX server; Oracle parms changed
###########################################################################################
PROJECT=$1

# According to Ed Deutscher, pvcs profiles still have Oracle 7 because Foundation Repositories have not been upgraded
# try using profile and then specifying Oracle 8 path when executing sqlplus statements

export  ORACLE_SID=CNDEV01.NA.NGRID.NET
export ORACLE_HOME=/4309.2.0
export TNS_ADMIN=/4309.2.0/network/admin


function prompt_usage
{
    print "USAGE: autobaedel.ksh <project>"
}

SEL_SQL_FILE=file.sql
SQL_EXEC=date.sql
SQL_FILE=date.lst

echo ""
echo "** running...autobaedel.ksh script for $ORACLE_SID"
echo ""

# use Oracle date functions to calculate 3 days less than current date
echo "set feedback off" > $SQL_EXEC
echo "set line 26" >> $SQL_EXEC
echo "set space 1" >> $SQL_EXEC
echo "set newp 0" >> $SQL_EXEC
echo "set flush off" >> $SQL_EXEC
echo "set term on" >> $SQL_EXEC
echo "set pagesize 0" >> $SQL_EXEC
echo "set head off" >> $SQL_EXEC
echo "select TO_CHAR(SysDate - 3, 'YYYY-MM-DD') from Dual;" >> $SQL_EXEC 
echo "exit" | sqlplus -s acct_xtract/acct_xtract@$ORACLE_SID @$SQL_EXEC > $SQL_FILE 

# get calculated date from output file
calcdate=$(< $SQL_FILE )
echo "calcdate = " $calcdate

# spool timestamps from buffer header table    
echo "SET FEEDBACK OFF " > $SEL_SQL_FILE
echo "SET HEADING OFF " >> $SEL_SQL_FILE
echo "SET PAGESIZE 0 " >> $SEL_SQL_FILE
echo "spool ceedel.dat" >> $SEL_SQL_FILE
echo "select arch_oth_ts_dt_tm from extract_ld_hdr where arch_oth_ts_dt_tm < '$calcdate';" >> $SEL_SQL_FILE
echo "exit" >> $SEL_SQL_FILE
sqlplus -s acct_xtract/acct_xtract@$ORACLE_SID @$SEL_SQL_FILE 

# delete rows from buffer header table
echo "SET FEEDBACK ON " > $SEL_SQL_FILE
echo "SET HEADING OFF " >> $SEL_SQL_FILE
echo "SET PAGESIZE 0 " >> $SEL_SQL_FILE
echo "delete from extract_ld_hdr where arch_oth_ts_dt_tm < '$calcdate';" >> $SEL_SQL_FILE
echo "commit;" >> $SEL_SQL_FILE
echo "exit" >> $SEL_SQL_FILE
 sqlplus -s acct_xtract/acct_xtract@$ORACLE_SID @$SEL_SQL_FILE 

# delete rows from buffer detail table
echo "SET FEEDBACK ON " > $SEL_SQL_FILE
echo "SET HEADING OFF " >> $SEL_SQL_FILE
echo "SET PAGESIZE 0 " >> $SEL_SQL_FILE
for timestamp in $(<ceedel.dat)
do
   echo "delete from extract_ld_dtl where arch_oth_ts_dt_tm = '$timestamp';" >> $SEL_SQL_FILE
   echo "commit;" >> $SEL_SQL_FILE
done
echo "exit" >> $SEL_SQL_FILE
sqlplus acct_xtract/acct_xtract@$ORACLE_SID @$SEL_SQL_FILE

rm $SEL_SQL_FILE
rm $SQL_FILE
rm $SQL_EXEC
rm ceedel.dat
