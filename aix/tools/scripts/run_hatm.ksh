#!/bin/ksh
#******************************************************************************
#
#   Tool Name:    run_hatm.ksh 
#   Version:      2.0
#   Description:  Processes all copybooks from the UNIX current directory.  
#                 It truncates the .cpy extension; removes the ^M characters.
#
#   Andersen Consulting - SolutionWorks
# 
#   Coder:          Date	Action
#   Khim Theng      04/09/97    Original code.
#   Cathy Casas     06/19/98    Change to include code to remove cont char
#                               and run mvsformat
#
#******************************************************************************

find . -name "*.cpy" > temp.temp

if [[ -s temp.temp ]];
then
for file in *.@(CPY|cpy);
 do
  delctrlch.ksh ${file}
  pathname=`dirname ${file}`
  filename=`basename ${file}`
  newname=`print ${filename} | cut -d"." -f1`
  newfile=${pathname}/${newname}
  mv ${file} ${newfile}
  if [[ $? = 0 ]]; then
     print ${newname}
  fi
 mvsformat ${newname}
  if [[ $? = 0 ]]; then
     rm ${newname}.err
  else
     print "There is an error in ${newname}"
  fi
 done
 run_cob_io.ksh
rm EXTRACT.* GNRTNMSG.*
else 
	print
	print " --- There are no .cpy file(s) in your current directory."
	print
fi
if [[ -a temp.temp ]];
then
	rm temp.temp
fi

