/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZCLM01                             *
*                        Generated on: Tue Oct 22 17:24:02 1996            *
*                                  by: IPEREZAR                            *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record Group.DZLM001K
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
#ifndef   DEV00857_LOCK_PROCESS_TYPE_LEN
#define   DEV00857_LOCK_PROCESS_TYPE_LEN        2
#define   LOCKPROCESSTYPE_LEN                   2
#endif
#ifndef _DZLM001KEYS_z
#define _DZLM001KEYS_z

typedef struct __DZLM001Keys
{
   char                  TxLockObjectType[33];
   char                  LockObjectName[33];
   char                  TxLockRepository[21];
   char                  LockRefCheck[3];
   char                  LockProcessType[2];
}  _DZLM001KEYS;
#endif
/***************************************************************************
* Definition for Record Group.DZLM001D
***************************************************************************/
#ifndef   DEV00857_LOCK_PROCESS_TYPE_LEN
#define   DEV00857_LOCK_PROCESS_TYPE_LEN        2
#define   LOCKPROCESSTYPE_LEN                   2
#endif
#ifndef _DZLM001DATA_z
#define _DZLM001DATA_z

typedef struct __DZLM001Data
{
   short                 ObjsLocked;
   short                 ObjsPrevLocked;
   short                 ObjsProcessed;
   char                  LockProcessType[2];
}  _DZLM001DATA;
#endif
/***************************************************************************
* Definition for Record Group.DZLM001M
***************************************************************************/
#ifndef _DZLM001MESSAGE_z
#define _DZLM001MESSAGE_z

typedef struct __DZLM001Message
{
   _DZLM001KEYS          DZLM001Keys;
   _DZLM001DATA          DZLM001Data;
}  _DZLM001MESSAGE;
#endif
/***************************************************************************
* Definition for Record.DZLM001I
***************************************************************************/
#ifndef _DZLM001INPUT_z
#define _DZLM001INPUT_z

typedef struct __DZLM001Input
{
   _DZLM001MESSAGE       DZLM001Message;
}  _DZLM001INPUT;
#endif


