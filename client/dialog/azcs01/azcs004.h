/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*mdc 03/20/96 _WCDAZCS004C in azcs004c.h has been hand modified to include 
**                 _WCD_DATA WCD in the structure typedef.  This structure is not
**                  generated correctly and must be hand modified each time the client
**                  is generated.  Also malloc.h is not included by the driver and is
**                  included here.
**/

#include <malloc.h>

#define CMN_HIGH_VALUES_STR "HIGH-VALUES"
#define CMN_LOW_VALUES_STR  "LOW-VALUES"
#define CMN_MAPGEN_NAME "CSR Map Generator"

WCBFWD(AZCS004BUSAboutMNClick);
WCBFWD (UnLdAZCS4I);
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
WCBFWD(AZCS004BUSSetCLNTLITERALStatus);
WCBFWD(AZCS004BUSSetSRVCWLDCARDStatus);
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
