/***************************************************************************/
/*                                                                         */
/*                   P R O G R A M   F R O N T   E N D                     */
/*                                                                         */
/*            Copyright (C) 1989, 1990, Andersen Consulting.               */
/*                         All rights reserved.                            */
/*                                                                         */
/***************************************************************************/
/*                                                                         */
/*                Program Front End for: AZCD01                            */
/*                         Generated on: Jul 15, 1992                      */
/*                                   at: 15:37:27                          */
/*                                   by: LMISFELD                            */
/*                                                                         */
/***************************************************************************/

#define  INCL_WIN
#include <os2.h>
#include <string.h>
#include <stdio.h>
#include <float.h>
#include <limits.h>

#define  FND_FE_INCL
#define  FND_IM_INCL
#define  FND_EH_INCL
#define  FND_PS_INCL


/***************************************************************************/
/* Foundation Global Header File                                           */
/***************************************************************************/
#include <kglzk000.h>

/***************************************************************************/
/* Copybooks and data typedefs                                             */
/***************************************************************************/


/***************************************************************************/
/* Library prototypes                                                      */
/***************************************************************************/


/***************************************************************************/
/* Foundation Application Information                                      */
/***************************************************************************/

#define  FND_PROGRAM_NAME        "AZCD01"
#define  FND_APPL_VERSION        "03"
#define  FND_APPL_QUEUE          UNSOLICITED_Q_AU
#define  FND_PROGRAM_TYPE        FND_APPL_TYPE_CLIENT
#define  FND_WINDOW_NAME         ""

#define  FND_DBMS                FND_DB_NONE

/***************************************************************************/
/* Register with foundation services                                       */
/***************************************************************************/
#define REGISTER_WITH_MM         FALSE
#define REGISTER_WITH_EL         FALSE
#define REGISTER_WITH_ST         TRUE
#define REGISTER_WITH_MN         TRUE

/***************************************************************************/
/* CLIENT: - indicate the number of windows in the application             */
/***************************************************************************/


/***************************************************************************/
/* Window Identifiers                                                       */
/***************************************************************************/
#include  "azcd01.gnz"


/***************************************************************************/
/* Window Forward Declarations                                             */
/***************************************************************************/
extern WINDEFTBLENTRY AZCD001XWindowDefn;
extern WINDEFTBLENTRY AZCD002XWindowDefn;
extern WINDEFTBLENTRY AZCD003XWindowDefn;
extern WINDEFTBLENTRY AZCD004XWindowDefn;




/***************************************************************************/
/* If a Business Function Context Data area is desired, the                */
/* BusinessFunctContextData structure must be used to define it.           */
/***************************************************************************/
#include  "azcd001x.gnb"


/***************************************************************************/
/* Working Storage Declarations                                            */
/***************************************************************************/
#define FND_BFCD_SIZE sizeof(_BFCD)


/***************************************************************************/
/*  Program Message Table */
/***************************************************************************/

/****************************************************************************
 * C PROGRAM MESSAGE TABLE MESSAGE CODES file AZCD01.gno.                   *
 * Created on Jul 15, 1992 at 15:36:26 by LMISFELD.                         *
 ****************************************************************************/






/****************************************************************************
 * PM QUEUE SIZE DEFINITION                                                 *
 * Created on Jul 15, 1992 at 15:36:27 by LMISFELD.                         *
 ****************************************************************************/


#define   MAX_PM_Q_SIZE                  50


/****************************************************************************
 * CUSTOM INITIALIZATION & TERMINATION DECLARATIONS                         *
 * Created on Jul 15, 1992 at 15:36:27 by LMISFELD.                         *
 ****************************************************************************/


#define   FND_PROGRAM_INIT_ROUTINE       NULL
#define   FND_PROGRAM_TERM_ROUTINE       NULL

#define   FND_INTERFACE_INIT_ROUTINE     NULL
#define   FND_INTERFACE_TERM_ROUTINE     NULL



/****************************************************************************
 * C PROGRAM MESSAGE TABLE                                                  *
 * Created on Jul 15, 1992 at 15:36:27 by LMISFELD.                         *
 ****************************************************************************/

#define  FND_APPL_ID                    0



static _FE_MSG_DISPATCH_RECORD dispatchTable[] =
{
    0
};





/***************************************************************************/
/* Declare the window table                                                */
/***************************************************************************/
VOID cdecl main(int argc, char *argv[])
{
  static WINDEFTBLENTRY *windowDefTable[] =
  {

/***************************************************************************/
/* For each window definition table, add a line to the                     */
/* *WindowDefnTbl definition.                                              */
/***************************************************************************/

        &AZCD001XWindowDefn
     ,&AZCD002XWindowDefn
     ,&AZCD003XWindowDefn
     ,&AZCD004XWindowDefn

 };

/***************************************************************************/
/* Count the window instances in the table:                                */
/***************************************************************************/

#define NUM_WINDOWS            sizeof(windowDefTable)/sizeof(WINDEFTBLENTRY*)



/***************************************************************************/
/* Initialize the application interface                                    */
/***************************************************************************/
   APPL_INIT_DATA applInitData;
   USHORT         returnStatus;

   memcpy(applInitData.version,            FND_APPL_VERSION, _VER_LEN);
   memcpy(applInitData.programName,        FND_PROGRAM_NAME, _PROG_NAME_LEN);
   applInitData.programType              = FND_PROGRAM_TYPE;
   memcpy(applInitData.windowName,         FND_WINDOW_NAME,  _WIN_NAME_LEN);
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
   applInitData.windowDefTable           = (WINDEFTBLENTRY FAR *)windowDefTable;
   applInitData.numWindows               = NUM_WINDOWS;
   applInitData.applicationID            = FND_APPL_ID;
   strcpy(applInitData.DatabaseDLL, FND_DBMS);

   FND_Application(argc, argv, &applInitData, returnStatus);

}


