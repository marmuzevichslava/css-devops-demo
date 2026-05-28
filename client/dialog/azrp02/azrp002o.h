/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: AZRP002O                            *
*                        Generated on: Fri Jul 12 15:55:18 1996            *
*                                  by: MCONNER                             *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record.AZRP002O
***************************************************************************/
#ifndef   AZRP0015_LEN
#define   AZRP0015_LEN                          2
#define   PRINTDEST_LEN                         2
#endif
#ifndef   AZRP0017_LEN
#define   AZRP0017_LEN                          256
#define   PRINTFILE_LEN                         256
#endif
#ifndef   AZRP0022_LEN
#define   AZRP0022_LEN                          2
#define   DUPLEX_LEN                            2
#endif
#ifndef _AZRP002OUTPUT_z
#define _AZRP002OUTPUT_z

typedef struct __AZRP002Output
{
   char                  PrintDest[2];
   char                  PrintFile[256];
   char                  Duplex[2];
}  _AZRP002OUTPUT;
#endif


