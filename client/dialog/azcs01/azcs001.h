/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Architecture Header File
**
**  FILENAME         : 	azcs001
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : MCONNER
**
**  DATE CREATED     : 01-08-96
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**	 01/08/96   mconner               added malloc.h
**   01/15/96   mconner               added help headers
**   10/01/96   mconner               added Azcs001BusAmnMassGenClk 
**                                    prototype
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
/*mdc - 01-08-96 - added  include malloc here and removed from azcs00n.c
 */
#include <malloc.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>

/*mdc 01-15-96 - added for help */
#include "systcomm.hh"
#include "roadmap.hh"

/*mdc 11/21/96 global header file*/
#include "azcs01.h"


/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
#define CMN_MAPGEN_MSG_BASE 25000
#define CMN_MSG_SPACER       5
#define CMN_MAPGEN_MSG_INFO  CMN_MAPGEN_MSG_BASE + 1
#define CMN_MAPGEN_MSG_WARN  CMN_MAPGEN_MSG_BASE + 2
#define CMN_MAPGEN_MSG_ERROR CMN_MAPGEN_MSG_BASE + 3
#define CMN_MAPGEN_MSG_DONE  CMN_MAPGEN_MSG_BASE + 4
#define CMN_MAPGEN_NAME "CSR Map Generator"

#define CMN_MAPGEN_NAME "CSR Map Generator"
#define     MAPGEN_ELB_NAME "Rlb01ELB"
#define SET_LANDSCAPE   "\033&l1O"
#define LINE_PRINTER "\033(0N\033(s0p16.67h8.5v0s0b0T"
#define VMI                   "\033&l5.6C"  // 5.6

#define RESET_PRINTER "\033E"
#define STACKSIZE 51200
#define MSG_TYPE_LEN          8
#define MESSAGE_LEN           255
#define ERR_FILE_NM    "csrmapmg.err"
#define CSR_MAP_MASS_GEN_LOG_EXT    "rpt"

/***************************************************************************/
/* Global variables                                                   */
/***************************************************************************/

CMN_SIGNAL hsemLock;   /* Global Semaphore variable */
BOOL bWarn;
BOOL bError;
BOOL bRemap;
FILE *fpLog;  /*global log file pointer */



/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/
typedef struct __STDParms
 {
  _BFCD * pBFCD;
  HWND hwnd;
 } _STDParms;

/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/
WCBFWD (AZCS001BusAboutMNClick);
WCBFWD (AZCS001BUSPredistroy);
WCBFWD (OpnAZCS2);
WCBFWD (OpnAZCS3);
WCBFWD (ClsAZCS1);
WCBFWD (OpnAZCS4);
WCBFWD (OpnAZCS5);
WCBFWD (OpnAZCS6);
WCBFWD (OpnAZCS7);
WCBFWD (GetDefDir);
WCBFWD (ChkTLStatus);
WCBFWD (SetupBFCD);
WCBFWD (AZCS001BusAmnGenerateClk);
WCBFWD (AZCS001BusAmnSaveClk);
WCBFWD (RestoreServiceLB);
WCBFWD (RestoreTaskList);
WCBFWD (GetServiceReposData);
WCBFWD (AZCS001BusCleanupBFCD);
WCBFWD (AZCS001BusAMNDumpClk);
WCBFWD (SetDeleteFlag);
WCBFWD (ResetDeleteFlag);
WCBFWD (Azcs001BusAmnMassGenClk);


USHORT MGCompLayouts( CMN_ARCH_PARM_TYPES );

 SHORT CsrMapRetrieveLayout( CHAR *EntityId, CHAR ClientLayoutFlag,
                            _LAYOUT_REC **ppLayoutRecTable,
                            USHORT *pNumberRows,
                            double *pVersionNumber,
                            CMN_ARCH_PARM_TYPES );

short GetServiceIndex(unsigned long Server,
                      unsigned short ServiceID,
                      char *TranMap,
                      CMN_ARCH_PARM_TYPES);

USHORT ExtractSavedData( CMN_ARCH_PARM_TYPES,
                       char * );


USHORT Azcs001BusCompareLayouts( _STDParms * );
USHORT Azcs001CheckIt(char cLayoutType, SHORT sServiceIndex, SHORT sNumRows, _LAYOUT_REC *pReposLayout, _LAYOUT_REC *pSavedLayout, _STDParms *pSTDParms);

SHORT Azcs001Remap(_STDParms *pSTDParms);
SHORT Azcs001ChangeIt(SHORT sServx, SHORT sIndex, SHORT sNewReposIx, _STDParms *pSTDParms);


SHORT Azcs001ChangeLK(SHORT sServ, SHORT sIndex, SHORT sNewReposIx, _STDParms *pSTDParms);
SHORT Azcs001ChangeCK(SHORT sServ, SHORT sIndex, SHORT sNewReposIx, _STDParms *pSTDParms);
SHORT Azcs001ChangeLD(SHORT sServ, SHORT sIndex, SHORT sNewReposIx, _STDParms *pSTDParms);
SHORT Azcs001ChangeRD(SHORT sServ, SHORT sIndex, SHORT sNewReposIx, _STDParms *pSTDParms);
SHORT Azcs001ChangeRPMH(SHORT sServ, SHORT sIndex, SHORT sNewReposIx, _STDParms *pSTDParms);
SHORT Azcs001DropClient( SHORT sClientx,
                  SHORT sServ,
                  SHORT Process,
                  _STDParms *pSTDParms );

SHORT Azcs001DropClientLK(SHORT sServ, SHORT sIndex, SHORT sNewServIndex, _STDParms *pSTDParms);
SHORT Azcs001DropClientCK(SHORT sServ, SHORT sIndex, SHORT sNewServIndex, _STDParms *pSTDParms);
SHORT Azcs001DropClientLD(SHORT sServ, SHORT sIndex, SHORT sNewServIndex, _STDParms *pSTDParms);
SHORT Azcs001DropClientRD(SHORT sServ, SHORT sIndex, SHORT sNewServIndex, _STDParms *pSTDParms);
SHORT Azcs001DropClientRPMH(SHORT sServ, SHORT sIndex, SHORT sNewServIndex, _STDParms *pSTDParms);

USHORT InitErrorFile( CMN_ARCH_PARM_TYPES );
USHORT InitCompLog( CMN_ARCH_PARM_TYPES, char * );
USHORT LogMsg(USHORT, char *);
USHORT Azcs001MassGenWrapUp( char *, BOOL, CMN_ARCH_PARM_TYPES );