/***************************************************************************
 *                                                                         *
 *           C   W I N D O W S    N T   W I N D O W   F I L E              *
 *                                                                         *
 *              Copyright (C) 1994, Andersen Consulting.                   *
 *                        All rights reserved.                             *
 *                                                                         *
 ***************************************************************************
 *                                                                         *
 *                      Module File for: ATDW001                           *
 *                         Generated on: Sun Aug 27 15:58:18 1995          *
 *                                   by: CWOODS                            *
 *                                                                         *
 ***************************************************************************
 * You may need to define other constants depending on the APIs used       *
 * in your window.                                                         *
 ***************************************************************************/
#define CMN_ERR_ARCH_WRAP_FUNC FALSE
#define WINDOWNAME ATDW001

#define INCL_DOS
#define INCL_WIN
#define WINDOWMOD

/***************************************************************************
 * FOUNDATION Data Structures And Common Functions                         *
 ***************************************************************************/
#define  FND_CF_INCL
#define  FND_CTCONV_INCL
#define  FND_EH_INCL
#define  FND_IM_INCL
#define  FND_PS_INCL
#define  FND_SD_INCL
#define  FND_ST_INCL
#define  FND_MS_INCL


#define WESMAPNAME _ATDW001WesMap

/***************************************************************************
 * User Supplied Definitions.                                              *
 ***************************************************************************/

/***************************************************************************
 * System Header Files                                                     *
 ***************************************************************************/
#include <windows.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <math.h>
#include <limits.h>
#include <float.h>

/*************************************************************************** 
 * Foundation Global Header File                                           *
 ***************************************************************************/
#include <kglxk000.h>

/***************************************************************************
 * Business Function Context Data Type Definition                          *
 ***************************************************************************/
#include "atdw01b.gnb"


/***************************************************************************
 * WESMap Header File                                                      *
 ***************************************************************************/
#include "atdw001.wmp"

/***************************************************************************
 * CSS Architecture Global Header File                                     *
 ***************************************************************************/
#include <C1CEAB.H>

/***************************************************************************
 * User Includes.                                                          *
 ***************************************************************************/

/***************************************************************************
 * Copybooks and Source Includes
 ***************************************************************************/



/***************************************************************************
 * Window Context Data
 ***************************************************************************/
#include "atdw001c.h"

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
#include "atdw001.h"

/*************************************************************************** 
 * Application Window Identifiers, window control identifiers and the      *
 * window dispatch Tables.                                                 *
 ***************************************************************************/
#include "ATDW01.gnz"
#include "atdw001.gnh"
#include "atdw001.gnd"

/***************************************************************************
 * Callbacks                                                               *
 ***************************************************************************/
#include "atdw001.aex"
#include "archhelp.cb"

#include "azdi0400.c"
#include "atdw001.bus"


#include "atdw001.src"
