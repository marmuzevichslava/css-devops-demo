/***************************************************************************
 *                                                                         *
 *                     P R O G R A M   F R O N T   E N D                   *
 *                                                                         *
 *                  Copyright (C) 1994 Andersen Consulting.                *
 *                         All rights reserved.                            *
 *                                                                         *
 ***************************************************************************
 *                                                                         *
 *                Program Front End for: dzba01                            *
 *                         Generated on: Sun Jul  7 15:23:39 1996          *
 *                                   by: IPEREZAR                          *
 *                                                                         *
 ***************************************************************************/

#define  INCL_WIN

#define  FND_VERSION2
#define  FND_FE_INCL
#define  FND_IM_INCL
#define  FND_EH_INCL
#define  FND_PS_INCL

/***************************************************************************
 * Foundation Application Information                                      *
 ***************************************************************************/
#define  FND_PROGRAM_NAME        "dzba01"
#define  FND_APPL_VERSION        "21"
#define  FND_APPL_QUEUE          UNSOLICITED_Q_AU
#define  FND_PROGRAM_TYPE        FND_APPL_TYPE_SERVER
#define  FND_PROGRAM_LANG        FND_COBOL_LANG
#define  FND_DBMS                FND_DB_ORACLE
#define  FND_PORTABILITY_FLAG    0

/***************************************************************************
 * Register with Foundation services                                       *
 ***************************************************************************/
#define REGISTER_WITH_MM         1
#define REGISTER_WITH_EL         0
#define REGISTER_WITH_ST         1
#define REGISTER_WITH_MN         1

/***************************************************************************
 * User Supplied Definitions.                                              *
 ***************************************************************************/

/***************************************************************************
 * System Headers                                                          *
 ***************************************************************************/
#include <string.h>
#include <stdio.h>

/*************************************************************************** 
 * Foundation Global Header File                                           *
 ***************************************************************************/
#include <kglhk000.h>

/***************************************************************************
 * Business Function Context Data declaration.                             *
 ***************************************************************************/
#if FND_PROGRAM_LANG == FND_COBOL_LANG
#define _BFCD            void
#define FND_BFCD_SIZE    64000      /* Cobol default for BFCD */
#else
#define _BFCD            void
#define FND_BFCD_SIZE    0
#endif

/***************************************************************************
 *  Service, Initialization and Termination Function Prototypes            *
 ***************************************************************************/
extern FND_FUNCTION DZBA001;



/***************************************************************************
 * Window definition tables                                                *
 ***************************************************************************/
#include "dzba01.wdt"

/***************************************************************************
 * Service dispatch table                                                  *
 ***************************************************************************/
#include "dzba01.sdt"

/***************************************************************************
 * User Includes.                                                          *
 ***************************************************************************/



int main(int argc, char *argv[])
{

/***************************************************************************
 * Application Interface Initialization                                    *
 ***************************************************************************/
   APPL_INIT_DATA  applInitData;
   unsigned short  returnStatus;
   
   printf("ENTERED BAEXT FRONT END.\n");

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
   applInitData.GUI_Message_Q_Len        = MAX_GUI_Q_SIZE;
   applInitData.ProgLang                 = FND_PROGRAM_LANG;
   applInitData.WinOriginPortability     = FND_PORTABILITY_FLAG;
   applInitData.DynamicAppl              = NULL;
   applInitData.DynamicFree              = NULL;
   applInitData.DynamicSrv               = 0;

   printf("Calling Application %s.\n",argv[0]);

   FND_Application(argc,argv,&applInitData,returnStatus);

   return 0;
}
