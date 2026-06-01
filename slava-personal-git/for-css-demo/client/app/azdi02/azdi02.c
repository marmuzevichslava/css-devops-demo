/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*************************************************************************
**
**	FILENAME:		AZDI02.C
**
**	DESCRIPTION:	The executable is built from several source files.  The 
**                  names and brief description of the information captured 
**                  in each module are as follows:
**
**              		AZDI0201	Burst information
**              		AZDI0202	Drive mappings
**              		AZDI0203	Inventory of Files
**              		AZDI0204	Password Management Facility (PMF)
**              		AZDI0205	Registry Entries
**              		AZDI0206	Session Data
**              		AZDI0207	Active Processes
**              		AZDI0208    Session Transcript
**	                	AZDI0209	Foundation DS Configuration
**              	    AZDI0210    Active Windows
**
**  CREATED:
**
**  REVISION HISTORY
**
**    DATE      REVISED BY  SIR #   DESCRIPTION OF CHANGE
**  --------    ----------  ------  ---------------------------------------
**  02/12/97    GHOWELL     16116    Commented out PMF functions - not used
**                                     Release 3.0, and replaced hardcoded
**                                     output file name with macro
*************************************************************************/

#include <windows.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <time.h>
#include <sys\types.h>
#include <sys\stat.h>

#include "AZDI02.H"

/*************************************************************************
**
**	main
**
*************************************************************************/
//SHORT main(int argc, char **argv)
int WINAPI WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpszCmdLine, int nCmdShow );
int WINAPI WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpszCmdLine, int nCmdShow ) 
{
  _BURST_HDR       BurstHdr;
  _DRIVEMAP_HDR    DriveMapHdr;
  _REGENTRIES_HDR  RegEntriesHdr;
  _ACTIVEPROCS_HDR ActiveProcsHdr;
  _SESSTRAN_HDR    SessTranHdr;
  _ACTIVEHWNDS_HDR ActiveHwndsHdr;
  _DISTSVCS_HDR    DistSvcsHdr;
  _SESSDATA_HDR	   SessDataHdr;
  // _PMF_HDR		   PmfHdr;   02/12/97 GHOWELL - PMF is not used in Rel. 3.0 
  _FILEINV_HDR	   FileInvHdr;
  HANDLE           hOut;
  OFSTRUCT         OpenFileInfo;
  _REG_LIST_HDR    RegListHdr;

  int nRegAccessFlag = 1;
  

  SHORT rc;

  memset( &RegListHdr, 0, sizeof(RegListHdr));

  //rc = GetPmfInfo( &PmfHdr );  02/12/97 GHOWELL - PMF is not used in Rel. 3.0 

  rc = GetSessData( &SessDataHdr );

  rc = GetRegEntries( &RegEntriesHdr, &RegListHdr, nRegAccessFlag );

  rc = GetFileInvInfo( &FileInvHdr );

  rc = GetDriveConnections( &DriveMapHdr );

  rc = GetDistSvcs( &DistSvcsHdr );

  rc = GetBurstInfo( &BurstHdr );

  rc = GetSessTran( &SessTranHdr );

  rc = GetActiveProcs( &ActiveProcsHdr );

  rc = GetActiveHwnds ( &ActiveHwndsHdr );



  /* Report results */

  /* 02/12/97 GHOWELL - Replaced hardcoded file name with macro defined in AZDI02.h */
  //hOut = (HANDLE) OpenFile( "c:\\c1cdiag.txt", &OpenFileInfo, OF_CREATE|OF_WRITE );
  hOut = (HANDLE) OpenFile( DIAG_OUTPUT_FILE, &OpenFileInfo, OF_CREATE|OF_WRITE ); 

  if( hOut != (HANDLE) HFILE_ERROR )
  {
    //rc = RptPmfInfo( hOut, &PmfHdr );  02/12/97 GHOWELL - PMF is not used in Rel. 3.0 

	rc = RptSessData( hOut, &SessDataHdr );

    rc = RptRegEntries( hOut, &RegEntriesHdr, &RegListHdr, nRegAccessFlag );

    rc = RptFileInvInfo( hOut, &FileInvHdr );

    rc = RptDriveMappings( hOut, &DriveMapHdr );

    rc = RptDistSvcs( hOut, &DistSvcsHdr );

    rc = RptBurstInfo( hOut, &BurstHdr );

    rc = RptSessTran( hOut, &SessTranHdr );

    rc = RptActiveProcs( hOut, &ActiveProcsHdr );

    rc = RptActiveHwnds( hOut, &ActiveHwndsHdr );

	CloseHandle( hOut );
  }

  	rc = FreeMemRegEntries(&RegEntriesHdr, &RegListHdr);/* AZDI0205.C */

  return 0;
}


SHORT Report( HANDLE hOut, CHAR *pszResults )
{
  SHORT rc = 0;
  LONG BytesWritten;

  WriteFile( hOut, pszResults, strlen( pszResults ), &BytesWritten, NULL );

  return rc;
}

