/*
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : DZSF001.H
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : EHEMMER
**
**  DATE CREATED     : 12/04/96
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    12/04/96  EHEMMER               Original code taken from the BUS File
**
**    12/04/96  EHEMMER               Added TAB_FirstError & TAB_FirstStat
**
**    12/04/96  EHEMMER      TAB Compile w/Discovery
**                                    Commented out declaration of CMN_FAIL
**
**    04/10/97  GHOWELL               Casted 0's in FLOAT data types as
**                                      FLOAT to avoid compile warnings
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
#include <time.h>
#include <sys\timeb.h>
#include <stdlib.h>
#include <direct.h>
#include "cucr097i.h"
#include "cucr031c.h"

/* Global Variables for Update of Window */  
SHORT           NumPools           = 0;
SHORT           ErrorMessageID     = 0;
SHORT           PoolCounter        = 0;

FLOAT           lElapsedTime       = (FLOAT) 0;
FLOAT           InitialRandom      = (FLOAT) 0;
FLOAT           PrevRandom         = (FLOAT) 0;
FLOAT           lNetworkTime       = (FLOAT) 0;
FLOAT           lTotalNumMessages  = (FLOAT) 0;

ULONG           lClientMsgNbr      = 0;
ULONG           lTotalTime         = 0;
ULONG           lactuallengthsend  = 0;
ULONG           ldelaytime              = 0;
double          DZSF001_TestBeginTime   = 0;
double          DZSF001_PauseBeginTime  = 0;
double          DZSF001_PauseEndTime    = 0;
double          DZSF001_TotalPauseTime  = 0;

SHORT           DelayThrottle      = 0;
SHORT           PoolSize           = 0;
SHORT           RefreshRate        = 0;
SHORT           FileLog            = 0;
SHORT           BeepFlag           = 0;
SHORT           Iterative          = 0;

CHAR            SaveIPAddress[16] = "\0";
CHAR            lrandomfilename[9];
CHAR            lfunctioncode[3];
CHAR            NewWindowTitle[50];
CHAR            SaveIDPrevMsgInst[24];

BOOL            DZSF001_FirstError = TRUE;
BOOL            DZSF001_FirstStat  = TRUE;
BOOL            DZSF001_Continue = TRUE;
BOOL            DZSF001_BeginTimeGotten = FALSE;

_MSG_PARM_BLOCK InitialParmBlock;


/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
/*
** TAB Compile w/Discovery   EHEMMER   12/03/96
** Commented out the following declaration since it is already defined in
** C1CBASE.H as -1.
**/
// #define CMN_FAIL           0

#define NUMPOOLS             10
#define INCL_DOSPROCESS

#define UPDATE_IP_ADDR     1000
#define UPDATE_CURRENT_MSG 1005
#define UPDATE_STATS       1007
#define ERROR_MSG          1010
#define UPDATE_TITLE       1020

/*
** EHEMMER  12/16/96   Added these #defines
**/
#define TAB_LOG_FILE                    "C:\\DATA\\TAB.PRF"
#define TAB_ERROR_LOG                   "C:\\DATA\\TAB.ERR"
#define TAB_CSR_DUMP_FILE_DIRECTORY     "S:\\TECHMGT\\PERFTEST\\CSRDMP\\CSRDMP"
#define TAB_CONTROL_INPUT_FILE          "S:\\TECHMGT\\PERFTEST\\TAB\\CONTROL.TAB"
//#define TAB_CONTROL_INPUT_FILE          "C:\\TAB\\CONTROL.TAB"
#define TAB_USER_ID                     "EAHEMMER"
#define TAB_USER_PSWD                   "ASDFHJ"



/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/
typedef struct __MY_PB
{
    HWND     hwnd;
    _EAIA    *pEAIA;

}  _MY_PB;

/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/

/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/

SHORT TABGetPBAndMessage( _MSG_PARM_BLOCK *pMsgPB,
						  BYTE **ppMessage,
						  CHAR *FileName );

SHORT TABRefreshControl( );


/***************************************************************************/
/* Forward declarations for Architecture Exit Functions                    */
/***************************************************************************/
