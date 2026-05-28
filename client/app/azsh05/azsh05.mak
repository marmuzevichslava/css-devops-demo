#/***************************************************************************
#**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
#**  This work is protected by copyright law as an unpublished work.       **
#****************************************************************************/
#-------------------------------------------------------------------------
#
#   Make File
#
#   Filename: AZSH05.MAK
#
#   Description:    Make file for Executable to call Security API
#
#   Author: CWOODS, SolutionWorks
#
#   Date Created:  May 28, 1996
#
#   Date         By       Sir#   Description
# --------  ------------ ------  -----------------------------------------
# 05/28/96  CWOODS               Creation
#
#--------------------------------------------------------------------------

#--------------------------------------------------------------------------
#
#   Project Name
#
#--------------------------------------------------------------------------
PROJ = AZSH05

#--------------------------------------------------------------------------
#
#   Library List
#
#--------------------------------------------------------------------------
LIBS_OS2 = os2+llibcrt+crtexe+C1CFUNC

LIBS_WIN32 = msvcrt.lib kernel32.lib user32.lib gdi32.lib \
             winspool.lib comdlg32.lib \
             advapi32.lib shell32.lib wsock32.lib \
             c1cfunc.lib

#--------------------------------------------------------------------------
#
#   Include Standard Architecture Executable Build Macro
#
#--------------------------------------------------------------------------
!INCLUDE <eaxbuild.mak>

#--------------------------------------------------------------------------
#
#   Main Project Dependency
#
#--------------------------------------------------------------------------
ALL : $(EXE_FILE)

#--------------------------------------------------------------------------
#
#   Modify the base location (Local or Remote) of the object files
#        (NT & OS/2) and DEF file (OS/2) dependencies.
#
#--------------------------------------------------------------------------
AZSH05 = $(R_OBJ)\AZSH05.obj
DEF_FILE = $(R_SRC)\$(PROJ).def

#--------------------------------------------------------------------------
#
#   Create the NT executable
#
#--------------------------------------------------------------------------
!if "$(PLATFORM)" == "WIN32"

$(EXE_FILE) : $(MAK_FILE) $(AZSH05)
    link @<<
$(LFLAGS)
$(AZSH05)
$(LIBS)
<<
!endif

#--------------------------------------------------------------------------
#
#   Create the OS/2 executable
#
#--------------------------------------------------------------------------
!if "$(PLATFORM)" == "OS2"

$(EXE_FILE) : $(DEF_FILE) $(MAK_FILE) $(AZSH05)
    link $(LFLAGS) @<<
$(AZSH05)
$(EXE_FILE)
NUL
$(LIBS)
$(DEF_FILE)
<<
!endif

#--------------------------------------------------------------------------
#
#   Create the OBJ file based upon the inference rules defined
#       in EAXBUILD.MAK
#
#--------------------------------------------------------------------------

$(AZSH05) :
