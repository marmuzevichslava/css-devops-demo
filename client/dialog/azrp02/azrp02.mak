#***************************************************************************
#                                                                          *
#                W I N D O W S   N T   M A K E   F I L E                   *
#                                                                          *
#                Copyright (C) 1994, Andersen Consulting.                  *
#                          All rights reserved.                            *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: AZRP02                            *
#                          Generated on: Fri Mar 29 09:26:24 1996          *
#                                    by: MCONNER                           *
#                                                                          *
#***************************************************************************

PROJ = AZRP02
EXEDIR = r:\exe
OBJDIR = r:\obj
PROJDIR = n:\azrp02nt

!ifndef DEBUG
DEBUG = 1
!endif

CC = cl
RC = rc
LINK = link

CFLAGS_D = /c /W3 /Zip /Od /D "_DEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D "FND_WIN32" /MD /Fd"$(EXEDIR)\$(PROJ).PDB" 
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


# Make C frontend dependencies AZRP02
AZRP02_DEP =  $(PROJDIR)\AZRP02.sdt $(PROJDIR)\AZRP02.wdt


# Make C window module AZRP001X
AZRP001X_DEP = $(PROJDIR)\AZRP001X.c	\
		$(PROJDIR)\AZRP001C.h	\
		n:\archinc\AZRP001M.h	\
		$(PROJDIR)\AZRP002O.h	\
		$(PROJDIR)\AZRP003O.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZRP001.BUS    \
                $(PROJDIR)\AZRP001.aex     \
                $(PROJDIR)\AZRP001.h       \
                $(PROJDIR)\AZRP001.wmp     \
                $(PROJDIR)\AZRP001.gnd     \
                $(PROJDIR)\AZRP001.gnh     \
                $(PROJDIR)\AZRP02.gnz        \
                $(PROJDIR)\AZRP001.src
# Make C window module AZRP002X
AZRP002X_DEP = $(PROJDIR)\AZRP002X.c	\
		$(PROJDIR)\AZRP002C.h	\
		$(PROJDIR)\AZRP002O.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZRP002.BUS    \
                $(PROJDIR)\AZRP002.aex     \
                $(PROJDIR)\AZRP002.h       \
                $(PROJDIR)\AZRP002.wmp     \
                $(PROJDIR)\AZRP002.gnd     \
                $(PROJDIR)\AZRP002.gnh     \
                $(PROJDIR)\AZRP02.gnz        \
                $(PROJDIR)\AZRP002.src
# Make C window module AZRP003X
AZRP003X_DEP = $(PROJDIR)\AZRP003X.c	\
		$(PROJDIR)\AZRP003C.h	\
		$(PROJDIR)\AZRP003O.h	\
		$(PROJDIR)\AZDI0400.C	\
		$(PROJDIR)\AZRP003.BUS    \
                $(PROJDIR)\AZRP003.aex     \
                $(PROJDIR)\AZRP003.h       \
                $(PROJDIR)\AZRP003.wmp     \
                $(PROJDIR)\AZRP003.gnd     \
                $(PROJDIR)\AZRP003.gnh     \
                $(PROJDIR)\AZRP02.gnz        \
                $(PROJDIR)\AZRP003.src



# Make RC dependencies for AZRP02
AZRP02_RCDEP = $(PROJDIR)\AZRP02.gnz    \
               $(PROJDIR)\AZRP001.dlg  \
               $(PROJDIR)\AZRP002.dlg  \
               $(PROJDIR)\AZRP003.dlg 


#***************************************************************************
#  Steps for construction of AZRP02.EXE 
#***************************************************************************
all:	$(EXEDIR)\$(PROJ).EXE

#***************************************************************************
# Compile the Front End
#***************************************************************************
$(OBJDIR)\AZRP02.obj : $(PROJDIR)\AZRP02.C $(AZRP02_DEP)
     $(CC) $(CFLAGS) -Fo$(OBJDIR)\AZRP02.obj $(PROJDIR)\AZRP02.C

#***************************************************************************
# Compile each window module
#***************************************************************************

# Make C window module AZRP001X
$(OBJDIR)\AZRP001X.obj : $(AZRP001X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZRP001X.obj $(PROJDIR)\AZRP001X.c

# Make C window module AZRP002X
$(OBJDIR)\AZRP002X.obj : $(AZRP002X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZRP002X.obj $(PROJDIR)\AZRP002X.c

# Make C window module AZRP003X
$(OBJDIR)\AZRP003X.obj : $(AZRP003X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo$(OBJDIR)\AZRP003X.obj $(PROJDIR)\AZRP003X.c


#***************************************************************************
# Compile the executable resource file
#***************************************************************************
$(OBJDIR)\AZRP02.res:   $(PROJDIR)\AZRP02.RC $(AZRP02_RCDEP)
   $(RC) $(RCFLAGS) $(RCDEFINES) -Fo$(OBJDIR)\AZRP02.res $(PROJDIR)\AZRP02.RC

#***************************************************************************
# Compile each service module
#***************************************************************************


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************





#***************************************************************************
# Construct the executable
#***************************************************************************

$(EXEDIR)\$(PROJ).EXE :  $(OBJDIR)\AZRP02.obj $(OBJDIR)\AZRP02.res 	\
		$(OBJDIR)\AZRP001X.obj 	\
		$(OBJDIR)\AZRP002X.obj 	\
		$(OBJDIR)\AZRP003X.obj 
    link $(LFLAGS) @<<
/OUT:$(EXEDIR)\$(PROJ).EXE
$(OBJDIR)\AZRP02.obj
      $(OBJDIR)\AZRP001X.obj
      $(OBJDIR)\AZRP002X.obj
      $(OBJDIR)\AZRP003X.obj

$(OBJDIR)\AZRP02.res
$(ALL_LIBS)

<<

