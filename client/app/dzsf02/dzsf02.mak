#***************************************************************************
#                                                                          *
#                W I N D O W S   N T   M A K E   F I L E                   *
#                                                                          *
#    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: DZSF02                            *
#                          Generated on: Fri Jan 30 15:26:37 1998          *
#                                    by: MCONNER                           *
#                     Short Description:                                   *
#                                                                          *
#***************************************************************************

PROJ = DZSF02

!ifndef DEBUG
DEBUG = 1
!endif

CC = cl
RC = rc
LINK = link


CFLAGS_D = /c /W3 /Zp1 /Zip /Od /D "_DEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D "FND_WIN32" /MD /Fd"$(PROJ).PDB" 
CFLAGS_R = /c /W3 /Zp1 /O2 /D "NDEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D "FND_WIN32" /MD 
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

LIBS     = user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib \
           ktfpsapi.lib ktfntend.lib ktfndcod.lib ktfndapi.lib ktmsgapi.lib ktddeapi.lib

NODBLIBS = kndbnul.lib
OTHLIBS  = othelibs
DLLLIBS  =
USRLIBS  = archdisp.LIB c1cfunc.LIB cssfunc.LIB
ALL_LIBS = $(LIBS)   $(DLLLIBS) $(USRLIBS)

#***************************************************************************
#  Dependencies for each of the executable components
#***************************************************************************


!INCLUDE <azvars.h>


# Make C frontend dependencies DZSF02
DZSF02_DEP =  DZSF02.sdt DZSF02.wdt



# Make C window module DZSF002X
DZSF002X_DEP = DZSF002X.c	\
		.\DZSF002C.h	\
		.\DZSF002.BUS	\
		.\AZDI0400.C    \
                DZSF002.aex     \
                DZSF002.h       \
                DZSF002.wmp     \
                DZSF002.gnd     \
                DZSF002.gnh     \
                DZSF02.gnz        \
                DZSF002.src



# Make RC dependencies for DZSF02
DZSF02_RCDEP = DZSF02.gnz    \
               DZSF002.dlg 


#***************************************************************************
#  Steps for construction of DZSF02.EXE 
#***************************************************************************
all:	.\$(PROJ).EXE

#***************************************************************************
# Compile the Front End
#***************************************************************************
.\DZSF02.obj : DZSF02.C $(DZSF02_DEP)
     $(CC) $(CFLAGS) -Fo.\DZSF02.obj DZSF02.C

#***************************************************************************
# Compile each window module
#***************************************************************************

# Make C window module DZSF002X
.\DZSF002X.obj : $(DZSF002X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZSF002X.obj DZSF002X.c


#***************************************************************************
# Compile the executable resource file
#***************************************************************************
.\DZSF02.res:   DZSF02.RC $(DZSF02_RCDEP)
   $(RC) $(RCFLAGS) $(RCDEFINES) -Fo.\DZSF02.res DZSF02.RC


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************





#***************************************************************************
# Construct the executable
#***************************************************************************

.\$(PROJ).EXE :  .\DZSF02.obj .\DZSF02.res 	\
		.\DZSF002X.obj 
    link $(LFLAGS) @<<
/OUT:.\$(PROJ).EXE
.\DZSF02.obj
      .\DZSF002X.obj

.\DZSF02.res
$(ALL_LIBS)

<<

