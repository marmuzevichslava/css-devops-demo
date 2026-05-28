# SCCS: tolower.ksh  1.6  08/09/95  13:29:02
#******************************************************************************
#
# <tolower.ksh>
#
# Converts the case of a file name to lower case.
#
# Andersen Consulting - SolutionWorks
# 
# Coder:          Date		Action
# Marc Danneels   07/12/95    Original code.
# Bernard Lim     08/03/95    Added the ff. options:
#                             -f     for filename only
#                             -e     for extension only
#                             <none> for both
# Cynthia Ledesma 09/13/95    Modified directory structure
# Ralph Brown     12/15/95    Modified to accept wildcards and 
#                             multiple filename arguments
# 
#******************************************************************************


#validate arguments
set `echo TrustMeAboutThis;getopt "ef" $*`
if [[ $? -ge 1 ]]; then
   exit 1
fi
shift

#if both options specified, same as none.
while [ $1 != '--' ] 
do
  case $1 in
   -e) case $opt in
         f) opt='';;
        '') opt=e;;
       esac;;
   -f) case $opt in
         e) opt='';;
        '') opt=f;;
       esac;;
  esac
  shift;
done
shift


if ( [[ $# -eq 0 ]] ); then
 printf "\nusage:  tolower.ksh  -f -e <file> [file...]"
 printf "\nwhere:  -f    -> to change filename to lower case"
 printf "\n        -e    -> to change extension to lower case"
 printf "\n       <none> -> to change all to lower case\n\n"
 exit 1
fi

count=0
echo

while [ $# != 0 ]
do
  if [[ -f $1 ]]; then
       awk -f $BASE_TOOL/common/host/awk/tolower.awk -v option=$opt -v filename=$1
       if [[ $? -eq 0 ]]; then
          count=`expr $count + 1`
       fi
  fi
  shift
done

echo "\n  $count file(s) moved.\n"
exit 0
