#/***************************************************************************
#**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
#**  This work is protected by copyright law as an unpublished work.       **
#****************************************************************************/
#*****************************************************************************
#*
#*  Customer/1 Cooperative Architecture Make File
#*
#*      File Name:         < >.MAK
#*
#*      Description:   This file is a platform-independent build script for
#*                     the < > Dynamic Link Library.  
#*
#*      Author:        < >
#*
#*      Date Created:  < >
#*
#*      Revision History
#*
#*  DATE      REVISED BY			SIR #    DESCRIPTION OF CHANGE
#*  --------  ----------			-------  --------------------------------
#*  <      >  <        >                     Creation.
#******************************************************************************

#******************************************************************************
#*  Project Name
#******************************************************************************
PROJ = < >

DLLDIR = < >
LIBDIR = < >
OBJDIR = < >

#******************************************************************************
#*  Library List
#******************************************************************************
LIBS_WIN32 = azgs03.lib c1cfunc.lib cssfunc.lib

!ifndef DEBUG
DEBUG = ON
!endif

CFLAGS_D_WIN32 = /c /W3 /Zp1 /Zip /Od /D "_X86_" /D "_DEBUG" /D "WINSOCK" /D "FND_WIN32" /D "WIN32" /D"C1CDEBUG" /D"PERF" /D"CPM" /MT
CFLAGS_R_WIN32 = /c /Zp1 /W3 /Od /D "_X86_" /D "NDEBUG" /D "WINSOCK" /D "FND_WIN32" /D "WIN32" /D"CPM" /MT 

LFLAGS_D_WIN32 = /DEBUG /PDB:NONE /DEBUGTYPE:cv /OUT:$(DLLDIR)\$(PROJ).dll /SUBSYSTEM:windows /DLL /ENTRY:_DllMainCRTStartup@12 /MAP
LFLAGS_R_WIN32 = /OUT:$(DLLDIR)\$(PROJ).dll /SUBSYSTEM:windows /DLL /ENTRY:_DllMainCRTStartup@12 /MAP

!if "$(DEBUG)" == "ON"
TEXT = debug version for Windows NT...
CFLAGS = $(CFLAGS_D_WIN32)
LFLAGS = $(LFLAGS_D_WIN32)
LIBS   = $(LIBS_WIN32)
!endif

!if "$(DEBUG)" == "OFF"
TEXT = no debug version for Windows NT...
CFLAGS = $(CFLAGS_R_WIN32)
LFLAGS = $(LFLAGS_R_WIN32)
LIBS   = $(LIBS_WIN32)
!endif	

#******************************************************************************
#*  Main project dependency
#******************************************************************************
ALL : $(PROJ).DLL

#******************************************************************************
#*  Create the NT LIB and NT EXP files
#******************************************************************************
$(PROJ).lib : $(PROJ).DEF
	  lib @<<
/DEF:$(PROJ).DEF
/OUT:$(LIBDIR)\$(PROJ).LIB
/SUBSYSTEM:windows
$(PROJ).OBJ
<<

#******************************************************************************
#*  Create NT DLL Step
#******************************************************************************
$(PROJ).DLL : $(PROJ).OBJ $(PROJ).lib
	link @<<
/OUT:$(DLLDIR)\$(PROJ).DLL
$(LFLAGS)
$(PROJ).obj
$(PROJ).exp
$(LIBS)
<<

$(PROJ).OBJ : $(PROJ).C
	cl $(CFLAGS) $(PROJ).C