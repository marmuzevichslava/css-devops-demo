/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZCL002O                            *
*                        Generated on: Tue Oct 01 09:25:43 1996            *
*                                  by: IPEREZAR                            *
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
* Definition for Record Group.DZR01H01
***************************************************************************/
#ifndef   DZ00700_IO_MOD_NAME_LEN
#define   DZ00700_IO_MOD_NAME_LEN               9
#define   IOMODNM_LEN                           9
#endif
#ifndef   DZ00706_SUM_COL_ID_LEN
#define   DZ00706_SUM_COL_ID_LEN                9
#define   SUMCOL_LEN                            9
#endif
#ifndef   DZ00702_ALR_COPYBOOK_LEN
#define   DZ00702_ALR_COPYBOOK_LEN              9
#define   ALRCBOOK_LEN                          9
#endif
#ifndef   DZ00737_LEN
#define   DZ00737_LEN                           9
#define   FUNCNM_LEN                            9
#endif
#ifndef   DZ00708_FETCH_LEN
#define   DZ00708_FETCH_LEN                     2
#define   FETCH_LEN                             2
#endif
#ifndef   DZ00709_INSERT_LEN
#define   DZ00709_INSERT_LEN                    2
#define   INSERT_LEN                            2
#endif
#ifndef   DZ00710_UPDATE_LEN
#define   DZ00710_UPDATE_LEN                    2
#define   UPDATE_LEN                            2
#endif
#ifndef   DZ00711_SUM_LEN
#define   DZ00711_SUM_LEN                       2
#define   SUM_LEN                               2
#endif
#ifndef   DZ00712_COUNT_LEN
#define   DZ00712_COUNT_LEN                     2
#define   COUNT_LEN                             2
#endif
#ifndef   DZ00713_DYNAMIC_SCREENING_LEN
#define   DZ00713_DYNAMIC_SCREENING_LEN         2
#define   DYNSCR_LEN                            2
#endif
#ifndef   DZ00715_DELETE_LEN
#define   DZ00715_DELETE_LEN                    2
#define   DELETE_LEN                            2
#endif
#ifndef   DZ00716_FETCH_NEXT_LEN
#define   DZ00716_FETCH_NEXT_LEN                2
#define   FETNX_LEN                             2
#endif
#ifndef   DZ00717_FETCH_PREVIOUS_LEN
#define   DZ00717_FETCH_PREVIOUS_LEN            2
#define   FETPREV_LEN                           2
#endif
#ifndef   DZ00718_INSERT_SET_LEN
#define   DZ00718_INSERT_SET_LEN                2
#define   INSSET_LEN                            2
#endif
#ifndef   DZ00719_UPDATE_SET_LEN
#define   DZ00719_UPDATE_SET_LEN                2
#define   UPDSET_LEN                            2
#endif
#ifndef   DZ00720_COUNT_VALUE_LEN
#define   DZ00720_COUNT_VALUE_LEN               2
#define   UNIQUE_LEN                            2
#endif
#ifndef   DZ00721_CUSTOM_FUNCTIONS_LEN
#define   DZ00721_CUSTOM_FUNCTIONS_LEN          2
#define   CSTFUN_LEN                            2
#endif
#ifndef   DZ00722_DELETE_SET_LEN
#define   DZ00722_DELETE_SET_LEN                2
#define   DELSET_LEN                            2
#endif
#ifndef   DZ00723_SUM_MULTIPLE_LEN
#define   DZ00723_SUM_MULTIPLE_LEN              2
#define   SUMMUL_LEN                            2
#endif
#ifndef   DZ00724_COUNT_MULTIPLE_LEN
#define   DZ00724_COUNT_MULTIPLE_LEN            2
#define   CNTMUL_LEN                            2
#endif
#ifndef   DZ00725_RENAME_LEN
#define   DZ00725_RENAME_LEN                    2
#define   RENAME_LEN                            2
#endif
#ifndef   DZ00726_CONTROLS_LEN
#define   DZ00726_CONTROLS_LEN                  2
#define   CONTROLS_LEN                          2
#endif
#ifndef   DZ00732_VIEW_NAME_LEN
#define   DZ00732_VIEW_NAME_LEN                 19
#define   VW_NM_LEN                             19
#endif
#ifndef _HDR_DZ0101_z
#define _HDR_DZ0101_z

typedef struct __Hdr_DZ0101
{
   char                  Iomodnm[9];
   char                  SumCol[9];
   char                  Alrcbook[9];
   char                  FuncNm[9];
   char                  Fetch[2];
   char                  Insert[2];
   char                  Update[2];
   char                  Sum[2];
   char                  Count[2];
   char                  DynScr[2];
   char                  Delete[2];
   char                  FetNx[2];
   char                  FetPrev[2];
   char                  InsSet[2];
   char                  UpdSet[2];
   char                  Unique[2];
   char                  CstFun[2];
   char                  DelSet[2];
   char                  SumMul[2];
   char                  CntMul[2];
   char                  Rename[2];
   char                  Controls[2];
   char                  Vw_Nm[19];
}  _HDR_DZ0101;
#endif
/***************************************************************************
* Definition for Record Group.DZR01H02
***************************************************************************/
#ifndef   DZ00701_PRIM_TABLE_LEN
#define   DZ00701_PRIM_TABLE_LEN                9
#define   PRIMTAB_LEN                           9
#endif
#ifndef   DZ00702_ALR_COPYBOOK_LEN
#define   DZ00702_ALR_COPYBOOK_LEN              9
#define   ALRCBOOK_LEN                          9
#endif
#ifndef   DZ00732_VIEW_NAME_LEN
#define   DZ00732_VIEW_NAME_LEN                 19
#define   VW_NM_LEN                             19
#endif
#ifndef   DZ00705_PRIM_TABLE_NAME__18__LEN
#define   DZ00705_PRIM_TABLE_NAME__18__LEN      19
#define   PRIMTABNM_LEN                         19
#endif
#ifndef _HDR_DZ0202_z
#define _HDR_DZ0202_z

typedef struct __Hdr_DZ0202
{
   char                  PrimTab[9];
   char                  Alrcbook[9];
   char                  Vw_Nm[19];
   char                  PrimTabNm[19];
}  _HDR_DZ0202;
#endif
/***************************************************************************
* Definition for Record Group.DZR01H00
***************************************************************************/
#ifndef   DZ00770_DESCENDING_KEY_LEN
#define   DZ00770_DESCENDING_KEY_LEN            9
#define   DESCKEY_LEN                           9
#endif
#ifndef   DZ00775_ORDER_FLAG_LEN
#define   DZ00775_ORDER_FLAG_LEN                2
#define   ORDFLG_LEN                            2
#endif
#ifndef _ORDER_BY_z
#define _ORDER_BY_z

typedef struct __Order_By
{
   char                  DescKey[9];
   char                  OrdFlg[2];
   float                 OrdPos;
}  _ORDER_BY;
#endif
/***************************************************************************
* Definition for Record.DZCL002O
***************************************************************************/
#ifndef   _DZCL001OUTPUT__ORDER_BY_SIZE
#define   _DZCL001OUTPUT__ORDER_BY_SIZE         5
#endif
#ifndef _DZCL001OUTPUT_z
#define _DZCL001OUTPUT_z

typedef struct __DZCL001Output
{
   _STANDARDHEADER       StandardHeader;
   _HDR_DZ0101           Hdr_DZ0101;
   _HDR_DZ0202           Hdr_DZ0202;
   _ORDER_BY             Order_By[5];
}  _DZCL001OUTPUT;
#endif


