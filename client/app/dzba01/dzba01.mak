#***************************************************************************
#                                                                          *
#                W I N D O W S   N T   M A K E   F I L E                   *
#                                                                          *
#    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: DZBA01                            *
#                          Generated on: Thu Jan 30 09:46:52 1997          *
#                                    by: IPEREZAR                          *
#                     Short Description:                                   *
#                                                                          *
#***************************************************************************

PROJ = DZBA01

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


# Make C frontend dependencies DZBA01
DZBA01_DEP = DZBA01B.gnb DZBA01.sdt DZBA01.wdt



# Make C window module DZBA001X
DZBA001X_DEP = DZBA001X.c	\
		DZBA01B.gnb	\
		DZBA001C.h	\
		DZBA002I.h	\
		DZBA002O.h	\
		DZBA004I.h	\
		DZBA004O.h	\
		.\AZDI0400.C	\
		.\DZBA001.BUS	\
		.\DZBA001.VLD    \
                DZBA001.aex     \
                DZBA001.h       \
                DZBA001.wmp     \
                DZBA001.gnd     \
                DZBA001.gnh     \
                DZBA01.gnz        \
                DZBA001.src

# Make C window module DZBA002X
DZBA002X_DEP = DZBA002X.c	\
		DZBA01B.gnb	\
		DZBA002C.h	\
		DZBA002I.h	\
		DZBA002O.h	\
		DZBA003I.h	\
		DZBA003O.h	\
		.\AZDI0400.C	\
		.\DZBA002.BUS    \
                DZBA002.aex     \
                DZBA002.h       \
                DZBA002.wmp     \
                DZBA002.gnd     \
                DZBA002.gnh     \
                DZBA01.gnz        \
                DZBA002.src

# Make C window module DZBA003X
DZBA003X_DEP = DZBA003X.c	\
		DZBA01B.gnb	\
		DZBA003C.h	\
		DZBA003I.h	\
		DZBA003O.h	\
		.\AZDI0400.C	\
		.\DZBA003.BUS    \
                DZBA003.aex     \
                DZBA003.h       \
                DZBA003.wmp     \
                DZBA003.gnd     \
                DZBA003.gnh     \
                DZBA01.gnz        \
                DZBA003.src

# Make C window module DZBA004X
DZBA004X_DEP = DZBA004X.c	\
		DZBA01B.gnb	\
		DZBA004C.h	\
		DZBA004I.h	\
		DZBA004O.h	\
		.\AZDI0400.C	\
		.\DZBA004.BUS    \
                DZBA004.aex     \
                DZBA004.h       \
                DZBA004.wmp     \
                DZBA004.gnd     \
                DZBA004.gnh     \
                DZBA01.gnz        \
                DZBA004.src



# Make RC dependencies for DZBA01
DZBA01_RCDEP = DZBA01.gnz    \
               DZBA001.dlg  \
               DZBA002.dlg  \
               DZBA003.dlg  \
               DZBA004.dlg 


#***************************************************************************
#  Steps for construction of DZBA01.EXE 
#***************************************************************************
all:	.\$(PROJ).EXE

#***************************************************************************
# Compile the Front End
#***************************************************************************
.\DZBA01.obj : DZBA01.C $(DZBA01_DEP)
     $(CC) $(CFLAGS) -Fo.\DZBA01.obj DZBA01.C

#***************************************************************************
# Compile each window module
#***************************************************************************

# Make C window module DZBA001X
.\DZBA001X.obj : $(DZBA001X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZBA001X.obj DZBA001X.c

# Make C window module DZBA002X
.\DZBA002X.obj : $(DZBA002X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZBA002X.obj DZBA002X.c

# Make C window module DZBA003X
.\DZBA003X.obj : $(DZBA003X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZBA003X.obj DZBA003X.c

# Make C window module DZBA004X
.\DZBA004X.obj : $(DZBA004X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZBA004X.obj DZBA004X.c


#***************************************************************************
# Compile the executable resource file
#***************************************************************************
.\DZBA01.res:   DZBA01.RC $(DZBA01_RCDEP)
   $(RC) $(RCFLAGS) $(RCDEFINES) -Fo.\DZBA01.res DZBA01.RC


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************





#***************************************************************************
# Construct the executable
#***************************************************************************

.\$(PROJ).EXE :  .\DZBA01.obj .\DZBA01.res 	\
		.\DZBA001X.obj 	\
		.\DZBA002X.obj 	\
		.\DZBA003X.obj 	\
		.\DZBA004X.obj 
    link $(LFLAGS) @<<
/OUT:.\$(PROJ).EXE
.\DZBA01.obj
      .\DZBA001X.obj
      .\DZBA002X.obj
      .\DZBA003X.obj
      .\DZBA004X.obj

.\DZBA01.res
$(ALL_LIBS)

<<

