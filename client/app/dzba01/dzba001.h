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

#define MX_PART_ACCT_PROC   99999


/* Bad password literal */
#define NOCONN             "NOCONN"

#define BAD_EXT_PW         "Incorrect Password on Extraction Criteria"
#define BAD_INS_PW         "Incorrect Password on Inserion Criteria"



/* Literal appearing on message box of Window 3 when no accounts are retrieved */
#define BAEXT_NO_ACCT     "No Accounts Found To Match Criteria"

/* lengths defined for instance name */
#define SWAT01A_KYEXTRACTNO_LEN 12

/* Reference for Window Data - malloc in predisplay */
#define SWAT01A_WorkStorage     (_WindowData *) WCD_pWorkingStorageData

/* This character appears on the password field when the user keys in */
#define AZSS001_PASSWORD_CHAR   '*'

/***************************************************************************/
/* Application global variables                                            */
/***************************************************************************/

// This clobal character array will hold the Extract Database Password
CHAR GlobalHoldPassword[TXEXTRACTPSSWDID_LEN];

// This clobal character array will hold the Insert Database Password
CHAR GlobalHoldPasswordB[TXEXTRACTPSSWDID_LEN];

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
WCBFWD( DZBA001VldCDExtInsFC )
WCBFWD( DZBA001BusProcessMNEnable )

//WCBFWD( SWAT01AVldExtDbFC )
//WCBFWD( SWAT01AVldInsDbFC)
//WCBFWD( SWAT01AVldExtOwnerFC )
//WCBFWD( SWAT01AVldInsOwnerFC )
//WCBFWD( SWAT01AVldExtPasswdFC )
//WCBFWD( SWAT01AVldInsPasswdFC )
//WCBFWD( SWAT01AVldUserNmFC )

/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/


//WCBFWD( SWAT01ABusWindowPredisp )
//WCBFWD( SWAT01ABusWindowPredestroy )
//WCBFWD( SWAT01ABusLBSelect)
//WCBFWD( SWAT01ABusProcessMNClick )

