/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*                Copyright (C) 1996, Andersen Consulting.                  *
*                          All rights reserved.                            *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZSF002C                            *
*                        Generated on: Thu Feb 26 12:58:01 1998            *
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
* Definition for Record Group.DZSF002R
***************************************************************************/
#ifndef   DZSF002_CSR_DMP_FILE_LEN
#define   DZSF002_CSR_DMP_FILE_LEN              256
#define   CSRDMPFILE_LEN                        256
#endif
#ifndef   DZSF002_DATA_FILE_LEN
#define   DZSF002_DATA_FILE_LEN                 256
#define   DATAFILE_LEN                          256
#endif
#ifndef   DZSF002_DUPLICATE_CHECK_LEN
#define   DZSF002_DUPLICATE_CHECK_LEN           2
#define   DUPCHK_LEN                            2
#endif
#ifndef   ARC00271_FL_WINDOW_MOD_LEN
#define   ARC00271_FL_WINDOW_MOD_LEN            2
#define   FLWINDOWMOD_LEN                       2
#endif
#ifndef _DZSF002R_z
#define _DZSF002R_z

typedef struct __Dzsf002r
{
   char                  CsrDmpFile[256];
   char                  DataFile[256];
   char                  DupChk[2];
   unsigned long         FinishNum;
   unsigned long         StartNum;
   char                  FlWindowMod[2];
}  _DZSF002R;
#endif
/***************************************************************************
* Definition for Record.DZSF002C
***************************************************************************/
#ifndef _WCDDZSF002C_z
#define _WCDDZSF002C_z

typedef struct __WCDDzsf002c
{
   _ARCHDATA             ArchData;
   _DZSF002R             Dzsf002r;
}  _WCDDZSF002C;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WCD_Dzsf002r          pWindContextData->Dzsf002r
#define  WINCONTEXTNAME        _WCDDZSF002C

