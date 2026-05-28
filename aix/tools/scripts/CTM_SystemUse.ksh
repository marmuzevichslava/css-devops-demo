#!/bin/ksh
#******************************************************************************
# (c) COPYRIGHT 1996 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.           
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.        
#
# <filename>
#
# Arguments: 
#
# CTM Population Script
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date      Action
# Marc Danneels   04/07/97  Original code.
#
#******************************************************************************
#USAGE="\nUsage: `basename $0` <codes table input file>\n"
 

# Function: call_fdecode - determins if the variable is used to drive 
# code in the file.  Trying to determine if a variable drives code is 
# a very complex task.  This application is not 100% acurate.

function call_fdecode {
	while read fullpath 
  do
		if [[ -n $fullpath ]]
		then
	 		echo "$fullpath $VARIABLE" >> search_code.out
 			# Test for the file to contain logic.  If it is found then break
 			# and create an input file for access containing TABLE, CODE, 1 ( true )
 
 			print "Running fdecode"
 			./fdecode $fullpath "$VARIABLE "

			if [[ $? = 1 ]]
			then
				print "$fullpath $VARIABLE  $TABLE,E$VALUE" >> fdecode.out			
				return
			fi
		fi
	done <fdecode.input
}

function create_run_sql {
    echo "execute CF1_QUERY ( '$APPL_TBL', '$ARCH_TBL', '{$VARIABLE}', 7564);" > run_sql.sql
    echo "spool results.out;" >> run_sql.sql
    echo "set feedback off;" >> run_sql.sql
    echo "set head off;" >> run_sql.sql
    echo "select text from PUBLIC_HITLIST_VIEW" >> run_sql.sql
    echo "where QueryKey = 7564;" >> run_sql.sql
    echo "exit;" >> run_sql.sql
		sqlplus impact/impact@swt1 @run_sql
}


# Delete all output files
#rm *out

if [[ $# < 1 ]]
then
  echo "\nInvalid number of arguments."
  echo $USAGE
  exit 1
fi

TOTAL_RECORDS=`wc -l $1`
let CTR=0

while read TABLE
do
	let CTR="CTR + 1"
	print "Processing record $CTR of $TOTAL_RECORDS" >> progress.out
	print "Processing record $CTR of $TOTAL_RECORDS"
	# Host Processing - check host application and architecture areas
	# Check to see if a HOST CUV Copybook exists

	BASE_CUV=${TABLE#CIS}
	HOST_CUV="CUV$BASE_CUV"
	CLIENT_CUV=cuv`echo $BASE_CUV | tr [:upper:] [:lower:]`.h

	if [[ -f $HOST_APPL/source/copy/cuv/$HOST_CUV ]]
	then
		APPL_TBL="C1_T4_HOST"
		ARCH_TBL="ARCH_HOST"
		# Determine all 88 values associated with cuv file
		grep VALUE $HOST_APPL/source/copy/cuv/$HOST_CUV | grep ' 88 ' > temp.lst

		# See if temp.lst file contains data
		if [[ -s temp.lst ]]
		then
			# This should all be done in one awk script - or better yet a perl script
			awk '{print $2 " " $4}' temp.lst | sed s/\'//g | sed s/.$// | grep -v "^[ ]*$" > cisvalue.out
			if [[ -s cisvalue.out ]]
			then
				while read VARIABLE VALUE 
				do
					grep $TABLE TblCodes.lst | grep "	E$VALUE$" > /dev/null
					if [[ $? = 0 ]]
					then
						print "Found variable <$VARIABLE> for value <E$VALUE> in codestable <$TABLE> which relates to <$HOST_CUV>"
						create_run_sql
						if [[ -f results.out ]]
						then
							# Dont need to scan the cuv copybook
							grep -v "$HOST_APPL/source/copy/cuv/$HOST_CUV" results.out > fdecode.input
							if [[ -f fdecode.input ]]
							then
								call_fdecode
							fi
				    fi
					fi
				done < cisvalue.out
			fi
		fi
	else
		print $HOST_APPL/source/copy/cuv/$HOST_CUV not found.
	fi

  if [[ -f $CLNT_APPL/source/include/$CLIENT_CUV ]]
  then
    APPL_TBL="C1_T4_CLIENT"
    ARCH_TBL="ARCH_CLIENT"
    # Determine all 88 values associated with cuv file
    grep "^#define" $CLNT_APPL/source/include/$CLIENT_CUV  > temp.lst

    # See if temp.lst file contains data
    if [[ -s temp.lst ]]
    then
      # This should all be done in one awk script - or better yet a perl script
      awk '{print $2 " " $3}' temp.lst | sed s/\"//g > cisvalue.out
      if [[ -s cisvalue.out ]]
      then
        while read VARIABLE VALUE
        do
					# Note:  There is a tab character just befor the E$VALUE$
          grep $TABLE TblCodes.lst | grep "	E$VALUE$" > /dev/null
          if [[ $? = 0 ]]
          then
            print "Found variable <$VARIABLE> for value <E$VALUE> in codestable <$TABLE> which relates to <$CLIENT_CUV>"
            create_run_sql
            if [[ -f results.out ]]
            then
              # Dont need to scan the cuv copybook
              grep -v "$CLNT_APPL/source/include/$CLIENT_CUV" results.out > fdecode.input
              if [[ -f fdecode.input ]]
              then
                call_fdecode
              fi
            fi
          fi
        done < cisvalue.out
      fi
    fi
  else
    print $HOST_APPL/source/copy/cuv/$CLIENT_CUV not found.
  fi

done <$1

# Cleanup

#rm temp.lst fdecode.input cisvalue.out results.out

awk -f format_fdecode.awk fdecode.out > fdecode.csv
