/***************************************************************************/
/*                       COMMON MODULE SOURCE FILE                         */
/*                                                                         */
/* Subsystem       : Technical Architecture                                */
/* Component       : Database - Informix version                           */
/*                                                                         */
/* File Name       : TADB001u.EC                                           */
/*                                                                         */
/* Author          : Andersen Consulting                                   */
/*                                                                         */
/* Date Written    : 07/07/94                                              */
/*                                                                         */
/* Description     : This module contains database handling functions      */
/*                                                                         */
/* Revision History:                                                       */
/*                                                                         */
/* Date        Revised By   Description                                    */
/* ----        ----------   -----------                                    */
/* 04/20/1995   OT          Ported to HP_UX - Informix                     */
/***************************************************************************/
/***************************************************************************/
/* #INCLUDEs                                                               */
/***************************************************************************/
#define   FND_DBMGR_INCL
#define   DTA_INCL_DB
#define   DTA_INCL_OS

#include  "tadf001.h"
#include  "tadb001.h"
#include  "taem001.h"
#include  <ctype.h>


EXEC SQL INCLUDE sqlca;

/*************************************************************************** 
 * Foundation Global Header File                                           *
 ***************************************************************************/
#include <kglhk000.h>

/***************************************************************************/
/* EXTERN Variables                                                        */
/***************************************************************************/
/***************************************************************************/
/* Constants (#DEFINE)                                                     */
/***************************************************************************/
/***************************************************************************/
/* Macros    (#DEFINE)                                                     */
/***************************************************************************/
/***************************************************************************/
/* Type definitions                                                        */
/***************************************************************************/
/***************************************************************************/
/* Global variables for this file                                          */
/***************************************************************************/
/***************************************************************************/
/* Internal Functions                                                      */
/***************************************************************************/
/***************************************************************************/
/* External Functions                                                      */
/***************************************************************************/

/***************************************************************************/
/* Function:    TaDbOpen                                                   */
/*                                                                         */
/* Description: Opens a connection to the database                         */
/*                                                                         */
/* Returns:     RTA_SUCCESS or ETA_DB_OPEN_ERR                             */
/***************************************************************************/
SHORT TaDbOpen(char * szDbName,
               char * pUserName,
               char * pPassWord)
{
   SHORT      sRetCode = FND_SUCCESS;

   EXEC SQL BEGIN DECLARE SECTION;
      char szDataBase[20];
   EXEC SQL END   DECLARE SECTION;

   memset(szDataBase, 0, sizeof(szDataBase) );
   strncpy(szDataBase, szDbName, sizeof(szDataBase) );

   strcat(szDataBase, DBASE_SERVER );

   printf("\nConnecting %s.\n", szDataBase);

   $database :szDataBase; 

   printf("\nConnection %d.\n", SQLCODE);

   if (SQLCODE == 0)
   {
      sRetCode = FND_SUCCESS;
      EXEC SQL SET ISOLATION TO DIRTY READ;
   }
   else
      sRetCode = ETA_DB_OPEN_ERR;

   return sRetCode;
}

/***************************************************************************/
/* Function:    TA_DbRollback                                              */
/*                                                                         */
/* Description: Rolls back the database                                    */
/*                                                                         */
/*	Returns:     RTA_SUCCESS or ETA_DB_ROLLBACK_ERR                         */
/***************************************************************************/
SHORT TaDbRollback(void)
{
   SHORT sRetCde;

   EXEC SQL ROLLBACK WORK;

   switch (VTA_SQL_CODE)
   {
   case CTA_DB_NO_ERROR:
      sRetCde = RTA_SUCCESS;
      break;
   default:
      sRetCde = ETA_DB_ROLLBACK_ERR;
   }

   return sRetCde;
}

/***************************************************************************/
/* Function:    TaDbCommit                                                 */
/*                                                                         */
/* Description: Commits Changes to the database. Do not log off            */
/*                                                                         */
/* Returns:     RTA_SUCCESS or ETA_DB_COMMIT_ERR                           */
/***************************************************************************/
SHORT TaDbCommit(void)
{
   SHORT sRetCde;

   EXEC SQL COMMIT WORK;

   switch (VTA_SQL_CODE)
   {
   case CTA_DB_NO_ERROR:
      sRetCde = RTA_SUCCESS;
      break;

   default:
      sRetCde = ETA_DB_COMMIT_ERR;
   }

   TaDbClose();

   return sRetCde;
}


/***************************************************************************/
/* Function:    TaDbClose                                                  */
/*                                                                         */
/* Description: Commits changes and logs off from the database             */
/*                                                                         */
/* Returns:     RTA_SUCCESS or ETA_DB_CLOSE_ERR                            */
/***************************************************************************/
SHORT TaDbClose()
{
   SHORT       sRetCde = FND_SUCCESS;

   EXEC SQL CLOSE DATABASE;

   return sRetCde;
}

