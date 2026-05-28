#!/bin/ksh
#####################################################
# ScriptName: d2u_lower.ksh
# Purpose   : convert dos files to unix
#####################################################

awk -f $BASE_TOOL/common/host/awk/d2u_lower.awk $1 > $$
mv $$ $1

