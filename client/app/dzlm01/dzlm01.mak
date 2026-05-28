#***************************************************************************
#                                                                          *
#                W I N D O W S   N T   M A K E   F I L E                   *
#                                                                          *
#    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: DZLM01                            *
#                          Generated on: Tue Oct 29 09:37:55 1996          *
#                                    by: IPEREZAR                          *
#                     Short Description:                                   *
#                                                                          *
#***************************************************************************

PROJ = DZLM01

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


# Make C frontend dependencies DZLM01
DZLM01_DEP = DZLM01B.gnb DZLM01.sdt DZLM01.wdt



# Make C window module DZLM001X
DZLM001X_DEP = DZLM001X.c	\
		DZLM01B.gnb	\
		DZLM001C.h	\
		DZCLM01I.h	\
		DZCLM01O.h	\
		DZLM01M.h	\
		.\DZLM001.BUS	\
		.\AZDI0400.C    \
                DZLM001.aex     \
                DZLM001.h       \
                DZLM001.wmp     \
                DZLM001.gnd     \
                DZLM001.gnh     \
                DZLM01.gnz        \
                DZLM001.src



# Make RC dependencies for DZLM01
DZLM01_RCDEP = DZLM01.gnz    \
               DZLM001.dlg 


#***************************************************************************
#  Steps for construction of DZLM01.EXE 
#***************************************************************************
all:	.\$(PROJ).EXE

#***************************************************************************
# Compile the Front End
#***************************************************************************
.\DZLM01.obj : DZLM01.C $(DZLM01_DEP)
     $(CC) $(CFLAGS) -Fo.\DZLM01.obj DZLM01.C

#***************************************************************************
# Compile each window module
#***************************************************************************

# Make C window module DZLM001X
.\DZLM001X.obj : $(DZLM001X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZLM001X.obj DZLM001X.c


#***************************************************************************
# Compile the executable resource file
#***************************************************************************
.\DZLM01.res:   DZLM01.RC $(DZLM01_RCDEP)
   $(RC) $(RCFLAGS) $(RCDEFINES) -Fo.\DZLM01.res DZLM01.RC


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************





#***************************************************************************
# Construct the executable
#***************************************************************************

.\$(PROJ).EXE :  .\DZLM01.obj .\DZLM01.res 	\
		.\DZLM001X.obj 
    link $(LFLAGS) @<<
/OUT:.\$(PROJ).EXE
.\DZLM01.obj
      .\DZLM001X.obj

.\DZLM01.res
$(ALL_LIBS)

<<

