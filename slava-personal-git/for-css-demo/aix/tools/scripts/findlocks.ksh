#!/bin/ksh
################################################################################
#
# ScriptName :  findlocks.ksh
#
# Description:  This script will find all locks that a specified user has.
#
# Usage      :  findlocks.ksh <userid>
#
# Date          Programmer         Action/Description
# ---------     ------------       ------------------
# 07/23/98      Khim Theng         Original code
################################################################################

function prompt_usage
{
    print "USAGE:     findlocks.ksh <userid>"
    print "EXAMPLE:   findlocks.ksh jsmith\n"
    exit $ERROR
}

########
# MAIN #
########
if [[ $# != 1 ]]; then
    print "\nERROR: Invalid number of parameters.\n"
    prompt_usage
fi

USERID=$1
print "Searching ..."
vjournal -XL | grep $USERID > lockedfiles.output
if [[ $? != 0 ]]; then
    print "\n$USERID has nothing locked.\n"
else
    print "\n$USERID has the following files locked:"
    cat lockedfiles.output
fi
rm -f lockedfiles.output
