/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*------------------------------------------------------------------------
|
|   AZVS01 Post-Generation Service Copybook Processor
|
|   Filename:  AZVS01.H
|
|   Description:    This header contains the definitions for the Post
|                   Generation Service Copybook Processor program AZVS01.
|
|   Author: Lou Misfeldt, Florida Power Corporation
|
|   Date Create:  June 22, 1994
|
|   Maintenance Log:
|
|    DATE        BY        Description of Change
|  --------  ----------    -------------------------------------------------
|  06/22/94  L. Misfeldt   Creation
|
|--------------------------------------------------------------------------*/

#include <azrp001m.h>

#define REPEXSER_SERV_APPL_ID   1
#define REPEXSER_SERV_ID        1
#define REPEXSER_SERV_VER       "00"

#define REPEXSER_TRANS_MAP      "AZCR001O"
#define REPEXSER_TRANS_MAP_VER  "01"

#define AZVS01_APPL_ID           3
#define AZVS01_TIMEOUT          30
#define AZVS01_MSG_PRIORITY      0
#define AZVS01_MAX_ROWS        200
#define AZVS01_SUCCESS           0
#define AZVS01_FAIL              1
#define AZVS01_COBOL_BUF_LEN    80
#define AZVS01_C_BUF_LEN       256

#define AZVS01_COBOL_VER_FIELD  "NO-SVC-VERSION"
#define AZVS01_C_VER_FIELD      "NoSvcVersion"

/*
|   Data Element Usage Value Constants
*/
#define AZVS01_USAGE_GROUP          1
#define AZVS01_USAGE_DISPLAY        2
#define AZVS01_USAGE_COMP           3
#define AZVS01_USAGE_COMP3          4
#define AZVS01_USAGE_DATE           5
#define AZVS01_USAGE_TIME           6
#define AZVS01_USAGE_DISP_SIGNED    7
#define AZVS01_USAGE_DBL_PRECIS     8
#define AZVS01_USAGE_FLOAT_PT       9
#define AZVS01_USAGE_POINTER        10
#define AZVS01_USAGE_TIME_STAMP     11
#define AZVS01_USAGE_VARIABLE       12



SHORT BuildVersionNumber (_ENTITYDATA *pEntityData, USHORT nRows,
                          double *pVersion);

SHORT LocateCobolVerField (FILE *pInputFile, FILE *pOutputFile,
                           double dVersion);

SHORT LocateCVerField (FILE *pInputFile, FILE *pOutputFile,
                       double dVersion);

SHORT StrTrimTrailBlanks (char *Target, USHORT nSize);

SHORT ReportError (char *ErrorText);
