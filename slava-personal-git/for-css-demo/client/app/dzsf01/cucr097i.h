/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: CUCR097I SELECT BUSINESS RETR       *
*                        Generated on: Tue Jan 14 16:16:28 1997            *
*                                  by: CLAWSON                             *
*                   Short Description: CUCR097I SELECT BUSINESS RETR       *
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
* Definition for Record Group.CUR97H01 HDR-CU0501C
***************************************************************************/
#ifndef _HDRCU0501C_z
#define _HDRCU0501C_z

typedef struct __HdrCU0501C
{
   long                  CdReturn;
   short                 QyALRAclCnt;
   double                KyBa;
}  _HDRCU0501C;
#endif
/***************************************************************************
* Definition for Record Group.CUR97H02 HDR-CU0502H
***************************************************************************/
#ifndef _HDRCU0502H_z
#define _HDRCU0502H_z

typedef struct __HdrCU0502H
{
   long                  CdReturn;
   short                 QyALRAclCnt;
   double                KyBa;
}  _HDRCU0502H;
#endif
/***************************************************************************
* Definition for Record Group.CUR97D01 DAT-CU0501C-0502H
***************************************************************************/
#ifndef   CIS00277_DT_PROCESS_LEN
#define   CIS00277_DT_PROCESS_LEN               11
#define   DTPRCS_LEN                            11
#endif
#ifndef   CIS01081_CD_BUSINESS_LEN
#define   CIS01081_CD_BUSINESS_LEN              5
#define   CDBUS_LEN                             5
#endif
#ifndef   CIS03407_CD_BUSINESS_PRODUCT_STA_LEN
#define   CIS03407_CD_BUSINESS_PRODUCT_STA_LEN  3
#define   CDBUSPRODSTAT_LEN                     3
#endif
#ifndef   CIS04760_TX_PRODUCT_LONG_DECODE_LEN
#define   CIS04760_TX_PRODUCT_LONG_DECODE_LEN   35
#define   TXPRODLONG_LEN                        35
#endif
#ifndef   CIS05468_CD_BUSINESS_DIRECTORY_LEN
#define   CIS05468_CD_BUSINESS_DIRECTORY_LEN    2
#define   CDBUSDIR_LEN                          2
#endif
#ifndef   CIS33564_CD_FINAL_REASON_LEN
#define   CIS33564_CD_FINAL_REASON_LEN          3
#define   CDFINALREASON_LEN                     3
#endif
#ifndef   CIS33566_KY_ALT_ORD_NO_LEN
#define   CIS33566_KY_ALT_ORD_NO_LEN            9
#define   KYALTORDNO_LEN                        9
#endif
#ifndef   CIS33567_FL_COMBINE_LEN
#define   CIS33567_FL_COMBINE_LEN               2
#define   FLCOMBINE_LEN                         2
#endif
#ifndef   CIS00616_CD_DEPOSIT_LEN
#define   CIS00616_CD_DEPOSIT_LEN               2
#define   CDDEP_LEN                             2
#endif
#ifndef _DATCU0501C0502H_z
#define _DATCU0501C0502H_z

typedef struct __DatCU0501C0502H
{
   char                  DtPrcs[11];
   long                  KyProdOrdno;
   char                  CdBus[5];
   long                  CdProd;
   double                AtUnbilBal;
   double                AtOpenMoBal;
   double                AtMoAct;
   char                  CdBusProdStat[3];
   char                  TxProdLong[35];
   char                  CdBusDir[2];
   char                  CdFinalReason[3];
   char                  KyAltOrdNo[9];
   char                  FlCombine[2];
   char                  CdDep[2];
}  _DATCU0501C0502H;
#endif
/***************************************************************************
* Definition for Record.CUCR097I SELECT BUSINESS RETR
***************************************************************************/
#ifndef   _CUCR097I__DATCU0501C0502H_SIZE
#define   _CUCR097I__DATCU0501C0502H_SIZE       100
#endif
#ifndef _CUCR097I_z
#define _CUCR097I_z

typedef struct __CUCR097I
{
   _STANDARDHEADER       StandardHeader;
   _HDRCU0501C           HdrCU0501C;
   _HDRCU0502H           HdrCU0502H;
   _DATCU0501C0502H      DatCU0501C0502H[100];
}  _CUCR097I;
#endif


