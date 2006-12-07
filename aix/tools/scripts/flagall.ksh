#!/bin/ksh 
###########################################################################################
# ScriptName :  flagall.ksh
# Description:  
#               
# Usage      :  flagall.ksh project group list
#               options:
#                         
#                       
#                     
# Date       Programmer         Action
# --------------------------------------------
# 01/06/98   Ed Deutscher       If the 2nd parameter is not client or host then the dir_name 
#                               will be copied to list.lst.  Otherwise the files in  dir_name 
#                               according to the whether they are client or host will be 
#                               copied to list.lst.
# 04/17/98  Scott Shepherd      Removed all logic except for actual flagging of archive so
#                               that it can be used in conjuction with runflagall.ksh.
###########################################################################################

if [[ $# != 2 ]]; then
    print "Invalid # of args."
    print "Usage: flagall.ksh project group list"
    exit 1
fi

for file in $(<$2) 
do
    vcs -GSVT -Y -Q $file >> vcs.out 2>> vcs.out
    chmod 444 $file
    chgrp $1 $file
done
