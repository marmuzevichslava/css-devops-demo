################################################
# ScriptName: create.workunit.ksh
# Purpose   : create corresponding workunit file
################################################

for file in CUC*.pco
do
	prefix=${file%.pco}
	four=${prefix#CUC}

	ls CUF$four.c > /dev/null

	if [ $?=0 ] 
	then
		print $file > $prefix.sv
		print CUF$four.c >> $prefix.sv
		tolower.ksh $prefix.sv
	else
		print "Problem - Matching .c file not found"
	fi

done
