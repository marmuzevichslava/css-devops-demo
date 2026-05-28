#!/bin/ksh 
###########################################################################################
# ScriptName :  get_nm.ksh
# Description:  This script is used to retrieve BAE export files from NIMO mainframe. 
# Usage      :  get_nm.ksh <user id> <file>
#               options:
#                        user id - Mainframe id
#                        file    - File to down load
#
# Date       Programmer         Action
# --------------------------------------------
# 04/14/98   Scott Shepherd     Original Code.
# 08/27/98   Jeffrey Meissner   Modified code of where files are located on Mainframe
###########################################################################################

typeset -i i
typeset -u ExportFile
EXP=EXP

if [[ $# != 2 ]]; then
    echo "Usage: get_nm.ksh <tso id> <filename>"
    exit 1
else
    clear
    MFID=$1
    ExportFile=$2
fi

echo 'Retrieving Bill Account Extract File from Mainframe ... \n'
ftp -i -n <<EOF
open ibmcpua 
user $MFID
binary
cd ..
cd $MFID
cd BAEX
get $ExportFile
bye
EOF
echo '\nFile Transfer Complete\n'
if [[ ! -s $ExportFile ]]; then
    print ERROR: Could not get $ExportFile from mainframe.
    exit 1
fi 
    
ls -l $ExportFile

i=0
for word in `ls -l $ExportFile`
do
    i=i+1
    if [[ $i = 5 ]]; then
	bytesize=$word
    fi
done

print "$bytesize/2071\nquit" > .temp.out
print "Number of rows: \c" 
bc -l .temp.out

echo '\nPlease Verify File - Press <Enter> to Continue or <Cntrl-C> to Quit \c'
read ans
cp -f $ExportFile /tmp_work/bae/data/$ExportFile.dat
if [[ $? = 0 ]]; then
    cpflag=1
fi
rm -f $ExportFile
if [[ $cpflag = 1 ]]; then
    echo $ExportFile has successfully been copied to /tmp_work/bae/data/$ExportFile.dat
else
    echo ERROR: $ExportFile has not been copied to /tmp_work/bae/data/$2.dat
fi
rm -f .temp.out
echo '\nDone.'
