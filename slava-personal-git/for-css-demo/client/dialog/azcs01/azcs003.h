/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Architecture Header File
**
**  FILENAME         : azcs003
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
**	  01/08/96   mconner               added malloc.h
**   01/15/96   mconner               added help headers
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
/*mdc - 01-08-96 - added  include malloc here and removed from azcs00n.c
 */
#include <malloc.h>
/*#include "azcs002.gnh" mdc 03/22/96 Added for LT_RequestTypeUP definition*/
/*mdc 09/16/96 Removed above and defined LT_RequestTypeUP below*/

#include "systcomm.hh"
#include "roadmap.hh"

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
#define MAPGEN_ELBADD1_INST_NAME "Elb1AddRow"
#define MAPGEN_ELBCHG1_INST_NAME "Elb1ChangeRow"

/*mdc 09/16/96 Added here to match definition in azcs002.gnh*/
#ifndef LT_RequestTypeUP
#define LT_RequestTypeUP                     "2"
#endif

#define CHANGE_ACTION "Change Service Information"
#define CHANGE_OBJECT_TYPE "CSR Request ID"

#define ADD_TITLE "Add Server/Service Information"


/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/







/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/
WCBFWD (LdAZCS3O);
WCBFWD (UnLdAZCS3I);
WCBFWD (VerifyTranMap);
WCBFWD (ChkTranMap);
WCBFWD (AZCS003BusTranFldChg);

SHORT CsrMapRetrieveLayout( CHAR *EntityId, CHAR ClientLayoutFlag,
                            _LAYOUT_REC **ppLayoutRecTable,
                            USHORT *pNumberRows,
                            double *pVersionNumber,
                             CMN_ARCH_PARM_TYPES );

