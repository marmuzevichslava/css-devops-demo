/***************************************************************************
 *                                                                         *
 *            C  W I N D O W S   N T   W I N D O W   F I L E               *
 *                                                                         *
 *   (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
 *                                                                         *
 ***************************************************************************
 *                                                                         *
 *                      Module File for: AZRP002X                          *
 *                         Generated on: Fri Jul 12 15:55:18 1996          *
 *                                   by: MCONNER                           *
 *                    Short Description:                                   *
 *                                                                         *
 ***************************************************************************
 * You may need to define other constants depending on the APIs used       *
 * in your window.                                                         *
 ***************************************************************************/

#define CMN_ERR_ARCH_WRAP_FUNC FALSE
#define WINDOWNAME AZRP002


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

#define WESMAPNAME _AZRP002WesMap

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
#define _BFCD            void
#define FND_BFCD_SIZE    0

/***************************************************************************
 * CSS Architecture Global Header File                                     *
 ***************************************************************************/
#include <C1CEAB.H>

/***************************************************************************
 * Window Context Data
 ***************************************************************************/
#include "azrp002c.h"

#if !defined(WINCONTEXTNAME)
#define WINCONTEXTNAME       void
#define FND_WINCONTEXT_LEN   0
#else
#define FND_WINCONTEXT_LEN   sizeof(WINCONTEXTNAME)
#endif

/***************************************************************************
 * WESMap Header File                                                      *
 ***************************************************************************/
#include "azrp002.wmp"


/*************************************************************************** 
 * Application Window Identifiers, window control identifiers and the      *
 * window dispatch Tables.                                                 *
 ***************************************************************************/
#include "AZRP02.gnz"
#include "azrp002.gnh"
#include "azrp002.gnd"

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
 * User Includes.                                                          *
 ***************************************************************************/

/***************************************************************************
 * Copybooks and Source Includes
 ***************************************************************************/
#include "azrp002o.h"


/***************************************************************************
 * Window Header File                                                      *
 ***************************************************************************/
#include "azrp002.h"

/***************************************************************************
 * Callbacks                                                               *
 ***************************************************************************/
#include "azrp002.aex"
#include "archhelp.cb"
#include "azdi0400.c"
#include "azrp002.bus"


#include "azrp002.src"
