#***************************************************************************
#                                                                          *
#                W I N D O W S   N T   M A K E   F I L E                   *
#                                                                          *
#    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: AZRP02                            *
#                          Generated on: Wed Jul 31 14:51:13 1996          *
#                                    by: CWOODS                            *
#                     Short Description:                                   *
#                                                                          *
#***************************************************************************

PROJ = AZRP02

!ifndef DEBUG
DEBUG = 1
!endif

CC = cl
RC = rc
LINK = link


CFLAGS_D = /c /W3 /Zp1 /Zip /Od /D "_DEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D  "WIN32" /D "FND_WIN32" /MD /Fd"$(PROJ).PDB" 
CFLAGS_R = /c /W3 /Zp1 /O2 /D "NDEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D "FND_WIN32" /MD 
LFLAGS_D = /DEBUG /DEBUGTYPE:cv /SUBSYSTEM:windows,3.10   /MAP 
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
USRLIBS  = ARCHDISP.LIB C1CFUNC.LIB CSSFUNC.LIB
ALL_LIBS = $(LIBS)   $(DLLLIBS) $(USRLIBS)

#***************************************************************************
#  Dependencies for each of the executable components
#***************************************************************************


# Make C frontend dependencies AZRP02
AZRP02_DEP =  AZRP02.sdt AZRP02.wdt



# Make C window module AZRP001X
AZRP001X_DEP = AZRP001X.c	\
		AZRP001C.h	\
		AZRP001M.h	\
		AZRP002O.h	\
		AZRP003O.h	\
		.\AZRP001.BUS	\
		.\AZDI0400.C    \
                AZRP001.aex     \
                AZRP001.h       \
                AZRP001.wmp     \
                AZRP001.gnd     \
                AZRP001.gnh     \
                AZRP02.gnz        \
                AZRP001.src

# Make C window module AZRP002X
AZRP002X_DEP = AZRP002X.c	\
		AZRP002C.h	\
		AZRP002O.h	\
		.\AZDI0400.C	\
		.\AZRP002.BUS    \
                AZRP002.aex     \
                AZRP002.h       \
                AZRP002.wmp     \
                AZRP002.gnd     \
                AZRP002.gnh     \
                AZRP02.gnz        \
                AZRP002.src

# Make C window module AZRP003X
AZRP003X_DEP = AZRP003X.c	\
		AZRP003C.h	\
		AZRP003O.h	\
		.\AZDI0400.C	\
		.\AZRP003.BUS    \
                AZRP003.aex     \
                AZRP003.h       \
                AZRP003.wmp     \
                AZRP003.gnd     \
                AZRP003.gnh     \
                AZRP02.gnz        \
                AZRP003.src



# Make RC dependencies for AZRP02
AZRP02_RCDEP = AZRP02.gnz    \
               AZRP001.dlg  \
               AZRP002.dlg  \
               AZRP003.dlg 


#***************************************************************************
#  Steps for construction of AZRP02.EXE 
#***************************************************************************
all:	.\$(PROJ).EXE

#***************************************************************************
# Compile the Front End
#***************************************************************************
.\AZRP02.obj : AZRP02.C $(AZRP02_DEP)
     $(CC) $(CFLAGS) -Fo.\AZRP02.obj AZRP02.C

#***************************************************************************
# Compile each window module
#***************************************************************************

# Make C window module AZRP001X
.\AZRP001X.obj : $(AZRP001X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\AZRP001X.obj AZRP001X.c

# Make C window module AZRP002X
.\AZRP002X.obj : $(AZRP002X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\AZRP002X.obj AZRP002X.c

# Make C window module AZRP003X
.\AZRP003X.obj : $(AZRP003X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\AZRP003X.obj AZRP003X.c


#***************************************************************************
# Compile the executable resource file
#***************************************************************************
.\AZRP02.res:   AZRP02.RC $(AZRP02_RCDEP)
   $(RC) $(RCFLAGS) $(RCDEFINES) -Fo.\AZRP02.res AZRP02.RC


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************





#***************************************************************************
# Construct the executable
#***************************************************************************

.\$(PROJ).EXE :  .\AZRP02.obj .\AZRP02.res 	\
		.\AZRP001X.obj 	\
		.\AZRP002X.obj 	\
		.\AZRP003X.obj 
    link $(LFLAGS) @<<
/OUT:.\$(PROJ).EXE
.\AZRP02.obj
      .\AZRP001X.obj
      .\AZRP002X.obj
      .\AZRP003X.obj

.\AZRP02.res
$(ALL_LIBS)

<<

