/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: AZCS003O                            *
*                        Generated on: Mon Jul 15 06:51:10 1996            *
*                                  by: MCONNER                             *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record.AZCS003O
***************************************************************************/
#ifndef   ARC00305_LEN
#define   ARC00305_LEN                          10
#define   TRANMAP_LEN                           10
#endif
#ifndef   ARC00307_LEN
#define   ARC00307_LEN                          11
#define   ANTICMODULE_LEN                       11
#endif
#ifndef   ARC00329_LEN
#define   ARC00329_LEN                          2
#define   FLUSH_LEN                             2
#endif
#ifndef   ARC00330_LEN
#define   ARC00330_LEN                          10
#define   ALTMAP_LEN                            10
#endif
#ifndef   ARC00335_LEN
#define   ARC00335_LEN                          3
#define   SERVICEMAPTYPE_LEN                    3
#endif
#ifndef   ARC00452_LEN
#define   ARC00452_LEN                          2
#define   FORCECALL_LEN                         2
#endif
#ifndef _AZCS003O_z
#define _AZCS003O_z

typedef struct __Azcs003O
{
   unsigned long         Server;
   unsigned short        ServiceID;
   char                  TranMap[10];
   unsigned long         ServiceAge;
   char                  AnticModule[11];
   char                  Flush[2];
   char                  AltMap[10];
   char                  ServiceMapType[3];
   char                  ForceCall[2];
}  _AZCS003O;
#endif


