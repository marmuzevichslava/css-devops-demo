/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZIO005C                            *
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
* Definition for Record Group.DZIO005K
***************************************************************************/
#ifndef   DZ00700_IO_MOD_NAME_LEN
#define   DZ00700_IO_MOD_NAME_LEN               9
#define   IOMODNM_LEN                           9
#endif
#ifndef   DZ00738_LEN
#define   DZ00738_LEN                           9
#define   FUNCTYP_LEN                           9
#endif
#ifndef _DZIO005KEYS_z
#define _DZIO005KEYS_z

typedef struct __DZIO005Keys
{
   char                  Iomodnm[9];
   char                  FuncTyp[9];
}  _DZIO005KEYS;
#endif
/***************************************************************************
* Definition for Record Group.DZIO005R
***************************************************************************/
#ifndef _DZIO005RQST_z
#define _DZIO005RQST_z

typedef struct __DZIO005Rqst
{
   unsigned short        CdMsgioStatus;
   unsigned short        CdServErrMsg;
   long                  CdReturn;
   _DZIO005KEYS          DZIO005Keys;
}  _DZIO005RQST;
#endif
/***************************************************************************
* Definition for Record.DZIO005C
***************************************************************************/
#ifndef _WCDDZIO005C_z
#define _WCDDZIO005C_z

typedef struct __WCDDzio005c
{
   _ARCHDATA             ArchData;
   _DZIO005RQST          DZIO005Rqst;
}  _WCDDZIO005C;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WCD_DZIO005Rqst       pWindContextData->DZIO005Rqst
#define  WINCONTEXTNAME        _WCDDZIO005C

