/*************************************************************************
**
**	AZDI02
**
**  The executable is built from several source files.  The names and
**  brief description of the information captured in each module 
**  follows:
**
**		AZDI0201	Burst information
**		AZDI0202	Drive mappings
**		AZDI0203	Inventory of Files
**		AZDI0204	Password Management Facility (PMF)
**		AZDI0205	Registry Entries
**		AZDI0206	Session Data
**		AZDI0207	Active Processes
**		AZDI0208    Session Transcript
**		AZDI0209	Foundation DS Configuration
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
  HANDLE           hOut;
  OFSTRUCT         OpenFileInfo;

  SHORT rc;

  rc = GetBurstInfo( &BurstHdr );

  rc = GetDriveMappings( &DriveMapHdr );

  rc = GetRegEntries( &RegEntriesHdr  );

  rc = GetActiveProcs( &ActiveProcsHdr );

  rc = GetSessTran( &SessTranHdr );

  rc = GetActiveHwnds ( &ActiveHwndsHdr );

  rc = GetDistSvcs( &DistSvcsHdr );

  /* Report results */
  hOut = (HANDLE) OpenFile( "cssdiag.rpt", &OpenFileInfo, OF_CREATE|OF_WRITE );

  if( hOut != (HANDLE) HFILE_ERROR )
  {
    rc = RptBurstInfo( hOut, &BurstHdr );

    rc = RptSessTran( hOut, &SessTranHdr );

    rc = RptRegEntries( hOut, &RegEntriesHdr  );

    rc = RptDistSvcs( hOut, &DistSvcsHdr );

    rc = RptDriveMappings( hOut, &DriveMapHdr );

    rc = RptActiveProcs( hOut, &ActiveProcsHdr );

    rc = RptActiveHwnds( hOut, &ActiveHwndsHdr );

	CloseHandle( hOut );
  }

  return 0;
}


SHORT Report( HANDLE hOut, CHAR *pszResults )
{
  SHORT rc = 0;
  LONG BytesWritten;

  WriteFile( hOut, pszResults, strlen( pszResults ), &BytesWritten, NULL );

  return rc;
}

