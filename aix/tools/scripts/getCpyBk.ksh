#!/bin/ksh 

# SCCS:  %M%  %G%  %U%  %I%
#######################################################################
#
#	File: getCpyBk.ksh
#       Author: Michael D. Conner
#               Andersen Consulting
#               St. Petersburg, Florida
#
#	Description: finds the copy book for a particular table     
#
#	Parameters:
#		$1 = Table name          
#
#       Usage: getCpyBk.ksh <table name>
#######################################################################

#-------------------------------------
# set variables and check parameters
#-------------------------------------

if [[ $# -eq 0  || "$1" = "?" ]]; then
	print "Usage: getCpyBk.ksh <table name>"
	print "Prints copybook name"
	return 1
fi
print $1 | tr "[a-z]" "[A-Z]" | read TABLENAME
export TABLENAME
#print $TABLENAME

#--------------------------------------------------------------------
# getCB
#--------------------------------------------------------------------
getCB()
{
	head $file | awk -v str=$TABLENAME -v fn=$file ' 
	{
		while (getline > 0 )
		{
			if (index($0, str))
				print fn	
		}
	} '
}
#--------------------------------------------------------------------
#            main
#--------------------------------------------------------------------
#for file in $PROD_APPL/dclgen/*
for file in $HOST_APPL/source/copy/table/*
do
	export file
	getCB | read CBA
	if [[ "$CBA" != "" ]]; then
		print $CBA
		return 0
	fi
done
print "NOT_FOUND"
return 0
