/***************************************************************************
**
**               Customer Service System Architecture Header File
**
**  FILENAME         : 	azcs011
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


/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/
WCBFWD (AZCS011BUSUserPredisplay);
WCBFWD(AZCS011BUSAboutMNClick);
WCBFWD (AZCS011BUSMoveLB1);
WCBFWD (AZCS011BUSMoveLB2);
WCBFWD (NewService);
WCBFWD(AZCS011BUSCreateRelationship);
WCBFWD(AZCS011BUSRemoveRelationship);
WCBFWD(CellAttrNormS);
WCBFWD(CellAttrNormC);
WCBFWD(AZCD001BusCellDataComplete);
WCBFWD(CellDataNotCompleteClient);
WCBFWD(CellDataNotCompleteService);
WCBFWD(AZCS011BUSSaveToBFCD);
WCBFWD(FillStatusRM);
WCBFWD(InitService);
WCBFWD(MoveService);
WCBFWD(InitClient);
WCBPROC(MoveClient);
WCBPROC(CellAttrNotNorm);
WCBPROC(AZCS011BUSChangeClientType);
WCBPROC(AZCS011BUSChangeServiceType);
WCBFWD(AZCS011BUSClntLng);
WCBFWD(AZCS011BUSSrvLng);
WCBFWD(FillServiceLB);
WCBFWD(AZCS011BUSFillClientLB);
WCBFWD(CellAttrNotNorm);
WCBFWD(DisableClientRows)
SHORT FindClientMatch(CMN_ARCH_PARM_TYPES);
WCBFWD(LookForClientName);
WCBFWD(Azcs011busrlb01elbpagedown);
WCBFWD(Azcs011busrlb01elbpageup);
WCBFWD(Azcs011busrlb02elbpagedown);
WCBFWD(Azcs011busrlb02elbpageup);
WCBFWD(AZCS011BusCellDataComplete);
WCBFWD(ServiceDataComplete);

SHORT ClientElmntToRow(SHORT ClientElmnt, CMN_ARCH_PARM_TYPES);
SHORT ServiceElmntToRow(SHORT ServiceElmnt, CMN_ARCH_PARM_TYPES);
SHORT LoadClientElmnt(SHORT ClientElmnt, CMN_ARCH_PARM_TYPES);
SHORT LoadServiceElmnt(SHORT ServiceElmnt, CMN_ARCH_PARM_TYPES);

