/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : <CUffnnn>.H
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : XXXXXXXX
**
**  DATE CREATED     : 99/99/99
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    99/99/99  XXXXXXXX              Original code.
**
***************************************************************************/
 /* cwoods: added help files */
#include <systcomm.hh>
#include <roadmap.hh>

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/
#include "ATDW01.h"   /* Dialog level header file */

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/

WCBFWD( ATDW004BusOtherGui);

/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/

//---------------------------------------------------
//  S H E L L   I N S T R U C T I O N S
//
//  Uncomment and duplicate the following line for every
//  RAB-generated Application Validation function that has
//  been added to the <CUffnnn>.VLD file.
//
//  REMOVE THIS COMMENT BLOCK WHEN DONE.
//
//---------------------------------------------------


//---------------------------------------------------
//  S H E L L   I N S T R U C T I O N S
//
//  Uncomment and duplicate the following statement for every
//  application-defined Application Validation function that
//  has been added to the <CUffnnn>.VLD file.
//
//  REMOVE THIS COMMENT BLOCK WHEN DONE.
//
//---------------------------------------------------

//SHORT CUffnnnVldApplicationDefined( TYPE Parameter1,
//                                    TYPE Parameter2,
//                                    TYPE ParameterN,
//                                    CMN_ARCH_PARM_TYPES);


/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/
WCBFWD( ATDW004BusPredisplay );
SHORT ATDW004BusFillLB(CMN_ARCH_PARM_TYPES);

//---------------------------------------------------
//  S H E L L   I N S T R U C T I O N S
//
//  Uncomment and duplicate the following line for every
//  RAB-generated Application Business function that has
//  been added to the <CUffnnn>.BUS file.
//
//  REMOVE THIS COMMENT BLOCK WHEN DONE.
//
//---------------------------------------------------

//WCBFWD( CUffnnnBusControlEvent )

//---------------------------------------------------
//  S H E L L   I N S T R U C T I O N S
//
//  Uncomment and duplicate the following statement for every
//  application-defined Application Business function that
//  has been added to the <CUffnnn>.BUS file.
//
//  REMOVE THIS COMMENT BLOCK WHEN DONE.
//
//---------------------------------------------------

//SHORT CUffnnnBusApplicationDefined( TYPE Parameter1,
//                                    TYPE Parameter2,
//                                    TYPE ParameterN,
//                                    CMN_ARCH_PARM_TYPES);


/***************************************************************************/
/* Forward declarations for Architecture Exit Functions                    */
/***************************************************************************/

//---------------------------------------------------
//  S H E L L   I N S T R U C T I O N S
//
//  Uncomment and duplicate the following statement for every
//  application-defined Architecture Exit function that
//  has been added to the <CUffnnn>.AEX file.
//
//  REMOVE THIS COMMENT BLOCK WHEN DONE.
//
//---------------------------------------------------

//SHORT CUffnnnAexApplicationDefined( TYPE Parameter1,
//                                    TYPE Parameter2,
//                                    TYPE ParameterN,
//                                    CMN_ARCH_PARM_TYPES);
