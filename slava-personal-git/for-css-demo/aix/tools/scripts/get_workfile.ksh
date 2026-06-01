#!/bin/ksh 

. ~pvcs/.profile.base

if [[ $# != 4 ]]; then
    print "ERROR:  Invalid number of parameters"
fi

file=$1
revision=$2
archpath=$3
refpath=$4

if [[ `echo $revision |grep . ` != $revision ]]; then
    print "ERROR: Invalid revision number (must be in decimal format) -> $revision"
    exit 1
fi

if [[ ! -s $archpath/$file.v ]]; then
    print "ERROR: Invalid arcive file $archpath/$file" 
    exit 1
fi

if [[ ! -s $refpath/$file ]]; then
    print "ERROR: Invalid arcive file $refpath/$file"
    exit 1
fi

print "ReferenceDir=$refpath" > vcs.cfg
print "VCSDir=$archpath" >> vcs.cfg

get -Cvcs.cfg -R$revision -Y $file

if [[ ! -s $file ]]; then
    print "ERROR: Could not get $file."
    exit 1
fi
