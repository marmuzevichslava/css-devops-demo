#-------------------------------------------------------------------------
#
#   Make File
#
#   Filename: AZSS01.MAK
#
#   Description:    Make file for Session Data Creation
#
#   Author: Lou Misfeldt, Florida Power Corporation
#
#   Date Created:  Aug 22, 1994
#
#   Date         By       Sir#   Description
# --------  ------------ ------  -----------------------------------------
# 08/22/94  L. Misfeldt          Creation
# 12/01/94  L. Misfeldt          Conversion to use EAXBUILD.MAK to allow
#                                  a build for either OS/2 or Windows NT.
#
#--------------------------------------------------------------------------

#--------------------------------------------------------------------------
#
#   Project Name
#
#--------------------------------------------------------------------------
PROJ = AZSS01

#--------------------------------------------------------------------------
#
#   Library List
#
#--------------------------------------------------------------------------
LIBS_OS2 = os2+llibcrt+crtexe+KZFPSAPI+KZFNTEND+KZFNDCOD+KZFNDAPI+KZMSGAPI+KZDDEAPI+C1CFUNC+PMFOS2

LIBS_WIN32 = msvcrt.lib kernel32.lib user32.lib gdi32.lib \
             winspool.lib comdlg32.lib \
             advapi32.lib shell32.lib wsock32.lib \
             ktfpsapi.lib ktfntend.lib ktfndcod.lib ktfndapi.lib \
             ktmsgapi.lib ktddeapi.lib c1cfunc.lib pmfapi32.lib

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
AZSS01 = $(R_OBJ)\AZSS01.obj
DEF_FILE = $(R_SRC)\$(PROJ).def

#--------------------------------------------------------------------------
#
#   Create the NT executable
#
#--------------------------------------------------------------------------
!if "$(PLATFORM)" == "WIN32"

$(EXE_FILE) : $(MAK_FILE) $(AZSS01)
    link @<<
$(LFLAGS)
$(AZSS01)
$(LIBS)
<<
!endif

#--------------------------------------------------------------------------
#
#   Create the OS/2 executable
#
#--------------------------------------------------------------------------
!if "$(PLATFORM)" == "OS2"

$(EXE_FILE) : $(DEF_FILE) $(MAK_FILE) $(AZSS01)
    link $(LFLAGS) @<<
$(AZSS01)
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

$(AZSS01) :
