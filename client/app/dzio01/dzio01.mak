#***************************************************************************
#                                                                          *
#                W I N D O W S   N T   M A K E   F I L E                   *
#                                                                          *
#    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: DZIO01                            *
#                          Generated on: Tue Oct 01 09:25:43 1996          *
#                                    by: IPEREZAR                          *
#                     Short Description:                                   *
#                                                                          *
#***************************************************************************

PROJ = DZIO01

!ifndef DEBUG
DEBUG = 1
!endif

CC = cl
RC = rc
LINK = link


CFLAGS_D = /c /W3 /Zp1 /Zip /Od /D "_DEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D "FND_WIN32" /MD /Fd"$(PROJ).PDB" 
CFLAGS_R = /c /W3 /Zp1 /O2 /D "NDEBUG" /D "_X86_" /D "STRICT" /D "WIN32" /D "FND_WIN32" /MD 
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

LIBS     = user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib \
           ktfpsapi.lib ktfntend.lib ktfndcod.lib ktfndapi.lib ktmsgapi.lib ktddeapi.lib

NODBLIBS = kndbnul.lib
OTHLIBS  = othelibs
DLLLIBS  =
USRLIBS  = archdisp.LIB c1cfunc.LIB cssfunc.LIB
ALL_LIBS = $(LIBS)   $(DLLLIBS) $(USRLIBS)

#***************************************************************************
#  Dependencies for each of the executable components
#***************************************************************************


# Make C frontend dependencies DZIO01
DZIO01_DEP = DZIO01B.gnb DZIO01.sdt DZIO01.wdt



# Make C window module DZIO001X
DZIO001X_DEP = DZIO001X.c	\
		DZIO01B.gnb	\
		DZIO001C.h	\
		DZCL002I.h	\
		DZCL002O.h	\
		DZCR002I.h	\
		DZCR002O.h	\
		DZIO002O.h	\
		DZIO005I.h	\
		DZIO005O.h	\
		DZIO007O.h	\
		.\AZDI0400.C	\
		.\DZIO001.BUS    \
                DZIO001.aex     \
                DZIO001.h       \
                DZIO001.wmp     \
                DZIO001.gnd     \
                DZIO001.gnh     \
                DZIO01.gnz        \
                DZIO001.src

# Make C window module DZIO002X
DZIO002X_DEP = DZIO002X.c	\
		DZIO01B.gnb	\
		DZIO002C.h	\
		DZIO002O.h	\
		.\AZDI0400.C	\
		.\DZIO002.BUS    \
                DZIO002.aex     \
                DZIO002.h       \
                DZIO002.wmp     \
                DZIO002.gnd     \
                DZIO002.gnh     \
                DZIO01.gnz        \
                DZIO002.src

# Make C window module DZIO005X
DZIO005X_DEP = DZIO005X.c	\
		DZIO01B.gnb	\
		DZIO005C.h	\
		DZIO002O.h	\
		DZIO005I.h	\
		DZIO005O.h	\
		.\AZDI0400.C	\
		.\DZIO005.BUS    \
                DZIO005.aex     \
                DZIO005.h       \
                DZIO005.wmp     \
                DZIO005.gnd     \
                DZIO005.gnh     \
                DZIO01.gnz        \
                DZIO005.src

# Make C window module DZIO007X
DZIO007X_DEP = DZIO007X.c	\
		DZIO01B.gnb	\
		DZIO007C.h	\
		AZRP001M.h	\
		.\AZDI0400.C	\
		.\DZIO007.BUS    \
                DZIO007.aex     \
                DZIO007.h       \
                DZIO007.wmp     \
                DZIO007.gnd     \
                DZIO007.gnh     \
                DZIO01.gnz        \
                DZIO007.src

# Make C window module DZIO008X
DZIO008X_DEP = DZIO008X.c	\
		DZIO01B.gnb	\
		DZIO008C.h	\
		AZRP001M.h	\
		.\AZDI0400.C	\
		.\DZIO008.BUS    \
                DZIO008.aex     \
                DZIO008.h       \
                DZIO008.wmp     \
                DZIO008.gnd     \
                DZIO008.gnh     \
                DZIO01.gnz        \
                DZIO008.src

# Make C window module DZIO009X
DZIO009X_DEP = DZIO009X.c	\
		DZIO01B.gnb	\
		DZIO009C.h	\
		DZCR002I.h	\
		DZCR002O.h	\
		.\AZDI0400.C	\
		.\DZIO009.BUS    \
                DZIO009.aex     \
                DZIO009.h       \
                DZIO009.wmp     \
                DZIO009.gnd     \
                DZIO009.gnh     \
                DZIO01.gnz        \
                DZIO009.src

# Make C window module DZIO012X
DZIO012X_DEP = DZIO012X.c	\
		DZIO01B.gnb	\
		AZRP001M.h	\
		DZIO012C.h	\
		DZIO012I.h	\
		DZIO012O.h	\
		.\AZDI0400.C	\
		.\DZIO012.BUS    \
                DZIO012.aex     \
                DZIO012.h       \
                DZIO012.wmp     \
                DZIO012.gnd     \
                DZIO012.gnh     \
                DZIO01.gnz        \
                DZIO012.src

# Make C window module DZIO013X
DZIO013X_DEP = DZIO013X.c	\
		DZIO01B.gnb	\
		AZRP001M.h	\
		DZIO013C.h	\
		DZIO013I.h	\
		DZIO013O.h	\
		.\AZDI0400.C	\
		.\DZIO013.BUS    \
                DZIO013.aex     \
                DZIO013.h       \
                DZIO013.wmp     \
                DZIO013.gnd     \
                DZIO013.gnh     \
                DZIO01.gnz        \
                DZIO013.src

# Make C window module DZIO014X
DZIO014X_DEP = DZIO014X.c	\
		DZIO01B.gnb	\
		AZRP001M.h	\
		DZIO014C.h	\
		DZIO014I.h	\
		DZIO014O.h	\
		.\DZIO014.BUS	\
		.\AZDI0400.C    \
                DZIO014.aex     \
                DZIO014.h       \
                DZIO014.wmp     \
                DZIO014.gnd     \
                DZIO014.gnh     \
                DZIO01.gnz        \
                DZIO014.src



# Make RC dependencies for DZIO01
DZIO01_RCDEP = DZIO01.gnz    \
               DZIO001.dlg  \
               DZIO002.dlg  \
               DZIO005.dlg  \
               DZIO007.dlg  \
               DZIO008.dlg  \
               DZIO009.dlg  \
               DZIO012.dlg  \
               DZIO013.dlg  \
               DZIO014.dlg 


#***************************************************************************
#  Steps for construction of DZIO01.EXE 
#***************************************************************************
all:	.\$(PROJ).EXE

#***************************************************************************
# Compile the Front End
#***************************************************************************
.\DZIO01.obj : DZIO01.C $(DZIO01_DEP)
     $(CC) $(CFLAGS) -Fo.\DZIO01.obj DZIO01.C

#***************************************************************************
# Compile each window module
#***************************************************************************

# Make C window module DZIO001X
.\DZIO001X.obj : $(DZIO001X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZIO001X.obj DZIO001X.c

# Make C window module DZIO002X
.\DZIO002X.obj : $(DZIO002X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZIO002X.obj DZIO002X.c

# Make C window module DZIO005X
.\DZIO005X.obj : $(DZIO005X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZIO005X.obj DZIO005X.c

# Make C window module DZIO007X
.\DZIO007X.obj : $(DZIO007X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZIO007X.obj DZIO007X.c

# Make C window module DZIO008X
.\DZIO008X.obj : $(DZIO008X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZIO008X.obj DZIO008X.c

# Make C window module DZIO009X
.\DZIO009X.obj : $(DZIO009X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZIO009X.obj DZIO009X.c

# Make C window module DZIO012X
.\DZIO012X.obj : $(DZIO012X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZIO012X.obj DZIO012X.c

# Make C window module DZIO013X
.\DZIO013X.obj : $(DZIO013X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZIO013X.obj DZIO013X.c

# Make C window module DZIO014X
.\DZIO014X.obj : $(DZIO014X_DEP)
    $(CC) $(CFLAGS) /I.\ /Fo.\DZIO014X.obj DZIO014X.c


#***************************************************************************
# Compile the executable resource file
#***************************************************************************
.\DZIO01.res:   DZIO01.RC $(DZIO01_RCDEP)
   $(RC) $(RCFLAGS) $(RCDEFINES) -Fo.\DZIO01.res DZIO01.RC


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************





#***************************************************************************
# Construct the executable
#***************************************************************************

.\$(PROJ).EXE :  .\DZIO01.obj .\DZIO01.res 	\
		.\DZIO001X.obj 	\
		.\DZIO002X.obj 	\
		.\DZIO005X.obj 	\
		.\DZIO007X.obj 	\
		.\DZIO008X.obj 	\
		.\DZIO009X.obj 	\
		.\DZIO012X.obj 	\
		.\DZIO013X.obj 	\
		.\DZIO014X.obj 
    link $(LFLAGS) @<<
/OUT:.\$(PROJ).EXE
.\DZIO01.obj
      .\DZIO001X.obj
      .\DZIO002X.obj
      .\DZIO005X.obj
      .\DZIO007X.obj
      .\DZIO008X.obj
      .\DZIO009X.obj
      .\DZIO012X.obj
      .\DZIO013X.obj
      .\DZIO014X.obj

.\DZIO01.res
$(ALL_LIBS)

<<

