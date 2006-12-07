#!/bin/ksh
#******************************************************************************
#
#   Tool Name:    bite_cbs.ksh
#   Version:      1.0
#   Description:  Processes all copybooks from the UNIX tmaps directory.  
#                 It truncates the .CPY extension & removes the ^M characters.
#
#   Andersen Consulting - SolutionWorks
# 
#   Coder:          Date:
#   Khim Theng      04/30/96    
#******************************************************************************

for file in *.@(CPY|cpy); do
  delctrlch.ksh ${file}
  pathname=`dirname ${file}`
  filename=`basename ${file}`
  newname=`print ${filename} | cut -d"." -f1`
  newfile=${pathname}/${newname}
  mv ${file} ${newfile}
  if [[ $? = 0 ]]; then
     print ${newname}
  fi
done
rm EXTRACT.* GNRTNMSG.*


#*****************************************************************************
#
# Tool Name:	filler.ksh
#
# Description: 	Bitesizes all copybooks specified, returns the bitesize,
#               filler, and occurs (only if Alr is something other than 100).
#
# Andersen Consulting - SolutionWorks
#	
# Coder: Khim Theng 
# Date:  06/06/96
#*****************************************************************************

USAGE="usage: filler.ksh argv1"
integer sum
integer asize
integer hsize
integer ssize
integer lsize
integer occurs
integer fillz
integer fill

if (($# >0))
then
	book=$1
else
	print -n 'Enter the i/o module to be bitesized: '
	read book
fi

typeset -u book
convert "$book"H

bitesize.ksh "tmp" > bite
grep +0 bite > H
rm tmp

bitesize.ksh "$book"A > bite
grep +0 bite >A 

convert "$book"S
bitesize.ksh "tmp" >bite
grep +0 bite >S

exec 8<A
read -u8 aplus

exec 9<H
read -u9 hplus

exec 7<S
read -u7 splus

asize=$aplus
hsize=$hplus
ssize=$splus

clear

print -n "****************** $book ******************"
print ''
print ''
print -n "Alr  = "
print -n $asize
print -n "\tfiller =  "
((fill = 22800-asize*100))
  if (($fill <= 0)) 
  then     
      ((occurs = 22800 / asize))
      ((fillz = asize * occurs)) 
      ((fill = 22800 - fillz))
      print -n $fill 
      print -n "\toccurs = "
      print -n $occurs
      
  else
         print -n $fill
  fi


print ''
print -n "High = "
print -n $hsize
((lsize=hsize))

print -n "\tfiller =  "
((hsize=150-hsize))
print -n $hsize


print ''
print -n "Low  = " 
print -n $lsize
print -n "\tfiller =  "
((lsize=150-lsize))
print -n $lsize
print ''
print -n "Dyn  = "
print -n $ssize
print -n "\tfiller =  "
((ssize=180-ssize))
print -n $ssize
print ''
print ''
print "*********************************************"
print ''
print ''

rm A
rm H
rm S
rm tmp
rm bite
rm SWBS*
