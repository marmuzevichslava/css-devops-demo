/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZIO013O                            *
*                        Generated on: Mon Dec 02 19:27:38 1996            *
*                                  by: IPEREZAR                            *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record.DZIO013O
***************************************************************************/
#ifndef   DZ00701_PRIM_TABLE_LEN
#define   DZ00701_PRIM_TABLE_LEN                9
#define   PRIMTAB_LEN                           9
#endif
#ifndef   DZ00702_ALR_COPYBOOK_LEN
#define   DZ00702_ALR_COPYBOOK_LEN              9
#define   ALRCBOOK_LEN                          9
#endif
#ifndef _DZIO013O_z
#define _DZIO013O_z

typedef struct __Dzio013o
{
   char                  PrimTab[9];
   char                  Alrcbook[9];
}  _DZIO013O;
#endif


