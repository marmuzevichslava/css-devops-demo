/***************************************************************************/
/*                       COMMON MODULE INCLUDE FILE                        */
/*                                                                         */
/* Subsystem      : Technical Architecture                                 */
/* Component      : Common Database constants                              */
/*                                                                         */
/* File Name      : TADB001.H                                              */
/*                                                                         */
/* Author         : Andersen Consulting                                    */
/* Date Written   : 30/05/94                                               */
/*                                                                         */
/* Description    : This include file contains constants pertaining to the */
/*                    database.                                            */
/*                                                                         */
/* Revision History:                                                       */
/*                                                                         */
/* Date     Revised By     Description                                     */
/* ----     ----------     ------------                                    */
/* 07/21/1994    OT      Removed redundant constants                       */
/* 10/08/1994    DG      Added CTA_DB_NULL_VALUE                           */
/* 11/08/1994    DG      Added parameter sFuncRetCde to TaDbClose          */
/*                                                                         */
/***************************************************************************/
/***************************************************************************/
/* #INCLUDEs                                                               */
/***************************************************************************/
/***************************************************************************/
/* EXTERN Variables                                                        */
/***************************************************************************/
/***************************************************************************/
/* Constants (#DEFINE)                                                     */
/***************************************************************************/

#define CTA_DB_NO_ERROR             0
#define CTA_DB_REC_NOT_FOUND        1403
#define CTA_DB_END_OF_CURSOR        1403
#define CTA_DB_DUPLICATE_KEY        -1
#define CTA_DB_TBL_NOT_FOUND        -942
#define CTA_DB_PARENT_NOT_FOUND     -2291
#define CTA_DB_CHILD_FOUND          -2292

#define CTA_DB_WARNING                'W'
#define CTA_DB_WARNING_OK         ' '

#define CTA_DB_NULL_VALUE      -1405

#define DBASE_SERVER "@instance01"

/***************************************************************************/
/* Macros    (#DEFINE)                                                     */
/***************************************************************************/

#define VTA_SQL_CODE     sqlca.sqlcode
#define VTA_SQL_ERR_PARM sqlca.sqlerrm

/***************************************************************************/
/* Type definitions                                                        */
/***************************************************************************/
typedef struct sqlca TTA_DB_ERR_BLOCK, * TTA_P_DB_ERR_BLOCK;

#define SHORT short
#define USHORT unsigned short

/***************************************************************************/
/* Global variables for this file                                          */
/***************************************************************************/
/***************************************************************************/
/* Internal Functions                                                      */
/***************************************************************************/
/***************************************************************************/
/* External Functions                                                      */
/***************************************************************************/
SHORT TaDbOpen(char * szDbName,
               char * pUserName,
               char * pPassWord);
SHORT TaDbRollback(void);
SHORT TaDbCommit(void);
SHORT TaDbClose();

