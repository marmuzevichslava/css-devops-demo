/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Architecture Header File
**
**  FILENAME         : 	azcs001
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : MCONNER
**
**  DATE CREATED     : 01-08-96
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**	 01/08/96   mconner               added malloc.h
**   01/15/96   mconner               added help headers
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
/*mdc - 01-08-96 - added  include malloc here and removed from azcs00n.c
 */
#include <malloc.h>

/*mdc 01-15-96 - added for help */
#include "systcomm.hh"
#include "roadmap.hh"



/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
#define CMN_MAPGEN_NAME "CSR Map Generator"
#define     MAPGEN_ELB_NAME "Rlb01ELB"

#define SET_LANDSCAPE   "\033&l1O"
#define LINE_PRINTER "\033(0N\033(s0p16.67h8.5v0s0b0T"
#define VMI                   "\033&l5.6C"  // 5.6

#define RESET_PRINTER "\033E"


/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/







/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/
WCBFWD (AZCS001BusAboutMNClick);
WCBFWD (AZCS001BUSPredistroy);
WCBFWD (OpnAZCS2);
WCBFWD (OpnAZCS3);
WCBFWD (ClsAZCS1);
WCBFWD (OpnAZCS4);
WCBFWD (OpnAZCS5);
WCBFWD (OpnAZCS6);
WCBFWD (OpnAZCS7);
WCBFWD (GetDefDir);
WCBFWD (ChkTLStatus);
WCBFWD (SetupBFCD);
WCBFWD (AZCS001BusAmnGenerateClk);
WCBFWD (AZCS001BusAmnSaveClk);
WCBFWD (RestoreServiceLB);
WCBFWD (RestoreTaskList);
WCBFWD (GetServiceReposData);
WCBFWD (AZCS001BusCleanupBFCD);
WCBFWD (AZCS001BusAMNDumpClk);
WCBFWD (SetDeleteFlag);
WCBFWD (ResetDeleteFlag);

 SHORT CsrMapRetrieveLayout( CHAR *EntityId, CHAR ClientLayoutFlag,
                            _LAYOUT_REC **ppLayoutRecTable,
                            USHORT *pNumberRows,
                            double *pVersionNumber,
                            CMN_ARCH_PARM_TYPES );

short GetServiceIndex(unsigned long Server,
                      unsigned short ServiceID,
                      char *TranMap,
                      CMN_ARCH_PARM_TYPES);

