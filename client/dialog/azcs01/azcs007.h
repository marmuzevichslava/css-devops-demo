/*mdc 03/20/96 _WCD_DATA WCD addded to _WCDAZCS007C in azcs007c.h. */
/*                 This structure is not generated correctly by FCP and must be */
/*                  edited each time azcs01 is generated.  malloc.h is not included */
/*                  by the generation drdiver so it is included here */



#include <malloc.h>

#define CMN_HIGH_VALUES_STR "HIGH-VALUES"
#define CMN_LOW_VALUES_STR  "LOW-VALUES"

WCBFWD(AZCS007BUSAboutMNClick);
WCBFWD (UnLdAZCS7I);
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
WCBFWD(MoveClient);
WCBFWD(CellAttrNotNorm);
WCBFWD(AZCS007BUSChangeClientType);
WCBFWD(AZCS007BUSChangeServiceType);
WCBFWD(AZCS007BUSSetCLNTLITERALStatus);
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


short ClientElmntToRow(short ClientElmnt, CMN_ARCH_PARM_TYPES);
short ServiceElmntToRow(short ServiceElmnt, CMN_ARCH_PARM_TYPES);
short LoadClientElmnt(short ClientElmnt, CMN_ARCH_PARM_TYPES);
short LoadServiceElmnt(short ServiceElmnt, CMN_ARCH_PARM_TYPES);

SHORT CheckDataTypes( USHORT ClientIndex,
                      USHORT ServiceIndex,
                      USHORT ServiceNum,
                      CMN_ARCH_PARM_TYPES);
