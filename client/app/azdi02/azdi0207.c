/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*************************************************************************
**
**	FILENAME:		AZDI0207.C - Get Active Process Information
**
**	DESCRIPTION:	This function finds all active processes running on the
**                  local machine.
**
**
**  CREATED:
**
**  REVISION HISTORY
**
**  DATE        REVISED BY  SIR #   DESCRIPTION OF CHANGE
**  --------    ----------  ------  ---------------------------------------
*************************************************************************/


#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "AZDI02.h"
#include "azdi0207.h"

int CompareProcNames( const _ACTIVEPROCS_DTL *pDtl1, const _ACTIVEPROCS_DTL *pDtl2 )
{
  return stricmp( pDtl1->ActiveProcess, pDtl2->ActiveProcess );
}

/********************************************************
*														
*  GetActiveProcs											
*														
*      						
*														
********************************************************/
short GetActiveProcs   ( _ACTIVEPROCS_HDR *pActiveProcsHdr ) 
{
  GetPerfIndex ();
  GetProcessList (gpProcessObject, pActiveProcsHdr);

  qsort( pActiveProcsHdr->ActiveProcsDtl, pActiveProcsHdr->CmnHdrInfo.DtlCount,
         sizeof( pActiveProcsHdr->ActiveProcsDtl[0].ActiveProcess),
		 CompareProcNames );

  return 0;
 }


SHORT RptActiveProcs( HANDLE hOut, _ACTIVEPROCS_HDR *pActiveProcsHdr ) 
{
  SHORT i, j=0;
  CHAR szOut[255];

  Report( hOut, "\n*** ACTIVE PROCESSES ***\n\n" );

  for( i=0; i<pActiveProcsHdr->CmnHdrInfo.DtlCount; i++ )
  {
    sprintf( szOut, "%-8.8s    ", pActiveProcsHdr->ActiveProcsDtl[i].ActiveProcess );
	Report( hOut, szOut );

	if( j<5 )
	{
	  j++;
	}
	else /* j==5 */
	{
	  Report( hOut, "\n" );
	  j=0;
	}
  }

  Report( hOut, "\n" );

  return 0;
}

/***********************************************************************
**
**  FUNCTION         :  GetProcessList
**
**  DESCRIPTION      :  Find all process and update the process list.
**						
**                        
**
**  INPUTS           :  PPERF_OBJECT pObject
**                      
** 
**  OUTPUTS          :  None.
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
void GetProcessList ( PPERF_OBJECT pObject, _ACTIVEPROCS_HDR *pActiveProcsHdr )
{
PPERF_INSTANCE  pInstance;
TCHAR           szListText[255];
INT             InstanceIndex = 0;


	 if (pObject)
     {
        pInstance = FirstInstance (pObject);
  

        while (pInstance && InstanceIndex < pObject->NumInstances)
        {
          SetProcessListText (pInstance, szListText);

		  /* Copy process string to pActiveProcs */
		  strcpy (pActiveProcsHdr->ActiveProcsDtl[InstanceIndex].ActiveProcess, szListText);

          pInstance = NextInstance (pInstance);
          InstanceIndex++;
        }

		/* Update item count. */
		pActiveProcsHdr->CmnHdrInfo.DtlCount = InstanceIndex;	 

     }
}

/********************************************************
*														*
*  GetPerfIndex											*
*														*
*      Setup the perf data indexes.						*
*														*
********************************************************/
void    GetPerfIndex (void)
{
LPTSTR  TitleBuffer;
LPTSTR  *Title;
DWORD   Last;
TCHAR   szTemp[50];
DWORD   dwR;


    dwR = GetPerfTitleSz (ghMachineKey, ghPerfKey, &TitleBuffer, &Title, &Last);

    if (dwR != ERROR_SUCCESS)
    {
        sprintf (szTemp, TEXT("Unable to retrieve counter indexes, ERROR -> %#x"), dwR);
        // Jon, Do you want me to return any errors??
        // MessageBox (NULL, szTemp, TEXT("Pviewer"), MB_OK|MB_ICONEXCLAMATION);
        return;
    }


	PX_PROCESS = GetTitleIdx ( Title, Last, PN_PROCESS );
  
    sprintf (INDEX_PROCTHRD_OBJ, TEXT("%ld %ld"), PX_PROCESS);	 

    /* get performance data */
    gpPerfData = RefreshPerfData (ghPerfKey, INDEX_PROCTHRD_OBJ, gpPerfData, &gPerfDataSize);

    gpProcessObject = FindObject (gpPerfData, PX_PROCESS);

    LocalFree (TitleBuffer);
    LocalFree (Title);
}


/*************************************************************
*															 *
*  GetTitleIdx												 *
*															 *
*      Searches Titles[] for Name.  Returns the index found. *
*															 *
*************************************************************/

DWORD   GetTitleIdx ( LPTSTR Title[], DWORD LastIndex, LPTSTR Name )
{
DWORD   Index;

    for (Index = 0; Index <= LastIndex; Index++)
        if (Title[Index])
            if (!lstrcmpi (Title[Index], Name))
                return Index;

    return 0;
}



/***********************************************************************
**
**  FUNCTION         :  PutCounterDWKB
**
**  DESCRIPTION      :  Display a DWORD counter's data in KB units.
**
**
**  INPUTS           :  HWND            hWnd
**                      DWORD           dwItemID
**                      PPERF_INSTANCE  pInst
**                      PPERF_OBJECT    pObj
**                      DWORD           dwCounterIdx
** 
**  OUTPUTS          :  DWORD
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
DWORD   PutCounterDWKB (DWORD           dwItemID,
                        PPERF_INSTANCE  pInst,
                        PPERF_OBJECT    pObj,
                        DWORD           dwCounterIdx)
{
PPERF_COUNTER   pCounter;
DWORD           *pdwData;
TCHAR           szTemp[20];

    if (pCounter = FindCounter (pObj, dwCounterIdx))
    {
        pdwData = (DWORD *) CounterData (pInst, pCounter);
        sprintf (szTemp, TEXT("%ld KB"), *pdwData/1024);

        return *pdwData;
    }
    else
    {
        return 0;
    }

}

/***********************************************************************
**
**  FUNCTION         :  RefreshPerfData
**
**  DESCRIPTION      :  Get a new set of performance data.  pData should be NULL initially.
**
**
**  INPUTS           :  HKEY        hPerfKey
**                      LPTSTR      szObjectIndex
**                      PPERF_DATA  pData
**                      DWORD       *pDataSize
** 
**  OUTPUTS          :  PPERF_DATA
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PPERF_DATA RefreshPerfData (HKEY        hPerfKey,
                            LPTSTR      szObjectIndex,
                            PPERF_DATA  pData,
                            DWORD       *pDataSize)
{
    if (GetPerfData (hPerfKey, szObjectIndex, &pData, pDataSize) == ERROR_SUCCESS)
        return pData;
    else
        return NULL;
}


/***********************************************************************
**
**  FUNCTION         :  SetProcessListText
**
**  DESCRIPTION      :  Format the process list text.
**
**
**  INPUTS           :  PPERF_INSTANCE pInst
**                      LPTSTR         str
** 
**  OUTPUTS          :  None.
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
void SetProcessListText (PPERF_INSTANCE pInst, LPTSTR str)
{
TCHAR szTemp[100];

    sprintf (szTemp, TEXT("%ls"), InstanceName(pInst));
  
    sprintf (str, TEXT("%s"), szTemp);
}




/***********************************************************************
**
**  FUNCTION         :  GetPerfData
**
**  DESCRIPTION      :  Get a new set of performance data.
**
**                      *ppData should be NULL initially.									  
**                      This function will allocate a buffer big enough to hold the			  
**                      data requested by szObjectIndex.										  
**																			  
**                      *pDataSize specifies the initial buffer size.  If the size is		  
**                      too small, the function will increase it until it is big enough		  
**                      then return the size through *pDataSize.  Caller should				  
**                      deallocate *ppData if it is no longer being used.					  
**
**                      Returns ERROR_SUCCESS if no error occurs.
**
**      		  Note: the trial and error loop is quite different from the normal	  
**                      registry operation.  Normally if the buffer is too small,		  
**                      RegQueryValueEx returns the required size.  In this case,		  
**                      the perflib, since the data is dynamic, a buffer big enough	  
**                      for the moment may not be enough for the next. Therefor,		  
**                      the required size is not returned.								  
**                      One should start with a resonable size to avoid the overhead	  
**                      of reallocation of memory.										  
**
**  INPUTS           :  HKEY        hPerfKey
**                      LPTSTR      szObjectIndex
**                      PPERF_DATA  *ppData
**                      DWORD       *pDataSize
**
**  OUTPUTS          :  DWORD
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
DWORD   GetPerfData    (HKEY        hPerfKey,
                        LPTSTR      szObjectIndex,
                        PPERF_DATA  *ppData,
                        DWORD       *pDataSize)
{
DWORD   DataSize;
DWORD   dwR;
DWORD   Type;

   if (!*ppData)
      *ppData = (PPERF_DATA) LocalAlloc (LMEM_FIXED, *pDataSize);


    do  
    {
        DataSize = *pDataSize;
        dwR = RegQueryValueEx (hPerfKey,
                               szObjectIndex,
                               NULL,
                               &Type,
                               (BYTE *)*ppData,
                               &DataSize);

        if (dwR == ERROR_MORE_DATA)
        {
           LocalFree (*ppData);
           *pDataSize += 1024;
           *ppData = (PPERF_DATA) LocalAlloc (LMEM_FIXED, *pDataSize);
        }

        if (!*ppData)
        {
           LocalFree (*ppData);
           return ERROR_NOT_ENOUGH_MEMORY;
        }

    } while (dwR == ERROR_MORE_DATA);

    return dwR;

 }



/***********************************************************************
**
**  FUNCTION         :  atoiW
**
**  DESCRIPTION      :  Unicode version of atoi.
**
**  INPUTS           :  LPTSTR s
** 
**  OUTPUTS          :  INT
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
#ifdef UNICODE

#define atoi    atoiW

INT atoiW (LPTSTR s)
{
INT i = 0;

	 while (iswdigit (*s))
     {
		i = i*10 + (BYTE)*s - L'0';
        s++;
     }

    return i;
}

#endif


/***********************************************************************
**
**  FUNCTION         :  GetPerfTitleSz
**
**  DESCRIPTION      :  Retrieves the performance data title strings.
**						This call retrieves english version of the title strings.
**
** 	                    For NT 3.1, the counter names are stored in the "Counters" value		  
** 	                    in the ...\perflib\009 key.  For 3.5 and later, the 009 key is no		  
**                      longer used.  The counter names should be retrieved from "Counter 009" 
**                      value of HKEY_PERFORMANCE_KEY.										  
**																			  
**                      Caller should provide two pointers, one for buffering the title		  
**                      strings the other for indexing the title strings.  This function will  
**                      allocate memory for the TitleBuffer and TitleSz.  To get the title	  
**                      string for a particular title index one would just index the TitleSz.  
**                      *TitleLastIdx returns the highest index can be used.  If TitleSz[N] is 
**                      NULL then there is no Title for index N.								  
**																			  
**                      Example:  TitleSz[20] points to titile string for title index 20.	  
**																			  
**                      When done with the TitleSz, caller should LocalFree(*TitleBuffer).	  
**																			  
**                      This function returns ERROR_SUCCESS if no error.						  
**
**  INPUTS           :  HKEY    hKeyMachine,
**                      HKEY    hKeyPerf,
**                      LPTSTR  *TitleBuffer,
**                      LPTSTR  *TitleSz[],
**                      DWORD   *TitleLastIdx)
** 
**  OUTPUTS          :  DWORD
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
DWORD   GetPerfTitleSz (HKEY    hKeyMachine,
                        HKEY    hKeyPerf,
                        LPTSTR  *TitleBuffer,
                        LPTSTR  *TitleSz[],
                        DWORD   *TitleLastIdx)
{
HKEY	hKey1;
HKEY    hKey2;
DWORD   Type;
DWORD   DataSize;
DWORD   dwR;
DWORD   Len;
DWORD   Index;
DWORD   dwTemp;
BOOL    bNT10;
LPTSTR  szCounterValueName;
LPTSTR  szTitle;




    /* Initialize */
    hKey1        = NULL;
    hKey2        = NULL;
    *TitleBuffer = NULL;
    *TitleSz     = NULL;




    /* Open the perflib key to find out the last counter's index and system version */
    dwR = RegOpenKeyEx (hKeyMachine,
                        TEXT("software\\microsoft\\windows nt\\currentversion\\perflib"),
                        0,
                        KEY_READ,
                        &hKey1);
    if (dwR != ERROR_SUCCESS)
        goto done;

    /* Get the last counter's index so we know how much memory to allocate for TitleSz */
    DataSize = sizeof (DWORD);
    dwR = RegQueryValueEx (hKey1, TEXT("Last Counter"), 0, &Type, (LPBYTE)TitleLastIdx, &DataSize);
    if (dwR != ERROR_SUCCESS)
        goto done;



    /* Find system version, for system earlier than 1.0a, there's no version value. */
    dwR = RegQueryValueEx (hKey1, TEXT("Version"), 0, &Type, (LPBYTE)&dwTemp, &DataSize);

    if (dwR != ERROR_SUCCESS)
        /* unable to read the value, assume NT 1.0 */
        bNT10 = TRUE;
    else
        /* found the value, so, NT 1.0a or later */
        bNT10 = FALSE;


    /* Now, get ready for the counter names and indexes. */
    if (bNT10)
        {
          /* NT 1.0, so make hKey2 point to ...\perflib\009 and get */
          /*  the counters from value "Counters"					  */
          szCounterValueName = TEXT("Counters");
          dwR = RegOpenKeyEx (hKeyMachine,
                              TEXT("software\\microsoft\\windows nt\\currentversion\\perflib\\009"),
                              0,
                              KEY_READ,
                              &hKey2);
          if (dwR != ERROR_SUCCESS)
             goto done;
        }
    else
        {
          /* NT 1.0a or later.  Get the counters in key HKEY_PERFORMANCE_KEY */
          /*  and from value "Counter 009"								   */
          szCounterValueName = TEXT("Counter 009");
          hKey2 = hKeyPerf;
        }


    /* Find out the size of the data. */
    dwR = RegQueryValueEx (hKey2, szCounterValueName, 0, &Type, 0, &DataSize);
    if (dwR != ERROR_SUCCESS)
        goto done;


    /* Allocate memory */
    *TitleBuffer = (LPTSTR)LocalAlloc (LMEM_FIXED, DataSize);
    if (!*TitleBuffer)
    {
       dwR = ERROR_NOT_ENOUGH_MEMORY;
       goto done;
    }

    *TitleSz = (LPTSTR *)LocalAlloc (LPTR, (*TitleLastIdx+1) * sizeof (LPTSTR));
    if (!*TitleSz)
    {
       dwR = ERROR_NOT_ENOUGH_MEMORY;
       goto done;
    }


    /* Query the data */
    dwR = RegQueryValueEx (hKey2, szCounterValueName, 0, &Type, (BYTE *)*TitleBuffer, &DataSize);
    if (dwR != ERROR_SUCCESS)
        goto done;


    /* Setup the TitleSz array of pointers to point to beginning of each title string. */
    /* TitleBuffer is type REG_MULTI_SZ.											   */
    szTitle = *TitleBuffer;

    while (Len = lstrlen (szTitle))
    {
      Index = atoi (szTitle);

      szTitle = szTitle + Len +1;

      if (Index <= *TitleLastIdx)
         (*TitleSz)[Index] = szTitle;

      szTitle = szTitle + lstrlen (szTitle) +1;
    }
 

done:

    /* Now cleanup! */
    
    if (dwR != ERROR_SUCCESS)
    {
       /* There was an error, free the allocated memory */
       if (*TitleBuffer) LocalFree (*TitleBuffer);
       if (*TitleSz)     LocalFree (*TitleSz);
    }

    /* Close the hKeys. */
    if (hKey1) RegCloseKey (hKey1);
    if (hKey2 && hKey2 != hKeyPerf) RegCloseKey (hKey2);

    return dwR;
}


/***********************************************************************
**
**  FUNCTION         :  FirstObject
**
**  DESCRIPTION      :  Returns pointer to the first object in pData.
**						If pData is NULL then NULL is returned.											  
**
**  INPUTS           :  PPERF_DATA pData: Perf data.
** 
**  OUTPUTS          :  PPERF_OBJECT
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PPERF_OBJECT FirstObject (PPERF_DATA pData)
{
    if (pData)
       return ((PPERF_OBJECT) ((PBYTE) pData + pData->HeaderLength));
    else
       return NULL;
}

/***********************************************************************
**
**  FUNCTION         :  NextObject
**
**  DESCRIPTION      :  Returns pointer to the next object following pObject.
**
**                      If pObject is the last object, bogus data maybe returned.			  *
**                      The caller should do the checking.									  *
**																			  *
**                      If pObject is NULL, then NULL is returned.							  *
**
**  INPUTS           :  PPERF_OBJECT pObject: Object data.
** 
**  OUTPUTS          :  PPERF_OBJECT
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PPERF_OBJECT NextObject (PPERF_OBJECT pObject)
{
    if (pObject)
       return ((PPERF_OBJECT) ((PBYTE) pObject + pObject->TotalByteLength));
    else
       return NULL;
}

/***********************************************************************
**
**  FUNCTION         :  FindObject
**
**  DESCRIPTION      :  Returns pointer to object with TitleIndex.
**
**                      If not found, NULL is returned.			  
**
**  INPUTS           :  PPERF_DATA pData: Object data.
** 						DWORD TitleIndex: Which one?
**
**  OUTPUTS          :  PPERF_OBJECT
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PPERF_OBJECT FindObject (PPERF_DATA pData, DWORD TitleIndex)
{
PPERF_OBJECT pObject;
DWORD        i = 0;

    if (pObject = FirstObject (pData))
       while (i < pData->NumObjectTypes)
       {
         if (pObject->ObjectNameTitleIndex == TitleIndex)
            return pObject;

         pObject = NextObject (pObject);
         i++;
       }

    return NULL;
}

/***********************************************************************
**
**  FUNCTION         :  FindObjectN
**
**  DESCRIPTION      :  Find the Nth object in pData.
**
**                      If not found, NULL is returned.			  
**						0 <= N < NumObjectTypes.
**
**  INPUTS           :  PPERF_DATA pData: Object data.
** 						DWORD N         : Which one?
**
**  OUTPUTS          :  PPERF_OBJECT
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PPERF_OBJECT FindObjectN (PPERF_DATA pData, DWORD N)
{
PPERF_OBJECT pObject;
DWORD        i = 0;

    if (!pData)
       return NULL;
    else if (N >= pData->NumObjectTypes)
       return NULL;
    else
    {
       pObject = FirstObject (pData);

       while (i != N)
       {
         pObject = NextObject (pObject);
         i++;
       }

       return pObject;
    }
}

/***********************************************************************
**
**  FUNCTION         :  FirstInstance
**
**  DESCRIPTION      :  Returns pointer to the first instance of pObject type.
**						If pObject is NULL then NULL is returned.											  
**
**  INPUTS           :  PPERF_OBJECT pObject: Object data.
** 
**  OUTPUTS          :  PPERF_INSTANCE
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PPERF_INSTANCE   FirstInstance (PPERF_OBJECT pObject)
{
    if (pObject)
        return (PPERF_INSTANCE)((PCHAR) pObject + pObject->DefinitionLength);
    else
        return NULL;
}

/***********************************************************************
**
**  FUNCTION         :  NextInstance
**
**  DESCRIPTION      :  Returns pointer to the next instance following pInst.
**
**                      If pInst is the last instance, bogus data maybe returned.	 
**                      The caller should do the checking.							 
**
**  INPUTS           :  PPERF_INSTANCE pInst: Instance data.
** 
**  OUTPUTS          :  PPERF_INSTANCE
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PPERF_INSTANCE   NextInstance (PPERF_INSTANCE pInst)
{
PERF_COUNTER_BLOCK *pCounterBlock;

    if (pInst)
    {
      pCounterBlock = (PERF_COUNTER_BLOCK *)((PCHAR) pInst + pInst->ByteLength);
      return (PPERF_INSTANCE)((PCHAR) pCounterBlock + pCounterBlock->ByteLength);
    }
    else
      return NULL;
}

/***********************************************************************
**
**  FUNCTION         :  FindInstanceN
**
**  DESCRIPTION      :  Returns the Nth instance of pObject type.
**
**                      If not found, NULL is returned.  0 <= N <= NumInstances.
**
**  INPUTS           :  PPERF_OBJECT pObject: Object data.
** 						DWORD N             : Which Instance?
** 
**  OUTPUTS          :  PPERF_INSTANCE
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PPERF_INSTANCE FindInstanceN (PPERF_OBJECT pObject, DWORD N)
{
PPERF_INSTANCE pInst;
DWORD          i = 0;

    if (!pObject)
       return NULL;
    else if (N >= (DWORD)(pObject->NumInstances))
       return NULL;
    else
       {
         pInst = FirstInstance (pObject);

         while (i != N)
         {
           pInst = NextInstance (pInst);
           i++;
         }

         return pInst;
       }
}

/***********************************************************************
**
**  FUNCTION         :  FindInstanceParent
**
**  DESCRIPTION      :  Returns the pointer to an instance that is the parent of pInst.
**
**                      If pInst is NULL or the parent object is not found then NULL is
**						returned.
**
**  INPUTS           :  PPERF_OBJECT pObject: Object data.
** 						PPERF_DATA pData    : Perf data
** 
**  OUTPUTS          :  PPERF_INSTANCE
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PPERF_INSTANCE FindInstanceParent (PPERF_INSTANCE pInst, PPERF_DATA pData)
{
PPERF_OBJECT    pObject;

    if (!pInst)
       return NULL;
    else if (!(pObject = FindObject (pData, pInst->ParentObjectTitleIndex)))
       return NULL;
    else
       return FindInstanceN (pObject, pInst->ParentObjectInstance);
}

/***********************************************************************
**
**  FUNCTION         :  InstanceName
**
**  DESCRIPTION      :  Returns the name of the pInst.
**
**                      If pInst is NULL then NULL is returned.
**
**  INPUTS           :  PPERF_INSTANCE pInst: Instance data.
** 
**  OUTPUTS          :  LPTSTR Instance Name
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/

LPTSTR  InstanceName (PPERF_INSTANCE pInst)
{
    if (pInst)
       return (LPTSTR) ((PCHAR) pInst + pInst->NameOffset);
    else
       return NULL;
}

/***********************************************************************
**
**  FUNCTION         :  FirstCounter
**
**  DESCRIPTION      :  Find the first counter in pObject.
**
**
**  INPUTS           :  PPERF_OBJECT pObject: perf data object.
**
**  OUTPUTS          :  PPERF_COUNTER - pointer to the first counter
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PPERF_COUNTER FirstCounter (PPERF_OBJECT pObject)
{
    if (pObject)
        return (PPERF_COUNTER)((PCHAR) pObject + pObject->HeaderLength);
    else
        return NULL;
}

/***********************************************************************
**
**  FUNCTION         :  NextCounter
**
**  DESCRIPTION      :  Find the next counter in pObject.
**                      If pCounter is the last counter of an object type, bogus data 
**                      maybe returned.  The caller should do the checking.			 
**																	  
**                      Returns a pointer to a counter.  If pCounter is NULL then	 
**                      NULL is returned.											 
**
**  INPUTS           :  PPERF_OBJECT pObject: perf data object.
**
**  OUTPUTS          :  PPERF_COUNTER - pointer to the first counter
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PPERF_COUNTER NextCounter (PPERF_COUNTER pCounter)
{
    if (pCounter)
        return (PPERF_COUNTER)((PCHAR) pCounter + pCounter->ByteLength);
    else
        return NULL;
}

/***********************************************************************
**
**  FUNCTION         :  NextCounter
**
**  DESCRIPTION      :  Find a counter specified by TitleIndex.
**																	  
**                      Returns a pointer to a counter.  If pCounter is NULL then	 
**                      NULL is returned.											 
**
**  INPUTS           :  PPERF_OBJECT pObject: perf data object.
**						DWORD TitleIndex    :
** 
**  OUTPUTS          :  PPERF_COUNTER - pointer to the first counter
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PPERF_COUNTER FindCounter (PPERF_OBJECT pObject, DWORD TitleIndex)
{
PPERF_COUNTER pCounter;
DWORD         i = 0;

    if (pCounter = FirstCounter (pObject))
        while (i < pObject->NumCounters)
        {
          if (pCounter->CounterNameTitleIndex == TitleIndex)
             return pCounter;

          pCounter = NextCounter (pCounter);
          i++;
        }

    return NULL;
}

/***********************************************************************
**
**  FUNCTION         :  CounterData
**
**  DESCRIPTION      :  Find a counter specified by TitleIndex.
**																	  
**                      Returns counter data for an object instance.  If pInst or 	 
**                      pCount is NULL then NULL is returne.							 
**
**  INPUTS           :  PPERF_INSTANCE pInst: Instance data.
**						PPERF_COUNTER pCount: Counter data
** 
**  OUTPUTS          :  None
**
**  AUTHOR           :  ANDERSEN CONSULTING
**
**  DATE CREATED     :  03/10/95
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  03/10/95    B.FREELING                 Original Code
**
************************************************************************/
PVOID CounterData (PPERF_INSTANCE pInst, PPERF_COUNTER pCount)
{
PPERF_COUNTER_BLOCK pCounterBlock;

    if (pCount && pInst)
    {
      pCounterBlock = (PPERF_COUNTER_BLOCK)((PCHAR)pInst + pInst->ByteLength);
      return (PVOID)((PCHAR)pCounterBlock + pCount->CounterOffset);
    }
    else
      return NULL;
} 
