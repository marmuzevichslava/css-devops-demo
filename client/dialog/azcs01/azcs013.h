/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Architecture Header File
**
**  FILENAME         : 	azcs013
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
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
/*mdc - 01-08-96 - added  include malloc here and removed from azcs00n.c
 */
#include <malloc.h>


#include <process.h>
#include <stddef.h>
#include "systcomm.hh"
#include "roadmap.hh"


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
#define CMN_SEM_TIMEOUT SEM_INDEFINITE_WAIT

#define SET_LANDSCAPE   "\033&l1O"
#define LINE_PRINTER "\033(0N\033(s0p16.67h8.5v0s0b0T"
#define VMI                   "\033&l5.6C"  // 5.6

#define RESET_PRINTER "\033E"

#define POSTMSG                                            \
                 FndGenRC = CmnOsSignalSet(hsemLock);  \
                 FndGenRC = FndWndMsgPost( hwnd,   \
                                           MsgID,  \
                                           &MsgData,\
                                           &FndGenErrorBlock); \
                 FndGenRC = CmnOsSignalWait(hsemLock, CMN_SEM_TIMEOUT);  \
                 if(pBFCD->pCSRMapBFCD->AbortFlag == TRUE)           \
                    _endthread();                                         \


#define CHECKINDEX if (pBFCD->pCSRMapBFCD->ClientInfo.pClientLayoutTable[sCurrentIndex].ParentIndex > \
                       pBFCD->pCSRMapBFCD->ClientInfo.NumClientRows ||    \
                     pBFCD->pCSRMapBFCD->ServiceInfoTable[sServiceIndex].pServiceLayoutTable[sTableIndex].ParentIndex  > \
                     pBFCD->pCSRMapBFCD->ServiceInfoTable[sServiceIndex].NumServiceRows) \
                     { \
                       FndGenRC = FndMsgBoxDisplayText(         \
                         "Invalid Parent index. Unable to add to listbox", \
                                        NULL, \
                                        CBI_hwnd, \
                                        FND_MSGBOX_OK, \
                                        FND_MSGBOX_ERROR, \
                                        FND_MSGBOX_IDOK, \
                                        CMN_MAPGEN_NAME,  \
                                        &SelectedButton,  \
                                        &ErrorBlock);  \
                      break; \
                     }

#define ERR_TYPE       '1'
#define ERR_FORMAT     '2'
#define ERR_LENGTH     '3'
#define ERR_OCCURS     '4'
#define ERR_USAGE      '5'
#define ERR_ID         '6'

/*mdc - 01-10-96 - changed data type to CMN_SIGNAL for compatibility with
common Arch funtions. CMN_SIGNAL is a HANDLE in WINN32 and a HSYSSEM in OS/2 */
CMN_SIGNAL hsemLock;   /* Global Semaphore variable */
BOOL bWarn;
BOOL bError;
BOOL bRemap;

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
WCBFWD(AZCS013BusPredisplay);
WCBFWD(AZCS013BUSPredistroy);
WCBFWD(ProcessMsg);
WCBFWD(SaveLog);
WCBFWD(PrintLog);
WCBFWD(Azcs013BusUseOldMap);

VOID CompareLayouts(_STDParms *pSTDParms);
SHORT CheckIt(char cLayoutType, SHORT sServiceIndex, SHORT sNumRows, _LAYOUT_REC *pReposLayout, _LAYOUT_REC *pSavedLayout, _STDParms *pSTDParms);

SHORT Remap(_STDParms *pSTDParms);
SHORT ChangeIt(SHORT sServx, SHORT sIndex, SHORT sNewReposIx, _STDParms *pSTDParms);

char *BuildFullName(SHORT sElementx, _LAYOUT_REC *pLayout);
SHORT FindFullName(SHORT sSavedIndex,
                   _LAYOUT_REC *pSavedLayout,
                   _LAYOUT_REC *pReposLayout,
                   SHORT sNumReposRows,
                   SHORT *sReposIndex);

SHORT ChangeLK(SHORT sServ, SHORT sIndex, SHORT sNewReposIx, _STDParms *pSTDParms);
SHORT ChangeCK(SHORT sServ, SHORT sIndex, SHORT sNewReposIx, _STDParms *pSTDParms);
SHORT ChangeLD(SHORT sServ, SHORT sIndex, SHORT sNewReposIx, _STDParms *pSTDParms);
SHORT ChangeRD(SHORT sServ, SHORT sIndex, SHORT sNewReposIx, _STDParms *pSTDParms);
SHORT ChangeRPMH(SHORT sServ, SHORT sIndex, SHORT sNewReposIx, _STDParms *pSTDParms);
SHORT DropClientLK(SHORT sServ, SHORT sIndex, SHORT sNewServIndex, _STDParms *pSTDParms);
SHORT DropClientCK(SHORT sServ, SHORT sIndex, SHORT sNewServIndex, _STDParms *pSTDParms);
SHORT DropClientLD(SHORT sServ, SHORT sIndex, SHORT sNewServIndex, _STDParms *pSTDParms);
SHORT DropClientRD(SHORT sServ, SHORT sIndex, SHORT sNewServIndex, _STDParms *pSTDParms);
SHORT DropClientRPMH(SHORT sServ, SHORT sIndex, SHORT sNewServIndex, _STDParms *pSTDParms);

