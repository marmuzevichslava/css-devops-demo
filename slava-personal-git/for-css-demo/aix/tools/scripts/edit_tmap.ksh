#!/bin/ksh
#******************************************************************************
#
#   Tool Name  : edit_tmap.ksh
#
#   Description: Processes all xlt files in the UNIX tmaps directory.
#                It converts all files in lower case, changes the permissions,
#                and places a copy to the ~clawson/xltload directory for map
#                loading.
# 
#   Andersen Consulting - SolutionWorks
# 
#   Coder:          Date	Action
#   Khim Theng      04/30/96    Original code.
#   Cathy Casas     06/09/97    Modified due to addition on t4
#   Cathy Casas &   06/03/98    Comment out delctrlch due to change in
#   Ed Deutscher                checkin & remove copy to DA.
#*********************************************************************

for file in *.@(XLT|xlt); do
  #delctrlch.ksh ${file}
  filename=`basename ${file}`
  pathname=`dirname ${file}`
  newname=`print ${filename} | tr '[A-Z]' '[a-z]'`
  newpath=${pathname}/${newname}
  mv ${file} ${newpath}
  if [[ $? = 0 ]]; then
     print ${newname}
  fi
done
rm EXTRACT.*
rm GNRTNMSG.*
rm SWBS*
