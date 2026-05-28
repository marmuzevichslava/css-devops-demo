#!/bin/ksh
#******************************************************************************
#
#   Tool Name: crun.ksh
#
#   Description:  Processes all .H and .GNB files from the UNIX home directory.
#                 It converts the files to lower case and the moves them to 
#                 cbooks directory ready for migration.
# 
#   Andersen Consulting - SolutionWorks
# 
#   Coder:          Date	Action
#   Bernard Lim     11/01/95    Original code.
#   K. Swaim        04/07/97    Check for existance of files and directories needed.
#                               and run format_unix on the files.
#
#******************************************************************************
#check for existance of GNB or gnb or H or h files

find ~/ -name "*.GNB" > temp.temp
find ~/ -name "*.H"  >> temp.temp
find ~/ -name "*.gnb" >> temp.temp
find ~/ -name "*.h" >> temp.temp
if [[ -s temp.temp ]];
then

#if the GNB file(s) exist then check to see if directories exist. Create them if not.

       if [[ ! -d new_include ]]; then
           mkdir new_include
           chmod 775 new_include 
       fi
       if [[ ! -d include ]]; then
           mkdir include
           chmod 775 include
       fi

   # run format_unix.ksh on all files 

       for file in ./*.@(GNB|gnb|H|h); do
           format_UNIX.ksh ${file}
           print 'Formatting... ' ${file}
       done


     for file in ~/*.@(GNB|gnb|H|h); do
        pathname=`dirname ${file}`
        filename=`basename ${file}`
        newname=`print ${filename} | tr '[A-Z]' '[a-z]'`
        newfile=${pathname}/${newname}
        mv ${file} ${newfile}
        if [[ $? = 0 ]]; then
           print ${newname}
        fi
        if [[ -a $CLNT_APPL/source/include/${newname} ]]; then
           mv -f ${newfile} ~/include
        else
           print ''
           print 'You have new include file(s).'
           print ''
           mv -f ${newfile} ~/new_include
        fi
     done

else
     print
     print "  There are no .GNB or .H files in your current directory."
     print
fi
if [[ -a temp.temp ]];
then
     rm temp.temp
fi
