#***************************************************************************
#                                                                          *
#                W I N D O W S   N T   M A K E   F I L E                   *
#                                                                          *
#                Copyright (C) 1994, Andersen Consulting.                  *
#                          All rights reserved.                            *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: DZSM01                            *
#                          Generated on: Mon Jan 16 14:01:47 1995          *
#                                    by: ABURDEN                           *
#                                                                          *
#***************************************************************************

PROJ = DZSM01

!ifndef DEBUG
DEBUG = 1
!endif

CC = cl
RC = rc
LINK = link

CFLAGS_D = /c /W3 /Zip /Od /D "_DEBUG" /D "_X86_" /D "STRICT" /D "FND_WIN32" /D "CPM" /MD /Fd"$(PROJ).PDB" 
CFLAGS_R = /c /W3 /Zp /O2 /D "NDEBUG" /D "_X86_" /D "STRICT" /D "FND_WIN32" /MD 
LFLAGS_D = /DEBUG /DEBUGTYPE:cv /SUBSYSTEM:windows   /MAP
LFLAGS_R = /SUBSYSTEM:windows  
RCDEFINES_D = -d_DEBUG -dFND_WIN32
RCDEFINES_R = -dNDEBUG -dFND_WIN32

!if "$(DEBUG)" == "1"
CFLAGS = $(CFLAGS_D)
LFLAGS = $(LFLAGS_D)
RCDEFINES = $(RCDEFINES_D)
!else
CFLAGS = $(CFLAGS_R)
LFLAGS = $(LFLAGS_R)
RCDEFINES = $(RCDEFINES_R)
!endif
RCFLAGS = -r

#LIBS     = user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib olecli32.lib olesvr32.lib shell32.lib ktfpsapi.lib ktfntend.lib ktfndcod.lib ktfndapi.lib ktmsgapi.lib ktddeapi.lib pmfapi32.lib

LIBS     = user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib \
           ktfpsapi.lib ktfntend.lib ktfndcod.lib ktfndapi.lib ktmsgapi.lib ktddeapi.lib pmfapi32.lib

OTHLIBS  = othelibs
DLLLIBS  =
USRLIBS  = c1cfunc.LIB cssfunc.LIB archdisp.LIB
ALL_LIBS = $(LIBS)   $(DLLLIBS) $(USRLIBS)

#***************************************************************************
#  Dependencies for each of the executable components
#***************************************************************************


# Make C frontend dependencies DZSM01
DZSM01_DEP =  DZSM01.sdt DZSM01.wdt


# Make C window module DZSM001X
DZSM001X_DEP = DZSM001X.c	\
		.\DZSM001.BUS    \
                DZSM001.aex     \
                DZSM001.h       \
                DZSM001.wmp     \
                DZSM001.gnd     \
                DZSM001.gnh     \
                DZSM01.gnz        \
                DZSM001.src



# Make RC dependencies for DZSM01
DZSM01_RCDEP = DZSM01.gnz    \
               DZSM001.dlg 


#***************************************************************************
#  Steps for construction of DZSM01.EXE 
#***************************************************************************
all:	.\$(PROJ).EXE

#***************************************************************************
# Compile the Front End
#***************************************************************************
.\DZSM01.obj : DZSM01.C $(DZSM01_DEP)
     $(CC) $(CFLAGS) /IS:\INCLUDE\ -Fo.\DZSM01.obj DZSM01.C

#***************************************************************************
# Compile each window module
#***************************************************************************

# Make C window module DZSM001X
.\DZSM001X.obj : $(DZSM001X_DEP)
    $(CC) $(CFLAGS) /IS:\INCLUDE\ /I.\ /Fo.\DZSM001X.obj DZSM001X.c


#***************************************************************************
# Compile the executable resource file
#***************************************************************************
.\DZSM01.res:   DZSM01.RC $(DZSM01_RCDEP)
   $(RC) $(RCFLAGS) $(RCDEFINES) -Fo.\DZSM01.res DZSM01.RC

#***************************************************************************
# Compile each service module
#***************************************************************************


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************





#***************************************************************************
# Construct the executable
#***************************************************************************

.\$(PROJ).EXE :  .\DZSM01.obj .\DZSM01.res 	\
		.\DZSM001X.obj 
    link $(LFLAGS) @<<
/OUT:.\$(PROJ).EXE
.\DZSM01.obj
      .\DZSM001X.obj

.\DZSM01.res
$(ALL_LIBS)

<<

