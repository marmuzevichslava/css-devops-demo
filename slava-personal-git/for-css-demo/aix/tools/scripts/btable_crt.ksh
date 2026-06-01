#!/bin/ksh 

#######################################################
#
#	File: btable_crt 
#
#	Description: creates a flat file to be used by 
#		     Oracle Loader.
#
#	Input: batch driver logfiles
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
RUN=B1
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
#	ProcessLogFile
#------------------------------------------------------
ProcessLogFile ()
{
FILE=$1
DRIVER=`expr "$1" : '.*/\(.*\)' \| "$1"`
DRIVER=`expr "$DRIVER" : '\(cs4..dip\)'`
PRINT=NO
cat $FILE | while read TID TIMESTAMP DUMMY
do
	HH=`expr "$TIMESTAMP" : '\(..\)'`
	MM=`expr "$TIMESTAMP" : '..:\(..\)'`
	SS=`expr "$TIMESTAMP" : '.*:\(..\)'`
	TOTSECS=`expr \( $HH \* 60 \* 60 \) + \( $MM \* 60 \) + $SS`

	if [[ "$PRINT" = "YES" ]]; then
		RESPONSETIME=`expr $TOTSECS - $LAST_TOTSECS`
		echo "$RUN $DATE $DRIVER $LAST_TID $LAST_TIMESTAMP $RESPONSETIME" >> $OUTFILE
	else
		PRINT=YES
	fi

	LAST_TID=$TID
	LAST_TIMESTAMP=$TIMESTAMP
	LAST_TOTSECS=$TOTSECS
done
}

#------------------------------------------------------
#	Main
#------------------------------------------------------
Main ()
{
Init

for FILE in $FCPATH/cs4[0-9][0-9]dip.log
do
	ProcessLogFile $FILE 
done
}

Main
