/***************************************************************************
 *                                                                         *
 *                     P R O G R A M   F R O N T   E N D                   *
 *                                                                         *
 *                  Copyright (C) 1996 Andersen Consulting.                *
 *                         All rights reserved.                            *
 *                                                                         *
 ***************************************************************************
 *                                                                         *
 *                Program Front End for: DZSM01                            *                        
 *                         Generated on: Tue Mar 31 15:52:40 1998          *  
 *                                   by: MCONNER                           *     
 *                                                                         *
 *                    Short Description:                                   *             
 *                                                                         *
 ***************************************************************************/

#define  FND_FE_INCL
#define  FND_IM_INCL
#define  FND_EH_INCL
#define  FND_PS_INCL
#define  FND_CF_INCL

/***************************************************************************
 * Foundation Application Information                                      *
 ***************************************************************************/
#define  FND_PROGRAM_NAME        "DZSM01"
#define  FND_APPL_VERSION        "21"
#define  FND_APPL_QUEUE          UNSOLICITED_Q_AW
#define  FND_PROGRAM_TYPE        FND_APPL_TYPE_CLIENT
#define  FND_PROGRAM_LANG        FND_C_LANG
#define  FND_DBMS                FND_DB_NONE
#define  FND_PORTABILITY_FLAG    FALSE
#define  FND_WINDOW_NAME         ""

/***************************************************************************
 * Register with Foundation services                                       *
 ***************************************************************************/
#define REGISTER_WITH_MM         FALSE
#define REGISTER_WITH_EL         FALSE
#define REGISTER_WITH_ST         TRUE
#define REGISTER_WITH_MN         TRUE

/***************************************************************************
 * User Supplied Definitions.                                              *
 ***************************************************************************/

/***************************************************************************
 * System Headers                                                          *
 ***************************************************************************/
#include <windows.h>
#include <stdlib.h>
#include <string.h>

/*************************************************************************** 
 * Foundation Global Header File                                           *
 ***************************************************************************/
#include <kglxk000.h>

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


/***************************************************************************
 * Service dispatch table                                                  *
 ***************************************************************************/
#include "DZSM01.sdt"

/***************************************************************************
 * User Includes.                                                          *
 ***************************************************************************/


int WINAPI WinMain (HINSTANCE hInstance,      /* current instance handle        */
                    HINSTANCE hPrevInstance,  /* previous instance handle       */
                    LPSTR     lpCmdLine,      /* command line                   */
                    int       nCmdShow )      /* show window type (open or icon)*/
{
/***************************************************************************
 * Window definition tables                                                *
 ***************************************************************************/
#include "DZSM01.wdt"

/***************************************************************************
 * Application Interface Initialization                                    *
 ***************************************************************************/

   APPL_INIT_DATA  applInitData;
   unsigned short  returnStatus = FND_SUCCESS;

   memcpy(applInitData.version,            FND_APPL_VERSION, _VER_LEN);
   memcpy(applInitData.programName,        FND_PROGRAM_NAME, _PROG_NAME_LEN);
   applInitData.programType              = FND_PROGRAM_TYPE;
   memcpy(applInitData.applQueue,          FND_APPL_QUEUE,   _PORT_LEN);
   applInitData.initFlags.registerWithMM = REGISTER_WITH_MM;
   applInitData.initFlags.registerWithEL = REGISTER_WITH_EL;
   applInitData.initFlags.registerWithST = REGISTER_WITH_ST;
   applInitData.initFlags.registerWithMN = REGISTER_WITH_MN;
   applInitData.initRoutine              = (SERVICE_FUNC_PTR) FND_PROGRAM_INIT_ROUTINE;
   applInitData.termRoutine              = (SERVICE_FUNC_PTR) FND_PROGRAM_TERM_ROUTINE;
   applInitData.initUIRoutine            = (SERVICE_FUNC_PTR) FND_INTERFACE_INIT_ROUTINE;
   applInitData.termUIRoutine            = (SERVICE_FUNC_PTR) FND_INTERFACE_TERM_ROUTINE;
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
   applInitData.hInstance                = hInstance;
   applInitData.hPrevInstance            = hPrevInstance;
   applInitData.pszCmdLine               = lpCmdLine;
   applInitData.nCmdShow                 = nCmdShow;
   applInitData.ThreadStackSize          = 32768;



   FND_Application(__argc,__argv,&applInitData,returnStatus);

   return 0;
}
