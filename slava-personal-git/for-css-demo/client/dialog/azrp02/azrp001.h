/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : azrp001.H
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : 
**
**  DATE CREATED     : 
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**                                    Original code.
**    04/15/96  mconner               Added numerous functions and definitions
**                                    to accomodate port to NT and generally 
**                                    clean it up
**
**   04/25/96  mconner                Changed definition of NUM_SUBS to 10 
**                                    Long desc of 640 bytes expand to more than
**                                    8 lines for printing. Removed definition of 
**                                    PRINTPORT for win NT. Code now useds call 
**                                    to system for default printer
**
**   10/30/97  MEVANS        T4       Added #include <arc00305.h> to 
**                                    support calls to new Architecture 
**                                    Print Driver.
**
**   01/28/97  B Lucas                added defines for AZRP001BusPrintReport
**                                    and AZRP001BusFormatHeader functions  
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
#include <malloc.h>
#include <time.h>
#include <ctype.h>
#include "systcomm.hh"
#include "roadmap.hh"

/**************************************************************************
**   C1/C Architecture #include
***************************************************************************/
#include <arc00305.h>

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
#define ENTITY_ID_LEN   9
#define ENTITY_TYPE_LEN 9
#define NUM_BLANKS_IN_BLANK_STRING   2
#define LONG_DESC_LEN   651
#define LINE_LEN        80
#define SUB_STR_LEN     120
#define NUM_SUBS        10
#define PARSE_CHAR      '\n'
#define PAD_CHAR        ' '
#define DATE_STR_LEN    9		 
/*mdc 04/25/96 not used with win NT default printer logic
#ifdef FND_WIN32
#define PRINTPORT       "LPT2"
#endif
*/
#ifdef FND_OS2
#define PRINTPORT       "LPT1"
#endif
#define PAD_LEN         32
/*mdc 05/10/96 define entity types */
#define ENTITY_TYPE_1     "TABLE"
#define ENTITY_TYPE_2     "COPYBOOK"
#define ENTITY_TYPE_3     "RECORD"
#define ENTITY_TYPE_4     "GROUP"
#define ENTITY_TYPE_5     "ELEMENT"

/*             FMT    LEN   PREC  US    OCCUR BYTES OTHER */
#define SEG_RPT_DTL_FMT \
        "      %-2.2s %3.3s %4.4s %2.2s %5.5s %5.5s %-22.22s\n"

#define SEG_RPT_COLHDR1 \
"      -----------------------------------------------------------------------------------------------------------------------------"

#define SEG_RPT_COLHDR2 \
"      DOCUMENT ID              ITEM TYPE      ITEM NAME                          FMT LEN PREC US OCCUR BYTES OTHER CHARACTERISTICS "

#define SEG_RPT_COLHDR3 \
"      ---------------------    ----------     ------------------------------     --- --- ---- -- ----- ----- ----------------------"

#define AZRP001_SEG_RPT_COLHDR1 \
"------------------------------------------------------------------------------------------------------------------"
#define AZRP001_SEG_RPT_COLHDR2 \
"DOCUMENT ID       ITEM TYPE        ITEM NAME                     FMT LEN PREC US OCCUR BYTES OTHER CHARACTERISTICS"
#define AZRP001_SEG_RPT_COLHDR3 \
"-----------       ---------        ---------                     --- --- ---- -- ----- ----- ---------------------"

/*
** bdl 01/28/98
** added following defines 
*/

/* curr page/line defines */
#define MAX_LINES_PER_PAGE    89

/* entity types */
#define ENTITY_TYPE_TABLE     'T'
#define ENTITY_TYPE_COPYBOOK  'C'
#define ENTITY_TYPE_RECORD    'R'
#define ENTITY_TYPE_GROUP     'G'
#define ENTITY_TYPE_ELEMENT   'E'
#define ENTITY_TYPE_NUMERIC   'N'

/* label defines */
#define LABEL_TABLE_NAME       "TABLE NAME:"
#define LABEL_CHARACTERISTICS  "CHARACTERISTICS"
#define LABEL_SHORT_DESC       "SHORT DESCRIPTION:"
#define LABEL_LONG_DESC        "LONG DESCRIPTION:"
#define LABEL_FND_CSS          "FOUNDATION 3.2/CSS"
#define LABEL_SEG_RPT          "SEGMENT REPORTER"
#define LABEL_PAGE             "Page "

/* header offsets */	
#define OFFSET_PAGE              38
#define OFFSET_DATE              39
#define OFFSET_TBL_NAME          2
#define OFFSET_SHORT_DESC        OFFSET_TBL_NAME
#define OFFSET_LONG_DESC         OFFSET_TBL_NAME
#define OFFSET_FND_CSS           47
#define OFFSET_SEG_RPT           OFFSET_FND_CSS
#define OFFSET_ENTITY            OFFSET_FND_CSS
#define OFFSET_TBL_NAME_LABEL	 3
#define OFFSET_SHORT_DESC_LABEL  OFFSET_TBL_NAME_LABEL
#define OFFSET_LONG_DESC_LABEL   OFFSET_TBL_NAME_LABEL

/* detail section offsets */
#define OFFSET_OCCUR       1
#define OFFSET_OTHER_CHAR  1
#define OFFSET_BYTES       1
#define OFFSET_LEN         2
#define OFFSET_PREC        1
#define OFFSET_US          1
#define OFFSET_FMT         1

/* column widths */
#define COL_WIDTH_DESC   18
#define COL_WIDTH_TITLE  20

#define COL_WIDTH_DOC_ID      18
#define COL_WIDTH_ITEM_TYPE   17
#define COL_WIDTH_OCCUR       5
#define COL_WIDTH_OTHER_CHAR  22
#define COL_WIDTH_BYTES       5
#define COL_WIDTH_LEN         3
#define COL_WIDTH_PREC        4
#define COL_WIDTH_US          2
#define COL_WIDTH_FMT         3

/* default margin settings */
#define DEFAULT_MARGIN_TOP     5
#define DEFAULT_MARGIN_BOTTOM  5
#define DEFAULT_MARGIN_LEFT    4
#define DEFAULT_MARGIN_RIGHT   4

/* misc defaults */
#define INDENT_FACTOR  2
#define FMT_START_COL  64

/* messages */
#define MSG_TOO_MANY_ROWS  "%c%s%c%sthe maximum number of printable lines " \
                           "(%d) has been exceeded.%c%sthe remaining data " \
                           "will not be printed.%c%s"
                           

/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/

WCBFWD(	AZRP001BUSPredisplay )
WCBFWD( AZRP001BusAmnprintClk )
WCBFWD( AZRP001BusFindpbClk )
WCBFWD( AZRP001BusAmnbatchClk )

SHORT SegRptRetrieveLayout( _REQUESTHDR *pRequestHdr,
                            _REPLYHDR *pReplyHdr,
                            _ENTITYDATA *pEntityDataTable,
                            CMN_ARCH_PARM_TYPES );

SHORT AZRP001PopulateWindow( _ENTITYDATA *pEntityDataTable,
                             _REPLYHDR *pReplyHdr,
                             CMN_ARCH_PARM_TYPES );

/* 10/31/97 MEVANS  New function used to interface with new Print Driver */
SHORT AZRP001BusPrintReport( _REQUESTHDR *pRequestHdr, 
                             _REPLYHDR   *pReplyHdr,
                             _ENTITYDATA *pEntityDataTable, 
                             CHAR         Duplex, 
                             CMN_ARCH_PARM_TYPES );

SHORT AZRP001BusFormatHeader( CHAR *DatatoPrint,
						      LONG *DataToPrintSize,
                              _REQUESTHDR *pRequestHdr,
                              _REPLYHDR   *pReplyHdr, 
                              _ENTITYDATA *pEntityDataTable,
                              SHORT        CurrPage, 
                              SHORT       *pCurrLine, 
                              CMN_ARCH_PARM_TYPES );

SHORT AZRP001BusWriteReport( _REQUESTHDR *pRequestHdr, 
                             _REPLYHDR   *pReplyHdr,
                             _ENTITYDATA *pEntityDataTable, 
                             CHAR        *PrintFile,
                             CHAR         Duplex, 
                             CMN_ARCH_PARM_TYPES );

SHORT AZRP001BusWriteHeader( FILE        *pfPrinter, 
                             _REQUESTHDR *pRequestHdr,
                             _REPLYHDR   *pReplyHdr, 
                             _ENTITYDATA *pEntityDataTable,
                             SHORT        CurrPage, 
                             SHORT       *pCurrLine, 
                             CMN_ARCH_PARM_TYPES );

USHORT FormatLongDesc(char *,
                      USHORT *);


USHORT StrAllocateSubs(char *[],
                       USHORT,
				       USHORT);

USHORT FreeMemArray(void *[]);

USHORT StrInsertCRLF(char *,
		             USHORT *);

USHORT StrParse(char *,
				char *[],
				char,
				USHORT);

USHORT StrPad(char *,
			  char,
			  USHORT);

USHORT StrAssemble(char *,
				   char *[]);

USHORT GetEntityType(char *);

