/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: ATDW003C                            *
*                        Generated on: Tue Jul 30 00:57:00 1996            *
*                                  by: CWOODS                              *
*                   Short Description: AZCD003C                            *
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
* Definition for Record.ATDW003C
***************************************************************************/
#ifndef _WCDATDW003C_z
#define _WCDATDW003C_z

typedef struct __WCDAtdw003c
{
   _ARCHDATA             ArchData;
}  _WCDATDW003C;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WINCONTEXTNAME        _WCDATDW003C

