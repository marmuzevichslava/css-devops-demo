/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: AZCS002O                            *
*                        Generated on: Mon Jul 15 06:51:10 1996            *
*                                  by: MCONNER                             *
*                   Short Description: AZCS001C                            *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record.AZCS002O
***************************************************************************/
#ifndef   ARC00301_LEN
#define   ARC00301_LEN                          10
#define   REQUESTID_LEN                         10
#endif
#ifndef   ARC00302_LEN
#define   ARC00302_LEN                          12
#define   REQUESTTYPE_LEN                       12
#endif
#ifndef   ARC00303_LEN
#define   ARC00303_LEN                          33
#define   CLIENTLAYOUT_LEN                      33
#endif
#ifndef _REQUESTINFO_z
#define _REQUESTINFO_z

typedef struct __RequestInfo
{
   char                  RequestID[10];
   char                  RequestType[12];
   char                  ClientLayout[33];
}  _REQUESTINFO;
#endif


