/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZBA002C                            *
*                        Generated on: Thu Aug 29 17:59:08 1996            *
*                                  by: IPEREZAR                            *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record Group.AGRCO10
***************************************************************************/
#ifndef _ARCHDATA_z
#define _ARCHDATA_z

typedef struct __ArchData
{
   _CMN_ARCH_BLOCK*      pArchBlock;
}  _ARCHDATA;
#endif
/***************************************************************************
* Definition for Record Group.SWAT01B
***************************************************************************/
#ifndef   DEV00808_CD_EXTRACT_INSERT_ACT_LEN
#define   DEV00808_CD_EXTRACT_INSERT_ACT_LEN    3
#define   CDEXTRACTINSERTACT_LEN                3
#endif
#ifndef   DEV00802_CD_ACCESS_TYPE_LEN
#define   DEV00802_CD_ACCESS_TYPE_LEN           3
#define   CDACCESSTYPE_LEN                      3
#endif
#ifndef   DEV00817_KY_EXTRACT_NO_A_LEN
#define   DEV00817_KY_EXTRACT_NO_A_LEN          12
#define   KYEXTRACTNOA_LEN                      12
#endif
#ifndef   DEV00818_TS_KY_EXTRACT_LEN
#define   DEV00818_TS_KY_EXTRACT_LEN            27
#define   TSKYEXTRACT_LEN                       27
#endif
#ifndef   DEV00819_TX_EXTRACT_REMARKS_2_LEN
#define   DEV00819_TX_EXTRACT_REMARKS_2_LEN     81
#define   TXEXTRACTREMARKS2_LEN                 81
#endif
#ifndef _SWAT01BDATA_z
#define _SWAT01BDATA_z

typedef struct __SWAT01BData
{
   char                  CdExtractInsertAct[3];
   char                  CdAccessType[3];
   double                KyExtractNo;
   char                  KyExtractNoA[12];
   char                  TsKyExtract[27];
   char                  TxExtractRemarks2[81];
}  _SWAT01BDATA;
#endif
/***************************************************************************
* Definition for Record Group.SWAT01R RQST
***************************************************************************/
#ifndef   DEV00832_CD_FUNC_ID_LEN
#define   DEV00832_CD_FUNC_ID_LEN               3
#define   CDFUNCID_LEN                          3
#endif
#ifndef _SWAT01BRQST_z
#define _SWAT01BRQST_z

typedef struct __SWAT01BRqst
{
   unsigned short        QyAlrAclCnt;
   _SWAT01BDATA          SWAT01BData;
   char                  CdFuncId[3];
}  _SWAT01BRQST;
#endif
/***************************************************************************
* Definition for Record.DZBA002C
***************************************************************************/
#ifndef _WCDSWAT01BWCD_z
#define _WCDSWAT01BWCD_z

typedef struct __WCDSWAT01BWCD
{
   _ARCHDATA             ArchData;
   _SWAT01BRQST          SWAT01BRqst;
   char*                 pWorkingStorageData;
}  _WCDSWAT01BWCD;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WCD_SWAT01BRqst       pWindContextData->SWAT01BRqst
#define  WCD_pWorkingStorageData pWindContextData->pWorkingStorageData
#define  WINCONTEXTNAME        _WCDSWAT01BWCD

