/***************************************************************************
 *                                                                         *
 *           C   W I N D O W S    N T   W I N D O W   F I L E              *
 *                                                                         *
 *              Copyright (C) 1994, Andersen Consulting.                   *
 *                        All rights reserved.                             *
 *                                                                         *
 ***************************************************************************
 *                                                                         *
 *                      Module File for: AZCS014                           *
 *                         Generated on: Thu Mar 21 14:16:12 1996          *
 *                                   by: MCONNER                           *
 *                                                                         *
 ***************************************************************************
 * You may need to define other constants depending on the APIs used       *
 * in your window.                                                         *
 ***************************************************************************/
#define CMN_ERR_ARCH_WRAP_FUNC FALSE
#define WINDOWNAME AZCS014

#define INCL_DOS
#define INCL_WIN
#define WINDOWMOD

/***************************************************************************
 * FOUNDATION Data Structures And Common Functions                         *
 ***************************************************************************/
/*mdc 03/25/96 These #defines are from the working copy*/
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



/*mdc 
#define  FND_CF_INCL
#define  FND_CTCONV_INCL
#define  FND_EH_INCL
#define  FND_IM_INCL
#define  FND_PS_INCL
#define  FND_SD_INCL
#define  FND_ST_INCL
#define  FND_MS_INCL
*/

#define WESMAPNAME _AZCS014WesMap

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
#include "azcs01b.gnb"


/***************************************************************************
 * WESMap Header File                                                      *
 ***************************************************************************/
#include "azcs014.wmp"

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
#include "azcs014c.h"

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
/*mdc 03/21/96 not used
#include <CSS.H>
*/
/***************************************************************************
 * Window Header File                                                      *
 ***************************************************************************/
#include "azcs014.h"

/*************************************************************************** 
 * Application Window Identifiers, window control identifiers and the      *
 * window dispatch Tables.                                                 *
 ***************************************************************************/
#include "AZCS01.gnz"
#include "azcs014.gnh"
#include "azcs014.gnd"

/***************************************************************************
 * Callbacks                                                               *
 ***************************************************************************/
#include "azcs014.aex"
#include "archhelp.cb"

#include "azdi0400.c"
#include "azcs014.cb"


#include "azcs014.src"
