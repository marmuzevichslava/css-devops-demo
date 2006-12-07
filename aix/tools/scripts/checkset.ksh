#!/bin/ksh
# This program will pvcslock and checkin all copybooks 
# for the entered i/o module  
# the_list contains the list of files to be locked/checkin
# error.file will list the errors of any files not locked/checkin
# this will do all A,h,l,w,s,1-9
# it is NOT case sensitive
#
# AUTHOR: MICHAEL TIPALDO
# VERSION: 6.0
# DATE CREATED: 12/7/95
# DATE UPDATED:  6/24/97
# DATE IPDATED: 2/23/99
# Modified to take advantage of new projects  CCasas


USAGE="usage: checkset.ksh"
exec 2>error.list		# write to file path\error.list
rm *M


clear
print ''
print -n 'Enter the I/O Module Name: '
read book
typeset -u book

# This section of code rejects the .pco if it contains a double period
# and terminates the execution of the script.

testval=$(grep -c '\.\.' "$book.pco")
if [[ $testval -gt 0 ]]
then
  echo "\n$book.pco contains double period.  Resolve this problem before proceeding.\n"
  echo "***********************************************************************"
  echo "LINE NUMBER"
  echo "-----------"
  grep -n '\.\.' "$book.pco"
  echo "***********************************************************************\n"
  exit 1
fi 

print ''
print -n 'Enter the comment: '
read comment


print ''
print -n 'Enter t3, or, ce, ce2, me, am, nm, ppl : '
read syst   


if [[ $syst = 't3' ]]; then
   env="base"
   elif [[ $syst = 'or' ]]; then
      env="t4_or"
   elif [[ $syst = 'ce' ]]; then
      env="t4_ce"
    elif [[ $syst = 'ce2' ]]; then
	  env="t4_ce2"
   elif [[ $syst = 'nm' ]]; then
      env="t5nm"
   elif [[ $syst = 'am' ]]; then
      env="t5am"
   elif [[ $syst = 'me' ]]; then
      env="t5me"
   elif [[ $syst = 'ppl' ]]; then
      env="t5ppl"
fi

for file in $book? 
do
    echo "Checking in copybook $file"
    pvcslock $file -t"copy book" -f "$env" -c io -l lock -y 
    checkin $file -t"copy book" -f "$env" -e build -c io -d "$comment" -y 

done

for file2 in $book.pco
do
        echo "Checking in module $file2"
# the " in $comment keep it a string,else the second word becomes a file name
	pvcslock $file2 -t"io module" -f "$env" -l lock -y
	checkin $file2 -t"io module" -f "$env" -e build -d "$comment" -y 
done
