/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*************************************************************************
**
**	FILENAME:		AZDI0210.C - Get Active Windows
**
**	DESCRIPTION:	This function obtains all active windows and writes the
**                  list to the output file.
**
**  CREATED:
**
**  REVISION HISTORY
**
**  DATE        REVISED BY  SIR #   DESCRIPTION OF CHANGE
**  --------    ----------  ------  ---------------------------------------
**  02/13/97    GHOWELL     16116   Printed total number of active windows
**                                     with a title to the report file
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
  CHAR    szOut[ 255 ];
  USHORT  i = 0,
          TitledWindowsCtr = 0;  /* 02/13/97 GHOWELL Added */

  Report( hOut, "\n\n*** ACTIVE WINDOWS ***\n\n" );

  sprintf( szOut, "Total Active Windows: %d\n\n", 
           pActiveHwndsHdr->CmnHdrInfo.DtlCount );
  Report( hOut, szOut );

  for( i=0, TitledWindowsCtr=0; i<pActiveHwndsHdr->CmnHdrInfo.DtlCount; i++ )
  {
	if( strlen( pActiveHwndsHdr->ActiveHwndsDtl[i].Text ))
	{
	  sprintf( szOut, "  %-77.77s\n", pActiveHwndsHdr->ActiveHwndsDtl[i].Text );
	  Report( hOut, szOut );
      TitledWindowsCtr++;
	}
  }

  /* 02/13/97 GHOWELL - Some windows do not have a title, so are included in 
  **                    the Total Active Windows count in the report, but do not
  **                    not appear in the list. This next count shows a count of 
  **                    only windows with a title (windows listed in the report).
  */
  sprintf( szOut, "\nTotal Active \"Titled\" Windows: %d\n\n", 
           TitledWindowsCtr );
  Report( hOut, szOut );
 
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
