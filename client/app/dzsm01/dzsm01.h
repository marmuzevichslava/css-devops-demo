/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : dzsm01.h
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : mconner
**
**  DATE CREATED     : 3/23/98
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    99/99/99  mconner              Original code.
**
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/


/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/
#ifndef DZSM001_FILE_PATH_LEN
#define DZSM001_FILE_PATH_LEN                          256
#endif
#ifndef DZSM001_APPL_NAME
#define DZSM001_APPL_NAME                              "CSS"
#endif
#ifndef DZSM001_PARMS_MAX_LEN
#define DZSM001_PARMS_MAX_LEN                          100
#endif
#ifndef DZSM001_FKEY_ID
#define DZSM001_FKEY_ID                               "Architecture"
#endif
#ifndef DZSM001_SLAM_INI_DIR_KEY
#define DZSM001_SLAM_INI_DIR_KEY                      "PMR ini Path and File"
#endif
#ifndef DZSM001_TOKEN_VALUE
#define DZSM001_TOKEN_VALUE                           10700
#endif
#ifndef DZSM001_PRG_ID
#define DZSM001_PRG_ID                                "DZSM01"
#endif 
#ifndef DZSM001_PC_NAME_LO_VALUE
#define DZSM001_PC_NAME_LO_VALUE                      "        "
#endif
#ifndef DZSM001_PC_NAME_HI_VALUE
#define DZSM001_PC_NAME_HI_VALUE                      "99999999"
#endif
#ifndef DZSM001_ENV_ID
#define DZSM001_ENV_ID                                "D1"
#endif
#ifndef DZSM001_SRVC_ID
#define DZSM001_SRVC_ID                               101
#endif
#ifndef DZSM001_LOW_DATE
#define DZSM001_LOW_DATE                             "0001-01-01"
#endif
#ifndef DZSM001_HI_DATE
#define DZSM001_HI_DATE                              "9999-12-31"
#endif
#ifndef DZSM001_LOW_TIME
#define DZSM001_LOW_TIME                             "00:00:01"
#endif
#ifndef DZSM001_HI_TIME
#define DZSM001_HI_TIME                              "23:59:59"
#endif
#ifndef DZSM001_ERR_DESCR_LEN
#define DZSM001_ERR_DESCR_LEN                        100
#endif
#ifndef DZSM001_TMP_HR_LEN
#define DZSM001_TMP_HR_LEN                           3
#endif
#ifndef DZSM001_TMP_MIN_LEN
#define DZSM001_TMP_MIN_LEN                          3
#endif
#ifndef APPL_ID
#define APPL_ID                                      1000 /* change for debug to 1000nnn where nnn = CAS id*/
#endif
#ifndef SRVC_ID
#define SRVC_ID                                      1000
#endif
#ifndef SRVC_VER
#define SRVC_VER                                     "01"
#endif
#ifndef MAP_NAME
#define MAP_NAME                                    "CU1040AM"
#endif
#ifndef MAP_VER
#define MAP_VER                                      "01"
#endif
#ifndef DZSM001_BEEP_FREQ
#define DZSM001_BEEP_FREQ                            1200
#endif
#ifndef DZSM001_BEEP_DURTN
#define DZSM001_BEEP_DURTN                            60
#endif
#ifndef DZSM001_MAX_ROWS
#define DZSM001_MAX_ROWS                             48
#endif
#ifndef DZSM001_VAL_LEN
#define DZSM001_VAL_LEN                              300
#endif
#ifndef DZSM001_KYUSERID_LO_VAL
#define DZSM001_KYUSERID_LO_VAL                     "        "
#endif
#ifndef DZSM001_KYUSERID_HI_VAL
#define DZSM001_KYUSERID_HI_VAL                     "99999999"
#endif
#ifndef DZSM001_IO_MOD_ID
#define DZSM001_IO_MOD_ID                           "CU1040A "
#endif
#ifndef DZSM001_ACS_CMD
#define DZSM001_ACS_CMD                             "F "
#endif
#ifndef DZSM001_IO_MOD_TYPE_ID
#define DZSM001_IO_MOD_TYPE_ID                      "CUCG001\n"
#endif
#ifndef DZSM001_RANG_QUAL
#define DZSM001_RANG_QUAL                           "GELE\n"
#endif
#ifndef DZSM001_HI_CHAR_VAL
#define DZSM001_HI_CHAR_VAL                         255
#endif




 


/***************************************************************************/
/* Global variables                                                        */
/***************************************************************************/
CHAR                  Dzsm001SLAMDatPathAndFile[DZSM001_FILE_PATH_LEN];


/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/




/***************************************************************************/
/* Forward declarations for Application Business Functions                 */
/***************************************************************************/


SHORT SlamReportError( CHAR *FileName,
                      SHORT Severity,
                      SHORT ErrorNumber,
                      CHAR *FunctionName,
                      CHAR *ErrorText );

WCBFWD( DZSM001BusPredisplay );
WCBFWD( DZSM001BusResetPbClick );
WCBFWD( DZSM001BusTypeQry );
WCBFWD( DZSM001BusFindPbClick );
