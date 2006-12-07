#!/bin/ksh -p
# run_cob.ksh # 2.0 # CHANGED [run_cbl.ksh] # HP-UX 10.10 # OCT 1997
#******************************************************************************
#
#   Tool Name: run_590.ksh
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
tmp1="$pn.$$.1.tmp"  # work temporary file
tmp2="$pn.$$.2.tmp"  # work temporary file
integer rc=0      # return code
integer ec=0      # code of execution

integer tot=0     # total number of processed CBs
integer skp=0     # number of skipped  CBs
integer cuv=0     # number of CUV      CBs
integer ngn=0     # number of NON-GEN  CBs
integer lib=0     # number of LIB      CBs
integer nlib=0    # number of NEW_LIB  CBs
integer nngn=0    # number of NEW_NGEN CBs

typeset -Z3 tot
typeset -u  newname

for file in `ls $HOME/*.@(CPY|cpy)`
do
#######################################################################
# LOOP THROUGH ALL RELEVANT COPYBOOKS -- *.cpy OR *.CPY
#######################################################################

pathname=${file%/*}
filename=${file##*/}
newname=${filename%.*}
#newfile=${pathname}/${newname}

let tot=tot+1

format_UNIX.ksh ${file} # to UNIX format - remove line feeds

#dos2ux ${file} | tr -d '\011' >$tmp1  # to UNIX format and del TABs
cat ${file} | tr -d '\011' >$tmp1  # del TABs

ec=$?
if [ $ec -eq 0 ]
then
  note=""
  /css/devtools/common/host/scripts/l88form.ksh $tmp1 >$tmp2 # SOURCE CODE REFORMATTING
  ec=$?
  case $ec in
    0):
      note="RE-FORMATTED."
      :;;
    1):
      :;;
    *):
      note="RE-FORMATTING FAILED. RC=$ec. SKIPPED."
      continue
      :;;
  esac
  if   [[ -a $HOST_APPL/source/copy/nongen/${newname} ]]
  then
    mv -f $tmp2 ~/nongen/${newname} 
    let ngn=ngn+1
  elif [[ -a $HOST_APPL/source/copy/lib/${newname}    ]]
  then
    mv -f $tmp2 ~/lib/${newname} 
    let lib=lib+1
  elif [[ ${newname} = *V ]]
  then
    note="$note  NEW VERSION COPYBOOK"
    mv -f $tmp2 ~/new_ngen/${newname} 
    let nngn=nngn+1
  else
    note="$note  NEW LIB COPYBOOK"
    mv -f $tmp2  ~/new_lib/${newname} 
    let nlib=nlib+1
  fi
  print "..[$pn] $tot ${newname} $note"
  rm ${file}
else
  let skp=skp+1
  rc=1
  print "..[$pn] ${file} dos2ux FAILED. SKIPPED. RC=$ec."
fi

#######################################################################
done

###############################################################################
# EPILOGUE
###############################################################################

rm $tmp1 $tmp2 2>/dev/null
print "..[$pn] $tot/$skp lib=$lib new_lib=$nlib nongen=$ngn new_ngen=$nngn. RC=$rc."
exit $rc
