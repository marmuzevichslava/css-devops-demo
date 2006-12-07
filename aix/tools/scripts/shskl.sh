#!/bin/ksh

# SCCS:  shskl.sh  02/10/95  08:47:02  1.4                            
#------------------------------------------------------------------------
# Script ID:  shskl.sh                                                        
# Date:   02/10/95                                                        
# Author: Michael D. Conner                                             
#         Andersen Consulting                                             
#         SolutionWorks                                                   
#         St.Petersburg, Florida                                          
#       
#-------------------------------------------------------------------------
# Function: Automatic batch script prologue                               
#           Uses:                   
#                 mkscrpt - skeleton prologue
#
#   Usage=> bsms.sh <shell script id> 
#-------------------------------------------------------------------------
# Revisions:
# Date       Who                      comments                            
#-------------------------------------------------------------------------
# 01/18/95  mconner                   created
# 09/13/95  cledesma                  modified directory structure
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
#STEP 1: Usage check
#-------------------------------------------------------------------------
if [[ $# -eq 0 ]]; then
	print "Usage: bsms.sh <script id>"
	exit 2
fi
#-------------------------------------------------------------------------
#STEP 5:  Definitions
#------------------------------------------------------------------------
TODAY=`date`
#MKSCRPT=$PROD_APPL/scripts/mkscrpt
MKSCRPT=$HOST_APPL/control/jobs/scripts/mkscrpt
#------------------------------------------------------------------------
#------------------------------------------------------------------------
#STEP 10: Change script_id
#------------------------------------------------------------------------
cp $MKSCRPT mscrpt
sed -e "/<script_id>/s//$1/g" mscrpt > tmp
/bin/rm -f mscrpt
#------------------------------------------------------------------------
#STEP 15: Insert date
#------------------------------------------------------------------------
sed -e "/<today>/s//$TODAY/g" tmp > tmp.1
mv tmp.1 tmp
#------------------------------------------------------------------------
#STEP 20: Insert author name
#------------------------------------------------------------------------
sed -e "/<scriptwriter>/s//$LOGNAME/g" tmp > tmp.1
/bin/rm -f tmp
mv tmp.1 $1
chmod 755 $1
return 0
