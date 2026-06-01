/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***************************************************************************
**
**               Customer Service System Session Data Function
**
**  PROGRAM          : AZSS01.C
**
**  DESCRIPTION      : This program reads in values from SessData.txt to
**                     fill in the Session Data structure with values for
**                     testing.
**
**  CALLED FUNCTIONS : NONE
**
**  AUTHOR           : JLOONEY
**
**  DATE CREATED     : 08/11/93
**
**  REVISION HISTORY :
**
**  DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**  --------  -----------  -------  -------------------------------------
**  08/11/93  JLOONEY               Original code.
**
**  03/05/94  JLOONEY               The AZRCSM01.H was changed to no longer
**                                  contain TxResourceId.  It now contains
**                                  CdResourceId.
**
**  08/01/94  L Misfeldt            Modified to use the userid information
**                                  from PMF instead of being hard-coded
**                                  in the sessdata.txt file.
**                                  Modified to allow updates to the
**                                  shared memory if it already exists.
**
**  08/16/94  L Misfeldt            Modified to run a program that holds
**                                  session data as a detached process.
**
**  08/22/94  L Misfeldt            Modified to set the strict security
**                                  flag from the sessdata.txt file.
**
**  02/11/95  J. Looney				Changed to compile in OS/2 or NT.
**  09/17/96  CWOODS                Removed Resource ID and Resource Rights
**                                  from Session Data.  This has been added
**                                  to the Security Application.
***************************************************************************/
/**************************************************************************
**
**   Operating System #defines
**
***************************************************************************/
#define  INCL_DOS
#define INCL_WIN

#ifdef FND_OS2
  #include <os2.h>
#endif

#ifdef FND_WIN32
  #include <windows.h>
#endif

/**************************************************************************
**
**   C Runtime #includes
**
***************************************************************************/
#include <string.h>
#include <stdio.h>
#include <conio.h>
#include <float.h>
#include <limits.h>
#include <stdlib.h>
#include <malloc.h>
#include <ctype.h>
#include <stdarg.h>

/**************************************************************************
**
**   Foundation #includes
**
***************************************************************************/
#define  FND_FE_INCL
#define  FND_IM_INCL
#define  FND_EH_INCL
#define  FND_PS_INCL
#define  FND_CF_INCL
#define  FND_ST_INCL
#define  FND_OS_INCL
#define  FND_CTCONV_INCL
#define  FND_VERSION2

/* FND_WIN32: Conditional inclusion of kglzk000.h/kglxk000.h */
#ifdef FND_OS2
 #include <kglzk000.h>
#endif
#ifdef FND_WIN32
 #include <kglxk000.h>
#endif

/**************************************************************************
**
**   C1/C Architecture #include
**
***************************************************************************/
#define INCL_C1CBASE
#include <c1c.h>
#include <pmf.h>

/**************************************************************************
**
**   AZSS01 #defines
**
***************************************************************************/
#define SessionDataFile    "C:\\DATA\\SessData.txt"
#define _CUR_LINE_LEN      255
#define _DUMMY_LEN         30

/**************************************************************************
**
**   AZSS01 Function Prototypes
**
***************************************************************************/
SHORT LoadSessionData (CMN_HMEM     hSessionData,
                       _PMFUIDPASS *UidPassInfo);

SHORT ReportError (char *ErrorText);

cdecl main(int argc, char *argv[]);


/**************************************************************************
**
**   AZSS01 Main
**
***************************************************************************/
#ifdef WIN32
    int WINAPI WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance,
                LPSTR lpszCmdLine, int nCmdShow)
#else
    _cdecl main (void)
#endif
{
    USHORT FndGenRC                 = 0;
    SHORT i;
    _ABHI                           ABHI;
    ABHINAME                       *pABHI = &ABHI;
    _AZRCSM01SESSDATA *pSessionData = NULL;
    CMN_HMEM                       hSessionData;

    #ifdef WIN32
        DWORD   dwRC;
    #endif

    ULONG FndGenAsyncProcessId,
           FndGenSyncReturnCode;

    _MSG_PARM_BLOCK     MsgPB;
    _MSG_PARM_BLOCK     MsgPBShut;
    _ABHI               Abhi;

    _PMFUIDPASS UidPassInfo;

    _FND_ERROR_BLOCK    FndErrorBlock;

    /*
    |   Try to establish a FND message queue to verify that FOUNDATION
    |       Production is running.
    */
    memset (&MsgPB, 0, sizeof (_MSG_PARM_BLOCK));
    memset (&Abhi, 0, sizeof (_ABHI));
    MsgPB.src.service_id.appl = 2;
    memcpy (MsgPB.commarea.ver, FND_MSG_VER, _VER_LEN);
    FndGenRC = MSGInit (&MsgPB, &Abhi);
    switch (FndGenRC)
    {
        case MSGIO_SUCCESS:
            break;

        case MSGIO_FATAL_ERROR:
        case MSGIO_ERRPARMS:
        case MSGIO_INVALID_VERSION:
            CmnOsDisplayMessageBox
                (HWND_DESKTOP,
                 12,
                 "AZSS01 - Session Data Error\n"
                 "Could not create DS Message Queue");
            printf ("\nAZSS01 - Could not create DS Message Queue\n");
            return (12);

        case MSGIO_NONEXISTENT:
            CmnOsDisplayMessageBox
                 (HWND_DESKTOP,
                  12,
                  "AZSS01 - CSS Session Data Error.\n"
                  "FOUNDATION Production must be running to create"
                  " CSS Session Data.  Please start FOUNDATION"
                  " Production and restart Session Data (AZSS01)");
            printf
              ("\nAZSS01 - CSS Session Data Error.\n"
               "  FOUNDATION Production must be running to create\n"
               "    CSS Session Data.  Please start FOUNDATION\n"
               "    Production and restart Session Data (AZSS01).\n");
            return (12);
    }

    /*
    |   Shut down the FND message queue created above
    */
    memset (&MsgPBShut, 0, sizeof (_MSG_PARM_BLOCK));
    memset (&Abhi, 0, sizeof (_ABHI));
    MsgPBShut.src.service_id.appl = 2;
    memcpy (MsgPBShut.commarea.ver, FND_MSG_VER, _VER_LEN);
    memcpy (MsgPBShut.src.net_addr.port,
            MsgPB.src.net_addr.port,
            sizeof (MsgPB.src.net_addr.port));
    MSGShut (&MsgPBShut, &Abhi);

    /*
    |   Get the Userid from PMF.
    */
    //#ifdef FND_WIN32
    //    FndGenRC = PmfGetUidPass (NULL, &UidPassInfo, &dwRC);
    //#else
    //    FndGenRC = PmfGetUidPass (&UidPassInfo);
    //#endif
	FndGenRC = PMF_SUCCESS;
    if (FndGenRC != PMF_SUCCESS)
    {
        CmnOsDisplayMessageBox
            (HWND_DESKTOP,
             12,
             "AZSS01 - CSS Session Data Error.\n"
             "You must be logged onto the Password Management Facility"
             " in order to run CSS applications and create session data."
             "  Please logon to the Password Management Facility and"
             " and restart Session Data (AZSS01).");

        printf
          ("\nSession Data Creation Error.\n"
           "  You must be logged onto the Password Management Facility\n"
           "    inorder to run CSS applications and create session\n"
           "    data.  Please logon to the Password Management Facility\n"
           "    and restart Session Data (AZSS01).\n");

        ReportError
            ("AZSS01 - Not Logged-On to Password Management Facility");
        return (12);
    }

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
        |   Load Session Data since shared memory exists and return.
        */
        LoadSessionData (hSessionData, &UidPassInfo);
    }
    else
    {
        /*
        |   Since session data does not exist, start the program
        |        that will allocate and hold the memory.
        */
        FndGenRC = FndProcessStartAppl
                        ("AZSS03.EXE",
                         FND_PROCESS_BACKGROUND,
                         &FndGenAsyncProcessId,
                         &FndGenSyncReturnCode,
                         &FndErrorBlock,
                         "",
                         NULL);

        /*
        |   Attempt to get the shared memory handle again.
        */
        for (i=0;
             ((i < 10)
                &&
              (!hSessionData));
            i++)
        {
            CmnOsSleep (1000L, CMN_NULL_ARCH_PARMS);
            FndGenRC = CmnMemGetNamedHandle (CMN_SESSDATA_MEM_NAME,
                                             &hSessionData,
                                             CMN_NULL_ARCH_PARMS);
        }

        /*
        |   See if we were able to obtain a handle to session
        |       data.
        */
        if (i >= 10)
        {
            CmnOsDisplayMessageBox
                (HWND_DESKTOP,
                 12,
                 "AZSS01 - Session Data Creation Error.\n"
                 "Memory to contain session data could not be"
                 " allocated or AZSS03.EXE could not be started."
                 "Please contact Technical Support.");
            printf
              ("\nSession Data Creation Error.\n"
               "  Memory to contain session data could not be\n"
               "    allocated.  Please try again.\n");
            ReportError
                ("AZSS01 - Could Not Allocate CSS Session Data");
            return (12);
        }

        /*
        |   Since we were able to obtain a handle to session data,
        |       load Session Data.
        */
        LoadSessionData (hSessionData, &UidPassInfo);
    }

    return(0);

} /* End of Main */

/**************************************************************************
**
**   LoadSessionData
**
***************************************************************************/
SHORT LoadSessionData (CMN_HMEM     hSessionData,
                       _PMFUIDPASS *UidPassInfo)
{
    FILE *Stream;
    SHORT i                 = 0;
    SHORT NumberOfResourceIds       = 0;
    SHORT NumberOfCdInternalMails   = 0;
    CHAR CurLine[_CUR_LINE_LEN]     = "";
    CHAR Dummy1[_DUMMY_LEN] = "";
    CHAR Dummy2[_DUMMY_LEN] = "";
    char StrictSecFlag[2];
    BOOL fDone;

    _AZRCSM01SESSDATA *pSessionData;

    /*
    |   Get the pointer to the shared memory
    */
    CmnMemGetPointer (hSessionData,
                      &pSessionData,
                      CMN_NULL_ARCH_PARMS);

    /* Open Map File */
    if (( Stream = fopen( SessionDataFile,"r" )) == NULL )
    {
         CmnOsDisplayMessageBox( HWND_DESKTOP,
                                 12,
                 "AZSS01 - Session Data Creation Error.\n"
                 "The Session Data off-host text file "
                 "(C:\\DATA\\SESSDATA.TXT) could not be found.  "
                 "Please ensure that you have SESSDATA.TXT in "
                 "C:\\DATA." );

         printf( "ERROR OPENING SESSDATA.TXT!\n" );
         ReportError ("AZSS01 - Session Data WAS NOT successfully loaded");
    }

    /*
    |   Initialize session data
    */
    memset (pSessionData, 0, sizeof(_AZRCSM01SESSDATA));

    /* Format CdPrinter */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %s %s",
            Dummy1,     /* SESSAzrcsm01ArchData */
            Dummy2,     /* ***CdPrinter */
            pSessionData->Azrcsm01ArchData.CdPrinter );

    /* Format Nodomain */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %lD",
            Dummy1,     /* ***Nodomain */
            &(pSessionData->Azrcsm01ArchData.Nodomain) );

    /* Format NoStation */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %lD",
            Dummy1,     /* ***NoStation */
            &(pSessionData->Azrcsm01ArchData.NoStation) );

    /* Format TxLanId - now ignored obtained from PMF*/
    fgets( CurLine,_CUR_LINE_LEN, Stream );
	/* For NON-PMF: use sscanf stmt and not strcpy */
    sscanf( CurLine,
            "%s %s",
            Dummy1,     /* ***TxLanId */
            pSessionData->Azrcsm01ArchData.TxLanId );
    //strcpy (pSessionData->Azrcsm01ArchData.TxLanId,
    //        UidPassInfo->LanID);


    /* Number of RsrceRgts */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %s %d",
            Dummy1,     /* RSRCERGTS */
            Dummy2,     /* ***NumberOfResourceIds */
            &NumberOfResourceIds );

    /* Format the RsrceRgts */
    for ( i = 0; i < NumberOfResourceIds; i++ )
    {

        /* Format CdResourceId */
        fgets( CurLine,_CUR_LINE_LEN, Stream );

        /* CWOODS 09/17/96:  Resource Rights removed
           from Session Data */
        //sscanf( CurLine,
        //        "%s %s",
        //        Dummy1,     /* ***CdResourceId */
        //        pSessionData->Azrcsm01ArchData.RsrceRgts[i].CdResourceId );

        /* Format CdAccessRights */
        fgets( CurLine,_CUR_LINE_LEN, Stream );

        /* CWOODS 09/17/96:  Resource Rights removed
           from Session Data */
        //sscanf( CurLine,
        //        "%s %s",
        //        Dummy1,     /* ***CdAccessRights */
        //        pSessionData->Azrcsm01ArchData.RsrceRgts[i].CdAccessRights );

     } /* End of For Loop: Format the RsrceRgts */

    /* Format KyUserId - now ignored, obtained from PMF */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
	/*  For NON-PMF: use sscanf stmt and not strcpy */
    sscanf( CurLine,
            "%s %s %s",
            Dummy1,     /* SESSAPPLDATA */
            Dummy2,     /* ***KyUserId */
            pSessionData->Azgrsm03ApplData.KyUserId );
    //strcpy (pSessionData->Azgrsm03ApplData.KyUserId,
    //        UidPassInfo->OTNumber);

    /* Format NmUser */
    fgets( CurLine,_CUR_LINE_LEN, Stream );

    {    char *result;

         /* Locate the '=' in the CurLine. */
         result = strchr( CurLine, '=' );

         result++;

         /* Search for the first character of the name. */
         while ( *result++ == ' ');

         /* Copy result into NmUser */
         strncpy( pSessionData->Azgrsm03ApplData.NmUser,
                  --result,
                  31 );

         /* Have result point to the last character in the string */
         result = &( pSessionData->Azgrsm03ApplData.
                     NmUser[ strlen( pSessionData->Azgrsm03ApplData.NmUser )
                     - 1 ]);

         while (( *result == ' ' ) || ( *result == '\n' ))
         {
             *result = '\0';
             result--;
         }

    }

//    sscanf( CurLine,
//            "%s %s %s",
//            Dummy1,     /* ***NmUser */
//            pSessionData->Azgrsm03ApplData.NmUser,
//           Dummy2 );

//    strcat( pSessionData->Azgrsm03ApplData.NmUser, " " );
//    strcat( pSessionData->Azgrsm03ApplData.NmUser, Dummy2 );

    /* Format KyPwqGrp */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %s",
            Dummy1,     /* ***KyPwqGrp */
            pSessionData->Azgrsm03ApplData.KyPwqGrp );

    /* Format CdWorkLocation */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %s",
            Dummy1,     /* ***CdWorkLocation */
            pSessionData->Azgrsm03ApplData.CdWorkLocation );

    /* Format CdSecurityGroup */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %s",
            Dummy1,     /* ***CdSecurityGroup */
            pSessionData->Azgrsm03ApplData.CdSecurityGroup );

    /* Format TxUserAcd */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %s",
            Dummy1,     /* ***TxUserAcd */
            pSessionData->Azgrsm03ApplData.TxUserAcd );

    /* Format TxUserPhnNo */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %s",
            Dummy1,     /* ***TxUserPhnNo */
            pSessionData->Azgrsm03ApplData.TxUserPhnNo );

    /* Format TxUserPhnExtn */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %s",
            Dummy1,     /* ***TxUserPhnExtn */
            pSessionData->Azgrsm03ApplData.TxUserPhnExtn );

    /* Format NoRa */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %s",
            Dummy1,     /* ***NoRa */
            pSessionData->Azgrsm03ApplData.NoRa );

    /* Number of CdInternalMails */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %s %d",
            Dummy1,     /* CDINTERNALMAIL */
            Dummy2,     /* ***NumberOfCdInternalMails */
            &NumberOfCdInternalMails );

    /* Format the first of the CdInternalMails */
    fgets( CurLine,_CUR_LINE_LEN, Stream );
    sscanf( CurLine,
            "%s %s",
            Dummy1,     /* ***CdInternalMail */
            pSessionData->Azgrsm03ApplData.CdInternalMail );

    /*
    |   Locate the strict security flag and update it
    */
    pSessionData->Azrcsm01ArchData.FlStrictSecurity[0] = 'N';
    fDone = FALSE;
    while ((fgets (CurLine, _CUR_LINE_LEN, Stream))
             &&
           (!fDone))
    {
        /*
        |   See if the text contains the string 'StrictSec'
        */
        if (strstr(CurLine, "StrictSec"))
        {
            sscanf (CurLine,
                    "%s %s",
                    Dummy1,
                    StrictSecFlag);
            pSessionData->Azrcsm01ArchData.FlStrictSecurity[0] = StrictSecFlag[0];
            fDone = TRUE;
        }
    }

    ReportError ("AZSS01 - Session Data was successfully loaded");
    return (0);
}

/**************************************************************************
**
**   ReportError
**
***************************************************************************/
SHORT ReportError (char *ErrorText)
{
   USHORT             rc = 0;
   _FND_STANDARD_PB   ParmBlock;
   _ST_FMT_DATA_BLOCK FormatDataBlock;
   _DESCR             UnformatDataBlock;
   _ABHI              Abhi;

   #ifdef FND_OS2
    PIDINFO            PidInfo;
   #endif
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
   strcpy (Abhi.abhi_monitor_data_block.fnd_win_name, "AZSS01");
   #ifdef FND_OS2
    DosGetPID (&PidInfo);
    Abhi.abhi_monitor_data_block.fnd_process_id = PidInfo.pid;
    Abhi.abhi_monitor_data_block.fnd_thread_id = PidInfo.tid;
   #endif
   #ifdef FND_WIN32
    Abhi.abhi_monitor_data_block.fnd_process_id = GetCurrentProcessId();
	Abhi.abhi_monitor_data_block.fnd_thread_id = GetCurrentThreadId();
   #endif
   strcpy (Abhi.abhi_pgm_id, "AZSS03");
   Abhi.abhi_error_appl_type = FND_APPL_TYPE_CLIENT;
   Abhi.abhi_error_type_code = FND_ERR_TYPE_APPL;
   strcpy (Abhi.abhi_load_image_name, "AZSS03");
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
