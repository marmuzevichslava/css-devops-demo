#!/bin/ksh
# set -x
#******************************************************************************
# (c) COPYRIGHT 1996 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# <search.ksh>
#
# Arguments: 
#	-e search the execution path ( similar to whence )
# -i search the COBCPY path
# -s search the COBPATH
#
# Return Codes:
# 1 - invalid number of arguments
# 2 - invalid option
# 3 - File not found in COBCPY path
# 4 - File not found in COBPATH path
# 
# Searches the environment for executables and files
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date      Action
# Marc Danneels   02/04/97  Original code.
#
#******************************************************************************
USAGE="\nUsage: `basename $0` -e -i -s <target file>\n\n\t-e search execution path\n\t-i search \$COBCPY\n\t-s search \$COBPATH\n"

if [[ $# < 1 ]]
then
  print "\nInvalid number of arguments."
  print $USAGE
  exit 1
fi

# Functions

option_e ()
{ 
	print "\nSearching executable path for <$OPTARG>"
	whence $OPTARG
	RETURN=$?
}

option_i ()
{ 
	print "Searching \$COBCPY for <$OPTARG>\n"
	echo $COBCPY > $HOME/$$
	sed 's/:/ /g' $HOME/$$ > $HOME/COBCPY_DIRS
	RETURN=3
	for dir in $(<$HOME/COBCPY_DIRS)
	do
		if [ -f $dir/$OPTARG ] 
		then
			ls $dir/$OPTARG
			RETURN=0
		fi
	done
}

option_s ()
{ 
	print "Searching \$COBPATH for <$OPTARG>\n"
  echo $COBPATH > $HOME/$$
  sed 's/:/ /g' $HOME/$$ > $HOME/COBPATH_DIRS
  RETURN=4
  for dir in $(<$HOME/COBPATH_DIRS)
  do
    if [ -f $dir/$OPTARG ]
    then
      ls $dir/$OPTARG
      RETURN=0
    fi
  done

}

while getopts ":e:i:s:" opt
do
	case $opt in
		e	) option_e;;
		i	) option_i;;
		s	) option_s;;
		\? ) print "Invalid option.\n$USAGE"; exit 2;;
	esac
done

print 

# Cleanup & Exit
rm -f $HOME/$$ $HOME/COBPATH_DIRS $HOME/COBCPY_DIRS > /dev/null 2>&1

exit $RETURN 
