/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZBA003I                            *
*                        Generated on: Thu Aug 29 17:59:08 1996            *
*                                  by: IPEREZAR                            *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record Group.DZCBA03K
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
#ifndef _DZCBA03KEYS_z
#define _DZCBA03KEYS_z

typedef struct __DZCBA03Keys
{
   char                  CdAccessType[3];
   double                KyBa;
   unsigned long         KyPremNo;
   unsigned long         KyBldgNo;
   char                  TsKyExtract[27];
   char                  TxExtractRemarks2[81];
}  _DZCBA03KEYS;
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
* Definition for Record.DZBA003I
***************************************************************************/
#ifndef _DZBA003INPUT_z
#define _DZBA003INPUT_z

typedef struct __DZBA003Input
{
   _DZCBA03KEYS          DZCBA03Keys;
   _DZCBA02DATA          DZCBA02Data;
}  _DZBA003INPUT;
#endif


