/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
#define CMN_HIGH_VALUES_STR "HIGH-VALUES"
#define CMN_LOW_VALUES_STR  "LOW-VALUES"
#define CMN_MAPGEN_NAME "CSR Map Generator"

WCBFWD (UnLdAZCS4I);
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
WCBFWD(FillStatusCK);
WCBFWD(InitClient1);
WCBFWD(InitService1);
WCBFWD(ClntLng);
WCBFWD(SrvLng);
WCBFWD(FillClientLB);
WCBFWD(FillServiceLB);
WCBFWD(CellAttrNotNorm);
WCBFWD(MoveClient1);
WCBFWD(MoveService1);
WCBFWD(ChangeClientType);
WCBFWD(ChangeServiceType);
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
