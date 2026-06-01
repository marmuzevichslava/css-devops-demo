/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Session Data Function
**
**  PROGRAM          : AZSH05.C
**
**  DESCRIPTION      : This executable retrieves the user ID and password
**					   by calling CmnSecCallSecurity located in c1cfunc.dll
**
**  CALLED FUNCTIONS : NONE
**
**  AUTHOR           : CWOODS
**
**  DATE CREATED     : 05/29/96
**
**  REVISION HISTORY :
**
**  DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**  --------  -----------  -------  -------------------------------------
**	05/29/96  CWOODS				Creation.
***************************************************************************/
#include "azsh001.h"

#ifdef WIN32
    int WINAPI WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance,
                LPSTR lpszCmdLine, int nCmdShow)
#else
    _cdecl main (void)
#endif
{

 	CHAR  UserId[9];
	CHAR  Password[9];
	SHORT ReturnCode=0, CmnReturnCode;


    /* Call the Security Application to retrieve User ID and Password */
	CmnReturnCode = CmnSecCallSecurity(NULL, NULL, NULL, NULL, NULL, NULL, __LINE__, __FILE__ , /*CMN_ARCH_PARMS */
									   CMN_SEC_TRANSTYPE_GETUSERID, 	        /* Security Transaction */
									   &ReturnCode,
								  	   "CSR",	 							    /* Requesting Application */
                          		  	   20469,	 								/* Token */							 	
						          	   NULL,	 								/* Platform - NULL retrieves default data */
						  		  	   UserId,
						  		       Password) ;

    /* Successful call to the Security Application */
    if ( ( CmnReturnCode == 0 ) &&
	     ( ReturnCode == 0) )
    {
        return TRUE;
    } /* End of if:  Successful CmnSecCallSecurity */

    else /* Error from CmnSecCallSecurity */
    {
		/* If the CmnSecCallSecurity returns CMN_FAIL - then the Security Application could not be reached
		   via named pipes. */ 
        if ( CmnReturnCode != 0 )
        {
             return FALSE;

        } /* end of if:  ( CmnReturnCode != 0 ) */

        else /* Other security error */
        {
            return FALSE;

        } /* end of else */


    } /* End of else: Error from CmnSecCallSecurity */

 
    return(TRUE);

} /* End of Main */


