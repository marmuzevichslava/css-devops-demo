#!/bin/ksh 
###########################################################################################
# ScriptName :  baecopy.ksh
# Description:  This scirpt copies a bae from the header and detail based on a timestamp.
# Usage      :  baecopy.ksh <time stamp> 
#               options:
#                   time stamp - 26 character time stamp to delete by.
#
# Date       Programmer         Action
# --------------------------------------------
# 04/27/98   Scott Shepherd     Original Code.
###########################################################################################
function prompt_usage
{
    print "USAGE: baecopy.ksh <time stamp>"
    print "\t time stamp - 26 character time stamp to delete"
}

if [[ $# != 1 ]]; then
    prompt_usage
    exit 1
fi

SEL_SQL_FILE=sqlplusfile.sql

print "copy from acct_xtract/acct_xtract@cl2pv to acct_xtract/acct_xtract@swt5o8 \c" > $SEL_SQL_FILE
print "insert extract_ld_hdr(arch_oth_ts_dt_tm, dsp_acct_id, ld_desc_tx, txn_owner_id, txn_dat_mnt_id) \c" >> $SEL_SQL_FILE
print "using select * from extract_ld_hdr where arch_oth_ts_dt_tm = $1;" >> $SEL_SQL_FILE
echo "exit" | sqlplus -s acct_xtract/acct_xtract @$SEL_SQL_FILE

print "copy from acct_xtract/acct_xtract@cl2pv to acct_xtract/acct_xtract@swt5o8 \c" > $SEL_SQL_FILE
print "insert extract_ld_dtl(arch_oth_ts_dt_tm, dsp_acct_id, bat_rec_nb, bat_tbl_id, bat_tbl_dat_tx, tx_alvp_view, txn_dat_mnt_id) \c" >> $SEL_SQL_FILE
print "using select * from extract_ld_dtl where arch_oth_ts_dt_tm = $1;" >> $SEL_SQL_FILE
echo "exit" | sqlplus -s acct_xtract/acct_xtract @$SEL_SQL_FILE

rm $SEL_SQL_FILE

