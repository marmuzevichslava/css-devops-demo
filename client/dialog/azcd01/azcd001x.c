/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************/
/*                                                                         */
/*                        M O D U L E   F I L E                            */
/*                                                                         */
/*            Copyright (C) 1989, 1990, Andersen Consulting.               */
/*                         All rights reserved.                            */
/*                                                                         */
/***************************************************************************/
/*                                                                         */
/*                      Module File for: AZCD001X                          */
/*                         Generated on: Jul 15, 1992                      */
/*                                   at: 15:37:34                          */
/*                                   by: LMISFELD                            */
/*                                                                         */
/***************************************************************************/

#define WINDOWMOD

  
#include <specdefs.h>   /* for spec ref and deref */

/***************************************************************************/
/*                                                                         */
/* You may need to                                                         */
/*                                                                         */
/*   #define INCL_DOS                                                      */
/*   #define INCL_WIN                                                      */
/*                                                                         */
/* or other constants depending on the APIs used                           */
/* in your window.                                                         */
/*                                                                         */
/***************************************************************************/

/***************************************************************************/
/* Includes for Foundation specific data structures                        */
/* and common routines                                                     */
/***************************************************************************/

#define FND_CD_INCL
#define FND_CF_INCL
#define FND_CT_INCL
#define FND_EH_INCL
#define FND_IM_INCL

#define FND_SD_INCL
#define FND_PS_INCL

#include <os2.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <kglzk000.h>
#include <limits.h>
#include <float.h>

/***************************************************************************/
/* Business Function Context Data Type Definition                          */
/***************************************************************************/
#include  "azcd001x.gnb"


 
#define WESMAPNAME _AZCD001XWesMap
#include  "azcd001x.wmp"


/***************************************************************************/
/* Library Prototype Definitions                                           */
/***************************************************************************/


/***************************************************************************/
/* Header files containing data typedefs                                   */
/***************************************************************************/

/***************************************************************************/
/* Input and output message layouts                                        */
/***************************************************************************/


/***************************************************************************/
/* Include Window Identifiers, Window Defines and Dispatch Tables          */
/***************************************************************************/
#include  "azcd01.gnz"

#include  "azcd001x.gnh"


/****************************************************************************
*                                                                           *
*         AZCD001X Dispatch Tables                                          *
*         Generated on: Jul 15, 1992                                        *
*                   at: 15:36:52                                            *
*                   by: LMISFELD                                            *
*                                                                           *
****************************************************************************/

/****************************************************************************
 Window & Widget Function List
****************************************************************************/

WCBFWD (SLB01LSE)
WCBFWD (E00001FC)
WCBFWD (AMNDEL)
WCBFWD (WINPRDIS)
WCBFWD (WINMSGNT)
WCBFWD (WINSYSCL)
WCBFWD (E00185FC)
WCBFWD (WINREDIS)
WCBFWD (WINOPMEV)
WCBFWD (AMNEXIT)
WCBFWD (SLB01DCK)
WCBFWD (AMNADD)
WCBFWD (APBFIND)
WCBFWD (AMNUPD)
WCBFWD (AMNINQ)
WCBFWD (E00011FC)
WCBFWD (APBPGDN)
WCBFWD (APBPGUP)
WCBFWD (WINPRDES)

/****************************************************************************
 Window Dispatch Table
****************************************************************************/

WNDDISPTBL AZCD001XWindDisp[]= {
     {FindPB_CMD,APBFIND},
     {PageUpPB_CMD,APBPGUP},
     {PageDownPB_CMD,APBPGDN},
     {InquireMN_CMD,AMNINQ},
     {AddMN_CMD,AMNADD},
     {UpdateMN_CMD,AMNUPD},
     {DeleteMN_CMD,AMNDEL},
     {ExitMN_CMD,AMNEXIT},
     {OTHER_GUI_EVENT,WINOPMEV},
     {SYSTEM_MENU_CLOSE,WINSYSCL},
     {PREDESTROY,WINPRDES},
     {MSG_NOTIFICATION,WINMSGNT},
     {PREDISPLAY,WINPRDIS},
     {REDISPLAY,WINREDIS},
     {0,0}
};

/****************************************************************************
 Widget Dispatch Table
****************************************************************************/

WDGDISPTBL AZCD001XWidgDisp[]= {
     {KyErrorMessage_FID,FIELD_CHANGE,E00011FC},
     {TxErrorMsg_FID,FIELD_CHANGE,E00001FC},
     {FlMatchCase_FID,FIELD_CHANGE,E00185FC},
     {ErrMsgLB_FID,LIST_SELECT,SLB01LSE},
     {ErrMsgLB_FID,DOUBLE_CLICK,SLB01DCK},
     {0,0,0}
};

WINDEFTBLENTRY AZCD001XWindowDefn = {
     "10",AZCD001XID,"",WTP_WESWINDOW,WMD_MODELESS,
     FALSE, WCR_MAINWINDOW,AZCD001XID,AZCD001XAccelID,AZCD001XMenuID,AZCD001XIconID,
     0,AZCD001XWidgDisp,AZCD001XWindDisp,0};




/***************************************************************************/
/* Working Storage Definitions and Procedure Forward Declarations          */
/***************************************************************************/

/****************************************************************************
*   
*   Working Storage for: {T235.AZCD001X} (O)
*   Generated on: Jul 15, 1992
*             at: 15:36:31
*             by: LMISFELD
*   
*   Copyright (C) Andersen Consulting, 1992.
*   All rights reserved.
*   
*   Record: AZCD001X
*   Description:
*    This window is the top window to search for the error message tha
*    can be inquired, updated, added or deleted from the Codes Table. 
*   
****************************************************************************/



#define FND_BFCD_SIZE sizeof(_BFCD) 




/***************************************************************************/
/* Include Callbacks And Window Forward Declarations                       */
/* if this is a window module                                              */
/***************************************************************************/
 
/***************************************************************************/
/* Include Non-Repository Defined Callbacks                                */
/* if this is a window module                                              */
/***************************************************************************/
 



/***************************************************************************/
/* CUSTOMER/1 Cooperative Window/Service Source File Include		   */
/***************************************************************************/
#include "AZCD001X.cb"

  
/***************************************************************************/
/* User Procedures                                                         */
/***************************************************************************/
