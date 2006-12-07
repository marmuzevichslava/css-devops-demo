# this program will pvcslock and checkin ALL DCLgens in the CURRENT DIR 
# error.file will list the errors of any files not  icheckin 
# ALL DCLgens will have the SAME comment
#
# AUTHOR: MICHAEL TIPALDO
# VERSION: 5.0 
# DATE CREATED: 12/18/95
# DATE CHANGED:  6/09/97  CCasas to take advatage of new environment
# DATE CHANGED: 11/20/97  RHUYNH new t5 environment
# DATE UPDATED: 12/17/97  MBLACK add common environment to checkin
# DATE UPDATED: 04/30/99  SZOLMAN added t4ce2 environment to checkin

USAGE="usage: checkd.ksh"
exec 2> error.list

clear
print ''
print -n 'Enter the comment: '
read comment

print ''
print -n 'Enter me, nm, am, ppl, cmn, ce, ce2, or, t3 : '
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
   elif [[ $syst = 'ce' ]]; then
      env="t4_ce"   
   elif [[ $syst = 'ce2' ]]; then
      env="t4_ce2"
   elif [[ $syst = 'or' ]]; then
      env="t4_or"   
   elif [[ $syst = 't3' ]]; then
      env="base"   

fi

for file in C???TB?? 
do
    pvcslock $file -t"copy book" -f "$env" -c table -l lock -y 
    checkin $file -t"copy book" -f "$env" -e build -c table -d "$comment"  -y

done
