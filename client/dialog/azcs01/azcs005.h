/***************************************************************************
**
**               Customer Service System Architecture Header File
**
**  FILENAME         : azcs005
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
WCBFWD (UnLdAZCS5I);
WCBFWD (AZCS005BUSMoveLB1);
WCBFWD (AZCS005BUSMoveLB2);
WCBFWD (AZCS005BUSNewService);
WCBFWD(AZCS005BUSCreateRelationship);
WCBFWD(AZCS005BUSRemoveRelationship);
WCBFWD(MoveService);
WCBFWD(MoveClient);
WCBFWD(CellDataComplete);
WCBFWD(CellDataNotCompleteClient);
WCBFWD(CellDataNotCompleteService);
WCBFWD(AZCS005BUSSaveToBFCD);
WCBFWD(FillStatusRD);
WCBFWD(InitClient);
WCBFWD(InitService);
WCBFWD(AZCS005BUSClntLng);
WCBFWD(AZCS005BUSSrvLng);
WCBFWD(FillServiceLB);
WCBFWD(CellAttrNotNorm);
WCBFWD(AZCS005BUSFillClientLB);
WCBFWD(LookForClientName);
WCBFWD(LookForServiceName);
WCBFWD(Azcs005busrlb01elbpagedown);
WCBFWD(Azcs005busrlb01elbpageup);
WCBFWD(Azcs005busrlb02elbpagedown);
WCBFWD(Azcs005busrlb02elbpageup);

SHORT ClientElmntToRow(SHORT ClientElmnt, CMN_ARCH_PARM_TYPES);
SHORT ServiceElmntToRow(SHORT ServiceElmnt, CMN_ARCH_PARM_TYPES);
SHORT LoadClientElmnt(SHORT ClientElmnt, CMN_ARCH_PARM_TYPES);
SHORT LoadServiceElmnt(SHORT ServiceElmnt, CMN_ARCH_PARM_TYPES);
SHORT FindClientMatch(CMN_ARCH_PARM_TYPES);
SHORT FillLayoutLB(char *LBName,
                   _LAYOUT_REC *pLayout,
                   USHORT NumRec,
                   enum LANGUAGE_TYPE Language,
                   CMN_ARCH_PARM_TYPES);

SHORT CheckDataTypes( USHORT ClientIndex,
                      USHORT ServiceIndex,
                      USHORT ServiceNum,
                      CMN_ARCH_PARM_TYPES);

