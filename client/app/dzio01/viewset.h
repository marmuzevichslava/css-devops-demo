/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**
**
** FUNCTION	    :	DZIO008PopulateWindow
**
** DESCRIPTION	    :	This function will populate window # 9.
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

SHORT DZIO008PopulateWindow( _ENTITYDATA *pEntityDataTable,
                             _REPLYHDR *pReplyHdr,
                             CMN_ARCH_PARM_TYPES )
{
  _ReposDataLBRow ReposDataLBRow;
  CHAR Indent[ 20 ];
  USHORT i,j;
  _FND_ERROR_BLOCK  FndGenErrorBlock;
  USHORT FndGenRC = 0;
  SHORT TextLen;

//  for( i=0; i<_REPLYHDR__ENTITYTEXT_SIZE; i++ )
  for( i=0; i<pReplyHdr->NumTextRows; i++ )
  {
    CmnStrTrimTrailBlanks( pReplyHdr->EntityText[i],
                           sizeof( pReplyHdr->EntityText[i] ),
                           CMN_ARCH_PARMS );

    /* Trim CR/LF from text */
    CmnDdeTrimCRLF( pReplyHdr->EntityText[i],
                    sizeof( pReplyHdr->EntityText[i] ));

    TextLen = strlen(pReplyHdr->EntityText[i]);

    pReplyHdr->EntityText[i][TextLen] = '\n';
    pReplyHdr->EntityText[i][TextLen+1] = '\0';
  }


  for( i=0; i<pReplyHdr->RowsReturned; i++ )
  {
    memset( Indent, 0, sizeof(Indent ));

    for( j=0; j<pEntityDataTable[i].EntityLevel; j++ )
    {
      strcat( Indent, "  " );
    }

    memset( &ReposDataLBRow, 0, sizeof( ReposDataLBRow ));

    /* JSH: 07/29/93 REMOVED */
    /*
    /* JSH: 09/21/93 MODIFIED from CmnStrTrimBlanks
    CmnStrTrimTrailBlanks( pEntityDataTable[i].EntityId,
                           sizeof( pEntityDataTable[i].EntityId ),
                           CMM_ARCH_PARMS );
    */
    /* JSH: 07/29/93 ADDED */
    /* Null terminate at first space in EntityId */
    j = 0;
    while( pEntityDataTable[i].EntityId[j] != ' ' )
    {
      j++;
    }
    pEntityDataTable[i].EntityId[j] = '\0';

    CmnStrCat( CMN_ARCH_PARMS, ReposDataLBRow._ReposDataLBEntityIdData,
               sizeof( ReposDataLBRow._ReposDataLBEntityIdData ),
               2, Indent, pEntityDataTable[i].EntityId );

    /* JSH: 09/21/93 MODIFIED from CmnStrTrimBlanks */
    CmnStrTrimTrailBlanks( pEntityDataTable[i].EntityType,
                           sizeof( pEntityDataTable[i].EntityType),
                           CMN_ARCH_PARMS );

    if( !strcmp( pEntityDataTable[i].EntityType, "DEDTABLE" ))
    {
      strcpy( pEntityDataTable[i].EntityType, "TABLE" );
    }
    else if( !strcmp( pEntityDataTable[i].EntityType, "DECOPYBK" ))
    {
      strcpy( pEntityDataTable[i].EntityType, "COPYBOOK" );
    }
    else if( !strcmp( pEntityDataTable[i].EntityType, "DERECORD" ))
    {
      strcpy( pEntityDataTable[i].EntityType, "RECORD" );
    }
    else if( !strcmp( pEntityDataTable[i].EntityType, "DEGROUP" ))
    {
      strcpy( pEntityDataTable[i].EntityType, "GROUP" );
    }
    else if( !strcmp( pEntityDataTable[i].EntityType, "DEDTELEM" ))
    {
      strcpy( pEntityDataTable[i].EntityType, "ELEMENT" );
    }

    CmnStrCat( CMN_ARCH_PARMS, ReposDataLBRow._ReposDataLBEntityTypeData,
               sizeof( ReposDataLBRow._ReposDataLBEntityTypeData ),
               2, Indent, pEntityDataTable[i].EntityType );

    /* JSH: 09/21/93 MODIFIED from CmnStrTrimBlanks */
    CmnStrTrimTrailBlanks( pEntityDataTable[i].EntityCobolName,
                           sizeof( pEntityDataTable[i].EntityCobolName),
                           CMN_ARCH_PARMS );
    CmnStrCat( CMN_ARCH_PARMS,
               ReposDataLBRow._ReposDataLBEntityNameData,
               sizeof( ReposDataLBRow._ReposDataLBEntityNameData ),
               2, Indent, pEntityDataTable[i].EntityCobolName );

    /* Display length if it's non-zero */
    if( pEntityDataTable[i].DteIntLength > 0 )
    {
      CmnStrFromInt( ReposDataLBRow._ReposDataLBLengthData,
                     sizeof( ReposDataLBRow._ReposDataLBLengthData ),
                     pEntityDataTable[i].DteIntLength,
                     CMN_LEADING_ZEROES_NO,
                     CMN_ARCH_PARMS );
    }
    else
    {
      strcpy( ReposDataLBRow._ReposDataLBLengthData, "" );
    }

    ReposDataLBRow._ReposDataLBFormatData[0] =
        pEntityDataTable[i].DteIntFormat;

    /* Display precision if format is numeric */
    if( pEntityDataTable[i].DteIntFormat == 'N' )
    {
      CmnStrFromInt( ReposDataLBRow._ReposDataLBPrecisionData,
                     sizeof( ReposDataLBRow._ReposDataLBPrecisionData ),
                     pEntityDataTable[i].DteIntPrecision,
                     CMN_LEADING_ZEROES_NO,
                     CMN_ARCH_PARMS );
    }
    else
    {
      strcpy( ReposDataLBRow._ReposDataLBPrecisionData, "" );
    }

    CmnStrCopy( ReposDataLBRow._ReposDataLBUsageData,
                pEntityDataTable[i].DteIntUsage,
                sizeof( ReposDataLBRow._ReposDataLBUsageData ),
                CMN_ARCH_PARMS );

    /* Display occurs only if occurs > 1 */
    if( pEntityDataTable[i].RelatOccFact > 1 )
    {
      CmnStrFromInt( ReposDataLBRow._ReposDataLBOccursData,
                     sizeof( ReposDataLBRow._ReposDataLBOccursData ),
                     pEntityDataTable[i].RelatOccFact,
                     CMN_LEADING_ZEROES_NO,
                     CMN_ARCH_PARMS );
    }
    /*
    else
    {
      strcpy( ReposDataLBRow._ReposDataLBOccursData, "" );
    }
    */


    /* Display Other and Other2 */
    /* Display only if first row represents a TABLE */
    if(( strcmp( pEntityDataTable[0].EntityType, "TABLE" ) == 0 ) &&
       ( strcmp( pEntityDataTable[i].EntityType, "ELEMENT" ) == 0 ) &&
       ( pEntityDataTable[i].RelatNulFl != 'Y' ))
    {
      if( pEntityDataTable[i].RelatDefaultFl == 'Y' )
      {
        strcpy( ReposDataLBRow._ReposDataLBOther2Data,
                "NOT NULL WITH DEFAULT" );
      }
      else
      {
        strcpy( ReposDataLBRow._ReposDataLBOther2Data,
                "NOT NULL" );
      }
    }

    /* Add the new row */
    FndGenRC = FndLstBoxRowAdd( CBI_hwnd,
				"ReposDataLB",
				i,
                                sizeof( _ReposDataLBRow ),
                                (VOID *) &ReposDataLBRow,
                                &FndGenErrorBlock );
  }

  return CMN_SUCCESS;
}

/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**
**
** FUNCTION	    :	DZIO008RetrieveLayout
**
** DESCRIPTION	    :	This function will call the AZRP01 service.
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

SHORT DZIO008RetrieveLayout( _REQUESTHDR *pRequestHdr,
                            _REPLYHDR *pReplyHdr,
                            _ENTITYDATA *pEntityDataTable,
                            CMN_ARCH_PARM_TYPES )
{
  #define DEST_APPL_ID   1
  #define DEST_SRVC_ID   1
  #define DEST_SRVC_VER  "00"

  USHORT FndGenRC = 0;
  _FND_STANDARD_PB  FndStandardPB;
  _FND_ERROR_BLOCK  FndGenErrorBlock;
  _MSG_PARM_BLOCK   ParmBlock;

//  _LAYOUT_REC *pLayoutRecTable;
//  _ENTITYDATA *pEntityDataTable;
//  USHORT OffsetTable[ 20 ];
//  USHORT GroupCLength;

//  USHORT i;

  /* JSH: 07/24/93 MODIFIED */
  _MESSAGEOUTPUT  *pMessageInput;
  _MESSAGEOUTPUT *pMessageOutput;

  SHORT ReturnCode = 0;
  CHAR Message[ 255 ];
  USHORT SelectedButton;


  FndGenRC = FndWindowSetPointer(CBI_hwnd,
                                 FNDSYSPTR_WAIT,
                                 &FndGenErrorBlock);

  FndGenRC = FndMsgBoxDisplayMdlssText( "\n\nRetrieving Data From The Repository ...\n\n Please be patient.",
                                   "ReposWait",
                                   CBI_hwnd,
                                   FND_MSGBOX_NOBUTTONS,
                                   FND_MSGBOX_INFORMATION,
                                   FND_MSGBOX_IDNOBUTTON,
                                   CMN_CSS_APPL_NAME,
                                   &FndGenErrorBlock);

  /* JSH: 07/24/93 MODIFIED */
  pMessageInput  = malloc( sizeof( _MESSAGEOUTPUT ));
  pMessageOutput = malloc( sizeof( _MESSAGEOUTPUT ));

  memcpy( FndStandardPB.ver, FND_MSG_VER, _VER_LEN );

  /* Set up Request Header */
  strcpy( pMessageInput->RequestHdr.EntityType, pRequestHdr->EntityType );

  strcpy( pMessageInput->RequestHdr.EntityId, pRequestHdr->EntityId );
  pMessageInput->RequestHdr.MaxRows = pRequestHdr->MaxRows;

  /* Initialize Foundation Parm Block */
  MSGInitPB( &FndStandardPB, &ParmBlock, pEAIA, DEST_APPL_ID,
             DEST_SRVC_ID, DEST_SRVC_VER, pABHI );

  memcpy( ParmBlock.commarea.ver, FND_MSG_VER, _VER_LEN );
  ParmBlock.commarea.function_code = MSGIO_CONVERSE;
  /* JSH: 07/24/93 MODIFIED */
  ParmBlock.buffer_size = sizeof( _MESSAGEOUTPUT );
  ParmBlock.actual_length_send = sizeof( _REQUESTHDR );
  ParmBlock.timeout_interval = 30;

  memcpy( ParmBlock.translation.map_name, "AZCR001O", _FND_MAP_NAME_LEN );
  memcpy( ParmBlock.translation.map_version, "01", _VER_LEN );

  FndGenRC = MSGConvUI( &ParmBlock, (_MSG_SEND_AREA) pMessageInput,
                      (_MSG_RECV_AREA) pMessageOutput, pABHI );

//  FndGenRC = MSGConv( &ParmBlock, (_MSG_SEND_AREA) pMessageInput,
//                      (_MSG_RECV_AREA) pMessageOutput, pABHI );

  if( FndGenRC == MSGIO_SUCCESS &&
      ParmBlock.appl_status.explan_code == FND_SUCCESS )
  {
    /* Allocate space for Layout Record Table */
    //pReplyHdr->RowsReturned = pMessageOutput->ReplyHdr.RowsReturned;
    memcpy( pReplyHdr, &(pMessageOutput->ReplyHdr), sizeof( _REPLYHDR ));

    /* Check if any rows were returned */
    if( pReplyHdr->RowsReturned )
    {
      //pEntityDataTable = (_ENTITYDATA *)
      //                       malloc( *pNumRows * sizeof( _ENTITYDATA ));

      /* Initialize memory */
      memcpy( pEntityDataTable, &(pMessageOutput->EntityData),
              pReplyHdr->RowsReturned * sizeof( _ENTITYDATA ));

      /*
      for( i=0; i<*pNumRows; i++ )
      {
        CsrMapInitItem( &(pMessageOutput->EntityData[i]),
                        &(pLayoutRecTable[i]), CMN_ARCH_PARMS );
      }
      */

      //*ppEntityDataTable = pEntityDataTable;

      /* Initialize OffsetTable */
      /*
      memset( OffsetTable, 0, sizeof( OffsetTable ));
      */
      /*

      CsrMapProcessDataLayout( pMessageOutput->EntityData,
                               OffsetTable,
                               pLayoutRecTable,
                               0,
                               0,
                               0,
                               &GroupCLength );
      */

      /* Check SQLCODE */
      if( pReplyHdr->SqlCode )
      {
        sprintf( Message, "Rows were returned by the Repository "
                          "Extract Service.  However, a non-zero "
                          "SQL Code was returned.  The SQL Code was "
                          "%ld.",
                 pReplyHdr->SqlCode );

        FndMsgBoxDisplayText( Message, NULL, CBI_hwnd, FND_MSGBOX_OK,
                              FND_MSGBOX_WARNING, FND_MSGBOX_OK,
                              NULL, &SelectedButton, &FndGenErrorBlock );
      }


    }
    else
    {
      /* No rows were returned */
      /* Check SQL Code */
      switch( pMessageOutput->ReplyHdr.SqlCode )
      {
        case 0:
	    sprintf( Message, "The entity was not found by the Repository "
                              "Extract Service.  The SQL Code was %ld.",
                     pMessageOutput->ReplyHdr.SqlCode );
            break;

        default:
	    sprintf( Message, "The entity was not found by the Repository "
                              "Extract Service.  The SQL Code was %ld.",
                     pMessageOutput->ReplyHdr.SqlCode );
            break;
      }

      FndMsgBoxDisplayText( Message, NULL, CBI_hwnd, FND_MSGBOX_OK,
                            FND_MSGBOX_CRITICAL, FND_MSGBOX_OK,
                            NULL, &SelectedButton, &FndGenErrorBlock );

	  /* Shut down the window */

	  FndGenRC = FndWindowDestroy(CBI_hwnd,
								  &FndGenErrorBlock);


      /* Set ReturnCode to indicate error */
      ReturnCode = 1;
    }
  }
  else
  {
    sprintf( Message, "Distribution Services returned an error.  "
                      "The return code from MSGConv is %d.  "
                      "The explanation code is %d.",
             FndGenRC, ParmBlock.appl_status.explan_code );


    FndMsgBoxDisplayText( Message, NULL, CBI_hwnd, FND_MSGBOX_OK,
                          FND_MSGBOX_CRITICAL, FND_MSGBOX_OK,
                          NULL, &SelectedButton, &FndGenErrorBlock );

    /* DS Error occurred */
    ReturnCode = 1;
  }

  /* Free the memory allocated for Message Input and Output */
  free( pMessageInput );
  free( pMessageOutput );

  FndGenRC = FndWindowSetPointer( CBI_hwnd,
                                  FNDSYSPTR_ARROW,
                                  &FndGenErrorBlock );

  FndGenRC = FndMsgBoxDestroy("ReposWait",
                               &FndGenErrorBlock);

  return ReturnCode;
}
