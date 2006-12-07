#!/bin/ksh
# set -x
#******************************************************************************
# (c) COPYRIGHT 1996 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# <lt_module.ksh>
#
# Arguments: COBOL Module
#
# Return Codes:   0 Passed 
#                 1 Failed
#
# Calls lt_module.awk and determins if any LT-MODULE names are missing.  Produces 
# a list of called modules that are not defined.
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date         Action
# Marc Danneels   Haloween '96 Original code.
# Marc Danneels   05/19/97     Modified script so that it can be called from runmake.
#                              All exit calls were changed to return calls.
# Marc Danneels   05/21/97     Added to the exception list the following calls:
#                              CUBRS002 CUBCO002 CUBCO001 CUMBD001 WC-ASM-ENV-MODULE
# Heidi Rodriguez 06/29/00     Added CUMBD002 to the exception list for arch rebuild                              
#******************************************************************************
USAGE="\nUsage: `basename $0` <COBOL module>\n"
AWKDIR=/css/devtools/common/host/awk

if [[ $# < 1 ]]; then
  echo "\nInvalid number of arguments."
  echo $USAGE
  return 1
fi

FILE=$1
PREFIX=${FILE%.pco}

print "Running lt_module check..."
awk -f $AWKDIR/lt_module.awk $PREFIX.lst | grep -v -e SQLBEX -e SQLADR -e DACP-CD-IO-MOD-ID -e CUBRS002 -e CUBCO002 -e CUBCO001  \-e CUMBD001 -e CUMBD002 -e WC-ASM-ENV-MODULE > $PREFIX.lt_module

if [[ -s $PREFIX.lt_module ]]; then
  print Failed lt_module check!
  print "See file $PREFIX.lt_module for calls that are not included in the LT-MODULE-NAMES section."
  return 1
fi

print Passed lt_module check!
return 0
