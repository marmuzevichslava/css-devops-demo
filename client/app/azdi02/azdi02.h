/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*************************************************************************
**
**	FILENAME:		AZDI02.H - Common Data Structures/Function Prototypes
**
**	DESCRIPTION:	This is the header file for all files in CSS Diagnostics,
**                  except for AZDI0207.c, which used its own.
**
**  CREATED:
**
**  REVISION HISTORY
**
**    DATE      REVISED BY  SIR #   DESCRIPTION OF CHANGE
**  --------    ----------  ------  ---------------------------------------
**  02/12/97    GHOWELL     16116    Added macros, changed Burst timeout,
**                                     changed Max. # windows
**
**  10/28/97    B Lucas     25378   added defines for default user/pass
**                                  added include for security struct
*************************************************************************/

/*************************************************************************
**
**	#includes
**
*************************************************************************/

#include "azrcsm01.h"

/* Foundation Session Transcript Header file */
/* 02/12/97 GHOWELL - Placed contents of this file (only one structure typedef)
**                    into AZDI0208 header section of this file
*/
//#include "KSTA0001.H"  

/* PMF Header file */
#include "pmf.h"

#include <windows.h>
#include <tlhelp32.h> /* Win95 - needed for tool help declarations */

/* 
** bdl 10/28/97
** added includes for security struct
*/
#include "azdiext.h"

/*************************************************************************
**
**	#defines
**
*************************************************************************/

/* GHOWELL 02/12/97 - Added directory path section */
/* #defines for directory paths */
#define DIAG_OUTPUT_FILE  "c:\\css_diag.txt"


/* #defines for Session Transcript Information */
#define NUM_SESSTRAN_RECS 20

/* 02/12/97 GHOWELL - Increased to 150 (many windows are hidden and do not
**                    appear, so it's easy to have many windows open 
*/
#define MAX_WINDOWS       150
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
#define CMN_MAX_INV_ENTRIES			100

#define 	TRUE			1
#define 	FALSE			0

/* Win95 specific */
/* Type definitions for pointers to call tool help functions. */
typedef BOOL (WINAPI *MODULEWALK)(HANDLE hSnapshot, LPMODULEENTRY32 lpme); 
typedef BOOL (WINAPI *PROCESSWALK)(HANDLE hSnapshot, LPPROCESSENTRY32 lppe); 
typedef HANDLE (WINAPI *CREATESNAPSHOT)(DWORD dwFlags, DWORD th32ProcessID); 

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

/* 02/12/97 GHOWELL - Moved #defines from .C file to header file */
#define UNIX_APPL_ID       989
#define CICS_APPL_ID       987
#define BURST_TIMEOUT_LEN  MS_INFINITE_TIMEOUT  /* 02/14/96 GHOWELL - Changed timeout to prevent Sess Tran msg */
#define ENVIRON_LEN          2
#define BURST_XLT_NAME     "BURST2"
#define BURST_XLT_VERSION  "01"

/*
** bdl 10/28/97
** added defines for default username/password. both defines can be no 
** longer than AZDIEXT_KYUSERID_LEN and AZDIEXT_PASSWORD_LEN and must be 
** padded with spaces for their respective defined lengths.
*/
#define AZDI0201_DEFAULT_USERNAME "USERID  "
#define AZDI0201_DEFAULT_PASSWORD "PASSWORD"

/*************************************************************************
**
**		AZDI0202.H - Drive Mappings Data Structures
**
*************************************************************************/

typedef struct __DRIVEMAP_DETAIL
{
  CHAR DriveLetter[3];
  CHAR DriveMapping[255];
} _DRIVEMAP_DETAIL;

typedef struct __DRIVEMAP_HDR
{
  _CMN_HDR_INFO CmnHdrInfo;
  _DRIVEMAP_DETAIL DriveMapDtl[26];
} _DRIVEMAP_HDR;


/*************************************************************************
**
**		AZDI0203.H - Inventory of Files Data Structures
**
*************************************************************************/

typedef struct __FILEINV_DTL
{
  char DtlString[255];
} _FILEINV_DTL;

typedef struct __FILEINV_HDR
{
  _CMN_HDR_INFO CmnHdrInfo;
  BOOL			InvFileFound;
  SHORT			InSynchCount;
  SHORT			OutSynchCount;
  SHORT			TotalFiles;
  _FILEINV_DTL  FileInvDtl[CMN_MAX_INV_ENTRIES];
} _FILEINV_HDR;



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

typedef struct __ENUM_KEY
{
	CHAR sEnumSubKey[65];
	struct __QUERY_SUBKEY_VALUE *pFirstSubKeyValue;
	struct __ENUM_KEY *pNextSubKey;

} _ENUM_KEY;

typedef struct __QUERY_SUBKEY_VALUE
{
	CHAR *psSubKeyValue;
	DWORD dwValueType;
	CHAR *psValueData;
	struct __QUERY_SUBKEY_VALUE *pNextValue;

} _QUERY_SUBKEY_VALUE;

typedef struct __REG_LIST_HDR
{
	_ENUM_KEY *pFirstSubKey;

} _REG_LIST_HDR;

/* 02/12/97 GHOWELL - Added macros to replace hardcodes */
#define CMN_PROFILE_KEY_SW_TOP_KEY      "Software\\SolutionWorks\\"
#define CMN_PROFILE_KEY_FPC_TOP_KEY     "Software\\FPC\\"
#define CMN_PROFILE_KEY_NAME_CSS        "CSS"
#define CMN_PROFILE_KEY_CURRENT_VERSION "\\CurrentVersion\\"
#define CMN_PROFILE_KEY_RELEASE         "\\Release"

/*************************************************************************
**
**		AZDI0206.H - Session Data Data Structures
**
*************************************************************************/

typedef struct __SESSDATA_HDR
{					 
  _CMN_HDR_INFO      CmnHdrInfo;
  SHORT              RetCode;
  _AZRCSM01ARCHDATA  ArchData;
  _AZGRSM03APPLDATA  ApplData;
} _SESSDATA_HDR;

typedef struct __SESSDATA_DTL
{
  SHORT Dummy;
} _SESSDATA_DTL;

/* 02/12/97 GHOWELL - Added macro to replace hardcoded text */
#define SECURITY_ERROR_MESSAGE  "Security Get Rights"

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


/* Win95 specific */
/* File scope globals. These pointers are declared because of the need 
** to dynamically link to the functions.  They are exported only by 
** the Windows 95 kernel. Explicitly linking to them will make this 
** application unloadable in Microsoft(R) Windows NT(TM) and will 
** produce an ugly system dialog box. 
*/
static CREATESNAPSHOT pCreateToolhelp32Snapshot = NULL; 
static PROCESSWALK pProcess32First = NULL; 
static PROCESSWALK pProcess32Next  = NULL; 

/*************************************************************************
**
**		AZDI0208.H - Session Transcript Data Structures
**
*************************************************************************/

/* 02/12/97 GHOWELL - inserted only contents of old KSTA0001.H into main header file
*/
typedef struct __ST_DETAIL                                                      
{                                                                               
   char                MsgVersion[2];                              
   char                MsgSeverity[12];                            
   char                MsgErrorType[12];                          
   unsigned short      MsgErrorNum;                                             
   char                MsgErrMsgDecode[81];                    
   char                MsgApplType[10];                            
   char                StDetailPgmName[8];                    
   char                MsgErrorArea[160];                          
   char                MsgSendTime[9];                            
   char                MsgSendDate[9];                            
   char                MsgWinName[32];                              
   unsigned long       MsgProcessId;                                            
   unsigned long       MsgThreadId;                                             
   long                MsgDepMsgNum;                                            
   char                MsgDepMsgArea[160];                        
   unsigned long       MsgSendTimeStamp;                                        
   unsigned short      MsgApplDataLength;                                       
   char                MsgApplData[101];                            
   short               ExplanationCode;                                         
   char                ErrorTagData[30];                          
}  _ST_DETAIL;                                                                  

typedef struct __SESSTRAN_HDR
{
  _CMN_HDR_INFO CmnHdrInfo;
  BOOL			KTFNDFound;
  BOOL			DataPathFound;
  _ST_DETAIL    *pSessTranDtl; /* KSTA0001.H */
} _SESSTRAN_HDR;


/* 02/12/97 GHOWELL - Added macros to replace hardcodes */
#define FND_INI_FILE      "KTFND.INI"
#define SESS_TRN_LOG_FILE "\\ktstlog.txt"

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


/* Except for AZDI0207.H, these files no longer exist - all info has been
** placed in this file.  AZDI0207.c includes AZDI0207.H itself
*/
//#include "AZDI0201.H"
//#include "AZDI0202.H"
//#include "AZDI0203.H"
//#include "AZDI0204.H"
//#include "AZDI0205.H"
//#include "AZDI0206.H"
//#include "AZDI0207.H"
//#include "AZDI0208.H"
//#include "AZDI0209.H"



/*************************************************************************
**
**	Function Prototypes
**
*************************************************************************/

SHORT Report( HANDLE hOut, CHAR *pszResults );

SHORT GetBurstInfo     ( _BURST_HDR       *pBurstHdr       ); /* AZDI0201.C */
SHORT GetDriveConnections ( _DRIVEMAP_HDR    *pDriveMapHdr    ); /* AZDI0202.C */
SHORT GetFileInvInfo   ( _FILEINV_HDR     *pFileInvHdr     ); /* AZDI0203.C */
SHORT GetPmfInfo       ( _PMF_HDR         *pPmfHdr         ); /* AZDI0204.C */
SHORT GetRegEntries    ( _REGENTRIES_HDR  *pRegEntriesHdr, _REG_LIST_HDR *pRegListHdr,  int nRegAccessFlag ); /* AZDI0205.C */
SHORT GetSessData      ( _SESSDATA_HDR    *pSessDataHdr    ); /* AZDI0206.C */
SHORT GetActiveProcs   ( _ACTIVEPROCS_HDR *pActiveProcsHdr ); /* AZDI0207.C */
SHORT GetSessTran      ( _SESSTRAN_HDR    *pSessTranHdr    ); /* AZDI0208.C */
SHORT GetDistSvcs      ( _DISTSVCS_HDR    *pDSHdr    ); 	  /* AZDI0209.C */
SHORT GetActiveHwnds   ( _ACTIVEHWNDS_HDR *pActiveHwndsHdr ); /* AZDI0210.C */

SHORT RptBurstInfo     ( HANDLE hOut, _BURST_HDR       *pBurstHdr       ); /* AZDI0201.C */
SHORT RptDriveMappings ( HANDLE hOut, _DRIVEMAP_HDR    *pDriveMapHdr    ); /* AZDI0202.C */
SHORT RptFileInvInfo   ( HANDLE hOut, _FILEINV_HDR     *pFileInvHdr     ); /* AZDI0203.C */
SHORT RptPmfInfo       ( HANDLE hOut, _PMF_HDR         *pPmfHdr         ); /* AZDI0204.C */
SHORT RptRegEntries    ( HANDLE hOut, _REGENTRIES_HDR  *pRegEntriesHdr, _REG_LIST_HDR *pRegListHdr, int nRegAccessFlag ); /* AZDI0205.C */
SHORT RptSessData      ( HANDLE hOut, _SESSDATA_HDR    *pSessDataHdr    ); /* AZDI0206.C */
SHORT RptActiveProcs   ( HANDLE hOut, _ACTIVEPROCS_HDR *pActiveProcsHdr ); /* AZDI0207.C */
SHORT RptSessTran      ( HANDLE hOut, _SESSTRAN_HDR    *pSessTranHdr    ); /* AZDI0208.C */
SHORT RptSessTranDtl   ( HANDLE hOut, _ST_DETAIL       *pSessTranDtl    ); /* AZDI0208.C */
SHORT RptDistSvcs      ( HANDLE hOut, _DISTSVCS_HDR    *pDistSvcsHdr    ); /* AZDI0209.C */
SHORT RptActiveHwnds   ( HANDLE hOut, _ACTIVEHWNDS_HDR *pActiveHwndsHdr ); /* AZDI0210.C */ 

SHORT FreeMemRegEntries(_REGENTRIES_HDR  *pRegEntriesHdr, _REG_LIST_HDR    *pRegListHdr);/* AZDI0205.C */

SHORT OpenSTFile( CHAR *FileName, HFILE *phFile, HANDLE *phFileMap,
                  CHAR **ppFile, LONG *pFileSize );

SHORT CloseSTFile( HFILE hFile, HANDLE hFileMap, CHAR *pFile );
