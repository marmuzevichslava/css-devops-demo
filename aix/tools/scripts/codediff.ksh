#!/bin/ksh
#******************************************************************************
#
#   Tool Name:    codediff.ksh  
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
USAGE="\nUsage: codediff.ksh cis00001.dat"      

if [[ $# < 1 ]]
then
  echo "\nInvalid number of arguments."
  echo $USAGE
  echo
  exit 1
fi
#print $1, $host
#print "What is the CIS number of the codes table, i.e. <CIS00001>"
#  read type
#  typeset -1 type
 diff -b ${1} $CLNT_APPL/source/codestbl/${1} > diff_file
	print
	print "Please see diff_file"
	print;
