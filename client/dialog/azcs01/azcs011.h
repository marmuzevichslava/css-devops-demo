/* forward declarations for user defined functions */

WCBFWD (UserPredisplay);
WCBFWD (MoveLB1);
WCBFWD (MoveLB2);
WCBFWD (NewService);
WCBFWD(CreateRelationship);
WCBFWD(RemoveRelationship);
WCBFWD(CellAttrNormS);
WCBFWD(CellAttrNormC);
WCBFWD(AZCD001BusCellDataComplete);
WCBFWD(CellDataNotCompleteClient);
WCBFWD(CellDataNotCompleteService);
WCBFWD(SaveToBFCD);
WCBFWD(FillStatusRM);
WCBFWD(InitService);
WCBFWD(MoveService);
WCBFWD(InitClient);
WCBPROC(MoveClient);
WCBPROC(CellAttrNotNorm);
WCBPROC(ChangeClientType);
WCBPROC(ChangeServiceType);
WCBFWD(ClntLng);
WCBFWD(SrvLng);
WCBFWD(FillServiceLB);
WCBFWD(FillClientLB);
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


