/***************************************************************************/
/*                                                                         */
/*                        M O D U L E   F I L E                            */
/*                                                                         */
/*            Copyright (C) 1989, 1990, Andersen Consulting.               */
/*                         All rights reserved.                            */
/*                                                                         */
/***************************************************************************/
/*                                                                         */
/*                      Module File for: AZCD004X                          */
/*                         Generated on: Jul 15, 1992                      */
/*                                   at: 15:37:24                          */
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


 
#define WESMAPNAME _AZCD004XWesMap
#include  "azcd004x.wmp"


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

#include  "azcd004x.gnh"


/****************************************************************************
*                                                                           *
*         AZCD004X Dispatch Tables                                          *
*         Generated on: Jul  2, 1992                                        *
*                   at: 13:53:52                                            *
*                   by: LMISFELD                                            *
*                                                                           *
****************************************************************************/

/****************************************************************************
 Window & Widget Function List
****************************************************************************/

WCBFWD (WINMSGNT)
WCBFWD (APBCANCL)
WCBFWD (WINPRDIS)
WCBFWD (WINPRDES)
WCBFWD (WINREDIS)
WCBFWD (WINOPMEV)
WCBFWD (APBOK)

/****************************************************************************
 Window Dispatch Table
****************************************************************************/

WNDDISPTBL AZCD004XWindDisp[]= {
     {OKPB_CMD,APBOK},
     {CancelPB_CMD,APBCANCL},
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

WDGDISPTBL AZCD004XWidgDisp[]= {
     {0,0,0}
};

WINDEFTBLENTRY AZCD004XWindowDefn = {
     "10",AZCD004XID,"",WTP_WESWINDOW,WMD_MODAL,
     FALSE, WCR_POPUP| WCR_HIDDEN,AZCD004XID,WOP_NOACCEL,WOP_NOMENU,WOP_NOICON,
     0,AZCD004XWidgDisp,AZCD004XWindDisp,0};




/***************************************************************************/
/* Working Storage Definitions and Procedure Forward Declarations          */
/***************************************************************************/

/****************************************************************************
*   
*   Working Storage for: {T235.AZCD004X} (O)
*   Generated on: Jul  2, 1992
*             at: 13:51:44
*             by: LMISFELD
*   
*   Copyright (C) Andersen Consulting, 1992.
*   All rights reserved.
*   
*   Record: AZCD004X
*   Description:
*    This window is a dialog window to enter a message number during  
*    the add process of an error message.                             
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
#include "AZCD004X.cb"

  
/***************************************************************************/
/* User Procedures                                                         */
/***************************************************************************/

