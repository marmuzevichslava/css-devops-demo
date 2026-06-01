#!/bin/ksh 
#******************************************************************************
#
# <script_find.ksh>
#
# Arguments: 
#
# Return Codes:
# 
# Searches the script_usage.txt file for keyword or script name provided
#
#******************************************************************************
USAGE="\nUsage: script_find.ksh <keyword> \n"

if [[ $# < 1 ]]
then
  print "\nInvalid number of arguments."
  print $USAGE
  exit 1
fi

# Functions

{ 
        grep $1 scripts_usage.txt
       
}

exit $RETURN 
