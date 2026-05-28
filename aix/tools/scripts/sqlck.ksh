#!/bin/ksh
#******************************************************************************
# (c) COPYRIGHT 1996 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# <sqlck.ksh>
#
# Arguments: A COBOL source file.
#
# Passes the argument to copycatch.awk
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date      Action
# Marc Danneels   01/25/96  Original code.
#
#******************************************************************************
USAGE="\nUsage: $0 <COBOL source file>\n"
AWKDIR=$BASE_TOOL/common/host/awk

if [[ $# < 1 ]]
then
  echo "\nInvalid number of arguments."
  echo $USAGE
  exit 1
fi

awk -f $AWKDIR/sqlck.awk $1

awk_return_code=$?

if [[ $awk_return_code -eq 0 ]]
then
	print "No SQL format problems found."
else
	print "$awk_return_code SQL Format problems found."
fi

exit $awk_return_code
