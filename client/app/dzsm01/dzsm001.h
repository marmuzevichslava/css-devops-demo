/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*                Copyright (C) 1996, Andersen Consulting.                  *
*                          All rights reserved.                            *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZSM001C                            *
*                        Generated on: Fri Jul 31 15:39:21 1998            *
*                                  by: MCONNER                             *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

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
/***************************************************************************
* Definition for Record Group.DZSM001 SM SEARCH CRITERIA
***************************************************************************/
#ifndef   CIS33525_TX_COMPUTER_NAME_LEN
#define   CIS33525_TX_COMPUTER_NAME_LEN         16
#define   TXPCNAME_LEN                          16
#endif
#ifndef   CIS02898_KY_USER_ID_LEN
#define   CIS02898_KY_USER_ID_LEN               9
#define   KYUSERID_LEN                          9
#endif
#ifndef _SEARCHCRITERIA_z
#define _SEARCHCRITERIA_z

typedef struct __SearchCriteria
{
   char                  TxPcName[16];
   char                  KyUserId[9];
}  _SEARCHCRITERIA;
#endif
/***************************************************************************
* Definition for Record Group.CU10DA40 CLIENT PERFORM MONITOR
***************************************************************************/
#ifndef   CIS38865_TS_SLAM_TMSTMP_LEN
#define   CIS38865_TS_SLAM_TMSTMP_LEN           27
#define   TSSLAMTMSTMP_LEN                      27
#endif
#ifndef _CLIENTPERFMONITOR_z
#define _CLIENTPERFMONITOR_z

typedef struct __ClientPerfMonitor
{
   short                 QyFiveTenth;
   short                 QyOne;
   short                 QyOnePointFive;
   short                 QyTwo;
   short                 QyTwoPointFive;
   short                 QyThree;
   short                 QyThreePtFive;
   short                 QyFour;
   short                 QyFourPointFive;
   short                 QyFive;
   short                 QyOverFive;
   short                 QyUnknWndwEv;
   short                 QySFiveTenth;
   short                 QySOne;
   short                 QySOnePointFive;
   short                 QySTwo;
   short                 QySTwoPointFive;
   short                 QySThree;
   short                 QySThreePtFive;
   short                 QySFour;
   short                 QySFourPtFive;
   short                 QySFive;
   short                 QySSix;
   short                 QySSeven;
   short                 QySEight;
   short                 QySNine;
   short                 QySTen;
   short                 QySFifteen;
   short                 QySOverFifteen;
   short                 QyUnknSvcEvent;
   short                 QyErrInSvcCall;
   short                 QyMsgConvErr;
   short                 QtTotSvcCalls;
   char                  TsSlamTmstmp[27];
}  _CLIENTPERFMONITOR;
#endif
/***************************************************************************
* Definition for Record.DZSM001C SLAM REC
***************************************************************************/
#ifndef   DEV00603_SM_QUERY_TYPE_LEN
#define   DEV00603_SM_QUERY_TYPE_LEN            9
#define   QUERYTYPE_LEN                         9
#endif
#ifndef   ARC00271_FL_WINDOW_MOD_LEN
#define   ARC00271_FL_WINDOW_MOD_LEN            2
#define   FLWINDOWMOD_LEN                       2
#endif
#ifndef   DCCURTM_LEN
#define   DCCURTM_LEN                           4
#define   DCCURTM_LEN                           4
#endif
#ifndef _WCDDZSM001CSLAMREC_z
#define _WCDDZSM001CSLAMREC_z

typedef struct __WCDDzsm001cSlamRec
{
   _STANDARDHEADER       StandardHeader;
   _SEARCHCRITERIA       SearchCriteria;
   char                  QueryType[9];
   char                  FlWindowMod[2];
   unsigned long         Dcdate;
   char                  Dccurtm[4];
   _CLIENTPERFMONITOR    ClientPerfMonitor;
}  _WCDDZSM001CSLAMREC;
#endif

#define  WCD_StandardHeader    pWindContextData->StandardHeader
#define  WCD_SearchCriteria    pWindContextData->SearchCriteria
#define  WCD_QueryType         pWindContextData->QueryType
#define  WCD_FlWindowMod       pWindContextData->FlWindowMod
#define  WCD_Dcdate            pWindContextData->Dcdate
#define  WCD_Dccurtm           pWindContextData->Dccurtm
#define  WCD_ClientPerfMonitor pWindContextData->ClientPerfMonitor
#define  WINCONTEXTNAME        _WCDDZSM001CSLAMREC

