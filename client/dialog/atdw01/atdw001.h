/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : ATDW001.H
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
/* cwoods: added help files */
#include <systcomm.hh>
#include <roadmap.hh>

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
#include "ATDW01.h"   /* Dialog level header file */
#include <time.h>     /* for printing functions */
// #include <ctype.h>    /* for toascii function   */
#include <io.h>
#include <stdio.h>

#include "csrdiag.hh" /* CSC: 10/25/93 Test of windows 3.0 help */

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
#define SET_LANDSCAPE   "\033&l1O"
#define LINE_PRINTER "\033(0N\033(s0p16.67h8.5v0s0b0T"
#define VMI                   "\033&l5.6C"  // 5.6

#define RESET_PRINTER "\033E"

#define CSR_DIAG_PIPE_TIMEOUT 1000

#define FILE_LEN            80

#define ATDW001_SERVER_LEN 9
#define ATDW001_PRINTER_LEN 9

/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/


WCBFWD( ATDW001BusPredisplay );
WCBFWD( ATDW001BusAmnstatClick );
WCBFWD( ATDW001BusAmnmapsClick );
WCBFWD( ATDW001BusAmndataClick );
WCBFWD( ATDW001BusAmnprntfClick );
WCBFWD( ATDW001BusAmnprntpClick );
WCBFWD( ATDW001BusServicesLBDblClick );
WCBFWD( ATDW001BusInterWindow);
WCBFWD( ATDW001BusRBFldChg);
WCBFWD( ATDW001BusFillMsgBox);
WCBFWD( ATDW001BusWriteSaveFile);
WCBFWD( ATDW001BusAboutMNClick);
WCBFWD( ATDW001BusWindowClose);
WCBFWD( ATDW001BusOtherGui);

short ATDW001BusProcessRequestMsg(CMN_ARCH_PARM_TYPES);
short ATDW001BusProcessServiceMsg(CMN_ARCH_PARM_TYPES);
short ATDW001BusProcessDetailMsg(CMN_ARCH_PARM_TYPES);

BOOL SaveToFile ( HWND,
                  CMN_ARCH_PARM_TYPES );
BOOL PrintToFile( HWND,
                  CMN_ARCH_PARM_TYPES );


/***************************************************************************/
/* Forward declarations for Architecture Exit Functions                    */
/***************************************************************************/
