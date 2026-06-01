/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*                Copyright (C) 1996, Andersen Consulting.                  *
*                          All rights reserved.                            *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZSF001C TAB WCD                    *
*                        Generated on: Wed Feb 04 14:22:17 1998            *
*                                  by: MCONNER                             *
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
* Definition for Record.DZSF001C
***************************************************************************/
#ifndef _WCDDZSF001C_z
#define _WCDDZSF001C_z

typedef struct __WCDDzsf001c
{
   _ARCHDATA             ArchData;
}  _WCDDZSF001C;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WINCONTEXTNAME        _WCDDZSF001C

