/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*************************************************************************
**
**	FILENAME:		AZDI0206.C - Get Session Data Information
**
**	DESCRIPTION:  This function captures the current session data and
**                sends the data to a report.  The heading for this section
**                of data in the report will be  '*** Session Data ***'.
**                The following information will be displayed:
**							Printer
**							Domain Number
**							Station Number
**							Resource Rights
**							LAN ID
**							Strict Security Flag
**							User Name
**							Work Group
**							Work Location
**							Security Group
**							User Area Code
**							User Phone Number
**							User Phone Extension
**							RA Number
**							Internal Mail							  
**
** REVISION HISTORY
**
** DATE        REVISED BY  SIR #   DESCRIPTION OF CHANGE
** --------    ----------  ------  ---------------------------------------
** 04/11/95    EHOPPE			   Creation
** 02/12/97    GHOWELL     16116   Called Security to get resource rights 
**                                   (info no longer in ArchData structure).
*************************************************************************/

#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include "AZDI02.H"
#include <conio.h>
#include <float.h>
#include <limits.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdarg.h>

#define  FND_FE_INCL
#define  FND_IM_INCL
#define  FND_EH_INCL
#define  FND_PS_INCL
#define  FND_MS_INCL
#define  FND_CF_INCL
#define  FND_ST_INCL
#define  FND_OS_INCL
#define  FND_CTCONV_INCL
#define  FND_VERSION2

#include <kglxk000.h>

/*
**   The following #define is required to prevent the architecture from
**       wrapping the CodesTableServices Function.  This program is not
**       a FOUNDATION generated application, so therefore, the standard
**       architecture components don't exist (EAIA, ABHI, etc.).
*/
#define EXCLUDE_FND_WRAPPERS
#define INCL_C1CBASE
#define INCL_AGRWN01
#define INCL_C1CPRIV
#include <c1c.h>
#include <azrcsm01.h>

SHORT GetSessData      ( _SESSDATA_HDR    *pSessDataHdr    )
{

	CMN_HMEM          hSessionData;
	_AZRCSM01SESSDATA *pSessionData;
	SHORT FndGenRC;

    /*
    |   See if shared memory already exists
    */
    FndGenRC = CmnMemGetNamedHandle (CMN_SESSDATA_MEM_NAME,
                                     &hSessionData,
                                     CMN_NULL_ARCH_PARMS);

    if ((FndGenRC == CMN_SUCCESS)
         &&
        (hSessionData))
    {
	  /*
	  |    If Shared memory exists, get a pointer to the allocated memory block
	  */
	  FndGenRC = CmnMemGetPointer (hSessionData,
	     					       &pSessionData,
							       CMN_NULL_ARCH_PARMS);

	    if( FndGenRC == CMN_SUCCESS )
	    {
	      pSessDataHdr->RetCode = CMN_SUCCESS;
		  /*  Copy architecture and application data structures */
		  memcpy ( &(pSessDataHdr->ArchData), &(pSessionData->Azrcsm01ArchData), sizeof(_AZRCSM01ARCHDATA));
		  memcpy ( &(pSessDataHdr->ApplData), &(pSessionData->Azgrsm03ApplData), sizeof(_AZGRSM03APPLDATA));
        }
	    else
        {
	      pSessDataHdr->RetCode = FndGenRC;
		}
    }
    else
    {
      pSessDataHdr->RetCode = FndGenRC;
    }		

    return(0);
}

SHORT RptSessData      ( HANDLE hOut, _SESSDATA_HDR    *pSessDataHdr    )
{
    CHAR szOut[255];
	INT  rsrcctr, linectr;

    //_FND_ERROR_BLOCK  FndGenErrorBlock;
    USHORT            FndGenRC = 0;
	SHORT             ReturnCode = 0;
    _CMN_RESOURCE_ARRAY ResourceArray[CMN_RESOURCE_ARRAY_MAX];
    SHORT             ResourceCount;

    HWND              Hwnd;     /* 02/15/97 GHOWELL Added */

	
    if (pSessDataHdr->RetCode == CMN_SUCCESS)
	{
	  sprintf( szOut, "\n\n*** SESSION DATA ***\n\n" );
	  Report( hOut, szOut );
	  
	  /*
	  |		Send the architecture data to the report
	  */
	  sprintf( szOut, "Printer:         %s\n", pSessDataHdr->ArchData.CdPrinter );
	  Report( hOut, szOut );
	  sprintf( szOut, "Domain #:        %ld\n", pSessDataHdr->ArchData.Nodomain );
	  Report( hOut, szOut );
	  sprintf( szOut, "Station #:       %ld\n", pSessDataHdr->ArchData.NoStation );
	  Report( hOut, szOut );

      sprintf( szOut, "\nResource Rights:\n" );
      Report( hOut, szOut );															  
	  rsrcctr = 0;
	  linectr = 0;
	  
      
      /* 02/12/97 GHOWELL - Called Security to get all dialog rights. This information
      **                    is no longer in the ArchData structure. If an error code
      **                    is returned from the call, display the warning box.
      */
      FndGenRC = CmnSecCallSecurity( CMN_NULL_ARCH_PARMS,
  	  							     CMN_SEC_TRANSTYPE_GETALLRIGHTS,
								     &ReturnCode,
                                     &ResourceCount,
                          		     &ResourceArray );

      if ( FndGenRC != CMN_SUCCESS )
      {

          ReturnCode = CmnOsDisplayMessageBox( Hwnd,
                                               CMN_WARNING,
                                               SECURITY_ERROR_MESSAGE );

      } 

      /* 02/12/97 GHOWELL - Changed array max to macro and changed reference to 
      **                    ArchData Resource Array to the Resource Array returned
      **                    from CmnSecCallSecurity
      */
	  while( rsrcctr < CMN_RESOURCE_ARRAY_MAX && 
             strcmp( ResourceArray[rsrcctr].ResourceId, "" ) != 0 )
 	  {
	    memset( szOut, 0, sizeof szOut );
	 	while( linectr < 8 )
		  {
		  strcat( szOut, ResourceArray[rsrcctr].ResourceId );
		  strcat( szOut, " " );
		  strcat( szOut, ResourceArray[rsrcctr].ResourceRight );
		  strcat( szOut, " " );
		  linectr++;
		  rsrcctr++;
		  }
		strcat( szOut, "\n" );
		Report( hOut, szOut );
		linectr = 0;
	  }	 

      /* 02/13/97 GHOWELL - LAN IDs no longer returned by Session Data - use 
      **                    Computer Name and IP Address instead.  GDT is not
      **                    reported by CSS Diagnostics
      */
	  // sprintf( szOut, "\nLAN ID:        %s\n", pSessDataHdr->ArchData.TxLanId );
	  // Report( hOut, szOut );
	  // sprintf( szOut, "Control Block:   %s\n", pSessDataHdr->ArchData.pGDTControlBlock );
	  // Report( hOut, szOut );															  

      /* 02/13/97 GHOWELL - Strict Sec Flag is now a string, not a character */
	  sprintf( szOut, "\nStrict Sec Flag: %s\n", pSessDataHdr->ArchData.FlStrictSecurity );
	  Report( hOut, szOut );

	  /*  The filler lines are not needed */
      //  sprintf( szOut, "Char Filler:     %s\n", pSessDataHdr->ArchData.CharFiller );
	  //  Report( hOut, szOut );
	  //  sprintf( szOut, "Cd Filler:       %s\n", pSessDataHdr->ArchData.CdFiller );
	  //  Report( hOut, szOut );															  
    
	  /*
	  |		Send the application data to the report
	  */
	  sprintf( szOut, "\nUser Name:     %s\n", pSessDataHdr->ApplData.NmUser );
	  Report( hOut, szOut );
	  sprintf( szOut, "Work Group:      %s\n", pSessDataHdr->ApplData.KyPwqGrp );
	  Report( hOut, szOut );
	  sprintf( szOut, "Work Location:   %s\n", pSessDataHdr->ApplData.CdWorkLocation );
	  Report( hOut, szOut );
	  sprintf( szOut, "Security Group:  %s\n", pSessDataHdr->ApplData.CdSecurityGroup );
	  Report( hOut, szOut );
	  sprintf( szOut, "User Area Code:  %s\n", pSessDataHdr->ApplData.TxUserAcd );
	  Report( hOut, szOut );
	  sprintf( szOut, "User Phone #:    %s\n", pSessDataHdr->ApplData.TxUserPhnNo );
	  Report( hOut, szOut );
	  sprintf( szOut, "User Phone Ext:  %s\n", pSessDataHdr->ApplData.TxUserPhnExtn );
	  Report( hOut, szOut );
	  sprintf( szOut, "RA Number:       %s\n", pSessDataHdr->ApplData.NoRa );
	  Report( hOut, szOut );
	  sprintf( szOut, "Internal Mail:   %s\n", pSessDataHdr->ApplData.CdInternalMail );
	  Report( hOut, szOut );

	  /*  The filler lines are not needed */
	  //sprintf( szOut, "Internal Filler: %s\n", pSessDataHdr->ApplData.CdFiller );
	  //Report( hOut, szOut );															  
	}  
	else
	{
	  sprintf( szOut, "The Session Data could not be found." );
	  Report( hOut, szOut );
	  sprintf( szOut, "Return Code:  %ld\n", pSessDataHdr->RetCode );
	  Report( hOut, szOut );
	}

  return 0;
}


