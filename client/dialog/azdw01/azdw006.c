
/***************************************************************************
 *                                                                         *
 *                C   O S / 2   W I N D O W   F I L E                      *
 *                                                                         *
 *              Copyright (C) 1992, Andersen Consulting.                   *
 *                        All rights reserved.                             *
 *                                                                         *
 ***************************************************************************
 *                                                                         *
 *                      Module File for: AZDW006                           *
 *                         Generated on: Wed Nov  3 14:43:38 1993          *
 *                                   by: CCRAMPTO                          *
 *                                                                         *
 ***************************************************************************
 * You may need to                                                         *
 *   #define INCL_DOS                                                      *
 *   #define INCL_WIN                                                      *
 * or other constants depending on the APIs used                           *
 * in your window.                                                         *
 ***************************************************************************/

#define CMN_ERR_ARCH_WRAP_FUNC FALSE
#define WINDOWNAME AZDW006
#define INCL_WIN
#define WINDOWMOD

#include <os2.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <limits.h>
#include <float.h>

/***************************************************************************
 * FOUNDATION Data Structures And Common Functions                         *
 ***************************************************************************/
#define  FND_VERSION2
#define  FND_CD_INCL
#define  FND_CF_INCL
#define  FND_CTCONV_INCL
#define  FND_EH_INCL
#define  FND_IM_INCL
#define  FND_SD_INCL
#define  FND_PS_INCL
#define  FND_DD_INCL
#define  FND_OS_INCL
#define  FND_ST_INCL
#define  FND_MS_INCL



/*************************************************************************** 
 * Foundation Global Header File                                           *
 ***************************************************************************/
#include <kglzk000.h>

/***************************************************************************
 * Business Function Context Data Type Definition                          *
 ***************************************************************************/
#include "azdw01b.gnb"


#define WESMAPNAME _AZDW006WesMap
#include "azdw006.wmp"


/***************************************************************************
 * CSS Architecture Global Header File                                     *
 ***************************************************************************/
#include <C1CEAB.H>

/***************************************************************************
 * Copybooks
 ***************************************************************************/
#include "azdw006c.h"


/***************************************************************************
 * Window Context Data
 ***************************************************************************/
#if !defined(WINCONTEXTNAME)
#define WINCONTEXTNAME       void
#define FND_WINCONTEXT_LEN   0
#else
#define FND_WINCONTEXT_LEN   sizeof(WINCONTEXTNAME)
#endif

/***************************************************************************
 * CSS Architecture Global Header File                                     *
 ***************************************************************************/
#define INCL_C1CBASE
#define INCL_C1CCALLBACK
#include <C1C.H>

/***************************************************************************
 * Window Header File                                                      *
 ***************************************************************************/
#include "azdw006.h"

/***************************************************************************
 * Application Window Identifiers, window control identifiers and the      *
 * window dispatch Tables.                                                 *
 ***************************************************************************/
#include "AZDW01.gnz"
#include "azdw006.gnh"
#include "azdw006.gnd"

/***************************************************************************
 * Callbacks                                                               *
 ***************************************************************************/

#include "azdw006.aex"
#include "azdw006.src"
#include "azdw006.bus"
