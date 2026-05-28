#if !defined(DTA_TAEM001_H)
#define DTA_TAEM001_H
/***************************************************************************/
/*                            ISCOR NEWCASTLE                              */
/*                       COMMON MODULE INCLUDE FILE                        */
/*                                                                         */
/* Subsystem       : Technical Architecture                                */
/* Component       : Error message numbers                                 */
/*                                                                         */
/* File Name       : TAEM001.H                                             */
/*                                                                         */
/* Author          : Andersen Consulting                                   */
/* Date Written    : 30/05/94                                              */
/*                                                                         */
/* Description     : This file contains error message number for TA modules*/
/*                                                                         */
/* Revision History:                                                       */
/*                                                                         */
/* Date     Revised By  Description                                        */
/* ----     ----------  ------------                                       */
/* 21/07/1994   OT      ETA_DB_COMMIT_ERR, ETA_DB_ROLLBACK_ERR             */
/*                      ETA_KEY_NOT_FOUND, ETA_CDT_UNKNOWN_ERR added       */
/* 03/08/1994   DG      ETA_SEGMENT_OVERLAP_ERR added                      */
/* 10/08/1994   DG      ETA_NO_SCRTY_FOUND_ERR added                       */
/* 18/08/1994   OT      ETA_SVC_NOT_LOCAL added                            */
/* 24/08/1994   PB                                                         */
/* 24/08/1994   IR      ETA_NO_TBL_NAME_PASS                               */
/* 08/09/1994   PB      ETA_DLVR_ADDR_CYBER                                */
/* 14/09/1994   MCV     ETA_PM_HDCPRT_ERR, ETA_PM_NOPRT_ERR                */
/*                      ETA_PM_GENPRT_ERR, ETA_PM_ABORTED_ERR added        */
/* 17/10/1994   MGR     ETA_DECODE_NOT_FOUND added                         */
/* 20/10/1994	MGR	ETA_PM_FONT_ERROR added 			   */
/*									   */
/***************************************************************************/
/***************************************************************************/
/* Constants (#DEFINE)                                                     */
/***************************************************************************/
/***************************************************************************/
/* ERRORS, Range: 0                                                        */
/***************************************************************************/
#define ITA_SUCCESS         0    /* Success */


/***************************************************************************/
/* ERRORS, Range: -1 - -5000                                               */
/***************************************************************************/
/***************************************************************************/
/* ERRORS, Range: -1 - -50                                                 */
/***************************************************************************/
/* Database Errors */

#define WTA_DB_STARTED_WRN   -1   /* Database system already started */
#define WTA_DB_WARNING_WRN   -2   /* Database warning detected. Operation might have failed. */
#define ETA_DB_START_ERR     -3   /* Failed to start database system */
#define ETA_DB_STOP_ERR      -4   /* Failed to stop the database system */
#define ETA_DB_OPEN_ERR      -5   /* Failed to open database */
#define ETA_DB_CLOSE_ERR     -6   /* Failed to close database */
#define ETA_DB_SQL_ERR       -7   /* Database operation resulted in an error */
#define ETA_DB_COMMIT_ERR    -8   /* Database commit resulted in an error */
#define ETA_DB_ROLLBACK_ERR  -9   /* Database rollback resulted in an error */
#define ETA_SL_NOT_FOUND     -10  /* Shared Library not found */
#define ETA_CUR_OPEN_ERR     -11  /* Open cursor failed */
#define ETA_CUR_CLOSE_ERR    -12  /* Close cursor failed */
#define ETA_CUR_DECLARE_ERR  -13  /* Fetch cursor failed */

/***************************************************************************/
/* ERRORS, Range: -51 - -100                                               */
/***************************************************************************/
/* Communication Errors for messaging */

#define ETA_COM_SEND_ERR         -51   /* Failed to send asynchronous message */
#define ETA_COM_INIT_ERR         -52   /* Failed to initialize message for sending */
#define ETA_COM_ROUTE_ERR        -53   /* Failed to route incoming message to correct window */
#define ETA_COM_TRANS_ERR        -54   /* No translation map avaiable */
#define ETA_COM_NO_SVC_DATA_RECV -55   /* No data received from service */

/***************************************************************************/
/* ERRORS, Range: -101 - -149                                              */
/***************************************************************************/
/* Codes Table Errors */
#define ETA_DECODE_TOO_LONG      -101   /* Error occurred while reading decode */
#define ETA_KEY_TOO_LONG         -102   /* Key length specified too short */
#define ETA_TOO_MANY_ENTRIES     -103   /* Decode table &&|| Key Table length specified is too short*/
#define ETA_TABLE_NOT_FOUND      -104   /* Codes Table name specified does not exist*/
#define ETA_KEY_NOT_FOUND        -105   /* Codes Table key does not exist exist */
#define ETA_CDT_UNKNOWN_ERR      -106   /* Unknown Codes Table error occured */
#define ETA_CDE_ALREADY_XST      -107
#define ETA_INVALID_CDE_LNGTH    -108
#define ETA_INVALID_DESC_LNGTH   -109
#define ETA_CODE_DELETE_ERR      -110   /* Deletion of entries off codes tables failed */
#define ETA_CODE_INSERT_ERR      -111   /* Insertion of entry onto codes table failed */
#define ETA_NO_TBL_NAME_PASS     -112   /* Codes table name not passed to window */
#define ETA_CANNOT_OPEN          -113   /* Could not open the codes tables. */
#define ETA_CANNOT_CLOSE         -114   /* Could not close the codes tables. */
#define ETA_DECODE_NOT_FOUND     -115   /* Codes Table decode does not exist */

/***************************************************************************/
/* ERRORS, Range: -150 - -249                                              */
/***************************************************************************/
/* Communication Errors */

#define ETA_FILE_OPEN_ERR           -150
#define ETA_INVALID_ACCESS_MODE     -151
#define ETA_FILE_DOES_NOT_EXIST     -152
#define ETA_FILE_READ_ERR           -153
#define ETA_BUFFER_SIZE_ERR         -154
#define ETA_INSUFFICIENT_MEMORY     -155
#define ETA_ENVAR_NOT_FOUND         -156
#define ETA_UNIQUE_NAME_ERR         -157
#define ETA_FILE_WRITE_ERR          -158
#define ETA_DIR_DOES_NOT_XST        -159
#define ETA_SEGMENT_OVERLAP_ERR     -160

/***************************************************************************/
/* ERRORS, Range: -250 - -299                                              */
/***************************************************************************/
/* Window Handling Errors */

#define ETA_WIN_OPEN_ERR               -250   /* Failed to open window */
#define ETA_WIN_MEM_ERR                -251   /* Failed to allocate memory */
#define ETA_WIN_CLOSE_ERR              -252   /* Error occurred when closing window. */
#define ETA_WIN_EXIT_APPL_INF          -253   /* Do you want to exit the application ? */
#define ETA_WIN_MSG_DISPLAY_ERR        -254   /* Error displaying message box. See dependent error message */
#define ETA_WIN_DISABLE_TIMEOUT        -255   /* Window is enabled due to timeout */
#define ETA_OS_HWND_NOT_FOUND          -256   /* The specified window title does not exist */
#define ETA_WIN_INIT_ERR               -257
#define ETA_WIN_ENABLE_ERR             -258
#define ETA_WIN_DISABLE_ERR            -259
#define ETA_WIN_MALLOC_ERR             -260
#define ETA_WIN_NUMROWS_ERR            -261
#define ETA_WIN_SEND_ERR               -262
#define ETA_NO_WIN_HAND_PASS_TO_WIN    -263

/***************************************************************************/
/* ERRORS, Range: -300 - -399                                              */
/***************************************************************************/
/* General Errors */

#define ETA_UNDEFINED_ERROR_NUMBER    -300
#define ETA_INVALID_SEVERITY_CODE     -301
#define ETA_INVALID_ERR_LOG_FILE      -302
#define ITA_INVALID_DATE_SEQ          -303
#define ITA_NO_REC_FOUND              -304
#define ETA_BATCH_ERR                 -305
#define ETA_NO_SCRTY_FOUND_ERR        -306
#define ETA_INVALID_ARGUMENTS         -307  /* Invalid command line arguments passed to prog */
#define ETA_FAILURE                   -308  /* General failure */

/***************************************************************************/
/* ERRORS, Range: -400 - -499                                              */
/***************************************************************************/
/* Change log */

#define ETA_CL_INVALID_INPUT         -400
#define ETA_CL_CREATE_FAILED         -401
#define ITA_CL_NO_CHG_LOGGED         -402
#define ETA_CL_MAX_NO_ATTR_REACHED   -403
#define ETA_CL_NO_DTL                -404

/***************************************************************************/
/* ERRORS, Range: -500 - -549                                              */
/***************************************************************************/
/* Service Component */

#define ETA_SVC_SL_NOT_FOUND         -500    /* Shared library not found */
#define ETA_SVC_NOT_LOCAL            -501    /* Service not local */

/***************************************************************************/
/* ERRORS, Range: -550 - -599                                              */
/***************************************************************************/
/* Security Component */

#define ETA_SCRTY_INIT_ERR           -550    /* Creation of Scrty BFCD pointer Failed */
#define ETA_SCRTY_TERM_ERR           -551    /* Freeing of Scrty BFCD pointer Failed */
#define ETA_SCRTY_VERF_ERR           -552    /* Server access denied       */
#define ETA_UNIX_ENCODE_KEY_ERR      -553    /* Encode Key not found */
#define ETA_SCRTY_FILE_UNIX_ERR      -554    /* Oracle Security file not found */
#define ETA_SCRTY_LOGIN_FAILED       -555    /* Login to oracle failed */
#define ETA_SCRTY_USER_COMB_ERR      -556    /* User combination invalid */

/***************************************************************************/
/* ERRORS, Range: -600 - -649                                              */
/***************************************************************************/
/* Interface errors */
#define ETA_DLVR_ADDR_CYBER           -600 /* Unable to create file for CYBER */

/***************************************************************************/
/* ERRORS, Range: -650 - -699                                              */
/***************************************************************************/
/* Print Manager errors */
#define ETA_PM_HDCPRT_ERR           -650 /* No Device Context available for printer */
#define ETA_PM_NOPRT_ERR            -651 /* No lines found in file */
#define ETA_PM_GENPRT_ERR           -652 /* General print error */
#define ETA_PM_ABORTED_ERR          -653 /* Print Job aborted */
#define ETA_PM_FONT_ERR             -654 /* Illegal font size specified, using default */

/***************************************************************************/
/* ERRORS, Range: -1000 - -1500                                            */
/***************************************************************************/
/* APPC & Adabas */
#define ETA_ADA_NORMAL_ERR     -1000  /* Normal successful completion      */
#define ETA_ADA_ISNNS_ERR      -1001  /* ISN list not sorted         */
#define ETA_ADA_FNCMP_ERR      -1002  /* Function not completely executed  */
#define ETA_ADA_EOF_ERR        -1003  /* End of file            */
#define ETA_ADA_OPREQ_ERR      -1004  /* Open command is mandatory      */
#define ETA_ADA_TABT_ERR       -1009  /* Transaction aborted         */
#define ETA_ADA_TWORECS_ERR    -1011  /* Two ADARECs running in parallel   */
#define ETA_ADA_INFIN_ERR      -1017  /* Invalid or unauthorized file
                                         number                            */
#define ETA_ADA_FICHA_ERR      -1018  /* File number changed during command
                                         sequence                          */
#define ETA_ADA_ACCUS_ERR      -1019  /* Command not allowed for ACC user  */
#define ETA_ADA_INCID_ERR      -1020  /* Invalid Command Identification
                                         (CID) value                       */
#define ETA_ADA_IUCID_ERR      -1021  /* Inconsistent usage of a Command
                                         Identification (CID) value        */
#define ETA_ADA_CMDINV_ERR     -1022  /* Invalid command code              */
#define ETA_ADA_ISNSV_ERR      -1023  /* Invalid ISN starting value for
                                         L2/L5                             */
#define ETA_ADA_BUISN_ERR      -1024  /* Invalid ISN found in ISN-buffer   */
#define ETA_ADA_ISNLL_ERR      -1025  /* ISN specified in ISN-LL for
                                         subsequent S1/S2 not found        */
#define ETA_ADA_BLISN_ERR      -1026  /* Invalid ISN-buffer length or
                                         invalid ISN-Quantity              */
#define ETA_ADA_IADD1_ERR      -1028  /* Invalid ADDITION-1 contents for
                                         L3/L6/S9                          */
#define ETA_ADA_MVOPT_ERR      -1029  /* Missing V-option during forced
                                         value start during L3/L6          */
#define ETA_ADA_SYNTX_ERR      -1040  /* Syntax error in Format buffer     */
#define ETA_ADA_ERFBU_ERR      -1041  /* Error in Format buffer            */
#define ETA_ADA_FBUTL_ERR      -1042  /* Format buffer too long            */
#define ETA_ADA_DESDE_ERR      -1043  /* Inconsistent Descriptor definition
                                         for L9                            */
#define ETA_ADA_FBUSU_ERR      -1044  /* Format buffer cannot be used for
                                         update                            */
#define ETA_ADA_FCOVL_ERR      -1045  /* Field count for PE or MU overflowed
                                         when using N-option for update    */
#define ETA_ADA_MISFB_ERR      -1046  /* Mismatch of format buffer usage
                                         for supplied command ID           */
#define ETA_ADA_FUNAV_ERR      -1048  /* File(s) / Userid  not available
                                         at Open time                      */
#define ETA_ADA_CORTL_ERR      -1049  /* Compressed record too long        */
#define ETA_ADA_SYRBO_ERR      -1050  /* Syntax error in Record buffer for
                                         open                              */
#define ETA_ADA_INVRB_ERR      -1051  /* Invalid Record buffer contents
                                         during Open                       */
#define ETA_ADA_DRBVB_ERR      -1052  /* Invalid data in Record buffer or
                                         Value   buffer                     */
#define ETA_ADA_RBTS_ERR       -1053  /* Record buffer too short           */
#define ETA_ADA_RBTL_ERR       -1054  /* Record buffer too long for C3,C5,
                                         ET                                */
#define ETA_ADA_IFCTE_ERR      -1055  /* Incompatible format conversion or
                                         truncation error                  */
#define ETA_ADA_DEVTL_ERR      -1056  /* Descriptor value too long         */
#define ETA_ADA_DSPEC_ERR      -1057  /* Unknown Descriptor specification
                                         in Search buffer for L9           */
#define ETA_ADA_RNODE_ERR      -1058  /* No descriptor found (release
                                         function)                         */
#define ETA_ADA_SYSBU_ERR      -1060  /* Syntax error in Search buffer     */
#define ETA_ADA_ERSBU_ERR      -1061  /* Error in Search buffer            */
#define ETA_ADA_LSPEC_ERR      -1062  /* Inconsistent length specification
                                         in Search and Value buffer        */
#define ETA_ADA_UCIDS_ERR      -1063  /* Unknown Command Identification
                                         (CID) in Search buffer            */
#define ETA_ADA_SCNST_ERR      -1070  /* No space available in table of
                                         sequential commands               */
#define ETA_ADA_SRNST_ERR      -1071  /* No space available in table of
                                         search results                    */
#define ETA_ADA_NSUQU_ERR      -1072  /* No space available for user in
                                         user queue                      */
#define ETA_ADA_NSWRK_ERR      -1073  /* No space available for search
                                         result in WORK                      */
#define ETA_ADA_NTWRK_ERR      -1074  /* No temporary space on WORK for
                                         search   command                    */
#define ETA_ADA_EXOVFCB_ERR    -1075  /* Extent overflow in File Control
                                         Block (FCB)                       */
#define ETA_ADA_OVIDX_ERR      -1076  /* An overflow occured in an inverted
                                         list index                        */
#define ETA_ADA_NSAAD_ERR      -1077  /* No Space available for ASSO/DATA  */
#define ETA_ADA_OVFST_ERR      -1078  /* Free Space Table (FST) overflow   */
#define ETA_ADA_HYXNA_ERR      -1079  /* Hyper descriptor not available    */
#define ETA_ADA_NOUSR_ERR      -1080  /* No user data stored for given user*/
#define ETA_ADA_HYISN_ERR      -1083  /* Invalid ISN from hyper exit       */
#define ETA_ADA_OVWOP_ERR      -1084  /* Work pool overflow during
                                         sub/super-descriptor update       */
#define ETA_ADA_OVDVT_ERR      -1085  /* DVT overflow during update command*/
#define ETA_ADA_HYPERR_ERR     -1086  /* Hyper descriptor error            */
#define ETA_ADA_INMEM_ERR      -1088  /* Insufficient memory               */
#define ETA_ADA_UNIQD_ERR      -1098  /* Unique descriptor already present */
#define ETA_ADA_IOERR_ERR      -1099  /* I/O error                         */
#define ETA_ADA_INVIS_ERR      -1113  /* Invalid ISN for HI,N2 or L1/L4    */
#define ETA_ADA_NLOCK_ERR      -1144  /* ISN to be updated not held by user*/
#define ETA_ADA_ALOCK_ERR      -1145  /* ISN already held by some other
                                         user                              */
#define ETA_ADA_BSPEC_ERR      -1146  /* Invalid buffer length
                                         specification                     */
#define ETA_ADA_UBNAC_ERR      -1147  /* User buffer not accessible        */
#define ETA_ADA_ANACT_ERR      -1148  /* ADABAS is not active or accessible*/
#define ETA_ADA_SYSCE_ERR      -1149  /* System communication error        */
#define ETA_ADA_NUCLI_ERR      -1150  /* Too many nuclei used in parallel  */
#define ETA_ADA_NSACQ_ERR      -1151  /* No space available in command queue*/
#define ETA_ADA_IUBSZ_ERR      -1152  /* User buffer greater than IUB size */
#define ETA_ADA_PENDI_ERR      -1153  /* ADABAS call already pending       */
#define ETA_ADA_CANCL_ERR      -1154  /* ADABAS call cancelled             */
#define ETA_ADA_MARKA_ERR      -1160  /* More than 20 blocks marked active
                                         for a single command              */
#define ETA_ADA_BPMFU_ERR      -1162  /* All buffer pool space is used     */
#define ETA_ADA_WORPO_ERR      -1164  /* Command requires more than 20 work
                                         pool areas                        */
#define ETA_ADA_NODESC_ERR     -1165  /* Error in inverted list - Descriptor
                                         not found                         */
#define ETA_ADA_NODV_ERR       -1166  /* Error in inverted list - DV not
                                         found                             */
#define ETA_ADA_UQDV_ERR       -1167  /* Error in inverted list - DV already
                                         present                           */
#define ETA_ADA_INIDX_ERR      -1169  /* Invalid INDEX (not accessible )   */
#define ETA_ADA_INRAB_ERR      -1170  /* Invalid RABN                      */
#define ETA_ADA_ISNVAL_ERR     -1172  /* ISN value invalid (ISN=0 or
                                         ISN>MAXISN)                       */
#define ETA_ADA_DARAB_ERR      -1173  /* Invalid DATA RABN                 */
#define ETA_ADA_INVLIST_ERR    -1176  /* Error in inverted list            */
#define ETA_ADA_MISAC_ERR      -1177  /* Record cannot be located in Data
                                         storage block as indicated by AC  */
#define ETA_ADA_ETDAT_ERR      -1182  /* Necessary ET-data were not found in
                                         appropriate WORK block            */
#define ETA_ADA_SECUR_ERR      -1200  /* Security violation                */
#define ETA_ADA_INVPWD_ERR     -1201  /* Invalid password                  */
#define ETA_ADA_NFPWD_ERR      -1202  /* Invalid password for used file    */
#define ETA_ADA_PWDINU_ERR     -1204  /* Password already in use           */
#define ETA_ADA_BLOST_ERR      -1210  /* Receive buffer lost               */
#define ETA_ADA_RMUTI_ERR      -1211  /* Only local utility usage allowed  */
#define ETA_ADA_NOTYET_ERR     -1212  /* Functionality not yet implemented */
#define ETA_ADA_OVLPL_ERR      -1222  /* PLOG Overflow                     */
#define ETA_ADA_ALLOC_ERR      -1242  /* Double allocation error           */
#define ETA_ADA_GCBEX_ERR      -1243  /* Invalid GCB / FCB extent detected */
#define ETA_ADA_OVCPB_ERR      -1244  /* Checkpoint Block (CPB) overflow   */
#define ETA_ADA_UTUCB_ERR      -1245  /* Pending utility entries in UCB    */
#define ETA_ADA_OVUCB_ERR      -1246  /* Utility Communicaton Block (UCB)
                                         overflow                          */
#define ETA_ADA_IDUCB_ERR      -1247  /* correct Ident not found in UCB    */
#define ETA_ADA_UQIDUQ_ERR     -1248  /* User (UQID) not found in User-Queue*/
#define ETA_ADA_TIDUQ_ERR      -1249  /* User (TID) not found in User-Queue*/
#define ETA_ADA_FCTNY_ERR      -1250  /* function not yet implemented      */
#define ETA_ADA_IUCAL_ERR      -1251  /* Invalid utility call              */
#define ETA_ADA_CALLINV_ERR    -1252  /* Invalid function call - coding
                                         error                              */
#define ETA_ADA_SYLOD_ERR      -1253  /* System file not loaded or
                                         inconsistent                      */
#define ETA_ADA_MRERUN_ERR     -1254  /* Max rerun command counter exceeded*/
#define ETA_ADA_BPOL_ERR       -1255  /* Insufficient space in attached
                                         buffer pool to process command    */
#define ETA_APPC_ERR           -1499  /* Appc Error                        */

/***************************************************************************/
/* ERRORS, Range: -1501 - -1550                                            */
/***************************************************************************/
/* Report Manager */
#define ITA_REPT_SUBM_ATTEMPT        -1501  /* Report Submitted successfully */
#define ITA_REPT_SUBM                -1502  /* Do you want to submit the report */
#define ITA_REPT_VIEW                -1503  /* Report can be viewed */
#define ETA_REPT_ID_INVALID          -1504
#define ETA_REPT_SEQ_NO_INVALID      -1505
#define FTA_REPT_MNTR_ERR            -1506
#define ETA_REPT_FILE_DEL_ERR        -1507
#define ETA_CRIT_FILE_DEL_ERR        -1508
#define ITA_NO_REPT_SUBMTD           -1509
#define ITA_SAVE_REPT                -1510
#define WTA_REPT_FILE_EXISTS         -1511
#define ETA_SAVE_REPT_ERR            -1512

/***************************************************************************/
/* ERRORS, Range: -1601 - -1650                                            */
/***************************************************************************/
/* Dynamic Memory Structures */
#define ITA_DYMS_END_OF_LIST            -1601
#define ETA_DYMS_ALLOC_ERROR            -1602
#define ETA_DYMS_BUF_TOO_SMALL          -1603
#define ETA_DYMS_INVALID_LIST           -1604

#endif /* DTA_TAEM001_H */
