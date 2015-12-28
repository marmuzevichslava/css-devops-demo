#***************************************************************************
#                                                                          *
#                W I N D O W S   N T   M A K E   F I L E                   *
#                                                                          *
#    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: ATDW01                            *
#                          Generated on: Tue Jul 30 00:57:00 1996          *
#                                    by: CWOODS                            *
#                     Short Description: AZCD01                            *
#                                                                          *
#***************************************************************************

PROJ = ATDW01

!ifndef DEBUG
DEBUG = 1
!endif

CC = cl
RC = rc
LINK = link


CFLAGS_D = /c /W3 /Zp1 /Zip /Od /D "_DEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D  "WIN32" /D "_USE_32BIT_TIME_T" /D "FND_WIN32" /MD /Fd"$(PROJ).PDB" 
CFLAGS_R = /c /W3 /Zp1 /O2 /D "NDEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D "_USE_32BIT_TIME_T" /D "FND_WIN32" /MD 
LFLAGS_D = /DEBUG /DEBUGTYPE:cv /SUBSYSTEM:windows,3.10   /MAP 
LFLAGS_R = /SUBSYSTEM:windows,3.10  
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
USRLIBS  = ARCHDISP.LIB C1CFUNC.LIB CSSFUNC.LIB tcppipe.lib
ALL_LIBS = $(LIBS)   $(DLLLIBS) $(USRLIBS)

#***************************************************************************
#  Dependencies for each of the executable components
#***************************************************************************


# Make C frontend dependencies ATDW01
ATDW01_DEP = ATDW01B.gnb ATDW01.sdt ATDW01.wdt



# Make C window module ATDW001
ATDW001_DEP = ATDW001.c	\
		ATDW01B.gnb	\
		ATDW001C.h	\
		.\AZDI0400.C	\
		.\ATDW001.BUS    \
                ATDW001.aex     \
                ATDW001.h       \
                ATDW001.wmp     \
                ATDW001.gnd     \
                ATDW001.gnh     \
                ATDW01.gnz        \
                ATDW001.src

# Make C window module ATDW002
ATDW002_DEP = ATDW002.c	\
		ATDW01B.gnb	\
		ATDW002C.h	\
		.\AZDI0400.C	\
		.\ATDW002.BUS    \
                ATDW002.aex     \
                ATDW002.h       \
                ATDW002.wmp     \
                ATDW002.gnd     \
                ATDW002.gnh     \
                ATDW01.gnz        \
                ATDW002.src

# Make C window module ATDW003
ATDW003_DEP = ATDW003.c	\
		ATDW01B.gnb	\
		ATDW003C.h	\
		.\AZDI0400.C	\
		.\ATDW003.BUS    \
                ATDW003.aex     \
                ATDW003.h       \
                ATDW003.wmp     \
                ATDW003.gnd     \
                ATDW003.gnh     \
                ATDW01.gnz        \
                ATDW003.src

# Make C window module ATDW004
ATDW004_DEP = ATDW004.c	\
		ATDW01B.gnb	\
		ATDW004C.h	\
		.\AZDI0400.C	\
		.\ATDW004.BUS    \
                ATDW004.aex     \
                ATDW004.h       \
                ATDW004.wmp     \
                ATDW004.gnd     \
                ATDW004.gnh     \
                ATDW01.gnz        \
                ATDW004.src

# Make C window module ATDW006
ATDW006_DEP = ATDW006.c	\
		ATDW01B.gnb	\
		ATDW006C.h	\
		.\AZDI0400.C	\
		.\ATDW006.BUS    \
                ATDW006.aex     \
                ATDW006.h       \
                ATDW006.wmp     \
                ATDW006.gnd     \
                ATDW006.gnh     \
                ATDW01.gnz        \
                ATDW006.src



# Make RC dependencies for ATDW01
ATDW01_RCDEP = ATDW01.gnz    \
               ATDW001.dlg  \
               ATDW002.dlg  \
               ATDW003.dlg  \
               ATDW004.dlg  \
               ATDW006.dlg 


#***************************************************************************
#  Steps for construction of ATDW01.EXE 
#***************************************************************************
all:	.\$(PROJ).EXE

#***************************************************************************
# Compile the Front End
#***************************************************************************
.\ATDW01.obj : ATDW01.C $(ATDW01_DEP)
     $(CC) $(CFLAGS) -Fo.\ATDW01.obj ATDW01.C

#***************************************************************************
# Compile each window module
#***************************************************************************

# Make C window module ATDW001
.\ATDW001.obj : $(ATDW001_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\ATDW001.obj ATDW001.c

# Make C window module ATDW002
.\ATDW002.obj : $(ATDW002_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\ATDW002.obj ATDW002.c

# Make C window module ATDW003
.\ATDW003.obj : $(ATDW003_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\ATDW003.obj ATDW003.c

# Make C window module ATDW004
.\ATDW004.obj : $(ATDW004_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\ATDW004.obj ATDW004.c

# Make C window module ATDW006
.\ATDW006.obj : $(ATDW006_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\ATDW006.obj ATDW006.c


#***************************************************************************
# Compile the executable resource file
#***************************************************************************
.\ATDW01.res:   ATDW01.RC $(ATDW01_RCDEP)
   $(RC) $(RCFLAGS) $(RCDEFINES) -Fo.\ATDW01.res ATDW01.RC


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************





#***************************************************************************
# Construct the executable
#***************************************************************************

.\$(PROJ).EXE :  .\ATDW01.obj .\ATDW01.res 	\
		.\ATDW001.obj 	\
		.\ATDW002.obj 	\
		.\ATDW003.obj 	\
		.\ATDW004.obj 	\
		.\ATDW006.obj 
    link $(LFLAGS) @<<
/OUT:.\$(PROJ).EXE
.\ATDW01.obj
      .\ATDW001.obj
      .\ATDW002.obj
      .\ATDW003.obj
      .\ATDW004.obj
      .\ATDW006.obj

.\ATDW01.res
$(ALL_LIBS)

<<

