#!/bin/ksh
#----------------------------------------------------------------------
#
# Program ID: die.ksh
#
# Author : Mike Conner
#          Andersen Consulting
#          SolutionWorks
#
# Description: This script wraps the IndexExtractor program.  The IndexExtractor program extracts a 
#              comma delimited index record from the ddl and writes it to a file passed in by this
#              script.  The script passes the IndexExtractor the output file name and an input
#              file name that is selected one at a time from a list of the latest ddl.  This list 
#              is created by this script as it runs.
#
# CALLS: IndexExtractor, sed 
#
# Input:  ddl list file name, Index Record file name, Error file name
#
# Output: ddl list, Index Record file, Error list.
#
# RETURNS: 0 = success; 1 = failure
#
# HISTORY:
# 06/10/98 mconner created
#
# (c) 1998 Copyright Andersen Consulting - All rights reserved. 
#THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.
#-----------------------------------------------------------------------
progID=$0
ddlListFile=ddl${PROJECT}.lst
IndexRecFile=Irec${PROJECT}.txt
ErrorFile=Ierror${PROJECT}.txt

#----------------------------------------------------------------------
#define program variables
#----------------------------------------------------------------------
SUCCESS=0
rc=0
FAIL=1

#----------------------------------------------------------------------
#FUNCTIONS
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# MAIN LOGIC
#----------------------------------------------------------------------
#rm -f tmp*

if [[ -f ${ddlListFile} ]]; then
	rm -f ${ddlListFile}
fi

if [[ -f $IndexRecFile ]]; then
	rm -f $IndexRecFile
fi

if [[ -f $ErrorFile ]]; then
	rm -f $ErrorFile 
fi

print "Table_Id,Table_name,Index_name,Column_name,Sequence,Sort,Unique" >> $IndexRecFile

find $HOST_APPL/source/ddl -type f > tmp
sed -e "/conv/d" tmp > tmp1
sort -r -t/ -o tmp2 -k 10.1,10 -k 9.1,9 tmp1
sed -e "s/\// /g" tmp2 > tmp3
uniq -f 8  tmp3 > tmp4
sed -e "s/ /\//g" tmp4 > tmp5
cp tmp5 $ddlListFile

for file in $(< $ddlListFile)
do
	IndexExtractor $file $IndexRecFile
	rc=$?
	if (( $rc != 0 )); then
		print  $file >> $ErrorFile
	fi
done

format_NT.ksh $ddlListFile
format_NT.ksh $IndexRecFile
format_NT.ksh $ErrorFile

rm -f tmp*

#----------------------------------------------------------------------
# RETURN TO SYSTEM
#----------------------------------------------------------------------
return ${SUCCESS}
