#***************************************************************************
#                                                                          
#                     U N I X   M A K E   F I L E                            
#                                                                          
#   (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.
#                                                                          
#***************************************************************************
#                                                                          
#                    Make file for: dzlm51  
#                     Generated on: Tue Oct 22 17:24:02 1996
#                               by: IPEREZAR            
#                Short Description: 
#
#***************************************************************************

#***************************************************************************
# Make sure the applicable environment variables are set correctly:
#
# FNDROOT = your Foundation software directory
# FNDUSERLIB = location of user libraries
#
# ORACLE_HOME     = your Oracle software directory
# INFORMIXDIR     = your Informix software directory
# INFORMIXCOBTYPE = mf2
# INFORMIXCOB     = cob
#***************************************************************************

#***************************************************************************
# C and COBOL compile flags for HP-UX
#***************************************************************************
CC              = cc
DEBUG           = -g
CCFLAGS         = $(DEBUG) -I$(FNDROOT)/include -IL:\INCLUDE/ -I./ -D_HPUX_SOURCE -DFND_HPUX \
                  -Dfnd_hp -c -Aa $(COMPILEINFORMIX)

COMPILEINFORMIX = -I$(INFORMIXDIR)/incl/esql
COMPILEORACLE   =
COMPILENODB     =

#   USRLIBS         = -larchdisp -lc1cfunc -lcssfunc

#***************************************************************************
# Link flags
#***************************************************************************


LN              = cc

LNINFORMIX      = $(INFORMIXDIR)/bin/esql

LINKNODB        = -Wl,+s,-a,default \
                  -L$(FNDROOT)/lib/libfcp.sl \
                  -L$(FNDROOT)/lib/libdbnul.sl\
                  -L$(FNDROOT)/lib/libsec.sl \
                  -L/usr/lib -lisam -lm  

LINKINFORMIX    = -Wl,+s,-a,default \
                  -L$(FNDROOT)/lib -lfcp -ldbinf -lsec \
                  -L/sw/software/informix/lib -l:libisam.a \
           	  -L/sw/software/informix/lib/esql/libgen.sl \
           	  -L/sw/software/informix/lib/esql/libsql.sl \
           	  -L/sw/software/informix/lib/esql/libos.sl 




#*****************************************************************************
# Link object files to create the executable
#*****************************************************************************
./dzlm51 : ./dzlm51.o 	\
	./tadb001u.o \
	./dzlockfuncs.o \
	./dzclm01.o 
	$(LNINFORMIX) $(LNFLAGS) -o ./dzlm51 ./dzlm51.o ./tadb001u.o \
	./dzclm01.o  ./dzlockfuncs.o \
	$(LINKINFORMIX)

#*****************************************************************************
# Compile the UNIX C Front End
#*****************************************************************************
./dzlm51.o : dzlm51.c   dzlm51.sdt dzlm51.wdt
	$(CC) $(CCFLAGS) dzlm51.c -o ./dzlm51.o

#*****************************************************************************
# Compile each UNIX service
#*****************************************************************************

# Compile C service dzclm01
./dzclm01.o : dzclm01.c	\
		dzclm01i.h      \
		dzclm01o.h
	$(CC) $(CCFLAGS) dzclm01.c -o ./dzclm01.o

# Compile C module tadb001u
./tadb001u.o : tadb001u.c      \
		tadb001.h      \
                taem001.h      \
		tadf001.h
	$(CC) $(CCFLAGS) tadb001u.c -o ./tadb001u.o


# Compile C module dzlockfuncs
./dzlockfuncs.o : dzlockfuncs.c \
		  dzerr01.h
	$(CC) $(CCFLAGS) dzlockfuncs.c -o ./dzlockfuncs.o

#*****************************************************************************
# Compile initialization and/or termination modules
#*****************************************************************************


#*****************************************************************************
# Use SQL preprocessor to precompile all modules
#*****************************************************************************
# Precompile module dzclm01
dzclm01.c : dzclm01.ec 
	esql include=$(INFORMIXDIR)/incl -e -g dzclm01.ec

# Precompile module tadb001u
tadb001u.c : tadb001u.ec 
	esql include=$(INFORMIXDIR)/incl -e -g tadb001u.ec

# Precompile module dzlockfuncs
dzlockfuncs.c : dzlockfuncs.ec 
	esql include=$(INFORMIXDIR)/incl -e -g dzlockfuncs.ec

