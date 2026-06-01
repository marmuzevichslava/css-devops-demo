/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZBA001C                            *
*                        Generated on: Thu Jan 30 09:46:52 1997            *
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
* Definition for Record Group.DZBA004C
***************************************************************************/
#ifndef   DEV00858_SERVER_FILE_PATH_LEN
#define   DEV00858_SERVER_FILE_PATH_LEN         51
#define   SERVERFILEPATH_LEN                    51
#endif
#ifndef   DEV00859_CLIENT_FILE_PATH_LEN
#define   DEV00859_CLIENT_FILE_PATH_LEN         51
#define   CLIENTFILEPATH_LEN                    51
#endif
#ifndef   DEV00860_EXPORT_FILE_LEN
#define   DEV00860_EXPORT_FILE_LEN              9
#define   EXPORTFILE_LEN                        9
#endif
#ifndef   DEV00861_IMPORT_FILE_LEN
#define   DEV00861_IMPORT_FILE_LEN              9
#define   IMPORTFILE_LEN                        9
#endif
#ifndef   DEV00862_WORKING_DIRECTORY_LEN
#define   DEV00862_WORKING_DIRECTORY_LEN        9
#define   WORKINGDIRECTORY_LEN                  9
#endif
#ifndef _DZBA004C_z
#define _DZBA004C_z

typedef struct __Dzba004c
{
   char                  ServerFilePath[51];
   char                  ClientFilePath[51];
   char                  ExportFile[9];
   char                  ImportFile[9];
   char                  WorkingDirectory[9];
}  _DZBA004C;
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
   _DZBA004C             Dzba004c;
}  _WCDSWAT01AWCD;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WCD_SWAT01ARqst       pWindContextData->SWAT01ARqst
#define  WCD_pWorkingStorageData pWindContextData->pWorkingStorageData
#define  WCD_Dzba004c          pWindContextData->Dzba004c
#define  WINCONTEXTNAME        _WCDSWAT01AWCD

