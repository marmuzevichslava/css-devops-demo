/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : CUffnnn.H
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : CWOODS  
**
**  DATE CREATED     : 99/99/99
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    99/99/99  XXXXXXXXX             Original code.
**
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/

/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/

WCBFWD( CUffnnnVld<MLBEntryFieldName>FC )


/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/

WCBFWD( CUffnnnBus<MLBListBoxName>Sel )
WCBFWD( CUffnnnBus<EnterPBName>Click )
WCBFWD( CUffnnnBusResetClick )
WCBFWD( CUffnnnBusOkClick )

/***************************************************************************/
/* Forward declarations for Architecture Exit Functions                    */
/***************************************************************************/

SHORT CUffnnnVldMLBEntryFieldChange( CMN_ARCH_PARM_TYPES);

SHORT CUffnnnBusDisableMLB( CMN_ARCH_PARM_TYPES);
