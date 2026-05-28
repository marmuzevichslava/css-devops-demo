/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : DZLM001.H
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : IPEREZAR
**
**  DATE CREATED     : 10/21/96
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    10/21/96    IPEREZAR            Creation
**
**
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/


#define MSG_RET_SUCCESS "0"
#define MSG_RET_FAIL    "1"

#define LOCK_ELEMENT "L"
#define UNLOCK_ELEMENT "U"

#define DEFREPOS_CODE "1"

#define UNIVERSAL_CHAR '*'
#define LIKE_CHAR '%'

#define APPL_ID			9520
#define SRVC_ID			9520
#define SRVC_MAP		"DZLM001I"

#define SRVC_VER		"01"

#define LUW_APPL_ID		9520
#define LUW_SRVC_ID		9520
#define LUW_SRVC_MAP	"DZLM001I"

#define BoxMessageSize  100
#define BaseDecodeLength 21

#define CallocNumElems  1

#define LOCK_MSG_TEMPLATE "Object(s) locked: %d.\n Object(s) already locked: %d.\n Object(s) processed: %d."
                             

#define UNLOCK_MSG_TEMPLATE "Obj(s) unlocked: %d.\n Obj(s) allready unlocked: %d.\n Obj(s) processed: %d."
                             
#define ERROR_MSG_TEMPLATE  "Fatal Host Error. Locking transaction rolled back."

/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/
                 /*
WCBFWD( DZLM001XObjNmFldChg );


SHORT DZLM001XObjNmFldChg( pEventInfo,
                           pEAIA,
                           pBFCD,
                           pWesMap,
                           pWindContextData,
                           pABHI);


                   */

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
