#include <windows.h>
#include <winnetwk.h>
#include <stdio.h>
#include <string.h>
#include <conio.h>
#include "AZDI02.H"

/****************************************************************************
**																	
**		AZDI0202.C - Get Drive Mappings
**																			
****************************************************************************/
SHORT GetDriveMappings( _DRIVEMAP_HDR *pDriveMapHdr ) 
{
  BOOL  bSuccess, bConnected;
  LPDWORD nBufferSize;
  char szLocal[16];
  char szRemoteName[80];
  int i;
  short iCount = 0;


  /* Init Flags */
  bSuccess = FALSE;
  bConnected = FALSE;

  nBufferSize = (LPDWORD) 64;
  lstrcpy(szLocal, (LPSTR) "A:");

  /* Loop/Test for mapped drive(s). */
  for (i = 0; i < 26; i++) 
  {
     szLocal[0] = (char)('A' + i);
   
     switch (WNetGetConnection((LPSTR) szLocal, (LPSTR) szRemoteName, (LPDWORD) &nBufferSize)) 
     {
       case WN_SUCCESS:
            bSuccess   = TRUE;
            bConnected = TRUE;
       break;
     }
     
     /* If this is a mapped drive (connected) then store in pDriveDetail. */
     if (bConnected) 
     {
        strcpy( pDriveMapHdr->DriveMapDtl[iCount].DriveLetter,  (LPSTR) szLocal);
        strcpy( pDriveMapHdr->DriveMapDtl[iCount].DriveMapping, (LPSTR) szRemoteName);

        /* Increment connected drive counter */
        iCount++;

        bConnected = FALSE;
     }

   } /* of For i, for drives */


   /* Store map count to hdr */
   pDriveMapHdr->CmnHdrInfo.DtlCount = iCount;

		
   /*
   if (!bSuccess) 
      MessageBox(NULL, " No Redirected Local Drives", "Network Connections", MB_OK | MB_ICONEXCLAMATION);
   */

   return 0;
}


SHORT RptDriveMappings( HANDLE hOut, _DRIVEMAP_HDR *pDriveMapHdr ) 
{
  SHORT i;
  CHAR szOut[255];

  Report( hOut, "\n*** DRIVE MAPPINGS ***\n\n" );

  for( i=0; i<pDriveMapHdr->CmnHdrInfo.DtlCount; i++ )
  {
    sprintf( szOut, "%s %s\n", pDriveMapHdr->DriveMapDtl[i].DriveLetter,
	                           pDriveMapHdr->DriveMapDtl[i].DriveMapping );

	Report( hOut, szOut );
  }

  return 0;
}

