/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : AZDW001.H
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : C. Crampton
**
**  DATE CREATED     : 08/10/93
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    99/99/99  XXXXXXXX              Original code.
**
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
#include "AZDW01.h"   /* Dialog level header file */
#include <time.h>     /* for printing functions */
// #include <ctype.h>    /* for toascii function   */


#include "csrdiag.hh" /* CSC: 10/25/93 Test of windows 3.0 help */

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
#define SET_LANDSCAPE   "\033&l1O"
#define LINE_PRINTER "\033(0N\033(s0p16.67h8.5v0s0b0T"
#define VMI                   "\033&l5.6C"  // 5.6

#define RESET_PRINTER "\033E"

#define CSR_DIAG_PIPE_TIMEOUT 1000

/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/


WCBFWD( AZDW001BusPredisplay );
WCBFWD( AZDW001BusAmnstatClick );
WCBFWD( AZDW001BusAmnmapsClick );
WCBFWD( AZDW001BusAmndataClick );
WCBFWD( AZDW001BusAmnprntfClick );
WCBFWD( AZDW001BusAmnprntpClick );
WCBFWD( AZDW001BusServicesLBDblClick );
WCBFWD( AZDW001BusOpenPipe );
WCBFWD( AZDW001BusReadPipe );
WCBFWD( AZDW001BusInterWindow);
WCBFWD( AZDW001BusRBFldChg);
WCBFWD( AZDW001BusFillMsgBox);
WCBFWD( AZDW001BusWriteSaveFile);
WCBFWD( AZDW001BusAboutMNClick);
WCBFWD( AZDW001BusWindowClose);
WCBFWD( AZDW001BusOtherGui);

short AZDW001BusProcessRequestMsg(CMN_ARCH_PARM_TYPES);
short AZDW001BusProcessServiceMsg(CMN_ARCH_PARM_TYPES);
short AZDW001BusProcessDetailMsg(CMN_ARCH_PARM_TYPES);



/***************************************************************************/
/* Forward declarations for Architecture Exit Functions                    */
/***************************************************************************/
