# Microsoft Developer Studio Generated NMAKE File, Format Version 4.20
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

!IF "$(CFG)" == ""
CFG=azgsstub - Win32 Debug
!MESSAGE No configuration specified.  Defaulting to azgsstub - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "azgsstub - Win32 Release" && "$(CFG)" !=\
 "azgsstub - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "azgsstub.mak" CFG="azgsstub - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "azgsstub - Win32 Release" (based on\
 "Win32 (x86) Console Application")
!MESSAGE "azgsstub - Win32 Debug" (based on "Win32 (x86) Console Application")
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
# PROP Target_Last_Scanned "azgsstub - Win32 Debug"
RSC=rc.exe
CPP=cl.exe

!IF  "$(CFG)" == "azgsstub - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
OUTDIR=.\Release
INTDIR=.\Release

ALL : "$(OUTDIR)\azgsstub.exe"

CLEAN : 
	-@erase "$(INTDIR)\azgsstub.obj"
	-@erase "$(OUTDIR)\azgsstub.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /YX /c
# ADD CPP /nologo /Zp1 /W3 /GX /O2 /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "WINSOCK" /YX /c
CPP_PROJ=/nologo /Zp1 /ML /W3 /GX /O2 /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D\
 "WINSOCK" /Fp"$(INTDIR)/azgsstub.pch" /YX /Fo"$(INTDIR)/" /c 
CPP_OBJS=.\Release/
CPP_SBRS=.\.
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/azgsstub.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 tcppipe.lib azgs02.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
LINK32_FLAGS=tcppipe.lib azgs02.lib kernel32.lib user32.lib gdi32.lib\
 winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib\
 uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)/azgsstub.pdb" /machine:I386 /out:"$(OUTDIR)/azgsstub.exe" 
LINK32_OBJS= \
	"$(INTDIR)\azgsstub.obj"

"$(OUTDIR)\azgsstub.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "azgsstub - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
OUTDIR=.\Debug
INTDIR=.\Debug

ALL : "$(OUTDIR)\azgsstub.exe"

CLEAN : 
	-@erase "$(INTDIR)\azgsstub.obj"
	-@erase "$(INTDIR)\vc40.idb"
	-@erase "$(INTDIR)\vc40.pdb"
	-@erase "$(OUTDIR)\azgsstub.exe"
	-@erase "$(OUTDIR)\azgsstub.ilk"
	-@erase "$(OUTDIR)\azgsstub.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE CPP /nologo /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /YX /c
# ADD CPP /nologo /Zp1 /W3 /Gm /GX /Zi /Od /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "WINSOCK" /YX /c
CPP_PROJ=/nologo /Zp1 /MLd /W3 /Gm /GX /Zi /Od /D "_DEBUG" /D "WIN32" /D\
 "_CONSOLE" /D "WINSOCK" /Fp"$(INTDIR)/azgsstub.pch" /YX /Fo"$(INTDIR)/"\
 /Fd"$(INTDIR)/" /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.\.
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/azgsstub.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386
# ADD LINK32 tcppipe.lib azgs02.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386
LINK32_FLAGS=tcppipe.lib azgs02.lib kernel32.lib user32.lib gdi32.lib\
 winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib\
 uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)/azgsstub.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)/azgsstub.exe" 
LINK32_OBJS= \
	"$(INTDIR)\azgsstub.obj"

"$(OUTDIR)\azgsstub.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.c{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

################################################################################
# Begin Target

# Name "azgsstub - Win32 Release"
# Name "azgsstub - Win32 Debug"

!IF  "$(CFG)" == "azgsstub - Win32 Release"

!ELSEIF  "$(CFG)" == "azgsstub - Win32 Debug"

!ENDIF 

################################################################################
# Begin Source File

SOURCE=.\azgsstub.c

!IF  "$(CFG)" == "azgsstub - Win32 Release"

DEP_CPP_AZGSS=\
	".\azgsstub.h"\
	{$(INCLUDE)}"\c1cerror.h"\
	{$(INCLUDE)}"\pctcp.h"\
	{$(INCLUDE)}"\sys\timeb.h"\
	{$(INCLUDE)}"\sys\types.h"\
	{$(INCLUDE)}"\tcppipe.h"\
	
NODEP_CPP_AZGSS=\
	"..\includes\c1cerror.h"\
	

"$(INTDIR)\azgsstub.obj" : $(SOURCE) $(DEP_CPP_AZGSS) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "azgsstub - Win32 Debug"

DEP_CPP_AZGSS=\
	".\azgsstub.h"\
	{$(INCLUDE)}"\azgscmn.h"\
	{$(INCLUDE)}"\c1cerror.h"\
	{$(INCLUDE)}"\kcfxk010.h"\
	{$(INCLUDE)}"\kcfxk012.h"\
	{$(INCLUDE)}"\kcgxk012.h"\
	{$(INCLUDE)}"\kctxk010.h"\
	{$(INCLUDE)}"\kctxk012.h"\
	{$(INCLUDE)}"\kdswk000.h"\
	{$(INCLUDE)}"\kdswk012.h"\
	{$(INCLUDE)}"\kehxk010.h"\
	{$(INCLUDE)}"\kehxk012.h"\
	{$(INCLUDE)}"\kelxk012.h"\
	{$(INCLUDE)}"\kfexk010.h"\
	{$(INCLUDE)}"\kfexk012.h"\
	{$(INCLUDE)}"\kglxk000.h"\
	{$(INCLUDE)}"\kglxk001.h"\
	{$(INCLUDE)}"\kglxk010.h"\
	{$(INCLUDE)}"\kglxk012.h"\
	{$(INCLUDE)}"\kimzk010.h"\
	{$(INCLUDE)}"\kimzk012.h"\
	{$(INCLUDE)}"\kioxk010.h"\
	{$(INCLUDE)}"\kioxk012.h"\
	{$(INCLUDE)}"\klszk012.h"\
	{$(INCLUDE)}"\kmnxk012.h"\
	{$(INCLUDE)}"\kmszk010.h"\
	{$(INCLUDE)}"\kmszk012.h"\
	{$(INCLUDE)}"\kpsxk010.h"\
	{$(INCLUDE)}"\kpsxk012.h"\
	{$(INCLUDE)}"\kscxk010.h"\
	{$(INCLUDE)}"\kscxk012.h"\
	{$(INCLUDE)}"\ksdxk010.h"\
	{$(INCLUDE)}"\ksdxk012.h"\
	{$(INCLUDE)}"\kstxk010.h"\
	{$(INCLUDE)}"\kstxk012.h"\
	{$(INCLUDE)}"\ktszk012.h"\
	{$(INCLUDE)}"\kwdxk010.h"\
	{$(INCLUDE)}"\kxwesatr.h"\
	{$(INCLUDE)}"\pctcp.h"\
	{$(INCLUDE)}"\sys\timeb.h"\
	{$(INCLUDE)}"\sys\types.h"\
	{$(INCLUDE)}"\tcppipe.h"\
	
NODEP_CPP_AZGSS=\
	"..\includes\c1cerror.h"\
	

"$(INTDIR)\azgsstub.obj" : $(SOURCE) $(DEP_CPP_AZGSS) "$(INTDIR)"


!ENDIF 

# End Source File
# End Target
# End Project
################################################################################
