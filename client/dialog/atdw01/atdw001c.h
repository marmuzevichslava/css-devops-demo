/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: ATDW001C                            *
*                        Generated on: Tue Jul 30 00:57:00 1996            *
*                                  by: CWOODS                              *
*                   Short Description: AZCD001C                            *
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
* Definition for Record.ATDW001C
***************************************************************************/
#ifndef _WCDATDW001C_z
#define _WCDATDW001C_z

typedef struct __WCDAtdw001c
{
   _ARCHDATA             ArchData;
}  _WCDATDW001C;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WINCONTEXTNAME        _WCDATDW001C

