# Microsoft Developer Studio Generated NMAKE File, Format Version 4.20
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) External Target" 0x0106

!IF "$(CFG)" == ""
CFG=DZSF3 - Win32 Debug
!MESSAGE No configuration specified.  Defaulting to DZSF3 - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "DZSF3 - Win32 Release" && "$(CFG)" != "DZSF3 - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "DZSF3.MAK" CFG="DZSF3 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "DZSF3 - Win32 Release" (based on "Win32 (x86) External Target")
!MESSAGE "DZSF3 - Win32 Debug" (based on "Win32 (x86) External Target")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 
################################################################################
# Begin Project

!IF  "$(CFG)" == "DZSF3 - Win32 Release"

# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP BASE Cmd_Line "NMAKE /f DZSF02.MAK"
# PROP BASE Rebuild_Opt "/a"
# PROP BASE Target_File "DZSF02.EXE"
# PROP BASE Bsc_Name "DZSF02.BSC"
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# PROP Cmd_Line "NMAKE /f DZSF02.MAK"
# PROP Rebuild_Opt "/a"
# PROP Target_File "DZSF02.EXE"
# PROP Bsc_Name "DZSF3.BSC"
OUTDIR=.\Release
INTDIR=.\Release

ALL : 

CLEAN : 
	-@erase 

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

!ELSEIF  "$(CFG)" == "DZSF3 - Win32 Debug"

# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP BASE Cmd_Line "NMAKE /f DZSF02.MAK"
# PROP BASE Rebuild_Opt "/a"
# PROP BASE Target_File "DZSF02.EXE"
# PROP BASE Bsc_Name "DZSF02.BSC"
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# PROP Cmd_Line "NMAKE /f DZSF02.MAK"
# PROP Rebuild_Opt "/a"
# PROP Target_File "DZSF02.EXE"
# PROP Bsc_Name "DZSF3.BSC"
OUTDIR=.\Debug
INTDIR=.\Debug

ALL : 

CLEAN : 
	-@erase 

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

!ENDIF 

################################################################################
# Begin Target

# Name "DZSF3 - Win32 Release"
# Name "DZSF3 - Win32 Debug"

!IF  "$(CFG)" == "DZSF3 - Win32 Release"

".\DZSF02.EXE" : 
   CD D:\Data\tabtest\gen
   NMAKE /f DZSF02.MAK

!ELSEIF  "$(CFG)" == "DZSF3 - Win32 Debug"

".\DZSF02.EXE" : 
   CD D:\Data\tabtest\gen
   NMAKE /f DZSF02.MAK

!ENDIF 

################################################################################
# Begin Source File

SOURCE=.\DZSF02.MAK

!IF  "$(CFG)" == "DZSF3 - Win32 Release"

!ELSEIF  "$(CFG)" == "DZSF3 - Win32 Debug"

!ENDIF 

# End Source File
# End Target
# End Project
################################################################################
