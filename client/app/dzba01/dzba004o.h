/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZBA004O                            *
*                        Generated on: Thu Jan 30 09:46:52 1997            *
*                                  by: IPEREZAR                            *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record Group.DZBA004I
***************************************************************************/
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
#ifndef _DZBA004INPUT_z
#define _DZBA004INPUT_z

typedef struct __DZBA004Input
{
   char                  ExportFile[9];
   char                  ImportFile[9];
   char                  WorkingDirectory[9];
}  _DZBA004INPUT;
#endif
/***************************************************************************
* Definition for Record.DZBA004O
***************************************************************************/
#ifndef _DZBA004OUTPUTREC_z
#define _DZBA004OUTPUTREC_z

typedef struct __DZBA004OutputRec
{
   _DZBA004INPUT         DZBA004Input;
}  _DZBA004OUTPUTREC;
#endif


