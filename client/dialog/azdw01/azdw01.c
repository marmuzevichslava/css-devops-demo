/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
 *                                                                         *
 *                     P R O G R A M   F R O N T   E N D                   *
 *                                                                         *
 *                  Copyright (C) 1992 Andersen Consulting.                *
 *                         All rights reserved.                            *
 *                                                                         *
 ***************************************************************************
 *                                                                         *
 *                Program Front End for: AZDW01                            *
 *                         Generated on: Wed Nov  3 14:43:18 1993          *
 *                                   by: CCRAMPTO                          *
 *                                                                         *
 ***************************************************************************/

#define  INCL_WIN
#include <os2.h>
#include <string.h>
#include <stdio.h>
#include <float.h>
#include <limits.h>

#define  FND_VERSION2
#define  FND_FE_INCL
#define  FND_IM_INCL
#define  FND_EH_INCL
#define  FND_PS_INCL


/***************************************************************************
 * Foundation Application Information                                      *
 ***************************************************************************/
#define  FND_PROGRAM_NAME        "AZDW01"
#define  FND_APPL_VERSION        "20"
#define  FND_APPL_QUEUE          UNSOLICITED_Q_AU
#define  FND_PROGRAM_TYPE        FND_APPL_TYPE_CLIENT
#define  FND_PROGRAM_LANG        FND_C_LANG
#define  FND_DBMS                FND_DB_NONE
#define  FND_PORTABILITY_FLAG    FALSE

/***************************************************************************
 * Register with Foundation services                                       *
 ***************************************************************************/
#define REGISTER_WITH_MM         FALSE
#define REGISTER_WITH_EL         FALSE
#define REGISTER_WITH_ST         TRUE
#define REGISTER_WITH_MN         TRUE

/*************************************************************************** 
 * Foundation Global Header File                                           *
 ***************************************************************************/
#ifdef OS2
#include <kglzk000.h>
#endif

#ifdef VAX
#include <kglvk000.h>
#endif

#ifdef FND_HPUX
#include <kglhk000.h>
#endif

#ifdef ULTRIX
#include <kgluk000.h>
#endif

/***************************************************************************
 * Business Function Context Data declaration.                             *
 ***************************************************************************/
#if FND_PROGRAM_LANG == FND_COBOL_LANG
#define _BFCD            void
#define FND_BFCD_SIZE    64000      /* Cobol default for BFCD */
#else
#include "azdw01b.gnb"

#endif

/***************************************************************************
 *  Service, Initialization and Termination Function Prototypes            *
 ***************************************************************************/


/***************************************************************************
 * Window definition tables                                                *
 ***************************************************************************/
#include "azdw01.wdt"

/***************************************************************************
 * Service dispatch table                                                  *
 ***************************************************************************/
#include "azdw01.sdt"


int cdecl main(int argc, char *argv[])
{
/***************************************************************************
 * Application Interface Initialization                                    *
 ***************************************************************************/
   APPL_INIT_DATA  applInitData;
   unsigned short  returnStatus;
   
   memcpy(applInitData.version,            FND_APPL_VERSION, _VER_LEN);
   memcpy(applInitData.programName,        FND_PROGRAM_NAME, _PROG_NAME_LEN);
   applInitData.programType              = FND_PROGRAM_TYPE;
   memcpy(applInitData.applQueue,          FND_APPL_QUEUE,   _PORT_LEN);
   applInitData.initFlags.registerWithMM = REGISTER_WITH_MM;
   applInitData.initFlags.registerWithEL = REGISTER_WITH_EL;
   applInitData.initFlags.registerWithST = REGISTER_WITH_ST;
   applInitData.initFlags.registerWithMN = REGISTER_WITH_MN;
   applInitData.initRoutine              = FND_PROGRAM_INIT_ROUTINE;
   applInitData.termRoutine              = FND_PROGRAM_TERM_ROUTINE;
   applInitData.initUIRoutine            = FND_INTERFACE_INIT_ROUTINE;
   applInitData.termUIRoutine            = FND_INTERFACE_TERM_ROUTINE;
   applInitData.applDispatchTable        = dispatchTable;
   applInitData.numApplMessages = sizeof(dispatchTable)/sizeof(_FE_MSG_DISPATCH_RECORD);
   applInitData.pBFCD                    = NULL;
   applInitData.bfcdSize                 = FND_BFCD_SIZE;
   applInitData.applicationID            = FND_APPL_ID;
   strcpy(applInitData.DatabaseDLL,        FND_DBMS);
   applInitData.pWindowsInDLL            = pWindowsInDLLs;
   applInitData.pWindows                 = ExeWindowTable;
   applInitData.pCBLWindows              = CBLwindowSetupTable;
   applInitData.GUI_Message_Q_Len        = MAX_PM_Q_SIZE;
   applInitData.ProgLang                 = FND_PROGRAM_LANG;
   applInitData.WinOriginPortability     = TRUE;
   applInitData.DynamicAppl              = NULL;
   applInitData.DynamicFree              = NULL;
   applInitData.DynamicSrv               = 0;

   FND_Application(argc,argv,&applInitData,returnStatus);

   return 0;
}
