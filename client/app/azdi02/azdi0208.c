/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*************************************************************************
**
**	FILENAME:		AZDI0208.C - Get Session Transcript Information
**
**	DESCRIPTION:	This function opens the Session Transcript log file
**                  and writes the results to a file.
**
**
**  CREATED:
**
**  REVISION HISTORY
**
**  DATE        REVISED BY  SIR #   DESCRIPTION OF CHANGE
**  --------    ----------  ------  ---------------------------------------
**  02/12/97    GHOWELL     16116   Changed hardcoded file names to macros
**  10/17/97	TZAK		24990	Added logic to handle when less than
**                                    NUM_SESSTRAN_RECS entries exist in 
**                                    log file
*************************************************************************/


#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include "AZDI02.H"

SHORT GetSessTran( _SESSTRAN_HDR *pSessTranHdr )
{
  HFILE hFile;
  HANDLE hFileMap;
  CHAR *pFile;
  LONG FileSize;
  INT	i = 0;
  //_ST_DETAIL *pStDetail;
  SHORT rc = 0;
  FILE 	*hiWinFND;
  CHAR 	fiWinFND[64];
  CHAR 	szSourceLine[1024];
  CHAR  szFileName[256];
  CHAR	PathEnvVar[64];

  memset( szFileName, 0, sizeof(szFileName) );
  pSessTranHdr->KTFNDFound = FALSE;
  pSessTranHdr->DataPathFound = FALSE;

  GetEnvironmentVariable( "SystemRoot", PathEnvVar, 64 );
  strcpy( fiWinFND, PathEnvVar);
  strcat( fiWinFND, "\\" );
  strcat( fiWinFND, FND_INI_FILE );  /* 02/12/97 GHOWELL - Changed from hardcoded file name */

  if ( (hiWinFND = fopen( fiWinFND, "rt" )) != NULL )
  {
    pSessTranHdr->KTFNDFound = TRUE;
    while (fgets( szSourceLine, 1024, hiWinFND ) != NULL)
    {
    	if (strstr( szSourceLine, "FNDDATA") != NULL)
		{
		    pSessTranHdr->DataPathFound = TRUE;
			strcpy( szFileName, szSourceLine+8  );
		}
	} /*while*/
  } /*if*/
  else
  {
    fcloseall();
  	return FALSE;
  }
  
  fcloseall();
  if( (!pSessTranHdr->KTFNDFound) ||
      (!pSessTranHdr->DataPathFound) )
  { /*Terminate if file or path not found*/
  	return FALSE;
  }

  /* Parse through filename and remove \n */
  i = 0;
  while( (szFileName[i] != '\n') && ( i < sizeof(szFileName)) )
  {
  	i++;
  }
  if( i < sizeof(szFileName) )
  {
    szFileName[i] = '\0';  
  }

  strcat( szFileName, SESS_TRN_LOG_FILE); /* 02/12/97 GHOWELL - Changed from hardcoded file name */

  rc = OpenSTFile( szFileName, &hFile, &hFileMap,
                   &pFile, &FileSize );

  if( !rc )
  {
    pSessTranHdr->CmnHdrInfo.DtlCount = FileSize / sizeof( _ST_DETAIL );

	/* Allocate memory for detail */
	pSessTranHdr->pSessTranDtl = malloc( FileSize );

	memcpy( pSessTranHdr->pSessTranDtl, pFile, FileSize );

	/* Close file */
	CloseSTFile( hFile, hFileMap, pFile );
  }

  pSessTranHdr->CmnHdrInfo.rc = rc;
  return rc;
}


SHORT RptSessTran( HANDLE hOut, _SESSTRAN_HDR *pSessTranHdr )
{
  SHORT i;
  SHORT rc;
  CHAR  szOut[255];
  _ST_DETAIL *pSTDetail = pSessTranHdr->pSessTranDtl;

  Report( hOut, "\n\n*** SESSION TRANSCRIPT LOG ***\n\n" );

  if ( !pSessTranHdr->KTFNDFound )
  {
    sprintf( szOut, "KTFND.INI file was not found.\n" );
	Report ( hOut, szOut );
	return FALSE;
  }
  
  if ( !pSessTranHdr->DataPathFound )
  {
    sprintf( szOut, "Foundation Data Path entry not found.\n");
    Report( hOut, szOut );
	return FALSE;
  }

  /* TZAK 10/16/97 - Added logic to handle when less than NUM_SESSTRAN_RECS 
  **                 entries exist in log file
  */
  if( pSessTranHdr->CmnHdrInfo.DtlCount > NUM_SESSTRAN_RECS )
  {
	  /* set counter to point to the last NUM_SESSTRAN_RECS records in memory */
	  i = pSessTranHdr->CmnHdrInfo.DtlCount - NUM_SESSTRAN_RECS;
  }
  else
  {
	  /* set counter to point to the first record in memory */
	  i = 0;
  }

  while( i < pSessTranHdr->CmnHdrInfo.DtlCount )
  {											   
    rc = RptSessTranDtl( hOut, &(pSTDetail[i++]) );
  }

  return 0;
}


SHORT RptSessTranDtl( HANDLE hOut, _ST_DETAIL *pSessTranDtl )
{
  CHAR szOut[255];

  sprintf( szOut, "%-8.8d  %-12.12s  %-8.8s  %-10.10s  %-12.12s  %-8.8s  %-8.8s\n",
           pSessTranDtl->MsgErrorNum,
		   pSessTranDtl->MsgSeverity,
		   pSessTranDtl->StDetailPgmName,
		   pSessTranDtl->MsgApplType,
		   pSessTranDtl->MsgErrorType,
		   pSessTranDtl->MsgSendDate,
		   pSessTranDtl->MsgSendTime );

  Report( hOut, szOut );

  sprintf( szOut, "  %-76.76s\n", pSessTranDtl->MsgErrMsgDecode );
  Report( hOut, szOut );
  sprintf( szOut, "  %-76.76s\n", pSessTranDtl->MsgApplData );
  Report( hOut, szOut );

   
   //char                MsgErrorArea[160];                          
   //char                MsgWinName[32];                              
   //long                MsgDepMsgNum;                                            
   //char                MsgDepMsgArea[160];                        
   //short               ExplanationCode;                                         
   //char                ErrorTagData[30];                          
   

  Report( hOut, "\n" );

  return 0;
}


SHORT OpenSTFile( CHAR *FileName, HFILE *phFile, HANDLE *phFileMap,
                  CHAR **ppFile, LONG *pFileSize )
{
  OFSTRUCT OFStruct;
  CHAR *pFile;
  SHORT rc = 0;
  LONG FileSize;

  *phFile = OpenFile( FileName, &OFStruct, OF_READ );

  if( *phFile != HFILE_ERROR )
  {
    if( *phFileMap  = CreateFileMapping( (HANDLE) *phFile, NULL, PAGE_READONLY, 0, 0, 
                                         NULL ))
	{
	  if( pFile = MapViewOfFile( *phFileMap, FILE_MAP_READ, 0, 0, 0 ))
	  {
		FileSize = GetFileSize( (HANDLE) *phFile, NULL );

		if( FileSize != 0xFFFFFFFF )
		{
	      if( *ppFile = malloc( FileSize ))
		  {
			/* Set return value of file size */
			*pFileSize = FileSize;

			/* Copy file into allocated buffer */
		    memcpy( *ppFile, pFile, FileSize );
		  }
		  else
		  {
		    /* ERROR: malloc failed */
		    fprintf( stderr, "ERROR: malloc failed.\n" );
		    rc = 1;
		  }
		}
		else
		{
		  /* ERROR: GetFileSize failed */
	      fprintf( stderr, "ERROR: GetFileSize for %s failed (%ld).\n",
		           FileName, GetLastError());
		  rc = 1;
		}   
	  }
	  else
	  {
	    /* ERROR: MapViewOfFile failed */
		fprintf( stderr, "ERROR: MapViewOfFile for %s failed (%ld).\n", 
		         FileName, GetLastError());
		rc = 1;
	  }
	}
	else
	{
	  /* ERROR: CreateFileMapping failed */
      fprintf( stderr, "ERROR: CreateFileMapping for %s failed (%ld).\n", 
               FileName, GetLastError());
	  rc = 1;
	}
  }
  else
  {
    /* ERROR: OpenFile failed */
    fprintf( stderr, "ERROR: OpenFile failed for %s (%ld).\n", 
             FileName, GetLastError());
	rc = 1;
  }

  return rc;
}


SHORT CloseSTFile( HFILE hFile, HANDLE hFileMap, CHAR *pFile )
{
  CloseHandle( hFileMap );
  CloseHandle( (HANDLE) hFile );
  free( pFile );

  return 0;
}
