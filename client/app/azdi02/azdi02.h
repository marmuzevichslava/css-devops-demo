/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*************************************************************************
**
**		AZDI02.H - Common Data Structures/Function Prototypes
**
*************************************************************************/

/*************************************************************************
**
**	#includes
**
*************************************************************************/

/* Foundation Session Transcript Header file */
#include "KSTA0001.H"

/* PMF Header file */
#include "pmf.h"

/*************************************************************************
**
**	#defines
**
*************************************************************************/

/* #defines for Session Transcript Information */
#define NUM_SESSTRAN_RECS 20

#define MAX_WINDOWS       100
#define HWND_TEXT_LEN     81

/* #defines for Registry Information */
#define CMN_REG_CSS_VERSION			"version"
#define CMN_REG_DEFAULT_SERVER		"DefaultServer"
#define CMN_REG_LAST_DEPT_ID  		"LastDeptID"
#define CMN_REG_LAST_USER_ID		"LastUserID"
#define CMN_REG_LOGIN_SCRIPT		"LoginScript"
#define CMN_REG_CSR_CONFIG_PATH		"CSR Configuration Path"
#define CMN_REG_IP_ADDRESS			"IPAddress"
#define CMN_REG_HOST_NAME			"HostName"


/*************************************************************************
**
**	Common Data Structures
**
*************************************************************************/

typedef struct __CMN_HDR_INFO
{
  SHORT DtlCount;  /* Number of detail lines */
  SHORT rc;
} _CMN_HDR_INFO;


/*************************************************************************
**
**		AZDI0201.H - Burst Data Structures
**
*************************************************************************/

typedef struct __BURST_DTL
{
  CHAR Platform[9];
  SHORT MsgConvRc;
  SHORT ApplSeverity;
  SHORT ApplExplanCode;
  SHORT CommSeverity;
  SHORT CommExplanCode;
} _BURST_DTL;

typedef struct __BURST_HDR
{
  _CMN_HDR_INFO CmnHdrInfo;
  _BURST_DTL    BurstDtl[2];
} _BURST_HDR;


/*************************************************************************
**
**		AZDI0202.H - Drive Mappings Data Structures
**
*************************************************************************/

typedef struct __DRIVEMAP_DTL
{
  CHAR DriveLetter[3];
  CHAR DriveMapping[255];
} _DRIVEMAP_DTL;

typedef struct __DRIVEMAP_HDR
{
  _CMN_HDR_INFO CmnHdrInfo;
  _DRIVEMAP_DTL DriveMapDtl[26];
} _DRIVEMAP_HDR;


/*************************************************************************
**
**		AZDI0203.H - Inventory of Files Data Structures
**
*************************************************************************/

typedef struct __FILEINV_HDR
{
  _CMN_HDR_INFO CmnHdrInfo;
} _FILEINV_HDR;

typedef struct __FILEINV_DTL
{
  char DetailString;
} _FILEINV_DTL;


/*************************************************************************
**
**		AZDI0204.H - PMF Data Structures
**
*************************************************************************/

typedef struct __PMF_HDR
{
  _CMN_HDR_INFO CmnHdrInfo;
  CHAR 			PmfLanID[15];
  CHAR      	PmfOTNumber[15];
} _PMF_HDR;



/*************************************************************************
**
**		AZDI0205.H - Registry Entries Data Structures
**
*************************************************************************/

typedef struct __REGENTRIES_HDR
{
  _CMN_HDR_INFO CmnHdrInfo; 
  BOOL  RegCSRKeySuccess;
  BOOL  RegPMFKeySuccess;
  BOOL  RegVERKeySuccess;
  CHAR  RegCssVersion[32];
  CHAR	RegDefaultServer[32];
  CHAR  RegLastDeptID[16];
  CHAR  RegLastUserID[16];
  CHAR  RegLoginScript[32];
  CHAR  RegCSRConfigPath[32];
} _REGENTRIES_HDR;


/*************************************************************************
**
**		AZDI0206.H - Session Data Data Structures
**
*************************************************************************/

typedef struct __SESSDATA_HDR
{
  _CMN_HDR_INFO CmnHdrInfo;
} _SESSDATA_HDR;

typedef struct __SESSDATA_DTL
{
  SHORT Dummy;
} _SESSDATA_DTL;


/*************************************************************************
**
**		AZDI0207.H - Active Processes Data Structures
**
*************************************************************************/

typedef struct __ACTIVEPROCS_DTL
{
  CHAR ActiveProcess[20];
} _ACTIVEPROCS_DTL;

typedef struct __ACTIVEPROCS_HDR
{
  _CMN_HDR_INFO CmnHdrInfo;
  _ACTIVEPROCS_DTL ActiveProcsDtl[100];
} _ACTIVEPROCS_HDR;


/*************************************************************************
**
**		AZDI0208.H - Session Transcript Data Structures
**
*************************************************************************/

typedef struct __SESSTRAN_HDR
{
  _CMN_HDR_INFO CmnHdrInfo;
  BOOL			KTFNDFound;
  BOOL			DataPathFound;
  _ST_DETAIL    *pSessTranDtl; /* KSTA0001.H */
} _SESSTRAN_HDR;


/*************************************************************************
**
**		AZDI0209.H - Distribution Services Data Structures
**
*************************************************************************/

typedef struct __DISTSVCS_HDR
{
  _CMN_HDR_INFO CmnHdrInfo;
  BOOL			KTFNDFound;
  CHAR			WinComputerName[32];
  CHAR			HostName[32];
  CHAR			TCPIPAddress[32];
  CHAR			LocalNodeDomain[16];
  CHAR			LocalNodeStation[16];
  CHAR			LocalNodeIPInfo[64];
  CHAR			AddSrvNodeDomain[16];
  CHAR			AddSrvNodeStation[16];
  CHAR			AddSrvNodeIPInfo[64];
  CHAR	        FndDataPath[64];
  CHAR			FndCodePath[64];
  CHAR			FndPathPath[64];
  CHAR			FndDdsSetting[16];
} _DISTSVCS_HDR;

/*************************************************************************
**
**		AZDI0210.H - Active Windows Data Structures
**
*************************************************************************/

typedef struct __ACTIVEHWNDS_DTL
{
  HWND hwnd;
  CHAR Text[ HWND_TEXT_LEN ];
} _ACTIVEHWNDS_DTL;

typedef struct __ACTIVEHWNDS_HDR
{
  _CMN_HDR_INFO    CmnHdrInfo;
  _ACTIVEHWNDS_DTL ActiveHwndsDtl[MAX_WINDOWS];
} _ACTIVEHWNDS_HDR;


/*
#include "AZDI0201.H"
#include "AZDI0202.H"
#include "AZDI0203.H"
#include "AZDI0204.H"
#include "AZDI0205.H"
#include "AZDI0206.H"
#include "AZDI0207.H"
#include "AZDI0208.H"
#include "AZDI0209.H"
*/


/*************************************************************************
**
**	Function Prototypes
**
*************************************************************************/

SHORT Report( HANDLE hOut, CHAR *pszResults );

SHORT GetBurstInfo     ( _BURST_HDR       *pBurstHdr       ); /* AZDI0201.C */
SHORT GetDriveMappings ( _DRIVEMAP_HDR    *pDriveMapHdr    ); /* AZDI0202.C */
SHORT GetFileInvInfo   ( _FILEINV_HDR     *pFileInvHdr     ); /* AZDI0203.C */
SHORT GetPmfInfo       ( _PMF_HDR         *pPmfHdr         ); /* AZDI0204.C */
SHORT GetRegEntries    ( _REGENTRIES_HDR  *pRegEntriesHdr  ); /* AZDI0205.C */
SHORT GetSessData      ( _SESSDATA_HDR    *pSessDataHdr    ); /* AZDI0206.C */
SHORT GetActiveProcs   ( _ACTIVEPROCS_HDR *pActiveProcsHdr ); /* AZDI0207.C */
SHORT GetSessTran      ( _SESSTRAN_HDR    *pSessTranHdr    ); /* AZDI0208.C */
SHORT GetDistSvcs      ( _DISTSVCS_HDR    *pDSHdr    ); 	  /* AZDI0209.C */
SHORT GetActiveHwnds   ( _ACTIVEHWNDS_HDR *pActiveHwndsHdr ); /* AZDI0210.C */

SHORT RptBurstInfo     ( HANDLE hOut, _BURST_HDR       *pBurstHdr       ); /* AZDI0201.C */
SHORT RptDriveMappings ( HANDLE hOut, _DRIVEMAP_HDR    *pDriveMapHdr    ); /* AZDI0202.C */
SHORT RptFileInvInfo   ( HANDLE hOut, _FILEINV_HDR     *pFileInvHdr     ); /* AZDI0203.C */
SHORT RptPmfInfo       ( HANDLE hOut, _PMF_HDR         *pPmfHdr         ); /* AZDI0204.C */
SHORT RptRegEntries    ( HANDLE hOut, _REGENTRIES_HDR  *pRegEntriesHdr  ); /* AZDI0205.C */
SHORT RptSessData      ( HANDLE hOut, _SESSDATA_HDR    *pSessDataHdr    ); /* AZDI0206.C */
SHORT RptActiveProcs   ( HANDLE hOut, _ACTIVEPROCS_HDR *pActiveProcsHdr ); /* AZDI0207.C */
SHORT RptSessTran      ( HANDLE hOut, _SESSTRAN_HDR    *pSessTranHdr    ); /* AZDI0208.C */
SHORT RptSessTranDtl   ( HANDLE hOut, _ST_DETAIL       *pSessTranDtl    ); /* AZDI0208.C */
SHORT RptDistSvcs      ( HANDLE hOut, _DISTSVCS_HDR    *pDistSvcsHdr    ); /* AZDI0209.C */
SHORT RptActiveHwnds   ( HANDLE hOut, _ACTIVEHWNDS_HDR *pActiveHwndsHdr ); /* AZDI0210.C */ 


SHORT OpenSTFile( CHAR *FileName, HFILE *phFile, HANDLE *phFileMap,
                  CHAR **ppFile, LONG *pFileSize );

SHORT CloseSTFile( HFILE hFile, HANDLE hFileMap, CHAR *pFile );
