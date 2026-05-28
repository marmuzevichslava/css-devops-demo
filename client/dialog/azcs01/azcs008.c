/***************************************************************************
 *                                                                         *
 *            C  W I N D O W S   N T   W I N D O W   F I L E               *
 *                                                                         *
 *   (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
 *                                                                         *
 ***************************************************************************
 *                                                                         *
 *                      Module File for: AZCS008                           *
 *                         Generated on: Mon Jul 15 06:51:10 1996          *
 *                                   by: MCONNER                           *
 *                    Short Description:                                   *
 *                                                                         *
 ***************************************************************************
 * You may need to define other constants depending on the APIs used       *
 * in your window.                                                         *
 ***************************************************************************/

#define CMN_ERR_ARCH_WRAP_FUNC FALSE
#define WINDOWNAME AZCS008


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

#define WESMAPNAME _AZCS008WesMap

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
 * CSS Architecture Global Header File                                     *
 ***************************************************************************/
#include <C1CEAB.H>

/***************************************************************************
 * Window Context Data
 ***************************************************************************/
#include "azcs008c.h"

#if !defined(WINCONTEXTNAME)
#define WINCONTEXTNAME       void
#define FND_WINCONTEXT_LEN   0
#else
#define FND_WINCONTEXT_LEN   sizeof(WINCONTEXTNAME)
#endif

/***************************************************************************
 * WESMap Header File                                                      *
 ***************************************************************************/
#include "azcs008.wmp"


/*************************************************************************** 
 * Application Window Identifiers, window control identifiers and the      *
 * window dispatch Tables.                                                 *
 ***************************************************************************/
#include "AZCS01.gnz"
#include "azcs008.gnh"
#include "azcs008.gnd"

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
#include "azcs010o.h"


/***************************************************************************
 * Window Header File                                                      *
 ***************************************************************************/
#include "azcs008.h"

/***************************************************************************
 * Callbacks                                                               *
 ***************************************************************************/
#include "azcs008.aex"
#include "archhelp.cb"
#include "azcs008.cb"
#include "azdi0400.c"


#include "azcs008.src"
