#***************************************************************************
#                                                                          *
#                W I N D O W S   N T   M A K E   F I L E                   *
#                                                                          *
#    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: AZCS01                            *
#                          Generated on: Wed Jul 31 16:48:14 1996          *
#                                    by: CWOODS                            *
#                     Short Description:                                   *
# 05/06/15 Vikas Jha: Handlded the local and remote compilations           *
#                                                                          *
#***************************************************************************
!ifndef LOC
LOC = REMOTE
!endif

!if "$(LOC)" == "REMOTE"
PROJDIR = n:\azcs01nt
OBJDIR = r:\obj
EXEDIR = r:\exe
ARCHINC = n:\archinc
!endif

!if "$(LOC)" == "LOCAL"
PROJDIR = C:\Data\archunit\src\azcs01\nt
OBJDIR = C:\Data\archunit\nt\bin\obj
EXEDIR = C:\Data\archunit\nt\bin\exe
ARCHINC = C:\Data\archunit\src\archinc
!endif

PROJ = AZCS01

!ifndef DEBUG
DEBUG = 1
!endif

CC = cl
RC = rc
LINK = link


CFLAGS_D = /c /W3 /Zp1 /Zip /Od /D "_DEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D "_USE_32BIT_TIME_T" /D "CSRMPGN" /D "FND_WIN32" /MD /Fd"$(PROJ).PDB" 
CFLAGS_R = /c /W3 /Zp1 /O2 /D "NDEBUG" /D "_X86_" /D "STRICT" /D "_USE_32BIT_TIME_T" /D "WIN32" /D "FND_WIN32" /D "CSRMPGN" /MT 
LFLAGS_D = /DEBUG /DEBUGTYPE:cv /SUBSYSTEM:windows /MAP 
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


# Make C frontend dependencies AZCS01
AZCS01_DEP = $(PROJDIR)\AZCS01B.gnb $(PROJDIR)\AZCS01.sdt $(PROJDIR)\AZCS01.wdt



# Make C window module AZCS001
AZCS001_DEP = $(PROJDIR)\AZCS001.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS001C.h	\
		$(PROJDIR)\AZCS002O.h	\
		$(PROJDIR)\AZCS003I.h	\
		$(PROJDIR)\AZCS003O.h	\
		$(PROJDIR)\AZCS004I.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZCS001.CB    \
        $(PROJDIR)\AZCS001.aex     \
        $(PROJDIR)\AZCS001.h       \
        $(PROJDIR)\AZCS001.wmp     \
        $(PROJDIR)\AZCS001.gnd     \
        $(PROJDIR)\AZCS001.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS001.src	\
		$(PROJDIR)\mapgen.h

# Make C window module AZCS002
AZCS002_DEP = $(PROJDIR)\AZCS002.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS002C.h	\
		$(PROJDIR)\AZCS002O.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZCS002.CB    \
        $(PROJDIR)\AZCS002.aex     \
        $(PROJDIR)\AZCS002.h       \
        $(PROJDIR)\AZCS002.wmp     \
        $(PROJDIR)\AZCS002.gnd     \
        $(PROJDIR)\AZCS002.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS002.src	\
		$(PROJDIR)\mapgen.h

# Make C window module AZCS003
AZCS003_DEP = $(PROJDIR)\AZCS003.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS003C.h	\
		$(PROJDIR)\AZCS003I.h	\
		$(PROJDIR)\AZCS003O.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZCS003.CB    \
        $(PROJDIR)\AZCS003.aex     \
        $(PROJDIR)\AZCS003.h       \
        $(PROJDIR)\AZCS003.wmp     \
        $(PROJDIR)\AZCS003.gnd     \
        $(PROJDIR)\AZCS003.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS003.src	\
		$(PROJDIR)\mapgen.h

# Make C window module AZCS004
AZCS004_DEP = $(PROJDIR)\AZCS004.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS004C.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZCS004.CB    \
        $(PROJDIR)\AZCS004.aex     \
        $(PROJDIR)\AZCS004.h       \
        $(PROJDIR)\AZCS004.wmp     \
        $(PROJDIR)\AZCS004.gnd     \
        $(PROJDIR)\AZCS004.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS004.src	\
		$(PROJDIR)\mapgen.h

# Make C window module AZCS005
AZCS005_DEP = $(PROJDIR)\AZCS005.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS005C.h	\
		$(PROJDIR)\AZCS004I.h	\
		$(PROJDIR)\AZCS005.CB	\
		$(PROJDIR)\AZDI0400.C    \
        $(PROJDIR)\AZCS005.aex     \
        $(PROJDIR)\AZCS005.h       \
        $(PROJDIR)\AZCS005.wmp     \
        $(PROJDIR)\AZCS005.gnd     \
        $(PROJDIR)\AZCS005.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS005.src	\
		$(PROJDIR)\mapgen.h

# Make C window module AZCS006
AZCS006_DEP = $(PROJDIR)\AZCS006.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS006C.h	\
		$(PROJDIR)\AZCS004I.h	\
		$(PROJDIR)\AZCS006.CB	\
		$(PROJDIR)\AZDI0400.C    \
        $(PROJDIR)\AZCS006.aex     \
        $(PROJDIR)\AZCS006.h       \
        $(PROJDIR)\AZCS006.wmp     \
        $(PROJDIR)\AZCS006.gnd     \
        $(PROJDIR)\AZCS006.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS006.src	\
		$(PROJDIR)\mapgen.h

# Make C window module AZCS007
AZCS007_DEP = $(PROJDIR)\AZCS007.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS007C.h	\
		$(PROJDIR)\AZCS004I.h	\
		$(PROJDIR)\AZCS007.CB	\
		$(PROJDIR)\AZDI0400.C    \
        $(PROJDIR)\AZCS007.aex     \
        $(PROJDIR)\AZCS007.h       \
        $(PROJDIR)\AZCS007.wmp     \
        $(PROJDIR)\AZCS007.gnd     \
        $(PROJDIR)\AZCS007.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS007.src	\
		$(PROJDIR)\mapgen.h

# Make C window module AZCS008
AZCS008_DEP = $(PROJDIR)\AZCS008.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS008C.h	\
		$(PROJDIR)\AZCS010O.h	\
		$(PROJDIR)\AZCS008.CB	\
		$(PROJDIR)\AZDI0400.C    \
        $(PROJDIR)\AZCS008.aex     \
        $(PROJDIR)\AZCS008.h       \
        $(PROJDIR)\AZCS008.wmp     \
        $(PROJDIR)\AZCS008.gnd     \
        $(PROJDIR)\AZCS008.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS008.src	\
		$(PROJDIR)\mapgen.h

# Make C window module AZCS009
AZCS009_DEP = $(PROJDIR)\AZCS009.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS009C.h	\
		$(PROJDIR)\AZCS009.CB	\
		$(PROJDIR)\AZDI0400.C    \
        $(PROJDIR)\AZCS009.aex     \
        $(PROJDIR)\AZCS009.h       \
        $(PROJDIR)\AZCS009.wmp     \
        $(PROJDIR)\AZCS009.gnd     \
        $(PROJDIR)\AZCS009.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS009.src	\
		$(PROJDIR)\mapgen.h

# Make C window module AZCS010
AZCS010_DEP = $(PROJDIR)\AZCS010.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS010C.h	\
		$(PROJDIR)\AZCS010O.h	\
		$(PROJDIR)\AZCS010.CB	\
		$(PROJDIR)\AZDI0400.C    \
        $(PROJDIR)\AZCS010.aex     \
        $(PROJDIR)\AZCS010.h       \
        $(PROJDIR)\AZCS010.wmp     \
        $(PROJDIR)\AZCS010.gnd     \
        $(PROJDIR)\AZCS010.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS010.src	\
		$(PROJDIR)\mapgen.h

# Make C window module AZCS011
AZCS011_DEP = $(PROJDIR)\AZCS011.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS011C.h	\
		$(PROJDIR)\AZCS011.CB	\
		$(PROJDIR)\AZDI0400.C    \
        $(PROJDIR)\AZCS011.aex     \
        $(PROJDIR)\AZCS011.h       \
        $(PROJDIR)\AZCS011.wmp     \
        $(PROJDIR)\AZCS011.gnd     \
        $(PROJDIR)\AZCS011.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS011.src	\
		$(PROJDIR)\mapgen.h

# Make C window module AZCS013
AZCS013_DEP = $(PROJDIR)\AZCS013.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS013C.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZCS013.CB    \
        $(PROJDIR)\AZCS013.aex     \
        $(PROJDIR)\AZCS013.h       \
        $(PROJDIR)\AZCS013.wmp     \
        $(PROJDIR)\AZCS013.gnd     \
        $(PROJDIR)\AZCS013.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS013.src	\
		$(PROJDIR)\mapgen.h

# Make C window module AZCS014
AZCS014_DEP = $(PROJDIR)\AZCS014.c	\
		$(PROJDIR)\AZCS01B.gnb	\
		$(PROJDIR)\AZCS014C.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZCS014.CB    \
        $(PROJDIR)\AZCS014.aex     \
        $(PROJDIR)\AZCS014.h       \
        $(PROJDIR)\AZCS014.wmp     \
        $(PROJDIR)\AZCS014.gnd     \
        $(PROJDIR)\AZCS014.gnh     \
        $(PROJDIR)\AZCS01.gnz        \
        $(PROJDIR)\AZCS014.src	\
		$(PROJDIR)\mapgen.h
				   
# Make RC dependencies for AZCS01
AZCS01_RCDEP = $(PROJDIR)\AZCS01.gnz    \
               $(PROJDIR)\AZCS001.dlg  \
               $(PROJDIR)\AZCS002.dlg  \
               $(PROJDIR)\AZCS003.dlg  \
               $(PROJDIR)\AZCS004.dlg  \
               $(PROJDIR)\AZCS005.dlg  \
               $(PROJDIR)\AZCS006.dlg  \
               $(PROJDIR)\AZCS007.dlg  \
               $(PROJDIR)\AZCS008.dlg  \
               $(PROJDIR)\AZCS009.dlg  \
               $(PROJDIR)\AZCS010.dlg  \
               $(PROJDIR)\AZCS011.dlg  \
               $(PROJDIR)\AZCS013.dlg  \
               $(PROJDIR)\AZCS014.dlg 

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

# Make C window module AZCS003
$(OBJDIR)\AZCS003.obj : $(AZCS003_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS003.obj AZCS003.c

# Make C window module AZCS004
$(OBJDIR)\AZCS004.obj : $(AZCS004_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS004.obj AZCS004.c

# Make C window module AZCS005
$(OBJDIR)\AZCS005.obj : $(AZCS005_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS005.obj AZCS005.c

# Make C window module AZCS006
$(OBJDIR)\AZCS006.obj : $(AZCS006_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS006.obj AZCS006.c

# Make C window module AZCS007
$(OBJDIR)\AZCS007.obj : $(AZCS007_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS007.obj AZCS007.c

# Make C window module AZCS008
$(OBJDIR)\AZCS008.obj : $(AZCS008_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS008.obj AZCS008.c

# Make C window module AZCS009
$(OBJDIR)\AZCS009.obj : $(AZCS009_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS009.obj AZCS009.c

# Make C window module AZCS010
$(OBJDIR)\AZCS010.obj : $(AZCS010_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZCS010.obj AZCS010.c

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
     cl $(CFLAGS) AZCSM001.c  /Fo$(OBJDIR)\azcsm001.obj

$(OBJDIR)\AZCSM005.obj : $(PROJDIR)\AZCSM005.c
     cl $(CFLAGS) AZCSM005.c /Fo$(OBJDIR)\azcsm005.obj

$(OBJDIR)\AZCSM006.obj : $(PROJDIR)\AZCSM006.c
     cl $(CFLAGS) AZCSM006.c /Fo$(OBJDIR)\azcsm006.obj

$(OBJDIR)\AZCSM010.obj : $(PROJDIR)\AZCSM010.c
     cl $(CFLAGS) AZCSM010.c  /Fo$(OBJDIR)\azcsm010.obj

$(OBJDIR)\VERSION.obj : $(PROJDIR)\VERSION.c
     cl $(CFLAGS) VERSION.c	 /Fo$(OBJDIR)\version.obj

#***************************************************************************
# Compile the executable resource file
#***************************************************************************
$(OBJDIR)\AZCS01.res:   AZCS01.RC $(AZCS01_RCDEP)
   $(RC) $(RCFLAGS) $(RCDEFINES) -Fo$(OBJDIR)\AZCS01.res AZCS01.RC


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************





#***************************************************************************
# Construct the executable
#***************************************************************************

$(EXEDIR)\$(PROJ).EXE :  $(OBJDIR)\AZCS01.obj $(OBJDIR)\AZCS01.res 	\
		$(OBJDIR)\AZCS001.obj 	\
		$(OBJDIR)\AZCS002.obj 	\
		$(OBJDIR)\AZCS003.obj 	\
		$(OBJDIR)\AZCS004.obj 	\
		$(OBJDIR)\AZCS005.obj 	\
		$(OBJDIR)\AZCS006.obj 	\
		$(OBJDIR)\AZCS007.obj 	\
		$(OBJDIR)\AZCS008.obj 	\
		$(OBJDIR)\AZCS009.obj 	\
		$(OBJDIR)\AZCS010.obj 	\
		$(OBJDIR)\AZCS011.obj 	\
		$(OBJDIR)\AZCS013.obj 	\
		$(OBJDIR)\AZCS014.obj \
	    $(OBJDIR)\AZCSM001.obj	   \
	    $(OBJDIR)\AZCSM005.obj	   \
	    $(OBJDIR)\AZCSM006.obj	  \
	    $(OBJDIR)\AZCSM010.obj	  \
	    $(OBJDIR)\VERSION.obj
    link $(LFLAGS) @<<
/OUT:$(EXEDIR)\$(PROJ).EXE
/NODEFAULTLIB:libcmt.lib
$(OBJDIR)\AZCS01.obj
      $(OBJDIR)\AZCS001.obj
      $(OBJDIR)\AZCS002.obj
      $(OBJDIR)\AZCS003.obj
      $(OBJDIR)\AZCS004.obj
      $(OBJDIR)\AZCS005.obj
      $(OBJDIR)\AZCS006.obj
      $(OBJDIR)\AZCS007.obj
      $(OBJDIR)\AZCS008.obj
      $(OBJDIR)\AZCS009.obj
      $(OBJDIR)\AZCS010.obj
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

