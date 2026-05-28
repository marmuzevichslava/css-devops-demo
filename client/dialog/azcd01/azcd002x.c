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
/*                      Module File for: AZCD002X                          */
/*                         Generated on: Jul 15, 1992                      */
/*                                   at: 15:37:21                          */
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


 
#define WESMAPNAME _AZCD002XWesMap
#include  "azcd002x.wmp"


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

#include  "azcd002x.gnh"


/****************************************************************************
*                                                                           *
*         AZCD002X Dispatch Tables                                          *
*         Generated on: Jul  3, 1992                                        *
*                   at: 11:37:19                                            *
*                   by: LMISFELD                                            *
*                                                                           *
****************************************************************************/

/****************************************************************************
 Window & Widget Function List
****************************************************************************/

WCBFWD (WINPRDES)
WCBFWD (WINMSGNT)
WCBFWD (WINPRDIS)
WCBFWD (OK)
WCBFWD (SPBVIEW)
WCBFWD (WINREDIS)
WCBFWD (WINOPMEV)

/****************************************************************************
 Window Dispatch Table
****************************************************************************/

WNDDISPTBL AZCD002XWindDisp[]= {
     {OKPushButton_CMD,OK},
     {VIEW_CMD,SPBVIEW},
     {PREDISPLAY,WINPRDIS},
     {MSG_NOTIFICATION,WINMSGNT},
     {OTHER_GUI_EVENT,WINOPMEV},
     {REDISPLAY,WINREDIS},
     {PREDESTROY,WINPRDES},
     {0,0}
};

/****************************************************************************
 Widget Dispatch Table
****************************************************************************/

WDGDISPTBL AZCD002XWidgDisp[]= {
     {0,0,0}
};

WINDEFTBLENTRY AZCD002XWindowDefn = {
     "10",AZCD002XID,"",WTP_WESWINDOW,WMD_MODAL,
     FALSE, WCR_POPUP| WCR_HIDDEN,AZCD002XID,WOP_NOACCEL,WOP_NOMENU,WOP_NOICON,
     0,AZCD002XWidgDisp,AZCD002XWindDisp,0};




/***************************************************************************/
/* Working Storage Definitions and Procedure Forward Declarations          */
/***************************************************************************/

/****************************************************************************
*   
*   Working Storage for: {T235.AZCD002X} (O)
*   Generated on: Jul  2, 1992
*             at: 16:03:55
*             by: LMISFELD
*   
*   Copyright (C) Andersen Consulting, 1992.
*   All rights reserved.
*   
*   Record: AZCD002X
*   Description:
*    This window is a dialog window to display information about an   
*    error message from the error codes table.                        
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
#include "AZCD002X.cb"

  
/***************************************************************************/
/* User Procedures                                                         */
/***************************************************************************/

