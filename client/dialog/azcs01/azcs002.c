/***************************************************************************
 *                                                                         *
 *           C   W I N D O W S    N T   W I N D O W   F I L E              *
 *                                                                         *
 *              Copyright (C) 1994, Andersen Consulting.                   *
 *                        All rights reserved.                             *
 *                                                                         *
 ***************************************************************************
 *                                                                         *
 *                      Module File for: AZCS002                           *
 *                         Generated on: Thu Mar 21 14:16:12 1996          *
 *                                   by: MCONNER                           *
 *                                                                         *
 ***************************************************************************
 * You may need to define other constants depending on the APIs used       *
 * in your window.                                                         *
 ***************************************************************************/
#define CMN_ERR_ARCH_WRAP_FUNC FALSE
#define WINDOWNAME AZCS002

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


#define WESMAPNAME _AZCS002WesMap

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
#include "azcs002.wmp"

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
#include "azcs002o.h"



/***************************************************************************
 * Window Context Data
 ***************************************************************************/
#include "azcs002c.h"

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
/*mdc 03/21/96 not needed
#include <CSS.H>
*/
/***************************************************************************
 * Window Header File                                                      *
 ***************************************************************************/
#include "azcs002.h"

/*************************************************************************** 
 * Application Window Identifiers, window control identifiers and the      *
 * window dispatch Tables.                                                 *
 ***************************************************************************/
#include "AZCS01.gnz"
#include "azcs002.gnh"
#include "azcs002.gnd"

/***************************************************************************
 * Callbacks                                                               *
 ***************************************************************************/
#include "azcs002.aex"
#include "archhelp.cb"

#include "azdi0400.c"
#include "azcs002.cb"


#include "azcs002.src"
