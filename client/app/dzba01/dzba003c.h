/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZBA003C                            *
*                        Generated on: Thu Jan 30 09:46:52 1997            *
*                                  by: IPEREZAR                            *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record Group.DZCBA02K
***************************************************************************/
#ifndef   DEV00802_CD_ACCESS_TYPE_LEN
#define   DEV00802_CD_ACCESS_TYPE_LEN           3
#define   CDACCESSTYPE_LEN                      3
#endif
#ifndef   DEV00801_ARCH_OTH_TS_DT_TM_LEN
#define   DEV00801_ARCH_OTH_TS_DT_TM_LEN        27
#define   TSKYEXTRACT_LEN                       27
#endif
#ifndef   DEV00819_TX_EXTRACT_REMARKS_2_LEN
#define   DEV00819_TX_EXTRACT_REMARKS_2_LEN     81
#define   TXEXTRACTREMARKS2_LEN                 81
#endif
#ifndef _DZCBA02KEYS_z
#define _DZCBA02KEYS_z

typedef struct __DZCBA02Keys
{
   char                  CdAccessType[3];
   double                KyBa;
   unsigned long         KyPremNo;
   unsigned long         KyBldgNo;
   char                  TsKyExtract[27];
   char                  TxExtractRemarks2[81];
}  _DZCBA02KEYS;
#endif
/***************************************************************************
* Definition for Record Group.DZCBA02J
***************************************************************************/
#ifndef   DEV00804_TXN_USR_ID_LEN
#define   DEV00804_TXN_USR_ID_LEN               11
#define   TXNUSRID_LEN                          11
#endif
#ifndef _DZCBA02J_z
#define _DZCBA02J_z

typedef struct __DZCBA02J
{
   char                  TxnUsrId[11];
}  _DZCBA02J;
#endif
/***************************************************************************
* Definition for Record Group.DZCBA02D
***************************************************************************/
#ifndef   DEV00801_ARCH_OTH_TS_DT_TM_LEN
#define   DEV00801_ARCH_OTH_TS_DT_TM_LEN        27
#define   TSKYEXTRACT_LEN                       27
#endif
#ifndef   DEV00804_TXN_USR_ID_LEN
#define   DEV00804_TXN_USR_ID_LEN               11
#define   TXNUSRID_LEN                          11
#endif
#ifndef   DEV00819_TX_EXTRACT_REMARKS_2_LEN
#define   DEV00819_TX_EXTRACT_REMARKS_2_LEN     81
#define   TXEXTRACTREMARKS2_LEN                 81
#endif
#ifndef _DZCBA02DATA_z
#define _DZCBA02DATA_z

typedef struct __DZCBA02Data
{
   double                KyBa;
   char                  TsKyExtract[27];
   char                  TxnUsrId[11];
   char                  TxExtractRemarks2[81];
}  _DZCBA02DATA;
#endif
/***************************************************************************
* Definition for Record Group.DZBA003R
***************************************************************************/
#ifndef   _DZBA003RQST__DZCBA02DATA_SIZE
#define   _DZBA003RQST__DZCBA02DATA_SIZE        100
#endif
#ifndef _DZBA003RQST_z
#define _DZBA003RQST_z

typedef struct __DZBA003Rqst
{
   _DZCBA02KEYS          DZCBA02Keys;
   _DZCBA02J             DZCBA02J;
   _DZCBA02DATA          DZCBA02Data[100];
}  _DZBA003RQST;
#endif
/***************************************************************************
* Definition for Record.DZBA003C
***************************************************************************/
#ifndef _WCDDZBA003WCD_z
#define _WCDDZBA003WCD_z

typedef struct __WCDDZBA003WCD
{
   _DZBA003RQST          DZBA003Rqst;
}  _WCDDZBA003WCD;
#endif

#define  WCD_DZBA003Rqst       pWindContextData->DZBA003Rqst
#define  WINCONTEXTNAME        _WCDDZBA003WCD

