/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Architecture Header File
**
**  FILENAME         : azcs006
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
**   03/21/96   mconner               added AZCS006BUSAboutMNClick
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
WCBFWD (UnLdAZCS6I);
WCBFWD(AZCS006BUSAboutMNClick);
WCBFWD(AZCS006BUSSetCLNTLITERALStatus);
WCBFWD (AZCS006BUSMoveLB1);
WCBFWD (AZCS006BUSMoveLB2);
WCBFWD (AZCS006BUSNewService);
WCBFWD(AZCS006BUSCreateRelationship);
WCBFWD(AZCS006BUSRemoveRelationship);
WCBFWD(CellAttrNormS);
WCBFWD(CellAttrNormC);
WCBFWD(CellDataComplete);
WCBFWD(CellDataNotCompleteClient);
WCBFWD(CellDataNotCompleteService);
WCBFWD(AZCS006BUSSaveToBFCD);
WCBFWD(FillStatusLK);
WCBFWD(InitService);
WCBFWD(MoveService);
WCBFWD(InitClient);
WCBFWD(MoveClient);
WCBFWD(CellAttrNotNorm);
WCBFWD(AZCS006BUSChangeClientType);
WCBFWD(AZCS006BUSChangeServiceType);
WCBFWD(AZCS006BUSClntLng);
WCBFWD(AZCS006BUSSrvLng);
WCBFWD(FillServiceLB);
WCBFWD(AZCS006BUSFillClientLB);
WCBFWD(LookForClientName);
WCBFWD(LookForServiceName);
WCBFWD(Azcs006busrlb01elbpagedown);
WCBFWD(Azcs006busrlb01elbpageup);
WCBFWD(Azcs006busrlb02elbpagedown);
WCBFWD(Azcs006busrlb02elbpageup);

SHORT ClientElmntToRow(SHORT ClientElmnt, CMN_ARCH_PARM_TYPES);
SHORT ServiceElmntToRow(SHORT ServiceElmnt, CMN_ARCH_PARM_TYPES);
SHORT LoadClientElmnt(SHORT ClientElmnt, CMN_ARCH_PARM_TYPES);
SHORT LoadServiceElmnt(SHORT ServiceElmnt, CMN_ARCH_PARM_TYPES);


SHORT CheckDataTypes( USHORT ClientIndex,
                      USHORT ServiceIndex,
                      USHORT ServiceNum,
                      CMN_ARCH_PARM_TYPES);

