#!/bin/ksh 

#######################################################
#
#	File: btab_crt 
#
#	Description: creates a flat file to be used by 
#		     Oracle Loader.
#
#	Input: TAB driver logfiles
#
#	Output: Oracle loader file
#
#######################################################

#------------------------------------------------------
#	Init
#------------------------------------------------------
Init ()
{
### RUN ###
RUN=A1
echo "Run Number [$RUN]: \c"
read NEW_RUN
case "$NEW_RUN" in
	"")     RUN="$RUN" ;;
	*)      RUN="$NEW_RUN" ;;
esac
export RUN

### Output file ###
OUTFILE="$FCPATH/btable.dat"
echo "Output File [$OUTFILE]: \c"
read NEW_OUTFILE
case "$NEW_OUTFILE" in
	"")     OUTFILE="$OUTFILE" ;;
	*)      OUTFILE="$NEW_OUTFILE" ;;
esac
export OUTFILE

rm $OUTFILE 1> /dev/null 2> /dev/null

### DATE ###
export DATE=`date +"%D"`
}

#------------------------------------------------------
#	ProcessTabFile
#------------------------------------------------------
ProcessTabFile ()
{
FILE=$1
cat $FILE | awk -F "[ ,]" '
	$9 ~ /CU*/	{
		printf("%s %s %s %s \n", $7, $9, $4, $23)
		}
	'
}
#------------------------------------------------------
#	ProcessLogFile
#------------------------------------------------------
ProcessLogFile ()
{
FILE=$1
ProcessTabFile $FILE | while read DRIVER TRANID TIME RESP DUMMY
do
	echo $RUN $DATE $DRIVER $TRANID $TIME $RESP >> $OUTFILE
done
}

#------------------------------------------------------
#	Main
#------------------------------------------------------
Main ()
{
Init

for FILE in $FCPATH/tab*.prf
do
	ProcessLogFile $FILE
done
}

Main
