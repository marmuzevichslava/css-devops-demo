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
**  AUTHOR           : XXXXXXXX
**
**  DATE CREATED     : 99/99/99
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    99/99/99  XXXXXXXX              Original code.
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
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
#include <malloc.h>
#include <time.h>
#include <ctype.h>
#include "systcomm.hh"
#include "roadmap.hh"

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
#define ENTITY_ID_LEN   9
#define ENTITY_TYPE_LEN 9
#define LONG_DESC_LEN   641
#define LINE_LEN        80
#define SUB_STR_LEN     120
#define NUM_SUBS        10
#define PARSE_CHAR      '\n'
#define PAD_CHAR        ' '
/*mdc 04/25/96 not used with win NT default printer logic
#ifdef FND_WIN32
#define PRINTPORT       "LPT2"
#endif
*/
#ifdef FND_OS2
#define PRINTPORT       "LPT1"
#endif
#define PAD_LEN         32

/*             FMT    LEN   PREC  US    OCCUR BYTES OTHER */
#define SEG_RPT_DTL_FMT \
        "      %-2.2s %3.3s %4.4s %2.2s %5.5s %5.5s %-22.22s\n"

#define SEG_RPT_COLHDR1 \
"      -----------------------------------------------------------------------------------------------------------------------------"

#define SEG_RPT_COLHDR2 \
"      DOCUMENT ID              ITEM TYPE      ITEM NAME                          FMT LEN PREC US OCCUR BYTES OTHER CHARACTERISTICS "

#define SEG_RPT_COLHDR3 \
"      ---------------------    ----------     ------------------------------     --- --- ---- -- ----- ----- ----------------------"

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

SHORT PrintHeader( FILE *pfPrinter, _REQUESTHDR *pRequestHdr,
                   _REPLYHDR *pReplyHdr, _ENTITYDATA *pEntityDataTable,
                   SHORT CurrPage, SHORT *pCurrLine, CMN_ARCH_PARM_TYPES );

SHORT PrintSegmentReport( _REQUESTHDR *pRequestHdr, _REPLYHDR *pReplyHdr,
                          _ENTITYDATA *pEntityDataTable, CHAR *PrintFile,
                          CHAR Duplex, CMN_ARCH_PARM_TYPES );

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

