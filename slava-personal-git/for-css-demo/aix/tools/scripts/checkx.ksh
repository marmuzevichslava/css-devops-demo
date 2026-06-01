# this program will pvcslock and checkin ALL T-maps in the CURRENT dir
# error.file will list the errors of any files not Locked/checkin 
#
# AUTHOR: MICHAEL TIPALDO
# VERSION: 5.0
# DATE CREATED: 12/ 7/95
# DATE CHANGED:  2/21/96
# DATE UPDATED: 12/17/97 BY MBLACK
# DATE UPDATED: 07/21/98 CCASAS ADDED T3 AND T4
# DATE UPDATED: 06/23/99 ADDED T4CE2 AS PROJECT   SZOLMAN

USAGE="usage: checkx.ksh"
exec 2>error.list		# write stderror to error.list

clear
print ''
print -n 'Enter the comment: '
read comment

print ''
print -n 'Enter me, nm, am, ppl, cmn, t3, ce, ce2, or: '
read syst   


if [[ $syst = 'me' ]]; then
   env="t5me"
   elif [[ $syst = 'nm' ]]; then
      env="t5nm"
   elif [[ $syst = 'am' ]]; then
      env="t5am"
   elif [[ $syst = 'ppl' ]]; then
      env="t5ppl"
   elif [[ $syst = 'cmn' ]]; then
      env="t5common"
   elif [[ $syst = 't3' ]]; then
      env="base"     
   elif [[ $syst = 'ce' ]]; then
      env="t4_ce"    
   elif [[ $syst = 'ce2' ]]; then
      env="t4_ce2"
   elif [[ $syst = 'or' ]]; then
      env="t4_or"    


fi

for file in c???????.xlt
do
   pvcslock $file -t"translation map"  -f "$env" -l lock -y 
   checkin $file -t"translation map"  -e build -f "$env" -d "$comment" -y

done
