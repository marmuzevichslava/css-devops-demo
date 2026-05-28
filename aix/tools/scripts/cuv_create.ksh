#!/bin/ksh
# set -x
#******************************************************************************
# (c) COPYRIGHT 1996 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# <cuv_create.ksh>
#
# Arguments: CUV Copybook
#
# Calls the cuv_create.awk file which creates a C header file 
# from a CUV copybook.
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date      Action
# Marc Danneels   06/04/96  Original code.
#
#******************************************************************************
USAGE="\nUsage: `basename $0` <CUV Copybook>\n\nCreates a cuv.h file in the current directory.\n"
C_NAME=`echo $1|tr [:upper:] [:lower:]`

if [[ $# < 1 ]]
then
  echo "\nInvalid number of arguments."
  echo $USAGE
  exit 1
fi

awk -f $BASE_TOOL/common/host/awk/cuv_create.awk $1 > $C_NAME.h
