/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZIO002C                            *
*                        Generated on: Mon Dec 02 19:27:38 1996            *
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
* Definition for Record Group.DZSR002K
***************************************************************************/
#ifndef   DEV00235_LEN
#define   DEV00235_LEN                          9
#define   CDOBJECTTYPE_LEN                      9
#endif
#ifndef   DEV00231_LEN
#define   DEV00231_LEN                          33
#define   TXOBJECTDESC_LEN                      33
#endif
#ifndef   DEV00369_LEN
#define   DEV00369_LEN                          2
#define   WORDRETURN_LEN                        2
#endif
#ifndef   DEV00330_LEN
#define   DEV00330_LEN                          3
#define   DDIOFUNCTIONCODE_LEN                  3
#endif
#ifndef   DEV00700_ORIGINATING_REPOSITORY_LEN
#define   DEV00700_ORIGINATING_REPOSITORY_LEN   9
#define   CDREPOSORG_LEN                        9
#endif
#ifndef _DZSR002XKEYS_z
#define _DZSR002XKEYS_z

typedef struct __Dzsr002xKeys
{
   long                  CdReturn;
   short                 QyALRAclCnt;
   unsigned long         IdSir;
   char                  CdObjectType[9];
   char                  TxObjectDesc[33];
   char                  WordReturn[2];
   char                  DdioFunctionCode[3];
   char                  CdReposOrg[9];
}  _DZSR002XKEYS;
#endif
/***************************************************************************
* Definition for Record Group.DZSR002D
***************************************************************************/
#ifndef   DEV00235_LEN
#define   DEV00235_LEN                          9
#define   CDOBJECTTYPE_LEN                      9
#endif
#ifndef   DEV00231_LEN
#define   DEV00231_LEN                          33
#define   TXOBJECTDESC_LEN                      33
#endif
#ifndef _DZSR002XLBDATA_z
#define _DZSR002XLBDATA_z

typedef struct __Dzsr002xLbData
{
   char                  CdObjectType[9];
   char                  TxObjectDesc[33];
}  _DZSR002XLBDATA;
#endif
/***************************************************************************
* Definition for Record Group.DZSR002R
***************************************************************************/
#ifndef   _RQST__DZSR002XLBDATA_SIZE
#define   _RQST__DZSR002XLBDATA_SIZE            50
#endif
#ifndef _RQST_z
#define _RQST_z

typedef struct __Rqst
{
   _DZSR002XKEYS         Dzsr002xKeys;
   _DZSR002XLBDATA       Dzsr002xLbData[50];
}  _RQST;
#endif
/***************************************************************************
* Definition for Record.DZSR002C
***************************************************************************/
#ifndef _WCDDZSR002X_z
#define _WCDDZSR002X_z

typedef struct __WCDDzsr002x
{
   _ARCHDATA             ArchData;
   _RQST                 Rqst;
}  _WCDDZSR002X;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WCD_Rqst              pWindContextData->Rqst
#define  WINCONTEXTNAME        _WCDDZSR002X

