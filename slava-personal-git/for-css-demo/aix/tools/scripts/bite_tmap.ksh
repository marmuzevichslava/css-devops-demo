#!/bin/ksh
#******************************************************************************
#
#   Tool Name:    bite_tmap.ksh    
#   Version:      1.0
#   Description:  Processes the copybook from the UNIX tmaps directory.  
#                 It truncates the .CPY extension, removes the ^M characters,
#                 and bitesize the copybook.
#
#   Andersen Consulting - SolutionWorks
# 
#   Coder:          Date:
#   Khim Theng      08/09/96    
#******************************************************************************

for file in *.@(CPY|cpy); do
  delctrlch.ksh ${file}
  pathname=`dirname ${file}`
  filename=`basename ${file}`
  newname=`print ${filename} | cut -d"." -f1`
  newfile=${pathname}/${newname}
  mv ${file} ${newfile}
  if [[ $? = 0 ]]; then
     print ${newname}
     print ''
     print 'Bitesizing....'
     print ''
  fi
done
rm EXTRACT.* GNRTNMSG.*
#bitesize.ksh ${newfile}

sed '23,9s/ 01 / 02 /'  <$newname > holding 
print "working"
bitesize.ksh  holding       

rm SWBS*
