/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZIO005I                            *
*                        Generated on: Mon Dec 02 19:27:38 1996            *
*                                  by: IPEREZAR                            *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record Group.DZIO005K
***************************************************************************/
#ifndef   DZ00700_IO_MOD_NAME_LEN
#define   DZ00700_IO_MOD_NAME_LEN               9
#define   IOMODNM_LEN                           9
#endif
#ifndef   DZ00738_LEN
#define   DZ00738_LEN                           9
#define   FUNCTYP_LEN                           9
#endif
#ifndef _DZIO005KEYS_z
#define _DZIO005KEYS_z

typedef struct __DZIO005Keys
{
   char                  Iomodnm[9];
   char                  FuncTyp[9];
}  _DZIO005KEYS;
#endif
/***************************************************************************
* Definition for Record.DZIO005I
***************************************************************************/
#ifndef _DZIO005I_z
#define _DZIO005I_z

typedef struct __DZIO005I
{
   _DZIO005KEYS          DZIO005Keys;
}  _DZIO005I;
#endif


