/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: CUCR031C COLL OBJ SEL C TRAN MAP    *
*                        Generated on: Mon Jan 27 14:46:16 1997            *
*                                  by: EAHEMMER                            *
*                   Short Description: CUCR031C COLL OBJ SEL C TRAN MAP    *
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
* Definition for Record Group.CUR31H01 HDR-CUMDT001
***************************************************************************/
#ifndef _HDRCUMDT001_z
#define _HDRCUMDT001_z

typedef struct __HdrCUMDT001
{
   long                  CdReturn;
   short                 QyALRAclCnt;
}  _HDRCUMDT001;
#endif
/***************************************************************************
* Definition for Record Group.CUR31H14 HDR-CU0246C
***************************************************************************/
#ifndef   CIS32816_FL_INSPECTION_DETAILS_LEN
#define   CIS32816_FL_INSPECTION_DETAILS_LEN    2
#define   FLVERIFYDETAILS_LEN                   2
#endif
#ifndef   CIS30131_CD_OPERATING_CENTER_LEN
#define   CIS30131_CD_OPERATING_CENTER_LEN      4
#define   CDOPERCNTR_LEN                        4
#endif
#ifndef   CIS30069_CD_BILL_ACCT_CLASSIFICA_LEN
#define   CIS30069_CD_BILL_ACCT_CLASSIFICA_LEN  2
#define   CDBACLASSIFICATN_LEN                  2
#endif
#ifndef   CIS00928_CD_BILL_ACCOUNT_STATUS_LEN
#define   CIS00928_CD_BILL_ACCOUNT_STATUS_LEN   3
#define   CDBASTAT_LEN                          3
#endif
#ifndef   CIS30070_CD_LIQUIDATION_SELECTIO_LEN
#define   CIS30070_CD_LIQUIDATION_SELECTIO_LEN  2
#define   CDBANKLIQRECVR_LEN                    2
#endif
#ifndef   ARC00112_CD_ACCESS_COMMAND_CODE_LEN
#define   ARC00112_CD_ACCESS_COMMAND_CODE_LEN   3
#define   CDACSCMD_LEN                          3
#endif
#ifndef   ARC00257_FL_DATA_ABOVE_LEN
#define   ARC00257_FL_DATA_ABOVE_LEN            2
#define   FLDATAABOVE_LEN                       2
#endif
#ifndef   ARC00258_FL_DATA_BELOW_LEN
#define   ARC00258_FL_DATA_BELOW_LEN            2
#define   FLDATABELOW_LEN                       2
#endif
#ifndef   CIS31180_CD_COLLECTION_STATUS_DE_LEN
#define   CIS31180_CD_COLLECTION_STATUS_DE_LEN  4
#define   CDCOLLSTATDETL_LEN                    4
#endif
#ifndef   CIS30000_CD_COLLECTION_LIST_TYPE_LEN
#define   CIS30000_CD_COLLECTION_LIST_TYPE_LEN  2
#define   CDCOLLCTNLSTTYP_LEN                   2
#endif
#ifndef   CIS35228_CD_ELIGIBLE_BUS_TYPE_LEN
#define   CIS35228_CD_ELIGIBLE_BUS_TYPE_LEN     3
#define   CDELIGBUSTYPE_LEN                     3
#endif
#ifndef   CIS35223_CD_LAST_MERCH_COLL_ACT_LEN
#define   CIS35223_CD_LAST_MERCH_COLL_ACT_LEN   4
#define   CDLSTMRCHACTION_LEN                   4
#endif
#ifndef _HDRCU0246C_z
#define _HDRCU0246C_z

typedef struct __HdrCU0246C
{
   long                  CdReturn;
   short                 QyALRAclCnt;
   char                  FlVerifyDetails[2];
   double                AtOrigNtcTot;
   double                KyBa;
   char                  CdOperCntr[4];
   char                  CdBAClassificatn[2];
   char                  CdBaStat[3];
   double                AtMinPastDue;
   double                AtMaxPastDue;
   short                 QyMinDyPDue;
   short                 QyMaxDyPDue;
   char                  CdBankLiqRecvr[2];
   char                  CdAcsCmd[3];
   char                  FlDataAbove[2];
   char                  FlDataBelow[2];
   char                  CdCollStatDetl[4];
   short                 KyMtrBillGrp1;
   short                 KyMtrBillGrp2;
   short                 KyMrdgAsgnmt;
   short                 KyMrdgAsgnmt1;
   char                  CdCollctnLstTyp[2];
   short                 CdCo;
   char                  CdEligBusType[3];
   long                  QyNumOfAccts;
   char                  CdLstMrchAction[4];
}  _HDRCU0246C;
#endif
/***************************************************************************
* Definition for Record Group.CUR31H11 HDR-COLLECTION
***************************************************************************/
#ifndef _HDRCOLLECTION_z
#define _HDRCOLLECTION_z

typedef struct __HdrCollection
{
   _HDRCU0246C           HdrCU0246C;
}  _HDRCOLLECTION;
#endif
/***************************************************************************
* Definition for Record Group.CUR31D14 DAT-CU0246C
***************************************************************************/
#ifndef   CIS01050_NM_CUSTOMER_1_LEN
#define   CIS01050_NM_CUSTOMER_1_LEN            29
#define   NMCUST1_LEN                           29
#endif
#ifndef   CIS35223_CD_LAST_MERCH_COLL_ACT_LEN
#define   CIS35223_CD_LAST_MERCH_COLL_ACT_LEN   4
#define   CDLSTMRCHACTION_LEN                   4
#endif
#ifndef   CIS31180_CD_COLLECTION_STATUS_DE_LEN
#define   CIS31180_CD_COLLECTION_STATUS_DE_LEN  4
#define   CDCOLLSTATDETL_LEN                    4
#endif
#ifndef _DATCU0246C_z
#define _DATCU0246C_z

typedef struct __DatCU0246C
{
   short                 QyOverdueBill;
   double                KyBa;
   double                AtOrigNtcOther;
   char                  NmCust1[29];
   long                  KyCustNo;
   short                 KyMtrBillGrp;
   short                 KyMrdgAsgnmt;
   char                  CdLstMrchAction[4];
   char                  CdCollStatDetl[4];
}  _DATCU0246C;
#endif
/***************************************************************************
* Definition for Record Group.CUR31D11 DAT COLLECTION
***************************************************************************/
#ifndef _DATCOLLECTION_z
#define _DATCOLLECTION_z

typedef struct __DatCollection
{
   _DATCU0246C           DatCU0246C;
}  _DATCOLLECTION;
#endif
/***************************************************************************
* Definition for Record Group.CUR31G04 MAIN COLLECTION GROUP
***************************************************************************/
#ifndef   _MAINCOLLECTIONGROUP__DATCOLLECTION_SIZE
#define   _MAINCOLLECTIONGROUP__DATCOLLECTION_SIZE   300
#endif
#ifndef _MAINCOLLECTIONGROUP_z
#define _MAINCOLLECTIONGROUP_z

typedef struct __MainCollectionGroup
{
   _HDRCOLLECTION        HdrCollection;
   _DATCOLLECTION        DatCollection[300];
}  _MAINCOLLECTIONGROUP;
#endif
/***************************************************************************
* Definition for Record.CUCR031C COLLECTION OBJ SEL "C"
***************************************************************************/
#ifndef   _CUCR031C__CD_FILLER_GEN_SERV_SIZE
#define   _CUCR031C__CD_FILLER_GEN_SERV_SIZE    14979
#endif
#ifndef _CUCR031C_z
#define _CUCR031C_z

typedef struct __CUCR031C
{
   _STANDARDHEADER       StandardHeader;
   _HDRCUMDT001          HdrCUMDT001;
   _MAINCOLLECTIONGROUP  MainCollectionGroup;
   unsigned char         CD_FILLER_GEN_SERV[14979];
}  _CUCR031C;
#endif


