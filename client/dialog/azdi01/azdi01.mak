#***************************************************************************
#                                                                          *
#                W I N D O W S   N T   M A K E   F I L E                   *
#                                                                          *
#                Copyright (C) 1994, Andersen Consulting.                  *
#                          All rights reserved.                            *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: AZDI01                            *
#                          Generated on: Mon Feb 20 10:11:24 1995          *
#                                    by: FGANTER                           *
#                                                                          *
#***************************************************************************

PROJ = AZDI01

!ifndef DEBUG
DEBUG = 1
!endif

CC = cl
RC = rc
LINK = link

CFLAGS_D = /c /W3 /Zip /Od /D "_DEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D "FND_WIN32" /MD /Fd"$(PROJ).PDB" 
CFLAGS_R = /c /W3 /Zp /D "NDEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D "FND_WIN32" /MD 
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

LIBS     = user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ktfpsapi.lib ktfntend.lib ktfndcod.lib ktfndapi.lib ktmsgapi.lib ktddeapi.lib

OTHLIBS  = othelibs
DLLLIBS  =
USRLIBS  = c1cfunc.LIB archdisp.LIB
ALL_LIBS = $(LIBS)   $(DLLLIBS) $(USRLIBS)

#***************************************************************************
#  Dependencies for each of the executable components
#***************************************************************************


# Make C frontend dependencies AZDI01
AZDI01_DEP =  AZDI01.sdt AZDI01.wdt


# Make C window module AZDI001X
AZDI001X_DEP = AZDI001X.c    \
#                AZDI001.aex     \
#                AZDI001.h       \
                AZDI001.wmp     \
                AZDI001.gnd     \
                AZDI001.gnh     \
                AZDI01.gnz        \
                AZDI001.src



# Make RC dependencies for AZDI01
AZDI01_RCDEP = AZDI01.gnz    \
               AZDI001.dlg 


#***************************************************************************
#  Steps for construction of AZDI01.EXE 
#***************************************************************************
all:	.\$(PROJ).EXE

#***************************************************************************
# Compile the Front End
#***************************************************************************
.\AZDI01.obj : AZDI01.C $(AZDI01_DEP)
     $(CC) $(CFLAGS) -Fo.\AZDI01.obj AZDI01.C

#***************************************************************************
# Compile each window module
#***************************************************************************

# Make C window module AZDI001X
.\AZDI001X.obj : $(AZDI001X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\AZDI001X.obj AZDI001X.c


#***************************************************************************
# Compile the executable resource file
#***************************************************************************
.\AZDI01.res:   AZDI01.RC $(AZDI01_RCDEP)
   $(RC) $(RCFLAGS) $(RCDEFINES) -Fo.\AZDI01.res AZDI01.RC

#***************************************************************************
# Compile each service module
#***************************************************************************


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************





#***************************************************************************
# Construct the executable
#***************************************************************************

.\$(PROJ).EXE :  .\AZDI01.obj .\AZDI01.res 	\
		.\AZDI001X.obj 
    link $(LFLAGS) @<<
/OUT:.\$(PROJ).EXE
.\AZDI01.obj
      .\AZDI001X.obj

.\AZDI01.res
$(ALL_LIBS)

<<

