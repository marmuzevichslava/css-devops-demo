#!/bin/ksh
# set -x
#******************************************************************************
# (c) COPYRIGHT 1996 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# <cutstamp.ksh>
#
# Arguments: IOMOD
#
# Calls the azio001p.awk & cumco17.awk files.
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date      Action
# Marc Danneels   10/2/96   Original code.
#
#******************************************************************************
USAGE="\nUsage: `basename $0` <IOMOD>\n"
AWKDIR="$BASE_TOOL/common/host/awk"

if [[ $# < 1 ]]
then
  echo "\nInvalid number of arguments."
  echo $USAGE
  exit 1
fi

awk -f $AWKDIR/azio001p.awk $1    > $1.az
awk -f $AWKDIR/cumco017.awk $1.az > $1
rm $1.az
