/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZBA001C                            *
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
* Definition for Record Group.DZCBA006
***************************************************************************/
#ifndef   DEV00808_CD_EXTRACT_INSERT_ACT_LEN
#define   DEV00808_CD_EXTRACT_INSERT_ACT_LEN    3
#define   CDEXTRACTINSERTACT_LEN                3
#endif
#ifndef   DEV00809_TX_EXTRACT_DB_ID_LEN
#define   DEV00809_TX_EXTRACT_DB_ID_LEN         11
#define   TXEXTRACTDBID_LEN                     11
#endif
#ifndef   DEV00810_TX_INSERT_DB_ID_LEN
#define   DEV00810_TX_INSERT_DB_ID_LEN          11
#define   TXINSERTDBID_LEN                      11
#endif
#ifndef   DEV00811_TX_EXTRACT_OWNER_ID_LEN
#define   DEV00811_TX_EXTRACT_OWNER_ID_LEN      31
#define   TXEXTRACTOWNERID_LEN                  31
#endif
#ifndef   DEV00812_TX_INSERT_OWNER_ID_LEN
#define   DEV00812_TX_INSERT_OWNER_ID_LEN       31
#define   TXINSERTOWNERID_LEN                   31
#endif
#ifndef   DEV00813_TX_EXTRACT_PSSWD_ID_LEN
#define   DEV00813_TX_EXTRACT_PSSWD_ID_LEN      31
#define   TXEXTRACTPSSWDID_LEN                  31
#endif
#ifndef   DEV00814_TX_INSERT_PSSWD_ID_LEN
#define   DEV00814_TX_INSERT_PSSWD_ID_LEN       31
#define   TXINSERTPSSWDID_LEN                   31
#endif
#ifndef   DEV00815_TX_EXTRACT_REMARKS_LEN
#define   DEV00815_TX_EXTRACT_REMARKS_LEN       81
#define   TXEXTRACTREMARKS_LEN                  81
#endif
#ifndef _SWAT01ADATA_z
#define _SWAT01ADATA_z

typedef struct __SWAT01AData
{
   char                  CdExtractInsertAct[3];
   char                  TxExtractDbId[11];
   char                  TxInsertDbId[11];
   char                  TxExtractOwnerId[31];
   char                  TxInsertOwnerId[31];
   char                  TxExtractPsswdId[31];
   char                  TxInsertPsswdId[31];
   char                  TxExtractRemarks[81];
}  _SWAT01ADATA;
#endif
/***************************************************************************
* Definition for Record Group.DZCBA007
***************************************************************************/
#ifndef   DEV00802_CD_ACCESS_TYPE_LEN
#define   DEV00802_CD_ACCESS_TYPE_LEN           3
#define   CDACCESSTYPE_LEN                      3
#endif
#ifndef   DEV00818_TS_KY_EXTRACT_LEN
#define   DEV00818_TS_KY_EXTRACT_LEN            27
#define   TSKYEXTRACT_LEN                       27
#endif
#ifndef   DEV00815_TX_EXTRACT_REMARKS_LEN
#define   DEV00815_TX_EXTRACT_REMARKS_LEN       81
#define   TXEXTRACTREMARKS_LEN                  81
#endif
#ifndef _SWAT01AGROUP_z
#define _SWAT01AGROUP_z

typedef struct __SWAT01AGroup
{
   char                  CdAccessType[3];
   double                KyExtractNo;
   char                  TsKyExtract[27];
   char                  TxExtractRemarks[81];
}  _SWAT01AGROUP;
#endif
/***************************************************************************
* Definition for Record Group.SWAT01A RQST
***************************************************************************/
#ifndef   _SWAT01ARQST__SWAT01AGROUP_SIZE
#define   _SWAT01ARQST__SWAT01AGROUP_SIZE       40
#endif
#ifndef   DEV00832_CD_FUNC_ID_LEN
#define   DEV00832_CD_FUNC_ID_LEN               3
#define   CDFUNCID_LEN                          3
#endif
#ifndef _SWAT01ARQST_z
#define _SWAT01ARQST_z

typedef struct __SWAT01ARqst
{
   unsigned short        QyAlrAclCnt;
   _SWAT01ADATA          SWAT01AData;
   _SWAT01AGROUP         SWAT01AGroup[40];
   char                  CdFuncId[3];
}  _SWAT01ARQST;
#endif
/***************************************************************************
* Definition for Record.DZBA001C
***************************************************************************/
#ifndef _WCDSWAT01AWCD_z
#define _WCDSWAT01AWCD_z

typedef struct __WCDSWAT01AWCD
{
   _ARCHDATA             ArchData;
   _SWAT01ARQST          SWAT01ARqst;
   char*                 pWorkingStorageData;
}  _WCDSWAT01AWCD;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WCD_SWAT01ARqst       pWindContextData->SWAT01ARqst
#define  WCD_pWorkingStorageData pWindContextData->pWorkingStorageData
#define  WINCONTEXTNAME        _WCDSWAT01AWCD

