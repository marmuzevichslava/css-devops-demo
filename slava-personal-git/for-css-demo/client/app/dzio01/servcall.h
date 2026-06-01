/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**
**
** FUNCTION	    :	DZIO001XResetWindow
**
** DESCRIPTION      :   This function will enable a command on the window.
**
** INPUTS	    :	o  char * module_name
**
**                      o  CMN_ARCH_PARM_TYPES - macro that expands to the
**                         architecture standard parameter types:
**
**			o  char * function_type
**
**
** OUTPUTS          :   CMN_SUCCESS  or  CMN_FAIL
**
**
** CALLED FUNCTIONS :   NONE
**
** SYNTAX           :
**
**	    OLD:   Ncqnrdhl8096_Predisplay
**
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
**
** 08/09/95  I Perez-Armesto		  Adapted for I/O Module Generator
**
***************************************************************************/


SHORT DZIO01ServiceCall(CMN_ARCH_PARM_TYPES,
			     char * function_type, 
				 char * module_name,
				 _DZCR001OUTPUT  *MessageOutput,
                 _DZCR001INPUT   *MessageInput)
{

   int		        i = 0;
   USHORT           FndGenRC = 0,
                    NumberOfRows = 1;
   CHAR			    szErrorMessage[200];

   _FND_STANDARD_PB	FndStandardPB;
   _MSG_PARM_BLOCK	ParmBlock;




   memset(MessageInput, '\0',sizeof(_DZCR001INPUT));
   memset(MessageOutput, '\0',sizeof(_DZCR001OUTPUT));


   CmnCodesGetDecodes( "DEV00707",			   /* Table name  */
                        CMN_CTB_LANGUAGE_DEFAULT,	   /* Language	  */
			            "R",
			            sizeof("R"),
			            MessageInput->StandardHeader.KyUserid2,	   /* Decode	  */
			            sizeof(MessageInput->StandardHeader.KyUserid2),	   /* Decode size */
			            &NumberOfRows,			   /* # of rows   */
			            CMN_ARCH_PARMS );


   strncpy(MessageInput->Hdr_DZ0101.Iomodnm,module_name,
	   sizeof(MessageInput->Hdr_DZ0101.Iomodnm) );

   strncpy(MessageInput->Hdr_DZ0101.Alrcbook,function_type,
	   sizeof(MessageInput->Hdr_DZ0101.Alrcbook) );

   memcpy(FndStandardPB.ver,FND_MSG_VER,_VER_LEN);

   i = sizeof (MessageOutput->StandardHeader);
   MSGInitPB(&FndStandardPB,
	     &ParmBlock,
	     pEAIA,
	     APPL_ID,
	     SRVC_ID,
	     SRVC_VER,
	     pABHI);

   memcpy(ParmBlock.commarea.ver,FND_MSG_VER,_VER_LEN);

   memcpy(ParmBlock.dest.service_id.service_ver, SRVC_VER, _VER_LEN);

   ParmBlock.actual_length_send = sizeof(_DZCR001INPUT);
   ParmBlock.src.language = FND_LANGUAGE_C;
   ParmBlock.buffer_size = sizeof(_DZCR001OUTPUT);
   ParmBlock.dest.service_id.appl = APPL_ID;
   ParmBlock.dest.service_id.srvc = SRVC_ID;

   memcpy(ParmBlock.translation.map_name, SRVC_MAP, _FND_MAP_NAME_LEN);
   memcpy(ParmBlock.translation.map_version,SRVC_VER, _VER_LEN);

   FndGenRC = MSGConvUI(&ParmBlock,
			(_MSG_SEND_AREA) MessageInput,
			(_MSG_RECV_AREA) MessageOutput,
			pABHI);


   if ((FndGenRC != MSGIO_SUCCESS) &&
       (ParmBlock.appl_status.explan_code != FND_SUCCESS))
   {

       memset(szErrorMessage, 0, sizeof(szErrorMessage));

	   sprintf(szErrorMessage, "Error in MsgConvUI <%d> <%d> <%d> <%s>",
	                            FndGenRC,
								ParmBlock.appl_status.explan_code,
								pABHI->abhi_error_msg_num,
                                pABHI->abhi_error_msg_area);

       FndGenRC = DZIO01MsgBoxDisplay( szErrorMessage,
				   "Search Results",
				   CBI_hwnd,
				   FND_MSGBOX_OK,
				   FND_MSGBOX_WARNING,
				   FND_MSGBOX_OK,
				   "Search Results",
				   CMN_ARCH_PARMS);

	   FndGenRC = !CMN_SUCCESS;

   }
   else
   {
		if ( strcmp(MessageOutput->Hdr_DZ0101.Alrcbook,"NotFound") != 0)
		{
			FndGenRC = !CMN_SUCCESS;
		}
		else
		{
			FndGenRC = CMN_SUCCESS;
		}
   }


   return FndGenRC;

}
