/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
#define CMN_HIGH_VALUES_STR "HIGH-VALUES"
#define CMN_LOW_VALUES_STR  "LOW-VALUES"

WCBFWD (UnLdAZCS7I);
WCBFWD (MoveLB1);
WCBFWD (MoveLB2);
WCBFWD (NewService);
WCBFWD(CreateRelationship);
WCBFWD(RemoveRelationship);
WCBFWD(CellAttrNormS);
WCBFWD(CellAttrNormC);
WCBFWD(CellDataComplete);
WCBFWD(CellDataNotCompleteClient);
WCBFWD(CellDataNotCompleteService);
WCBFWD(SaveToBFCD);
WCBFWD(FillStatusLD);
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
