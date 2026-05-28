#!/bin/ksh
#set -x
#******************************************************************************
# (c) COPYRIGHT 1996 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# <CSW_Report.ksh>
#
# Arguments: none
#
# Creates the Client / Window / Service Report ( NT format )
# Determins the relationships from the information contained within the CSR map.
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date      Action
# Marc Danneels   05/16/97  Original code.
#
#******************************************************************************
USAGE="\nUsage: `basename $0` <input file type>\n"

if [[ $# < 0 ]]
then
  echo "\nInvalid number of arguments."
  echo $USAGE
  exit 1
fi

LOCAL_DIR=`pwd`
# Create tmp file for grep purposes
touch $LOCAL_DIR/tmp

# Cleanup old output files
if [[ -s $LOCAL_DIR/CWS_Report.txt ]]
then
  print "Delete old report?"
  print "Selecting 'n' will append the new report to the old report."
  print "Type CNTL-C to abort."
  rm -i $LOCAL_DIR/CWS_Report.txt
fi

# Report Header
print "Client Window Service Report\n"  >> CWS_Report.txt
print "Generated from <$CLNT_APPL>\n\n" >> CWS_Report.txt

for file in $CLNT_APPL/source/dialog/*
do
  name=${file##/*/}
  cd $file
  ls *.map > /dev/null 2>&1
  if [[ $? = 0 ]]; then
    grep  "^SMH" *.map $LOCAL_DIR/tmp | awk '{print "  " $1 " " $6}' > $LOCAL_DIR/$$
	  print "Dialog: $name" >> $LOCAL_DIR/CWS_Report.txt
    cat $LOCAL_DIR/$$ >> $LOCAL_DIR/CWS_Report.txt
  fi
done

for file in $CLNT_APPL/source/comwin/*
do
  name=${file##/*/}
  cd $file
  ls *.map > /dev/null 2>&1
  if [[ $? = 0 ]]; then
    grep  "^SMH" *.map $LOCAL_DIR/tmp | awk '{print "  " $1 " " $6}' > $LOCAL_DIR/$$
	  print "CommonWindow: $name" >> $LOCAL_DIR/CWS_Report.txt
    cat $LOCAL_DIR/$$ >> $LOCAL_DIR/CWS_Report.txt
  fi
done

# Cleanup
cd $LOCAL_DIR

sed 's/.map:SMH//g' CWS_Report.txt > $$

# Remove the last character from the window and service

awk '/^ /{var1=substr($1,1,length($1)-1);var2=substr($2,1,length($2)-1);print "   " var1 "   " var2;next;}{print $0}' $$ > CWS_Report.txt

format_NT.ksh CWS_Report.txt

rm $$ tmp CWS_Report.txt.old
