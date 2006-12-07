#!/bin/ksh
#******************************************************************************
#
#   Tool Name: run_server.ksh
#
#   DESCRIPTION: Creates the files necessary for server checkin.
#
#   Andersen Consulting - SolutionWorks
# 
#   Coder:          Date	Action
#   Karen Swaim     3/16/97    Create 
#
#******************************************************************************

#check for existance of necesary files

find ~/server -name "CUF*" > temp.temp

if [[ -s temp.temp ]];
then
     #print 'files found'

     # run format_unix.ksh on all files and remove the *.old when done

     for file in ./server/CUF*; do
           format_UNIX.ksh ${file}
	   print 'Formatting... ' ${file}
     done
     rm ./server/CUF*.old 
     for file in ./server/cuf*; do
          format_UNIX.ksh ${file}
          print 'Formatting... ' ${file} 
     done
     rm ./server/cuf*.old

     # copy the *.c file to UPPER case

     for file in ./server/cuf*.c; do
         print 'Changing to upper case *.c -> ' ${file} 
         delctrlch.ksh ${file}
         filename=`basename ${file}`
         pathname=`dirname ${file}`
         newname=`print ${filename} | cut -d"." -f1`
	 newname=`print ${newname} | tr '[a-z]' '[A-Z]'`
	 newname=`print ${newname}.c`
	 newpath=${pathname}/${newname}
	 mv ${file} ${newpath}
	 if [[ $? = 0 ]]; then
	   print 'Changed to upper case ' ${newname} 
	 fi
     done
else
	print
	print "  There are no CUFx### files in your server directory."
	print
fi
if [[ -a temp.temp ]];
then
rm temp.temp
fi
