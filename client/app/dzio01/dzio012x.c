/***************************************************************************
 *                                                                         *
 *            C  W I N D O W S   N T   W I N D O W   F I L E               *
 *                                                                         *
 *   (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
 *                                                                         *
 ***************************************************************************
 *                                                                         *
 *                      Module File for: DZIO012X TABLE JOINS              *
 *                         Generated on: Mon Nov 04 17:40:03 1996          *
 *                                   by: IPEREZAR                          *
 *                    Short Description:                                   *
 *                                                                         *
 ***************************************************************************
 * You may need to define other constants depending on the APIs used       *
 * in your window.                                                         *
 ***************************************************************************/

#define CMN_ERR_ARCH_WRAP_FUNC FALSE
#define WINDOWNAME DZIO012


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

#define WESMAPNAME _DZIO012WesMap

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
#include "dzio01b.gnb"


/***************************************************************************
 * CSS Architecture Global Header File                                     *
 ***************************************************************************/
#include <C1CEAB.H>

/***************************************************************************
 * Window Context Data
 ***************************************************************************/
#include "dzio012c.h"

#if !defined(WINCONTEXTNAME)
#define WINCONTEXTNAME       void
#define FND_WINCONTEXT_LEN   0
#else
#define FND_WINCONTEXT_LEN   sizeof(WINCONTEXTNAME)
#endif

/***************************************************************************
 * WESMap Header File                                                      *
 ***************************************************************************/
#include "dzio012.wmp"


/*************************************************************************** 
 * Application Window Identifiers, window control identifiers and the      *
 * window dispatch Tables.                                                 *
 ***************************************************************************/
#include "DZIO01.gnz"
#include "dzio012.gnh"
#include "dzio012.gnd"

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
#include "azrp001m.h"
#include "dzio012i.h"
#include "dzio012o.h"


/***************************************************************************
 * Window Header File                                                      *
 ***************************************************************************/
#include "dzio012.h"

/***************************************************************************
 * Callbacks                                                               *
 ***************************************************************************/
#include "dzio012.aex"
// #include "archhelp.cb"
#include "azdi0400.c"
#include "dzio012.bus"


#include "dzio012.src"
