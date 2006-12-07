#!/bin/ksh -p
# run_cob.ksh # 2.0 # CHANGED [run_cbl.ksh] # HP-UX 10.10 # OCT 1997
#******************************************************************************
#
#   Tool Name: run_cob.ksh
#
#   Description:  Processes all COBOL copybooks from the UNIX home directory.  
#                 It truncates the .CPY extension and moves the copybooks to 
#                 the cblbooks directory for migration.
#
#   Andersen Consulting - SolutionWorks
# 
#   Coder:          Date	Action
#   Bernard Lim     09/27/95    Original code.
#   Plamen Nikitov  10/07/97    Changes.
#
#******************************************************************************

pn="cbl"
tmp="$pn.$$.tmp"  # work temporary file
integer rc=0      # return code
integer ec=0      # code of execution

integer tot=0     # total number of processed CBs
integer skp=0     # number of skipped  CBs
integer ngn=0     # number of NON-GEN  CBs
integer lib=0     # number of LIB      CBs
integer nlib=0    # number of NEW_LIB  CBs
integer nngn=0    # number of NEW_NGEN CBs

typeset -Z3 tot
typeset -u  newname

for file in C*
do
#######################################################################
# LOOP THROUGH ALL RELEVANT COPYBOOKS -- *.cpy OR *.CPY
#######################################################################

pathname=${file%/*}
filename=${file##*/}
newname=${filename%.*}
newfile=${pathname}/${newname}
let tot=tot+1

  note=""
/css/devtools/common/host/scripts/l88formio.ksh $newname > ${newname}.tmp # SOURCE CODE REFORMATTING
  ec=$?
  case $ec in
    0 )
      mv $newname.tmp $newname
      note="REFORMATED."
      ;;
    1 )
      rm $newname.tmp 2>/dev/null
      ;;
    * )
      note="REFORMATTING FAILED. RC=$ec. SKIPPED."
      rm $newname.tmp 2>/dev/null
      continue
      ;;
  esac

#######################################################################
done

###############################################################################
# EPILOGUE
###############################################################################

exit $rc
