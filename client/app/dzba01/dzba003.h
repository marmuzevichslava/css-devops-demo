/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : SWAT01A.H
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

#define BAEXT_NO_ACCT     "No Accounts Found To Match Criteria."

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
/* defined for RB Mode Field Change Strcmp statements */
#define LT_Extract_Mode  "01"
#define LT_Insert_Mode   "02"
#define LT_Ext_Ins_Mode  "03"

/* Literals defining the CdAccessType */
#define LT_Acct_A         "A"
#define LT_Prem_P         "P"
#define LT_Bldg_B         "B"

#define NULL_STR         ""

#define StartRowNum       0
#define MX_PART_ACCT_PROC   99999

/* lengths defined for instance name */
#define SWAT01A_KYEXTRACTNO_LEN 12
#define STS_BAVALID     'F'

/* Reference for Window Data - malloc in predisplay */
#define SWAT01A_WorkStorage     (_WindowData *) WCD_pWorkingStorageData


/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/
typedef struct __WindowData
{   
	USHORT  LastExtByteValue;
	USHORT  LastInsByteValue;
	CHAR    ExtractPassword[31];
	CHAR    InsertPassword[31];
	                                                                    
    USHORT  SWAT01AElbIndex;
    USHORT  SWAT01AOutputIndex;
} _WindowData;


/***************************************************************************/
/* Forward declarations for Application Validation Functions               */
/***************************************************************************/
WCBFWD( SWAT01AVldCDExtInsFC )
WCBFWD( SWAT01AVldExtDbFC )
WCBFWD( SWAT01AVldInsDbFC)
WCBFWD( SWAT01AVldExtOwnerFC )
WCBFWD( SWAT01AVldInsOwnerFC )
WCBFWD( SWAT01AVldExtPasswdFC )
WCBFWD( SWAT01AVldInsPasswdFC )
WCBFWD( SWAT01AVldUserNmFC )

/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/


WCBFWD( SWAT01ABusWindowPredisp )
WCBFWD( SWAT01ABusWindowPredestroy )
WCBFWD( SWAT01ABusLBSelect)
WCBFWD( SWAT01ABusProcessMNClick )

