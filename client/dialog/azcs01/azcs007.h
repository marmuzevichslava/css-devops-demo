/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Architecture Header File
**
**  FILENAME         : azcs007
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

#include "systcomm.hh"
#include "roadmap.hh"

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
#define CMN_HIGH_VALUES_STR "HIGH-VALUES"
#define CMN_LOW_VALUES_STR  "LOW-VALUES"


/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/
WCBFWD (UnLdAZCS7I);
WCBFWD(AZCS007BUSAboutMNClick);
WCBFWD(AZCS007BUSSetCLNTLITERALStatus);
WCBFWD (AZCS007BUSMoveLB1);
WCBFWD (AZCS007BUSMoveLB2);
WCBFWD (AZCS007BUSNewService);
WCBFWD(AZCS007BUSCreateRelationship);
WCBFWD(AZCS007BUSRemoveRelationship);
WCBFWD(CellAttrNormS);
WCBFWD(CellAttrNormC);
WCBFWD(CellDataComplete);
WCBFWD(CellDataNotCompleteClient);
WCBFWD(CellDataNotCompleteService);
WCBFWD(AZCS007BUSSaveToBFCD);
WCBFWD(FillStatusLD);
WCBFWD(InitService);
WCBFWD(MoveService);
WCBFWD(InitClient);
WCBPROC(MoveClient);
WCBPROC(CellAttrNotNorm);
WCBPROC(AZCS007BUSChangeClientType);
WCBPROC(AZCS007BUSChangeServiceType);
WCBFWD(AZCS007BUSClntLng);
WCBFWD(AZCS007BUSSrvLng);
WCBFWD(FillServiceLB);
WCBFWD(AZCS007BUSFillClientLB);
WCBFWD(LookForClientName);
WCBFWD(LookForServiceName);
WCBFWD(Azcs007busrlb01elbpagedown);
WCBFWD(Azcs007busrlb01elbpageup);
WCBFWD(Azcs007busrlb02elbpagedown);
WCBFWD(Azcs007busrlb02elbpageup);


SHORT ClientElmntToRow(SHORT ClientElmnt, CMN_ARCH_PARM_TYPES);
SHORT ServiceElmntToRow(SHORT ServiceElmnt, CMN_ARCH_PARM_TYPES);
SHORT LoadClientElmnt(SHORT ClientElmnt, CMN_ARCH_PARM_TYPES);
SHORT LoadServiceElmnt(SHORT ServiceElmnt, CMN_ARCH_PARM_TYPES);

SHORT CheckDataTypes( USHORT ClientIndex,
                      USHORT ServiceIndex,
                      USHORT ServiceNum,
                      CMN_ARCH_PARM_TYPES);

