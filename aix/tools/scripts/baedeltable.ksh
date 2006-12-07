#!/bin/ksh 
###########################################################################################
# ScriptName :  baedeltable.ksh
# Description:  This script deletes rows in the buffer table for a given    
#               timestamp and given table.
# Usage      :  baedeltable.ksh <time stamp>
#               options:
#                   time stamp - 26 character time stamp to delete by.
#
# Date       Programmer         Action
# --------------------------------------------
# 06/10/98   Jeffrey Meissner     Original Code.
# 04/23/99   Tanya McEwen         Modified to allow clients to delete one table associated
#                                 with timestamp in the BAE buffer table extract_ld_dtl.
###########################################################################################

function prompt_usage
{
    print "USAGE: baedeltable.ksh <table name> "
    print "\t table name - format should be CU99TB99"
}

SEL_SQL_FILE=file.sql

if [[ -z $1 ]]; then
    print "Table to be deleted from $PROJECT BAE buffer table: \c"
    read baetable 
else
    baetable=$1
fi

# user chooses timestamp from buffer table
sqlplus -s acct_xtract/acct_xtract <<eoi1 
SET LINESIZE 80 
ttitle 'Select a timestamp from $PROJECT BAE buffer table:' skip 2
set pagesize 100
column dsp_acct_id heading 'ACCOUNT'  format A12 
column arch_oth_ts_dt_tm heading 'BAE TIMESTAMP' format A28
column txn_owner_id heading 'SRC DATABASE' format A12 truncated 
column ld_desc_tx heading 'DESCRIPTION' format A22 truncated 
select dsp_acct_id, arch_oth_ts_dt_tm, txn_owner_id, ld_desc_tx from extract_ld_hdr order by dsp_acct_id;
exit;
eoi1

print "Enter Timestamp Value: \c"
read baetimestamp

if [[ -z $baetimestamp ]]; then 
    print "ERROR: No timestamp entered"
elif [[ -z $baetable ]]; then
    print "ERROR:  No table ID entered."
else 
    sqlplus -s acct_xtract/acct_xtract <<eoi2 
    set feedback on
    set heading off
    set pagesize 0
    delete from extract_ld_dtl where arch_oth_ts_dt_tm = '$baetimestamp' and bat_tbl_id = '$baetable';
    update extract_ld_hdr set ld_desc_tx = '*Rows deleted `date +%x`' where arch_oth_ts_dt_tm = '$baetimestamp';
    commit;
    exit;
eoi2
fi
