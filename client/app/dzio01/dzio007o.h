/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZIO007O                            *
*                        Generated on: Tue Oct 01 09:25:43 1996            *
*                                  by: IPEREZAR                            *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record Group.DZR01H00
***************************************************************************/
#ifndef   DZ00770_DESCENDING_KEY_LEN
#define   DZ00770_DESCENDING_KEY_LEN            9
#define   DESCKEY_LEN                           9
#endif
#ifndef   DZ00775_ORDER_FLAG_LEN
#define   DZ00775_ORDER_FLAG_LEN                2
#define   ORDFLG_LEN                            2
#endif
#ifndef _ORDER_BY_z
#define _ORDER_BY_z

typedef struct __Order_By
{
   char                  DescKey[9];
   char                  OrdFlg[2];
   float                 OrdPos;
}  _ORDER_BY;
#endif
/***************************************************************************
* Definition for Record.DZIO007O
***************************************************************************/
#ifndef   _DZIO007O__ORDER_BY_SIZE
#define   _DZIO007O__ORDER_BY_SIZE              5
#endif
#ifndef _DZIO007O_z
#define _DZIO007O_z

typedef struct __DZIO007O
{
   _ORDER_BY             Order_By[5];
}  _DZIO007O;
#endif


