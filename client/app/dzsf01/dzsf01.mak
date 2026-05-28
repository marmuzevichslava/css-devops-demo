#***************************************************************************
#                                                                          *
#                W I N D O W S   N T   M A K E   F I L E                   *
#                                                                          *
#    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: DZSF01                            *
#                          Generated on: Wed Feb 04 07:23:39 1998          *
#                                    by: MCONNER                           *
#                     Short Description:                                   *
#                                                                          *
#***************************************************************************

PROJ = DZSF01

!ifndef DEBUG
DEBUG = 1
!endif

CC = cl
RC = rc
LINK = link


CFLAGS_D = /c /W3 /Zp1 /Zip /Od /D "_DEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D "FND_WIN32" /MD /Fd"$(PROJ).PDB" /D "_USE_32BIT_TIME_T"
CFLAGS_R = /c /W3 /Zp1 /O2 /D "NDEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D "FND_WIN32" /MD /D "_USE_32BIT_TIME_T"
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


# Make C frontend dependencies DZSF01
DZSF01_DEP =  DZSF01.sdt DZSF01.wdt



# Make C window module DZSF001X
DZSF001X_DEP = DZSF001X.c	\
		.\DZSF001C.h	\
		.\AZDI0400.C	\
		.\DZSF001.BUS    \
                DZSF001.aex     \
                DZSF001.h       \
                DZSF001.wmp     \
                DZSF001.gnd     \
                DZSF001.gnh     \
                DZSF01.gnz        \
                DZSF001.src



# Make RC dependencies for DZSF01
DZSF01_RCDEP = DZSF01.gnz    \
               DZSF001.dlg 


#***************************************************************************
#  Steps for construction of DZSF01.EXE 
#***************************************************************************
all:	.\$(PROJ).EXE

#***************************************************************************
# Compile the Front End
#***************************************************************************
.\DZSF01.obj : DZSF01.C $(DZSF01_DEP)
     $(CC) $(CFLAGS) -Fo.\DZSF01.obj DZSF01.C

#***************************************************************************
# Compile each window module
#***************************************************************************

# Make C window module DZSF001X
.\DZSF001X.obj : $(DZSF001X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZSF001X.obj DZSF001X.c


#***************************************************************************
# Compile the executable resource file
#***************************************************************************
.\DZSF01.res:   DZSF01.RC $(DZSF01_RCDEP)
   $(RC) $(RCFLAGS) $(RCDEFINES) -Fo.\DZSF01.res DZSF01.RC


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************





#***************************************************************************
# Construct the executable
#***************************************************************************

.\$(PROJ).EXE :  .\DZSF01.obj .\DZSF01.res 	\
		.\DZSF001X.obj 
    link $(LFLAGS) @<<
/OUT:.\$(PROJ).EXE
.\DZSF01.obj
      .\DZSF001X.obj

.\DZSF01.res
$(ALL_LIBS)

<<

