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
**     1/27/98  mconner               Implemented Architecture statndards 
**                                     for header files.
**
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
#include <time.h>
#include <sys\timeb.h>
#include <stdlib.h>
#include <direct.h>
/*#include "cucr097i.h"
#include "cucr031c.h"
*/
/***************************************************************************/
/*  Application defined macos                                              */
/***************************************************************************/
#ifndef _PATH_LEN
#define _PATH_LEN                        256
#endif
#ifndef DZSF001_ADDRESS_LEN 
#define DZSF001_ADDRESS_LEN              16
#endif
#ifndef DZSF001_SAVE_MESSAGE_ID_LEN  
#define DZSF001_SAVE_MESSAGE_ID_LEN      24
#endif
#ifndef DZSF001_FILENAME_LEN
#define DZSF001_FILENAME_LEN             9
#endif
#ifndef DZSF001_FUNTION_CODE_LEN
#define DZSF001_FUNTION_CODE_LEN         3
#endif
#ifndef DZSF001_WINDOW_TITLE_LEN
#define DZSF001_WINDOW_TITLE_LEN         50
#endif
#ifndef DZSF001_MAX_MSG_LEN 
#define DZSF001_MAX_MSG_LEN              32000
#endif

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
/*
** TAB Compile w/Discovery   EHEMMER   12/03/96
** Commented out the following declaration since it is already defined in
** C1CBASE.H as -1.
**/
// #define CMN_FAIL           0

//#ifndef	NUMPOOLS
//#define NUMPOOLS                        10
//#endif
//#ifndef	INCL_DOSPROCESS
//#define INCL_DOSPROCESS
//#endif
#ifndef	UPDATE_IP_ADDR
#define UPDATE_IP_ADDR                  1000
#endif
#ifndef	UPDATE_CURRENT_MSG
#define UPDATE_CURRENT_MSG              1005
#endif
#ifndef	UPDATE_STATS
#define UPDATE_STATS                    1007
#endif
//#ifndef	ERROR_MSG
//#define ERROR_MSG                       1010
//#endif
#ifndef	UPDATE_TITLE
#define UPDATE_TITLE                    1020
#endif
//#ifndef DZSF001_FILE_LEN
//#define DZSF001_FILE_LEN                30
//#endif
#ifndef DZSF001_TIME_STR_LEN
#define DZSF001_TIME_STR_LEN            24
#endif
#ifndef DZSF001_MSEC_PER_SEC
#define DZSF001_MSEC_PER_SEC            1000
#endif
#ifndef DZSF001_AVG_NUM
#define DZSF001_AVG_NUM                 20
#endif
#ifndef DZSF001_REFRESH_FAIL
#define DZSF001_REFRESH_FAIL            1
#endif
#ifndef DZSF001_TOT_TIME_DIV
#define DZSF001_TOT_TIME_DIV            60
#endif
#ifndef DZSF001_RAND_FILE_NAME_LEN
#define DZSF001_RAND_FILE_NAME_LEN		9
#endif
#ifndef DZSF001_COMP_NAME_LEN
#define DZSF001_COMP_NAME_LEN           16
#endif
#ifndef	DZSF001_RAND_NUM_DIV
#define DZSF001_RAND_NUM_DIV            32676  
#endif
#ifndef DZSF001_FUNC_CODE_LEN
#define DZSF001_FUNC_CODE_LEN           3
#endif
#ifndef DZSF001_DATA_BLK_LEN
#define DZSF001_DATA_BLK_LEN            0
#endif
#ifndef DZSF001_STR_POOL_CNTR_LEN
#define DZSF001_STR_POOL_CNTR_LEN       6
#endif
#ifndef DZSF001_USER_ID_LEN
#define DZSF001_USER_ID_LEN             8
#endif
#ifndef DZSF001_USER_PSWD_LEN
#define DZSF001_USER_PSWD_LEN           8
#endif
#ifndef DZSF001_TAB_PARMS_LEN
#define DZSF001_TAB_PARMS_LEN           150
#endif
#ifndef DZSF001_KY_CONV_ID_STR
#define DZSF001_KY_CONV_ID_STR          "TABNT\0"
#endif
#ifndef DZSF001_DELAY_THROT_ACT_TITLE
#define DZSF001_DELAY_THROT_ACT_TITLE	"TAB Throttle Active (Delay = %us)\0"
#endif
#ifndef DZSF001_NORM_WIND_TITLE
#define DZSF001_NORM_WIND_TITLE         "TAB Stress Facility\0"
#endif
#ifndef DZSF001_STAT_LOG_HDR_FORMAT_STR 
#define DZSF001_STAT_LOG_HDR_FORMAT_STR  \
	"%-24s, %-12s, %-11s, %-11.9s, %-17s, %-18s, %-18s, %-20s, %-20s, %-20s \n \n"
#endif
#ifndef DZSF001_ERR_HDR_FORMAT_STR
#define DZSF001_ERR_HDR_FORMAT_STR  \
    "%-24s, %-13s, %-10s, %-12s, %-15s, %-12s, %-10s, %-19s, %-19s, %-17s, %-s \n \n"
#endif
#ifndef DZSF001_ERR_DATA_FORMAT_STR
#define DZSF001_ERR_DATA_FORMAT_STR  \
	"%-.24s, %-13s, %-10.8s, %-12s, %-15f, %-12s, %-10ld, %-19ld, %-19ld, %-17f, %-d \n"
#endif
#ifndef DZSF001_TAB_PARMS_FORMAT_STR
#define DZSF001_TAB_PARMS_FORMAT_STR      "%d %d %d %d %d %d %d %s %s %s %s %s %s"
#endif
#ifndef DZSF001_RAND_FILE_NM_FORMAT_STR
#define DZSF001_RAND_FILE_NM_FORMAT_STR  "%u%s"   
#endif
#ifndef DZSF001_HDR_1
#define DZSF001_HDR_1                   "Time"	
#endif
#ifndef DZSF001_HDR_2
#define DZSF001_HDR_2                   "IP Address"
#endif
#ifndef DZSF001_HDR_3
#define DZSF001_HDR_3                   "XLT Map"
#endif
#ifndef DZSF001_HDR_4
#define DZSF001_HDR_4                   "File Name"
#endif
#ifndef DZSF001_HDR_5
#define DZSF001_HDR_5                   "Network Time"
#endif
#ifndef DZSF001_HDR_6
#define DZSF001_HDR_6                   "Function Code"
#endif
#ifndef DZSF001_HDR_7
#define DZSF001_HDR_7                   "Client Msg Num"
#endif
#ifndef DZSF001_HDR_8
#define DZSF001_HDR_8					"Client Msg Len"
#endif
#ifndef DZSF001_HDR_9
#define DZSF001_HDR_9					"Service Msg Len"
#endif
#ifndef DZSF001_HDR_10
#define DZSF001_HDR_10					"Elapsed Time"
#endif
#ifndef	DZSF001_DATA_FORMAT_STR
#define DZSF001_DATA_FORMAT_STR   \
  "%-.24s, %-12s, %-11.8s, %-11s, %-17f, %-18s, %-18ld, %-20ld, %-20ld, %-20f \n"
#endif
#ifndef DZSF001_HDR_11
#define DZSF001_HDR_11                  "Func Code"
#endif
#ifndef	DZSF001_HSR_12
#define DZSF001_HSR_12                  "Msg Num"
#endif
#ifndef DZSF001_HDR_13
#define DZSF001_HDR_13                  "Error Message Num"
#endif
#ifndef DZSF001_FIELD_DELIMITER
#define DZSF001_FIELD_DELIMITER	         " "
#endif
#ifndef DZSF001_PROG_NAME
#define DZSF001_PROG_NAME                "TAB"
#endif
#ifndef DZSF001_ERR_IT_TEST_DMP_FILES
#define DZSF001_ERR_IT_TEST_DMP_FILES	 "The iterative test has exhausted all the dump files."
#endif
#ifndef DZSF001_ERR_DMP_FILE_OPN_MSG
#define DZSF001_ERR_DMP_FILE_OPN_MSG     "TAB cannot open the dump file(s)."
#endif
#ifndef DZSF001_INVLD_DMP_FILE_PATH_MSG
#define DZSF001_INVLD_DMP_FILE_PATH_MSG  "Invalid path for the dump file(s)."
#endif
#ifndef DZSF001_ERR_ALLOC_MEM_MSG
#define DZSF001_ERR_ALLOC_MEM_MSG        "Memory allocation failure."
#endif
#ifndef DZSF001_ERR_HME_PATH
#define DZSF001_ERR_HME_PATH             "Control File path get failure"
#endif
#ifndef DZSF001_ERR_INIT_MSP_Q
#define DZSF001_ERR_INIT_MSP_Q           "Failed to initialize message queue."
#endif
#ifndef DZSF001_ERR_THREAD_STRT
#define DZSF001_ERR_THREAD_STRT          "Failed to launch thread."
#endif
#ifndef DZSF001_ERR_CNTLTAB_READ
#define DZSF001_ERR_CNTLTAB_READ         "Control file read failed."
#endif
#ifndef DZSF001_MSG_FILE_NM_FORMAT
#define DZSF001_MSG_FILE_NM_FORMAT       "CS%u"
#endif





/*
** EHEMMER  12/16/96   Added these #defines
**/
//#ifndef TAB_LOG_FILE
//#define TAB_LOG_FILE                    "C:\\DATA\\TAB.PRF"
//#endif
//#ifndef TAB_ERROR_LOG
//#define TAB_ERROR_LOG                   "C:\\DATA\\TAB.ERR"
//#endif
#ifndef TAB_CONTROL_INPUT_FILE
#define TAB_CONTROL_INPUT_FILE          "CONTROL.TAB"
#endif

/***************************************************************************
* Definition for Record Group.AZGCO011 STANDARD HEADER SUB GRP
***************************************************************************/
#ifndef _STNDRDHEADSUBGRP_z
#define _STNDRDHEADSUBGRP_z

typedef struct __StndrdHeadSubgrp
{
   double                KyBa;
   long                  KyCustNo;
   long                  KyPremNo;
   long                  KySpt;
   long                  KyFordNo;
   long                  IdEquipment;
   long                  NoFutureKeyX;
   long                  NoFutureKeyY;
   long                  NoFutureKeyZ;
   short                 NoLockSeqCust;
   short                 NoLockSeqPrem;
   short                 NoLockSeqBa;
   short                 NoLockSeqBaAim;
   short                 NoLockSeqSpt;
   short                 NoLockSeqFoHdr;
   short                 NoLOckSeqEquip;
   short                 NoLockSeqX;
   short                 NoLockSeqY;
   short                 NoLockSeqZ;
}  _STNDRDHEADSUBGRP;
#endif
/***************************************************************************
* Definition for Record Group.AZGCO012 PERF SUBGROUP 2
***************************************************************************/
#ifndef   CIS33358_ID_PREV_MSG_INST_LEN
#define   CIS33358_ID_PREV_MSG_INST_LEN         25
#define   IDPREVMSGINST_LEN                     25
#endif
#ifndef _PERFSUBGRP2_z
#define _PERFSUBGRP2_z

typedef struct __PerfSubgrp2
{
   char                  IdPrevMsgInst[25];
   float                 NoPrevRespTime;
}  _PERFSUBGRP2;
#endif
/***************************************************************************
* Definition for Record Group.AZGCO010 STANDARD HEADER
***************************************************************************/
#ifndef   CIS32330_CD_FUNCTION_IDENTIFIER_LEN
#define   CIS32330_CD_FUNCTION_IDENTIFIER_LEN   3
#define   CDFUNCID_LEN                          3
#endif
#ifndef   CIS08419_DT_CURR_DATE_LEN
#define   CIS08419_DT_CURR_DATE_LEN             11
#define   DTCURRDATE_LEN                        11
#endif
#ifndef   CIS02496_ID_DIALOGUE_LEN
#define   CIS02496_ID_DIALOGUE_LEN              9
#define   KYCONVID_LEN                          9
#endif
#ifndef   CIS33361_KY_USERID_2_LEN
#define   CIS33361_KY_USERID_2_LEN              9
#define   KYUSERID2_LEN                         9
#endif
#ifndef   CIS33359_CD_STD_MSG_HDR_FILLER_LEN
#define   CIS33359_CD_STD_MSG_HDR_FILLER_LEN    21
#define   CDSTDMSGHDRFLR_LEN                    21
#endif
#ifndef _STANDARDHEADER_z
#define _STANDARDHEADER_z

typedef struct __StandardHeader
{
   char                  CdFuncId[3];
   char                  DtCurrDate[11];
   char                  KyConvId[9];
   _STNDRDHEADSUBGRP     StndrdHeadSubgrp;
   char                  KyUserid2[9];
   double                NoSvcVersion;
   _PERFSUBGRP2          PerfSubgrp2;
   char                  CdStdMsgHdrFlr[21];
}  _STANDARDHEADER;
#endif

#ifndef _DATAAREA_z
#define _DATAAREA_z

typedef struct __DATAAREA
{
   _STANDARDHEADER       StandardHeader;
}  _DATAAREA;
#endif



/* Global Variables for Update of Window */  
SHORT           NumPools           = 0;
SHORT           ErrorMessageID     = 0;
SHORT           PoolCounter        = 0;

FLOAT           lElapsedTime       = (FLOAT)0.0;
FLOAT           InitialRandom      = (FLOAT)0.0;
FLOAT           PrevRandom         = (FLOAT)0.0;
FLOAT           lNetworkTime       = (FLOAT)0.0;
FLOAT           lTotalNumMessages  = (FLOAT)0.0;

ULONG           lClientMsgNbr      = 0;
ULONG           lTotalTime         = 0;
ULONG           lactuallengthsend  = 0;
ULONG           ldelaytime              = 0;
double          DZSF001_TestBeginTime   = 0;
double          DZSF001_PauseBeginTime  = 0;
double          DZSF001_PauseEndTime    = 0;
double          DZSF001_TotalPauseTime  = 0;
/*
** mdc 4/7/98 global drive 
*/
int            tabhome;
CHAR           TabControlFile[_PATH_LEN];

SHORT           sFirstTime         = 1;
SHORT           SavedRangeRandom   = 0;
SHORT           DelayThrottle      = 0;
SHORT           PoolSize           = 0;
SHORT           RefreshRate        = 0;
SHORT           FileLog            = 0;
SHORT           BeepFlag           = 0;
SHORT           Iterative          = 0;
/*CHAR            TAB_CSR_DUMP_FILE_DIRECTORY[50] = "";
CHAR            TAB_CSR_DUMP_FILE_INPUT[50] = "";
*/
CHAR            TabCsrDumpFileDirectory[_PATH_LEN] = "";
CHAR            TabCsrDumpFileInput[_PATH_LEN] = "";
CHAR            TabLogPathAndFile[_PATH_LEN] = "";
CHAR            TabErrPathAndFile[_PATH_LEN] = "";
CHAR            SaveIPAddress[DZSF001_ADDRESS_LEN] = "\0";
CHAR            lrandomfilename[DZSF001_FILENAME_LEN];
CHAR            lfunctioncode[DZSF001_FUNTION_CODE_LEN];
CHAR            NewWindowTitle[DZSF001_WINDOW_TITLE_LEN];
CHAR            SaveIDPrevMsgInst[DZSF001_SAVE_MESSAGE_ID_LEN];
CHAR            TabUserID[DZSF001_USER_ID_LEN] = "";
CHAR            TabUserPW[DZSF001_USER_PSWD_LEN] = "";

BOOL            DZSF001_FirstError = TRUE;
BOOL            DZSF001_FirstStat  = TRUE;
BOOL            DZSF001_Continue = TRUE;
BOOL            DZSF001_BeginTimeGotten = FALSE;

_MSG_PARM_BLOCK InitialParmBlock;



/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/
/*
** mdc 02/05/98 This is the structure for the thread parm block
*/
typedef struct __MY_PB
{
    HWND                     hwnd;
	PCALLBACKEVENTINFO        pEventInfo;
	EAIANAME                 *pEAIA;
    _BFCD                    *pBFCD;
	WESMAPTYPE               *pWesMap;
	WINCONTEXTNAME           *pWindContextData;
	unsigned                 LineNo;
	void                     *FileName;

}  _MY_PB;


/***************************************************************************/
/* Forward declarations for Functions                    */
/***************************************************************************/
WCBFWD ( DZSF001BusPrdis );
WCBFWD ( DZSF001BusRecvMsg );
WCBPROC( DZSF001BusContPBClick);
WCBPROC( DZSF001BusPausePBClick);

USHORT APIENTRY TABThread( _APM_START far *pApm, ABHINAME *pABHI);
SHORT TABGetPBAndMessage( _MSG_PARM_BLOCK *pMsgPB,
			   BYTE **ppMessage, CHAR *pRFileName, CMN_ARCH_PARM_TYPES );
SHORT TABRefreshControl( );



