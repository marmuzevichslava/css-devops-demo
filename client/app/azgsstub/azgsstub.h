/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
***************************************************************************/
/***************************************************************************
**
**               CUSTOMER/1 Cooperative Architecture Module
**
** FILENAME         :  AZGS03.H
**
** DESCRIPTION      :  Header file for the Application Gateway Server
**                     helper function
**
** REVISION HISTORY
**
** DATE        REVISED BY  SIR #   DESCRIPTION OF CHANGE
** --------    ----------  ------  ---------------------------------------
** 05/07/97    B Lucas             creation.
**
** 02/19/98    B Lucas             changed HPUX defines to UNIX
**
***************************************************************************/

/**************************************************************************
/*
/* UNIX SYSTEM SPECIFIC SECTION
/*
/*************************************************************************/
#ifdef UNIX
 
 /* unix defines */
 #define CMN_SUCCESS  0

#endif

/**************************************************************************
/*
/* WIN32 SYSTEM SPECIFIC SECTION
/*
/*************************************************************************/
#ifdef WIN32

 #define FND_WIN32

 /* win32 includes */
 #include <windows.h>

#endif

/**************************************************************************
/*
/* COMMON SECTION FOR ALL OPERATING SYSTEMS
/*
/*************************************************************************/

/* standard includes */
#include <stdio.h>
#include <malloc.h>
#include <string.h>

/* azgs03 includes */
#include "tcppipe.h"
#include "azgscmn.h"

