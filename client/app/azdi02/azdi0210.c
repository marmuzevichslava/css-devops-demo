/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*************************************************************************
**
**		AZDI0210.C - Get Active Windows
**
*************************************************************************/

#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "AZDI02.h"

BOOL CALLBACK EnumWindowsProc( HWND hwnd, LPARAM lParam );

/********************************************************
*														
*  GetActiveHwnds											
*														
********************************************************/
SHORT GetActiveHwnds ( _ACTIVEHWNDS_HDR *pActiveHwndsHdr ) 
{
  pActiveHwndsHdr->CmnHdrInfo.DtlCount = 0;

  EnumWindows( EnumWindowsProc, (LPARAM) pActiveHwndsHdr );

  return 0;
}


SHORT RptActiveHwnds ( HANDLE hOut, _ACTIVEHWNDS_HDR *pActiveHwndsHdr ) 
{
  CHAR szOut[ 255 ];
  SHORT i;

  Report( hOut, "\n*** ACTIVE WINDOWS ***\n\n" );

  sprintf( szOut, "Total Active Windows: %d.\n\n", 
           pActiveHwndsHdr->CmnHdrInfo.DtlCount );
  Report( hOut, szOut );

  for( i=0; i<pActiveHwndsHdr->CmnHdrInfo.DtlCount; i++ )
  {
	if( strlen( pActiveHwndsHdr->ActiveHwndsDtl[i].Text ))
	{
	  sprintf( szOut, "  %-77.77s\n", pActiveHwndsHdr->ActiveHwndsDtl[i].Text );
	  Report( hOut, szOut );
	}
  }

  return 0;
}


BOOL CALLBACK EnumWindowsProc( HWND hwnd, LPARAM lParam )
{
  _ACTIVEHWNDS_HDR *pActiveHwndsHdr = (_ACTIVEHWNDS_HDR *) lParam;
  _ACTIVEHWNDS_DTL *pDtl;

  pDtl = &(pActiveHwndsHdr->ActiveHwndsDtl[pActiveHwndsHdr->CmnHdrInfo.DtlCount]);

  pDtl->hwnd = hwnd;
  GetWindowText( hwnd, pDtl->Text, HWND_TEXT_LEN-1 );

  pActiveHwndsHdr->CmnHdrInfo.DtlCount++;

  if( pActiveHwndsHdr->CmnHdrInfo.DtlCount == MAX_WINDOWS )
  {
    return FALSE;
  }
  else
  {
    return TRUE;
  }
}
