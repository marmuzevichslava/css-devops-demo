/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/****************************************************************
**
**					CUSTOMER SERVICE SYSTEM
**                     CSR MAP GENERATOR
**
**   FILENAME       :  MAPGEN.H
**
**   DESCRIPTION    :  This file contains all the CSR Map Generator
**                     structures, constnts, macros, and functions.
**
**	 AUTHOR 		:  Andersen Consulting & Florida Power Corp.
**
**   REVISION HISTORY
**
**	 DATE	   REVISED BY	 SIR #		DESCRIPTION OF CHANGE
**   ------    ----------    -----      ---------------------
**             CCRAMPTO                 Original File.
**
**   11/17/94  JLOONEY                  Changed MAX_SD from 20 to
**					50.
**   01/10/96  CWOODS			Added _RM_COMMAND_LEN
**
** 10/25/96 mconner added field to _BFCD_GLOBAL_DATA
**
** 11/13/96 mconner moved prototypes from c1cbase to here
**
*****************************************************************/

/****************************************************************
**
**		       INLUDES FILES
**
*****************************************************************/
#include "explode.h"     /* JLL: 07/01/93 ADDED */

/****************************************************************
**
**                    LENGTH CONSTANTS
**
*****************************************************************/

/* CSC: 06/04/93 ADDED LEN CONSTANTS */
#define ITEM_NAME_LEN          32
#define WILDCARD_LEN           21
#define SERVICE_NAME_LEN       12
#define CONTROL_NAME_LEN       34  /*mdc 01-11-96 added */
#define _PATH_LEN              70         /* JLL: 06/09/93 ADDED */       
#define _USAGE_LEN              3         /* JLL: 06/11/93 ADDED */
#define _FLUSH_LEN              6         /* JLL: 06/17/93 ADDED */
#define _COPY_COMMAND_LEN     251         /* JLL: 06/17/93 ADDED */
#define _RM_COMMAND_LEN	      251	  /* CWOODS: 01/19/96 ADDED */
#define _ALT_SERV_LEN	       10	  /* JLL: 07/01/93 ADDED */
#define _MAPGN_MAX_MAP_LINE_LEN 450       /* JLL: 09/21/94 ADDED */
/*mdc 10/30/96 Added for mass gen feature*/
#ifndef _DUMMY_LEN
#define _DUMMY_LEN             30
#endif
#ifndef AZCS01_TEMP_CONFIG_PATH_LEN  
#define AZCS01_TEMP_CONFIG_PATH_LEN		70		   /* JHR: 12/02/98 */
#endif
#define	_CONFIG_PATH_LEN				 3 		   /* JHR: 12/02/98 */

/****************************************************************
**
**                    DEFINE STATEMENTS
**
*****************************************************************/
#define MAX_SERVICES           10
#define MAX_SD                 50
#define MAXCLIENTROWS          500
#define MAXSERVICEROWS         500
#define MAPGEN_CLIENT_LB_NAME  "Rlb01ELB"
#define MAPGEN_SERVICE_LB_NAME "Rlb02ELB"
#define CSR_MAP_SAVE_FILE_EXT  "CSM"
#define CSR_MAP_GEN_FILE_EXT   "MAP"
#define CSR_MAP_LOG_EXT        "LOG"
#define CSR_MAP_ERR_EXT        "ERR"
#define MAP_VERSION            1.0f
#define BLANK_LINE             "\n"
#define MAP_TMP_FILE           "MAP.TMP"
#define CSR_MAP_CFG_FILE       "\\data\\csrmap.cfg"
#define MAX_ROWS_RETURNED      416
#define MAP_GEN_CLIENT_LAYOUT  'C'
#define MAP_GEN_SERVICE_LAYOUT 'S'
#define MAP_GEN_MAX_LEVELS     20
#define TL_CK_ROW_NUM           0
#define TL_LK_ROW_NUM           1
#define TL_RD_ROW_NUM           2
#define TL_RM_ROW_NUM           3
#define TL_LD_ROW_NUM           4
#define TL_SD_ROW_NUM           5
#define DEFAULT_SERVER_NUM      1111
#define DEFAULT_SERVICE_AGE_LIMIT 10

/****************************************************************
**
**                MAP SAVE FILE WRITE FORMATS
**
*****************************************************************/

#define CSR_MAP_REQ_HEADER_WRITE_STR "%-14.14s %-14.14s %-32.32s %-21.21s\
 %-9.9s %-16.16s %-11.11s %-22.22s %-10.1d %-18.18s %-10.1d %-16.16s\
 %-10.1d %-20.20s %-15.0lf\n"

/* JLL: 07/02/93 ADDED */
#define CSR_MAP_TL_STATUS_WRITE_STR "%s %s %c %s %c %s %c %s %c %s %c\n"

#define CSR_MAP_SD_WRITE_STR "%-14.14s %-14.14s %-32.32s\n"

#define CSR_MAP_LAYOUT_WRITE_STR "%-14.14s %-11.11s %-32.32s %-13.13s %c\
 %-14.14s %-32.32s %-18.18s %-32.32s %-11.11s %c %-15.15s %-10.1d %-14.14s\
 %-10.1d %-10.10s %-3.3s %-15.15s %-10.1d %-13.13s %-3.1d %-14.14s %-5.1d\
 %-15.15s %-10.1d %-16.16s %-3.1d %-15.15s %-5.1d %-17.17s %-5.1d %-16.16s\
 %-5.1d\n"

#define CSR_MAP_SERVICE_HDR_WRITE_STR  "%-14.14s %-22.22s %-32.32s %-11.11s\
 %-10.1lu %-14.14s %-10.1d %-20.20s %-10.1lu %-28.28s %-32.32s %-14.14s %-6.6s\
 %-16.16s %-2.2s %-21.21s %-10.10s %-19.19s %-10.1d %-12.12s %-15.0f %-14.14s %-3.3s\n"

#define CSR_MAP_RELATE_RPMH_WRITE_STR  "%-14.14s %-22.22s %-5.1d %-20.20s\
 %c\n"

#define CSR_MAP_RELATE_CK_WRITE_STR  "%-14.14s %-22.22s %-5.1d %-16.16s %c\
 %-17.17s %61.61s %-17.17s %c %-18.18s %-21.21s %-14.14s %-3.3s\n"

#define CSR_MAP_RELATE_RD_WRITE_STR  "%-14.14s %-22.22s %-5.1d\n"

#define CSR_MAP_RELATE_LK_WRITE_STR  "%-14.14s %-22.22s %-5.1d %-16.16s %c\
 %-17.17s %-61.61s\n"

#define CSR_MAP_RELATE_LD_WRITE_STR  "%-14.14s %-22.22s %-5.1d %-16.16s %c\
 %-17.17s %-61.61s\n"

/****************************************************************
**
**                MAP SAVE FILE READ FORMATS
**
*****************************************************************/

#define CSR_MAP_REQ_HEADER_FORMAT_STR "%s %s %s %s %s %s %s %s %d %s %d %s %d %s %lf"
/* JLL: 07/02/93 ADDED                 d1 d2 r  d3 c  d4 r  d5 n  d6 nc d7 ns d8 v */
#define CSR_MAP_TL_STATUS_FORMAT_STR "%s %s %c %s %c %s %c %s %c %s %c"
#define CSR_MAP_SD_FORMAT_STR "%s %s %s"
#define CSR_MAP_LAYOUT_FORMAT_STR "%s %s %s %s %c %s %s %s %s %s %c %s %d %s\
 %d %s %s %s %d %s %d %s %d %s %d %s %d %s %d %s %d %s %d"
#define CSR_MAP_SERVICE_HDR_FORMAT_STR  "%s %s %s %s %lu %s %d %s %lu %s %s\
 %s %s %s %s %s %s %s %d %s %lf %s %s"
#define CSR_MAP_RELATE_RPMH_FORMAT_STR  "%s %s %d %s %c"
#define CSR_MAP_RELATE_CK_FORMAT_STR  "%s %s %d %s %c %s %s %s %c %s %s %s %s"
#define CSR_MAP_RELATE_RD_FORMAT_STR  "%s %s %d"
#define CSR_MAP_RELATE_LK_FORMAT_STR  "%s %s %d %s %c %s %s"
#define CSR_MAP_RELATE_LD_FORMAT_STR  "%s %s %d %s %c %s %s"

/****************************************************************
**
**                   ENUMERATED DATA TYPES
**
*****************************************************************/
enum LITERAL_DATA_TYPES {CSR_STRING, CSR_SHORT, CSR_LONG, CSR_DOUBLE,
                         CSR_LONG_DBL, CSR_ULONG, CSR_FLOAT, CSR_UCHAR,
                         CSR_USHORT, CSR_BYTE, CSR_POINTER};

enum LANGUAGE_TYPE { C_LANGUAGE, COBOL_LANGUAGE};

/****************************************************************
**
**                  STRUCTURE DEFINITIONS
**
*****************************************************************/
typedef struct __LAYOUT_REC
{
  /* Repository fields */
  char  ItemId[ DOCID_LEN ];
  char  ItemType;                       /* Record (R), Record Group (G) */
                                        /*   or Element (E)             */

  char  ItemCName[ ITEM_NAME_LEN ];      /* C Name */
  char  ItemCobolName[ ITEM_NAME_LEN ];  /* COBOL Name */

  char  ElementTypeCode;
  char  Format;                     /* Format of item: A or N */
  short ItemLength;                 /* Length of item */
  short Precision;
  char  Usage[_USAGE_LEN];
  USHORT ItemOccurs;

  enum LITERAL_DATA_TYPES DataType;

  /* Calculated fields */
  short  ItemLevel;           /* Determined by service */
  USHORT ItemOffset;          /* Calculated from lengths of preceding fields */
  USHORT ItemCLength;         /* Calculated from repository information */

  /* Indexes of other records */
  short ChildIndex;                /* Index of child record (for groups) */
  short SiblingIndex;              /* Index of sibling record */
  short ParentIndex;               /* Index of parent record */

  /* JSH: 07/09/93 ADDED */
  short IndentLevel;

} _LAYOUT_REC;

typedef struct __RETR_LAYOUT_INPUT
{
  CHAR EntityId[DOCID_LEN];
  CHAR EntityType;
  SHORT MaxRows;
  _LAYOUT_REC *pLayoutTable;
} _RETR_LAYOUT_INPUT;


typedef struct __RETR_LAYOUT_OUTPUT
{
  SHORT Rc1;
  SHORT Rc2;
  SHORT RowsReturned;
} _RETR_LAYOUT_OUTPUT;


typedef struct __RELATE_RPMH
{
  short ClientLayoutIndex;
  char  SingleOccurence;
} _RELATE_RPMH;


typedef struct __RELATE_CK
{
  short ClientLayoutIndex;
  char  LiteralUsed;
  char  LiteralValue[ _LITERAL_VALUE_LEN ];
  char  WildCardUsed;
  char  WildCardValue[ WILDCARD_LEN ];
  char  Operation[_OPERATION_LEN];


} _RELATE_CK;


typedef struct __RELATE_LK
{
  short ClientLayoutIndex;
  char  LiteralUsed;
  char  LiteralValue[ _LITERAL_VALUE_LEN ];
} _RELATE_LK;


typedef struct __RELATE_LD
{
  short ClientLayoutIndex;
  char LiteralUsed;
  char LiteralValue[_LITERAL_VALUE_LEN];
} _RELATE_LD;


typedef struct __RELATE_RD
{
  short ClientLayoutIndex;
} _RELATE_RD;

typedef struct __SEARCH_DESTROY
{
  char ReqId[_REQ_ID_LEN];
} _SEARCH_DESTROY;

typedef struct __SERVICE_INFO
{
  /* Service Header info */
  char ServiceLayoutName[ SERVICE_NAME_LEN ];
  ULONG Server;
  _SERVICE ServiceId;

  /* JLL:  06/04/93  REMOVED TransMap; Duplicate of ServiceLayoutName */
  /* char TransMap[_TRANS_MAP_LEN]; */

  BOOL DeleteFlag;                        /* JLL: 07/06/93 ADDED */
  ULONG ServiceAgeLimit;
  char AnticCallModule[_ANTIC_CALL_LEN];
  BOOL FlushFlag;
  char ServiceType[2];
  CHAR AlternateService[_ALT_SERV_LEN];   /* JLL: 07/01/93 ADDED */

  double Version;  /* CSC: 08/09/94 */
  CHAR ForceCall[2];  /* CSC: 08/09/94 */

  /* Number of Rows in the Service Layout */
  short NumServiceRows;             /* JLL:  06/04/93  CHANGED from NumRows */
  short NumReposServiceRows;             /* JLL:  06/08/93 ADDED */

  _LAYOUT_REC *pServiceLayoutTable;      /* Pointer to Layout Table */
  _LAYOUT_REC *pReposServiceLayoutTable; /* JLL:  06/08/93 ADDED */


  /* Pointers to relationship tables */
  _RELATE_RPMH *pRepeatingMaps;          /* BCN: 06/08/93 */
  _RELATE_CK   *pCompareKeys;
  _RELATE_LK   *pLoadKeys;
  _RELATE_LD   *pLoadData;
  _RELATE_RD   *pReturnData;

 /* Pointers to saved relationship tables  CSC: 11/08/93 */
  _RELATE_RPMH *pSavedRepeatingMaps;
  _RELATE_CK   *pSavedCompareKeys;
  _RELATE_LK   *pSavedLoadKeys;
  _RELATE_LD   *pSavedLoadData;
  _RELATE_RD   *pSavedReturnData;

} _SERVICE_INFO;


typedef struct __REQUEST_INFO
{
  char   ReqId[_REQ_ID_LEN];
  char   ClientLayoutName[_REQ_ID_LEN];
  char   ReqType[_REQ_TYPE_LEN];

  short NumSearchDestroy;                       /* JLL:  06/07/93 ADDED */

  _SEARCH_DESTROY SearchDestroyTable[MAX_SD];   /* JLL:  06/04/93  ADDED */


  /* Number of Rows in Layout */
  short NumClientRows;           /* JLL:  06/04/93  CHANGED from NumRows */
  short NumReposClientRows;      /* JLL:  06/08/93  ADDED */
  double Version;  /* CSC: 08/09/94 */

  _LAYOUT_REC *pClientLayoutTable;
  _LAYOUT_REC *pReposClientLayoutTable;         /* JLL:  06/08/93 ADDED */

} _REQUEST_INFO;


typedef struct __BFCD_GLOBAL_DATA
{
  _REQUEST_INFO  ClientInfo;   /* Client Information */

  short NumServices;           /* JLL:  06/08/93 ADDED */

  /* Service Information for maximum number of services */
  _SERVICE_INFO ServiceInfoTable[ MAX_SERVICES ];

  char CsrMapSavePath[_PATH_LEN];     /* BCN: 06/08/93 */
  char CsrMapGenPath[_PATH_LEN];      /* BCN: 06/08/93 */
  char CsrMapConfigPath[AZCS01_TEMP_CONFIG_PATH_LEN];	  /* JHR: 12/02/98 */

  /*mdc 10/25/96 added for mass generate feature */
  char CsrMapLstFile[_PATH_LEN];  
  char CsrFLMassGen;

  char CKTaskListComplete;            /* JLL:  07/01/93 ADDED */
  char RDTaskListComplete;            /* JLL:  07/02/93 ADDED */
  char LKTaskListComplete;            /* JLL:  07/02/93 ADDED */
  char LDTaskListComplete;            /* JLL:  07/02/93 ADDED */
  char RPMHTaskListComplete;          /* JLL:  07/06/93 ADDED */

  char ChangeFlag;                    /* CSC:  09/07/93 ADDED */
  BOOL AbortFlag;                     /* CSC:  09/20/93 ADDED */


} _BFCD_GLOBAL_DATA;


typedef struct __WCD_DATA
{
  enum LANGUAGE_TYPE ClientLanguage;    /* JLL:  06/08/93 ADDED */
  enum LANGUAGE_TYPE ServiceLanguage;   /* JLL:  06/08/93 ADDED */

  short NumServices;                    /* JLL:  06/08/93 ADDED */
  short CurrentServiceIndex;            /* CSC:  06/09/93 ADDED */
  short PrevClientRow;                  /* CSC:  06/09/93 ADDED */
  short PrevServiceRow;                 /* CSC:  06/09/93 ADDED */
  short ClientLBOffset;                 /* CSC:  09/24/93 ADDED */
  short ServiceLBOffset;                /* CSC:  09/24/93 ADDED */

  _SERVICE_INFO ServiceInfoTable[ MAX_SERVICES ];
} _WCD_DATA;

/****************************************************************
**
**                     GLOBAL VARIABLES
**
*****************************************************************/

SHORT GlobalNestedLevel;                /* JLL:  06/14/93 ADDED */
BOOL PrintHeader;                       /* JLL:  06/16/93 ADDED */

/****************************************************************
**
**                    FUNCTION DEFINTIONS
**
*****************************************************************/

/* JSH: 06/22/93 ADDED */
/* JSH: 07/01/93 MODIFIED */
/* JSH: 07/01/93 TEMPORARILY REMOVED */
/*
SHORT CsrMapRetrieveLayout( CHAR *EntityId, CHAR ClientLayoutFlag,
                            _LAYOUT_REC **ppLayoutRecTable,
                            USHORT *pNumberRows, CMN_ARCH_PARM_TYPES );
*/

/* JLL: 06/09/93 ADDED */
/* JLL: 06/14/93 CHANGED; ADDED PARM Offsets[] */
/* JSH: 07/01/93 MODIFIED */
/*
USHORT CsrMapProcessDataLayout(  USHORT      Offsets[],
                                 _LAYOUT_REC ReposLayout[],
                                 USHORT     CurIndex,
                                 USHORT     CurLevel,
                                 USHORT     CurOffset,
                                 USHORT     *pGroupCLength );
*/

/* NOTIFY JON HERSTEIN (x4414) IF THIS IS CHANGED!!! */
//USHORT CsrMapProcessDataLayout(  _ENTITYDATA *pEntityDataTable,
//                                 USHORT      *Offsets,
//                                 _LAYOUT_REC *ReposLayout,
//                                 USHORT      CurIndex,
//                                 USHORT      CurLevel,
//                                 USHORT      CurOffset,
//                                USHORT      *pGroupCLength);

/* JLL: 06/09/93 ADDED */
//USHORT CsrMapProcessElement( _LAYOUT_REC DataElement,
//                              USHORT  *pCLength,
//              enum LITERAL_DATA_TYPES  *pDataType );

/* JSH: 07/01/93 ADDED */
//USHORT CsrMapInitItem( _ENTITYDATA *pEntityData, _LAYOUT_REC *pLayoutRec,
//                       CMN_ARCH_PARM_TYPES );



/* JLL:  06/14/93 ADDED */
/* JLL:  06/16/93 CHANGED; Added parm "Index" */
USHORT GenerateService( _LAYOUT_REC  ServiceLayout[],
                        _LAYOUT_REC  ClientLayout[],
                        _RELATE_RPMH RPMH[],
                        _RELATE_CK   CK[],
                        _RELATE_RD   RD[],
                        _RELATE_LK   LK[],
                        _RELATE_LD   LD[],
                        SHORT Index,
                        _SERVICE_INFO ServiceInfoTable[]);


/* JLL:  06/14/93 ADDED */
USHORT WriteCK( _LAYOUT_REC ClientLayout[],
                _LAYOUT_REC ServiceLayout[],
                USHORT CurIndex,
                _RELATE_RPMH RPMH[],
                _RELATE_CK CK[] );

/* JLL:  06/15/93 ADDED */
USHORT WriteRD( _LAYOUT_REC  ClientLayout[],
                _LAYOUT_REC  ServiceLayout[],
                 USHORT      CurIndex,
                _RELATE_RPMH RPMH[],
                _RELATE_RD   RD[] );

/* JLL:  06/15/93 ADDED */
USHORT WriteLK( _LAYOUT_REC  ClientLayout[],
                _LAYOUT_REC  ServiceLayout[],
                 USHORT      CurIndex,
                _RELATE_RPMH RPMH[],
                _RELATE_LK   LK[] );

/* JLL:  06/15/93 ADDED */
USHORT WriteLD( _LAYOUT_REC  ClientLayout[],
                _LAYOUT_REC  ServiceLayout[],
                 USHORT      CurIndex,
                _RELATE_RPMH RPMH[],
                _RELATE_LD   LD[] );

/* JLL:  06/15/93 ADDED */
USHORT FindRPMH( _LAYOUT_REC  ServiceLayout[],
                 _LAYOUT_REC  ClientLayout[], 
                  USHORT      CurIndex,
                 _RELATE_RPMH RPMH[],
                 _RELATE_CK   CK[],
                 _RELATE_RD   RD[],
                 _RELATE_LK   LK[],
                 _RELATE_LD   LD[] );

/* JLL:  06/15/93 ADDED */
USHORT WriteRPMHAndThenSome( _LAYOUT_REC  ServiceLayout[],
                             _LAYOUT_REC  ClientLayout[],
                              USHORT      CurIndex,
                             _RELATE_RPMH RPMH[],
                             _RELATE_CK   CK[], 
                             _RELATE_RD   RD[], 
                             _RELATE_LK   LK[], 
                             _RELATE_LD   LD[] );

/* JLL:  06/16/93 ADDED */
USHORT WriteRPCK( _LAYOUT_REC  ClientLayout[],
                _LAYOUT_REC  ServiceLayout[],
                 USHORT      CurIndex,
                _RELATE_RPMH RPMH[],
                _RELATE_CK   CK[]);

/* JLL:  06/16/93 ADDED */
USHORT WriteRPRD( _LAYOUT_REC  ClientLayout[],
                _LAYOUT_REC  ServiceLayout[],
                 USHORT      CurIndex,
                _RELATE_RPMH RPMH[],
                _RELATE_RD   RD[]);

/* JLL:  06/16/93 ADDED */
USHORT WriteRPLK( _LAYOUT_REC  ClientLayout[],
                  _LAYOUT_REC  ServiceLayout[],
                   USHORT      CurIndex,
                  _RELATE_RPMH RPMH[],
                  _RELATE_LK   LK[]);

/* JLL:  06/16/93 ADDED */
USHORT WriteRPLD( _LAYOUT_REC  ClientLayout[],
                  _LAYOUT_REC  ServiceLayout[],
                   USHORT      CurIndex,
                  _RELATE_RPMH RPMH[],
                  _RELATE_LD   LD[]);

/* JLL:  06/14/93 ADDED */
USHORT DecodeDataType( CHAR *DataType,
                       _LAYOUT_REC ServiceLayout[],
                       USHORT Index );

/*mdc 11/13/96 Moved here from c1cbase.h  
USHORT CsrMapReadMapFile( CMN_ARCH_PARM_TYPES );

USHORT CsrMapWriteMapFile( CMN_ARCH_PARM_TYPES );

USHORT GenerateMap( CMN_ARCH_PARM_TYPES );

USHORT WriteSDM( CMN_ARCH_PARM_TYPES );

USHORT WriteRMH( CMN_ARCH_PARM_TYPES) ;*/
