#!/bin/ksh 
################################################################################# 
#                                                                               #
# ScriptName:   count.ksh                                                       #
# Description:  Counts the number of files based on the extension and/or type.  #
# Usage:                                                                        #
#            count.ksh -tdialog      -> counts the total number of dialogs      #
#            count.ksh -tcomwin dlg  -> counts the number of .dlg files in      #
#                                       comwin                                  #
#            count.ksh o             -> counts the number of host object files  #
#            coutn.ksh               -> for files w/o extension; prompts user   #
#                                       for the type                            #
#                                                                               #
# Date          Programmer            Action                                    # 
# ----------------------------------------------------------------------------- #
# 11/19/96      Cynthia Ledesma       Original code.                            #
#################################################################################

function prompt_usage {
   print "usage:   count.ksh [t<type>v<version>] [file extension]"
   print "                   options:"
   print "                             t <type>	- specify module type"
   print "                                           e.g. -t dialolg"
   print "                             v <version>	- specify if type is ddl"
   print "                                           e.g. -v v2.1"
}

HOST_SRC=/css/c1/host/build/source
HOST_RUN=/css/c1/host/build/runtime
CLNT_SRC=/css/c1/client/build/source
CLNT_RUN=/css/c1/client/build/runtime
HOST_BLD=/css/c1/host/build
 
 EXT_LEN=3

 type=""

while getopts ":t:" option; do
case $option in 
   t)  type=$OPTARG;;
   v)  ver=$OPTARG;;
   \?) prompt_usage
	   exit 1
esac
done
shift $(($OPTIND-1))

ext=$1

if [[ -n $ext && ${#ext} -le $EXT_LEN ]]; then
   case $ext in
	  map) print "csrmaps:"
               find $CLNT_RUN/nt/csrmap -type f -name "*.map" > count.file;;
          dde) print "dde:"
               find $CLNT_RUN/dde -type f -name "*.dde" | wc -l;;
	  bmp) print "bitmaps:"
               find $CLNT_RUN/bitmaps -type f -name "*.bmp" | wc -l;;
          ico) print "icons:"
               find $CLNT_RUN/bitmaps -type f -name "*.ico" | wc -l;; 
	  dll) print "dll modules:"
               find $CLNT_RUN/nt/dll -type f -name "*.dll" | wc -l;;
	  exe) print "exe files:"
               find $CLNT_RUN/nt/exe -type f -name "*.exe" | wc -l;;
	  lib) print "lib files:"
               find $CLNT_RUN/nt/lib -type f -name "*.lib" | wc -l;;
	  obj) print "obj files:"
               find $CLNT_RUN/nt/obj -type f -name "*.obj" | wc -l;;
	  hlp) print "hlp files:"
               find $CLNT_RUN/nt/help -type f -name "*.hlp" | wc -l;;
	  h)   print "client include (h):"
               find $CLNT_SRC/include -type f -name "*.h" | wc -l
               print "total client includes:"
               find $CLNT_SRC/include -type f | wc -l;;
	  gnb) print "client include (gnb):"
               find $CLNT_SRC/include -type f -name "*.gnb" | wc -l
               print "total client includes:"
               find $CLNT_SRC/include -type f | wc -l;;
	  sql) if [[ -z $ver ]]; then
			  print "Enter ddl version: "
			  read ver
			  clear
		fi
                   print "ddl files in $ver:"
		   find $HOST_SRC/ddl/$ver -type f -name "*.sql" | wc -l;;
	  xlt) print "translation maps:"
               find $HOST_SRC/xltmap -type f -name "*.xlt" | wc -l;;
	  c)   print "UNIX server front ends:"
               find $HOST_SRC/code/service -type f -name "*.c" | wc -l;;
	  pco) print "service: "
		   find $HOST_SRC/code/service -type f -name "*.pco" | wc -l
		   print "common: "
		   find $HOST_SRC/code/common  -type f -name "*.pco"| wc -l
		   print "batch: "
		   find $HOST_SRC/code/batch  -type f -name "*.pco"| wc -l
		   print "report: "
		   find $HOST_SRC/code/report  -type f -name "*.pco"| wc -l
		   print "table: "
		   find $HOST_SRC/code/table  -type f -name "*.pco"| wc -l
		   print "interface: "
		   find $HOST_SRC/code/intrface  -type f -name "*.pco"| wc -l
		   print "io: "
		   find $HOST_SRC/code/io  -type f -name "*.pco"| wc -l;;
	  o)   print "host object files:"
               find $HOST_RUN/obj -type f -name "*.o" | wc -l;;
	  sdt|wdt) 
                   print "$ext files:"
		   if [[ $ext = sdt ]]; then
			  find $HOST_SRC/include -type f -name "*.sdt" | wc -l
		   else
			  find $HOST_SRC/include -type f -name "*.wdt" | wc -l
		   fi
                   print "host include:"
		   find $HOST_SRC/include -type f -name "*.?dt" | wc -l;;
	  int|idy|cbl)
                   print "$ext files:"
		   if [[ $ext = int ]]; then
			  find $HOST_RUN/symbol -type f -name "*.int" | wc -l
		   elif [[ $ext = idy ]]; then
			  find $HOST_RUN/symbol -type f -name "*.idy" | wc -l
                   else
			  find $HOST_RUN/symbol -type f -name "*.cbl" | wc -l
		   fi
                   print "host symbol:"
		   find $HOST_RUN/symbol -type f -name "*.*" | wc -l;;
	  sl)      print "host lib:"
                   find $HOST_RUN/lib -type f -name "*.sl" | wc -l;;
	  *) if [[ -z $type ]]; then
			print "Enter parent type [dialog|comwin|help]: "
			read type
		    clear
		 fi
		 case $type in
			dialog)   print "$ext files in dialogs: "
                                  find $CLNT_SRC/dialog -type f -name "*.$ext" | wc -l;;
			comwin)   print "$ext files in comwin: "
                                  find $CLNT_SRC/comwin -type f -name "*.$ext" | wc -l;;
			help)     print "$ext files in help text:"
                                  find $CLNT_SRC/help -type f -name "*.$ext" |wc -l;;  
		 esac
   esac
elif [[ -z $ext ]]; then
   if [[ -z $type ]]; then
	  print "Enter module type [scripts|cards|io|lib|nongen|table|code|cuv|mvssfe|dialog|comwin|help|copybooks]: "
	  read type
	  clear
   fi
   case $type in 
	  scripts) print "scripts:"
                   find $HOST_BLD/control/jobs/scripts -type f | wc -l;;
	  cards)   print "cards:"
                   find $HOST_BLD/control/jobs/cards -type f | wc -l;;
	  io)      print "io copybooks:"
                   find $HOST_SRC/copy/io -type f | wc -l;;
	  lib)     print "lib copybooks:"
                   find $HOST_SRC/copy/lib -type f | wc -l;;
	  nongen)  print "nongen copybooks:"
                   find $HOST_SRC/copy/nongen -type f | wc -l;;
	  table)   print "table copybooks:"
                   find $HOST_SRC/copy/table -type f | wc -l;;
	  code)    print "code copybooks:"
                   find $HOST_SRC/copy/code -type f | wc -l;;
	  cuv)     print "cuv copybooks:"
                   find $HOST_SRC/copy/cuv -type f | wc -l;;
	  mvssfe)  print "mvs server front ends:"
                   find $HOST_SRC/code.mvs -type f | wc -l;;
      dialog)  print "dialogs:"
                   ls $CLNT_SRC/dialog | wc -l;;
      comwin)  print "common windows:"
                   ls $CLNT_SRC/comwin | wc -l;;
      help)    print "help text:"
	           find $CLNT_SRC/help -type f | wc -l;;
      copybooks) print "copybooks: "
                     find $HOST_SRC/copy -type f | wc -l;;
	  *) print "Unrecognized type: $type!"
		 prompt_usage
		 exit 1;;
   esac
fi
