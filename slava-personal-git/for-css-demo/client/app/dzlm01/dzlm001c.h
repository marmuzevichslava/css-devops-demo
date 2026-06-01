/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZLM001C                            *
*                        Generated on: Tue Oct 29 09:37:55 1996            *
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
* Definition for Record Group.DZLM001C
***************************************************************************/
#ifndef   DEV00850_LOCK_OBJECT_TYPE_LEN
#define   DEV00850_LOCK_OBJECT_TYPE_LEN         33
#define   TXLOCKOBJECTTYPE_LEN                  33
#endif
#ifndef   DEV00851_LOCK_OBJECT_NAME_LEN
#define   DEV00851_LOCK_OBJECT_NAME_LEN         33
#define   LOCKOBJECTNAME_LEN                    33
#endif
#ifndef   DEV00852_LOCK_REPOSITORY_LEN
#define   DEV00852_LOCK_REPOSITORY_LEN          21
#define   TXLOCKREPOSITORY_LEN                  21
#endif
#ifndef   DEV00853_LOCK_REF_CHECK_LEN
#define   DEV00853_LOCK_REF_CHECK_LEN           3
#define   LOCKREFCHECK_LEN                      3
#endif
#ifndef _DZLM001CREC_z
#define _DZLM001CREC_z

typedef struct __DZLM001CRec
{
   char                  TxLockObjectType[33];
   char                  LockObjectName[33];
   char                  TxLockRepository[21];
   char                  LockRefCheck[3];
}  _DZLM001CREC;
#endif
/***************************************************************************
* Definition for Record.DZLM001C
***************************************************************************/
#ifndef _WCDDZLM001C_z
#define _WCDDZLM001C_z

typedef struct __WCDDZLM001C
{
   _ARCHDATA             ArchData;
   _DZLM001CREC          DZLM001CRec;
}  _WCDDZLM001C;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WCD_DZLM001CRec       pWindContextData->DZLM001CRec
#define  WINCONTEXTNAME        _WCDDZLM001C

