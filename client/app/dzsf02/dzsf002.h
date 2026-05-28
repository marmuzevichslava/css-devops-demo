/*
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : DZSF002.H
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : EHEMMER
**
**  DATE CREATED     : 01/30/97
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    01/30/97  EHEMMER               Original code taken from the BUS File
**
**
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/

/***************************************************************************/
/* Application #defines                                                    */ 
/***************************************************************************/
#ifndef DZSF002_OUTPUT_FIELD
#define DZSF002_OUTPUT_FIELD        "OutputDir"
#endif
#ifndef DZSF002_CSR_DUMP_FIELD
#define DZSF002_CSR_DUMP_FIELD      "CsrDmpFile"
#endif
#ifndef DZSF002_DATA_FIELD
#define DZSF002_DATA_FIELD          "DataFile"
#endif
#ifndef DZSF002_START_FIELD
#define DZSF002_START_FIELD         "StartNum"
#endif
#ifndef DZSF002_FINISH_FIELD
#define DZSF002_FINISH_FIELD        "FinishNum"
#endif
#ifndef DZSF002_CLEAR_ALL_PB
#define DZSF002_CLEAR_ALL_PB        "ClearAllPB"
#endif
#ifndef DZSF002_GENERATE_PB
#define DZSF002_GENERATE_PB         "GeneratePB"
#endif
#ifndef DZSF002_DUPLICATE_CHK_BOX
#define DZSF002_DUPLICATE_CHK_BOX   "DupChk"
#endif
#ifndef DZSF002_APPL_NAME
#define DZSF002_APPL_NAME           "TABLoad"
#endif  
#ifndef DZSF002_ELEM_KEY_WORD
#define DZSF002_ELEM_KEY_WORD       "Element"
#endif

 
#ifndef DZSF002_ELEM_CFG_STR_NUM
#define DZSF002_ELEM_CFG_STR_NUM    50
#endif
#ifndef DZSF002_ELEM_CFG_STR_LEN
#define DZSF002_ELEM_CFG_STR_LEN    80
#endif
#ifndef DZSF002_ELEM_KEY_WORD_LEN  
#define DZSF002_ELEM_KEY_WORD_LEN   7
#endif
#ifndef DZSF002_NT_CARRIAGE_RTRN
#define DZSF002_NT_CARRIAGE_RTRN    "\n"
#endif
#ifndef DZSF002_TRAN_MAP_OFFSET
#define DZSF002_TRAN_MAP_OFFSET     128
#endif
#ifndef DZSF002_TRAN_ID_LEN
#define DZSF002_TRAN_ID_LEN         8
#endif
#ifndef DZSF002_DIALOG_OFFSET
#define DZSF002_DIALOG_OFFSET       14
#endif
#ifndef DZSF002_DIALOG_ID_LEN
#define DZSF002_DIALOG_ID_LEN       9
#endif
#ifndef DZSF002_OFFSET_KY_WORD_LEN
#define DZSF002_OFFSET_KY_WORD_LEN  6
#endif
#ifndef DZSF002_FORMAT_STR_LEN
#define DZSF002_FORMAT_STR_LEN      10
#endif


/*
** Numeric Constants
*/
#ifndef DZSF002_VALUE_LEN
#define DZSF002_VALUE_LEN                         125
#endif
#ifndef DZSF002_NAME_LEN
#define DZSF002_NAME_LEN                          50
#endif
#ifndef TABLOAD_FILENAME_LEN
#define TABLOAD_FILENAME_LEN                       150
#endif
#ifndef _PATH_LEN
#define _PATH_LEN                                  70
#endif
#ifndef CSR_DUMP_FILE_NAME_LEN                     
#define CSR_DUMP_FILE_NAME_LEN                     10
#endif
#ifndef DZSF002_DUP_CHK_BX_LEN
#define DZSF002_DUP_CHK_BX_LEN                     2
#endif
#ifndef DZSF002_FUNCTION_CODE_LEN
#define DZSF002_FUNCTION_CODE_LEN                   3
#endif
#ifndef DZSF002_MESSAGE_LEN
#define DZSF002_MESSAGE_LEN                        35000
#endif
#ifndef DZSF002_ELEM_NAME_LEN
#define DZSF002_ELEM_NAME_LEN                      50
#endif
#ifndef DZSF002_ELEM_VALUE_LEN
#define DZSF002_ELEM_VALUE_LEN                     80
#endif
#ifndef DZSF002_NUM_ELEMS_SCAN
#define DZSF002_NUM_ELEMS_SCAN                     5
#endif
#ifndef DZSF002_ERR_MSG_LEN
#define DZSF002_ERR_MSG_LEN                        80
#endif

/*
** Error messages
*/
#ifndef DZSF002_ERR_OUT_FILE_OPEN_FAIL_MSG
#define DZSF002_ERR_OUT_FILE_OPEN_FAIL_MSG       "TABLoad could not create an output file."
#endif
#ifndef DZSF002_GEN_COMPLETE_MSG
#define DZSF002_GEN_COMPLETE_MSG                 "Generation Complete."
#endif
#ifndef DZSF002_ERR_DATA_FILE_OPEN_FAIL_MSG
#define DZSF002_ERR_DATA_FILE_OPEN_FAIL_MSG      "TABLoad could not open the data file"
#endif  
#ifndef	DZSF002_ERR_CSR_DMP_OPEN_FAIL_MSG
#define DZSF002_ERR_CSR_DMP_OPEN_FAIL_MSG        "TABLoad could not open the CSR dump file."
#endif
#ifndef	DZSF002_ERR_START_GT_FINISH_MSG
#define DZSF002_ERR_START_GT_FINISH_MSG          "The Start must be less than the finish number."
#endif
#ifndef DZSF002_ERR_DAT_FILE_MSG
#define DZSF002_ERR_DAT_FILE_MSG                 "Tabload could not open c:\\data\\tabload.dat file."
#endif
#ifndef	DZSF002_ERR_MEM_ALLOC_MSG
#define DZSF002_ERR_MEM_ALLOC_MSG                "DZSF002: Memory allocation error."
#endif
#ifndef DZSF002_ERR_ID_NOT_FOUND
#define DZSF002_ERR_ID_NOT_FOUND                 "[%s][%s] was not found in TABLOAD.DAT."
#endif


/*tmp file for directory testing*/
#ifndef TABLOAD_TMP_FILE
#define TABLOAD_TMP_FILE                           "TABLOAD.TMP"
#endif


/* Directory Bases */
#ifndef DZSF002_ELEM_DATA_FILE
#define DZSF002_ELEM_DATA_FILE      "c:\\data\\TABLOAD.DAT"
#endif



/* Default Input Parameters */
#ifndef DZSF002_DEFAULT_START_NUMBER
#define DZSF002_DEFAULT_START_NUMBER    0
#endif
#ifndef DZSF002_DEFAULT_FINISH_NUMBER
#define DZSF002_DEFAULT_FINISH_NUMBER   500
#endif


/* Global Variables */  
SHORT 		NumCreated = 0;
CHAR        CSRDumpFile[CSR_DUMP_FILE_NAME_LEN] = "";


/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/


/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/



WCBFWD( DZSF002BusGeneratePBClk );
WCBFWD( DZSF002BusPreDestroy );
WCBFWD( DZSF002BusClearAllPBClk );
WCBFWD( DZSF002BusVerifyDir );
WCBFWD( DZSF002BusVerifyDataFile );
WCBFWD( DZSF002BusVerifyDumpFile );
WCBFWD( DZSF002BusAboutMnuClk );
WCBFWD( DZSF002BusWindowClose );

SHORT DZSF002GetElemCfg( CHAR ElemCfgStr[DZSF002_ELEM_CFG_STR_NUM][DZSF002_ELEM_CFG_STR_LEN], 
						CHAR * TramMapID,
						CHAR * DialogID,
						USHORT *NumElements,
						FILE *fp );

SHORT CsrGetPBAndMessage(  _MSG_PARM_BLOCK *pMsgPB,
                           BYTE **ppMessage,
						   CHAR *CSRDumpFilePathAndName);

VOID cdecl main(SHORT argc, CHAR *argv[]);
