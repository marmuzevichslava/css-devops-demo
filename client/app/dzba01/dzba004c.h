/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZBA004C                            *
*                        Generated on: Thu Jan 30 09:46:52 1997            *
*                                  by: IPEREZAR                            *
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
* Definition for Record Group.DZBA004C
***************************************************************************/
#ifndef   DEV00858_SERVER_FILE_PATH_LEN
#define   DEV00858_SERVER_FILE_PATH_LEN         51
#define   SERVERFILEPATH_LEN                    51
#endif
#ifndef   DEV00859_CLIENT_FILE_PATH_LEN
#define   DEV00859_CLIENT_FILE_PATH_LEN         51
#define   CLIENTFILEPATH_LEN                    51
#endif
#ifndef   DEV00860_EXPORT_FILE_LEN
#define   DEV00860_EXPORT_FILE_LEN              9
#define   EXPORTFILE_LEN                        9
#endif
#ifndef   DEV00861_IMPORT_FILE_LEN
#define   DEV00861_IMPORT_FILE_LEN              9
#define   IMPORTFILE_LEN                        9
#endif
#ifndef   DEV00862_WORKING_DIRECTORY_LEN
#define   DEV00862_WORKING_DIRECTORY_LEN        9
#define   WORKINGDIRECTORY_LEN                  9
#endif
#ifndef _DZBA004C_z
#define _DZBA004C_z

typedef struct __Dzba004c
{
   char                  ServerFilePath[51];
   char                  ClientFilePath[51];
   char                  ExportFile[9];
   char                  ImportFile[9];
   char                  WorkingDirectory[9];
}  _DZBA004C;
#endif
/***************************************************************************
* Definition for Record.DZBA004C
***************************************************************************/
#ifndef _WCDDZBA004CWCD_z
#define _WCDDZBA004CWCD_z

typedef struct __WCDDZBA004CWCD
{
   _ARCHDATA             ArchData;
   _DZBA004C             Dzba004c;
}  _WCDDZBA004CWCD;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WCD_Dzba004c          pWindContextData->Dzba004c
#define  WINCONTEXTNAME        _WCDDZBA004CWCD

