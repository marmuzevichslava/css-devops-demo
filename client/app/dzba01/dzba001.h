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

/* Report file path */
#define REPORT_FILE "C:\\DATA\\BAEXT.LOG"

#define LOG_HEADER  "\t\tBILL ACCOUNT EXTRACT ERROR LOG\n"
#define LOG_COLUMNS "\t Account Id \tTable \t\tJob Type     Sql Error \n"

/* defined for RB Mode Field Change Strcmp statements */
#define LT_Extract_Mode  "01"
#define LT_Insert_Mode   "02"
#define LT_Ext_Ins_Mode  "03"
#define LT_Export_Mode   "04"
#define LT_Import_Mode   "05"

/* Literals defining the CdAccessType */
#define LT_Acct_A         "A"
#define LT_Prem_P         "P"
#define LT_Bldg_B         "B"

/* Literals defining the Pass Order */
#define LT_First_Pass   "01"
#define LT_Second_Pass  "02"


#define MX_PART_ACCT_PROC   99999


/* Bad password literal */
#define NOCONN             "NOCONN"
#define NODATA             "NODATA"
#define NOFILE             "NOFILE"

#define BAD_DATA           "There are now rows to process."
#define BAD_EXT_PW         "Incorrect Password on Extraction Criteria."
#define BAD_INS_PW         "Incorrect Password on Insertion Criteria."
#define NO_DATA_FOUND      "Account Not Found."
#define NO_FILE_FOUND      "File name not found in directory."

#define BaseDecodeLength 21

/* Literal appearing on message box of Window 3 when no accounts are retrieved */
#define BAEXT_NO_ACCT     "No Accounts Found To Match Criteria"

/* lengths defined for instance name */
#define SWAT01A_KYEXTRACTNO_LEN 12

/* Reference for Window Data - malloc in predisplay */
#define SWAT01A_WorkStorage     (_WindowData *) WCD_pWorkingStorageData

/* This character appears on the password field when the user keys in */
#define AZSS001_PASSWORD_CHAR   '*'

/* Concatenation of password and target database */
#define AT_STRING "@"


/***************************************************************************/
/* Application global variables                                            */
/***************************************************************************/

USHORT NumberOfRows = 0;
USHORT RowQueryNumber = 0;

/* The following are an array of structures that hold all deleted items, and the
** index of that structure.
**/

BOOL   ChangeFlag = FALSE;

BOOL   DeleteFlag = FALSE;
BOOL   Continue = FALSE;

USHORT DeletedIndex = 0;

_ExtractInsertLBRow DeletedRows[NUMEXTRACTINSERTLBROWS];


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


/***************************************************************************/
/* Application global variables                                            */
/***************************************************************************/

FILE *LogFile;

const unsigned short TableCountLimit = 500;
char NullString[] = "";

