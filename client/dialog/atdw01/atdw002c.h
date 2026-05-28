/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: ATDW002C                            *
*                        Generated on: Tue Jul 30 00:57:00 1996            *
*                                  by: CWOODS                              *
*                   Short Description: AZCD002C                            *
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
* Definition for Record.ATDW002C
***************************************************************************/
#ifndef _WCDATDW002C_z
#define _WCDATDW002C_z

typedef struct __WCDAtdw002c
{
   _ARCHDATA             ArchData;
}  _WCDATDW002C;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WINCONTEXTNAME        _WCDATDW002C

