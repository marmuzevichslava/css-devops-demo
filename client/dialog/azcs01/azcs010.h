/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Architecture Header File
**
**  FILENAME         : azcs010
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : MCONNER
**
**  DATE CREATED     : 01-08-96
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**	 01/08/96   mconner               added malloc.h
**   01/15/96   mconner               added help headers
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
/*mdc - 01-08-96 - added  include malloc here and removed from azcs00n.c
 */
#include <malloc.h>
#include "systcomm.hh"
#include "roadmap.hh"


/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
#define MAXSD 25
#ifndef ERROR_NO_MORE_FILES
#define ERROR_NO_MORE_FILES 18
#endif


/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/
WCBFWD(AZCS010BUSUserPredisplay);
WCBFWD(LdAZCS010O);
WCBFWD(AZCS010BUSInitLB);
WCBFWD(LdAZCS010O);