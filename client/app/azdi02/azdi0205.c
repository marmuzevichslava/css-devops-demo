/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
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
** 02/12/97    GHOWELL     16116   Modified GetRegEntries and RptRegEntries to not
**                                   retrieve or report PMF Registry Entries, as 
**                                   they are not part of Release 3.0.  Also replaced 
**                                   hard-coded Registry Paths with macros.  The 
**                                   SolutionWorks key will be retrieved first, 
**                                   then the FPC key if the SW key is not found.
*************************************************************************/
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "AZDI02.H"

SHORT GetRegEntries( _REGENTRIES_HDR  *pRegEntriesHdr , _REG_LIST_HDR *pRegListHdr,
					 int nRegAccessFlag) /* AZDI0205.C */
{
	
    long    lrc,
			lrcQueryInfo,
    		lrcEnumValue;

    DWORD   dwValueType = 0,
    	    dwValueSize = 0,
    	    dwKeyNameLen = 0, 
    	    dwSubKey = 0, 
    	    dwSubKeyValue = 0, 
    		dwValueData = 0, 
    		dwClassSize = 0, 
    		dwNumSubKeys = 0, 
    		dwMaxSubKeyLen = 0, 
    		dwMaxClassLen = 0,
    		dwNumValueEntries = 0, 
    		dwMaxValueName = 0, 
    		dwMaxValueData = 0, 
    		dwSecurityDesc = 0, 
    		dwValueTypeBuffer = 0;

    HKEY    hKey;
			
    CHAR 	sSubKeyBuffer[50],
            /* sSubKey[80], */
    		*psValueBuffer,
    		*psDataBuffer,
    		sClassString[30],
            *pSubKey_SW,         /* 02/12/97 GHOWELL added */
            *pSubKey_FPC;        /* 02/12/97 GHOWELL added */

    USHORT  SubKeySize_SW  = 0,  /* 02/12/97 GHOWELL added */
            SubKeySize_FPC = 0;  /* 02/12/97 GHOWELL added */

	FILETIME LastWrite; 
  
	_ENUM_KEY *pHead = NULL;
	_ENUM_KEY *pCurrent = NULL;
	_QUERY_SUBKEY_VALUE  *pSubKeyInfo = NULL;
	

	pRegEntriesHdr->CmnHdrInfo.DtlCount = 1;
	pRegEntriesHdr->RegCSRKeySuccess 	= TRUE;
	pRegEntriesHdr->RegPMFKeySuccess 	= TRUE;
	pRegEntriesHdr->RegVERKeySuccess 	= TRUE;


    /**************************************************************
    **
    **  02/12/97 GHOWELL - PMF is not used for Release 3.0, 
    **                     so this logic is commented out 
    */
	// /* Get PMF Information from Registry */
	//
	// strcpy(sSubKey, "Software\\FPC\\PMF\\CurrentVersion\\");
	//
    // lrc = RegOpenKeyEx
    //             (HKEY_LOCAL_MACHINE,
    //              sSubKey,
    //              0,
    //              KEY_READ,
    //              &hKey);
    // if (lrc != ERROR_SUCCESS)
	// {	
	// 	 /*Error occurred, registry problem */
	// 	 pRegEntriesHdr->RegPMFKeySuccess = FALSE;
 	// 	 strcpy( pRegEntriesHdr->RegDefaultServer, "Not found." );
	// 	 strcpy( pRegEntriesHdr->RegLastDeptID,    "Not found." );
	// 	 strcpy( pRegEntriesHdr->RegLastUserID,    "Not found." );
	// 	 strcpy( pRegEntriesHdr->RegLoginScript,   "Not found." );
	// }
	//  else
	// /* Get Default Server */
	// {
	// 	dwValueSize = sizeof(pRegEntriesHdr->RegDefaultServer);
    // 	lrc = RegQueryValueEx
    //             (hKey,
    //              CMN_REG_DEFAULT_SERVER,
    //              NULL,
    //              &dwValueType,
    //              pRegEntriesHdr->RegDefaultServer,
    //              &dwValueSize );
    // 
	// 	if(lrc != ERROR_SUCCESS)
	// 	{
	// 	/* Registry entries not found.*/
	// 		strcpy( pRegEntriesHdr->RegDefaultServer, "Not found." );
	// 	}
    // 
	// 	/* Get Department ID (RA#) */
	// 	dwValueSize = sizeof(pRegEntriesHdr->RegLastDeptID);
    // 	lrc = RegQueryValueEx
    //             (hKey,
    //              CMN_REG_LAST_DEPT_ID,
    //              NULL,
    //              &dwValueType,
    //              pRegEntriesHdr->RegLastDeptID,
    //              &dwValueSize);
	// 	if(lrc != ERROR_SUCCESS)
	// 	{
	// 		/*Registry entries not found.*/
	// 		strcpy( pRegEntriesHdr->RegLastDeptID, "Not found." );
	// 	}
	// 
	// 	/* Get User ID */
	// 	dwValueSize = sizeof(pRegEntriesHdr->RegLastUserID);
    // 	lrc = RegQueryValueEx
    //             (hKey,
    //              CMN_REG_LAST_USER_ID,
    //              NULL,
    //              &dwValueType,
    //              pRegEntriesHdr->RegLastUserID,
    //              &dwValueSize);
	// 	if(lrc != ERROR_SUCCESS)
	// 	{
	// 		/*Registry entries not found.*/
	// 		strcpy( pRegEntriesHdr->RegLastUserID, "Not found." );
	// 	}
    // 
	// 	/* Get Login Script Filename */
	// 	dwValueSize = sizeof(pRegEntriesHdr->RegLoginScript);
    // 	lrc = RegQueryValueEx
    //             (hKey,
    //              CMN_REG_LOGIN_SCRIPT,
    //              NULL,
    //              &dwValueType,
    //              pRegEntriesHdr->RegLoginScript,
    //              &dwValueSize);
	// 	if(lrc != ERROR_SUCCESS)
	// 	{
	// 		/*Registry entries not found.*/
	// 		strcpy( pRegEntriesHdr->RegLoginScript, "Not found." );
	// 	}
    // 
    // 	CloseHandle (hKey);
	// 
	//} /* else */
    //
    /*  END 02/12/97 - PMF not used in Release 3.0 */
	/************************************************************************/

    
    /* 02/12/97 GHOWELL - Removed hardcoding of Registry strings and lengths, 
    **                    and replaced with correctly allocated memory. These
    **                    Registry strings are stored in the base header file.
    **                    Look for SolutionWorks Key, then FPC Key.
    */
    // strcpy(sSubKey, "Software\\FPC\\CSS\\CurrentVersion\\"); 
	// lrc = RegOpenKeyEx
    //           (HKEY_LOCAL_MACHINE,
    //            sSubKey,
    //            0,
    //            KEY_READ,
    //            &hKey);
    
    /* Determine the length of the subkey to build */
    SubKeySize_SW = sizeof( CMN_PROFILE_KEY_SW_TOP_KEY )  + 
                    sizeof( CMN_PROFILE_KEY_NAME_CSS )    + 
                    sizeof( CMN_PROFILE_KEY_CURRENT_VERSION );
                
    /* Allocate memory to contain the subkey being built */
    pSubKey_SW = malloc (SubKeySize_SW);


    memset(pSubKey_SW, 0, SubKeySize_SW);

    /* Get Release Version */
    strcpy( pSubKey_SW, CMN_PROFILE_KEY_SW_TOP_KEY );
    strcat( pSubKey_SW, CMN_PROFILE_KEY_NAME_CSS );
    strcat( pSubKey_SW, CMN_PROFILE_KEY_CURRENT_VERSION );

    lrc = RegOpenKeyEx( HKEY_LOCAL_MACHINE,
                        pSubKey_SW,
                        0,
                        KEY_READ,
                        &hKey);

    /* Free the memory containing the subkey built */
    free (pSubKey_SW);

    if (lrc != ERROR_SUCCESS)   /* no SolutionWorks Key */
    {
        /* Set size for malloc */
        SubKeySize_FPC = sizeof( CMN_PROFILE_KEY_FPC_TOP_KEY ) + 
                         sizeof( CMN_PROFILE_KEY_NAME_CSS )    + 
                         sizeof( CMN_PROFILE_KEY_CURRENT_VERSION );

        /* Allocate memory to contain the subkey being built */
        pSubKey_FPC = malloc (SubKeySize_FPC);
        /* Build the subkey in the allocated memory */
        memset(pSubKey_FPC, 0, SubKeySize_FPC);

        strcpy( pSubKey_FPC, CMN_PROFILE_KEY_FPC_TOP_KEY );
        strcat( pSubKey_FPC, CMN_PROFILE_KEY_NAME_CSS );
        strcat( pSubKey_FPC, CMN_PROFILE_KEY_CURRENT_VERSION );


        /* Free the memory containing the subkey built */
        free (pSubKey_FPC);

        lrc = RegOpenKeyEx( HKEY_LOCAL_MACHINE,
                            pSubKey_FPC,
                            0,
                            KEY_READ,
                            &hKey);

    }  /* end no SolutionWorks Key */

    /* End 02/12/97 GHOWELL changes for modifying Registry variables */

    
    memset(sSubKeyBuffer, 0, sizeof(sSubKeyBuffer));
    
	/* Enumerate to get subkeys of the current version of CSS*/	
	while (lrc == ERROR_SUCCESS)
	{	
		dwKeyNameLen = sizeof(sSubKeyBuffer);
    	lrc = RegEnumKeyEx
        	        (hKey,
					 dwSubKey,
            	     sSubKeyBuffer,
					 &dwKeyNameLen,
					 NULL,                
                	 NULL,
					 NULL,
                 	 &LastWrite);

		if (lrc != ERROR_SUCCESS)
		{
			if (lrc == ERROR_NO_MORE_ITEMS)
			{
				break;
			}
			else
			{
				nRegAccessFlag = FALSE; 
				break;
			}
		}

		if (dwSubKey == 0)
		{
			pHead = malloc(sizeof(_ENUM_KEY));
			strcpy(pHead->sEnumSubKey, sSubKeyBuffer);
			pCurrent = pHead;
			pRegListHdr->pFirstSubKey = pHead;
		}
		else
		{
			/*
			| Allocate next node of memory and place address 
			|  of new node into the previous nodes pNextSubKey pointer.
			*/
			pCurrent->pNextSubKey = malloc(sizeof(_ENUM_KEY));

			/*
			| Set pCurrent pointer to point to the new node so that the
			| Subkey name can be copied into the new node.
			|  
			*/
			pCurrent = pCurrent->pNextSubKey; 
			strcpy(pCurrent->sEnumSubKey, sSubKeyBuffer);
		}


	 	dwSubKey ++;
	} /* end while*/

	CloseHandle (hKey);

	if (pCurrent != NULL)
	{
		pCurrent->pNextSubKey = NULL;
	}

	pCurrent = pRegListHdr->pFirstSubKey;
	while ( (pCurrent) && (dwSubKey > 0) )
	{

    /* 02/12/97 GHOWELL - Removed hardcoding of Registry strings and lengths, 
    **                    and replaced with correctly allocated memory. These
    **                    Registry strings are stored in the base header file.
    **                    Look for SolutionWorks Key, then FPC Key.
    */
    //    sprintf(sSubKey, "Software\\FPC\\CSS\\CurrentVersion\\%s", pCurrent->sEnumSubKey);
	//
	//	lrc = RegOpenKeyEx
    //    	        (HKEY_LOCAL_MACHINE,
    //       	     sSubKey,	  /* Opens first subkey under CSS\CurrentVersion ** 
    //            	 0,
    //         	     KEY_QUERY_VALUE,
    //            	 &hKey);
    
        /* Determine the length of the subkey to build */
        SubKeySize_SW = sizeof( CMN_PROFILE_KEY_SW_TOP_KEY )      + 
                        sizeof( CMN_PROFILE_KEY_NAME_CSS)         + 
                        sizeof( CMN_PROFILE_KEY_CURRENT_VERSION ) + 
                        sizeof( pCurrent->sEnumSubKey );
                
        /* Allocate memory to contain the subkey being built */
        pSubKey_SW = malloc (SubKeySize_SW);


        memset(pSubKey_SW, 0, SubKeySize_SW);

        /* Get Release Version */
        strcpy( pSubKey_SW, CMN_PROFILE_KEY_SW_TOP_KEY );
        strcat( pSubKey_SW, CMN_PROFILE_KEY_NAME_CSS );
        strcat( pSubKey_SW, CMN_PROFILE_KEY_CURRENT_VERSION );
        strcat( pSubKey_SW, pCurrent->sEnumSubKey );

        lrc = RegOpenKeyEx( HKEY_LOCAL_MACHINE,
                            pSubKey_SW,
                            0,
                            KEY_READ,
                            &hKey);

        /* Free the memory containing the subkey built */
        free (pSubKey_SW);

        if (lrc != ERROR_SUCCESS)   /* no SolutionWorks Key */
        {
            /* Set size for malloc */
            SubKeySize_FPC = sizeof( CMN_PROFILE_KEY_FPC_TOP_KEY )     + 
                             sizeof( CMN_PROFILE_KEY_NAME_CSS )        + 
                             sizeof( CMN_PROFILE_KEY_CURRENT_VERSION ) +
                             sizeof( pCurrent->sEnumSubKey );
                     
            /* Allocate memory to contain the subkey being built */
            pSubKey_FPC = malloc (SubKeySize_FPC);
            /* Build the subkey in the allocated memory */
            memset(pSubKey_FPC, 0, SubKeySize_FPC);

            strcpy( pSubKey_FPC, CMN_PROFILE_KEY_FPC_TOP_KEY );
            strcat( pSubKey_FPC, CMN_PROFILE_KEY_NAME_CSS );
            strcat( pSubKey_FPC, CMN_PROFILE_KEY_CURRENT_VERSION );
            strcat( pSubKey_SW, pCurrent->sEnumSubKey );


            /* Free the memory containing the subkey built */
            free (pSubKey_FPC);
    
            lrc = RegOpenKeyEx( HKEY_LOCAL_MACHINE,
                                pSubKey_FPC,
                                0,
                                KEY_READ,
                                &hKey);

        }  /* end no SolutionWorks Key */

        /* End 02/12/97 GHOWELL changes for modifying Registry variables */

            
        if (lrc != ERROR_SUCCESS)
		{
			nRegAccessFlag = FALSE; 
			break;
		}
		dwClassSize = sizeof(sClassString);
		lrcQueryInfo = RegQueryInfoKey
					 (hKey,
					 sClassString,
					 &dwClassSize,
					 NULL,
					 &dwNumSubKeys,
					 &dwMaxSubKeyLen,
					 &dwMaxClassLen,
					 &dwNumValueEntries,
					 &dwMaxValueName,
					 &dwMaxValueData,
					 &dwSecurityDesc,
					 &LastWrite);

		if (lrcQueryInfo == ERROR_SUCCESS)
		{
			psValueBuffer = malloc( ++dwMaxValueName);
    		psDataBuffer = malloc( ++dwMaxValueData );
		}
		else
		{
			nRegAccessFlag = FALSE; 
			break;	 	
		}

		pSubKeyInfo = NULL;
		if (lrc == ERROR_SUCCESS) /*for successful opening of subkey retrieve values*/
		{
			lrcEnumValue = ERROR_SUCCESS;
			dwSubKeyValue = 0;
			while (lrcEnumValue == ERROR_SUCCESS)	/*loop to get all values for each subkey*/
			{
				dwValueSize = dwMaxValueName;
				dwValueData = dwMaxValueData;
				lrcEnumValue = RegEnumValue
						(hKey,
						 dwSubKeyValue,
						 psValueBuffer,
						 &dwValueSize,
						 NULL,
						 &dwValueTypeBuffer,
						 psDataBuffer,
						 &dwValueData);

				if (lrcEnumValue == ERROR_NO_MORE_ITEMS)
				{
					break;
				}

				if (dwSubKeyValue == 0)    /*for first time through loop*/
				{
					pCurrent->pFirstSubKeyValue = malloc(sizeof(_QUERY_SUBKEY_VALUE));
					pCurrent->pFirstSubKeyValue->psSubKeyValue = malloc(++dwValueSize);
					pCurrent->pFirstSubKeyValue->psValueData = malloc(++dwValueData);
					strcpy(pCurrent->pFirstSubKeyValue->psSubKeyValue, psValueBuffer);
					pCurrent->pFirstSubKeyValue->dwValueType = dwValueTypeBuffer;
					strcpy(pCurrent->pFirstSubKeyValue->psValueData, psDataBuffer);
					pSubKeyInfo = pCurrent->pFirstSubKeyValue;
				}
				else	/*if not first loop*/
				{   
					pSubKeyInfo->pNextValue = malloc(sizeof(_QUERY_SUBKEY_VALUE));
					pSubKeyInfo = pSubKeyInfo->pNextValue;
					pSubKeyInfo->psSubKeyValue = malloc(++dwValueSize);
					pSubKeyInfo->psValueData = malloc(++dwValueData);
					strcpy(pSubKeyInfo->psSubKeyValue, psValueBuffer);
					pSubKeyInfo->dwValueType = dwValueTypeBuffer;
					strcpy(pSubKeyInfo->psValueData, psDataBuffer);
				}
		
					 
		
				dwSubKeyValue ++;
					
			} /*end while for getting values for each Subkey */

		} /*end if*/

		if ( psValueBuffer )
		{
			free( psValueBuffer );
		}
		if ( psDataBuffer )
		{
			free( psDataBuffer );
		}

		if (pSubKeyInfo != NULL)
		{
			pSubKeyInfo->pNextValue = NULL;
		}

		CloseHandle (hKey);
		dwSubKey --;
		pCurrent = pCurrent->pNextSubKey;
	} /*end while for opening Subkeys*/


	
	/* Get CSS Version number  */

    /* 02/12/97 GHOWELL - Removed hardcoding of Registry strings and lengths, 
    **                    and replaced with correctly allocated memory. These
    **                    Registry strings are stored in the base header file.
    **                    Look for SolutionWorks Key, then FPC Key.
	*/
    // strcpy(sSubKey, "Software\\FPC\\CSS\\tivoli\\");	
    //
    // lrc = RegOpenKeyEx
    //             (HKEY_LOCAL_MACHINE,
    //              sSubKey,
    //              0,
    //              KEY_READ,
    //              &hKey);
    
    /* Determine the length of the subkey to build */
    SubKeySize_SW = sizeof( CMN_PROFILE_KEY_SW_TOP_KEY ) + 
                    sizeof( CMN_PROFILE_KEY_NAME_CSS)    + 
                    sizeof( CMN_PROFILE_KEY_RELEASE );
                
    /* Allocate memory to contain the subkey being built */
    pSubKey_SW = malloc (SubKeySize_SW);


    memset(pSubKey_SW, 0, SubKeySize_SW);

    /* Get Release Version */
    strcpy( pSubKey_SW, CMN_PROFILE_KEY_SW_TOP_KEY );
    strcat( pSubKey_SW, CMN_PROFILE_KEY_NAME_CSS );
    strcat( pSubKey_SW, CMN_PROFILE_KEY_RELEASE );

    lrc = RegOpenKeyEx( HKEY_LOCAL_MACHINE,
                        pSubKey_SW,
                        0,
                        KEY_READ,
                        &hKey);

    /* Free the memory containing the subkey built */
    free (pSubKey_SW);

    if (lrc != ERROR_SUCCESS)   /* no SolutionWorks Key */
    {
        /* Set size for malloc */
        SubKeySize_FPC = sizeof( CMN_PROFILE_KEY_FPC_TOP_KEY ) + 
                         sizeof( CMN_PROFILE_KEY_NAME_CSS )    + 
                         sizeof( CMN_PROFILE_KEY_RELEASE );


        /* Allocate memory to contain the subkey being built */
        pSubKey_FPC = malloc (SubKeySize_FPC);
        /* Build the subkey in the allocated memory */
        memset(pSubKey_FPC, 0, SubKeySize_FPC);

        strcpy( pSubKey_FPC, CMN_PROFILE_KEY_FPC_TOP_KEY );
        strcat( pSubKey_FPC, CMN_PROFILE_KEY_NAME_CSS );
        strcat( pSubKey_FPC, CMN_PROFILE_KEY_CURRENT_VERSION );

        /* Free the memory containing the subkey built */
        free (pSubKey_FPC);
    
        lrc = RegOpenKeyEx( HKEY_LOCAL_MACHINE,
                            pSubKey_FPC,
                            0,
                            KEY_READ,
                            &hKey);

    }  /* end no SolutionWorks Key */

    /* End 02/12/97 GHOWELL changes for modifying Registry variables */
    
      
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


SHORT RptRegEntries( HANDLE hOut, _REGENTRIES_HDR  *pRegEntriesHdr,
								  _REG_LIST_HDR    *pRegListHdr,
							      int nRegAccessFlag )/* AZDI0205.C */
{
  CHAR 					szOut[255];
  _QUERY_SUBKEY_VALUE *pSubKeyInfo;
  _ENUM_KEY 		  *pCurrent = NULL;

  Report( hOut, "\n\n*** REGISTRY ENTRIES ***\n\n" );

  /*  02/12/97 GHOWELL - PMF is not used for Release 3.0, 
  **                     so this logic is commented out
  */
  // if( !pRegEntriesHdr->RegPMFKeySuccess)
  // {
  //   sprintf( szOut, "PMF Key does not exist!!!\n");
  //   Report( hOut, szOut );
  // }
  //   else
  // {
  //  	sprintf( szOut, "Default Server:  %s\n", pRegEntriesHdr->RegDefaultServer );
  // Report( hOut, szOut );
  // 	sprintf( szOut, "Dept. ID:        %s\n", pRegEntriesHdr->RegLastDeptID );
  // 	Report( hOut, szOut );
  // 	sprintf( szOut, "Last User ID:    %s\n", pRegEntriesHdr->RegLastUserID );
  // 	Report( hOut, szOut );
  // 	sprintf( szOut, "Login Script:    %s\n", pRegEntriesHdr->RegLoginScript );
  // 	Report( hOut, szOut );
  // }
  
  if( !pRegEntriesHdr->RegVERKeySuccess)
  {
  	sprintf( szOut, "Release Key does not exist!!!\n");
    Report( hOut, szOut );
  }
  else
  {
	sprintf( szOut, "CSS Version:     %s\n", pRegEntriesHdr->RegCssVersion );
	Report( hOut, szOut );
  }
  /**************************************************/
  if(!nRegAccessFlag)
  {
  	sprintf( szOut, "************************************\n");
  	sprintf( szOut, "**** RETRIEVAL OF CSS REGISTRY *****\n");
  	sprintf( szOut, "****           FAILED 			*****\n");
	sprintf( szOut, "************************************\n");
  }
  else
  {
  	Report( hOut, "\n\n*** CSS REGISTRY ENTRIES ***\n" );
	pCurrent = pRegListHdr->pFirstSubKey;
	while ( pCurrent )
	{
 		sprintf( szOut, "\n*** %s ***\n\n", pCurrent->sEnumSubKey );
  		Report( hOut, szOut );
		pSubKeyInfo = pCurrent->pFirstSubKeyValue;
	  	while (pSubKeyInfo != NULL)
		{
	  		sprintf( szOut, "%-40s:  %s\n", pSubKeyInfo->psSubKeyValue, pSubKeyInfo->psValueData );
	  		Report( hOut, szOut );
			pSubKeyInfo = pSubKeyInfo->pNextValue;
	  	}
		pCurrent = pCurrent->pNextSubKey; 
	}  		
  }
  /********************************************************/

  return 0;
}

SHORT FreeMemRegEntries(_REGENTRIES_HDR  *pRegEntriesHdr,
						_REG_LIST_HDR    *pRegListHdr)/* AZDI0205.C */
{

	_ENUM_KEY *pCurrent = NULL;
	_ENUM_KEY *pPrevKey = NULL;
	_QUERY_SUBKEY_VALUE  *pSubKeyInfo = NULL;
	_QUERY_SUBKEY_VALUE  *pPrevValue = NULL;

	pCurrent = pRegListHdr->pFirstSubKey;
	while ( pCurrent )
	{
		/* free allocated memory within this subkey */
		free ( pCurrent->pFirstSubKeyValue );

	  	while (pSubKeyInfo != NULL)
		{
			/* free allocated memory within this subkey value structure */
	  		free(pSubKeyInfo->psSubKeyValue);
	  		free(pSubKeyInfo->psValueData );

			/* Assign previous node to current node */
			pPrevValue = pSubKeyInfo;

			/* Set current node to next node */
			pSubKeyInfo = pSubKeyInfo->pNextValue;

			/* free previous node */
			free(pPrevValue);
	  	}
		/* Assign previous node to current node */
		pPrevKey = pCurrent;
		/* Set current node to next node */
		pCurrent = pCurrent->pNextSubKey; 
		/* free previous node */
		free(pPrevKey);
	} 
    return 0;	
} 		

