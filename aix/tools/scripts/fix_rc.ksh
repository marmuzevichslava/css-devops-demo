#!/bin/ksh
# set -x
#******************************************************************************
# (c) COPYRIGHT 1996 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# fix_rc.ksh
#
# Arguments: Application .rc file
#
# This shell script calls fix_rc.awk to remove hardcodes in .rc files
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date      Action
# Greg Howell     04/02/97  Original code.
#
#******************************************************************************

# Create list of make files
find . -name '*.rc' >> rc_file.lst

# Run the awk script against each make file
for file in $(<rc_file.lst)
do
	awk -f fix_rc.awk $file > $file.new
	mv -f $file.new $file
done

mv -f rc_file.lst rc_file.lst.old
