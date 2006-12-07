# SCCS: change_case.ksh  1.2  08/08/95  15:35:39
#******************************************************************************
#
#	<change_case.ksh>
#
#   Arguments:  -u Convert to upper case
#			    -l Convert to lower case
#
#	Changes all the files in the current directory to either all upper of lower case.
#
#	Andersen Consulting - SolutionWorks
# 
#	Coder:          Date		Action
#	Marc Danneels   08/02/95    Original code.
#	Marc Danneels   12/19/95    Redirected std error to /dev/null
#
#******************************************************************************

case $1 in
	-u)	OPTS='[:lower:] [:upper:]'
		;;
			
	-l)	OPTS='[:upper:] [:lower:]' 
		;;
			
	*) 	print "usage: $0 [-u] [-l]"
		echo 'Changes all files in current directory to either upper or lower case.'
		exit ;;
esac

for file in * 
do
	if [ -f $file ]
	then
		mv $file `echo $file | tr $OPTS` 2> /dev/null
	fi
done 
