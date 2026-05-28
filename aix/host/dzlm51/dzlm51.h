/***************************************************************************/
/*                                                                         */
/* File Name       : dzlm51.h                                              */
/*                                                                         */
/* Author          : Andersen Consulting                                   */
/* Date Written    : 10/25/96                                              */
/*                                                                         */
/* Description     : This file contains Lock Manager constants for Repos   */ 
/*                   Mngt tools                                            */
/* Revision History:                                                       */
/*                                                                         */
/* Date  Revised By     Description                                        */
/* ----  ----------     ------------                                       */
/*                                                                         */ 
/***************************************************************************/

/* Make object counters visible above its declaration */
extern unsigned long counter_lu;
extern unsigned long counter_already_lu;
extern unsigned long counter_unable_to_lu;

/* Global repository object counters */

unsigned long counter_lu            = 0;
unsigned long counter_already_lu    = 0;
unsigned long counter_unable_to_lu  = 0;

/* Constants for Locking Manager and Validation Manager */
#define CID_RA_ACTION_LOCK          1
#define CID_RA_ACTION_UNLOCK        0
#define CID_RA_LOCK_BY_DOUBLEQUOTE  "NAZIRA__"
#define CID_RA_LOCK_BY_BLANK        "        "
#define CID_RA_LOCK_TYPE_P          "P"
#define CID_RA_LOCK_TYPE_BLANK      " "

#define CID_RA_OBJTYPE_DATA_ELEM       1
#define CID_RA_OBJTYPE_CLIENT          2
#define CID_RA_OBJTYPE_SERVER          3
#define CID_RA_OBJTYPE_ENTITY_TYPE     4
#define CID_RA_OBJTYPE_ATTR_TYPE       5

#define CID_RA_OK                      0
#define CID_RA_OBJECT_NOT_FOUND        1
#define CID_RA_ALREADY_LOCKED          2
#define CID_RA_LOCKED_BY_OTHER_USER    3
#define CID_RA_ALREADY_UNLOCKED        4
#define CID_RA_OBJECT_TYPE_NOT_FOUND   5
#define CID_RA_OUTPUT_FILE_EXIST       6
#define CID_RA_SQL_ERROR               10
#define CID_RA_LCKMGR_LOGFILE          "ralck.log"
#define CID_RA_VALMGR_LOGFILE          "raval.log"
#define CID_RA_REP_DIR                 "VALREP"

#define CID_TEXT_EDITOR                "EPM.EXE"

#ifdef FND_HPUX
    #define CID_RA_SERVER_PATHSEP '/'
    #define CID_RA_CLIENT_PATHSEP '\\'
#else
    #define CID_RA_SERVER_PATHSEP '\\'
    #define CID_RA_CLIENT_PATHSEP '\\'
#endif

#define CID_RA_DRIVESEP ':'
#define CID_RA_EXTPATH_ENVVAR "EXTPATH"

#define SQLNOTFOUND 100
