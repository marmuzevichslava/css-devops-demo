/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*mdc 03/20/96 _WCD_DATA WCD has been added to _WCDAZCS010C typedef in azcs010c.h. */
/*                 This structure is not generated correctly by FCP and must be edited each time */
/*                  azc01 is generated. The drivers do not include malloc.h so it is included here. */

#include <malloc.h>

WCBFWD(AZCS010BUSUserPredisplay);
WCBFWD(AZCS010BUSInitLB);
WCBFWD(LdAZCS010O);

#define MAXSD 25
#define ERROR_NO_MORE_FILES 18
