/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: ATDW006C                            *
*                        Generated on: Tue Jul 30 00:57:00 1996            *
*                                  by: CWOODS                              *
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
* Definition for Record.ATDW006C
***************************************************************************/
#ifndef _WCDATDW006C_z
#define _WCDATDW006C_z

typedef struct __WCDAtdw006c
{
   _ARCHDATA             ArchData;
}  _WCDATDW006C;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WINCONTEXTNAME        _WCDATDW006C

