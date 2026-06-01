/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : SWAT01B.H
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : KCHASE
**
**  DATE CREATED     : 03/28/95
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**   03/28/95  KCHASE                Original code.
**
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/

char GlobalMode[3];

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
/* defined for RB Mode Field Change Strcmp statements */
#define LT_Extract_Mode "01"
#define LT_Insert_Mode  "02"
#define LT_Ext_Ins_Mode "03"
#define LT_Export_Mode   "04"
#define LT_Import_Mode   "05"


#define LT_Acct_01      "01"
#define LT_Prem_02      "02"
#define LT_Bldg_03      "03"

#define LT_Acct_A         "A"
#define LT_Prem_P         "P"
#define LT_Bldg_B         "B"

#define Like_Str		 ""
#define NULL_STR         ""
#define EMPTY_STR        ""

#define Begin_Qt         ""
#define End_Qt           ""


/* Reference for Window Data - malloc in predisplay */
#define SWAT01B_WorkStorage     (_WindowData *) WCD_pWorkingStorageData


/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/
typedef struct __WindowData
{                                                                               
    USHORT  SWAT01AElbIndex;
} _WindowData;


/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/

/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/

WCBFWD( DZBA002BusCDRbAccessTypeFC )
WCBFWD( DZBA002BusKyBldgNoFC )
WCBFWD( DZBA002BusKyPremNoFC )
WCBFWD( Dzba002bustxusernmfc )


//WCBFWD( SWAT01ABusWindowPredisp )
//WCBFWD( SWAT01ABusWindowPredestroy )
//WCBFWD( SWAT01ABusKyPremNoFC)
//WCBFWD( SWAT01ABusKyBaFC)
//WCBFWD( SWAT01ABusKyBldgNoFC)
//WCBFWD( SWAT01ABusValidatePBClick )
//WCBFWD( SWAT01BBusCDRbAccessTypeFC )
//WCBFWD( SWAT01BBusOkPBClick )

