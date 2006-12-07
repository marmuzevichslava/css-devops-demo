#!/bin/ksh
# SCCS: mfperftree.ksh  1.8  03/15/95  12:15:29
#**************************************************************************
#	Name  		:	mfperftree
#
#	Arguments	:	<Procedure letter and #> <module>
#
#	Description	:	Creates a simple tab-indented call tree for 
#			the given source file from the point specified.  
#			Example:
#
#			"mfperftree A7700 CUBMR116"   gives:
#
#				A7700-WRITE-MRDG-STAT-REC
#					A9200-WRITE-RSAM
#						S9000-RSAM-CONTROL
#
#**************************** Revision History ****************************
# Date		Programmer		        Action/Description
# --------	--------------------- 	-----------------------------------
# 01/19/95  Abraham Palmer          Original Code
# 02/14/95	Chris Taylor		    Renamed: calltree -> mfperftree.ksh
# 02/14/95	Chris Taylor		    Now data stored in $PROD_APPL/src_info
#					                as {mod}.perf file. Now searches for
#			            		    module along predefined path.
# 03/06/95	Chris Taylor		    {mod}.perf file now in /tmp, then
#					                removed immediately
# 03/15/95 	Chris Taylor		    Supports src/... subdirs
# 09/15/95  Cynthia Ledesma         Modified directory structure
# --------	---------------------	-----------------------------------
#**************************************************************************

C1_VAR=c1

function getcalls {
	for call in $(grep "^$1" $data | cut -d " " -f 2) ; do
		tabs="$tabs\t"
		print -n $tabs
 		print $call
 		if [[ ! -z $call ]] ; then
 			getcalls $call
 		fi
		tabs=${tabs%"\t"}
	done
}

####	mfperftree.ksh main ####

start=$1
tabs=""
data=/tmp/mfp$$

# Locate source for module
#srcpath="$PROD_APPL/src/bat:$PROD_APPL/src/cmn:$PROD_APPL/src/rpt"
srcpath="$HOST_APPL/source/code/batch"
srcpath="$srcpath:$HOST_APPL/source/code/common"
srcpath="$srcpath:$HOST_APPL/source/code/io"
srcpath="$srcpath:$HOST_APPL/source/code/report"
srcpath="$srcpath:$HOST_APPL/source/code/service"
srcpath="$srcpath:$HOST_APPL/source/code/table"


#srcpath="$srcpath:$PROD_APPL/src/svc:$PROD_ARCH/src/io:$PROD_ARCH/src/svc"
srcpath="$srcpath:$HOST_APPL/source/code:$BASE_APPL/base/host/conttest/source/code/io"
#srcpath="$srcpath:$PROD_TOOL/src:$BASE_TOOL/src"
srcpath="$srcpath:$PROD_TOOL/source:$BASE_TOOL/common/source"
foundSrc=""
for srcdir in $(print $srcpath | tr ':' ' '); do
	if [[ -f $srcdir/$2.pco ]]; then
		module=$srcdir/$2.pco
		foundSrc=1
		break
	elif [[ -f $srcdir/$2.cbl ]]; then
		module=$srcdir/$2.cbl
		foundSrc=1
		break
	fi
done

# Quit if no source found
if [[ -z $foundSrc ]]; then
	print "mfperftree: source not found for $2" >&2
	return 1
fi

# Generate data file if it does not exist
print Creating data file...
#awk -f $BASE_TOOL/awk/mfperftree.awk $module > $data
awk -f $BASE_TOOL/${C1_VAR}/conv/mfperftree.awk $module > $data

# Call function to generate tree at desired level
print $(grep "^$start" $data | cut -d " " -f 1 | head -n1)
getcalls $start

rm -f $data
