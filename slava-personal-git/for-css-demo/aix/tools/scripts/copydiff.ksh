#!/bin/ksh
#******************************************************************************
#
#   Tool Name:    copydiff.ksh  
#   Version:      2.0
#   Description:  Diffs the copybook(s) in build with the one(s) in the    
#                 current directory and produces a diff_file.
#
#   Andersen Consulting - SolutionWorks
# 
#   Coder:          Date:
#   Khim Theng      10/21/96   
#   Chris Lawson    06/01/98
#******************************************************************************
USAGE="\nUsage: copydiff.ksh <CUCL001I> "     

if [[ $# < 1 ]]
then
  echo "\nInvalid number of arguments."
  echo $USAGE
  echo
  exit 1
fi
clear
  print "Is this a Cobol or C copybook (cobol or c):"
	read type
	typeset -l type
case $type in
  "cobol")
  print "What type of copybook is it? (lib,nongen,cuv,io,table):"
	read copytype
	typeset -l copytype 

	diff -b ${1} $HOST_APPL/source/copy/$copytype/${1} > diff_file
	print
	print "Please see diff_file"
	print;;
   "c")
       diff -b ${1} $CLNT_APPL/source/include/${1} > diff_file
       print
       print "Please see diff_file"
       print;;
esac

