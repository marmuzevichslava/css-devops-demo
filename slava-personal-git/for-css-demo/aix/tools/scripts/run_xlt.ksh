#!/bin/ksh
#******************************************************************************
#
#   Tool Name: xltrun.ksh
#
#   Description: Processes all xlt files in the UNIX home directory.
#                It converts all files in lower case and moves them to the
#                xltmaps directory.  It also places a copy to the xltload
#                directory for map loading.
# 
#   Andersen Consulting - SolutionWorks
# 
#   Coder:          Date	Action
#   Bernard Lim     11/07/95    Original code.
#   Karen Swaim & Khim Theng  3/25/97. Check for existance of files and directories. Create
#                                      directories if needed.
#   Karen Swaim     4/7/97      Run format_UNIX.ksh automatically.
#   Ed Deutscher    5/12/98     Commented out format_UNIX.ksh and check for ENDMAP. 
#******************************************************************************
#check for existance of xlt files

find . -name "*.XLT"  > temp.temp

if [[ -s temp.temp ]]; then
     #if the xlt file(s) exist then check to see if directories exist. Create them if not.
     if [[ ! -d new_xlt ]]; then
          mkdir new_xlt
          chmod 775 new_xlt
     fi
     if [[ ! -d xlt ]]; then
          mkdir xlt
          chmod 775 xlt
     fi

     # run format_unix.ksh on all files *.cpy

     #for file in ./*.@(XLT|xlt); do
     #    format_UNIX.ksh ${file}
     #    print 'Formatting... ' ${file}
     # done

     for file in ~/*.@(XLT|xlt); do
          filename=`basename ${file}`
          pathname=`dirname ${file}`
          newname=`print ${filename} | tr '[A-Z]' '[a-z]'`
          newpath=${pathname}/${newname}
          grep "ENDMAP" ${file}
          if [[ $? = 0 ]]; then 
              mv ${file} ${newpath}
              if [[ $? = 0 ]]; then
                   print ${newname}
              fi
              if [[ -a ${HOST_APPL}/source/xltmap/${newname} ]]; then
                    chmod 777 ${newpath}
                    mv -f ${newpath} ~/xlt
              else
                    print ''
                    print 'You have new xlt file(s).'
                    print ''
                    mv -f ${newpath} ~/new_xlt
              fi
          else
              print "Did not find ENDMAP line in ${filename}."
          fi  
     done

else
     print
     print "  There are no .XLT files in your current directory."
     print
fi
if [[ -a temp.temp ]]; then
      rm temp.temp
fi
