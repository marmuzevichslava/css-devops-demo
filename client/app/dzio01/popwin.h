SHORT AZRP001PopulateWindow( _ENTITYDATA *pEntityDataTable,
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

  /* Populate MLE */
  CmnStrCat( CMN_ARCH_PARMS, LongDescData, sizeof( LongDescData ),
             8,
             pReplyHdr->EntityText[0], pReplyHdr->EntityText[1],
             pReplyHdr->EntityText[2], pReplyHdr->EntityText[3],
             pReplyHdr->EntityText[4], pReplyHdr->EntityText[5],
             pReplyHdr->EntityText[6], pReplyHdr->EntityText[7] );

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
/*       ( pEntityDataTable[i].RelatNulFl == 'N' )) */
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
    FndGenRC = FndLstBoxRowAdd( CBI_hwnd, "ReposDataLB", i,
                                sizeof( _ReposDataLBRow ),
                                (VOID *) &ReposDataLBRow,
                                &FndGenErrorBlock );
  }

  return CMN_SUCCESS;
}
