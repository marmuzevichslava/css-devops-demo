/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*
** Windows NT Compile specific data type conversions
*/

#ifdef FND_WIN32
#define CMN_HPIPE HANDLE
#endif


// CWOODS: OS/2 CSR.H file
// #include <CSR.H>
#include <pmf.h>
#include <CSRNT.H>
#include "CSRDIAG.HH"  /* Help topic header file */
// #include "CSRUTILS.C"


#define CSR_DIAG_REVISION "1.0"

/*
** Detail line
*/

typedef struct __CSR_DIAG_DETAIL_LINE
  {
   char Detail[CSR_DIAG_DETAIL_LEN];
  }_CSR_DIAG_DETAIL_LINE;



/*
** Services Data structure
*/

typedef struct __CSR_DIAG_SERVICE
  {
   ULONG ServiceKey;
   ULONG Server;
   _SERVICE Service;
   char TransMap[_TRANS_MAP_LEN];
   USHORT usNumServiceRows;
   _CSR_DIAG_DETAIL_LINE *pServiceBlock;
    FILE *fptrServiceLog;
    char szServiceLogName[255];

  } _CSR_DIAG_SERVICE;

/*
** CSR DIAGNOSTIC BFCD STRUCTURE
*/

  typedef struct __AZCD01Global
   {
    BOOL CSRPipeConnected;
    char RequestID[_REQ_ID_LEN];
    USHORT usNumRequestRows;
    _CSR_DIAG_DETAIL_LINE *pRequestBlock;
    _CSR_DIAG_SERVICE Service[CSR_DIAG_SERVICE_MAX];
    USHORT usNumServices;
// CWOODS: ATDW001.bus sets value to -1 -> change to SHORT
//  USHORT usCurrentIndex;
    SHORT usCurrentIndex;
    char szSaveFileName[255];
    char szLogDirName[255];
    FILE *fptrRequestLog;
    char szRequestLogName[255];
// CSC:04/05/94 NT Conversion    HSYSSEM hsDetailSem;
   } _AZCD01Global;

#define BFCD_AZCD01 ((_AZCD01Global *)(pBFCD->pCSRDiagBFCD))
#define BFCD_CSRPROFILE ((_CSRPROFILE *)(BFCD_AZCD01->pCSRProfile))

/* CHANGE THIS MACRO TO "DEBUG" OR "TRACE" TO SWITH MODES */
#define MESSAGE_MODE "DEBUG"
/* #define MESSAGE_MODE "TRACE" */


short ATDW001BusOpenPipe(enum TRANSACTION_TYPES Transaction, CMN_ARCH_PARM_TYPES );
