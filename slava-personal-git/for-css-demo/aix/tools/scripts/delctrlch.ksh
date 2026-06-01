#******************************************************************************
#
#	<d2u.ksh>
#
#	Converts a DOS type file to UNIX ( Strips out the 's from the file )
#
#	Andersen Consulting - SolutionWorks
# 
#	Coder:          Date		Action
#	Marc Danneels   09/08/95    Original code.
#       Warren Ratcliff 09/16/95    Adapted to delete ^K characters...
#
#
#******************************************************************************

sed s///g $1 > $$

mv $$ $1
