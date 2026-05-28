#!/bin/ksh 
###########################################################################################
# ScriptName :  baecount.ksh
# Description:  This script counts the number of rows found in the tables in the detail table
#               of the BAE.
# Usage      :  baecount.ksh <time stamp>
#               options:
#                   time stamp - 26 character time stamp to delete by.
#
# Date       Programmer         Action
# --------------------------------------------
# 04/03/98   Jeffrey Meissner     Original Code.
# 03/12/99   Tanya McEwen         Added options to sort by timestamp or account,      
#                                 show summary or details
# 06/02/99   Tanya McEwen	  Added columns for source database and description
###########################################################################################

function prompt_usage
{
    print "USAGE: baecount.ksh"
}

if [[ -z $1 ]]; then
    printf "\nBAE buffer table for project $PROJECT:\n"
    PS3='Select view option:  '
	select show in \
	    'Show summary (sorted by account)' \
	    'Show summary (sorted by timestamp)' \
	    'Show details (one account w/ breakdown by table)' \
	    'Show details (all accounts & total rows for each) ** BE PATIENT'
    do
       case $REPLY in
	  1) SORT=dsp_acct_id;;
	  2) SORT=arch_oth_ts_dt_tm;;
	  3) SORT=one_account;;
	  4) SORT=all_accounts;;
       esac

       if [[ -n $SORT ]]; then
	  break
       fi 
    done
fi

SEL_SQL_FILE=sqlplusfile.sql
echo "SET FEEDBACK ON " > $SEL_SQL_FILE
echo "SET PAGESIZE 999 " >> $SEL_SQL_FILE
echo "column dsp_acct_id heading 'ACCOUNT #' format A14" >> $SEL_SQL_FILE
echo "column arch_oth_ts_dt_tm heading 'TIMESTAMP' format A28" >> $SEL_SQL_FILE
echo "column bat_tbl_id heading 'TABLE ID' format A14" >> $SEL_SQL_FILE
echo "column txn_owner_id heading 'SRC DATABASE' format A12 truncated" >> $SEL_SQL_FILE
echo "column ld_desc_tx heading 'DESCRIPTION' format A22 truncated" >> $SEL_SQL_FILE

if [[ $REPLY = 1 ]]; then
   echo "select dsp_acct_id, arch_oth_ts_dt_tm, txn_owner_id, ld_desc_tx 
         from extract_ld_hdr order by dsp_acct_id;" >> $SEL_SQL_FILE
   echo "exit" | sqlplus -s acct_xtract/acct_xtract @$SEL_SQL_FILE

elif [[ $REPLY = 2 ]]; then
   echo "select arch_oth_ts_dt_tm, dsp_acct_id, txn_owner_id, ld_desc_tx 
         from extract_ld_hdr order by arch_oth_ts_dt_tm;" >> $SEL_SQL_FILE 
   echo "exit" | sqlplus -s acct_xtract/acct_xtract @$SEL_SQL_FILE

elif [[ $REPLY = 3 ]]; then
   echo "column dsp_acct_id heading 'ACCOUNT #' format A14" >> $SEL_SQL_FILE
   echo "column arch_oth_ts_dt_tm heading 'TIMESTAMP' format A28" >> $SEL_SQL_FILE
   echo "select dsp_acct_id, arch_oth_ts_dt_tm, txn_owner_id, ld_desc_tx 
         from extract_ld_hdr order by dsp_acct_id;" >> $SEL_SQL_FILE 
   echo "exit" | sqlplus -s acct_xtract/acct_xtract @$SEL_SQL_FILE
   print "Choose timestamp value to show account details: \c"
   read baetimestamp

   echo "SET FEEDBACK OFF " > $SEL_SQL_FILE
   echo "SET PAGESIZE 999 " >> $SEL_SQL_FILE
   echo "select bat_tbl_id TABLE_ID, count(*) TOTAL_ROWS from extract_ld_dtl where arch_oth_ts_dt_tm = 
          '$baetimestamp' group by bat_tbl_id order by bat_tbl_id;" >> $SEL_SQL_FILE
   echo "exit" | sqlplus -s acct_xtract/acct_xtract @$SEL_SQL_FILE

elif [[ $REPLY = 4 ]]; then
   echo "SET FEEDBACK OFF " >> $SEL_SQL_FILE
   echo "select dsp_acct_id, arch_oth_ts_dt_tm, count(*) TOTAL_ROWS from extract_ld_dtl 
         group by arch_oth_ts_dt_tm, dsp_acct_id order by dsp_acct_id;" >> $SEL_SQL_FILE
   echo "exit" | sqlplus -s acct_xtract/acct_xtract @$SEL_SQL_FILE
fi

rm $SEL_SQL_FILE
