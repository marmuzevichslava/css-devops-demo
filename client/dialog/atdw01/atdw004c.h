/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: ATDW004C                            *
*                        Generated on: Tue Jul 30 00:57:00 1996            *
*                                  by: CWOODS                              *
*                   Short Description: AZCD004C                            *
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
* Definition for Record.ATDW004C
***************************************************************************/
#ifndef _WCDATDW004C_z
#define _WCDATDW004C_z

typedef struct __WCDAtdw004c
{
   _ARCHDATA             ArchData;
}  _WCDATDW004C;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WINCONTEXTNAME        _WCDATDW004C

