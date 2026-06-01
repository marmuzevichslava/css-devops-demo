#-------------------------------------------------------------------------
#
#   Make File
#
#   Filename: AZDI02.MAK
#
#   Description:    Make file for CSS Diagnostics Tool
#
#   Author: David A. Kolodziejski, Andersen Consulting
#
#   Date Created:  Feb 13, 1995
#
#   Date         By       Sir#   Description
# --------  ------------ ------  -----------------------------------------
# 04/12/95  D. Kolodziejski      Creation
#
#--------------------------------------------------------------------------

#--------------------------------------------------------------------------
#
#   Project Name
#
#--------------------------------------------------------------------------
PROJ = AZDI02
SOURCE = $(PROJ)

#--------------------------------------------------------------------------
#
#   Library List
#
#--------------------------------------------------------------------------
LIBS_OS2 = os2+llibce+KZFPSAPI+KZFNTEND+KZFNDCOD+KZFNDAPI+KZMSGAPI+KZDDEAPI+C1CFUNC

#LIBS_WIN32 = msvcrt.lib kernel32.lib user32.lib gdi32.lib \
#             winspool.lib comdlg32.lib \
#             advapi32.lib olecli32.lib olesvr32.lib shell32.lib wsock32.lib \
#             ktfpsapi.lib ktfntend.lib ktfndcod.lib ktfndapi.lib \
#             ktmsgapi.lib ktddeapi.lib c1cfunc.lib pmfapi32.lib mpr.lib

#JOM - 09/20/96 - Removed olecli32.lib olesvr32.lib.
LIBS_WIN32 = msvcrt.lib kernel32.lib user32.lib gdi32.lib \
             winspool.lib comdlg32.lib \
             advapi32.lib shell32.lib wsock32.lib \
             ktfpsapi.lib ktfntend.lib ktfndcod.lib ktfndapi.lib \
             ktmsgapi.lib ktddeapi.lib c1cfunc.lib pmfapi32.lib mpr.lib \
			 azdiext.lib

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
AZDI02 = $(OBJDIR)\AZDI02.OBJ
AZDI0201 = $(OBJDIR)\AZDI0201.OBJ
AZDI0202 = $(OBJDIR)\AZDI0202.OBJ
AZDI0203 = $(OBJDIR)\AZDI0203.OBJ
AZDI0204 = $(OBJDIR)\AZDI0204.OBJ
AZDI0205 = $(OBJDIR)\AZDI0205.OBJ
AZDI0206 = $(OBJDIR)\AZDI0206.OBJ
AZDI0207 = $(OBJDIR)\AZDI0207.OBJ
AZDI0208 = $(OBJDIR)\AZDI0208.OBJ
AZDI0209 = $(OBJDIR)\AZDI0209.OBJ
AZDI0210 = $(OBJDIR)\AZDI0210.OBJ
BURSTNT = $(OBJDIR)\BURSTNT.OBJ

#--------------------------------------------------------------------------
#
#   Create the NT executable
#
#--------------------------------------------------------------------------
!if "$(PLATFORM)" == "WIN32"

$(EXE_FILE) : $(MAK_FILE) $(AZDI02) \
				$(AZDI0201) \
				$(AZDI0202) \
				$(AZDI0203) \
				$(AZDI0204) \
				$(AZDI0205) \
				$(AZDI0206) \
				$(AZDI0207) \
				$(AZDI0208) \
				$(AZDI0209) \
				$(AZDI0210) \
				$(BURSTNT)
    link @<<
$(LFLAGS)
$(AZDI02)
$(AZDI0201) 
$(AZDI0202) 
$(AZDI0203) 
$(AZDI0204) 
$(AZDI0205) 
$(AZDI0206) 
$(AZDI0207) 
$(AZDI0208) 
$(AZDI0209) 
$(AZDI0210) 
$(BURSTNT)
$(LIBS)
<<
!endif

#--------------------------------------------------------------------------
#
#   Create the OBJ file based upon the inference rules defined
#       in EAXBUILD.MAK
#
#--------------------------------------------------------------------------

$(AZDI02) :
$(AZDI0201) :
$(AZDI0202) :
$(AZDI0203) :
$(AZDI0204) :
$(AZDI0205) :
$(AZDI0206) :
$(AZDI0207) :
$(AZDI0208) :
$(AZDI0209) :
$(AZDI0210) :
$(BURSTNT)  :

