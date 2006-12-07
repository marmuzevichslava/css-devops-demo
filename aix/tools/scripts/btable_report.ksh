#!/bin/ksh 

#######################################################
#
#	File: btable_report
#
#	Description: creates final report
#
#######################################################

RTAG="ROW"

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

### ORACLE ID ###
ORAID=$SW_USER
echo "Oracle ID [$ORAID]: \c"
read NEW_ORAID
case "$NEW_ORAID" in
	"")     ORAID="$ORAID" ;;
	*)      ORAID="$NEW_ORAID" ;;
esac
export ORAID
}

#------------------------------------------------------
#	PrintHeader1
#------------------------------------------------------
PrintHeader1 ()
{
echo "                         Batch Benchmark Driver\n"
echo "Run: $RUN\n"
echo "Statistics for each Driver\n"
echo "Driver Name  Total   TPS    Avg. RT  Max. RT   Min. RT   Elapsed Time"
echo "-----------  -----   ---    -------  -------   -------   ------------"
}

#------------------------------------------------------
#	PrintHeader2
#------------------------------------------------------
PrintHeader2 ()
{
echo "\nStatistics at the time were ALL drivers were active \n"
echo "Driver Name  Total   TPS    Avg. RT  Max. RT   Min. RT"
echo "-----------  -----   ---    -------  -------   -------"
}

#------------------------------------------------------
#	ActiveTimestampRange
#------------------------------------------------------
ActiveTimestampRange ()
{
sqlplus $ORAID/$ORAID <<END
set linesize 200
select '$RTAG', max(min(timestamp)), min(max(timestamp))
   from benchmark_runs
   where run_name='$RUN'
   group by driver;
END
}

#------------------------------------------------------
#	StatPerDriver
#------------------------------------------------------
StatPerDriver ()
{
sqlplus $ORAID/$ORAID <<END
set linesize 200
select '$RTAG', driver, count(*), avg(response), max(response),
       min(response), max(timestamp), min(timestamp)
   from benchmark_runs
   where run_name='$RUN'
   group by driver;
END
}

#------------------------------------------------------
#	ActiveStat
#------------------------------------------------------
ActiveStat ()
{
sqlplus $ORAID/$ORAID <<END
set linesize 200
select '$RTAG', driver, count(*), avg(response), max(response),
       min(response), max(timestamp), min(timestamp)
   from benchmark_runs
   where run_name='$RUN'
   and timestamp > '$MINTIME' and timestamp < '$MAXTIME'
   group by driver;
END
}

#------------------------------------------------------
#	StatPerDriverTotal
#------------------------------------------------------
StatPerDriverTotal ()
{
sqlplus $ORAID/$ORAID <<END
set linesize 200
select '$RTAG', count(*), avg(response), max(response),
       min(response), max(timestamp), min(timestamp)
   from benchmark_runs
   where run_name='$RUN';
END
}


#------------------------------------------------------
#	ActiveStatTotal
#------------------------------------------------------
ActiveStatTotal ()
{
sqlplus $ORAID/$ORAID <<END
set linesize 200
select '$RTAG', count(*), avg(response), max(response),
       min(response), max(timestamp), min(timestamp)
   from benchmark_runs
   where run_name='$RUN'
   and timestamp > '$MINTIME' and timestamp < '$MAXTIME';
END
}

#------------------------------------------------------
#	PrintStatPerDriver
#------------------------------------------------------
PrintStatPerDriver ()
{
StatPerDriver | awk '
   /ROW/	{
	driver=$2
	total=$3
	avgrt=$4
	maxrt=$5
	minrt=$6
	maxts=$7
	mints=$8

	hh=substr(maxts,1,2)
	mm=substr(maxts,4,2)
	ss=substr(maxts,7,2)
	maxtotsec=(hh*60*60)+(mm*60)+ss

	hh=substr(mints,1,2)
	mm=substr(mints,4,2)
	ss=substr(mints,7,2)
	mintotsec=(hh*60*60)+(mm*60)+ss

	elapsed=maxtotsec-mintotsec
	tps=total/elapsed

	hh=int(elapsed/60/60)
	mm=int((elapsed-(hh*60*60))/60)
	ss=int(elapsed-(hh*60*60)-(mm*60))

	printf("%-10.10s %7d   %4.2f     %2.2f     %2.2f     %2.2f       %2.2d:%2.2d:%2.2d \n",driver,total,tps,avgrt,maxrt,minrt,hh,mm,ss)
	}
   '
}

#------------------------------------------------------
#	GetActiveRange
#------------------------------------------------------
GetActiveRange ()
{
ActiveTimestampRange | while read TAG MINTS MAXTS DUMMY
do
	if [[ "$TAG" = "$RTAG" ]]; then
		export MINTIME=$MINTS
		export MAXTIME=$MAXTS
	fi
done
}

#------------------------------------------------------
#	PrintActiveStats
#------------------------------------------------------
PrintActiveStats ()
{
ActiveStat | awk '
   /ROW/	{
	driver=$2
	total=$3
	avgrt=$4
	maxrt=$5
	minrt=$6
	maxts=$7
	mints=$8

	hh=substr(maxts,1,2)
	mm=substr(maxts,4,2)
	ss=substr(maxts,7,2)
	maxtotsec=(hh*60*60)+(mm*60)+ss

	hh=substr(mints,1,2)
	mm=substr(mints,4,2)
	ss=substr(mints,7,2)
	mintotsec=(hh*60*60)+(mm*60)+ss

	elapsed=maxtotsec-mintotsec
	tps=total/elapsed

	printf("%-10.10s %7d   %4.2f     %2.2f     %2.2f     %2.2f \n",driver,total,tps,avgrt,maxrt,minrt)
	}
   '
}

#------------------------------------------------------
#	PrintStatPerDriverTotal
#------------------------------------------------------
PrintStatPerDriverTotal ()
{
StatPerDriverTotal | awk '
   /ROW/	{
	total=$2
	avgrt=$3
	maxrt=$4
	minrt=$5
	maxts=$6
	mints=$7

	hh=substr(maxts,1,2)
	mm=substr(maxts,4,2)
	ss=substr(maxts,7,2)
	maxtotsec=(hh*60*60)+(mm*60)+ss

	hh=substr(mints,1,2)
	mm=substr(mints,4,2)
	ss=substr(mints,7,2)
	mintotsec=(hh*60*60)+(mm*60)+ss

	elapsed=maxtotsec-mintotsec
	tps=total/elapsed

	hh=int(elapsed/60/60)
	mm=int((elapsed-(hh*60*60))/60)
	ss=int(elapsed-(hh*60*60)-(mm*60))

	printf("-----------  -----  -----   -------  -------   -------   ------------\n");
	printf("           %7d   %4.2f     %2.2f     %2.2f     %2.2f       %2.2d:%2.2d:%2.2d \n",total,tps,avgrt,maxrt,minrt,hh,mm,ss)
	}
   '
}

#------------------------------------------------------
#	PrintActiveStatsTotal
#------------------------------------------------------
PrintActiveStatsTotal ()
{
ActiveStatTotal | awk '
   /ROW/	{
	total=$2
	avgrt=$3
	maxrt=$4
	minrt=$5
	maxts=$6
	mints=$7

	hh=substr(maxts,1,2)
	mm=substr(maxts,4,2)
	ss=substr(maxts,7,2)
	maxtotsec=(hh*60*60)+(mm*60)+ss

	hh=substr(mints,1,2)
	mm=substr(mints,4,2)
	ss=substr(mints,7,2)
	mintotsec=(hh*60*60)+(mm*60)+ss

	elapsed=maxtotsec-mintotsec
	tps=total/elapsed

	printf("-----------  -----  -----   -------  -------   ------- \n");
	printf("           %7d   %4.2f     %2.2f     %2.2f     %2.2f \n",total,tps,avgrt,maxrt,minrt)
	}
   '
}

#------------------------------------------------------
#	Main
#------------------------------------------------------
Main ()
{
Init
PrintHeader1
PrintStatPerDriver
PrintStatPerDriverTotal
PrintHeader2
GetActiveRange
PrintActiveStats
PrintActiveStatsTotal
}

Main
