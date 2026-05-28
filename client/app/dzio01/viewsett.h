/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**
**
** FUNCTION	    :	DZIO007PopulateWindowSpec
**
** DESCRIPTION	    :	This function will populate the specified listbox on Window
**			# 7.
**
** INPUTS	    :	o   _REQUESTHDR *pRequestHdr
**
**			o   _REPLYHDR *pReplyHdr
**
**			o   _ENTITYDATA *pEntityDataTable
**
**                      o  CMN_ARCH_PARM_TYPES - macro that expands to the
**                         architecture standard parameter types:
**
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

SHORT DZIO007PopulateJoinTable1( _ENTITYDATA *pEntityDataTable,
                                 _REPLYHDR *pReplyHdr,
                                 CMN_ARCH_PARM_TYPES )
{
  _JoinTable1Row ReposDataLBRow;
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


    /* JSH: 09/21/93 MODIFIED from CmnStrTrimBlanks */
    /* This sets up the data to be passed into the list box */

    CmnStrTrimTrailBlanks( pEntityDataTable[i].EntityCobolName,
                           sizeof( pEntityDataTable[i].EntityCobolName),
			   CMN_ARCH_PARMS );

    CmnStrCat( CMN_ARCH_PARMS,
               ReposDataLBRow._JoinTable1EntityNameData,
               sizeof( ReposDataLBRow._JoinTable1EntityNameData ),
               2, Indent, pEntityDataTable[i].EntityCobolName );


    CmnStrCopy( ReposDataLBRow._JoinTable1Dz00707Data,
		pEntityDataTable[i].EntityId,
		sizeof( ReposDataLBRow._JoinTable1Dz00707Data ),
		CMN_ARCH_PARMS );



    /* Add the new row */
    FndGenRC = FndLstBoxRowAdd( CBI_hwnd,
				"JoinTable1",
				i,
                                sizeof( _JoinTable1Row ),
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
** FUNCTION	    :	DZIO007PopulateJoinTable2
**
** DESCRIPTION	    :	This function will populate the specified listbox on Window
**			# 7.
**
** INPUTS	    :	o   _REQUESTHDR *pRequestHdr
**
**			o   _REPLYHDR *pReplyHdr
**
**			o   _ENTITYDATA *pEntityDataTable
**
**                      o  CMN_ARCH_PARM_TYPES - macro that expands to the
**                         architecture standard parameter types:
**
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

SHORT DZIO007PopulateJoinTable2( _ENTITYDATA *pEntityDataTable,
                                 _REPLYHDR *pReplyHdr,
                                 CMN_ARCH_PARM_TYPES )
{
  _JoinTable2Row ReposDataLBRow;
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


    /* JSH: 09/21/93 MODIFIED from CmnStrTrimBlanks */
    /* This sets up the data to be passed into the list box */

    CmnStrTrimTrailBlanks( pEntityDataTable[i].EntityCobolName,
                           sizeof( pEntityDataTable[i].EntityCobolName),
			   CMN_ARCH_PARMS );

    CmnStrCat( CMN_ARCH_PARMS,
               ReposDataLBRow._JoinTable2EntityNameData,
               sizeof( ReposDataLBRow._JoinTable2EntityNameData ),
               2, Indent, pEntityDataTable[i].EntityCobolName );


    CmnStrCopy( ReposDataLBRow._JoinTable2Dz00707Data,
		pEntityDataTable[i].EntityId,
		sizeof( ReposDataLBRow._JoinTable2Dz00707Data ),
		CMN_ARCH_PARMS );



    /* Add the new row */
    FndGenRC = FndLstBoxRowAdd( CBI_hwnd,
				"JoinTable2",
				i,
                                sizeof( _JoinTable2Row ),
                                (VOID *) &ReposDataLBRow,
                                &FndGenErrorBlock );
  }

  return CMN_SUCCESS;
}
