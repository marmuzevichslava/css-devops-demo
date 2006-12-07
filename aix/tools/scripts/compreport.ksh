#!/bin/ksh
####################################################################################
# (c) COPYRIGHT 1996 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.
#
# ScriptName : compreport.ksh
#
# Description: This is used to send an email of the modules that failed to recompile
#              after the masscomp.ksh/compile.ksh is complete.
#
# Usage      : compreport.ksh <env> <project> <work dir>
#
# Date       Programmer         Action
# --------------------------------------------
# 05/14/99   Ed Deutscher       Original code.
#####################################################################################

COMP_ENV=$1
T_PROJECT=$2
MAILOWNER=edeutsch@stpete.ac.com

WORKDIR=$3/${T_PROJECT}_${COMP_ENV}

if [[ $# != 3 ]]; then
    print "\nUsage: compreport.ksh <env> <project> <work dir>"
    exit 1
fi

cd $WORKDIR

find . -name unsuccess.lst | xargs cat > hostfailures.txt
print "******** HOST ERRORS ********" > error.out
if [[ ! -s hostfailures.txt ]]; then
    print "No host failures occurred.\n" >> error.out
else
    cat hostfailures.txt >> error.out
fi

print "\n******** CLIENT ERRORS ********" >> error.out
if [[ ! -s $WORKDIR/client/client.err ]]; then
    print "No client failures occurred." >> error.out
else
    cat client.err >> error.out
fi

cat error.out | elm -s "Recompile Error Listing for t4_ce2/$COMP_ENV" $MAILOWNER > /dev/null
