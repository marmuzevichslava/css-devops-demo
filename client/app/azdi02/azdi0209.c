#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <process.h>
#include "AZDI02.H"

/*************************************************************************
**
**	FILENAME:		AZDI0209.C - Get Distribution Services Information
**
**	DESCRIPTION:	This function retrieves the DS Configuration information from
**					the KTFND.INI file.  This information includes the following:
**								Local Node Domain & Station
**								Local Node IP Address and Port
**								Address Server Domain & Station
**								Address Server IP Address & Port
**								Foundation Executable, Data, and Code Paths
**					The function also retrieves the Host name and TCP/IP Address
**					from the registry, and gets the Computer Name using the 
**					GetComputerName API.
**
** REVISION HISTORY
**
** DATE        REVISED BY  SIR #   DESCRIPTION OF CHANGE
** --------    ----------  ------  ---------------------------------------
** 03/29/95    DKOLODZI			   Creation
*************************************************************************/

SHORT GetDistSvcs      ( _DISTSVCS_HDR    *pDSHdr    ) /* AZDI0209.C */
{
	FILE 	*hiWinFND;
    CHAR 	*fiWinFND 	 = "c:\\winnt\\ktfnd.ini";
    CHAR 	szSourceLine[1024];
	BOOL 	brc;	
	ULONG 	lSize;
    long    lrc;
    DWORD   dwValueType, dwValueSize;
    HKEY    hKey;
    CHAR    sSubKey[128];

	pDSHdr->CmnHdrInfo.DtlCount = 1;

	/******************************************
 	* Get TCP/IP Address
 	*/
	memset( sSubKey, 0, sizeof(sSubKey) );
	strcpy( sSubKey, "System\\CurrentControlSet\\Services\\SMCISA1\\Parameters\\Tcpip\\" );
	
    lrc = RegOpenKeyEx
                (HKEY_LOCAL_MACHINE,
                 sSubKey,
                 0,
                 KEY_READ,
                 &hKey);
    if (lrc != ERROR_SUCCESS)
	{	
		/*Error occurred, registry problem*/
		strcpy( pDSHdr->TCPIPAddress, "Not found." );
	}
	else
	/* Get IP Address */
	{
		dwValueSize = sizeof(pDSHdr->TCPIPAddress);
    	lrc = RegQueryValueEx
                (hKey,
                 CMN_REG_IP_ADDRESS,
                 NULL,
                 &dwValueType,
                 pDSHdr->TCPIPAddress,
                 &dwValueSize );
		if (lrc != ERROR_SUCCESS)
		{
			/*Value not found*/
			strcpy( pDSHdr->TCPIPAddress, "Not found." );
		}
	} /*else*/

	/******************************************
 	* Retrieve Hostname from registry
 	*/
	memset( sSubKey, 0, sizeof(sSubKey) );
	strcpy( sSubKey, "System\\CurrentControlSet\\Services\\Tcpip\\Parameters\\" );
	
    lrc = RegOpenKeyEx
                (HKEY_LOCAL_MACHINE,
                 sSubKey,
                 0,
                 KEY_READ,
                 &hKey);
    if (lrc != ERROR_SUCCESS)
	{	
		/*Error occurred, registry problem*/
		strcpy( pDSHdr->HostName, "Not found." );
	}
	else
	/* Get Host Name */
	{
		dwValueSize = sizeof(pDSHdr->HostName);
    	lrc = RegQueryValueEx
                (hKey,
                 CMN_REG_HOST_NAME,
                 NULL,
                 &dwValueType,
                 pDSHdr->HostName,
                 &dwValueSize );
		if (lrc != ERROR_SUCCESS)
		{
			/*Value not found*/
			strcpy( pDSHdr->HostName, "Not found." );
		}
	} /*else*/

	/***************************************************
 	* Open C:\WINDOWS\KTFND.INI in read text mode
 	*/
	strcpy( pDSHdr->FndDdsSetting, "Not found.\n" );
	strcpy( pDSHdr->LocalNodeDomain, "Not found.\n" );
	strcpy( pDSHdr->LocalNodeStation, "Not found.\n" );
	strcpy( pDSHdr->LocalNodeIPInfo, "Not found.\n" );
	strcpy( pDSHdr->AddSrvNodeDomain, "Not found.\n" );
	strcpy( pDSHdr->AddSrvNodeStation, "Not found.\n" );
	strcpy( pDSHdr->AddSrvNodeIPInfo, "Not found.\n" );
	strcpy( pDSHdr->FndPathPath, "Not found.\n" );
	strcpy( pDSHdr->FndCodePath, "Not found.\n" );
	strcpy( pDSHdr->FndDataPath, "Not found.\n" );
	strcpy( pDSHdr->FndDdsSetting, "Not found.\n" );

    if ( (hiWinFND = fopen( fiWinFND, "rt" )) != NULL )
	{
		pDSHdr->KTFNDFound = TRUE;
        while (fgets( szSourceLine, 1024, hiWinFND ) != NULL)
		{
        	if (strstr( szSourceLine, "ds_domain") != NULL)
			{
				memset( pDSHdr->LocalNodeDomain, 0, sizeof(pDSHdr->LocalNodeDomain) );
				strcpy( pDSHdr->LocalNodeDomain, szSourceLine+10 );
			}

			if ( strstr( szSourceLine, "ds_station") != NULL )
			{
				memset( pDSHdr->LocalNodeStation, 0, sizeof(pDSHdr->LocalNodeStation) );
				strcpy( pDSHdr->LocalNodeStation, szSourceLine+11 );
			}

			if ( strstr( szSourceLine, "ds_asdomain") != NULL )
			{
				memset( pDSHdr->AddSrvNodeDomain, 0, sizeof(pDSHdr->AddSrvNodeDomain) );
				strcpy( pDSHdr->AddSrvNodeDomain, szSourceLine+12 );
			}

			if ( strstr( szSourceLine, "ds_asstation") != NULL )
			{
				memset( pDSHdr->AddSrvNodeStation, 0, sizeof(pDSHdr->AddSrvNodeStation) );
				strcpy( pDSHdr->AddSrvNodeStation, szSourceLine+13 );
			}

			if ( strstr( szSourceLine, "INboundLH") != NULL )
			{
				memset( pDSHdr->LocalNodeIPInfo, 0, sizeof(pDSHdr->LocalNodeIPInfo) );
				strncpy( pDSHdr->LocalNodeIPInfo, szSourceLine, sizeof(pDSHdr->LocalNodeIPInfo) );
			}

			if ( strstr( szSourceLine, "ASNodes") != NULL )
			{
				memset( pDSHdr->AddSrvNodeIPInfo, 0, sizeof(pDSHdr->AddSrvNodeIPInfo) );
				strncpy( pDSHdr->AddSrvNodeIPInfo, szSourceLine, sizeof(pDSHdr->AddSrvNodeIPInfo) );
			}
			
			if ( strstr( szSourceLine, "FNDPATH") != NULL )
			{
				memset( pDSHdr->FndPathPath, 0, sizeof(pDSHdr->FndPathPath) );
				strcpy( pDSHdr->FndPathPath, szSourceLine+8 );
			}

			if ( strstr( szSourceLine, "FNDDATA") != NULL )
			{
				memset( pDSHdr->FndDataPath, 0, sizeof(pDSHdr->FndDataPath) );
				strcpy( pDSHdr->FndDataPath, szSourceLine+8 );
			}

			if ( strstr( szSourceLine, "FNDCODE=") != NULL )
			{
				memset( pDSHdr->FndCodePath, 0, sizeof(pDSHdr->FndCodePath) );
				strcpy( pDSHdr->FndCodePath, szSourceLine+8 );
			}

			if ( strstr( szSourceLine, "FNDCODE =") != NULL )
			{
				memset( pDSHdr->FndCodePath, 0, sizeof(pDSHdr->FndCodePath) );
				strcpy( pDSHdr->FndCodePath, szSourceLine+8 );
			}

			if ( strstr( szSourceLine, "FNDDS") != NULL )
			{
				memset( pDSHdr->FndDdsSetting, 0, sizeof(pDSHdr->FndDdsSetting) );
				strcpy( pDSHdr->FndDdsSetting, szSourceLine+6 );
			}
		} /*while*/
	} /*if*/
	else
	{
		pDSHdr->KTFNDFound = FALSE;
	}

	/***************************************************
 	* Get Computer Name
 	*/
	
	lSize = sizeof(pDSHdr->WinComputerName);

	brc = GetComputerName( pDSHdr->WinComputerName, &lSize );

	if ( !brc )
	{
		strcpy( pDSHdr->WinComputerName, "Not found." );
	}
	
    fcloseall();
	
	return TRUE;

} /* GetDSInfo */


SHORT RptDistSvcs( HANDLE hOut, _DISTSVCS_HDR    *pDSHdr    ) /* AZDI0209.C */
{
  CHAR szOut[255];

  Report( hOut, "\n*** DS CONFIG INFO ***\n\n" );

  sprintf( szOut, "Computer Name:           %s\n", pDSHdr->WinComputerName );
  Report( hOut, szOut );
  sprintf( szOut, "Host Name:               %s\n", pDSHdr->HostName );
  Report( hOut, szOut );
  sprintf( szOut, "TCP/IP Address:          %s\n\n", pDSHdr->TCPIPAddress );
  Report( hOut, szOut );
    
  if( !pDSHdr->KTFNDFound )
  {
  	sprintf( szOut, "KTFND File not found!!!\n\n");
  	Report( hOut, szOut );
  }  

  sprintf( szOut, "Local Node Domain:       %s", pDSHdr->LocalNodeDomain );
  Report( hOut, szOut );
  sprintf( szOut, "Local Node Station:      %s", pDSHdr->LocalNodeStation );
  Report( hOut, szOut );
  sprintf( szOut, "Local Node IP Info:      %s\n", pDSHdr->LocalNodeIPInfo );
  Report( hOut, szOut );
  sprintf( szOut, "Address Server Domain:   %s", pDSHdr->AddSrvNodeDomain );
  Report( hOut, szOut );
  sprintf( szOut, "Address Server Station:  %s", pDSHdr->AddSrvNodeStation );
  Report( hOut, szOut );
  sprintf( szOut, "Address Server IP Info:  %s\n", pDSHdr->AddSrvNodeIPInfo );
  Report( hOut, szOut );
  sprintf( szOut, "Foundation Path:         %s", pDSHdr->FndPathPath );
  Report( hOut, szOut );
  sprintf( szOut, "Foundation Data Path:    %s", pDSHdr->FndDataPath );
  Report( hOut, szOut );
  sprintf( szOut, "Foundation Code Path:    %s", pDSHdr->FndCodePath );
  Report( hOut, szOut );
  sprintf( szOut, "Foundation DS Setting:   %s\n", pDSHdr->FndDdsSetting );
  Report( hOut, szOut );
     
  return 0;
}
	
