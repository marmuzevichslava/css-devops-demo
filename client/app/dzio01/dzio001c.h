/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZIO001C                            *
*                        Generated on: Mon Dec 02 19:27:38 1996            *
*                                  by: IPEREZAR                            *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record Group.AGRCO10 COMMON WCD ARCH LAYOUT
***************************************************************************/
#ifndef _ARCHDATA_z
#define _ARCHDATA_z

typedef struct __ArchData
{
   _CMN_ARCH_BLOCK*      pArchBlock;
}  _ARCHDATA;
#endif
/***************************************************************************
* Definition for Record Group.DZIO01K
***************************************************************************/
#ifndef   DZ00700_IO_MOD_NAME_LEN
#define   DZ00700_IO_MOD_NAME_LEN               9
#define   IOMODNM_LEN                           9
#endif
#ifndef   DZ00739_LEN
#define   DZ00739_LEN                           9
#define   SRCTYP_LEN                            9
#endif
#ifndef _DZIO01KEYS_z
#define _DZIO01KEYS_z

typedef struct __DZIO01Keys
{
   char                  Iomodnm[9];
   char                  SrcTyp[9];
}  _DZIO01KEYS;
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
* Definition for Record Group.DZIO001D
***************************************************************************/
#ifndef   DZ00701_PRIM_TABLE_LEN
#define   DZ00701_PRIM_TABLE_LEN                9
#define   PRIMTAB_LEN                           9
#endif
#ifndef   DZ00705_PRIM_TABLE_NAME__18__LEN
#define   DZ00705_PRIM_TABLE_NAME__18__LEN      19
#define   PRIMTABNM_LEN                         19
#endif
#ifndef   DZ00706_SUM_COL_ID_LEN
#define   DZ00706_SUM_COL_ID_LEN                9
#define   SUMCOL_LEN                            9
#endif
#ifndef   DZ00702_ALR_COPYBOOK_LEN
#define   DZ00702_ALR_COPYBOOK_LEN              9
#define   ALRCBOOK_LEN                          9
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
#ifndef   DZ00733_PRIMARY_TABLE_NAME_LEN
#define   DZ00733_PRIMARY_TABLE_NAME_LEN        19
#define   PRITABNM_LEN                          19
#endif
#ifndef   _DZIO001DATA__ORDER_BY_SIZE
#define   _DZIO001DATA__ORDER_BY_SIZE           5
#endif
#ifndef _DZIO001DATA_z
#define _DZIO001DATA_z

typedef struct __DZIO001Data
{
   char                  PrimTab[9];
   char                  PrimTabNm[19];
   char                  SumCol[9];
   char                  Alrcbook[9];
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
   char                  PriTabNm[19];
   _ORDER_BY             Order_By[5];
}  _DZIO001DATA;
#endif
/***************************************************************************
* Definition for Record Group.DZIO001R
***************************************************************************/
#ifndef _DZIO001RQST_z
#define _DZIO001RQST_z

typedef struct __DZIO001Rqst
{
   unsigned short        CdMsgioStatus;
   unsigned short        CdServErrMsg;
   long                  CdReturn;
   _DZIO01KEYS           DZIO01Keys;
   _DZIO001DATA          DZIO001Data;
}  _DZIO001RQST;
#endif
/***************************************************************************
* Definition for Record.DZIO001C
***************************************************************************/
#ifndef _WCDDZIO001C_z
#define _WCDDZIO001C_z

typedef struct __WCDDZIO001C
{
   _ARCHDATA             ArchData;
   _DZIO001RQST          DZIO001Rqst;
}  _WCDDZIO001C;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WCD_DZIO001Rqst       pWindContextData->DZIO001Rqst
#define  WINCONTEXTNAME        _WCDDZIO001C

