#!/bin/ksh
# set -x
#******************************************************************************
# (c) COPYRIGHT 1997 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# <percent>
#
# Arguments:
#
# Determins disk space used.  By different projects, total and common.
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date      Action
# Marc Danneels   06/26/98  Original code.
# Marc Danneels   06/26/98  Added common area
# Marc Danneels   08/17/98  Added CE2
#
#******************************************************************************
USAGE="\nUsage: `basename $0` <input file type>\n"

if [[ $# < 0 ]]
then
  echo "\nInvalid number of arguments."
  echo $USAGE
  exit 1
fi

SERVER=`hostname`
OUTPUT=${SERVER}.total.csv
MAIN_TITLE="File Systems for $SERVER\nFile System, MB"

print "${MAIN_TITLE}" > $OUTPUT

# Determin total MB per file system
bdf -l | awk '{if ( NF == 6 ) printf( "%s,%d\n", $6, $2/1024 ); if ( NF == 5 ) printf("%s,%d\n", $5, $1/1024) }' >> $OUTPUT

# Determin by project
for PROJECT in base t4_ce t4_ce2 t4_or t5am t5me t5nm t5ppl
do
	print "$PROJECT File Systems for $SERVER\nFile System, MB" > $SERVER.$PROJECT.csv
	grep $PROJECT $OUTPUT >> $SERVER.$PROJECT.csv
	if [[ $? = 1 ]]; then
		rm $SERVER.$PROJECT.csv
	fi
done

# Get common areas.  Filter out all PROJECTs from total
grep -v base $OUTPUT | grep -v t4_ce | grep -v t4_ce2 | grep -v t4_or | grep -v t5am | grep -v t5me | grep -v t5nm | grep -v t5ppl > $SERVER.common.csv
