#******************************************************************************
# ScriptName  : chkfind.ksh
# Purpose     : To locate the specified file in either the host directory
#               structure or the client directory structure
# Usage       : chkfind.ksh [-c|-h] filename
#               -c   searches the client directory structure
#               -h   searches the host directory structure
# Default     : searches both directory structures
#
# Date		Programmer           Action
# ~~~~~~~~	~~~~~~~~~~~~~~~	     ~~~~~~~~~~~~
# 09/27/95 	Cynthia Ledesma      Original Code
#******************************************************************************
case $# in
     1 ) arg=$(print "'$1'" | cut -c2)
         if [[ $arg = "-" ]]; then
            print "usage: chkfind.ksh [-c|-h] filename"
            return 1
         else
            filename=$1
         fi ;;
     2 ) option=$(print "'$1'" | cut -c3)
         filename=$2 ;;
   0|* ) print "usage: chkfind.ksh [-c|-h] filename"
         return 1 ;;
esac
 
function searchboth {
   find $BASE_APPL/base/client/$APPL_ENV -name $filename > tmp.lst
   find $BASE_APPL/base/host/$APPL_ENV -name $filename >> tmp.lst  
}

function searchdir {
   find $BASE_APPL/base/${ClientHost}/$APPL_ENV -name $filename > tmp.lst
}

print 'searching ...'
let counter=0
case $option in
   c ) ClientHost=client
       searchdir ;;
   h ) ClientHost=host
       searchdir ;; 
   * ) searchboth ;;
esac

for file in $(<tmp.lst)
do
   if [[ -n $file ]]; then
      counter=$((counter+1))
      print "chkfind.ksh : $file" 
   fi 
done
rm -f tmp.lst
 
if [[ $counter = 0 ]]; then
   print "chkfind.ksh: $filename not found ..." 
   print "Check spelling and case of file."
elif [[ $counter -gt 1 ]]; then
   print "warning:  multiple existence of $filename"
fi

