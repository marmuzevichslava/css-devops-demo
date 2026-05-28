#!/bin/ksh
###########################################################################################
# ScriptName :  searchcode.ksh
# Description:  This script checks the out file for DACP-CD-IO-STA and SQLCODE.
# Usage      :  promote.ksh <tvspacw> <module name> <area> <sir no>
# Date       Programmer         Action
# --------------------------------------------
# 04/09/98   Scott Shepherd     Original code.
###########################################################################################

print "Searching DACP-CD-IO-STA Status not equal to OK or NF..."
grep "DACP-CD-IO-STA =" out |grep -v "NF"|grep -v "OK"
print "Searching for SQLCODE not equal to +000000000 or +000000100..."
grep "SQL-RTRN" out | grep -v "+000000000"|grep -v "+000000100"
