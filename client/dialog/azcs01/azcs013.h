#include <process.h>
#include <stddef.h>
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
                 FndGenRC = DosSemSet(&hsemLock);  \
                 FndGenRC = FndWndMsgPost( hwnd,   \
                                           MsgID,  \
                                           &MsgData,\
                                           &FndGenErrorBlock); \
                 FndGenRC = DosSemWait(&hsemLock, CMN_SEM_TIMEOUT);  \
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



ULONG hsemLock;   /* Global Semaphore variable*/
BOOL bWarn;
BOOL bError;
BOOL bRemap;


typedef struct __STDParms
 {
  _BFCD * pBFCD;
  HWND hwnd;
 } _STDParms;



WCBFWD(AZCS013BusPredisplay);
WCBFWD(ProcessMsg);
WCBFWD(SaveLog);
WCBFWD(PrintLog);
WCBFWD(Azcs013BusUseOldMap);

VOID CompareLayouts(_STDParms *pSTDParms);
short CheckIt(char cLayoutType, short sServiceIndex, short sNumRows, _LAYOUT_REC *pReposLayout, _LAYOUT_REC *pSavedLayout, _STDParms *pSTDParms);

short Remap(_STDParms *pSTDParms);
short ChangeIt(short sServx, short sIndex, short sNewReposIx, _STDParms *pSTDParms);

char *BuildFullName(short sElementx, _LAYOUT_REC *pLayout);
short FindFullName(short sSavedIndex,
                   _LAYOUT_REC *pSavedLayout,
                   _LAYOUT_REC *pReposLayout,
                   short sNumReposRows,
                   short *sReposIndex);

short ChangeLK(short sServ, short sIndex, short sNewReposIx, _STDParms *pSTDParms);
short ChangeCK(short sServ, short sIndex, short sNewReposIx, _STDParms *pSTDParms);
short ChangeLD(short sServ, short sIndex, short sNewReposIx, _STDParms *pSTDParms);
short ChangeRD(short sServ, short sIndex, short sNewReposIx, _STDParms *pSTDParms);
short ChangeRPMH(short sServ, short sIndex, short sNewReposIx, _STDParms *pSTDParms);
short DropClientLK(short sServ, short sIndex, short sNewServIndex, _STDParms *pSTDParms);
short DropClientCK(short sServ, short sIndex, short sNewServIndex, _STDParms *pSTDParms);
short DropClientLD(short sServ, short sIndex, short sNewServIndex, _STDParms *pSTDParms);
short DropClientRD(short sServ, short sIndex, short sNewServIndex, _STDParms *pSTDParms);
short DropClientRPMH(short sServ, short sIndex, short sNewServIndex, _STDParms *pSTDParms);


#define ERR_TYPE       '1'
#define ERR_FORMAT     '2'
#define ERR_LENGTH     '3'
#define ERR_OCCURS     '4'
#define ERR_USAGE      '5'
#define ERR_ID         '6'
