#***************************************************************************
#                                                                          *
#                     O S / 2    M A K E   F I L E                         *
#                                                                          *
#                Copyright (C) 1992, Andersen Consulting.                  *
#                          All rights reserved.                            *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: AZDW01                            *
#                          Generated on: Wed Nov  3 14:43:15 1993          *
#                                    by: CCRAMPTO                          *
#                                                                          *
#***************************************************************************
CFLAGS   =  -c -Zp -Zi -Aluf -G2sc -W3 -Od -MD -DOS2 -Fo$(EA_BIN_DRIVE)\OBJ\ -Gt0 -DFND_OS2
LFLAGS   = /CO
LIBS     = /NOD LLIBCRT+CRTEXE+os2+KZFPSAPI+KZFNTEND+KZFNDCOD+KZFNDAPI+KZMSGAPI+KZDDEAPI+C1CFUNC+ARCHDISP

EA_LOCAL_SRC_DRIVE=c:\data\archunit\src\csrwinnt
EA_LOCAL_BIN_DRIVE=c:\data\archunit\os2\bin
EA_REMOTE_SRC_DRIVE=n:\azdw01
EA_REMOTE_BIN_DRIVE=r:
EA_SRC_DRIVE=$(EA_REMOTE_SRC_DRIVE)
EA_BIN_DRIVE=$(EA_REMOTE_BIN_DRIVE)


#***************************************************************************
#  Steps for construction the AZDW01.exe executable
#***************************************************************************

#***************************************************************************
# Construct the executable
#***************************************************************************
#* CWOODS 10/22/95 : Change exe to EXE
$(EA_BIN_DRIVE)\EXE\AZDW01.EXE : $(EA_BIN_DRIVE)\obj\AZDW01.obj            \
                                 $(EA_SRC_DRIVE)\AZDW01.def   \
                                 $(EA_SRC_DRIVE)\AZDW01.res            \
                                 $(EA_SRC_DRIVE)\AZDW001.obj           \
                                 $(EA_SRC_DRIVE)\AZDW002.obj           \
                                 $(EA_SRC_DRIVE)\AZDW003.obj           \
                                 $(EA_SRC_DRIVE)\AZDW004.obj           \
                                 $(EA_SRC_DRIVE)\AZDW005.obj           \
                                 $(EA_SRC_DRIVE)\AZDW006.obj
    link $(LFLAGS) @<<AZDW01.LNK
$(EA_BIN_DRIVE)\OBJ\AZDW01.obj+
$(EA_BIN_DRIVE)\OBJ\AZDW001.obj+
$(EA_BIN_DRIVE)\OBJ\AZDW002.obj+
$(EA_BIN_DRIVE)\OBJ\AZDW003.obj+
$(EA_BIN_DRIVE)\OBJ\AZDW004.obj+
$(EA_BIN_DRIVE)\OBJ\AZDW005.obj+
$(EA_BIN_DRIVE)\OBJ\AZDW006.obj
$(EA_BIN_DRIVE)\EXE\AZDW01.EXE
NUL
$(LIBS)
$(EA_SRC_DRIVE)\AZDW01.DEF
<<KEEP

#*****************************************************************************
# Link in resources
#*****************************************************************************
#* CWOODS 10/22/95 : changed exe to EXE
    rc $(EA_BIN_DRIVE)\OBJ\AZDW01.res $(EA_BIN_DRIVE)\EXE\AZDW01.EXE

#***************************************************************************
# Compile each window module
#***************************************************************************

# Make C window module AZDW001
$(EA_BIN_DRIVE)\OBJ\AZDW001.obj : $(EA_SRC_DRIVE)\AZDW001.C   \
              $(EA_SRC_DRIVE)\AZDW01B.gnb \
              $(EA_SRC_DRIVE)\AZDW001C.h  \
              $(EA_SRC_DRIVE)\AZDI0400.C  \
              $(EA_SRC_DRIVE)\AZDW001.BUS \
              $(EA_SRC_DRIVE)\AZDW001.BUS \
              $(EA_SRC_DRIVE)\AZDW001.wmp \
              $(EA_SRC_DRIVE)\AZDW001.gnd \
              $(EA_SRC_DRIVE)\AZDW001.gnh \
              $(EA_SRC_DRIVE)\AZDW001.src \
              $(EA_SRC_DRIVE)\AZDW001.aex \
              $(EA_SRC_DRIVE)\AZDW001.bus \
              $(EA_SRC_DRIVE)\AZDW001.vld \
              $(EA_SRC_DRIVE)\AZDW001.h
    cl $(CFLAGS) $(EA_SRC_DRIVE)\AZDW001.C

# Make C window module AZDW002
$(EA_BIN_DRIVE)\OBJ\AZDW002.obj : $(EA_SRC_DRIVE)\AZDW002.C   \
              $(EA_SRC_DRIVE)\AZDW01B.gnb \
              $(EA_SRC_DRIVE)\AZDW002C.h  \
              $(EA_SRC_DRIVE)\AZDW002.BUS \
              $(EA_SRC_DRIVE)\AZDI0400.C  \
              $(EA_SRC_DRIVE)\AZDW002.wmp \
              $(EA_SRC_DRIVE)\AZDW002.gnd \
              $(EA_SRC_DRIVE)\AZDW002.gnh \
              $(EA_SRC_DRIVE)\AZDW002.src \
              $(EA_SRC_DRIVE)\AZDW002.aex \
              $(EA_SRC_DRIVE)\AZDW002.bus \
              $(EA_SRC_DRIVE)\AZDW002.vld \
              $(EA_SRC_DRIVE)\AZDW002.h
    cl $(CFLAGS) $(EA_SRC_DRIVE)\AZDW002.C

# Make C window module AZDW003
$(EA_BIN_DRIVE)\OBJ\AZDW003.obj : $(EA_SRC_DRIVE)\AZDW003.C   \
              $(EA_SRC_DRIVE)\AZDW01B.gnb \
              $(EA_SRC_DRIVE)\AZDW003C.h  \
              $(EA_SRC_DRIVE)\AZDW003.BUS \
              $(EA_SRC_DRIVE)\AZDI0400.C  \
              $(EA_SRC_DRIVE)\AZDW003.wmp \
              $(EA_SRC_DRIVE)\AZDW003.gnd \
              $(EA_SRC_DRIVE)\AZDW003.gnh \
              $(EA_SRC_DRIVE)\AZDW003.src \
              $(EA_SRC_DRIVE)\AZDW003.aex \
              $(EA_SRC_DRIVE)\AZDW003.bus \
              $(EA_SRC_DRIVE)\AZDW003.vld \
              $(EA_SRC_DRIVE)\AZDW003.h
    cl $(CFLAGS) $(EA_SRC_DRIVE)\AZDW003.C

# Make C window module AZDW004
$(EA_BIN_DRIVE)\OBJ\AZDW004.obj : $(EA_SRC_DRIVE)\AZDW004.C   \
              $(EA_SRC_DRIVE)\AZDW01B.gnb \
              $(EA_SRC_DRIVE)\AZDW004C.h  \
              $(EA_SRC_DRIVE)\AZDW004.BUS \
              $(EA_SRC_DRIVE)\AZDI0400.C  \
              $(EA_SRC_DRIVE)\AZDW004.wmp \
              $(EA_SRC_DRIVE)\AZDW004.gnd \
              $(EA_SRC_DRIVE)\AZDW004.gnh \
              $(EA_SRC_DRIVE)\AZDW004.src \
              $(EA_SRC_DRIVE)\AZDW004.aex \
              $(EA_SRC_DRIVE)\AZDW004.bus \
              $(EA_SRC_DRIVE)\AZDW004.vld \
              $(EA_SRC_DRIVE)\AZDW004.h
    cl $(CFLAGS) $(EA_SRC_DRIVE)\AZDW004.C

# Make C window module AZDW005
$(EA_BIN_DRIVE)\OBJ\AZDW005.obj : $(EA_SRC_DRIVE)\AZDW005.C   \
              $(EA_SRC_DRIVE)\AZDW01B.gnb \
              $(EA_SRC_DRIVE)\AZDW005C.h  \
              $(EA_SRC_DRIVE)\AZDW005.BUS \
              $(EA_SRC_DRIVE)\AZDI0400.C  \
              $(EA_SRC_DRIVE)\AZDW005.wmp \
              $(EA_SRC_DRIVE)\AZDW005.gnd \
              $(EA_SRC_DRIVE)\AZDW005.gnh \
              $(EA_SRC_DRIVE)\AZDW005.src \
              $(EA_SRC_DRIVE)\AZDW005.aex \
              $(EA_SRC_DRIVE)\AZDW005.bus \
              $(EA_SRC_DRIVE)\AZDW005.vld \
              $(EA_SRC_DRIVE)\AZDW005.h
    cl $(CFLAGS) $(EA_SRC_DRIVE)\AZDW005.C

# Make C window module AZDW006
$(EA_BIN_DRIVE)\OBJ\AZDW006.obj : $(EA_SRC_DRIVE)\AZDW006.C   \
              $(EA_SRC_DRIVE)\AZDW01B.gnb \
              $(EA_SRC_DRIVE)\AZDW006.wmp \
              $(EA_SRC_DRIVE)\AZDW006.gnd \
              $(EA_SRC_DRIVE)\AZDW006.gnh \
              $(EA_SRC_DRIVE)\AZDW006.src \
              $(EA_SRC_DRIVE)\AZDW006.aex \
              $(EA_SRC_DRIVE)\AZDW006.bus \
              $(EA_SRC_DRIVE)\AZDW006.vld \
              $(EA_SRC_DRIVE)\AZDW006.h
    cl $(CFLAGS) $(EA_SRC_DRIVE)\AZDW006.C


#***************************************************************************
# Compile each service module
#***************************************************************************


#***************************************************************************
# Compile initialization and termination routines
#***************************************************************************



#*****************************************************************************
# Compile resource file 
#*****************************************************************************
$(EA_SRC_DRIVE)\AZDW01.res : $(EA_SRC_DRIVE)\AZDW01.rc  \
      $(EA_SRC_DRIVE)\AZDW001.wct  $(EA_SRC_DRIVE)\AZDW001.dlg   \
      $(EA_SRC_DRIVE)\AZDW002.wct  $(EA_SRC_DRIVE)\AZDW002.dlg   \
      $(EA_SRC_DRIVE)\AZDW003.wct  $(EA_SRC_DRIVE)\AZDW003.dlg   \
      $(EA_SRC_DRIVE)\AZDW004.wct  $(EA_SRC_DRIVE)\AZDW004.dlg   \
      $(EA_SRC_DRIVE)\AZDW005.wct  $(EA_SRC_DRIVE)\AZDW005.dlg   \
      $(EA_SRC_DRIVE)\AZDW006.wct  $(EA_SRC_DRIVE)\AZDW006.dlg
    rc -r AZDW01.rc $(EA_BIN_DRIVE)\OBJ\AZDW01.RES


#***************************************************************************
# Compile the Front End
#***************************************************************************
$(EA_BIN_DRIVE)\OBJ\AZDW01.obj : $(EA_SRC_DRIVE)\AZDW01.c $(EA_SRC_DRIVE)\AZDW01B.gnb
     cl $(CFLAGS) $(EA_SRC_DRIVE)\AZDW01.c
