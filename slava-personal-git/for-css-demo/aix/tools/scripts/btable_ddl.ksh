#!/bin/ksh 

#######################################################
#
#	File: btable_ddl
#
#	Description: creates benchmark table
#
#######################################################

RTAG="ROW"

#------------------------------------------------------
#	Init
#------------------------------------------------------
Init ()
{
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
#	CreateTable
#------------------------------------------------------
CreateTable ()
{
sqlplus $ORAID/$ORAID <<END

drop table benchmark_runs;

create table benchmark_runs (
	run_name	char(10),
	run_date	char(10),
	driver		char(15),
	transaction	char(20),
	timestamp	char(10),
	response	number(10,2)
	) storage (initial 500K next 500K pctincrease 50);

drop index bindx1;

create index bindx1 on benchmark_runs (run_name);
	

END
}

#------------------------------------------------------
#	Main
#------------------------------------------------------
Main ()
{
Init
CreateTable
}

Main
