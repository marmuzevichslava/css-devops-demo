/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
#include <malloc.h>

WCBFWD (LdAZCS3O);
WCBFWD (UnLdAZCS3I);
WCBFWD (VerifyTranMap);
WCBFWD (ChkTranMap);
WCBFWD (AZCS003BusTranFldChg);

SHORT CsrMapRetrieveLayout( CHAR *EntityId, CHAR ClientLayoutFlag,
                            _LAYOUT_REC **ppLayoutRecTable,
                            USHORT *pNumberRows,
                            double *pVersionNumber,
                             CMN_ARCH_PARM_TYPES );

#define MAPGEN_ELBADD1_INST_NAME "Elb1AddRow"
#define MAPGEN_ELBCHG1_INST_NAME "Elb1ChangeRow"

#define CHANGE_ACTION "Change Service Information"
#define CHANGE_OBJECT_TYPE "CSR Request ID"

#define ADD_TITLE "Add Server/Service Information"

#ifndef LT_RequestTypeUP
#define LT_RequestTypeUP                    "2"
#endif


