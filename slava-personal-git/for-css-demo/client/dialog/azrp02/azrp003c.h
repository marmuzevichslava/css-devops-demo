/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: AZRP003C                            *
*                        Generated on: Fri Jul 12 15:55:18 1996            *
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
* Definition for Record.AZRP003C
***************************************************************************/
#ifndef _WCDAZRP003C_z
#define _WCDAZRP003C_z

typedef struct __WCDAZRP003C
{
   _ARCHDATA             ArchData;
}  _WCDAZRP003C;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WINCONTEXTNAME        _WCDAZRP003C

