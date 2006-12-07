#!/bin/ksh
# set -x
#******************************************************************************
# (c) COPYRIGHT 1998 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# <pdg.ksh> (Pound Define Generator)
#
# Arguments: $1 = Copybook Type (CUV) 
#            $2 = Copybook FileName
#
# Calls the pdg.awk file which creates a C header file 
# from a CUV copybook.
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date      Action
# -----------------------------------------------------------------------------
# Shawn M. Hyde  10/14/98   Original Code
#
#******************************************************************************
#
# Note: Commented code is for beta testing purposes.
#       The commented code is replaced by code immediately following each line.
#       The commented code requires two parameters, a copybook type, and a
#       copybook filename.  The "new" code requires only a copybook filename.
#       The final version of this file should have commented code removed.
#


#USAGE="Usage: `basename $0` <CopybookType> <CopybookFileName>\n\n" 
USAGE="Usage: `basename $0` <CopybookFileName>\n\n"

#COPYBOOK_TYPE=`echo $1|tr [:lower:] [:upper:]`
#C_NAME=`echo $2|tr [:upper:] [:lower:]`
C_NAME=`echo $1|tr [:upper:] [:lower:]`

#if [[ $# -ne 2 ]]
if [[ $# -ne 1 ]]
then
  echo ""
  echo "---------------------------------------------------------------------"
  echo "Pound Define Generator (`basename $0`)"
#  echo "This program creates a C header file from CUV or MSG COBOL copybooks."
  echo "This program creates a C header file from CUV COBOL copybooks."
  echo ""
  echo $USAGE
#  echo "<CopybookType>     CUV or MSG"
  echo "<CopybookFileName> assumes local directory unless a full"
  echo "                   path to the copybook is specified"
  echo "---------------------------------------------------------------------"
  echo
  exit 1
else
#  case $COPYBOOK_TYPE in
#     CUV )
#         awk -f pdg_cuv.awk $2 > $C_NAME.h;;
#          awk -f $BASE_TOOL/common/host/awk/pdg_cuv.awk $1 > $C_NAME.h;;
#     MSG )
#          echo "Sorry, MESSAGE copybooks are not supported at this time.";;
#         awk -f $BASE_TOOL/common/host/awk/pdg_msg.awk $1 > $C_NAME.h;;
#     * )
#         echo "Sorry, $COPYBOOK_TYPE is an unrecognized copybook type.";;
#
#  esac

      awk -f $BASE_TOOL/common/host/awk/pdg_cuv.awk $1 > $C_NAME.h

  if [[ -s $C_NAME.h ]]
  then
      echo ""
      echo "$C_NAME.h created successfully."
      echo ""
  else
      echo ""
      echo "There was an error while processing.  $C_NAME.h was not created."
      echo ""
      rm -f $C_NAME.h
  fi

fi




