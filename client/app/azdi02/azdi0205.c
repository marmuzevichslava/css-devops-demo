#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "AZDI02.H"

/*************************************************************************
**
**	FILENAME:		AZDI0205.C - Get Registry Information
**
**	DESCRIPTION:	This function queries the Registry using WIN32 functions, and
**					populates the Registry Entries Header record with the following
**					information:
**								Default Server
**								Department ID (RA#)
**								User ID
**								Login Script
**								CSR Configuration File Path
**
** REVISION HISTORY
**
** DATE        REVISED BY  SIR #   DESCRIPTION OF CHANGE
** --------    ----------  ------  ---------------------------------------
** 03/22/95    DKOLODZI			   Creation
*************************************************************************/

SHORT GetRegEntries( _REGENTRIES_HDR  *pRegEntriesHdr  ) /* AZDI0205.C */
{
    long    lrc;
    DWORD   dwValueType, dwValueSize;
    HKEY    hKey;
    CHAR    sSubKey[64];
	
	pRegEntriesHdr->CmnHdrInfo.DtlCount = 1;
	pRegEntriesHdr->RegCSRKeySuccess 	= TRUE;
	pRegEntriesHdr->RegPMFKeySuccess 	= TRUE;
	pRegEntriesHdr->RegVERKeySuccess 	= TRUE;

	/* Get PMF Information from Registry*/
	
	strcpy(sSubKey, "Software\\FPC\\PMF\\CurrentVersion\\");
	
    lrc = RegOpenKeyEx
                (HKEY_LOCAL_MACHINE,
                 sSubKey,
                 0,
                 KEY_READ,
                 &hKey);
    if (lrc != ERROR_SUCCESS)
	{	
		/*Error occurred, registry problem*/
		pRegEntriesHdr->RegPMFKeySuccess = FALSE;
		strcpy( pRegEntriesHdr->RegDefaultServer, "Not found." );
		strcpy( pRegEntriesHdr->RegLastDeptID,    "Not found." );
		strcpy( pRegEntriesHdr->RegLastUserID,    "Not found." );
		strcpy( pRegEntriesHdr->RegLoginScript,   "Not found." );
	}
	else
	/* Get Default Server */
	{
		dwValueSize = sizeof(pRegEntriesHdr->RegDefaultServer);
    	lrc = RegQueryValueEx
                (hKey,
                 CMN_REG_DEFAULT_SERVER,
                 NULL,
                 &dwValueType,
                 pRegEntriesHdr->RegDefaultServer,
                 &dwValueSize );

		if(lrc != ERROR_SUCCESS)
		{
		/*Registry entries not found.*/
			strcpy( pRegEntriesHdr->RegDefaultServer, "Not found." );
		}

		/* Get Department ID (RA#) */
		dwValueSize = sizeof(pRegEntriesHdr->RegLastDeptID);
    	lrc = RegQueryValueEx
                (hKey,
                 CMN_REG_LAST_DEPT_ID,
                 NULL,
                 &dwValueType,
                 pRegEntriesHdr->RegLastDeptID,
                 &dwValueSize);
		if(lrc != ERROR_SUCCESS)
		{
			/*Registry entries not found.*/
			strcpy( pRegEntriesHdr->RegLastDeptID, "Not found." );
		}
	
		/* Get User ID */
		dwValueSize = sizeof(pRegEntriesHdr->RegLastUserID);
    	lrc = RegQueryValueEx
                (hKey,
                 CMN_REG_LAST_USER_ID,
                 NULL,
                 &dwValueType,
                 pRegEntriesHdr->RegLastUserID,
                 &dwValueSize);
		if(lrc != ERROR_SUCCESS)
		{
			/*Registry entries not found.*/
			strcpy( pRegEntriesHdr->RegLastUserID, "Not found." );
		}

		/* Get Login Script Filename */
		dwValueSize = sizeof(pRegEntriesHdr->RegLoginScript);
    	lrc = RegQueryValueEx
                (hKey,
                 CMN_REG_LOGIN_SCRIPT,
                 NULL,
                 &dwValueType,
                 pRegEntriesHdr->RegLoginScript,
                 &dwValueSize);
		if(lrc != ERROR_SUCCESS)
		{
			/*Registry entries not found.*/
			strcpy( pRegEntriesHdr->RegLoginScript, "Not found." );
		}

    	CloseHandle (hKey);
	
	} /* else*/

	/* Get CSS Information from Registry */	
	strcpy(sSubKey, "Software\\FPC\\CSS\\CurrentVersion\\CSR\\");	
    lrc = RegOpenKeyEx
                (HKEY_LOCAL_MACHINE,
                 sSubKey,
                 0,
                 KEY_READ,
                 &hKey);
    if (lrc != ERROR_SUCCESS)
	{	
		/*Error occurred, registry problem*/
		pRegEntriesHdr->RegCSRKeySuccess = FALSE;
		strcpy( pRegEntriesHdr->RegCSRConfigPath, "Not found." );
	}
	else
	{
		/* Get CSR Config Path */
		dwValueSize = sizeof(pRegEntriesHdr->RegCSRConfigPath);
    	lrc = RegQueryValueEx
                (hKey,
                 CMN_REG_CSR_CONFIG_PATH,
                 NULL,
                 &dwValueType,
                 pRegEntriesHdr->RegCSRConfigPath,
                 &dwValueSize);
		if(lrc != ERROR_SUCCESS)
		{
			/*Registry entries not found.*/
			strcpy( pRegEntriesHdr->RegCSRConfigPath, "Not found." );
		}
      	CloseHandle (hKey);
	}
	/* Get CSS Version number  */
	strcpy(sSubKey, "Software\\FPC\\CSS\\tivoli\\");	
    lrc = RegOpenKeyEx
                (HKEY_LOCAL_MACHINE,
                 sSubKey,
                 0,
                 KEY_READ,
                 &hKey);
    if (lrc != ERROR_SUCCESS)
	{	
		/*Registry entries not found.*/
		pRegEntriesHdr->RegVERKeySuccess = FALSE;
		strcpy( pRegEntriesHdr->RegCssVersion, "Not found." );
	}
	else
	{
	  		/* Get CSS version number */
		dwValueSize = sizeof(pRegEntriesHdr->RegCssVersion);
    	lrc = RegQueryValueEx
                (hKey,
                 CMN_REG_CSS_VERSION,
                 NULL,
                 &dwValueType,
                 pRegEntriesHdr->RegCssVersion,
                 &dwValueSize);
		if(lrc != ERROR_SUCCESS)
		{
			/*Registry entries not found.*/
			strcpy( pRegEntriesHdr->RegCssVersion, "Not found." );
	  	}
    	CloseHandle (hKey);
	}


	return TRUE;

} /* GetRegEntries*/		


SHORT RptRegEntries( HANDLE hOut, _REGENTRIES_HDR  *pRegEntriesHdr  ) /* AZDI0205.C */
{
  CHAR szOut[255];

  Report( hOut, "\n*** REGISTRY ENTRIES ***\n\n" );

  if( !pRegEntriesHdr->RegCSRKeySuccess)
  {
  	sprintf( szOut, "CSR Key does not exist!!!\n");
    Report( hOut, szOut );
  }
  if( !pRegEntriesHdr->RegPMFKeySuccess)
  {
  	sprintf( szOut, "PMF Key does not exist!!!\n");
    Report( hOut, szOut );
  }
  if( !pRegEntriesHdr->RegVERKeySuccess)
  {
  	sprintf( szOut, "Tivoli Key does not exist!!!\n");
    Report( hOut, szOut );
  }

  sprintf( szOut, "CSS Version:     %s\n", pRegEntriesHdr->RegCssVersion );
  Report( hOut, szOut );
  sprintf( szOut, "Default Server:  %s\n", pRegEntriesHdr->RegDefaultServer );
  Report( hOut, szOut );
  sprintf( szOut, "Dept. ID:        %s\n", pRegEntriesHdr->RegLastDeptID );
  Report( hOut, szOut );
  sprintf( szOut, "Last User ID:    %s\n", pRegEntriesHdr->RegLastUserID );
  Report( hOut, szOut );
  sprintf( szOut, "Login Script:    %s\n", pRegEntriesHdr->RegLoginScript );
  Report( hOut, szOut );
  sprintf( szOut, "CSR Config Path: %s\n", pRegEntriesHdr->RegCSRConfigPath );
  Report( hOut, szOut );
  
  return 0;
}
