#***************************************************************************
#                                                                          *
#                W I N D O W S   N T   M A K E   F I L E                   *
#                                                                          *
#                Copyright (C) 1994, Andersen Consulting.                  *
#                          All rights reserved.                            *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: AZCS01                            *
#                          Generated on: Sat Jan  6 09:52:36 1996          *
#                                    by: PJPJ                              *
#                                                                          *
#***************************************************************************

PROJDIR = c:\data\archunit\nt\src\csrmapgn
OBJDIR = c:\data\archunit\nt\bin\obj
EXEDIR = c:\data\archunit\nt\bin\exe

PROJ = AZCS01

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
USRLIBS  = C1CFUNC.LIB ARCHDISP.LIB CSSFUNC.LIB
ALL_LIBS = $(LIBS)   $(DLLLIBS) $(USRLIBS)

#***************************************************************************
#  Dependencies for each of the executable components
#***************************************************************************


# Make C frontend dependencies AZCS01
AZCS01_DEP = $(PROJDIR)\AZCS01B.gnb AZCS01.sdt AZCS01.wdt


# Make C window module AZCS001
AZCS001_DEP = AZCS001.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS001C.h	\
		$(PROJDIR)\AZCS002O.h	\
		$(PROJDIR)\AZCS003I.h	\
		$(PROJDIR)\AZCS003O.h	\
		$(PROJDIR)\AZCS004I.h	\
		$(PROJDIR)\MAPGEN.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZCS001.CB	\
		$(PROJDIR)\AZCS001.C    \
                AZCS001.aex     \
                AZCS001.h       \
                AZCS001.wmp     \
                AZCS001.gnd     \
                AZCS001.gnh     \
                AZCS01.gnz        \
                AZCS001.src
# Make C window module AZCS002
AZCS002_DEP = AZCS002.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS002C.h	\
		$(PROJDIR)\AZCS002O.h	\
		$(PROJDIR)\MAPGEN.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZCS002.CB    \
                AZCS002.aex     \
                AZCS002.h       \
                AZCS002.wmp     \
                AZCS002.gnd     \
                AZCS002.gnh     \
                AZCS01.gnz        \
                AZCS002.src
# Make C window module AZCS006
AZCS006_DEP = AZCS006.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS006C.h	\
		$(PROJDIR)\AZCS004I.h	\
		$(PROJDIR)\MAPGEN.h	\
		$(PROJDIR)\AZCS006.CB	\
		$(PROJDIR)\AZDI0400.C    \
                AZCS006.aex     \
                AZCS006.h       \
                AZCS006.wmp     \
                AZCS006.gnd     \
                AZCS006.gnh     \
                AZCS01.gnz        \
                AZCS006.src
# Make C window module AZCS007
AZCS007_DEP = AZCS007.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS007C.h	\
		$(PROJDIR)\AZCS004I.h	\
		$(PROJDIR)\MAPGEN.h	\
		$(PROJDIR)\AZCS007.CB	\
		$(PROJDIR)\AZDI0400.C    \
                AZCS007.aex     \
                AZCS007.h       \
                AZCS007.wmp     \
                AZCS007.gnd     \
                AZCS007.gnh     \
                AZCS01.gnz        \
                AZCS007.src
# Make C window module AZCS004
AZCS004_DEP = AZCS004.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS004C.h	\
		$(PROJDIR)\AZCS004I.h	\
		$(PROJDIR)\MAPGEN.h	\
		$(PROJDIR)\AZCS004.CB	\
		$(PROJDIR)\AZDI0400.C	\
                AZCS004.aex     \
                AZCS004.h       \
                AZCS004.wmp     \
                AZCS004.gnd     \
                AZCS004.gnh     \
                AZCS01.gnz        \
                AZCS004.src
# Make C window module AZCS005
AZCS005_DEP = AZCS005.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS005C.h	\
		$(PROJDIR)\AZCS004I.h	\
		$(PROJDIR)\MAPGEN.h	\
		$(PROJDIR)\AZCS005.CB	\
		$(PROJDIR)\AZDI0400.C    \
                AZCS005.aex     \
                AZCS005.h       \
                AZCS005.wmp     \
                AZCS005.gnd     \
                AZCS005.gnh     \
                AZCS01.gnz        \
                AZCS005.src
# Make C window module AZCS008
AZCS008_DEP = AZCS008.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS008C.h	\
		$(PROJDIR)\MAPGEN.h	\
		$(PROJDIR)\AZCS008.CB	\
		$(PROJDIR)\AZDI0400.C    \
                AZCS008.aex     \
                AZCS008.h       \
                AZCS008.wmp     \
                AZCS008.gnd     \
                AZCS008.gnh     \
                AZCS01.gnz        \
                AZCS008.src
# Make C window module AZCS009
AZCS009_DEP = AZCS009.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS009C.h	\
		$(PROJDIR)\MAPGEN.h	\
		$(PROJDIR)\AZCS009.CB	\
		$(PROJDIR)\AZDI0400.C    \
                AZCS009.aex     \
                AZCS009.h       \
                AZCS009.wmp     \
                AZCS009.gnd     \
                AZCS009.gnh     \
                AZCS01.gnz        \
                AZCS009.src
# Make C window module AZCS010
AZCS010_DEP = AZCS010.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS010C.h	\
		$(PROJDIR)\MAPGEN.h	\
		$(PROJDIR)\AZCS010.CB	\
		$(PROJDIR)\AZDI0400.C    \
                AZCS010.aex     \
                AZCS010.h       \
                AZCS010.wmp     \
                AZCS010.gnd     \
                AZCS010.gnh     \
                AZCS01.gnz        \
                AZCS010.src
# Make C window module AZCS003
AZCS003_DEP = AZCS003.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS003C.h	\
		$(PROJDIR)\AZCS003I.h	\
		$(PROJDIR)\AZCS003O.h	\
		$(PROJDIR)\MAPGEN.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZCS003.CB    \
                AZCS003.aex     \
                AZCS003.h       \
                AZCS003.wmp     \
                AZCS003.gnd     \
                AZCS003.gnh     \
                AZCS01.gnz        \
                AZCS003.src
# Make C window module AZCS011
AZCS011_DEP = AZCS011.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS011C.h	\
		$(PROJDIR)\AZCS011I.h	\
		$(PROJDIR)\MAPGEN.h	\
		$(PROJDIR)\AZCS011.CB	\
		$(PROJDIR)\AZDI0400.C    \
                AZCS011.aex     \
                AZCS011.h       \
                AZCS011.wmp     \
                AZCS011.gnd     \
                AZCS011.gnh     \
                AZCS01.gnz        \
                AZCS011.src
# Make C window module AZCS013
AZCS013_DEP = AZCS013.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS013C.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZCS013.CB    \
                AZCS013.aex     \
                AZCS013.h       \
                AZCS013.wmp     \
                AZCS013.gnd     \
                AZCS013.gnh     \
                AZCS01.gnz        \
                AZCS013.src
# Make C window module AZCS014
AZCS014_DEP = AZCS014.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZCS014.CB    \
                AZCS014.aex     \
                AZCS014.h       \
                AZCS014.wmp     \
                AZCS014.gnd     \
                AZCS014.gnh     \
                AZCS01.gnz        \
                AZCS014.src



# Make RC dependencies for AZCS01
AZCS01_RCDEP = AZCS01.gnz    \
               AZCS001.dlg  \
               AZCS002.dlg  \
               AZCS006.dlg  \
               AZCS007.dlg  \
               AZCS004.dlg  \
               AZCS005.dlg  \
               AZCS008.dlg  \
               AZCS009.dlg  \
               AZCS010.dlg  \
               AZCS003.dlg  \
               AZCS011.dlg  \
               AZCS013.dlg  \
               AZCS014.dlg 


#***************************************************************************
#  Steps for construction of AZCS01.EXE 
#***************************************************************************
all:	$(EXEDIR)\$(PROJ).EXE

#***************************************************************************
# Compile the Front End
#***************************************************************************
$(OBJDIR)\AZCS01.obj : AZCS01.C $(AZCS01_DEP)
     $(CC) $(CFLAGS) -Fo$(OBJDIR)\AZCS01.obj AZCS01.C

#***************************************************************************
# Compile each window module
#***************************************************************************

# Make C window module AZCS001
$(OBJDIR)\AZCS001.obj : $(AZCS001_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS001.obj AZCS001.c

# Make C window module AZCS002
$(OBJDIR)\AZCS002.obj : $(AZCS002_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS002.obj AZCS002.c

# Make C window module AZCS006
$(OBJDIR)\AZCS006.obj : $(AZCS006_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS006.obj AZCS006.c

# Make C window module AZCS007
$(OBJDIR)\AZCS007.obj : $(AZCS007_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS007.obj AZCS007.c

# Make C window module AZCS004
$(OBJDIR)\AZCS004.obj : $(AZCS004_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS004.obj AZCS004.c

# Make C window module AZCS005
$(OBJDIR)\AZCS005.obj : $(AZCS005_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS005.obj AZCS005.c

# Make C window module AZCS008
$(OBJDIR)\AZCS008.obj : $(AZCS008_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS008.obj AZCS008.c

# Make C window module AZCS009
$(OBJDIR)\AZCS009.obj : $(AZCS009_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS009.obj AZCS009.c

# Make C window module AZCS010
$(OBJDIR)\AZCS010.obj : $(AZCS010_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS010.obj AZCS010.c

# Make C window module AZCS003
$(OBJDIR)\AZCS003.obj : $(AZCS003_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS003.obj AZCS003.c

# Make C window module AZCS011
$(OBJDIR)\AZCS011.obj : $(AZCS011_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS011.obj AZCS011.c

# Make C window module AZCS013
$(OBJDIR)\AZCS013.obj : $(AZCS013_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS013.obj AZCS013.c

# Make C window module AZCS014
$(OBJDIR)\AZCS014.obj : $(AZCS014_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS014.obj AZCS014.c

$(OBJDIR)\AZCSM001.obj : $(PROJDIR)\AZCSM001.c
     cl $(CFLAGS) AZCSM001.c

$(OBJDIR)\AZCSM005.obj : $(PROJDIR)\AZCSM005.c
     cl $(CFLAGS) AZCSM005.c

$(OBJDIR)\AZCSM006.obj : $(PROJDIR)\AZCSM006.c
     cl $(CFLAGS) AZCSM006.c

$(OBJDIR)\AZCSM010.obj : $(PROJDIR)\AZCSM010.c
     cl $(CFLAGS) AZCSM010.c

$(OBJDIR)\VERSION.obj : $(PROJDIR)\VERSION.c
     cl $(CFLAGS) VERSION.c

#***************************************************************************
# Compile the executable resource file
#***************************************************************************
$(OBJDIR)\AZCS01.res:   AZCS01.RC $(AZCS01_RCDEP)
   $(RC) $(RCFLAGS) $(RCDEFINES) -Fo$(OBJDIR)\AZCS01.res AZCS01.RC

#***************************************************************************
# Compile each service module
#***************************************************************************


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************





#***************************************************************************
# Construct the executable
#***************************************************************************

$(EXEDIR)\$(PROJ).EXE :  $(OBJDIR)\AZCS01.obj $(OBJDIR)\AZCS01.res 	\
		$(OBJDIR)\AZCS001.obj 	\
		$(OBJDIR)\AZCS002.obj 	\
		$(OBJDIR)\AZCS006.obj 	\
		$(OBJDIR)\AZCS007.obj 	\
		$(OBJDIR)\AZCS004.obj 	\
		$(OBJDIR)\AZCS005.obj 	\
		$(OBJDIR)\AZCS008.obj 	\
		$(OBJDIR)\AZCS009.obj 	\
		$(OBJDIR)\AZCS010.obj 	\
		$(OBJDIR)\AZCS003.obj 	\
		$(OBJDIR)\AZCS011.obj 	\
		$(OBJDIR)\AZCS013.obj 	\
		$(OBJDIR)\AZCS014.obj 	\
		$(OBJDIR)\AZCSM001.obj  \
		$(OBJDIR)\AZCSM005.obj  \
		$(OBJDIR)\AZCSM006.obj  \
		$(OBJDIR)\AZCSM010.obj  \
		$(OBJDIR)\VERSION.obj
    link $(LFLAGS) @<<
/OUT:$(EXEDIR)\$(PROJ).EXE
$(OBJDIR)\AZCS01.obj
      $(OBJDIR)\AZCS001.obj
      $(OBJDIR)\AZCS002.obj
      $(OBJDIR)\AZCS006.obj
      $(OBJDIR)\AZCS007.obj
      $(OBJDIR)\AZCS004.obj
      $(OBJDIR)\AZCS005.obj
      $(OBJDIR)\AZCS008.obj
      $(OBJDIR)\AZCS009.obj
      $(OBJDIR)\AZCS010.obj
      $(OBJDIR)\AZCS003.obj
      $(OBJDIR)\AZCS011.obj
      $(OBJDIR)\AZCS013.obj
      $(OBJDIR)\AZCS014.obj
	  $(OBJDIR)\AZCSM001.obj
	  $(OBJDIR)\AZCSM005.obj
	  $(OBJDIR)\AZCSM006.obj
	  $(OBJDIR)\AZCSM010.obj
	  $(OBJDIR)\VERSION.obj

$(OBJDIR)\AZCS01.res
$(ALL_LIBS)

<<

