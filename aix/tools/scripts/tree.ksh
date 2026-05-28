#!/bin/ksh
#	SCCS: tree.ksh  1.1  02/06/95  16:36:55
#**************************************************************************
#	Name  		:	tree
#
#	Arguments	:	$1 - Directory
#				$2 - [optional] maximum depth reported
#
#	Description	:
#
#	The tree script is an extremely elementary copy of the DOS tree
#	command. It produces a graphical representation of a file structure
#	using indentation and line-draw characters ( | and - ). It is
#	not currently smart enough to know when not to print a vertical 
#	connection bar. Perhaps a later version will trim the tree.
#	As it is, tree output can fairly easily be ported into documents
#	and tweaked to produce a respectable picture of the living 
#	structure.
#
#	tree relies on the find command's search alogrithm to return 
#	directory names in the proper order. This dependency upon an
#	utterly undocumented behavior of a particular HP-UX command is
#	definitely not guaranteed to be portable or to survive the
#	next HP-UX release.
#
#**************************** Revision History ****************************
# Date	   Programmer		 Action/Description
# -------- --------------------- ------------------------------------------
# 12/12/94 Chris Taylor		 Original code
# -------- --------------------- ------------------------------------------
#**************************************************************************

if [[ -d $1 ]]; then
	true
else
	print "tree: $1 not a directory"
	return 1
fi

print "directory tree for $1:"
cd $1
maxdepth=${2:-7}
for dir in $(find . -type d | grep -v "lost+found" | cut -c3- | cut -d"/" -f1-$maxdepth | uniq); do
	for list in $(print $dir | tr "\/" " "); do
		print -n "  |"
	done
	if [[ -n $list ]]; then
		printf '--%s\n' $list
	fi
done
