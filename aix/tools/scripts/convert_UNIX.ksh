#!/bin/ksh
# set -x
#******************************************************************************
# (c) COPYRIGHT 1997 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# <convert_UNIX.ksh>
#
# Arguments: COBOL file
#
# Strips out everything beyond col 72 and blanks out columns 1-6
#
# Andersen Consulting - SolutionWorks
#
# Coder            Date      Action
# Marc J. Danneels 04/20/98  Original code.
#
#******************************************************************************
USAGE="\nUsage: `basename $0` <MVS formated COBOL file>\n"

if [[ $# < 1 ]]
then
  echo "\nInvalid number of arguments."
  echo $USAGE
  exit 1
fi

cut -c 1-72 $1 > $$
sed s/"^......"// $$ > $1.new
