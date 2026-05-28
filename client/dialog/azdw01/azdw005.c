/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/

/***************************************************************************
 *                                                                         *
 *                C   O S / 2   W I N D O W   F I L E                      *
 *                                                                         *
 *              Copyright (C) 1992, Andersen Consulting.                   *
 *                        All rights reserved.                             *
 *                                                                         *
 ***************************************************************************
 *                                                                         *
 *                      Module File for: AZDW005                           *
 *                         Generated on: Wed Nov  3 14:43:36 1993          *
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
#define WINDOWNAME AZDW005
#define INCL_WIN
#define WINDOWMOD
#define INCL_DOS  /* CSC: 08/18/93 HAND EDIT */

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


#define WESMAPNAME _AZDW005WesMap
#include "azdw005.wmp"


/***************************************************************************
 * CSS Architecture Global Header File                                     *
 ***************************************************************************/
#include <C1CEAB.H>

/***************************************************************************
 * Copybooks
 ***************************************************************************/
#include "azdw005c.h"



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
#include "azdw005.h"

/***************************************************************************
 * Application Window Identifiers, window control identifiers and the      *
 * window dispatch Tables.                                                 *
 ***************************************************************************/
#include "AZDW01.gnz"
#include "azdw005.gnh"
#include "azdw005.gnd"

/***************************************************************************
 * Callbacks                                                               *
 ***************************************************************************/

#include "azdw005.aex"
#include "azdw005.src"

#include "azdw005.bus"
#include "azdi0400.c"
