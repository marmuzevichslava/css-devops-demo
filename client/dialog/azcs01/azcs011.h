/*mdc 03/20/96 _WCD_DATA WCD has been added to _WCDAZCS011C typedef in azcs011c.h. */
/*                 This structure is not generated correctly by FCP and must be edited each time */
/*                  azc01 is generated. The drivers do not include malloc.h so it is included here. */

#include <malloc.h>

/* forward declarations for user defined functions */

WCBFWD(AZCS011BUSAboutMNClick);
WCBFWD (AZCS011BUSUserPredisplay);
WCBFWD (AZCS011BUSMoveLB1);
WCBFWD (AZCS011BUSMoveLB2);
WCBFWD (AZCS011BUSNewService);
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
WCBFWD(MoveClient);
WCBFWD(CellAttrNotNorm);
WCBFWD(AZCS011BUSChangeClientType);
WCBFWD(AZCS011BUSChangeServiceType);
WCBFWD(AZCS011BUSClntLng);
WCBFWD(AZCS011BUSSrvLng);
WCBFWD(FillServiceLB);
WCBFWD(AZCS011BUSFillClientLB);
WCBFWD(CellAttrNotNorm);
WCBFWD(DisableClientRows)
short FindClientMatch(CMN_ARCH_PARM_TYPES);
WCBFWD(LookForClientName);
WCBFWD(Azcs011busrlb01elbpagedown);
WCBFWD(Azcs011busrlb01elbpageup);
WCBFWD(Azcs011busrlb02elbpagedown);
WCBFWD(Azcs011busrlb02elbpageup);
WCBFWD(AZCS011BusCellDataComplete);
WCBFWD(ServiceDataComplete);

short ClientElmntToRow(short ClientElmnt, CMN_ARCH_PARM_TYPES);
short ServiceElmntToRow(short ServiceElmnt, CMN_ARCH_PARM_TYPES);
short LoadClientElmnt(short ClientElmnt, CMN_ARCH_PARM_TYPES);
short LoadServiceElmnt(short ServiceElmnt, CMN_ARCH_PARM_TYPES);

