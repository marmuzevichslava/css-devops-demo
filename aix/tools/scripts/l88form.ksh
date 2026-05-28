#!/usr/bin/ksh -p
# form88.ksh # 1.0 # UNIX BATCH UTILITIES # HP-UX 10.10 # OCT 1997
##############################################################################
#                                                                 HP-UX 10.10
# ---------------------------------------------------------------------------
# REFORMAT COBOL 88-LEVEL DEFINITION BY REMOVING DASH FROM SEVENTH COLUMN.
# RETURN CODES:
#   00 - REFORMATING
#   01 - NO 88 LEVEL REFORMATING
#   02 - ERROR
# ---------------------------------------------------------------------------
# St.PETERSBURG, Florida                                       PLAMEN NIKITOV
##############################################################################

mt=${pn:-"rmdsh"} # message tag
integer rMar=71   # source code right margin

integer test=0    # 1 - test mode
integer rc=0      # return code
integer ec=0      # code of execution
integer a88=0     # counter for 88 level without continuation
integer oo=0      # OLD subscript
integer rr=0      # ROWS subscript
integer ol=0      # old     level
integer rl=0      # current level
integer dd=0      # level difference
integer n=0       # NEST subscript
integer i=0       # number of the input row(s)
integer cc=0      # number of the continuation line
integer c88=0     # 1 - 88 Level Continuation Processing
integer cmt=0
integer oth=0
integer sum=0
spaces="                                                                    "

typeset -L1 l1
typeset -R1 r1
typeset -L2 lvl

typeset -L5  z1
typeset -L19 z88n
typeset -L14 z88f
typeset -L27 z27
typeset -L29 z32

set -A NEST 0 7 0 6 0 8 0 10 0 12 0 14 0 16 0 18 0 20 0 22 0 24 0 26

z1=$spaces
z88f=$spaces
z88n=$spaces
z32=$spaces
z27=$spaces


##############################################################################
# COMMAND-LINE PROCESSING
##############################################################################

if [ $# -ne 1 ]
then
  print "..[$mt] $0 $*"
  print "ee[$mt] UNSUPPORTED COMMAND-LINE. EXIT."
  print "..[$mt] $0 <input>"
  exit 2
fi

if [ ! -f $1 ]
then
  print "ee[$mt] INPUT-FILE [$1] NOT-FOUND. EXIT."
  exit 2
fi

in="$1"           # input filename

#ec=`grep -c ^"      -" $in`
#if [ $ec -eq 0 ]
#then
#  #print "ee[$mt] $ec INPUT-FILE [$1] DOES NOT NEED REFORMATING. EXIT 1."
#  exit 1
#fi
 
rc=1
rm $out 2>/dev/null

while read row
do
##############################################################################
# FILE-LOOP
##############################################################################

let i=i+1
lvl=$row

if [ $test -eq 1 ]
then
  print "tt[$mt] $i [$lvl] $row"
fi

case $c88 in
   0):
     #************************************************************************
     #* GENERAL SELECTION
     #************************************************************************
     case $lvl in
       "88"):
	    r1=$row
	    if [[ "$r1" = "." ]]
	    then
	    #-----------------------------------------------------------------
	    #- 88 LEVEL WITHOUT CONTINUATION
	    #-----------------------------------------------------------------
	      xxx="$z88f $row"
              len=${#xxx}
	      if [ $len -gt $rMar ]
	      then
	        set -A ROW $row    # new (current)  row
                echo "$z88f ${ROW[0]}  ${ROW[1]} ${ROW[2]} ${ROW[3]} ${ROW[4]} ${ROW[5]}"
	      else
	        print "$z88f $row"
	      fi
	      let a88=a88+1
	    else
	    #-----------------------------------------------------------------
	    #- START OF 88 LEVEL CONTINUATION PROCESSING
	    #-----------------------------------------------------------------
	      #print "TT[$mt] $i $row"
	      set -A ROWS
	      rr=0
	      ROWS[rr]=`echo "$row" | tr "," " "`
	      c88=1
              rc=0
	    fi
	    :;;
 [0-7][0-9]):
            rl=$lvl
	    let dd=rl-ol
	    if [ $dd -gt 0 ]
            then
              let n=n+2
	      NEST[n]=$rl
            elif [ $dd -lt 0 ]
            then
	      n=2
	      while [[ "${NEST[n]}" != "0" ]] && [[ "${NEST[n]}" != "$rl" ]]
	      do
	        let n=n+2
	      done
	    fi
	    eval typeset -L${NEST[n+1]} z0
	    z0=$spaces
            xxx="$z0 $row"
            len=${#xxx}
	    if [ $len -gt $rMar ]
	    then
	      set -A ROW $row    # new (current)  row
              echo "$z0 ${ROW[0]}  ${ROW[1]} ${ROW[2]} ${ROW[3]} ${ROW[4]} ${ROW[5]}"
	    else
              echo  "$z0 $row"
	    fi
	    let oth=oth+1
            ol=$lvl
	    :;;
       "**"):
	    let cmt=cmt+1
	    echo "$z1 $row"
	    :;;
          *):
	    echo "$z27 $row"
	    :;;
     esac
     :;;
   1): 
     #************************************************************************
     #* 88 LEVEL CONTINUATION PROCESSING
     #************************************************************************
     r1=$row
     let rr=rr+1
     ROWS[rr]=`echo "$row" | tr  "," " "`
     if [ "$r1" = "." ]
     then
       #---------------------------------------------------------------------
       #- END OF 88 CONTINUATION(S)
       #---------------------------------------------------------------------
       #print "tt[$mt] $rr=${ROWS[*]}"
       c88=0
       set -A GEN ${ROWS[*]}
       rr=3
       l1="${GEN[3]}"
       if [ "$l1" = "'" ]
       then
	 dlm="'"     # CHARACTER VALUES: delimiter
	 inc=3       #                   number of the punctuations
       else
	 dlm=""      # NUMERIC VALUES
	 inc=1
       fi
       xxx=`echo "${GEN[3]}" | tr -d "'"`
       pic=${#xxx}   # VALUE LENGTH
       sum=0
       ccc=""
       line="$z88f ${GEN[0]}  ${GEN[1]} ${GEN[2]} "
       while [ $rr -lt ${#GEN[*]} ]
       do
       #-------------------------------------------------------------
       #- ALL 88 VALUES -- STARTING FROM rr=3
       #-------------------------------------------------------------
         xxx=`echo "${GEN[rr]}" | tr -d ".'-"`
	 if [ "$xxx" != "" ]
	 then
	 #...........................................................
	 #. PROCESS ONLY NOT-EMPTY ELEMENTS AFTER REMOVING . ' and -
	 #...........................................................
           len=${#xxx}
	   l1="$xxx"
           if [ $len -lt $pic ] || [ "$l1" = "T" ] || [ "$l1" = "H" ]
           then
	   #------------------ BROKEN ELEMENT ---------------------
             if [ "$thru" = "yes" ]
	     then
	       zzz="$xxx"
	     else
	       zzz="$zzz$xxx"
	     fi
	     eval typeset -L$pic vv
	     vv="THRU"
	     if [ ${#zzz} -ge $pic ] && [ "$zzz" != "$vv" ]
	     then
	     #---------------- LAST BROKEN PART -------------------
               #print "rr=$rr $dlm$zzz$dlm"    # element ready
	       len=${#zzz}
	       ll=${#line}
	       let lll=len+ll+inc
	       if [ "$zzz" = "THRU" ]
	       then
	         if [ $lll -gt $rMar ]
	         then
		   cline=${line:%,*}
		   nline=${line:##*,}
	           print "$cline,"
                   ccc=""
                   line="$z88n$nline"
                 fi
	         line="$line $zzz "
		 ccc=""
		 thru=yes
	       else
	         if [ $lll -gt 70 ]
	         then
		   if [ "$thru" = "yes" ]
		   then
		     cline=${line:%,*}
		     nline=${line:##*,}
	             print "$cline,"
                     line="$z88n$nline"
		   else
	             print "$line,"
                     line="$z88n"
		   fi
                   ccc=""
                 fi
	         line="$line$ccc$dlm$zzz$dlm"
		 ccc=","
		 thru=no
	       fi
	     #---------------- end-of0if --------------------------
	     fi
           else
	   #------------------ COMPLETED ELEMENT ------------------
             #print "rr=$rr $dlm$xxx$dlm"      # element ready
	     len=${#xxx}
	     ll=${#line}
	     let lll=len+ll+inc
	     if [ "$xxx" = "THRU" ]
	     then
	       if [ $lll -gt $rMar ]
	       then
		 cline=${line:%,*}
		 nline=${line:##*,}
	         print "$cline,"
	         #print "c=$cline n=$nline "
		 ccc=""
		 line="$z88n$nline"
	       fi
	       line="$line $xxx "
               ccc=""
	       thru=yes
	     else
	       if [ $lll -gt $rMar ]
	       then
		 if [ "$thru" = "yes" ]
		 then
		   cline=${line:%,*}
		   nline=${line:##*,}
	           print "$cline,"
                   line="$z88n$nline"
		 else
	           print "$line,"
		   line="$z88n"
		 fi
		 ccc=""
	       fi
	       line="$line$ccc$dlm$xxx$dlm"
               ccc=","
	       thru=no 
	     fi
	     zzz=""
	   #------------------ end-of-if --------------------------
	   fi
	 #.................... end-of-if ............................
         fi
         let rr=rr+1
	 if [ $rr -eq ${#GEN[*]} ]
	 then
	   print "${line}."
	   line=""
	 fi
       #---------------------- end-of-do ----------------------------
       done
     fi
     :;;

#************************************************************************
esac

############################## end-of-while ##################################
done <$in

##############################################################################
# EPILOGUE: LAST ROW IF IT IS NECESSARY
##############################################################################

############################## end-of-script #################################
exit $rc
