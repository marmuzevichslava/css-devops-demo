/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Architecture Header File
**
**  FILENAME         : azcs004
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
#define CMN_MAPGEN_NAME "CSR Map Generator"


/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/

/* NEYDE - 03/25/99 - The following structure defines the window's working
**                    storage.
*/
 #ifndef _AZCS004_WINDOWDATA_z
 #define _AZCS004_WINDOWDATA_z
 typedef struct __AZCS004_WindowData
 {
    _AZCS01MEGASCROLL *pClientMegaScroll;
    _AZCS01MEGASCROLL *pServiceMegaScroll;
	 
 }_AZCS004_WINDOWDATA;
 #endif

#define WCD_pWorkingStorageData ( (_AZCS004_WINDOWDATA *) pWindContextData->pWorkingStorageData)







/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/
WCBFWD (UnLdAZCS4I);
WCBFWD(AZCS004BUSAboutMNClick);
WCBFWD(AZCS004BUSSetCLNTLITERALStatus);
WCBFWD(AZCS004BUSSetSRVCWLDCARDStatus);
WCBFWD (AZCS004BUSMoveLB1);
WCBFWD (AZCS004BUSMoveLB2);
WCBFWD (AZCS004BUSNewService);
WCBFWD(AZCS004BUSCreateRelationship);
WCBFWD(AZCS004BUSRemoveRelationship);
WCBFWD(CellAttrNormS);
WCBFWD(CellAttrNormC);
WCBFWD(CellDataComplete);
WCBFWD(CellDataNotCompleteClient);
WCBFWD(CellDataNotCompleteService);
WCBFWD(AZCS004BUSSaveToBFCD);
WCBFWD(FillStatusCK);
WCBFWD(InitClient1);
WCBFWD(InitService1);
WCBFWD(AZCS004BUSClntLng);
WCBFWD(AZCS004BUSSrvLng);
WCBFWD(AZCS004BUSFillClientLB);
WCBFWD(FillServiceLB);
WCBFWD(CellAttrNotNorm);
WCBFWD(MoveClient1);
WCBFWD(MoveService1);
WCBFWD(AZCS004BUSChangeClientType);
WCBFWD(AZCS004BUSChangeServiceType);
WCBFWD(LookForClientName);
WCBFWD(LookForServiceName);
WCBFWD(Azcs004busrlb01elbpagedown);
WCBFWD(Azcs004busrlb01elbpageup);
WCBFWD(Azcs004busrlb02elbpagedown);
WCBFWD(Azcs004busrlb02elbpageup);

short ClientElmntToRow(short ClientElmnt, CMN_ARCH_PARM_TYPES);
short ServiceElmntToRow(short ServiceElmnt, CMN_ARCH_PARM_TYPES);
short LoadClientElmnt(short ClientElmnt, CMN_ARCH_PARM_TYPES);
short LoadServiceElmnt(short ServiceElmnt, CMN_ARCH_PARM_TYPES);
short FillLayoutLB(char *LBName,
                   _LAYOUT_REC *pLayout,
                   unsigned short NumRec,
                   enum LANGUAGE_TYPE Language,
                   CMN_ARCH_PARM_TYPES);
short FindClientMatch(CMN_ARCH_PARM_TYPES);

SHORT CheckDataTypes( USHORT ClientIndex,
                      USHORT ServiceIndex,
                      USHORT ServiceNum,
                      CMN_ARCH_PARM_TYPES);


SHORT  AZCS4FndCommandSetDefaultButton( FND_HWND WindowHandle,
                                           char CommandName[32],
                                           CMN_ARCH_PARM_TYPES);

SHORT  AZCS4FndLstBxRowQuerySelect( FND_HWND WindowHandle,
                                          char ListBoxName[32],
                                          short StartRowNumber,
                                          short *pRowNumber,
                                          CMN_ARCH_PARM_TYPES);

SHORT  AZCS004FndFieldSetValue( FND_HWND WindowHandle,
                                char *pszFldName,
                                USHORT DataLength,
                                void *pNewValue,
                                CMN_ARCH_PARM_TYPES);

