/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "AZDI02.H"

/*************************************************************************
**
**	FILENAME:		AZDI0204.C - Get PMF Information
**
**	DESCRIPTION:	This function queries the PMF for the User ID used at logon.  
**					The PMF API PmfGetUidPass is used to obtain the Lan ID and
**					OT Number.
**
** REVISION HISTORY
**
** DATE        REVISED BY  SIR #   DESCRIPTION OF CHANGE
** --------    ----------  ------  ---------------------------------------
** 03/27/95    DKOLODZI			   Creation
*************************************************************************/
SHORT GetPmfInfo       ( _PMF_HDR         *pPmfHdr         ) /* AZDI0204.C */
{
	_PMFUIDPASS 	PmfData;
	SHORT			sRC = ERROR_SUCCESS;
	LONG  			ErrNum = 0;

	pPmfHdr->CmnHdrInfo.DtlCount = 1;
    sRC = PmfGetUidPass( NULL, &PmfData, &ErrNum );

	if( sRC != ERROR_SUCCESS )
	{
		strcpy( pPmfHdr->PmfLanID, "Not found." );
		strcpy( pPmfHdr->PmfOTNumber, "Not found." );
	}
	else
	{
		strcpy( pPmfHdr->PmfLanID, PmfData.LanID );
		strcpy( pPmfHdr->PmfOTNumber, PmfData.OTNumber );
	}

	return TRUE;

} /* Get PmfInfo */

SHORT RptPmfInfo( HANDLE hOut, _PMF_HDR  *pPmfHdr  ) /* AZDI0204.C */
{
  CHAR szOut[255];

  Report( hOut, "\n*** PMF INFORMATION ***\n\n" );

  sprintf( szOut, "Lan ID:     %s\n", pPmfHdr->PmfLanID );
  Report( hOut, szOut );
  sprintf( szOut, "OT Number:  %s\n", pPmfHdr->PmfOTNumber );
  Report( hOut, szOut );
  
  return 0;
} /* RptPmfInfo */


