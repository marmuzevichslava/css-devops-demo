/***************************************************************************
 *                                                                         *
 *                C   O S / 2   W I N D O W   F I L E                      *
 *                                                                         *
 *              Copyright (C) 1992, Andersen Consulting.                   *
 *                        All rights reserved.                             *
 *                                                                         *
 ***************************************************************************
 *                                                                         *
 *                      Module File for: DZIO010X                          *
 *                         Generated on: Wed Sep 13 14:01:27 1995          *
 *                                   by: IPEREZAR                          *
 *                                                                         *
 ***************************************************************************
 * You may need to define other constants depending on the APIs used       *
 * in your window.                                                         *
 ***************************************************************************/
#define CMN_ERR_ARCH_WRAP_FUNC FALSE
#define WINDOWNAME DZIO010

#define INCL_DOS
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
#include "dzio01b.gnb"


#define WESMAPNAME _DZIO010WesMap
#include "dzio010.wmp"

/***************************************************************************
 * CSS Architecture Global Header File                                     *
 ***************************************************************************/
#include <C1CEAB.H>

/***************************************************************************
 * Copybooks and Source Includes
 ***************************************************************************/



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
 * CSS Functional Header File                                              *
 ***************************************************************************/
#include <CSS.H>

/***************************************************************************
 * Window Header File                                                      *
 ***************************************************************************/
#include "dzio010.h"

/*************************************************************************** 
 * Application Window Identifiers, window control identifiers and the      *
 * window dispatch Tables.                                                 *
 ***************************************************************************/
#include "DZIO01.gnz"
#include "dzio010.gnh"
#include "dzio010.gnd"

/***************************************************************************
 * Callbacks                                                               *
 ***************************************************************************/
#include "dzio010.aex"
// #include "archhelp.cb"

#include "azdi0400.c"
#include "dzio010.bus"


#include "dzio010.src"


