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
**  AUTHOR           : Lou Misfeldt, Florida Power Corporation
**
**  DATE CREATED     : 07/29/94
**
**  REVISION HISTORY :
**
**  DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**  --------  -----------  -------  -------------------------------------
**  07/29/94  L. Misfeldt           Original Code, OS/2 Version
**  11/21/94  L. Misfeldt           Modify to obtain file path for
**                                    CSSCOMP.INV from the CSS.INI file.
**  11/23/94  L. Misfeldt           Port to Windows NT
**  01/05/95  L. Misfeldt           Modified NT version to map an NFS
**                                    drive to locate the component
**                                    inventory file.  The network
**                                    drive letter, path and file name
**                                    are obtained from registry entries.
**  02/17/95  F. Ganter             Replaced all occurrences of wsprintf 
**                                  with sprintf (its portable)
**  02/17/95  F. Ganter             Modified wording of messages to use
** 									"Inventory of Files" instead of
**									"CSS Component Inventory"
**  02/17/95  F. Ganter             Added error logic to determine if NULL
**									pointer returning from call to
**									localtime function
**  03/01/95  F. Ganter             Modified to use portable functions
**  03/06/95  F. Ganter             Modified give header and footer info.
**									in error report file as well as
**									more information on each file in error
**  03/06/95  F. Ganter             Created GetInvFileLocation function to
**									make main function easier to read
**  03/20/95  F. Ganter             Added ShowMessageToUser and parameter 
**                                  to suppress pop-up messages
**  03/31/95  F. Ganter             Made compatible w/ CSS Diagnostics
**
***************************************************************************/
#ifdef WIN32
    #include <windows.h>
#else
    #define  INCL_DOS
    #define  INCL_DOSERRORS
    #include <os2.h>
#endif

#define  FND_FE_INCL
#define  FND_IM_INCL
#define  FND_EH_INCL
#define  FND_MS_INCL
#define  FND_PS_INCL
#define  FND_CF_INCL
#define  FND_ST_INCL
#define  FND_CTCONV_INCL
#define  FND_VERSION2

#ifdef WIN32
    #include <kglxk000.h>
#else
    #include <kglzk000.h>
#endif

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sys\types.h>
#include <sys\stat.h>

#ifdef WIN32
    #include <io.h>
#endif

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

#ifdef WIN32
    int WINAPI WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance,
                LPSTR lpszCmdLine, int nCmdShow)
#else
_cdecl main(int argc, char *argv[])
#endif
{
  _FILEINV_HDR FileInvHdr;
//  _FILEINV_DTL FileInvDtl;

  GetFileInvInfo(&FileInvHdr);
  RptFileInvInfo( (HANDLE) 0, &FileInvHdr);

  return 0;
}

short GetFileInvInfo(_FILEINV_HDR *pFileInvHdr)
{
    char        FileNameInInvFile[_MAX_PATH];
    char        InventoryFileName[_MAX_PATH];
    char        MsgTxt[600];

    BOOL        fError=FALSE;
    long        nFileSize;
    USHORT      rc;
	short       FilesInInvFileCount = 0;
	short       InSynchCount = 0;

	struct tm   FileInInvFileDateTime;
    struct tm   *pFileInLocDirDateTime;
	time_t      CurrentTimeTime_t;
    struct tm   *pCurrentTimeTm;

    FILE        *pInvFile;
    FILE        *pResultFile;

	/* Added for CSS Diagnostics */
//	_FILEINV_DTL CssDiagDetail;
//	char         SingleChar;


#ifdef WIN32
    char                DriveLetter[AZVS02_DRIVE_LETTER_LEN];
    char                InventoryFileNT[_MAX_PATH];
    long                hFind;
    struct _finddata_t  DummyFileInfo;
    struct _stat        LocFileInfo;
    DWORD               dwRC;
#else
    USHORT              EntCount;
    HDIR                hDir;
    FILEFINDBUF         Info;
    struct stat         LocFileInfo;
#endif

	/* Initializations */
	FlNoPopUp = FALSE;

    /*
    |   Register application with session transcript
    */
    ReportError ("AZVS02 - Registering with Session Transcript");

	/* Check parameters (if given) */

/*
#ifdef WIN32
    if( strtok(lpszCmdLine, "/m") || strtok(lpszCmdLine, "-m") )
	{
		FlNoPopUp = TRUE;
	}
#else
	if(argc > 1)
	{
	    if( (strnicmp(argv[0], "/m", 2) != 0) && (strnicmp(argv[0], "-m", 2) != 0) )
		{
            ReportError ("Incorrect syntax -- usage: AZVS02 [/m]");
			return(12);
		}

		FlNoPopUp = TRUE;
	}
#endif
*/

#ifdef WIN32
    rc = GetInvFileLocation(DriveLetter, InventoryFileName);
#else
    rc = GetInvFileLocation(NULL, InventoryFileName);
#endif

    if( rc )
	{
	    return rc;
	}

#ifdef WIN32
    /*
    |   Build the file name and path to open the inventory file
    */
    strcpy (InventoryFileNT, DriveLetter);
    strcat (InventoryFileNT, "\\");
    strcat (InventoryFileNT, InventoryFileName);
    strcpy (InventoryFileName, InventoryFileNT);
#endif

    /*
    |   Open the inventory file
    */
    if( (pInvFile = fopen (InventoryFileName, "r") ) == NULL )
    {
            sprintf
               (MsgTxt,
                "Inventory of Files Error.\n\n"
                "The CSS Component Inventory File could not be found."
                "  The inventory file is necessary to verify that all"
                " CSS Application Components exist and are current.\n\n"
                "Please contact the help desk with the above information"
                " for problem determination.");
            ShowMessageToUser
                (NULL,
                 CMN_ERROR,
                 MsgTxt);

        ReportError ("AZVS02 - Missing CSS Component Inventory File");

        return (12);
    }

    /*
    |   Open the verification results file
    */
    if( (pResultFile = fopen (AZVS02_RESULT_FILENAME, "w") ) == NULL )
    {
            sprintf
               (MsgTxt,
                "Inventory of Files Error.\n\n"
                "The CSS Inventory Verification Results File could not"
                " be created.  Please make disk space available for"
                " the results file by deleting unwanted files.");
            ShowMessageToUser
                (NULL,
                 CMN_ERROR,
                 MsgTxt);

        ReportError ("AZVS02 - Unable to open output result file");

        fclose (pInvFile);

#ifdef WIN32
            /*
            |   Dismount the network drive
            */
            WNetCancelConnection2
                 (DriveLetter,
                  0L,
                  TRUE);
#endif
                                
        return (12);
    }

	/* Write header info. to the report file. */
	time(&CurrentTimeTime_t);
	pCurrentTimeTm = localtime(&CurrentTimeTime_t);

	fprintf(pResultFile,
			"Inventory of Files verification sequence begun %02d/%02d/%02d %02d:%02d:%02d\n",
            pCurrentTimeTm->tm_mon + 1, /* month is zero-based */
            pCurrentTimeTm->tm_mday,
            pCurrentTimeTm->tm_year,
            pCurrentTimeTm->tm_hour,
            pCurrentTimeTm->tm_min,
            pCurrentTimeTm->tm_sec);


    /*
    |   Begin verifying the CSS components from the inventory file.
    */
	memset(&FileInInvFileDateTime, 0, sizeof(FileInInvFileDateTime));

    while( fscanf (pInvFile,
                    "%s %ld %02d/%02d/%02d %02d:%02d\n",
                    FileNameInInvFile,
                    &nFileSize,
                    &FileInInvFileDateTime.tm_mon,
                    &FileInInvFileDateTime.tm_mday,
                    &FileInInvFileDateTime.tm_year,
                    &FileInInvFileDateTime.tm_hour,
                    &FileInInvFileDateTime.tm_min) != EOF)
    {
	    FilesInInvFileCount++;

        /*
        |   Attempt to find the file
        */
#ifdef WIN32
        hFind = _findfirst (FileNameInInvFile, &DummyFileInfo);
        if (hFind == -1)
        {
            fprintf (pResultFile,
                     "\nNOT FOUND: %s\r\n",
                     FileNameInInvFile);
            fError = TRUE;
            _findclose (hFind);
            continue;
        }
        /*
        |   Close the file search directory handle
        */
        _findclose (hFind);
#else
            hDir = HDIR_SYSTEM;
            EntCount = 1;
            if (DosFindFirst (FileNameInInvFile,
                          &hDir,
                          FILE_NORMAL | FILE_READONLY | FILE_ARCHIVED,
                          &Info,
                          sizeof (FILEFINDBUF),
                          &EntCount,
                          0L)
                != 0)
        {
            fprintf (pResultFile,
                     "\nNOT FOUND: %s\r\n",
                     FileNameInInvFile);
            fError = TRUE;
            DosFindClose (hDir);
            continue;
        }

        /*
        |   Close the file search directory handle
        */
            DosFindClose (hDir);
#endif

		/**
		 ** Get file info
		 ** NOTE:  We don't use the info returned by the "firstfile" calls so we can
		 **        make the code more portable.
		 **/
        memset(&LocFileInfo, 0, sizeof(LocFileInfo) );
#ifdef WIN32
        _stat(FileNameInInvFile, &LocFileInfo);
#else
        stat(FileNameInInvFile, &LocFileInfo);
#endif

        /*
        |   Verify the file size
        */
		if(LocFileInfo.st_size != nFileSize)
        {
            fprintf (pResultFile,
                     "\nDIFFERENT SIZE: %s\n"
                     "  Size listed in inventory file: %d\n"
					 "  Actual size of file:           %d\n",
                     FileNameInInvFile,
					 nFileSize,
					 LocFileInfo.st_size);
            fError = TRUE;
            continue;
        }

        /*
        |   Verify the Date and Time stamps
        */
		if( LocFileInfo.st_mtime <= 0 )
		{
            fprintf (pResultFile,
                     "CORRUPT DATE/TIME INFO: %s\r\n",
                     FileNameInInvFile);
            fError = TRUE;
			continue;
		}
		/* Call function to split date/time into parts (makes it easier to read) */
		pFileInLocDirDateTime = localtime(&LocFileInfo.st_mtime);

		if( !pFileInLocDirDateTime )
		{
            fprintf (pResultFile,
                     "CORRUPT DATE/TIME INFO: %s\r\n",
                     FileNameInInvFile);
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
            fprintf (pResultFile,
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
            fError = TRUE;
            continue;
        }

		InSynchCount++;

    }

	/* Write footer info. to the report file. */
	fprintf(pResultFile,
	        "\nNumber of files in synch:                       %4d\n"
			"Number of files not in synch:                   %4d\n"
			"Total number of files read from inventory file: %4d\n\n",
			InSynchCount,
			FilesInInvFileCount - InSynchCount,
			FilesInInvFileCount);

	time(&CurrentTimeTime_t);
	pCurrentTimeTm = localtime(&CurrentTimeTime_t);

	fprintf(pResultFile,
	        "Inventory of Files verification sequence ended %02d/%02d/%02d %02d:%02d:%02d\n",
            pCurrentTimeTm->tm_mon + 1, /* month is zero-based */
            pCurrentTimeTm->tm_mday,
            pCurrentTimeTm->tm_year,
            pCurrentTimeTm->tm_hour,
            pCurrentTimeTm->tm_min,
            pCurrentTimeTm->tm_sec);


    /*
    |   Close Files
    */
    fclose (pInvFile);
    fclose (pResultFile);

#ifdef WIN32
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

                sprintf
               (MsgTxt,
                "Inventory of Files Error.\n\n"
                "An error occurred while attempting to disconnect"
                " the network drive that contains the Component"
                " Inventory File.\n\n"
                "Network Drive: %s\n\n"
                "Error Code: %li\n\n"
                "This drive can be removed by disconnecting it through"
                " File Manager.\n\n"
                " Please contact the help desk with the above information"
                " for problem determination.",
                DriveLetter,
                dwRC);
                ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);
        }
#endif

    if (fError)
    {
            sprintf
                 (MsgTxt,
                  "Inventory of Files Completed with Errors.\n"
				  "Results are stored in %s.\n\n"
                  "Please contact the help desk for problem determination.",
                  AZVS02_RESULT_FILENAME);
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);

        ReportError
            ("AZVS02 - Inventory of Files Completed with Errors.");
        rc = 12;
    }
    else
    {
        ReportError
             ("AZVS02 - Inventory of Files Completed Successfully.");
        rc = 0;
    }


  return (rc);
}


SHORT RptFileInvInfo   ( HANDLE hOut, _FILEINV_HDR     *pFileInvHdr     )
{
  return 0;
}


SHORT ReportError (char *ErrorText)
{
   USHORT             rc = 0;
   _FND_STANDARD_PB   ParmBlock;
   _ST_FMT_DATA_BLOCK FormatDataBlock;
   _DESCR             UnformatDataBlock;
   _ABHI              Abhi;
#ifdef OS2
        PIDINFO     PidInfo;
#endif


   /* For CSS Diagnostics version we don't need to do anything. */
   return(0);

   /*
   |    Initialize the local variables
   */
   memset( &ParmBlock,         '\0', sizeof( _FND_STANDARD_PB   ));
   memset( &FormatDataBlock,   '\0', sizeof( _ST_FMT_DATA_BLOCK ));
   memset( &UnformatDataBlock, '\0', sizeof( _DESCR             ));
   memset( &Abhi,              '\0', sizeof( _ABHI              ));

   /*
   |    Format the Parm Block
   */
   ParmBlock.function_code = 0;
   memcpy( ParmBlock.ver, FND_ST_VER, _VER_LEN );
   ParmBlock.status.explan_code = 0;
   ParmBlock.status.severity    = FND_SEVERITY_FATAL;

   /*
   |    Format the ABHI and copy it to the FormatDataBlock
   */
   Abhi.abhi_monitor_data_block.fnd_platform_type = FND_PLATFORM_OS2;
   strcpy (Abhi.abhi_monitor_data_block.fnd_win_name, "AZVS02");
#ifdef WIN32
        Abhi.abhi_monitor_data_block.fnd_process_id = GetCurrentProcessId();
        Abhi.abhi_monitor_data_block.fnd_thread_id = GetCurrentThreadId();
#else
        DosGetPID (&PidInfo);
        Abhi.abhi_monitor_data_block.fnd_process_id = PidInfo.pid;
        Abhi.abhi_monitor_data_block.fnd_thread_id = PidInfo.tid;
#endif
   strcpy (Abhi.abhi_pgm_id, "AZVS02");
   Abhi.abhi_error_appl_type = FND_APPL_TYPE_CLIENT;
   Abhi.abhi_error_type_code = FND_ERR_TYPE_APPL;
   strcpy (Abhi.abhi_load_image_name, "AZVS02");
   memcpy( &( FormatDataBlock.ApplErrorBlock ), &Abhi, sizeof( _ABHI ));

   /*
   |    Format the unformatted data block
   */
   UnformatDataBlock.desc_length  = strlen (ErrorText);
   UnformatDataBlock.data_pointer = ErrorText;

   rc = STLogAndDisplay( &ParmBlock,
                         &Abhi,
                         &FormatDataBlock,
                         UnformatDataBlock );

   return(0);
}


short GetInvFileLocation(char *DriveLetter, char *InventoryFileName)
{
    USHORT              rc;
    char                MsgTxt[600];
    char                Msg[100];

#ifdef WIN32
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
            sprintf
                (MsgTxt,
                 "Inventory of Files Error.\n\n"
                 "The CSS Component Inventory file name could not"
                 " be found in the NT Registry.  Please contact"
                 " the help desk to make sure that the registry"
                 " has been properly setup.");
            ReportError ("AZVS02 - Missing CSS information in NT Registry");
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);
            return (12);

        case CMN_PRF_SIZE_ERROR:
            sprintf
                (MsgTxt,
                 "Inventory of Files Error.\n\n"
                 "The buffer to hold the CSS Component Inventory"
                 " file name was not large enough.  Please contact"
                 " the help desk as this is an unrecoverable error."
                 " Have the help desk verify that the file name in the"
                 " CSS entries of the NT Registry is correct.");
            ReportError ("AZVS02 - Filename buffer size error");
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);
            return (12);

        case CMN_PRF_FATAL_ERROR:
            sprintf
                (MsgTxt,
                 "Inventory of Files Error.\n\n"
                 "There has been a fatal error when attempting"
                 " to obtain the CSS Component Inventory file name"
                 " from the NT Registry.  The cause of the error"
                 " cannot be ascertained and must be determined by"
                 " other methods.  Please contact the help desk for"
                 " problem determination.");
            ReportError ("AZVS02 - NT Registry access fatal error");
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);
            return (12);

        default:
            sprintf
                (MsgTxt,
                 "Inventory of Files Error.\n\n"
                 "Some other error has occurred while attempting"
                 " to obtain the CSS Component Inventory file name"
                 " from the NT Registry.  The cause of the error"
                 " is unknown, but the return code is: %i\n"
                 " Please contact the help desk with the above information"
                 " for problem determination.",
                 rc);
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);
            sprintf
                      (Msg,
                      "AZVS02 - Unknown error from CmnOsGetProfileValue: %i",
                      rc);
            ReportError (Msg);
            return (12);
    }

    /*
    |   NT VERSION ONLY:
    |       Obtain the network path to the resource where the component
    |       inventory file can be located.
    */
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
                sprintf
                (MsgTxt,
                 "Inventory of Files Error.\n\n"
                 "The CSS Component Inventory file name could not"
                 " be found in the NT Registry.  Please contact"
                 " the help desk to make sure that the registry"
                 " has been properly setup.");
            ReportError ("AZVS02 - Missing CSS information in NT Registry");
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);
            return (12);

        case CMN_PRF_SIZE_ERROR:
                sprintf
                (MsgTxt,
                 "Inventory of Files Error.\n\n"
                 "The buffer to hold the CSS Component Inventory"
                 " file name was not large enough.  Please contact"
                 " the help desk as this is an unrecoverable error."
                 " Have the help desk verify that the file name in the"
                 " CSS entries of the NT Registry is correct.");
            ReportError ("AZVS02 - Filename buffer size error");
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);
            return (12);

        case CMN_PRF_FATAL_ERROR:
                sprintf
                (MsgTxt,
                 "Inventory of Files Error.\n\n"
                 "There has been a fatal error when attempting"
                 " to obtain the CSS Component Inventory file name"
                 " from the NT Registry.  The cause of the error"
                 " cannot be ascertained and must be determined by"
                 " other methods.  Please contact the help desk for"
                 " problem determination.");
            ReportError ("AZVS02 - NT Registry access fatal error");
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);
            return (12);

        default:
                sprintf
                (MsgTxt,
                 "Inventory of Files Error.\n\n"
                 "Some other error has occurred while attempting"
                 " to obtain the CSS Component Inventory file name"
                 " from the NT Registry.  The cause of the error"
                 " is unknown, but the return code is: %i\n"
                 " Please contact the help desk with the above information"
                 " for problem determination.",
                 rc);
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);

                     sprintf
                      (Msg,
                      "AZVS02 - Unknown error from CmnOsGetProfileValue: %i",
                      rc);
            ReportError (Msg);
            return (12);
    }

    /*
    |   NT VERSION ONLY:
    |       Mount the network drive where the file is located.
    */
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
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "Access to the network drive containing the"
                   " Component Inventory file was denied.\n\n"
                   "Please make sure that the correct path and access"
                   " permissions have been set for the CSS Component"
                   " Inventory File in both the NT Registry and the"
                   " file server.\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.");
                break;

            case ERROR_ALREADY_ASSIGNED:
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "The network drive being used to locate the"
                   " Component Inventory file is already in use.\n\n"
                   "This drive MUST be available inorder to properly"
                   " start CSS.\n\n"
                   "The drive letter to be used is: %s\n\n"
                   "Please either disconnect the network drive or"
                   " change the drive letter to be used by this program"
                   " in the NT registry.\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.",
                   DriveLetter);
                break;

            case ERROR_BAD_DEV_TYPE:
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "This error should not occur.  But if it does,"
                   " it means that the device being connected does not"
                   " match the network resource requested.  For example,"
                   " attempting to connect a network printer to a disk device.\n\n"
                   "It is possible that the network path specified in the NT"
                   " registry is incorrect.\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.");
                break;

            case ERROR_BAD_DEVICE:
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "This error should not occur.  But if it does,"
                   " it means that the device being connected is invalid."
                   "  For example, attempting to connect to drive letter $"
                   " (dollar sign) which of course is an invalid drive"
                   " letter.\n\n"
                   "It is possible that the drive letter specified in the NT"
                   " registry is incorrect.\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.");
                break;

            case ERROR_BAD_NET_NAME:
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "The network path specified in the NT registry is"
                   " cannot be found.  Please correct the path"
                   " specified for the Component Inventory Path registry"
                   " value.\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.");
                break;

            case ERROR_BAD_PROFILE:
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "Bad Profile Error.\n\n"
                   "This error should not occur since the connection"
                   " being established is not being remembered.\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.");
                break;

            case ERROR_CANNOT_OPEN_PROFILE:
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "Cannot Open Profile Error.\n\n"
                   "This error should not occur since the connection"
                   " being established is not being remembered.\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.");
                break;

            case ERROR_DEVICE_ALREADY_REMEMBERED:
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "Device Already Remembered Error.\n\n"
                   "This error should not occur since the connection"
                   " being established is not being remembered.\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.");
                break;

            case ERROR_EXTENDED_ERROR:
                dwRC = WNetGetLastError
                            (&dwProvErrNum,
                             ProvErrDesc,
                             sizeof (ProvErrDesc),
                             ProvErrName,
                             sizeof (ProvErrName));
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "A Network Provider specific error has occurred.\n\n"
                   "The Network Provider is: %s\n\n"
                   "The Network Provider Error Number is: %li\n\n"
                   "The Network Provider Error Description is: %s\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.",
                   ProvErrName,
                   dwProvErrNum,
                   ProvErrDesc);
                break;

            case ERROR_INVALID_PASSWORD:
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "An invalid password was used to attempt and connect"
                   " the network drive.  This error should not occur as"
                   " the connection should be made using the guest id"
                   " which does not require a password.\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.");
                break;

            case ERROR_NO_NET_OR_BAD_PATH:
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "A network component has not been started or the"
                   " network path specified cannot be used.\n\n"
                   "Please make sure that the network path for the"
                   " Component Inventory file is correct in the NT"
                   " Registry.\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.");
                break;

            case ERROR_NO_NETWORK:
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "No network is present to connect the required"
                   " network drive.\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.");
                break;

            default:
                  sprintf
                  (MsgTxt,
                   "Inventory of Files Error.\n\n"
                   "An unknown network error occurred.  The return"
                   " code from the connection attempt is: %li\n\n"
                   "Please contact the help desk with the above information"
                   " for problem determination.");
                break;
        }

        ShowMessageToUser
                (NULL,
                 CMN_ERROR,
                 MsgTxt);
        return (12);
    }

#endif

    /*
    |   Get the path to the CSSCOMP.INV file from the CSS.INI
    |       file in OS/2 and the NT Registry in NT.
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
#ifdef WIN32
                  sprintf
                     (MsgTxt,
                      "Inventory of Files Error.\n\n"
                      "The CSS Component Inventory file name could not"
                      " be found in the NT Registry.  Please contact"
                      " the help desk to make sure that the registry"
                      " has been properly setup.");
                ReportError ("AZVS02 - Missing CSS information in NT Registry");
#else
                sprintf
                     (MsgTxt,
                      "Inventory of Files Error.\n\n"
                      "The CSS Component Inventory file name could not"
                      " be found in the CSS.INI file.  Please contact"
                      " the help desk to make sure that the CSS.INI file"
                      " exists and is the correct version.");
                ReportError ("AZVS02 - Missing information in CSS.INI");
#endif
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);
            return (12);

        case CMN_PRF_SIZE_ERROR:
#ifdef WIN32
                  sprintf
                     (MsgTxt,
                      "Inventory of Files Error.\n\n"
                      "The buffer to hold the CSS Component Inventory"
                      " file name was not large enough.  Please contact"
                      " the help desk as this is an unrecoverable error."
                      " Have the help desk verify that the file name in the"
                      " CSS entries of the NT Registry is correct.");
#else    
                sprintf
                     (MsgTxt,
                      "Inventory of Files Error.\n\n"
                      "The buffer to hold the CSS Component Inventory"
                      " file name was not large enough.  Please contact"
                      " the help desk as this is an unrecoverable error."
                      " Also have the help desk verify that the CSS.INI"
                      " file is the correct version.");
#endif
            ReportError ("AZVS02 - Filename buffer size error");
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);
            return (12);

        case CMN_PRF_FATAL_ERROR:
#ifdef WIN32
                  sprintf
                     (MsgTxt,
                      "Inventory of Files Error.\n\n"
                      "There has been a fatal error when attempting"
                      " to obtain the CSS Component Inventory file name"
                      " from the NT Registry.  The cause of the error"
                      " cannot be ascertained and must be determined by"
                      " other methods.\n\nPlease contact the help desk for"
                      " problem determination.");
                ReportError ("AZVS02 - NT Registry access fatal error");
#else
                sprintf
                     (MsgTxt,
                      "Inventory of Files Error.\n\n"
                      "There has been a fatal error when attempting"
                      " to obtain the CSS Component Inventory file name"
                      " from the CSS.INI file.  The cause of the error"
                      " cannot be asertained and must be determined by"
                      " other methods.\n\nPlease contact the help desk for"
                      " problem determination.");
                ReportError ("AZVS02 - CSS.INI information access fatal error");
#endif
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);
            return (12);

        default:
#ifdef WIN32
                     sprintf
                     (MsgTxt,
                      "Inventory of Files Error.\n\n"
                      "Some other error has occurred while attempting"
                      " to obtain the CSS Component Inventory file name"
                      " from the NT Registry.  The cause of the error"
                      " is unknown, but the return code is: %i\n\n"
                      " Please contact the help desk with the above information"
                      " for problem determination.",
                      rc);
#else
                sprintf
                     (MsgTxt,
                      "Inventory of Files Error.\n\n"
                      "Some other error has occurred while attempting"
                      " to obtain the CSS Component Inventory file name"
                      " from the CSS.INI file.  The cause of the error"
                      " is unknown, but the return code is: %i\n\n"
                      " Please contact the help desk with the above information"
                      " for problem determination.",
                      rc);
#endif
            ShowMessageToUser
                    (NULL,
                     CMN_ERROR,
                     MsgTxt);
            sprintf (Msg,
                     "AZVS02 - Unknown error from CmnOsGetProfileValue: %i",
                     rc);
            ReportError (Msg);
            return (12);
    }

  return 0;
}

/* Function to determine if we should be showing a message to the user.  If so, it shows it. */
SHORT ShowMessageToUser( HWND hwnd, SHORT sSeverity, CHAR *pszMsgText )
{
  /* For CSS Diagnostics version we don't need to do anything. */
  return(0);

  if(FlNoPopUp)
  {
      return 0;
  }

  CmnOsDisplayMessageBox(hwnd, sSeverity, pszMsgText);

  return 0;
} /* End: ShowMessageToUser */
