/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*mdc 03/20/96 _WCD_DATA WCD has been added to _WCDAZCS006C typedef in azcs006c.h. */
/*                 This structure is not generated correctly by FCP and must be edited each time */
/*                  azc01 is generated. The drivers do not include malloc.h so it is included here. */


#include <malloc.h>

#define CMN_HIGH_VALUES_STR "HIGH-VALUES"
#define CMN_LOW_VALUES_STR  "LOW-VALUES"

WCBFWD(AZCS006BUSAboutMNClick);
WCBFWD (UnLdAZCS6I);
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
WCBFWD(AZCS006BUSSetCLNTLITERALStatus);
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


short ClientElmntToRow(short ClientElmnt, CMN_ARCH_PARM_TYPES);
short ServiceElmntToRow(short ServiceElmnt, CMN_ARCH_PARM_TYPES);
short LoadClientElmnt(short ClientElmnt, CMN_ARCH_PARM_TYPES);
short LoadServiceElmnt(short ServiceElmnt, CMN_ARCH_PARM_TYPES);


SHORT CheckDataTypes( USHORT ClientIndex,
                      USHORT ServiceIndex,
                      USHORT ServiceNum,
                      CMN_ARCH_PARM_TYPES);
