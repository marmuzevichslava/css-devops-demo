/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               CUSTOMER/1-Cooperative Architecture Component
**
**  PROGRAM          : AZDI0203.C
**
**  DESCRIPTION      : This program performs CSS inventory verification
**                     process
**
**  CALLED FUNCTIONS :
**
**  AUTHOR           : David Kolodziejski
**
**  DATE CREATED     : 04/12/95
**
**  REVISION HISTORY :
**
**  DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**  --------  -----------  -------  -------------------------------------
**  04/12/95  D. Kolodziejski		Original Code, parts borrowed from AZVS01
**  04/13/95  D. Kolodziejski                        Changed include of AZVS02 to look
**				in INCLUDE path.
***************************************************************************/
#include <windows.h>
#define  FND_FE_INCL
#define  FND_IM_INCL
#define  FND_EH_INCL
#define  FND_MS_INCL
#define  FND_PS_INCL
#define  FND_CF_INCL
#define  FND_ST_INCL
#define  FND_CTCONV_INCL
#define  FND_VERSION2

#include <kglxk000.h>

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sys\types.h>
#include <sys\stat.h>

#include <io.h>

/*
|   Include the CSS Architecture
|       Do not wrap Fnd functions since this is not a
|       a FOUNDATION generated application
*/
#define EXCLUDE_FND_WRAPPERS  /* Do not wrap Fnd functions */
#define INCL_C1CBASE
#define INCL_C1CPRIV
#define INCL_AGRWN01
#include <c1c.h>

#include "azdi02.h"
#include "azvs02.h"

short GetFileInvInfo(_FILEINV_HDR *pFileInvHdr)
{
    char        FileNameInInvFile[_MAX_PATH];
    char        InventoryFileName[_MAX_PATH];

    BOOL        fError=FALSE;
    long        nFileSize;
    USHORT      rc;
	short       FilesInInvFileCount = 0;
	short       InSynchCount = 0;

	struct tm   
	FileInInvFileDateTime;
    struct tm   *pFileInLocDirDateTime;

    FILE        *pInvFile;

    char                DriveLetter[AZVS02_DRIVE_LETTER_LEN];
    char                InventoryFileNT[_MAX_PATH];
    long                hFind;
    struct _finddata_t  DummyFileInfo;
    struct _stat        LocFileInfo;
    DWORD               dwRC;
	int			iDtlCtr;

	/* Initializations */
	FlNoPopUp = FALSE;
	iDtlCtr   = 0;
	
	pFileInvHdr->InvFileFound = TRUE;

    rc = GetInvFileLocation(DriveLetter, InventoryFileName);

    if( rc )
	{
		pFileInvHdr->InvFileFound = FALSE;
	    return rc;
	}

    /*
    |   Build the file name and path to open the inventory file
    */
    strcpy (InventoryFileNT, DriveLetter);
    strcat (InventoryFileNT, "\\");
    strcat (InventoryFileNT, InventoryFileName);
    strcpy (InventoryFileName, InventoryFileNT);

    /*
    |   Open the inventory file
    */
    if( (pInvFile = fopen (InventoryFileName, "r") ) == NULL )
    {
		pFileInvHdr->InvFileFound = FALSE;
        return (12);
    }

    /*
    |   Begin verifying the CSS components from the inventory file.
    */
	memset(&FileInInvFileDateTime, 0, sizeof(FileInInvFileDateTime));

    while( (fscanf (pInvFile,
                    "%s %ld %02d/%02d/%02d %02d:%02d\n",
                    FileNameInInvFile,
                    &nFileSize,
                    &FileInInvFileDateTime.tm_mon,
                    &FileInInvFileDateTime.tm_mday,
                    &FileInInvFileDateTime.tm_year,
                    &FileInInvFileDateTime.tm_hour,
                    &FileInInvFileDateTime.tm_min) != EOF) &&
			(iDtlCtr < (CMN_MAX_INV_ENTRIES - 4) ) )
    {
	    FilesInInvFileCount++;

        /*
        |   Attempt to find the file
        */
        hFind = _findfirst (FileNameInInvFile, &DummyFileInfo);
        if (hFind == -1)
        {
            sprintf (pFileInvHdr->FileInvDtl[iDtlCtr].DtlString,
                     "\nNOT FOUND: %s\r\n",
                     FileNameInInvFile);
			iDtlCtr++;
            fError = TRUE;
            _findclose (hFind);
        }
        /*
        |   Close the file search directory handle
        */
        _findclose (hFind);

		/**
		 ** Get file info
		 ** NOTE:  We don't use the info returned by the "firstfile" calls so we can
		 **        make the code more portable.
		 **/
        memset(&LocFileInfo, 0, sizeof(LocFileInfo) );
        _stat(FileNameInInvFile, &LocFileInfo);

        /*
        |   Verify the file size
        */
		if(LocFileInfo.st_size != nFileSize)
        {
            sprintf (pFileInvHdr->FileInvDtl[iDtlCtr].DtlString,
                     "\nDIFFERENT SIZE: %s\n"
                     "  Size listed in inventory file: %d\n"
					 "  Actual size of file:           %d\n",
                     FileNameInInvFile,
					 nFileSize,
					 LocFileInfo.st_size);
			iDtlCtr++;
            fError = TRUE;
        }

        /*
        |   Verify the Date and Time stamps
        */
		if( LocFileInfo.st_mtime <= 0 )
		{
            sprintf (pFileInvHdr->FileInvDtl[iDtlCtr].DtlString,
                     "CORRUPT DATE/TIME INFO: %s\r\n",
                     FileNameInInvFile);
			iDtlCtr++;
            fError = TRUE;
			continue;
		}
		/* Call function to split date/time into parts (makes it easier to read) */
		pFileInLocDirDateTime = localtime(&LocFileInfo.st_mtime);

		if( !pFileInLocDirDateTime )
		{
            sprintf (pFileInvHdr->FileInvDtl[iDtlCtr].DtlString,
                     "CORRUPT DATE/TIME INFO: %s\r\n",
                     FileNameInInvFile);
			iDtlCtr++;
            fError = TRUE;
			continue;
		}

		/* Notice in the following code that 1 is added to the month, since the "localtime"
		   function returns month as base 0 (i.e. January = 0) */
		if( (FileInInvFileDateTime.tm_mon  != pFileInLocDirDateTime->tm_mon + 1) ||
		    (FileInInvFileDateTime.tm_mday != pFileInLocDirDateTime->tm_mday) ||
		    (FileInInvFileDateTime.tm_year != pFileInLocDirDateTime->tm_year) ||
		    (FileInInvFileDateTime.tm_hour != pFileInLocDirDateTime->tm_hour) ||
		    (FileInInvFileDateTime.tm_min  != pFileInLocDirDateTime->tm_min) )
        {
            sprintf (pFileInvHdr->FileInvDtl[iDtlCtr].DtlString,
                     "\nDIFFERENT DATE OR TIME: %s\r\n"
                     "  Date/Time listed in inventory file: %02d/%02d/%02d %02d:%02d\n"
					 "  Actual Date/Time of file:           %02d/%02d/%02d %02d:%02d\n",
                     FileNameInInvFile,
                     FileInInvFileDateTime.tm_mon,
                     FileInInvFileDateTime.tm_mday,
                     FileInInvFileDateTime.tm_year,
                     FileInInvFileDateTime.tm_hour,
                     FileInInvFileDateTime.tm_min,
                     pFileInLocDirDateTime->tm_mon + 1, /* month is zero-based */
                     pFileInLocDirDateTime->tm_mday,
                     pFileInLocDirDateTime->tm_year,
                     pFileInLocDirDateTime->tm_hour,
                     pFileInLocDirDateTime->tm_min);
			iDtlCtr++;
            fError = TRUE;
			continue;
        }

		InSynchCount++;

    } /*while*/

	/* Write footer info. to the report file. */
	pFileInvHdr->InSynchCount = InSynchCount;
	pFileInvHdr->OutSynchCount = FilesInInvFileCount - InSynchCount;
	pFileInvHdr->TotalFiles   = FilesInInvFileCount;



    /*
    |   Close Files
    */
    fclose (pInvFile);

        /*
        |   Dismount the network drive
        */
        dwRC = WNetCancelConnection2
                    (strupr(DriveLetter),
                     0L,
                     TRUE);
        if (dwRC != NO_ERROR)
        {
            dwRC = GetLastError();

        }

    if (fError)
    {
        rc = 12;
    }
    else
    {
        rc = 0;
    }


  return (rc);
}


SHORT RptFileInvInfo   ( HANDLE hOut, _FILEINV_HDR     *pFileInvHdr     )
{
  CHAR szOut[255];
  int  iDtlCtr;

  Report( hOut, "\n\n*** FILE INVENTORY INFORMATION ***\n" );

  if ( !pFileInvHdr->InvFileFound )
  {
  	sprintf( szOut, "Inventory File was not found.\n" );
	Report ( hOut, szOut );
	return 0;
  }

  iDtlCtr = 0;
  while ( ( iDtlCtr < CMN_MAX_INV_ENTRIES ) &&
          ( strcmp(pFileInvHdr->FileInvDtl[iDtlCtr].DtlString, "") ) )
  {
  	sprintf( szOut, "%s", pFileInvHdr->FileInvDtl[iDtlCtr].DtlString );
  	Report( hOut, szOut );
  	iDtlCtr++;
  } /* while */
  
  sprintf( szOut, "\nFiles in synch:     %d\n", pFileInvHdr->InSynchCount );
  Report( hOut, szOut );  
  sprintf( szOut, "Files out of synch: %d\n", pFileInvHdr->OutSynchCount );
  Report( hOut, szOut );  
  sprintf( szOut, "Total files:        %d\n", pFileInvHdr->TotalFiles );
  Report( hOut, szOut );
   
  return 0;
} /* RptFileInvInfo */


short GetInvFileLocation(char *DriveLetter, char *InventoryFileName)
{
    USHORT              rc;

    char                NetPath[_MAX_PATH];
    NETRESOURCE         NetResource;
    char                ProvErrDesc[300];
    char                ProvErrName[60];
    DWORD               dwProvErrNum;
    DWORD               dwRC;

    /*
    |   NT VERSION ONLY:
    |     Get the drive letter to use for the NFS link
    */
    rc = CmnOsGetProfileValue
            (CMN_PROFILE_NAME_CSS,
             CMN_PROFILE_SECTION_MISC_FILES,
             AZVS02_PROFILE_KEY_CSSCOMP_DR,
             AZVS02_DRIVE_LETTER_LEN,
             CMN_PRF_FAIL_ON_ERROR,
             DriveLetter,
             &rc,
             CMN_NULL_ARCH_PARMS);
    switch (rc)
    {
        case CMN_PRF_SUCCESS:
            break;

        case CMN_PRF_NOT_FOUND:
            return (12);

        case CMN_PRF_SIZE_ERROR:
            return (12);

        case CMN_PRF_FATAL_ERROR:
            return (12);

        default:
            return (12);
    }

    rc = CmnOsGetProfileValue
            (CMN_PROFILE_NAME_CSS,
             CMN_PROFILE_SECTION_MISC_FILES,
             AZVS02_PROFILE_KEY_CSSCOMP_PATH,
             _MAX_PATH,
             CMN_PRF_FAIL_ON_ERROR,
             NetPath,
             &rc,
             CMN_NULL_ARCH_PARMS);
    switch (rc)
    {
        case CMN_PRF_SUCCESS:
            break;

        case CMN_PRF_NOT_FOUND:
            return (12);

        case CMN_PRF_SIZE_ERROR:
            return (12);

        case CMN_PRF_FATAL_ERROR:
            return (12);

        default:
            return (12);
    }

    memset (&NetResource, 0, sizeof (NETRESOURCE));
    NetResource.lpRemoteName = NetPath;
    NetResource.lpLocalName = DriveLetter;
    NetResource.lpProvider = NULL;
    NetResource.dwType = RESOURCETYPE_DISK;
    dwRC = WNetAddConnection2
                (&NetResource,
                 NULL,
                 NULL,
                 0L);
    if (dwRC != NO_ERROR)
    {
        dwRC = GetLastError ();
        switch (dwRC)
        {
            case ERROR_ACCESS_DENIED:
                break;

            case ERROR_ALREADY_ASSIGNED:
                break;

            case ERROR_BAD_DEV_TYPE:
                break;

            case ERROR_BAD_DEVICE:
                break;

            case ERROR_BAD_NET_NAME:
                break;

            case ERROR_BAD_PROFILE:
                break;

            case ERROR_CANNOT_OPEN_PROFILE:
                break;

            case ERROR_DEVICE_ALREADY_REMEMBERED:
                break;

            case ERROR_EXTENDED_ERROR:
                dwRC = WNetGetLastError
                            (&dwProvErrNum,
                             ProvErrDesc,
                             sizeof (ProvErrDesc),
                             ProvErrName,
                             sizeof (ProvErrName));
                break;

            case ERROR_INVALID_PASSWORD:
                break;

            case ERROR_NO_NET_OR_BAD_PATH:
                break;

            case ERROR_NO_NETWORK:
                break;

            default:
                break;
        }

        return (12);
    }


    /*
    |   Get the path to the CSSCOMP.INV file from the NT Registry.
    */
    CmnOsGetProfileValue
            (CMN_PROFILE_NAME_CSS,
             CMN_PROFILE_SECTION_MISC_FILES,
             CMN_PROFILE_KEY_CSSCOMP_PATH,
             _MAX_PATH,
             CMN_PRF_FAIL_ON_ERROR,
             InventoryFileName,
             &rc,
             CMN_NULL_ARCH_PARMS);
    switch (rc)
    {
        case CMN_PRF_SUCCESS:
            break;

        case CMN_PRF_NOT_FOUND:
            return (12);

        case CMN_PRF_SIZE_ERROR:
            return (12);

        case CMN_PRF_FATAL_ERROR:
            return (12);

        default:
            return (12);
    }

  return 0;
}


