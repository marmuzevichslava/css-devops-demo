/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**                     For Use With the SIR Workbench
**
**
** FUNCTION	    :	DZIO01FieldSetValue
**
** DESCRIPTION      :   This function will set the value of a field
**                      on the window.
**
** INPUTS           :   o  void * FieldSetName - pointer to the WES Field Name
**
**                      o  CHAR * FieldSetValue - pointer to the new value of field
**
**                      o  USHORT FieldSetSize - pointer to the size of the new field
**
**                      o  CMN_ARCH_PARM_TYPES - macro that expands to the
**                         architecture standard parameter types:
**
**                            PCALLBACKEVENTINFO  *pEventInfo;
**                            EAIANAME            *pEAIA;
**                            _BFCD               *pBFCD;
**                            void                *pWesMap;
**                            WINCONTEXTNAME      *pWinContextData;
**                            ABHINAME            *pABHI;
**
**
** OUTPUTS          :   CMN_SUCCESS  or  CMN_FAIL
**
**
** CALLED FUNCTIONS :   NONE
**
** SYNTAX           :
**
**
**          OLD:   FndFieldSetValue( CBI_hwnd,
**                                   "TxSirStatus",
**                                   sizeof(StatusDecode),
**                                   StatusDecode,
**                                   &FndGenErrorBlock);
**
**		   ** I/O Module Generator Common Module -- Set **
**	    NEW:   DZIO01FieldSetValue( "TxSirStatus",
**                                     StatusDecode,
**                                     CMN_ARCH_PARMS );
**
**
**
** AUTHOR           :   Florida Power Corporation & Andersen Consulting
**
** DATE CREATED     :   03/10/94
**
**
** REVISION HISTORY
**
**  DATE     REVISED BY        SIR #      DESCRIPTION OF CHANGE
** -------   ----------------  ---------  ----------------------------------
** 03/10/94  W Ratcliff                   Created.
**
** 08/09/95  I Perez-Armesto		  Adapted for I/O Module Generator
**
***************************************************************************/
SHORT	DZIO01FieldSetValue(void * FieldSetName,
                           void * FieldSetValue,
                           USHORT FieldSetSize,
                           CMN_ARCH_PARM_TYPES)
{

   _FND_ERROR_BLOCK  FndGenErrorBlock;
    USHORT           FndGenRC;

    FndGenRC = FndFieldSetValue( CBI_hwnd,
                                 FieldSetName,
                                 FieldSetSize,
                                 FieldSetValue,
                                 &FndGenErrorBlock);

    if (FndGenRC != FND_SUCCESS)
    {
        return(CMN_FAIL);
    }

    return (CMN_SUCCESS);

} /* END DZIO01FieldSetValue */


/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**
**
** FUNCTION	    :	DZIO01FieldEnable
**
** DESCRIPTION      :   This function will enable a command on the window.
**
** INPUTS           :   o  void * CommandName - pointer to the WES Field Name
**
**                      o  CMN_ARCH_PARM_TYPES - macro that expands to the
**                         architecture standard parameter types:
**
**                            PCALLBACKEVENTINFO  *pEventInfo;
**                            EAIANAME            *pEAIA;
**                            _BFCD               *pBFCD;
**                            void                *pWesMap;
**                            WINCONTEXTNAME      *pWinContextData;
**                            ABHINAME            *pABHI;
**
**
** OUTPUTS          :   CMN_SUCCESS  or  CMN_FAIL
**
**
** CALLED FUNCTIONS :   NONE
**
** SYNTAX           :
**
**	    OLD:   FndFieldEnable( CBI_hwnd,
**                                   "ProcessMN",
**                                   &FndGenErrorBlock );
**
**                 ** SIR Workbench Common Module -- Enable Command **
**	    NEW:   DZIO01FieldEnable( "ProcessMN",
**                                      CMN_ARCH_PARMS );
**
**
**
** AUTHOR           :   Florida Power Corporation & Andersen Consulting
**
** DATE CREATED     :   03/16/94
**
**
** REVISION HISTORY
**
**  DATE     REVISED BY        SIR #      DESCRIPTION OF CHANGE
** -------   ----------------  ---------  ----------------------------------
** 03/16/94  W Ratcliff 		  Created.
**
** 08/09/95  I Perez-Armesto		  Adapted for I/O Module Generator
**
***************************************************************************/
SHORT	DZIO01FieldEnable( void * FieldName,
                            CMN_ARCH_PARM_TYPES)
{

   _FND_ERROR_BLOCK  FndGenErrorBlock;
    USHORT           FndGenRC;

    FndGenRC = FndFieldEnable( CBI_hwnd,
				 FieldName,
                                 &FndGenErrorBlock);

    if (FndGenRC != FND_SUCCESS)
    {
        return(CMN_FAIL);
    }

    return (CMN_SUCCESS);

} /* END DZIO01FieldEnable */


/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**
**
** FUNCTION	    :	DZIO01FieldDisable
**
** DESCRIPTION      :   This function will enable a command on the window.
**
** INPUTS           :   o  void * CommandName - pointer to the WES Field Name
**
**                      o  CMN_ARCH_PARM_TYPES - macro that expands to the
**                         architecture standard parameter types:
**
**                            PCALLBACKEVENTINFO  *pEventInfo;
**                            EAIANAME            *pEAIA;
**                            _BFCD               *pBFCD;
**                            void                *pWesMap;
**                            WINCONTEXTNAME      *pWinContextData;
**                            ABHINAME            *pABHI;
**
**
** OUTPUTS          :   CMN_SUCCESS  or  CMN_FAIL
**
**
** CALLED FUNCTIONS :   NONE
**
** SYNTAX           :
**
**	    OLD:   FndFieldEnable( CBI_hwnd,
**                                   "ProcessMN",
**                                   &FndGenErrorBlock );
**
**	    NEW:   DZIO01FieldDisable( "ProcessMN",
**                                      CMN_ARCH_PARMS );
**
**
**
** AUTHOR           :   Florida Power Corporation & Andersen Consulting
**
** DATE CREATED     :   03/16/94
**
**
** REVISION HISTORY
**
**  DATE     REVISED BY        SIR #      DESCRIPTION OF CHANGE
** -------   ----------------  ---------  ----------------------------------
** 03/16/94  W Ratcliff 		  Created.
**
** 08/09/95  I Perez-Armesto		  Adapted for I/O Module Generator
**
***************************************************************************/
SHORT	DZIO01FieldDisable( void * FieldName,
                            CMN_ARCH_PARM_TYPES)
{

   _FND_ERROR_BLOCK  FndGenErrorBlock;
    USHORT           FndGenRC;

    FndGenRC = FndFieldDisable( CBI_hwnd,
				 FieldName,
                                 &FndGenErrorBlock);

    if (FndGenRC != FND_SUCCESS)
    {
        return(CMN_FAIL);
    }

    return (CMN_SUCCESS);

} /* END DZIO01FieldDisable */



/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**		       For Use With the I/O Module Generator
**
**
** FUNCTION	    :	DZIO01CommandEnable
**
** DESCRIPTION      :   This function will enable a command on the window.
**
** INPUTS           :   o  void * CommandName - pointer to the WES Field Name
**
**                      o  CMN_ARCH_PARM_TYPES - macro that expands to the
**                         architecture standard parameter types:
**
**                            PCALLBACKEVENTINFO  *pEventInfo;
**                            EAIANAME            *pEAIA;
**                            _BFCD               *pBFCD;
**                            void                *pWesMap;
**                            WINCONTEXTNAME      *pWinContextData;
**                            ABHINAME            *pABHI;
**
**
** OUTPUTS          :   CMN_SUCCESS  or  CMN_FAIL
**
**
** CALLED FUNCTIONS :   NONE
**
** SYNTAX           :
**
**          OLD:   FndCommandEnable( CBI_hwnd,
**                                   "ProcessMN",
**                                   &FndGenErrorBlock );
**
**		   ** I/O Module Generator Common Module -- Enable Command **
**	    NEW:   DZIO01CommandEnable( "ProcessMN",
**                                      CMN_ARCH_PARMS );
**
**
**
** AUTHOR           :   Florida Power Corporation & Andersen Consulting
**
** DATE CREATED     :   03/16/94
**
**
** REVISION HISTORY
**
**  DATE     REVISED BY        SIR #      DESCRIPTION OF CHANGE
** -------   ----------------  ---------  ----------------------------------
** 03/16/94  W Ratcliff 		  Created.
**
** 08/09/95  I Perez-Armesto		  Adapted for I/O Module Generator
**
***************************************************************************/

SHORT	DZIO01CommandEnable( void * CommandName,
                            CMN_ARCH_PARM_TYPES)
{

   _FND_ERROR_BLOCK  FndGenErrorBlock;
    USHORT           FndGenRC;

    FndGenRC = FndCommandEnable( CBI_hwnd,
                                 CommandName,
                                 &FndGenErrorBlock);

    if (FndGenRC != FND_SUCCESS)
    {
        return(CMN_FAIL);
    }

    return (CMN_SUCCESS);

} /* END DZIO01CommandEnable */


/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**		       For Use With the I/O Module Generator
**
**
** FUNCTION	    :	DZIO01CommandDisable
**
** DESCRIPTION	    :	This function will disable a command on the window.
**
** INPUTS           :   o  void * CommandName - pointer to the WES Field Name
**
**                      o  CMN_ARCH_PARM_TYPES - macro that expands to the
**                         architecture standard parameter types:
**
**                            PCALLBACKEVENTINFO  *pEventInfo;
**                            EAIANAME            *pEAIA;
**                            _BFCD               *pBFCD;
**                            void                *pWesMap;
**                            WINCONTEXTNAME      *pWinContextData;
**                            ABHINAME            *pABHI;
**
**
** OUTPUTS          :   CMN_SUCCESS  or  CMN_FAIL
**
**
** CALLED FUNCTIONS :   NONE
**
** SYNTAX           :
**
**          OLD:   FndCommandEnable( CBI_hwnd,
**                                   "ProcessMN",
**                                   &FndGenErrorBlock );
**
**		   ** I/O Module Generator Common Module -- Enable Command **
**	    NEW:   DZIO01CommandEnable( "ProcessMN",
**                                      CMN_ARCH_PARMS );
**
**
**
** AUTHOR           :   Florida Power Corporation & Andersen Consulting
**
** DATE CREATED     :   03/16/94
**
**
** REVISION HISTORY
**
**  DATE     REVISED BY        SIR #      DESCRIPTION OF CHANGE
** -------   ----------------  ---------  ----------------------------------
** 03/16/94  W Ratcliff 		  Created.
**
** 08/09/95  I Perez-Armesto		  Adapted for I/O Module Generator
**
***************************************************************************/

SHORT	DZIO01CommandDisable( void * CommandName,
                            CMN_ARCH_PARM_TYPES)
{

   _FND_ERROR_BLOCK  FndGenErrorBlock;
    USHORT           FndGenRC;

    FndGenRC = FndCommandDisable( CBI_hwnd,
                                 CommandName,
                                 &FndGenErrorBlock);

    if (FndGenRC != FND_SUCCESS)
    {
        return(CMN_FAIL);
    }

    return (CMN_SUCCESS);

} /* END DZIO01CommandEnable */



/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**		       For Use With the I/O Module Generator
**
**
** FUNCTION	    :	DZIO01FieldQueryValue
**
** DESCRIPTION      :   This function will set the value of a field
**                      on the window.
**
** INPUTS           :   o  void * FieldQryName - pointer to the WES Field Name
**
**                      o  CHAR * FieldQryValue - pointer to the field to
**                                                  put the result in.
**
**                      o  USHORT FieldQrySize - pointer to the size of the new field
**
**                      o  CMN_ARCH_PARM_TYPES - macro that expands to the
**                         architecture standard parameter types:
**
**                            PCALLBACKEVENTINFO  *pEventInfo;
**                            EAIANAME            *pEAIA;
**                            _BFCD               *pBFCD;
**                            void                *pWesMap;
**                            WINCONTEXTNAME      *pWinContextData;
**                            ABHINAME            *pABHI;
**
**
** OUTPUTS          :   CMN_SUCCESS  or  CMN_FAIL
**
**
** CALLED FUNCTIONS :   NONE
**
** SYNTAX           :
**
**
**          OLD:   FndFieldQueryValue( CBI_hwnd,
**                                     "CdSirPriority",
**                                     sizeof(BFCD_Luw.HeaderLuw.CdSirPriority),
**                                     BFCD_Luw.HeaderLuw.CdSirPriority,
**                                     &FndGenErrorBlock );
**
**
**	    NEW:   SirWBFieldQueryValue( "CdSirPriority",
**                                       BFCD_Luw.HeaderLuw.CdSirPriority,
**                                       CMN_ARCH_PARMS );
**
**
**
** AUTHOR           :   Florida Power Corporation & Andersen Consulting
**
** DATE CREATED     :   03/10/94
**
**
** REVISION HISTORY
**
**  DATE     REVISED BY        SIR #      DESCRIPTION OF CHANGE
** -------   ----------------  ---------  ----------------------------------
** 03/10/94  W Ratcliff 		  Created.
**
** 08/09/95  I Perez-Armesto		  Adapted for I/O Module Generator
**
***************************************************************************/
SHORT	DZIO01FieldQueryValue(void * FieldQryName,
                             void * FieldQryValue,
                             USHORT FieldQrySize,
                             CMN_ARCH_PARM_TYPES)
{

   _FND_ERROR_BLOCK  FndGenErrorBlock;
    USHORT           FndGenRC;

    FndGenRC = FndFieldQueryValue( CBI_hwnd,
                                    FieldQryName,
                                    FieldQrySize,
                                    FieldQryValue,
                                    &FndGenErrorBlock );

    if (FndGenRC != FND_SUCCESS)
    {
        return(CMN_FAIL);
    }

    return (CMN_SUCCESS);

} /* END SirWBFieldQueryValue */



/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**		       For Use With the I/O Module Generator
**
**
** FUNCTION	    :	DZIO01MsgBoxDisplay
**
** DESCRIPTION      :   This function will set the value of a field
**                      on the window.
**
** INPUTS           :   o  void * FieldQryName - pointer to the WES Field Name
**
**                      o  CHAR * FieldQryValue - pointer to the field to
**                                                  put the result in.
**
**                      o  USHORT FieldQrySize - pointer to the size of the new field
**
**                      o  CMN_ARCH_PARM_TYPES - macro that expands to the
**                         architecture standard parameter types:
**
**                            PCALLBACKEVENTINFO  *pEventInfo;
**                            EAIANAME            *pEAIA;
**                            _BFCD               *pBFCD;
**                            void                *pWesMap;
**                            WINCONTEXTNAME      *pWinContextData;
**                            ABHINAME            *pABHI;
**
**
** OUTPUTS          :   CMN_SUCCESS  or  CMN_FAIL
**
**
** CALLED FUNCTIONS :   NONE
**
** SYNTAX           :
**
**
**	    OLD:   FndGenRC = FndMsgBoxDisplayMdlssText(TITLE6,
**					 BOX_TITLE2,
**					 CBI_hwnd,
**					 FND_MSGBOX_NOBUTTONS,
**					 FND_MSGBOX_INFORMATION,
**					 FND_MSGBOX_IDNOBUTTON,
**					 BOX_TITLE2,
**					 &FndGenErrorBlock);
**
**
**	    NEW:   DZIO01MsgBoxDisplay( "CdSirPriority",
**                                       BFCD_Luw.HeaderLuw.CdSirPriority,
**                                       CMN_ARCH_PARMS );
**
**
**
** AUTHOR           :   Florida Power Corporation & Andersen Consulting
**
** DATE CREATED     :   03/10/94
**
**
** REVISION HISTORY
**
**  DATE     REVISED BY        SIR #      DESCRIPTION OF CHANGE
** -------   ----------------  ---------  ----------------------------------
** 08/09/95  I Perez-Armesto		  Created
**
***************************************************************************/

SHORT	DZIO01MsgBoxDisplay(char *pMsgBoxText,
			    char MsgBoxName[32],
			    FND_HWND OwnerHwnd,
			    unsigned short Buttons,
			    unsigned short Icon,
			    unsigned short DefaultButton,
			    char *pMsgBoxTitle,
			    CMN_ARCH_PARM_TYPES)
{

   _FND_ERROR_BLOCK  FndGenErrorBlock;
    USHORT           FndGenRC,
		             SelectedButton;

    FndGenRC = FndMsgBoxDisplayText(pMsgBoxText,
					 MsgBoxName,
					 OwnerHwnd,
					 Buttons,
					 Icon,
					 DefaultButton,
					 pMsgBoxTitle,
					 &SelectedButton,
					 &FndGenErrorBlock);

    if (FndGenRC != FND_SUCCESS)
    {
        return(CMN_FAIL);
    }

    return (CMN_SUCCESS);

} /* END DZIO01MsgBoxDisplay */


/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**		       For Use With the I/O Module Generator
**
**
** FUNCTION	    :	DZIO01MsgBoxDestroy
**
** DESCRIPTION      :   This function will set the value of a field
**                      on the window.
**
** INPUTS           :   o  void * FieldQryName - pointer to the WES Field Name
**
**                      o  CHAR * FieldQryValue - pointer to the field to
**                                                  put the result in.
**
**                      o  USHORT FieldQrySize - pointer to the size of the new field
**
**                      o  CMN_ARCH_PARM_TYPES - macro that expands to the
**                         architecture standard parameter types:
**
**                            PCALLBACKEVENTINFO  *pEventInfo;
**                            EAIANAME            *pEAIA;
**                            _BFCD               *pBFCD;
**                            void                *pWesMap;
**                            WINCONTEXTNAME      *pWinContextData;
**                            ABHINAME            *pABHI;
**
**
** OUTPUTS          :   CMN_SUCCESS  or  CMN_FAIL
**
**
** CALLED FUNCTIONS :   NONE
**
** SYNTAX           :
**
**
**	    OLD:   FndGenRC = FndMsgBoxDisplayMdlssText(TITLE6,
**					 BOX_TITLE2,
**					 CBI_hwnd,
**					 FND_MSGBOX_NOBUTTONS,
**					 FND_MSGBOX_INFORMATION,
**					 FND_MSGBOX_IDNOBUTTON,
**					 BOX_TITLE2,
**					 &FndGenErrorBlock);
**
**
**	    NEW:   DZIO01MsgBoxDisplay( "CdSirPriority",
**                                       BFCD_Luw.HeaderLuw.CdSirPriority,
**                                       CMN_ARCH_PARMS );
**
**
**
** AUTHOR           :   Florida Power Corporation & Andersen Consulting
**
** DATE CREATED     :   03/10/94
**
**
** REVISION HISTORY
**
**  DATE     REVISED BY        SIR #      DESCRIPTION OF CHANGE
** -------   ----------------  ---------  ----------------------------------
** 08/09/95  I Perez-Armesto		  Created
**
***************************************************************************/

SHORT	DZIO01MsgBoxDestroy(char MsgBoxName[32],
			    CMN_ARCH_PARM_TYPES)
{

    USHORT	     FndGenRC;

    FndGenRC = CmnMsgBoxDestroy(MsgBoxName,
				CMN_ARCH_PARMS);

    if (FndGenRC != FND_SUCCESS)
    {
        return(CMN_FAIL);
    }

    return (CMN_SUCCESS);

} /* END DZIO01MsgBoxDestroy */
