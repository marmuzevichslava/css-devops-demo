/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: AZRP003O                            *
*                        Generated on: Fri Jul 12 15:55:18 1996            *
*                                  by: MCONNER                             *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record.AZRP003O
***************************************************************************/
#ifndef   AZRP0015_LEN
#define   AZRP0015_LEN                          2
#define   PRINTDEST_LEN                         2
#endif
#ifndef   AZRP0016_LEN
#define   AZRP0016_LEN                          256
#define   BATCHLISTFILE_LEN                     256
#endif
#ifndef   AZRP0017_LEN
#define   AZRP0017_LEN                          256
#define   PRINTFILE_LEN                         256
#endif
#ifndef   AZRP0022_LEN
#define   AZRP0022_LEN                          2
#define   DUPLEX_LEN                            2
#endif
#ifndef _AZRP003OUTPUT_z
#define _AZRP003OUTPUT_z

typedef struct __AZRP003Output
{
   char                  PrintDest[2];
   char                  BatchListFile[256];
   char                  PrintFile[256];
   char                  Duplex[2];
}  _AZRP003OUTPUT;
#endif


