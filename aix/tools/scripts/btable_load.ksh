#!/bin/ksh 

#######################################################
#
#	File: btable_load
#
#	Description: load tables into oracle
#
#######################################################

### ORACLE ID ###

ORAID=$SW_USER
echo "Oracle ID [$ORAID]: \c"
read NEW_ORAID
case "$NEW_ORAID" in
	"")     ORAID="$ORAID" ;;
	*)      ORAID="$NEW_ORAID" ;;
esac
export ORAID

### Run Oracle SQL*Loader ###

sqlldr userid=$ORAID/$ORAID \
control=$BASE_TOOL/common/host/scripts/btable.ctl \
log=$FCPATH/btable.log \
data=$FCPATH/btable.dat \
bad=$FCPATH/btable.bad \
discard=$FCPATH/btable.dsc

