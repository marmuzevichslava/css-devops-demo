
/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : AZSH001.H
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR           : CWOODS  
**
**  DATE CREATED     : 05/29/96
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    05/29/96  CWOODS                Original code.
**
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/

#ifdef WIN32
    #include <windows.h>
#else
    #define  INCL_DOS
    #include <os2.h>
#endif

/***************************************************************************/
/* Application #defines                                                    */
/***************************************************************************/


#define CMN_ARCH_PARM_TYPES    						\
              void   			*pEventInfo, 		\
              void            	*pEAIA,		 		\
              void              *pBFCD, 			\
              void          	*pWesMap, 			\
              void      		*pWindContextData, 	\
              void            	*pABHI,            	\
              unsigned          LineNo,           	\
              void              *FileName

/***************************************************************************/
/* Application typedefs                                                    */
/***************************************************************************/

enum CMN_SEC_SECURITY_TRANSTYPE  { CMN_SEC_SECURITY_TRANSTYPE_GETUSERID = 1,
							       CMN_SEC_SECURITY_TRANSTYPE_TERMINATE,
							       CMN_SEC_SECURITY_TRANSTYPE_GETRIGHT };

/***************************************************************************/
/* Forward declarations                                                    */
/***************************************************************************/

SHORT CmnSecCallSecurity( CMN_ARCH_PARM_TYPES,
						  enum CMN_SEC_SECURITY_TRANSTYPE SecTransaction,
						  SHORT *pReturnCode,
                            ... );

