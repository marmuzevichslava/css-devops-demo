#!/bin/ksh
#******************************************************************************
#
#	<replace_str.ksh>
#
#	Calls replace_str.awk which replaces the input string with the replacement 
#	string in the files given.
#
#	Andersen Consulting - SolutionWorks
# 
#	Coder:          Date		Action
#	Marc Danneels   10/25/95    Original code.
#
#*****************************************************************************

if [[ $# -ne 3 ]]; then
	print "\nusage: replace_str.ksh <file> \"old string\" \"newstring\"\n"
	exit 0
fi

awk -v oldstr="$2" -v newstr="$3" -f $BASE_TOOL/common/host/awk/replace_str.awk $1 > $1.tmp

mv -f $1.tmp $1
