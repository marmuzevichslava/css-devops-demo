#***************************************************************************
#                                                                          *
#                           M A K E   F I L E                              *
#                                                                          *
#             Copyright (C) 1989, 1990, Andersen Consulting.               *
#                          All rights reserved.                            *
#                                                                          *
#***************************************************************************
#                                                                          *
#                         Make file for: AZCD01                            *
#                             Generated: Jul 15, 1992                      *
#                                    at: 15:37:30                          *
#                                    by: LMISFELD                            *
#                                                                          *
#***************************************************************************

CFLAGS   =  -c -Zip -Aluf -G2sc -W3 -Od -MD
LFLAGS   = /CO
LIBS     = /NOD LLIBCRT+CRTEXE+os2+KZFPSAPI+KZFNTEND+KZFNDCOD+KZFNDAPI+KZMSGAPI+C1CFUNC

#***************************************************************************
#  Steps for "Making" Executable                                           *
#***************************************************************************

# construct Program executable
AZCD01.exe : AZCD01.obj  AZCD01.def AZCD01.res AZCD001X.obj AZCD002X.obj AZCD003X.obj AZCD004X.obj 
    link $(LFLAGS) AZCD01 @AZCD01.lnk,AZCD01,NUL,$(LIBS),AZCD01
    rc AZCD01.res AZCD01.exe

# compile each window module
azcd001x.obj : azcd001x.c azcd001x.wmp 
  cl $(CFLAGS) azcd001x.c

azcd002x.obj : azcd002x.c azcd002x.wmp 
  cl $(CFLAGS) azcd002x.c

azcd003x.obj : azcd003x.c azcd003x.wmp 
  cl $(CFLAGS) azcd003x.c

azcd004x.obj : azcd004x.c azcd004x.wmp 
  cl $(CFLAGS) azcd004x.c



# compile each service module


# compile resource file
AZCD01.res : AZCD01.rc azcd001x.dlg azcd002x.dlg azcd003x.dlg azcd004x.dlg  azcd001x.wct azcd002x.wct azcd003x.wct azcd004x.wct 
    rc -r AZCD01.rc

# compile main Program program module

AZCD01.obj  : AZCD01.c 
     cl $(CFLAGS) AZCD01.c
