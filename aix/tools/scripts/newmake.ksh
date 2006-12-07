#!/bin/ksh
# SCCS: makemake.ksh  1.5  02/13/95  09:03:32
#**************************************************************************
#
#	makemake
#
#	Korn shell script to generate makefile headers
#
#	Andersen Consulting - SolutionWorks
# 
#	SCCS: makemake.ksh  1.5  02/13/95  09:03:32
# 
# 			  Date		   Programmer/Action
#  	Created:	11/21/94	Chris Taylor
# 	Modified:	12/01/94	Chris Taylor: Added INTERIM variable
#					for clean target. Removed RSAMLIBS
#					from library list. Made "SQL?" an
#					executable-only question. Reworded
#					and rearranged prompts and status bar.
#	01/31/95	Chris Taylor	Now uses ENVR_TOOL
#					to include makedefs and makeinst.
#	02/09/95	Chris Taylor	Now uses BASE_TOOL
#					to include makedefs.mak and 
#					makeinst.mak; uses PROD_xxxx vars.
#	02/13/95	Chris Taylor	Removed precompile TDM support
#       09/13/95        Cynthia Ledesma Modified directory structure
#
#**************************************************************************
# Same as makemake.ksh
makemake.ksh
exit 0

#**************************************************************************
#
# termdefs defines terminal control code variables for terminals that
# can handle them. Terminals not listed before the default action are
# not supported fully for screen clearing and line clearing. The 
# baseTerm variable is a flag indicating an unsupported terminal.
#
# The terminal control strings are typeset as constants (read-only).
#
#**************************************************************************
function termdefs {
	case $TERM in
		vt100) ;;
		vt220) ;;
		*) print -u2 "TERM $TERM not supported."; baseTerm=1; return ;;
	esac

	CLS="\033[2J"		# Clear screen
	CLL="\033[2K"		# Clear entire line
	WRP="\033[?7h"		# Line wrap on 
	NOW="\033[?7l"		# Line wrap off
}

#**************************************************************************
#
# The move function moves the cursor to the given y,x coordinates on
# the screen for supported terminals.
#
# 	Arguments	:	$1 - y position
# 					$2 - x position
#
#**************************************************************************
function move {
	if [[ -n $baseTerm ]]; then
		print
		return
	fi

	print -u2 "\033[$1;$2H"
}

#**************************************************************************
#
# showStat expects a variable argument list of yes/no flag variables.
# A value of 'x' is interpreted as undefined; 'yes' gives a positive
# return; other values are dismissed as 'no'.
#
#	Arguments	:	(variable flag list)
#
#**************************************************************************
function showStat {
	print -n "#	"
	for flag in $@; do
		if [[ $flag = 'yes' ]]; then
			print -n " (y)  "
		else
			if [[ $flag = 'x' ]]; then
				print -n " (*)  "
			else
				print -n " (n)  "
			fi
		fi
	done
}

#**************************************************************************
#
# The status function displays a summary of current flag settings, calling
# the showStat function to decode all flags.
#
#**************************************************************************
function status {
	
	print "#	 FND | SQL | Dbg | Prf | Lst | Language"

	showStat ${fndFlag:-'x'} \
		${sqlFlag:-'x'} \
		${debugFlag:-'x'} \
		${profileFlag:-'x'} \
		${listFlag:-'x'}

	case $language in
		c) langDisp=C ;;
		cobol) langDisp=COBOL ;;
		*) langDisp="*" ;;
	esac

	print " $langDisp"
}

#**************************************************************************
#
# clearDisp blanks user input area lines on supported terminals.
#
#	Arguments	:	$1 - Number of lines to clear; defaults to 15
#
#**************************************************************************
function clearDisp {
	if [[ -n $baseTerm ]]; then
		return
	fi

	numLines=${1:-'15'}
	loopCount=0

	move 6 1

	while [[ loopCount -lt numLines ]]; do
		print $CLL
		let loopCount=loopCount+1
	done

	move 6 1
}

#**************************************************************************
#
# The yesOrNo function gives a yes/no menu and validates user input.
# It prints prompts and errors to stderr. The evaluation function calls
# this function.
#
#	Arguments	:	$1 - User prompt
#
#**************************************************************************
function yesOrNo {
	PS3=$1
 	select yesNo in yes no; do
		if [[ -n $yesNo ]]; then
			return
		else
			print -u2 'Invalid selection.'
		fi
 	done
}

#**************************************************************************
#
# All of the evaluation functions (evalXxx) prompt the user for information
# about the executable to be made, setting flags for later use.
#
#**************************************************************************
function evalLanguage {
	PS3='Which language(s) will be part of the executable? '
 	select lang in C COBOL both; do
		if [[ -n $lang ]]; then
			break
		else
			print -u2 'Invalid selection.'
		fi
 	done

	language=$(print $lang | tr '[A-Z]' '[a-z]')
}

function evalFnd {
	yesOrNo 'Will the executable interface with FOUNDATION? '

	fndFlag=$yesNo
}

function evalSql {

#	If FOUNDATION is accessed, SQL libraries must also be linked.
	if [[ $fndFlag = 'yes' ]]; then
		sqlFlag=yes
		print -u2 'Including database libraries for FOUNDATION.'
		return
	fi

	yesOrNo 'Will the executable access the database? '
	sqlFlag=$yesNo
}

function evalDebug {
	yesOrNo 'Support debugging? '
	debugFlag=$yesNo
}

function evalProfile {
	yesOrNo 'Support profiler? '
	profileFlag=$yesNo
}

function evalListing {
	yesOrNo 'Should compilation produce a list file? '
	listFlag=$yesNo
}

#**************************************************************************
#
# The loadArray function prompts the user to choose from a list of
# choices, passed as the second parameter, until the user terminates 
# the loop. Each choice is added to a generic array.
#
#	Arguments	:	$1 - Explanation of list for user
#					$2 - Choices, space-separated
#
#**************************************************************************
function loadArray {

#		Display title/info for selection
	print -u2 $CLS; move 1 1 >&2; print -u2 "	$1"

#		Initialize loop flag, array, array index and prompt
	unset array
	typeset -i index=0
	loop=
	PS3='Selection? '

#		Loop get choices and adds them to array until <done> 
#		or a bogus number is chosen
	while [[ -z $loop ]]; do
		print
		select object in '<done>' $2; do
			if [[ -z $object || $object = '<done>' ]]; then
				loop=end
				break
			fi
			array[index]=$object
			let index=index+1
			print "${array[*]}"
		done
	done
}

#**************************************************************************
#
# promptUser calls user input functions and displays the flag status bar
#
#	Arguments	:	$1 - Target, if given
#
#**************************************************************************
function promptUser {
	move 2 1 >&2; print >&2; status >&2; clearDisp >&2

	if [[ $generic = 'no' ]]; then
		evalLanguage
		move 2 1 >&2; print >&2; status >&2; clearDisp >&2
		evalFnd
		move 2 1 >&2; print >&2; status >&2; clearDisp >&2
		evalSql
		move 2 1 >&2; print >&2; status >&2; clearDisp >&2
	fi

	evalDebug
	move 2 1 >&2; print >&2; status >&2; clearDisp >&2
	evalProfile
	move 2 1 >&2; print >&2; status >&2; clearDisp >&2
	evalListing
	move 2 1 >&2; print >&2; status >&2; clearDisp >&2

#		For executable makefiles, get object and library information
	if [[ $generic = 'no' ]]; then
		list=$(ls -1 *.o | grep -v "$1.o" | head -40)
		loadArray 'Working Object Files' "$list"
		workObjs="${array[*]}"

		#list=$(ls $PROD_ARCH/lib | cut -d"." -f1 | grep -v swrsam | uniq)
		list=$(ls $HOST_ARCH/source/copy/lib | cut -d"." -f1 | grep -v swrsam | uniq)
		loadArray 'Architecture Libraries' "$list"
		archLibs="${array[*]}"

		#list=$(ls $PROD_APPL/lib | cut -d"." -f1 | uniq)
		list=$(ls $HOST_APPL/runtime/lib | cut -d"." -f1 | uniq)
		loadArray 'Application Libraries' "$list"
		applLibs="${array[*]}"
	fi
}

#**************************************************************************
#
# The comment function displays a lengthy line of commented asterisks
#
#**************************************************************************
function comment {
	print -n '#'
	a=0
	while [ $a -lt 74 ]; do
		print -n "*"
		let a=a+1
	done
	print
}

#**************************************************************************
#
# The header function prints a comment header for its argument, $1
#
#	Arguments	:	$1 - Text of comment box header
#
#**************************************************************************
function header {
	comment
	print '#'
	print "#	$1"
	print '#'
	comment
}

#**************************************************************************
#
# The makeheader function prints core lines for a makefile header,
# including comments, timestamp and flag setting status bar.
#
#	Arguments	:	$1 - Name of makefile
#
#**************************************************************************
function makeheader {
	stamp=$(date)
	comment
	print "#"
	print "#	Makefile header	: "$1
	print "#"
	print "#	Generated on	: "$stamp
	print "#"
	print "#	Generated by	: "$LOGNAME
	print "#"
	status
	print "#"
	comment
	print

	header 'Global variable definitions'
	#print 'include $(BASE_TOOL)/mak/makedefs.mak'
	print 'include $(BASE_TOOL)/common/source/makedefs.mak'
	print
}

#**************************************************************************
#
# The prepfile function checks for a pre-existing makefile, giving 
# an opportunity for user prompting in the future; currently, the
# file is removed with a message and a new file is created.
#
#	Arguments	:	$1 - name of target object (no suffix)
#
#**************************************************************************

function prepfile {
	if [[ -a $1 ]]; then
		print "Overwriting previous makefile $1"
		rm $1
	fi

    makeheader $1 > $1
}

#**************************************************************************
#
# groupFlagsExe defines the EXEFLAGS variable (flags used to compile the
# executable) by grouping together selected flag variables defined in
# the global definitions file.
#
#	Arguments	:	$1 - Name of executable
#
#	The following flags are assumed to be defined:
# 		DEBUGFLAG
# 		PICOBJFLAG
# 		GLBLFLAGSC
# 		GLBLFLAGSCBL
# 		LISTFLAGC
# 		LISTFLAGCBL
# 		PROFILERFLAG
#
#**************************************************************************
function groupFlagsExe {
	header 'Flags for executable creation'
	print -n 'EXEFLAGS		='

	if [[ $debugFlag = 'yes' ]]; then
		print -n ' $(DEBUGFLAG)'
	else
		print -n ' $(PICOBJFLAG)' 
	fi

	if [[ $language = 'c' ]]; then
		print -n ' $(GLBLFLAGSC)'
	else
		print -n ' -x $(GLBLFLAGSCBL)'
	fi

	if [[ $listFlag = 'yes' ]]; then
		if [[ $language = 'cobol' ]]; then
			print -n ' $(LISTFLAGCBL)'
		else
			print -n ' $(LISTFLAGC)'
		fi
	fi

	if [[ $profileFlag = 'yes' ]]; then
		print -n ' $(PROFILERFLAG)'
	fi
	print
	print
}

#**************************************************************************
#
# groupFlagsC defines CFLAGS, the flags used to compile C source code to
# the object stage.
#
#	Arguments	:	$1 - Name of executable
#
#	The following flags are assumed to be defined:
# 		DEBUGFLAG
# 		PICOBJFLAG
# 		GLBLFLAGSC
# 		LISTFLAGC
# 		PROFILERFLAG
#
#**************************************************************************
function groupFlagsC {
	header 'C object compilation flags'
	print -n 'CFLAGS			='

#		These flags are mutually exclusive
	if [[ $debugFlag = 'yes' ]]; then
		print -n ' $(DEBUGFLAG)'
	else
		print -n ' $(PICOBJFLAG)'
	fi

	print -n ' -c $(GLBLFLAGSC)'

	if [[ $listFlag = 'yes' ]]; then
		print -n ' $(LISTFLAGC)'
	fi

	if [[ $profileFlag = 'yes' ]]; then
		print -n ' $(PROFILERFLAG)'
	fi
	print
	print
}

#**************************************************************************
#
# groupFlagsCbl defines CBLFLAGS, the flags used to compile C source code to
# the object stage.
#
#	Arguments	:	$1 - Name of executable
#
#	The following flags are assumed to be defined:
# 		DEBUGFLAG
#		ANIMFLAGCBL
# 		PICOBJFLAG
# 		GLBLFLAGSCBL
# 		LISTFLAGCBL
# 		PROFILERFLAG
#
#**************************************************************************
function groupFlagsCbl {
	header 'COBOL object compilation flags'
	print -n 'CBLFLAGS		='

#		Debug and PIC object flags are mutually exclusive
	if [[ $debugFlag = 'yes' ]]; then
		print -n ' $(DEBUGFLAG)'
		print -n ' $(ANIMFLAGCBL)'
	else
		print -n ' $(PICOBJFLAG)'
	fi

	print -n ' -cx $(GLBLFLAGSCBL)'

	if [[ $listFlag = 'yes' ]]; then
		print -n ' $(LISTFLAGCBL)'
	fi

	if [[ $profileFlag = 'yes' ]]; then
		print -n ' $(PROFILERFLAG)'
	fi
	print
	print
}

#**************************************************************************
#
# groupLibraries writes variable definitions for the libraries to be
# linked to the executable. The libraries are from earlier user input.
#
#	Arguments	:	$1 - Name of executable
#
#	The following variables are assumed to be defined:
#		FNDLIBS
#		ISAMLIBS
#		ORALIBS
#		SYSLIBS
#
#**************************************************************************
function groupLibraries {
	header 'Libraries'

	print -n 'ARCHLIBS		='

	for library in $archLibs; do
		print " \\"
		print -n "			-l${library#lib}"
	done
	print
	print

	print -n 'APPLLIBS		='

	for library in $applLibs; do
		print " \\"
		print -n "			-l${library#lib}"
	done
	print
	print

	print 'LIBRARIES		=\\'

	print '			$(APPLLIBS) \\'
	print '			$(ARCHLIBS) \\'

	if [[ $fndFlag = 'yes' ]]; then
		print '			$(FNDLIBS) \\'
	fi

	print '			$(ISAMLIBS) \\'

	if [[ $sqlFlag = 'yes' ]]; then
		print '			$(ORALIBS) \\'
	fi

	print '			$(SYSLIBS)'
	print
}

#**************************************************************************
#
# groupMisc writes variable definitions for various purposes.
#
#	Arguments	:	$1 - Name of executable
#
#		Executable only (non-generic)
#	OUTPUT: Name of executable
#	OUTPUTOBJ: Executable's object file
#	COMPILE: Compiler invoked as front end to linker
#		Generic
#	LTYPE: Oracle precompiler list file mode
#	OBJTYPE: Reminds user of object type, debuggable or PIC
#	INTERIM: List of suffixes to be scrubbed by "clean" target
#
#**************************************************************************
function groupMisc {

	if [[ $generic = 'no' ]]; then
		header 'Executable instruction definitions'
		print "OUTPUT			=$1"
		print "OUTPUTOBJ		=$1.o"

		if [[ $language = 'c' ]]; then
			print 'COMPILE			=$(COMPILEC)'
		else
			print 'COMPILE			=$(COMPILECBL)'
		fi
		print
	fi

	if [[ $listFlag = 'yes' ]]; then
		print 'ORALIST			=LTYPE=LONG'
	else
		print 'ORALIST			=LTYPE=NONE'
	fi
	print

	header 'Object type'
	if [[ $debugFlag = 'yes' ]]; then
		print 'OBJTYPE			=debuggable'
	else
		print 'OBJTYPE			=PIC'
	fi
	print

	header 'Suffix list for removal by "clean" target'
	print 'INTERIM			=*.int *.idy *.csi'
	print
}

#**************************************************************************
#
# The groupWorkObjs function defines a variable for user-specified
# object files in the current working directory needed by the 
# executable. The objects were specified by the user earlier.
#
#	Arguments	:	$1 - Name of executable
#
#**************************************************************************
function groupWorkObjs {
	header 'Working Objects'
	print -n 'WORKOBJS		='

	for object in $workObjs; do
		print \\
		print -n "			$object"
	done
	print
	print
}

#**************************************************************************
#
# The executableInst function builds the instruction lines to link
# an executable, tying together all flags, paths and libraries.
#
#	Arguments	:	$1 - Name of executable
#
#**************************************************************************
function executableInst {
	header 'Executable Instructions'

	print '$(OUTPUT) : $(WORKOBJS) $(OUTPUTOBJ)'
	print '	@echo "Linking $@..."'
	print -n '	@$(COMPILE) $(EXEFLAGS) $(OUTPUTOBJ) $(WORKOBJS)'

	if [[ $language = 'c' ]]; then
		print ' $(INCDIRS) \\'
	else
		print ' \\'
	fi

	print '	-o $(OUTPUT) $(LDFLAGS) $(LIBDIRS) $(LIBRARIES)'
	print
}

#**************************************************************************
#
# buildfile is a controlling function, calling the individual 
# build components conditionally in a logical sequence with output
# redirected to the makefile.
#
#	Arguments	:	$1 - Executable target
#
#**************************************************************************
function buildfile {

	if [[ $generic = 'no' ]]; then
		groupFlagsExe $1 >> $outfile
	fi

	groupFlagsC $1 >> $outfile
	groupFlagsCbl $1 >> $outfile

	if [[ $generic = 'no' ]]; then
		groupLibraries $1 >> $outfile
	fi

	groupMisc $1 >> $outfile

	if [[ $generic = 'no' ]]; then
		groupWorkObjs $1 >> $outfile
		executableInst $1 >> $outfile
	fi
}

#**************************************************************************
#
# The wrapfile function concludes the makefile, adding lines to 
# include common instructions for COBOL and C programs.
#
#	Arguments	:	$1 - Name of executable
#
#**************************************************************************
function wrapfile {
	header 'Common Instructions'
	#print 'include $(BASE_TOOL)/mak/makeinst.mak'
	print 'include $(BASE_TOOL)/common/source/makeinst.mak'
}

#**************************************************************************
#
# MAIN SHELL BODY
#
#**************************************************************************
{
	termdefs

	print $CLS
	move 1 1
	print '  Makefile Generator - (c) 1994 Andersen Consulting - All rights reserved.'

	if [[ -z "$1" ]]; then
		outfile=Makefile
		generic=yes
		language=both
		print 'Producing generic makefile'
	else
		outfile=$1.mak
		generic=no
		print 'Producing makefile for executable '$1 
	fi

	promptUser $1

	prepfile $outfile

	buildfile $1

	wrapfile $1 >> $outfile
}
