#******************************************************************************
#
# <fix_iomods.ksh>
#
# Arguments: COBOL file name
#
# Brief description of the shell script.
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date     Action
# Adam Kreuger    01/09/96 Original code.
# Marc Danneels   01/09/96 Modified to be run with HostMasscheckout script
#
#******************************************************************************
USAGE="\nUsage: fix_iomods.ksh <COBOL file >\n"
AWKDIR=$BASE_TOOL/common/host/awk

if [[ $# < 1 ]]
then
  echo "\nInvalid number of arguments."
  echo $USAGE
  exit 1
fi

file=$1

newname=`basename $file .pco`

awk -f $AWKDIR/REDEFINES.awk -v file=$newname  $file > $file.tmp

mv $file.tmp $file

cut -c 73-150 $file | grep -qv '^ *$'

if (( $?==0));then
	print "\nERROR--- characters past the 72 column.\n  In file........." $file >> REDERROR.txt
	cut -c 73-150 $file |grep -vn '^ *$' >> REDERROR.txt
fi
