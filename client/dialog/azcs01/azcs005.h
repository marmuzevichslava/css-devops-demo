/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/**mdc 03/20/96 Added _WCD_DATA to _WCDAZCS005C in azcs005c.h.  This structure is  */
/*                  not generated correctly by FCP and must be edited each time azcs01 is */
/*                  generated. The drivers do not include malloc.h so it is included here. */
/*                  csrcmn.h and mapgen.h are hand added to azcs01b.gnb for similar reasons. */


#include <malloc.h>
WCBFWD(AZCS005BUSAboutMNClick);
WCBFWD (UnLdAZCS5I);
WCBFWD (AZCS005BUSMoveLB1);
WCBFWD (AZCS005BUSMoveLB2);
WCBFWD (AZCS005BUSNewService);
WCBFWD(AZCS005BUSCreateRelationship);
WCBFWD(AZCS005BUSRemoveRelationship);
WCBFWD(MoveService);
WCBFWD(MoveClient);
WCBFWD(CellDataComplete);
WCBFWD(CellDataNotCompleteClient);
WCBFWD(CellDataNotCompleteService);
WCBFWD(AZCS005BUSSaveToBFCD);
WCBFWD(FillStatusRD);
WCBFWD(InitClient);
WCBFWD(InitService);
WCBFWD(AZCS005BUSClntLng);
WCBFWD(AZCS005BUSSrvLng);
WCBFWD(FillServiceLB);
WCBFWD(CellAttrNotNorm);
WCBFWD(AZCS005BUSFillClientLB);
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
