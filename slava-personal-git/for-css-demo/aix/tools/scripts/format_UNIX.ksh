#!/bin/ksh
# SCCS: %M%  %I%  %G%  %U%
###############################################################################
#
# <format_UNIX.ksh>
#
# Formats a Mainframe cobol file to the specifications of Microfocus Cobol.
# Strips out the  characters and splits out the code between lines 1 and 72 
# and then writes them back to the original file.  Saves the original file as 
# <file>.old
#
# Andersen Consulting - SolutionWorks
# 
# Coder         Date     Action
# ------------- -------- ------------------------------------------------
# Marc Danneels	06/12/95 Original code.
# Marc Danneels	10/12/95 Removed the cut 1-72.  This was primarily used for COBOL conversion.
#
###############################################################################
file=$1

cp $file $file.old
sed -f $BASE_TOOL/common/host/data/stripM.cmd $file > $$
mv $$ $file
