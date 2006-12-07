#!/bin/ksh
#******************************************************************************
#
#	<pvcsinfo.ksh>
#
#	Arguments: -u <userid>                report activity based on userid
#              -d <startdate> <enddate>   report activity between dates
#              -l                         only report locks
#              -U                         only report unlocks
#              -p                         only report puts
#              -g                         only report gets 
#              -?                         usage
#
#   Return Codes: 1 - invalid number of arguments
#                 2 - invalid argument supplied
#
#	This script will report information contained within the PVCS journal log file.
#   ( /sw/software/pvcs52/journal/journal.log ) 
#
#	Andersen Consulting - SolutionWorks
#
#	Coder           Date 	    Action
#	Marc Danneels   11/15/95    Original code.
#       Khim Theng      09/23/98    Changed "/sw/software/pvcs52" to "~pvcs"
#                                   to remove the hard coded version number. 
#
#******************************************************************************
AWKFILE=$BASE_TOOL/common/host/awk/pvcsinfo.awk
JOURNAL=~pvcs/journal/journal.log
USERID=''
STARTDATE=''
ENDDATE=''
LOCK=''
UNLOCK=''
GET=''
PUT=''
USAGE="\nUsage: pvcsinfo.ksh -l -p -g -u <userid> -d <start date> <end date>\n\
Arguments: -u <userid>                report activity based on userid\n\
           -d <startdate> <enddate>   report activity between dates\n\
           -l                         only report locks\n\
           -U                         only report unlocks\n\
           -p                         only report puts\n\
           -g                         only report gets\n\
           -t                         specific file type\n\
           -?                         usage\n\
Note date format: YYMMDD"

if [[ $# < 1 ]]
then
	echo "\nInvalid number of arguments."
	echo $USAGE
	exit 1
fi

while [[ "$1" != "" ]]
do
	case $1 in
		-l) LOCK="-v lock=1"
		;;
		-U) UNLOCK="-v unlock=1"
		;;
		-p) PUT="-v put=1"
		;;
		-g) GET="-v get=1"
		;;
		-u) shift
			USERID="-v userid=$1"
		;;
		-d) shift
			DATES="-v startdate=$1 -v enddate=$2"
		    shift
		;;
		-t) shift
            TYPE="-v type=$1"
        ;;
		-?) echo $USAGE
		    exit
		;;
		*)  echo "Invalid argument entred:"
		    echo $USAGE
		    exit 2
		;;
	esac
	shift
done

awk -f $AWKFILE $TYPE $USERID $LOCK $UNLOCK $PUT $GET $DATES $JOURNAL
