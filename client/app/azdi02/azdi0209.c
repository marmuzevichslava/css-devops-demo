/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
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
** 02/13/97    GHOWELL     16116   Windows Sockets APIs are now used to get
**                                    the Computer Name, Host Name, and IP
**                                    Address information instead of querying
**                                    the Registry. WinSock is portable, and
**                                    IP Addresses are stored differently in
**                                    the Registry for DHCP assigned IPs and
**                                    statically assigned IPs.
*************************************************************************/

#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <process.h>
#include "AZDI02.H"

SHORT GetDistSvcs      ( _DISTSVCS_HDR    *pDSHdr    ) /* AZDI0209.C */
{
	FILE 	*hiWinFND;
    CHAR 	fiWinFND[64];
    CHAR 	szSourceLine[1024];
	BOOL 	brc;	
	ULONG 	lSize;
   	CHAR	PathEnvVar[64];

    /* 02/13/97 GHOWELL - Commented out next four (used for Registry reads) */
    // long    lrc;
    // DWORD   dwValueType, dwValueSize;
    // HKEY    hKey;                    
    // CHAR    sSubKey[128];            

    /* 02/13/97 GHOWELL - Added next six */
    USHORT          HostNameRC = 0,
                    IPAddrRC   = 0;
    LPHOSTENT       pHostInfo;
    WSADATA         wsadata;
    WORD            wVer;
    struct in_addr  IPAddress;
	
    pDSHdr->CmnHdrInfo.DtlCount = 1;

	GetEnvironmentVariable( "SystemRoot", PathEnvVar, 64 );
	strcpy( fiWinFND, PathEnvVar);
	strcat( fiWinFND, "\\" );
    strcat( fiWinFND, FND_INI_FILE );  /* 02/12/97 GHOWELL - Changed from hardcoded file name */


    /************************************************************************
    **                                                                     **
    **    GET HOSTNAME AND IP ADDRESS THROUGH WINDOWS SOCKETS API CALLS    **
    **                                                                     **
    ************************************************************************/
    
    /* 02/13/97 GHOWELL - Added logic to retrieve Hostname and IP Address 
    **                    via Windows Sockets APIs
    */
    
    /* Start up Windows Sockets. If we get get an error, no data was retrieved,
    **     so set IP and Hostname accordingly.
    */
    wVer = MAKEWORD(1, 1);
    if (WSAStartup(wVer, &wsadata) != NO_ERROR) 
    {
	    strcpy( pDSHdr->TCPIPAddress, "Not found." );
        strcpy( pDSHdr->HostName, "Not found." );
    }
    else
    {
        /* C function to get Hostname */
        HostNameRC = gethostname(pDSHdr->HostName, sizeof(pDSHdr->HostName));

      	if ( HostNameRC )  /* if any return other than zero, an error occured */
    	{
		    strcpy( pDSHdr->HostName, "Not found." );
	    }
        
        /*  C function to get host information based on the HostName, returning
        **  a pointer to the information strucuture */
        pHostInfo = gethostbyname(pDSHdr->HostName);
    
       	if ( !pHostInfo || HostNameRC )  /* if the structure is null (no data), or we
                                         ** never got the host name, an error occured
                                         */
	    {
            strcpy( pDSHdr->TCPIPAddress, "Not found." );
    	}
        else   /* we have information in the structure */
        {
            /* gets IP Address from information structure */
            IPAddress = *(struct in_addr far *)pHostInfo->h_addr;  

            /* convert IP Address to character string*/
            strcpy(pDSHdr->TCPIPAddress, inet_ntoa(IPAddress));   
        }
    }

    /* 02/13/97 GHOWELL - End get Hostname and IP Address */



    /*************************************************************
 	**  OLD WAY  -  Retrieve Hostname from registry  -  OLD WAY
 	**/
    /* 02/13/97 GHOWELL - Commented out code. Instead of Registry, 
    **                    now use WinSock API to get HostName (done above)
    */
    //     memset( sSubKey, 0, sizeof(sSubKey) );
	//     strcpy( sSubKey, "System\\CurrentControlSet\\Services\\Tcpip\\Parameters\\" );
	//     
    //     lrc = RegOpenKeyEx
    //                 (HKEY_LOCAL_MACHINE,
    //                  sSubKey,
    //                  0,
    //                  KEY_READ,
    //                  &hKey);
    //     if (lrc != ERROR_SUCCESS)
	//     {	
	//     	/* Error occurred, registry problem */
	//     	strcpy( pDSHdr->HostName, "Not found." );
	//     }
	//     else
	//     /* Get Host Name */
	//     {
	//     	dwValueSize = sizeof(pDSHdr->HostName);
    //     	lrc = RegQueryValueEx
    //                 (hKey,
    //                  CMN_REG_HOST_NAME,
    //                  NULL,
    //                  &dwValueType,
    //                  pDSHdr->HostName,
    //                  &dwValueSize );
	//      	if (lrc != ERROR_SUCCESS)
	//         	{
	//     	    	/* Value not found */
	//     		    strcpy( pDSHdr->HostName, "Not found." );
	//      	}
    //   	} /* else */
    
    /************************************************
 	**  OLD WAY  -  Get TCP/IP Address  -  OLD WAY
 	**/
    /* 02/13/97 GHOWELL - Commented out code. Instead of Registry, 
    **                    now use WinSock API to get IP Address (done above)
    */
	//     memset( sSubKey, 0, sizeof(sSubKey) );
	//     strcpy( sSubKey, "System\\CurrentControlSet\\Services\\SMCISA1\\Parameters\\Tcpip\\" );
	//     
    //     lrc = RegOpenKeyEx
    //                 (HKEY_LOCAL_MACHINE,
    //                  sSubKey,
    //                  0,
    //                  KEY_READ,
    //                  &hKey);
    //     if (lrc != ERROR_SUCCESS)
	//     {	
	//     	/* Error occurred, registry problem */
	//     	strcpy( pDSHdr->TCPIPAddress, "Not found." );
	//     }
	//     else
	//     /* Get IP Address */
	//     {
	//     	dwValueSize = sizeof(pDSHdr->TCPIPAddress);
    //     	lrc = RegQueryValueEx
    //                 (hKey,
    //                  CMN_REG_IP_ADDRESS,
    //                  NULL,
    //                  &dwValueType,
    //                  pDSHdr->TCPIPAddress,
    //                  &dwValueSize );
	//     	if (lrc != ERROR_SUCCESS)
	//     	{
	//     		/* Value not found */
	//     		strcpy( pDSHdr->TCPIPAddress, "Not found." );
	//     	}
	//     } /* else */
        

    
    /***************************************************
 	* Open C:\<SYSTEM_ROOT>\KTFND.INI in read text mode
 	**/
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

			if ( strstr( szSourceLine, "InboundLH") != NULL )
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

  Report( hOut, "\n\n*** DS CONFIG INFO ***\n\n" );

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
	
