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
**   03/25/99   N.Eyde                added includes and defines for 
**                                    megascrolling
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
/*mdc - 01-08-96 - added  include malloc here and removed from azcs00n.c
 */
#include <malloc.h>
#include <azcs01.h> /* NEYDE - 03/25/99 - Added dialog header */
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
/* NEYDE - 03/25/99 - The following structure defines the data stored for
**                    megascrolling data.
*/
 #ifndef  _AZCS006_KEYS_z
 #define  _AZCS006_KEYS_z
 typedef  struct __AZCS006_Keys
 {
   SHORT                KySelectedRow;                                                 

 }_AZCS006_KEYS;
 #endif


/* NEYDE - 03/25/99 - The following structure defines the window's working
**                    storage.
*/
 #ifndef _AZCS006_WINDOWDATA_z
 #define _AZCS006_WINDOWDATA_z
 typedef struct __AZCS006_WindowData
 {
    _AZCS01MEGASCROLL *pClientMegaScroll;
    _AZCS01MEGASCROLL *pServiceMegaScroll;
	 
 }_AZCS006_WINDOWDATA;
 #endif

#define WCD_pWorkingStorageData ( (_AZCS006_WINDOWDATA *) pWindContextData->pWorkingStorageData)


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

SHORT FindClientMatch(CMN_ARCH_PARM_TYPES);
SHORT FillLayoutLB(char *LBName,
                   _LAYOUT_REC *pLayout,
                   USHORT NumRec,
                   enum LANGUAGE_TYPE Language,
                   CMN_ARCH_PARM_TYPES);

