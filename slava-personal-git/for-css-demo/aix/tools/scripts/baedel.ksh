#!/bin/ksh 
###########################################################################################
# ScriptName :  baedel.ksh
# Description:  This script cleans up a single extract from the buffer and detail tables
#               of the BAE.
# Usage      :  baedel.ksh <time stamp>
#               options:
#                   time stamp - 26 character time stamp to delete by.
#
# Date       Programmer         Action
# --------------------------------------------
# 04/03/98   Scott Shepherd     Original Code.
# 03/12/99   Tanya McEwen       Added options to delete by timestamp or account number.
# 06/02/99   Tanya McEwen       Added source database and description columns
###########################################################################################

function prompt_usage
{
    print "USAGE: baedel.ksh"
}

if [[ -z $1 ]]; then
    printf "\nBAE buffer table for project $PROJECT:\n"
    PS3='Select delete option:  '
    select delete in \
       'Delete by account number' \
       'Delete by timestamp' 
    do
        case $REPLY in
           1) DELETE_FIELD=dsp_acct_id;;
           2) DELETE_FIELD=arch_oth_ts_dt_tm;;
        esac

        if [[ -n $DELETE_FIELD ]]; then
            break
	fi
    done
fi


if [[ $REPLY = 1 ]]; then
   sqlplus -s acct_xtract/acct_xtract << END
   set pagesize 999
   column dsp_acct_id heading 'ACCOUNT'  format A12
   column arch_oth_ts_dt_tm heading 'BAE TIMESTAMP' format A28
   column txn_owner_id heading 'SRC DATABASE' format A12 truncated
   column ld_desc_tx heading 'DESCRIPTION' format A22 truncated
   select dsp_acct_id, arch_oth_ts_dt_tm, txn_owner_id, ld_desc_tx 
   from extract_ld_hdr
   order by dsp_acct_id;
   exit;
END
   printf "** BE PATIENT...accounts take longer to delete **\n"
   print "Choose account to be deleted: \c"
   read delvalue 

elif [[ $REPLY = 2 ]]; then
   sqlplus -s acct_xtract/acct_xtract << END
   set pagesize 999
   column dsp_acct_id heading 'ACCOUNT'  format A12
   column arch_oth_ts_dt_tm heading 'BAE TIMESTAMP' format A28
   column txn_owner_id heading 'SRC DATABASE' format A12 truncated
   column ld_desc_tx heading 'DESCRIPTION' format A22 truncated
   select arch_oth_ts_dt_tm, dsp_acct_id, txn_owner_id, ld_desc_tx 
   from extract_ld_hdr
   order by arch_oth_ts_dt_tm;
   exit;
END
   print "Choose timestamp to be deleted: \c"
   read delvalue 
fi

print "\nNumber of rows to be deleted from EXTRACT_LD_HDR:  "
sqlplus -s acct_xtract/acct_xtract << END
   set heading off
   set pagesize 0
   select count(*) from extract_ld_hdr where $DELETE_FIELD = '$delvalue';
   exit;
END

print "Number of rows to be deleted from EXTRACT_LD_DTL:  "
sqlplus -s acct_xtract/acct_xtract << END
   set heading off
   set pagesize 0
   select count(*) from extract_ld_dtl where $DELETE_FIELD = '$delvalue';
   exit;
END

print "Do you want to continue (y/n): \c"
read response

if [[ $response = y ]]; then

    SEL_SQL_FILE=sqlplusfile.sql

    echo "SET FEEDBACK ON " > $SEL_SQL_FILE
    echo "SET HEADING OFF " >> $SEL_SQL_FILE
    echo "SET PAGESIZE 0 " >> $SEL_SQL_FILE
    echo "delete from extract_ld_hdr where $DELETE_FIELD = '$delvalue';" >> $SEL_SQL_FILE
    echo "exit" | sqlplus -s acct_xtract/acct_xtract @$SEL_SQL_FILE 

    echo "SET FEEDBACK ON " > $SEL_SQL_FILE
    echo "SET HEADING OFF " >> $SEL_SQL_FILE
    echo "SET PAGESIZE 0 " >> $SEL_SQL_FILE
    echo "delete from extract_ld_dtl where $DELETE_FIELD = '$delvalue';" >> $SEL_SQL_FILE
    echo "exit" | sqlplus -s acct_xtract/acct_xtract @$SEL_SQL_FILE

    rm $SEL_SQL_FILE
fi
