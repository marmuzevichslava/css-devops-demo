/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
WCBFWD (UnLdAZCS5I);
WCBFWD (MoveLB1);
WCBFWD (MoveLB2);
WCBFWD (NewService);
WCBFWD(CreateRelationship);
WCBFWD(RemoveRelationship);
WCBFWD(MoveService);
WCBFWD(MoveClient);
WCBFWD(CellDataComplete);
WCBFWD(CellDataNotCompleteClient);
WCBFWD(CellDataNotCompleteService);
WCBFWD(SaveToBFCD);
WCBFWD(FillStatusRD);
WCBFWD(InitClient);
WCBFWD(InitService);
WCBFWD(ClntLng);
WCBFWD(SrvLng);
WCBFWD(FillServiceLB);
WCBFWD(CellAttrNotNorm);
WCBFWD(FillClientLB);
WCBFWD(LookForClientName);
WCBFWD(LookForServiceName);
WCBFWD(Azcs005busrlb01elbpagedown);
WCBFWD(Azcs005busrlb01elbpageup);
WCBFWD(Azcs005busrlb02elbpagedown);
WCBFWD(Azcs005busrlb02elbpageup);

short ClientElmntToRow(short ClientElmnt, CMN_ARCH_PARM_TYPES);
short ServiceElmntToRow(short ServiceElmnt, CMN_ARCH_PARM_TYPES);
short LoadClientElmnt(short ClientElmnt, CMN_ARCH_PARM_TYPES);
short LoadServiceElmnt(short ServiceElmnt, CMN_ARCH_PARM_TYPES);
short FindClientMatch(CMN_ARCH_PARM_TYPES);
short FillLayoutLB(char *LBName,
                   _LAYOUT_REC *pLayout,
                   unsigned short NumRec,
                   enum LANGUAGE_TYPE Language,
                   CMN_ARCH_PARM_TYPES);

SHORT CheckDataTypes( USHORT ClientIndex,
                      USHORT ServiceIndex,
                      USHORT ServiceNum,
                      CMN_ARCH_PARM_TYPES);
