/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/*****************************************************************
**
**        CUSTOMER SERVICE SYSTEM CSR MAP GENERATOR MODULE
**
**
**  FILENAME      :  AZCSM010.C
**
**  DESCRIPTION   :  CSR Map Generator functions:
**
**                          GenerateMap
**                          WriteSDM
**                          WriteRMH
**                          GenerateService
**                          WriteCK
**                          WriteRD
**                          WriteLK
**                          WriteLD
**                          FindRPMH
**                          WriteRPMHAndThenSome
**                          WriteRPCK
**                          WriteRPRD
**                          WriteRPLK
**                          WriteRPRD
**                          DecodeDataType
**                          FormatHighValues
**                          FileAdd
**                          AZCS01MegaScrollPush
**                          AZCS01MegaScrollPop
**                          AZCS01MegaScrollPopAll
**
**  DATE CREATED  :  06/09/93
**
**  REVISION HISTORY
**
**  DATE        REVISED BY    SIR #    DESCRIPTION OF CHANGE
**  --------    ----------    -----    ---------------------
**  09/15/93    JLOONEY                Added CSR_BYTE to DecodeDataType.
**  10/15/93    JLOONEY                Changed the fprintfs of CK, LK, LD,
**                                     RPCK, RPLK, and RPLD to print a
**                                     Literal up to 61 characters.
**
**  11/03/93    JLOONEY                Modified WriteRPCK, WriteRPLK, and
**                                     WriteRPLD.
**  12/03/93    CCRAMPTO               Modified Generate map(), strcmp for alternate
**                                     service with NULL from == to !=.
**
**  03/17/94    CCRAMPTO               Add logic to write temporary file to
**                                     the generation directory not the CWD.
**
**  07/14/94    JLOONEY                Moved high and low value #defines
**                                     to C1CPRIV.H
**
**  07/18/94    CCRAMPTO               Add INCL_AGRWN01 so C1CPRIV will not
**					get errors.
**
** 01-31-96    MCONNER		      moved CSSr map includes to precede
**				      Architecture includes to prevent
**				      redefinition of _BFCD
**
** 03/25/96   mconner               added #defs for OS/2 and WINNT declarations
**
** 03/25/96   mconner               cast strlen to USHORT in min calls
**
** 04/22/96   mconner               Added call to remove tmp file and
**                                  created FileAdd to concatenate tmp file
**                                  to the map file.  This removes the calls
**                                  to "system" from the program.
**
** 08/20/96   jlooney				Modified if statements for FND 3.0 INT3
**								    date issue (internally now stored as N).
**									WriteCK, WriteLK, and WriteLD
** 11/15/96      CWOODS             PTF-A - Added check for Usage = 'V' if it
**                                  is a Date Type.
**
** 03/25/99     NEYDE               Added three megascrolling functions which
**                                  are modelled after the CSS counterparts.
******************************************************************/

/**************************************************************************
**
**    #defines
**
***************************************************************************/
#define INCL_WIN
#define  INCL_DOS

#define WINDOWMOD
#ifdef FND_WIN32
#include <windows.h>
#endif
#ifdef FND_OS2
#include <os2.h>
#endif

/**************************************************************************
**
**   C Runtime #includes
**
***************************************************************************/
#include <string.h>
#include <stdio.h>
#include <float.h>
#include <limits.h>
#include <stdlib.h>
#include <malloc.h>
#include <ctype.h>
#include <stdarg.h>
#include <time.h>


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
#define  FND_CTCONV_INCL
#define  FND_VERSION2

#ifdef FND_OS2
#include <kglzk000.h>
#endif
#ifdef FND_WIN32
#include <kglxk000.h>
#endif

/**************************************************************************
**
**   CSR Map Generator #includes
**
***************************************************************************/
/*mdc 03/20/96 these are already included in azcs01b.gnb
#include "csrcmn.h"
#include "mapgen.h"
*/
#include "azcs01b.gnb"
#include "AZCS003.GNH"


/**************************************************************************
**
**   C1/C Architecture #include
**
***************************************************************************/
#include <C1CEAB.H>
#define  INCL_C1CBASE
#define  INCL_C1CPRIV
#define  INCL_AGRWN01
#include <c1c.h>


/**************************************************************************
**
**   AZCSM010.C Function Prototypes
**
***************************************************************************/
USHORT FormatHighValues(_LAYOUT_REC ServiceLayout,
                        CHAR *pszFormatString,
                        SHORT sFormatStringLen);

USHORT FileAdd(FILE *, FILE *);

/*mdc 11/21/96 include global header file*/
#include "azcs01.h"


/**************************************************************************
**
**   AZCSM010.C Variable Declarations
**
***************************************************************************/
CHAR FileNm[_CSR_MAP_FILENAME_LEN];
FILE *Stream, *TmpFile;
SHORT MapDataLength;

/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**  FUNCTION         : BuildFullName
**
**  DESCRIPTION      : This function builds a fully qualified name. Fully qualified
**                      means it goes all the way thru its hierarchial structure to build
**                      the name. This implies that a truly unique name can be built.
**                      To do this the function calls itself recursively until it gets to the
**                      top of its hierarchial tree (parent index = -1). Then as it returns
**                      from each of the recursive calls it concatenates the C name of the element
**                      at this level to the previous levels.
**
**                     **** NOTE **** The name is built in a static character array. Subsequent calls
**                                     to this function will destroy the data in this array.
**
**
**  INPUTS           : sElementx - Index of the variable whose name to build.
**                     pLayout - pointer to the data layout.
**
**  OUTPUTS          : Return Code - SHORT (Valid: CMN_SUCCESS or CMN_FAIL).
**
**  CALLED FUNCTIONS : Itself - This function is recursive.
**
**  AUTHOR           : C. Crampton
**
**  DATE CREATED     : 11/08/93
**
**  REVISION HISTORY :
**
**  DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**  --------  -----------  -------  -------------------------------------
**  11/08/93  C. Crampton           Original code.
**
**  10/18/94  J. Looney             Clean Up.
**	03/22/96  mconner               Commented out HEAP_CHECK_BEEP
**  11/21/96  mconner               Moved from azcs013.cb
**
***************************************************************************/
CHAR *BuildFullName( SHORT sElementx, _LAYOUT_REC *pLayout)
{
    static CHAR szFullName[255];
    CHAR *pszTemp;
    SHORT sParentx;
    static SHORT sNestedLevel=0;

    /*HEAP_CHECK_BEEP*/

    /*
     * sParentx will be -1 when you are at the top of the hierarchy
     */
    sParentx = pLayout[sElementx].ParentIndex;

    /* if not at top call yourself again, Also keep track of how deep in */
    /*   the hierarchy you are. */
    if ( sParentx != -1 )
    {
        sNestedLevel++;

        BuildFullName( sParentx, pLayout );

        sNestedLevel--;
    }
    else
    {
        strncpy( szFullName, "", sizeof( szFullName));

        sElementx = 0;
    }

    /* Concatenate the C name onto the end of szFullName */
    strcat( szFullName, pLayout[sElementx].ItemCName );

    /*
     * Find out if the end of the field is blank filled. If it is then
     * we want to put a null where the first blank field is. pszTemp
     * will contain the address of the first blank or Null if none exist.
     * A  period is placed between each level in the hierarchy, but
     * not at the end of the name.
     */
    pszTemp = strchr(szFullName, ' ');

    /* Blank filled and not at the end */
    if ( pszTemp && sNestedLevel != 0 )
    {
        strcpy(pszTemp,".");
    }

    /* blank filled and at the end */
    else if ( pszTemp && sNestedLevel == 0 )
    {
        strcpy( pszTemp, "" );
    }

    /* Not Blank filled and not at end */
    else if ( !pszTemp && sNestedLevel != 0 )
    {
        strcat(szFullName, ".");
    }

    /* Not Blank filled and at the end */
    else
    {
        strcat(szFullName, "");
    }

    /*HEAP_CHECK_BEEP*/

    return( szFullName );

} /* end of BuildFullName */


/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**  FUNCTION         : FindFullName
**
**  DESCRIPTION      : This function looks in a layout_rec structure trying to find
**                       an occurence of a Parent and Element name.
**
**  INPUTS           : sSavedIndex - Index into the saved data layout.
**                     pSavedLayout - Pointer to the saved data layout.
**                     pReposLayout - Pointer to the repository data layout.
**                     sNumReposRows - Number of rows in the repository.
**
**  OUTPUTS          : sReposIndex - Matching index in the repository data layout.
**                     Return Code - Number of matches found (0 or 1).
**
**  CALLED FUNCTIONS : BuildFullName
**
**  AUTHOR           : C. Crampton
**
**  DATE CREATED     : 11/08/93
**
**  REVISION HISTORY :
**
**  DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**  --------  -----------  -------  -------------------------------------
**  11/08/93  C. Crampton           Original code.
**
**  10/18/94  J. Looney             Clean Up
**  03/22/96  mconner               Commented out HEAP_CHECK_BEEP
**  11/21/96  mconner               Moved from azcs013.cb as a global function
**
***************************************************************************/
SHORT FindFullName(SHORT sSavedIndex,
                   _LAYOUT_REC *pSavedLayout,
                   _LAYOUT_REC *pReposLayout,
                   SHORT sNumReposRows,
                   SHORT *sReposIndex)
{
    SHORT sIndex;
    CHAR szBuildName[255];
    CHAR szTempName[255];

    /*HEAP_CHECK_BEEP*/

    /* Build the full name for the saved element */
    strncpy( szBuildName,
             BuildFullName(sSavedIndex, pSavedLayout),
             sizeof( szBuildName ));

    /*
     * Loop thru all of the layout records looking for a match on the group
     * and element name.  Only check records that have a non negative
     * parent index.  A match occurs if the parent index matches the group
     * and ItemId matches the element name
     */
    for ( sIndex = 0; sIndex < sNumReposRows; sIndex++ )
    {
        strncpy( szTempName,
                 BuildFullName(sIndex, pReposLayout),
                 sizeof( szTempName ));

        if (strcmp(szBuildName, szTempName) == 0 )
        {
            *sReposIndex = sIndex;

            /*HEAP_CHECK_BEEP*/

            return(1);

        } /* End of if element data type */

    } /* end of for loop thru each layout record */

    /*HEAP_CHECK_BEEP*/

    return(0);

} /* End of FindFullName */


/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  GenerateMap
**
**  DESCRIPTION   :  Generates the CSR Map file.
**
**  INPUTS        :  CMN_ARCH_PARM_TYPES
**
**  OUTPUTS       :  CMN_SUCCESS, CMN_FAIL
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/09/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/09/93      J. Looney                Original Code
**
******************************************************************/

USHORT GenerateMap( CMN_ARCH_PARM_TYPES )
{
    CHAR CopyCommand[_COPY_COMMAND_LEN];
    /*mdc 11/26/96 no longer used
    SHORT NumberClosed;
    */
    /*mdc 11/26/96 return code for file close*/
    int rc = 0;
    SHORT i;
    SHORT j;
    USHORT FndGenRC;
    CHAR TmpFileNm[_CSR_MAP_FILENAME_LEN] = "";
    _FND_ERROR_BLOCK  FndGenErrorBlock;
    USHORT SelectedButton;
	LONG lSysRC = 0;


    /* Initialize CopyCommand */
    memset(CopyCommand, '\0', _COPY_COMMAND_LEN);

    MapDataLength = 0;

    sprintf(TmpFileNm, "%s\\%s", BFCD_pCSRMapBFCD->CsrMapGenPath, MAP_TMP_FILE);

    /* Open the temporary map file. */
    if (( TmpFile = fopen( TmpFileNm,"w" )) == NULL )
    {
       FndGenRC = FndMsgBoxDisplayText("Unable to open temporary file\n"
                                       "Make sure your generation directory is valid.\n\n"
                                       "Generation of map failed.",
                                       NULL,
                                       CBI_hwnd,
                                       FND_MSGBOX_OK,
                                       FND_MSGBOX_ERROR,
                                       FND_MSGBOX_IDOK,
                                       NULL,
                                       &SelectedButton,
                                       &FndGenErrorBlock);

       return( CMN_FAIL );
    }


    for ( i = 0; i < BFCD_pCSRMapBFCD->NumServices; i++ )
    {
      /* Check if Service is deleted */
      if ( BFCD_pCSRMapBFCD->ServiceInfoTable[i].DeleteFlag )
      {
         /* if deleted, continue onto the next service */
         continue;
      }

      if ( strcmp( BFCD_pCSRMapBFCD->ServiceInfoTable[i].ServiceType,
                   LT_Primary ) == 0 )
      {

         FndGenRC = GenerateService ( BFCD_pCSRMapBFCD->ServiceInfoTable[i].pReposServiceLayoutTable,
                                      BFCD_pCSRMapBFCD->ClientInfo.pReposClientLayoutTable,
                                      BFCD_pCSRMapBFCD->ServiceInfoTable[i].pRepeatingMaps,
                                      BFCD_pCSRMapBFCD->ServiceInfoTable[i].pCompareKeys,
                                      BFCD_pCSRMapBFCD->ServiceInfoTable[i].pReturnData,
                                      BFCD_pCSRMapBFCD->ServiceInfoTable[i].pLoadKeys,
                                      BFCD_pCSRMapBFCD->ServiceInfoTable[i].pLoadData,
                                      i,
                                      BFCD_pCSRMapBFCD->ServiceInfoTable);

         if (( strcmp( BFCD_pCSRMapBFCD->ServiceInfoTable[i].AlternateService,
               "NULL" ) != 0 ))
         {
            /* Search for Alternate Service */
            for ( j = 0; j < BFCD_pCSRMapBFCD->NumServices; j++ )
            {
                if (( strcmp( BFCD_pCSRMapBFCD->ServiceInfoTable[j].ServiceLayoutName,
                      BFCD_pCSRMapBFCD->ServiceInfoTable[i].AlternateService )
                      == 0 ))
                {
                  FndGenRC = GenerateService ( BFCD_pCSRMapBFCD->ServiceInfoTable[j].pReposServiceLayoutTable,
                                               BFCD_pCSRMapBFCD->ClientInfo.pReposClientLayoutTable,
                                               BFCD_pCSRMapBFCD->ServiceInfoTable[j].pRepeatingMaps,
                                               BFCD_pCSRMapBFCD->ServiceInfoTable[j].pCompareKeys,
                                               BFCD_pCSRMapBFCD->ServiceInfoTable[j].pReturnData,
                                               BFCD_pCSRMapBFCD->ServiceInfoTable[j].pLoadKeys,
                                               BFCD_pCSRMapBFCD->ServiceInfoTable[j].pLoadData,
                                               j,
                                               BFCD_pCSRMapBFCD->ServiceInfoTable);
                  break;
                } /* end of 3rd if */

             } /* end of inner for loop */

         } /* end of 2nd if */

      } /* end of 1st if */

    } /* end of outer for loop */

    if ( BFCD_pCSRMapBFCD->ClientInfo.NumSearchDestroy > 0 )
    {
       WriteSDM( CMN_ARCH_PARMS );
    }

    WriteRMH( CMN_ARCH_PARMS ); /* To a separate file */

    /* mdc 11/26/96 Close tmp file and map file only 
    if ( NumberClosed  != 2)
    {
       return(CMN_FAIL);
    }
    */
    rc = fclose(TmpFile);
    if (rc) return CMN_FAIL;

    rc = fclose(Stream);
    if (rc) return CMN_FAIL;


    /* Combine RMH file with other file */
    /*mdc 11/26/96 No longer needed
    FndGenRC = CmnStrCat( CMN_ARCH_PARMS,
                          CopyCommand,
                          _COPY_COMMAND_LEN,
                          6,
                          "COPY ",
                          FileNm,
                          " + ",
                          TmpFileNm,
                          " ",
                          FileNm );
*/

   /*lSysRC = system(CopyCommand); */
   /*mdc reopen files and cat to FileNm*/
   Stream = fopen(FileNm, "a");
   TmpFile = fopen(TmpFileNm, "r");
   if(Stream == NULL || TmpFile == NULL)
   {
   		fprintf(stderr, "File open failure.");
		return CMN_FAIL;
	}
    


   FndGenRC = FileAdd(Stream, TmpFile);

    /* mdc 11/26/96 Close tmp file and map file only 
    if ((NumberClosed = fcloseall()) != 2)
    {
       return(CMN_FAIL);
    }
    */
    rc = fclose(TmpFile);
    if (rc) return CMN_FAIL;

    rc = fclose(Stream);
    if (rc) return CMN_FAIL;
    
	/*mdc 04/09/96 remove temp file */
	FndGenRC = remove(TmpFileNm);

	return CMN_SUCCESS;

} /* end of GenerateMap */

/*mdc*************************************************************************/
/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  FileAdd
**
**  DESCRIPTION   :  Adds file 2 to file 1.
**                   NOTE: InputChar is declared as an int so that this will
**                         run in 16 bit OS/2 without conversion.
**
**  INPUTS        :  FILE *	ofp - target file
**                   FILE * ifp - source file
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  mconner
**
**  DATE CREATED  :  04/22/96
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**	04/22/96	mconner						created
**     05/21/96      mconner                  Changed logic so that it would not 
**                                                 copy another character after EOF
******************************************************************/
USHORT FileAdd(FILE *ofp, FILE *ifp)
{
	int  InputChar;
	

	 if( ofp  != NULL &&	ifp != NULL)
	 {
                InputChar = getc(ifp);

	 	while (InputChar != EOF)
		{
                    putc(InputChar, ofp );
		    InputChar = getc(ifp);
		    
		}
	  }

	  return CMN_SUCCESS;
}

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  GenerateService
**
**  DESCRIPTION   :  Generates the SMH portion of the CSR Map file.
**
**  INPUTS        :  _LAYOUT_REC  ServiceLayout[]
**                   _LAYOUT_REC  ClientLayout[]
**                   _RELATE_RPMH RPMH[]
**                   _RELATE_CK   CK[]
**                   _RELATE_RD   RD[]
**                   _RELATE_LK   LK[]
**                   _RELATE_LD   LD[]
**                   SHORT Index
**                   _SERVICE_INFO ServiceInfoTable[]
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/11/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/11/93      J. Looney                Original Code
**  12/09/93      C. Crampton              Sevice Age limit is in minutes multiply be
**                                           60 to change to seconds.
**
******************************************************************/
#define SMH_LINE_1 "********  S E R V I C E  M A P  H E A D E R  ********\n"
#define SMH_LINE_2 "**** Server     Service    ServiceDataLength ServiceAgeLimit TranslationMap AnticCallModule Flush     Version #     Force\n"
#define SMH_LINE_3 "**** ------     -------    ----------------- --------------- -------------- --------------- -----  ---------------  -----\n"
#define SMH_LINE_4 "SMH  %-10.1lu %-10.1i %-10.1u        %-10.1lu      %-12.12s   %-11.11s     %-1.1c      %#-15.0f  %-2.2s \n"

/* JLL: 07/07/93 ADDED */
#define ASMH_LINE_1 "********  A L T E R N A T E  S E R V I C E  M A P  H E A D E R  ********\n"
#define ASMH_LINE_2 "**** Server     Service    ServiceDataLength ServiceAgeLimit TranslationMap AnticCallModule Flush  Version #        Force\n"
#define ASMH_LINE_3 "**** ------     -------    ----------------- --------------- -------------- --------------- ----- --------------  -----\n"
#define ASMH_LINE_4 "ASMH %-10.1lu %-10.1i %-10.1i        %-10.1lu      %-12.12s   %-11.11s     %-1.1c     %-15.0f  %-2.2s \n"

USHORT GenerateService(_LAYOUT_REC  ServiceLayout[],
                       _LAYOUT_REC  ClientLayout[],
                       _RELATE_RPMH RPMH[],
                       _RELATE_CK   CK[],
                       _RELATE_RD   RD[],
                       _RELATE_LK   LK[],
                       _RELATE_LD   LD[],
                       SHORT Index,
                       _SERVICE_INFO ServiceInfoTable[])
{
    char Flush;

    GlobalNestedLevel = 0;

    if ( ServiceInfoTable[Index].FlushFlag )
    {
        Flush = 'Y';
    }
    else
    {
        Flush = 'N';
    }

    /* Check if SMH */
    if (( strcmp( ServiceInfoTable[Index].ServiceType, LT_Primary )
           == 0 ))
    {
       /* SMH */
       /* Write the standard header to the file */
       fprintf( TmpFile, BLANK_LINE );
       fprintf( TmpFile, SMH_LINE_1 );
       fprintf( TmpFile, SMH_LINE_2 );
       fprintf( TmpFile, SMH_LINE_3 );
       fprintf( TmpFile, SMH_LINE_4,
                ServiceInfoTable[Index].Server,
                ServiceInfoTable[Index].ServiceId,
                ServiceLayout[0].ItemCLength,
                ( ServiceInfoTable[Index].ServiceAgeLimit * 60 ),
                ServiceInfoTable[Index].ServiceLayoutName,
                ServiceInfoTable[Index].AnticCallModule,
                Flush,
                ServiceInfoTable[Index].Version,
                ServiceInfoTable[Index].ForceCall );

       MapDataLength += _SERVICE_MAP_HEADER;
    }
    else
    {
       /* ASMH */
       /* Write the standard header to the file */
       fprintf( TmpFile, BLANK_LINE );
       fprintf( TmpFile, ASMH_LINE_1 );
       fprintf( TmpFile, ASMH_LINE_2 );
       fprintf( TmpFile, ASMH_LINE_3 );
       fprintf( TmpFile, ASMH_LINE_4,
                ServiceInfoTable[Index].Server,
                ServiceInfoTable[Index].ServiceId,
                ServiceLayout[0].ItemCLength,
                ( ServiceInfoTable[Index].ServiceAgeLimit * 60 ),
                ServiceInfoTable[Index].ServiceLayoutName,
                ServiceInfoTable[Index].AnticCallModule,
                Flush,
                ServiceInfoTable[Index].Version,
                ServiceInfoTable[Index].ForceCall );

       MapDataLength += _SERVICE_MAP_HEADER;

    }

    if ( ServiceInfoTable[Index].pCompareKeys != NULL )
    {
       PrintHeader = TRUE;
       WriteCK(ClientLayout,
               ServiceLayout,
               0,
               RPMH,
               CK);
    }

    if ( ServiceInfoTable[Index].pReturnData != NULL )
    {
       PrintHeader = TRUE;
       WriteRD(ClientLayout,
               ServiceLayout,
               0,
               RPMH,
               RD);
    }

    if ( ServiceInfoTable[Index].pLoadKeys != NULL )
    {
       PrintHeader = TRUE;
       WriteLK(ClientLayout,
               ServiceLayout,
               0,
               RPMH,
               LK);
    }

    if ( ServiceInfoTable[Index].pLoadData != NULL )
    {
       PrintHeader = TRUE;
       WriteLD(ClientLayout,
               ServiceLayout,
               0,
               RPMH,
               LD);
    }

    FindRPMH(ServiceLayout,
             ClientLayout,
             0,
             RPMH,
             CK,
             RD,
             LK,
             LD);

    return( CMN_SUCCESS );

} /* end of GenerateService */

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  WriteCK
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/14/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/14/93      J. Looney                Original Code
**
**  07/22/93      J. Looney                Changed code to print a client
**                                         offset of zero if a literal is
**                                         used.
**
**  11/05/93      C. Crampton              Changed CK_LINE_4 parms 3, 4 from i to u.
**
**  02/11/94      C. Crampton              Changed CK_LINE_4 to use min for length.
**
**  02/14/94      C. Crampton              Changed CK_LINE_4 to use min with strlen of
**                                         literal value.
**
**  06/09/94      C. Crampton              Changed literal value to be strlen + 1**
**
**  07/19/94      C. Crampton              Added logic for high values with Date, Time and
**                                           Timestamp
**
**  08/20/96	  J. Looney				   Added to if stmt to check
**										   for numeric date due to 
**										   FND 3.0 upgrade.
**  11/15/96      CWOODS                   PTF-A - Added check for Usage = 'V' for Date Data Types
******************************************************************/

#define CK_LINE_1 "********  C O M P A R E  K E Y S  ********\n"
#define CK_LINE_2 "**** ClientName                       ServiceName                       FromOffset  ToOffset  Length    DataType    Operation   WildCardUsed WildCard              LiteralUsed LiteralValue \n"
#define CK_LINE_3 "**** ----------                       -----------                       ----------  --------  ------    --------    ---------   ------------ --------              ----------- ------------ \n"
#define CK_LINE_4 "CK   %-32.32s %-32.32s  %-10.1u  %-10.1u%-10.1d%-11.11s %-11.11s %-1.1c            %-21.21s %-1.1c           %-61.61s\n"

USHORT WriteCK( _LAYOUT_REC  ClientLayout[],
                _LAYOUT_REC  ServiceLayout[],
                 USHORT      CurIndex,
                _RELATE_RPMH RPMH[],
                _RELATE_CK   CK[])
{
    SHORT Index = 0;

    Index = ServiceLayout[CurIndex].ChildIndex;


    while ( Index != -1 )
    {
         if (( ServiceLayout[Index].ItemType == 'E' ) &&
             (( CK[Index].LiteralUsed == 'Y' ) ||
              ( CK[Index].ClientLayoutIndex > 0 )))
// CSC: 09/23/93             ( CK[Index].ClientLayoutIndex != -1 )))
         {
            char DataType[_DATA_TYPE_LEN];
            char ItemCName[ITEM_NAME_LEN];
            short ItemOffset;

            /* Get the CK Data Type info */
            memset( DataType, '\0', _DATA_TYPE_LEN );

            DecodeDataType(DataType,
                           ServiceLayout,
                           Index );

            /* Get CK info and write line to the file */
            if ( PrintHeader )
            {
                fprintf( TmpFile, BLANK_LINE );
                fprintf( TmpFile, CK_LINE_1 );
                fprintf( TmpFile, CK_LINE_2 );
                fprintf( TmpFile, CK_LINE_3 );
                PrintHeader = FALSE;
            }

            if ( CK[Index].LiteralUsed == 'Y' )
            {

                strncpy( ItemCName, "NULL", ITEM_NAME_LEN );

                /* Set ItemOffset to 0 because this client offset is not
                 * used when a Literal is used.
                 */

                ItemOffset = 0;

                /*
                ** If the data type is a alphnumeric the length is minimum of
                ** the string length + NULL terminator or of the field length
                ** which would case truncation. But if the literal is High or
                ** Low values use the field length because the CSR will fill
                ** the field with high or low values not the literal string.
				**
				** JLOONEY 08/20/96:  Modified the if statement to check for 
				** a numeric DT that we are treating as a string due to the 
				** change in how FND internally stores DT since the FND 3.0
				** upgrade.  We now need to check for the numeric date in 
				** order to properly copy high and low values for a date.
                */
                if ((toupper(ServiceLayout[Index].Format) == 'A') ||
					((toupper(ServiceLayout[Index].Format) == 'N') &&
					 (strcmp(ServiceLayout[Index].Usage, "DT") == 0)))
                {
                    if ((strcmp(CK[Index].LiteralValue, CMN_HIGH_VALUES_STR) == 0)
                       ||
                        (strcmp(CK[Index].LiteralValue,  CMN_LOW_VALUES_STR) == 0) )
                    {
                        /*
                        ** If Usage is DT (Date) change DataType to CSR_DATE
                        ** If Usage is TS (TimeStamp) change DataType to CSR_TMSTMP
                        ** If Usage is TM (Time) change DataType to CSR_TIME
                        ** Otherwise just leave it as CSR_STRING
                        */                                 
                        /* CWOODS 11/15/96:  PTF-A Release - Check for 'V' Usage */
                        if ( (strcmp(ServiceLayout[Index].Usage, "DT") == 0) ||

                            ((ServiceLayout[Index].ElementTypeCode == 'D') &&
                             (!strcmp(ServiceLayout[Index].Usage,"V"))    ) )

                        {
                            strncpy(DataType, "CSR_DATE", _DATA_TYPE_LEN);
                        }
                        else
                        if (strcmp(ServiceLayout[Index].Usage, "TS") == 0)
                        {
                            strncpy(DataType, "CSR_TMSTMP", _DATA_TYPE_LEN);
                        }
                        else
                        if (strcmp(ServiceLayout[Index].Usage, "TM") == 0)
                        {
                            strncpy(DataType, "CSR_TIME", _DATA_TYPE_LEN);
                        }

                        fprintf( TmpFile,
                                 CK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 DataType,
                                 CK[Index].Operation,
                                 CK[Index].WildCardUsed,
                                 CK[Index].WildCardValue,
                                 CK[Index].LiteralUsed,
                                 CK[Index].LiteralValue);
                    }
                    else
                    {
                        fprintf( TmpFile,
                                 CK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 min(ServiceLayout[Index].ItemCLength,
				     ((USHORT) ( strlen(CK[Index].LiteralValue) + 1))),
                                 DataType,
                                 CK[Index].Operation,
                                 CK[Index].WildCardUsed,
                                 CK[Index].WildCardValue,
                                 CK[Index].LiteralUsed,
                                 CK[Index].LiteralValue);
                    } /* end else not high or low values */
                } /* end of if format is alphanumeric */
                else
                { /* not alphanumeric, so its numeric */
                    if (strcmp(CK[Index].LiteralValue, CMN_HIGH_VALUES_STR) == 0)
                    {
                        char acValue[61];
                        USHORT usRC=0;

                        usRC = FormatHighValues(ServiceLayout[Index],
                                                acValue,
                                                sizeof(acValue));

                        fprintf( TmpFile,
                                 CK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 DataType,
                                 CK[Index].Operation,
                                 CK[Index].WildCardUsed,
                                 CK[Index].WildCardValue,
                                 CK[Index].LiteralUsed,
                                 acValue);
                    }
                    else
                    if (strcmp(CK[Index].LiteralValue, CMN_LOW_VALUES_STR) == 0)
                    {

                        fprintf( TmpFile,
                                 CK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 DataType,
                                 CK[Index].Operation,
                                 CK[Index].WildCardUsed,
                                 CK[Index].WildCardValue,
                                 CK[Index].LiteralUsed,
                                 "0");
                    }
                    else
                    {
                        fprintf( TmpFile,
                                 CK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 min(ServiceLayout[Index].ItemCLength,
				     ((USHORT) strlen(CK[Index].LiteralValue) + 1)),
                                 DataType,
                                 CK[Index].Operation,
                                 CK[Index].WildCardUsed,
                                 CK[Index].WildCardValue,
                                 CK[Index].LiteralUsed,
                                 CK[Index].LiteralValue);
                    } /* end else not high or low values */




                } /* end of not alphanumeric */


            }
            else
            {
                strncpy( ItemCName,
                         ClientLayout[CK[Index].ClientLayoutIndex].ItemCName,
                         ITEM_NAME_LEN );
                ItemOffset =
                        ClientLayout[CK[Index].ClientLayoutIndex].ItemOffset;
                fprintf( TmpFile,
                     CK_LINE_4,
                     ItemCName,
                     ServiceLayout[Index].ItemCobolName,
                     ItemOffset,
                     ServiceLayout[Index].ItemOffset,
                     min(ServiceLayout[Index].ItemCLength,
                         ClientLayout[CK[Index].ClientLayoutIndex].ItemCLength),
                     DataType,
                     CK[Index].Operation,
                     CK[Index].WildCardUsed,
                     CK[Index].WildCardValue,
                     CK[Index].LiteralUsed,
                     CK[Index].LiteralValue );

            }


            MapDataLength += _COMPARE_KEYS;

         }

         else if ((ServiceLayout[Index].ItemType == 'G') &&
                  (ServiceLayout[Index].ItemOccurs <= 1))
         {
              WriteCK(ClientLayout,
                      ServiceLayout,
                      Index,
                      RPMH,
                      CK);
         }

         Index = ServiceLayout[Index].SiblingIndex;

    } /* end of while */

    return CMN_SUCCESS;

} /* end of WriteCK */

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  WriteRD
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/15/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/15/93      J. Looney                Original Code
**  11/05/93      C. Crampton              Changed param 3 and 4 for RD_LINE_4 from
**                                          %-10.1i to %-10.1u
**  02/11/94      C. Crampton              Changed CK_LINE_4 to use min for length.
**
******************************************************************/

#define RD_LINE_1 "********  R E T U R N  D A T A  ********\n"
#define RD_LINE_2 "**** ClientName                       ServiceName                       FromOffset  ToOffset  Length \n"
#define RD_LINE_3 "**** ----------                       -----------                       ----------  --------  ------ \n"
#define RD_LINE_4 "RD   %-32.32s %-32.32s  %-10.1u  %-10.1u%-10.1i\n"

USHORT WriteRD( _LAYOUT_REC  ClientLayout[],
                _LAYOUT_REC  ServiceLayout[],
                 USHORT      CurIndex,
                _RELATE_RPMH RPMH[],
                _RELATE_RD   RD[])
{
    SHORT Index = 0;

    Index = ServiceLayout[CurIndex].ChildIndex;


    while ( Index != -1 )
    {
         if (( ServiceLayout[Index].ItemType == 'E' ) &&
              ( RD[Index].ClientLayoutIndex > 0 ))
// CSC: 09/23/93              ( RD[Index].ClientLayoutIndex != -1 ))

         {
            /* Get RD info and write line to the file */
            if ( PrintHeader )
            {
                fprintf( TmpFile, BLANK_LINE);
                fprintf( TmpFile, RD_LINE_1 );
                fprintf( TmpFile, RD_LINE_2 );
                fprintf( TmpFile, RD_LINE_3 );
                PrintHeader = FALSE;
            }
            fprintf( TmpFile,
                     RD_LINE_4,
                     ClientLayout[RD[Index].ClientLayoutIndex].ItemCName,
                     ServiceLayout[Index].ItemCobolName,
                     ServiceLayout[Index].ItemOffset,
                     ClientLayout[RD[Index].ClientLayoutIndex].ItemOffset,
                     min(ClientLayout[RD[Index].ClientLayoutIndex].ItemCLength,
                         ServiceLayout[Index].ItemCLength)
                   );

            MapDataLength += _RETURN_DATA;

         }

         else if ((ServiceLayout[Index].ItemType == 'G') &&
                  (ServiceLayout[Index].ItemOccurs <= 1))
         {
              WriteRD(ClientLayout,
                      ServiceLayout,
                      Index,
                      RPMH,
                      RD);
         }

         Index = ServiceLayout[Index].SiblingIndex;

    } /* end of while */

    return CMN_SUCCESS;

} /* end of WriteRD */

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  WriteLK
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/15/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/15/93      J. Looney                Original Code
**
**  07/22/93      J. Looney                Changed code to print a client
**                                         offset of zero if a literal is
**                                         used.
**
**  11/05/93      C. Crampton              Changed LK_LINE_4 parm 3 and 4
**
**  02/11/94      C. Crampton              Changed CK_LINE_4 to use min for length.
**
**  02/14/94      C. Crampton              Changed CK_LINE_4 to use strlen of Literal Value.
**
**  06/09/94      C. Crampton              Changed literal value to be strlen + 1
**
**  06/16/94      C. Crampton              Added logic for high and low values
**
**  07/19/94      C. Crampton              Added logic for Data, Time and Timestamp
**                                           with high and low values.
**
**  08/20/96	  J. Looney				   Added to if stmt to check
**										   for numeric date due to 
**										   FND 3.0 upgrade.
**  11/15/96      CWOODS                   PTF-A - Added check for Usage = 'V' if it
**                                         is a Date Type.
******************************************************************/

#define LK_LINE_1 "********  L O A D  K E Y S  ********\n"
#define LK_LINE_2 "**** ClientName                       ServiceName                       FromOffset  ToOffset  Length    LiteralUsed LiteralValue          LiteralDataType\n"
#define LK_LINE_3 "**** ----------                       -----------                       ----------  --------  ------    ----------- ------------          ---------------\n"
#define LK_LINE_4 "LK   %-32.32s %-32.32s  %-10.1u  %-10.1u%-10.1i%-1.1c           %-61.61s %-11.11s\n"

USHORT WriteLK( _LAYOUT_REC  ClientLayout[],
                _LAYOUT_REC  ServiceLayout[],
                 USHORT      CurIndex,
                _RELATE_RPMH RPMH[],
                _RELATE_LK   LK[])
{
    SHORT Index = 0;

    Index = ServiceLayout[CurIndex].ChildIndex;


    while ( Index != -1 )
    {
         if (( ServiceLayout[Index].ItemType == 'E' ) &&
             (( LK[Index].LiteralUsed == 'Y' ) ||
              ( LK[Index].ClientLayoutIndex > 0 )))
// CSC: 09/23/93              ( LK[Index].ClientLayoutIndex != -1 )))

         {
            char DataType[_DATA_TYPE_LEN];
            char ItemCName[ITEM_NAME_LEN];
            short ItemOffset;

            /* Get the LK Data Type info */
            memset( DataType, '\0', _DATA_TYPE_LEN );

            DecodeDataType(DataType,
                           ServiceLayout,
                           Index );
            /* Get LK info and write line to the file */
            if ( PrintHeader )
            {
                fprintf( TmpFile, BLANK_LINE );
                fprintf( TmpFile, LK_LINE_1 );
                fprintf( TmpFile, LK_LINE_2 );
                fprintf( TmpFile, LK_LINE_3 );
                PrintHeader = FALSE;
            }

            if ( LK[Index].LiteralUsed == 'Y' )
            {

                strncpy( ItemCName, "NULL", ITEM_NAME_LEN );

                /* Set ItemOffset to 0 because this client offset is not
                 * used when a Literal is used.
                 */
                ItemOffset = 0;

                /*
                ** If the data type is a alphnumeric the length is minimum of
                ** the string length + NULL terminator or of the field length
                ** which would case truncation. But if the literal is High or
                ** Low values use the field length because the CSR will fill
                ** the field with high or low values not the literal string.
				**
				** JLOONEY 08/20/96:  Modified the if statement to check for 
				** a numeric DT that we are treating as a string due to the 
				** change in how FND internally stores DT since the FND 3.0
				** upgrade.  We now need to check for the numeric date in 
				** order to properly copy high and low values for a date.
                */
                if ((toupper(ServiceLayout[Index].Format) == 'A') ||
					((toupper(ServiceLayout[Index].Format) == 'N') &&
					 (strcmp(ServiceLayout[Index].Usage, "DT") == 0)))
                {
                    if ((strcmp(LK[Index].LiteralValue, CMN_HIGH_VALUES_STR) == 0)
                       ||
                        (strcmp(LK[Index].LiteralValue,  CMN_LOW_VALUES_STR) == 0) )
                    {
                        /*
                        ** If Usage is DT (Date) change DataType to CSR_DATE
                        ** If Usage is TS (TimeStamp) change DataType to CSR_TMSTMP
                        ** If Usage is TM (Time) change DataType to CSR_TIME
                        ** Otherwise just leave it as CSR_STRING
                        */
                        /* CWOODS 11/15/96:  PTF-A Release - Check for 'V' Usage */
                        if ( (strcmp(ServiceLayout[Index].Usage, "DT") == 0) ||

                            ((ServiceLayout[Index].ElementTypeCode == 'D') &&
                             (!strcmp(ServiceLayout[Index].Usage,"V"))    ) )
                        {
                            strncpy(DataType, "CSR_DATE", _DATA_TYPE_LEN);
                        }
                        else
                        if (strcmp(ServiceLayout[Index].Usage, "TS") == 0)
                        {
                            strncpy(DataType, "CSR_TMSTMP", _DATA_TYPE_LEN);
                        }
                        else
                        if (strcmp(ServiceLayout[Index].Usage, "TM") == 0)
                        {
                            strncpy(DataType, "CSR_TIME", _DATA_TYPE_LEN);
                        }


                        fprintf( TmpFile,
                                 LK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 LK[Index].LiteralUsed,
                                 LK[Index].LiteralValue,
                                 DataType );
                    }
                    else
                    {
                        fprintf( TmpFile,
                                 LK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 min(ServiceLayout[Index].ItemCLength,
				     ((USHORT) strlen(LK[Index].LiteralValue) + 1)),
                                 LK[Index].LiteralUsed,
                                 LK[Index].LiteralValue,
                                 DataType );
                    } /* end else not high or low values */
                } /* end of if format is alphanumeric */
                else
                { /* not alphanumeric, so its numeric */
                    if (strcmp(LK[Index].LiteralValue, CMN_HIGH_VALUES_STR) == 0)
                    {
                        char acValue[61];
                        USHORT usRC=0;

                        usRC = FormatHighValues(ServiceLayout[Index],
                                                acValue,
                                                sizeof(acValue));

                        fprintf( TmpFile,
                                 LK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 LK[Index].LiteralUsed,
                                 acValue,
                                 DataType );
                    }
                    else
                    if (strcmp(LK[Index].LiteralValue, CMN_LOW_VALUES_STR) == 0)
                    {

                        fprintf( TmpFile,
                                 LK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 LK[Index].LiteralUsed,
                                 "0",
                                 DataType );
                    }
                    else
                    {
                        fprintf( TmpFile,
                                 LK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 min(ServiceLayout[Index].ItemCLength,
				     ((USHORT) strlen(LK[Index].LiteralValue) + 1)),
                                 LK[Index].LiteralUsed,
                                 LK[Index].LiteralValue,
                                 DataType );
                    } /* end else not high or low values */




                } /* end of not alphanumeric */


            }
            else  /* Not literal used */
            {
                strncpy( ItemCName,
                         ClientLayout[LK[Index].ClientLayoutIndex].ItemCName,
                         ITEM_NAME_LEN );

                ItemOffset =
                        ClientLayout[LK[Index].ClientLayoutIndex].ItemOffset;
                fprintf( TmpFile,
                     LK_LINE_4,
                     ItemCName,
                     ServiceLayout[Index].ItemCobolName,
                     ItemOffset,
                     ServiceLayout[Index].ItemOffset,
                     min(ServiceLayout[Index].ItemCLength,
                         ClientLayout[LK[Index].ClientLayoutIndex].ItemCLength),
                     LK[Index].LiteralUsed,
                     LK[Index].LiteralValue,
                     DataType );

            }



            MapDataLength += _LOAD_KEYS;

         }

         else if ((ServiceLayout[Index].ItemType == 'G') &&
                  (ServiceLayout[Index].ItemOccurs <= 1))
         {
              WriteLK(ClientLayout,
                      ServiceLayout,
                      Index,
                      RPMH,
                      LK);
         }

         Index = ServiceLayout[Index].SiblingIndex;

    } /* end of while */

    return CMN_SUCCESS;

} /* end of WriteLK */

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  WriteLD
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/15/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/15/93      J. Looney                Original Code
**
**  11/03/93      J. Looney                Corrected the fprintf statment to
**                                         print the local ItemCName not
**                                         the one in the ClientLayout
**                                         structure.
**
**  11/03/93      J. Looney                Corrected the fprintf statment to
**                                         print the local ItemOffset not
**                                         the one in the ClientLayout
**                                         structure.
**
**  11/05/93      C. Crampton              Changed LD_LINE_4 parms 3, 4 from int to unsigned.
**
**  06/09/94      C. Crampton              Changed literal value to be strlen + 1
**
**  06/16/94      C. Crampton              Added logic for High and low values
**
**  07/19/94      C. Crampton              Added logic for Date, Time and Timestamp
**                                          with low and high values.
**
**  08/20/96	  J. Looney				   Added to if stmt to check
**										   for numeric date due to 
**										   FND 3.0 upgrade.
**  11/15/96      CWOODS                   PTF-A - Added check for Usage = 'V' if it
**                                         is a Date Type.
******************************************************************/

#define LD_LINE_1 "********  L O A D  D A T A  ********\n"
#define LD_LINE_2 "**** ClientName                       ServiceName                       FromOffset  ToOffset  Length    LiteralUsed LiteralValue          LiteralDataType\n"
#define LD_LINE_3 "**** ----------                       -----------                       ----------  --------  ------    ----------- ------------          ---------------\n"
#define LD_LINE_4 "LD   %-32.32s %-32.32s  %-10.1u  %-10.1u%-10.1i%-1.1c           %-61.61s %-11.11s\n"

USHORT WriteLD( _LAYOUT_REC  ClientLayout[],
                _LAYOUT_REC  ServiceLayout[],
                 USHORT      CurIndex,
                _RELATE_RPMH RPMH[],
                _RELATE_LD   LD[])
{
    SHORT Index = 0;

    Index = ServiceLayout[CurIndex].ChildIndex;


    while ( Index != -1 )
    {

         if (( ServiceLayout[Index].ItemType == 'E' ) &&
             (( LD[Index].LiteralUsed == 'Y' ) ||
              ( LD[Index].ClientLayoutIndex > 0 )))
// CSC: 09/23/93              ( LD[Index].ClientLayoutIndex != -1 )))

         {
            char DataType[_DATA_TYPE_LEN];
            char ItemCName[ITEM_NAME_LEN];
            short ItemOffset;

            /* Get the LD Data Type info */
            memset( DataType, '\0', _DATA_TYPE_LEN );

            DecodeDataType(DataType,
                           ServiceLayout,
                           Index );
            /* Get LD info and write line to the file */
            if ( PrintHeader )
            {
                fprintf( TmpFile, BLANK_LINE );
                fprintf( TmpFile, LD_LINE_1 );
                fprintf( TmpFile, LD_LINE_2 );
                fprintf( TmpFile, LD_LINE_3 );
                PrintHeader = FALSE;
            }

            if ( LD[Index].LiteralUsed == 'Y' )
            {

                strncpy( ItemCName, "NULL", ITEM_NAME_LEN );

                /* Set ItemOffset to 0 because this client offset is not
                 * used when a Literal is used.
                 */

                ItemOffset = 0;

                /*
                ** If the data type is a alphnumeric the length is minimum of
                ** the string length + NULL terminator or of the field length
                ** which would case truncation. But if the literal is High or
                ** Low values use the field length because the CSR will fill
                ** the field with high or low values not the literal string.
				**
				** JLOONEY 08/20/96:  Modified the if statement to check for 
				** a numeric DT that we are treating as a string due to the 
				** change in how FND internally stores DT since the FND 3.0
				** upgrade.  We now need to check for the numeric date in 
				** order to properly copy high and low values for a date.
                */
                if ((toupper(ServiceLayout[Index].Format) == 'A') ||
					((toupper(ServiceLayout[Index].Format) == 'N') &&
					 (strcmp(ServiceLayout[Index].Usage, "DT") == 0)))
                {
                    if ((strcmp(LD[Index].LiteralValue, CMN_HIGH_VALUES_STR) == 0)
                       ||
                        (strcmp(LD[Index].LiteralValue,  CMN_LOW_VALUES_STR) == 0) )
                    {
                        /*
                        ** If Usage is DT (Date) change DataType to CSR_DATE
                        ** If Usage is TS (TimeStamp) change DataType to CSR_TMSTMP
                        ** If Usage is TM (Time) change DataType to CSR_TIME
                        ** Otherwise just leave it as CSR_STRING
                        */
                        /* CWOODS 11/15/96:  PTF-A Release - Check for 'V' Usage */
                        if ( (strcmp(ServiceLayout[Index].Usage, "DT") == 0) ||

                           ((ServiceLayout[Index].ElementTypeCode == 'D') &&
                             (!strcmp(ServiceLayout[Index].Usage,"V"))    ) )

                        {
                            strncpy(DataType, "CSR_DATE", _DATA_TYPE_LEN);
                        }
                        else
                        if (strcmp(ServiceLayout[Index].Usage, "TS") == 0)
                        {
                            strncpy(DataType, "CSR_TMSTMP", _DATA_TYPE_LEN);
                        }
                        else
                        if (strcmp(ServiceLayout[Index].Usage, "TM") == 0)
                        {
                            strncpy(DataType, "CSR_TIME", _DATA_TYPE_LEN);
                        }

                        fprintf( TmpFile,
                                 LD_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 LD[Index].LiteralUsed,
                                 LD[Index].LiteralValue,
                                 DataType );
                    }
                    else
                    {
                        fprintf( TmpFile,
                                 LD_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 min(ServiceLayout[Index].ItemCLength,
				     ((USHORT) strlen(LD[Index].LiteralValue) + 1)),
                                 LD[Index].LiteralUsed,
                                 LD[Index].LiteralValue,
                                 DataType );
                    } /* end else not high or low values */
                } /* end of if format is alphanumeric */
                else
                { /* not alphanumeric, so its numeric */
                    if (strcmp(LD[Index].LiteralValue, CMN_HIGH_VALUES_STR) == 0)
                    {
                        char acValue[61];
                        USHORT usRC=0;

                        usRC = FormatHighValues(ServiceLayout[Index],
                                                acValue,
                                                sizeof(acValue));

                        fprintf( TmpFile,
                                 LD_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 LD[Index].LiteralUsed,
                                 acValue,
                                 DataType );
                    }
                    else
                    if (strcmp(LD[Index].LiteralValue, CMN_LOW_VALUES_STR) == 0)
                    {

                        fprintf( TmpFile,
                                 LD_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 LD[Index].LiteralUsed,
                                 "0",
                                 DataType );
                    }
                    else
                    {
                        fprintf( TmpFile,
                                 LD_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 min(ServiceLayout[Index].ItemCLength,
				     ((USHORT) strlen(LD[Index].LiteralValue) + 1)),
                                 LD[Index].LiteralUsed,
                                 LD[Index].LiteralValue,
                                 DataType );
                    } /* end else not high or low values */




                } /* end of not alphanumeric */


            }
            else
            {
                strncpy( ItemCName,
                         ClientLayout[LD[Index].ClientLayoutIndex].ItemCName,
                         ITEM_NAME_LEN );
                ItemOffset =
                        ClientLayout[LD[Index].ClientLayoutIndex].ItemOffset;
                fprintf( TmpFile,
                     LD_LINE_4,
                     ItemCName,
                     ServiceLayout[Index].ItemCobolName,
                     ItemOffset,
                     ServiceLayout[Index].ItemOffset,
                     min(ServiceLayout[Index].ItemCLength,
                         ClientLayout[LD[Index].ClientLayoutIndex].ItemCLength),
                     LD[Index].LiteralUsed,
                     LD[Index].LiteralValue,
                     DataType );


            }


            MapDataLength += _LOAD_DATA;

         }

         else if ((ServiceLayout[Index].ItemType == 'G') &&
                  (ServiceLayout[Index].ItemOccurs <= 1))
         {
              WriteLD(ClientLayout,
                      ServiceLayout,
                      Index,
                      RPMH,
                      LD);
         }

         Index = ServiceLayout[Index].SiblingIndex;

    } /* end of while */

    return CMN_SUCCESS;

} /* end of WriteLD */

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  FindRPMH
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/15/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/15/93      J. Looney                Original Code
**
******************************************************************/

USHORT FindRPMH( _LAYOUT_REC  ServiceLayout[],
                 _LAYOUT_REC  ClientLayout[], 
                  USHORT      CurIndex,
                 _RELATE_RPMH RPMH[],
                 _RELATE_CK   CK[],
                 _RELATE_RD   RD[],
                 _RELATE_LK   LK[],
                 _RELATE_LD   LD[])

{
    SHORT Index = 0;

    Index = ServiceLayout[CurIndex].ChildIndex;

    while (Index != -1)
    {
         if ((RPMH != NULL ) &&
             (ServiceLayout[Index].ItemType == 'G') &&
             (ServiceLayout[Index].ItemOccurs > 1))
         {
              WriteRPMHAndThenSome(ServiceLayout,
                                   ClientLayout,
                                   Index,
                                   RPMH,
                                   CK,
                                   RD,
                                   LK,
                                   LD);
         }
         else if (ServiceLayout[Index].ItemType == 'G')
         {
              FindRPMH(ServiceLayout,
                       ClientLayout,
                       Index,
                       RPMH,
                       CK,
                       RD,
                       LK,
                       LD);
         }

         Index = ServiceLayout[Index].SiblingIndex;
    }

    return( CMN_SUCCESS );
}

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  WriteRPMHAndThenSome
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/15/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/15/93      J. Looney                Original Code
**
******************************************************************/
#define RPMH_LINE_1 "********  R E P E A T I N G  M A P  H E A D E R  ********\n"
#define RPMH_LINE_2 "**** ClientName                       ServiceName                       NestedLevel ServiceOccurs ServiceRecLength ServiceOffset ClientOccurs ClientRecLength ClientOffset\n"
#define RPMH_LINE_3 "**** ----------                       -----------                       ----------- ------------- ---------------- ------------- ------------ --------------- ------------\n"
#define RPMH_LINE_4 "RPMH %-32.32s %-32.32s  %-10.1i  %-10.1i    %-10.1i       %-10.1i    %-10.1i   %-10.1i      %-10.1i\n"

USHORT WriteRPMHAndThenSome( _LAYOUT_REC  ServiceLayout[],
                             _LAYOUT_REC  ClientLayout[],
                              USHORT      CurIndex,
                             _RELATE_RPMH RPMH[],
                             _RELATE_CK   CK[], 
                             _RELATE_RD   RD[], 
                             _RELATE_LK   LK[], 
                             _RELATE_LD   LD[])
{
//  USHORT Index = 0;
    char ItemCName[ITEM_NAME_LEN];
    SHORT ItemOccurs;
    SHORT ItemCLength;
    SHORT ItemOffset;

    GlobalNestedLevel++;
    
    /* Get RPMH info and write a line */
    fprintf( TmpFile, BLANK_LINE );
    fprintf( TmpFile, RPMH_LINE_1 );
    fprintf( TmpFile, RPMH_LINE_2 );
    fprintf( TmpFile, RPMH_LINE_3 );

    

    if (( RPMH[CurIndex].ClientLayoutIndex == -1) &&
        ( RPMH[CurIndex].SingleOccurence == 'Y' ))
    {
        strncpy(ItemCName, "NONE", ITEM_NAME_LEN);
        ItemOccurs = 1;
        ItemCLength = 0;
        ItemOffset = 0;

    }
    else
    {
        strncpy( ItemCName,
                 ClientLayout[RPMH[CurIndex].ClientLayoutIndex].ItemCName,
                 ITEM_NAME_LEN );
        ItemOccurs =
                 ClientLayout[RPMH[CurIndex].ClientLayoutIndex].ItemOccurs;
        ItemCLength =
                 ClientLayout[RPMH[CurIndex].ClientLayoutIndex].ItemCLength;
        ItemOffset =
                 ClientLayout[RPMH[CurIndex].ClientLayoutIndex].ItemOffset;
    }

    fprintf( TmpFile, RPMH_LINE_4,
             ItemCName,
             ServiceLayout[CurIndex].ItemCobolName,
             GlobalNestedLevel,
             ServiceLayout[CurIndex].ItemOccurs,
             ServiceLayout[CurIndex].ItemCLength,
             ServiceLayout[CurIndex].ItemOffset,
             ItemOccurs,
             ItemCLength,
             ItemOffset );

    MapDataLength += _REPEATING_MAP_HEADER;

    if ( CK != NULL )
    {
       PrintHeader = TRUE;
       WriteRPCK( ClientLayout,
                  ServiceLayout,
                  CurIndex,
                  RPMH,
                  CK );
    }

    if ( RD != NULL )
    {
       PrintHeader = TRUE;
       WriteRPRD( ClientLayout,
                  ServiceLayout,
                  CurIndex,
                  RPMH,
                  RD );
    }

    if ( LK != NULL )
    {
       PrintHeader = TRUE;
       WriteRPLK( ClientLayout,
                  ServiceLayout,
                  CurIndex,
                  RPMH,
                  LK);
    }

    if ( LD != NULL )
    {
       PrintHeader = TRUE;
       WriteRPLD( ClientLayout,
                  ServiceLayout,
                  CurIndex,
                  RPMH,
                  LD);
    }

    PrintHeader = TRUE;
    FindRPMH(ServiceLayout,
             ClientLayout,
             CurIndex,
             RPMH,
             CK,
             RD,
             LK,
             LD);

    GlobalNestedLevel--;
    
    return( CMN_SUCCESS );
}

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  WriteRPCK
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/16/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/16/93      J. Looney                Original Code
**
**  11/03/93      J. Looney                Added code to determine whether
**                                         or not a Literal is used.  If not,
**                                         the client name = NULL and the
**                                         client offset = 0.
**
**  11/03/93      J. Looney                Corrected the fprintf statment to
**                                         print the local ItemCName not
**                                         the one in the ClientLayout
**                                         structure.
**
**  11/03/93      J. Looney                Corrected the fprintf statment to
**                                         print the local ItemOffset not
**                                         the one in the ClientLayout
**                                         structure.
**  11/05/93      C. Crampton              Changed RPCK_LINE_4 parms 4, 5 from i to u.
**
**  02/14/94      C. Crampton              Changed RPCK_LINE_4 to use min literal value.
**
**  06/09/94      C. Crampton              Changed literal value to be strlen + 1
**
**  06/16/94      C. Crampton              Added logic for high and low values
**
**  0719/94       C. Crampton              Added logic for Date, Timestamp, time with
**                                         Low and High values
******************************************************************/

#define RPCK_LINE_1 "********  R E P E A T I N G  C O M P A R E  K E Y S  ********\n"
#define RPCK_LINE_2 "**** ClientName                       ServiceName                       NestedLevel FromOffset  ToOffset  Length    DataType    Operation   WildCardUsed WildCard              LiteralUsed LiteralValue \n"
#define RPCK_LINE_3 "**** ----------                       -----------                       ----------- ----------  --------  ------    --------    ---------   ------------ --------              ----------- ------------ \n"
#define RPCK_LINE_4 "RPCK %-32.32s %-32.32s  %-10.1i  %-10.1u  %-10.1u%-10.1i%-11.11s %-11.11s %-1.1c            %-21.21s %-1.1c           %-61.61s\n"

USHORT WriteRPCK( _LAYOUT_REC  ClientLayout[],
                  _LAYOUT_REC  ServiceLayout[],
                   USHORT      CurIndex,
                  _RELATE_RPMH RPMH[],
                  _RELATE_CK   CK[])
{
    SHORT Index = 0;

    Index = ServiceLayout[CurIndex].ChildIndex;


    while ( Index != -1 )
    {
         if (( ServiceLayout[Index].ItemType == 'E' ) &&
             (( CK[Index].LiteralUsed == 'Y' ) ||
              ( CK[Index].ClientLayoutIndex > 0 )))
// CSC 09/23/93              ( CK[Index].ClientLayoutIndex != -1 )))
         {
            char DataType[_DATA_TYPE_LEN];

            /* JLL: 11/03/93 ADDED */
            char ItemCName[ITEM_NAME_LEN];
            short ItemOffset;

            /* Get the RPCK Data Type info */
            memset( DataType, '\0', _DATA_TYPE_LEN );

            DecodeDataType(DataType,
                           ServiceLayout,
                           Index );
            /* Get RPCK info and write line to the file */
            if ( PrintHeader )
            {
                fprintf( TmpFile, BLANK_LINE );
                fprintf( TmpFile, RPCK_LINE_1 );
                fprintf( TmpFile, RPCK_LINE_2 );
                fprintf( TmpFile, RPCK_LINE_3 );
                PrintHeader = FALSE;
            }

            /* JLL: 11/03/93 ADDED */
            if ( CK[Index].LiteralUsed == 'Y' )
            {
                strncpy( ItemCName, "NULL", ITEM_NAME_LEN );

                /* Set ItemOffset to 0 because this client offset is not
                 * used when a Literal is used.
                 */

                ItemOffset = 0;

                                /*
                ** If the data type is a alphnumeric the length is minimum of
                ** the string length + NULL terminator or of the field length
                ** which would case truncation. But if the literal is High or
                ** Low values use the field length because the CSR will fill
                ** the field with high or low values not the literal string.
                */
                if (toupper(ServiceLayout[Index].Format) == 'A')
                {
                    if ((strcmp(CK[Index].LiteralValue, CMN_HIGH_VALUES_STR) == 0)
                       ||
                        (strcmp(CK[Index].LiteralValue,  CMN_LOW_VALUES_STR) == 0) )
                    {
                        /*
                        ** If Usage is DT (Date) change DataType to CSR_DATE
                        ** If Usage is TS (TimeStamp) change DataType to CSR_TMSTMP
                        ** If Usage is TM (Time) change DataType to CSR_TIME
                        ** Otherwise just leave it as CSR_STRING
                        */
                        /* CWOODS 11/15/96:  PTF-A Release - Check for 'V' Usage */
                        if ( (strcmp(ServiceLayout[Index].Usage, "DT") == 0) ||

                            ((ServiceLayout[Index].ElementTypeCode == 'D') &&
                             (!strcmp(ServiceLayout[Index].Usage,"V"))    ) )

                        {
                            strncpy(DataType, "CSR_DATE", _DATA_TYPE_LEN);
                        }
                        else
                        if (strcmp(ServiceLayout[Index].Usage, "TS") == 0)
                        {
                            strncpy(DataType, "CSR_TMSTMP", _DATA_TYPE_LEN);
                        }
                        else
                        if (strcmp(ServiceLayout[Index].Usage, "TM") == 0)
                        {
                            strncpy(DataType, "CSR_TIME", _DATA_TYPE_LEN);
                        }


                        fprintf( TmpFile,
                                 RPCK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 DataType,
                                 CK[Index].Operation,
                                 CK[Index].WildCardUsed,
                                 CK[Index].WildCardValue,
                                 CK[Index].LiteralUsed,
                                 CK[Index].LiteralValue );
                    }
                    else
                    {
                        fprintf( TmpFile,
                                 RPCK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 min(ServiceLayout[Index].ItemCLength,
				     ((USHORT) strlen(CK[Index].LiteralValue) + 1)),
                                 DataType,
                                 CK[Index].Operation,
                                 CK[Index].WildCardUsed,
                                 CK[Index].WildCardValue,
                                 CK[Index].LiteralUsed,
                                 CK[Index].LiteralValue);
                    } /* end else not high or low values */
                } /* end of if format is alphanumeric */
                else
                { /* not alphanumeric, so its numeric */
                    if (strcmp(CK[Index].LiteralValue, CMN_HIGH_VALUES_STR) == 0)
                    {
                        char acValue[61];
                        USHORT usRC=0;

                        usRC = FormatHighValues(ServiceLayout[Index],
                                                acValue,
                                                sizeof(acValue));

                        fprintf( TmpFile,
                                 RPCK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 DataType,
                                 CK[Index].Operation,
                                 CK[Index].WildCardUsed,
                                 CK[Index].WildCardValue,
                                 CK[Index].LiteralUsed,
                                 acValue );
                    }
                    else
                    if (strcmp(CK[Index].LiteralValue, CMN_LOW_VALUES_STR) == 0)
                    {

                        fprintf( TmpFile,
                                 RPCK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 DataType,
                                 CK[Index].Operation,
                                 CK[Index].WildCardUsed,
                                 CK[Index].WildCardValue,
                                 CK[Index].LiteralUsed,
                                 "0");
                    }
                    else
                    {
                        fprintf( TmpFile,
                                 RPCK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 min(ServiceLayout[Index].ItemCLength,
				     ((USHORT) strlen(CK[Index].LiteralValue) + 1)),
                                 DataType,
                                 CK[Index].Operation,
                                 CK[Index].WildCardUsed,
                                 CK[Index].WildCardValue,
                                 CK[Index].LiteralUsed,
                                 CK[Index].LiteralValue );
                    } /* end else not high or low values */




                } /* end of not alphanumeric */


            }
            else
            {
                strncpy( ItemCName,
                         ClientLayout[CK[Index].ClientLayoutIndex].ItemCName,
                         ITEM_NAME_LEN );
                ItemOffset =
                        ClientLayout[CK[Index].ClientLayoutIndex].ItemOffset;

                fprintf( TmpFile, RPCK_LINE_4,
                     ItemCName,
                     ServiceLayout[Index].ItemCobolName,
                     GlobalNestedLevel,
                     ItemOffset,
                     ServiceLayout[Index].ItemOffset,
                     min(ServiceLayout[Index].ItemCLength,
                         ClientLayout[CK[Index].ClientLayoutIndex].ItemCLength ),
                     DataType,
                     CK[Index].Operation,
                     CK[Index].WildCardUsed,
                     CK[Index].WildCardValue,
                     CK[Index].LiteralUsed,
                     CK[Index].LiteralValue );
            }



            MapDataLength += _REPEATING_COMPARE_KEYS;

         }

         else if ((ServiceLayout[Index].ItemType == 'G') &&
                  (ServiceLayout[Index].ItemOccurs <= 1))
         {
              WriteRPCK(ClientLayout,
                        ServiceLayout,
                        Index,
                        RPMH,
                        CK);
         }

         Index = ServiceLayout[Index].SiblingIndex;

    } /* end of while */

    return CMN_SUCCESS;

} /* end of WriteRPCK */

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  WriteRPRD
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/16/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/16/93      J. Looney                Original Code
**  11/05/93      C. Crampton              Changed RPRD_LINE_4 parms 4, 5 from i to u.
**
******************************************************************/

#define RPRD_LINE_1 "********  R E P E A T I N G  R E T U R N  D A T A  ********\n"
#define RPRD_LINE_2 "**** ClientName                       ServiceName                       NestedLevel FromOffset  ToOffset  Length \n"
#define RPRD_LINE_3 "**** ----------                       -----------                       ----------- ----------  --------  ------ \n"
#define RPRD_LINE_4 "RPRD %-32.32s %-32.32s  %-10.1i  %-10.1u  %-10.1u%-10.i\n"

USHORT WriteRPRD( _LAYOUT_REC  ClientLayout[],
                  _LAYOUT_REC  ServiceLayout[],
                   USHORT      CurIndex,
                  _RELATE_RPMH RPMH[],
                  _RELATE_RD   RD[])
{
    SHORT Index = 0;

    Index = ServiceLayout[CurIndex].ChildIndex;


    while ( Index != -1 )
    {
         if (( ServiceLayout[Index].ItemType == 'E' ) &&
              ( RD[Index].ClientLayoutIndex > 0 ))
// CSC: 09/23/93             ( RD[Index].ClientLayoutIndex != -1 ))

         {
            /* Get RPRD info and write line to the file */
            if ( PrintHeader )
            {
                fprintf( TmpFile, BLANK_LINE);
                fprintf( TmpFile, RPRD_LINE_1 );
                fprintf( TmpFile, RPRD_LINE_2 );
                fprintf( TmpFile, RPRD_LINE_3 );
                PrintHeader = FALSE;
            }

            fprintf( TmpFile,
                     RPRD_LINE_4,
                     ClientLayout[RD[Index].ClientLayoutIndex].ItemCName,
                     ServiceLayout[Index].ItemCobolName,
                     GlobalNestedLevel,
                     ServiceLayout[Index].ItemOffset,
                     ClientLayout[RD[Index].ClientLayoutIndex].ItemOffset,
                     min(ClientLayout[RD[Index].ClientLayoutIndex].ItemCLength,
                         ServiceLayout[Index].ItemCLength)
                     );

            MapDataLength += _REPEATING_RETURN_DATA;

         }

         else if ((ServiceLayout[Index].ItemType == 'G') &&
                  (ServiceLayout[Index].ItemOccurs <= 1))
         {
              WriteRPRD(ClientLayout,
                        ServiceLayout,
                        Index,
                        RPMH,
                        RD);
         }

         Index = ServiceLayout[Index].SiblingIndex;

    } /* end of while */

    return CMN_SUCCESS;

} /* end of WriteRPRD */

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  WriteRPLK
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/16/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/16/93      J. Looney                Original Code
**
**  11/03/93      J. Looney                Added code to determine whether
**                                         or not a Literal is used.  If not,
**                                         the client name = NULL and the
**                                         client offset = 0.
**
**  11/03/93      J. Looney                Corrected the fprintf statment to
**                                         print the local ItemCName not
**                                         the one in the ClientLayout
**                                         structure.
**
**  11/03/93      J. Looney                Corrected the fprintf statment to
**                                         print the local ItemOffset not
**                                         the one in the ClientLayout
**                                         structure.
**
**  11/05/93      C. Crampton              Changed RPLK_LINE_4 parms 4, 5 from i to u.
**
**  02/14/94      C. Crampton              Changed RPLK_LINE_4 min literal value.
**
**  06/09/94      C. Crampton              Changed literal value to be strlen + 1
**
**  06/16/94      C. Crampton              Added logic for high and low values
**
**  07/19/94      C. Crampton              Added logic for Date, Time and Timestamp
**                                          for high and low values
******************************************************************/

#define RPLK_LINE_1 "********  R E P E A T I N G  L O A D  K E Y S  ********\n"
#define RPLK_LINE_2 "**** ClientName                       ServiceName                       NestedLevel FromOffset  ToOffset  Length    LiteralUsed LiteralValue          LiteralDataType\n"
#define RPLK_LINE_3 "**** ----------                       -----------                       ----------- ----------  --------  ------    ----------- ------------          ---------------\n"
#define RPLK_LINE_4 "RPLK %-32.32s %-32.32s  %-10.1i  %-10.1u  %-10.1u%-10.1i%-1.1c           %-61.61s %-11.11s\n"

USHORT WriteRPLK( _LAYOUT_REC  ClientLayout[],
                  _LAYOUT_REC  ServiceLayout[],
                   USHORT      CurIndex,
                  _RELATE_RPMH RPMH[],
                  _RELATE_LK   LK[])
{
    SHORT Index = 0;

    Index = ServiceLayout[CurIndex].ChildIndex;


    while ( Index != -1 )
    {
         if (( ServiceLayout[Index].ItemType == 'E' ) &&
             (( LK[Index].LiteralUsed == 'Y' ) ||
              ( LK[Index].ClientLayoutIndex > 0 )))
// CSC: 09/23/93              ( LK[Index].ClientLayoutIndex != -1 )))

         {
            char DataType[_DATA_TYPE_LEN];

            /* JLL: 11/03/93 ADDED */
            char ItemCName[ITEM_NAME_LEN];
            short ItemOffset;

            /* Get the RPLK Data Type info */
            memset( DataType, '\0', _DATA_TYPE_LEN );

            DecodeDataType(DataType,
                           ServiceLayout,
                           Index );
            /* Get RPLK info and write line to the file */
            if ( PrintHeader )
            {
                fprintf( TmpFile, BLANK_LINE );
                fprintf( TmpFile, RPLK_LINE_1 );
                fprintf( TmpFile, RPLK_LINE_2 );
                fprintf( TmpFile, RPLK_LINE_3 );
                PrintHeader = FALSE;
            }

            /* JLL: 11/03/93 ADDED */
            if ( LK[Index].LiteralUsed == 'Y' )
            {
                strncpy( ItemCName, "NULL", ITEM_NAME_LEN );

                /* Set ItemOffset to 0 because this client offset is not
                 * used when a Literal is used.
                 */

                ItemOffset = 0;

                /*
                ** If the data type is a alphnumeric the length is minimum of
                ** the string length + NULL terminator or of the field length
                ** which would case truncation. But if the literal is High or
                ** Low values use the field length because the CSR will fill
                ** the field with high or low values not the literal string.
                */
                if (toupper(ServiceLayout[Index].Format) == 'A')
                {
                    if ((strcmp(LK[Index].LiteralValue, CMN_HIGH_VALUES_STR) == 0)
                       ||
                        (strcmp(LK[Index].LiteralValue,  CMN_LOW_VALUES_STR) == 0) )
                    {
                        /*
                        ** If Usage is DT (Date) change DataType to CSR_DATE
                        ** If Usage is TS (TimeStamp) change DataType to CSR_TMSTMP
                        ** If Usage is TM (Time) change DataType to CSR_TIME
                        ** Otherwise just leave it as CSR_STRING
                        */
                        /* CWOODS 11/15/96:  PTF-A Release - Check for 'V' Usage */
                        if ( (strcmp(ServiceLayout[Index].Usage, "DT") == 0) ||

                            ((ServiceLayout[Index].ElementTypeCode == 'D') &&
                             (!strcmp(ServiceLayout[Index].Usage,"V"))    ) )

                        {
                            strncpy(DataType, "CSR_DATE", _DATA_TYPE_LEN);
                        }
                        else
                        if (strcmp(ServiceLayout[Index].Usage, "TS") == 0)
                        {
                            strncpy(DataType, "CSR_TMSTMP", _DATA_TYPE_LEN);
                        }
                        else
                        if (strcmp(ServiceLayout[Index].Usage, "TM") == 0)
                        {
                            strncpy(DataType, "CSR_TIME", _DATA_TYPE_LEN);
                        }


                        fprintf( TmpFile,
                                 RPLK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 LK[Index].LiteralUsed,
                                 LK[Index].LiteralValue,
                                 DataType );
                    }
                    else
                    {
                        fprintf( TmpFile,
                                 RPLK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 min(ServiceLayout[Index].ItemCLength,
				     ((USHORT) strlen(LK[Index].LiteralValue) + 1)),
                                 LK[Index].LiteralUsed,
                                 LK[Index].LiteralValue,
                                 DataType );
                    } /* end else not high or low values */
                } /* end of if format is alphanumeric */
                else
                { /* not alphanumeric, so its numeric */
                    if (strcmp(LK[Index].LiteralValue, CMN_HIGH_VALUES_STR) == 0)
                    {
                        char acValue[61];
                        USHORT usRC=0;

                        usRC = FormatHighValues(ServiceLayout[Index],
                                                acValue,
                                                sizeof(acValue));

                        fprintf( TmpFile,
                                 RPLK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 LK[Index].LiteralUsed,
                                 acValue,
                                 DataType );
                    }
                    else
                    if (strcmp(LK[Index].LiteralValue, CMN_LOW_VALUES_STR) == 0)
                    {

                        fprintf( TmpFile,
                                 RPLK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 LK[Index].LiteralUsed,
                                 "0",
                                 DataType );
                    }
                    else
                    {
                        fprintf( TmpFile,
                                 RPLK_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 min(ServiceLayout[Index].ItemCLength,
				     ((USHORT) strlen(LK[Index].LiteralValue) + 1)),
                                 LK[Index].LiteralUsed,
                                 LK[Index].LiteralValue,
                                 DataType );
                    } /* end else not high or low values */




                } /* end of not alphanumeric */


            }
            else
            {
                strncpy( ItemCName,
                         ClientLayout[LK[Index].ClientLayoutIndex].ItemCName,
                         ITEM_NAME_LEN );
                ItemOffset =
                        ClientLayout[LK[Index].ClientLayoutIndex].ItemOffset;

                fprintf( TmpFile,
                     RPLK_LINE_4,
                     ItemCName,
                     ServiceLayout[Index].ItemCobolName,
                     GlobalNestedLevel,
                     ItemOffset,
                     ServiceLayout[Index].ItemOffset,
                     min(ServiceLayout[Index].ItemCLength,
                         ClientLayout[LK[Index].ClientLayoutIndex].ItemCLength),
                     LK[Index].LiteralUsed,
                     LK[Index].LiteralValue,
                     DataType );

            }


            MapDataLength += _REPEATING_LOAD_KEYS;

         }

         else if ((ServiceLayout[Index].ItemType == 'G') &&
                  (ServiceLayout[Index].ItemOccurs <= 1))
         {
              WriteRPLK(ClientLayout,
                        ServiceLayout,
                        Index,
                        RPMH,
                        LK);
         }

         Index = ServiceLayout[Index].SiblingIndex;

    } /* end of while */

    return CMN_SUCCESS;

} /* end of WriteRPLK */

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  WriteRPLD
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/16/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/16/93      J. Looney                Original Code
**
**  11/03/93      J. Looney                Added code to determine whether
**                                         or not a Literal is used.  If not,
**                                         the client name = NULL and the
**                                         client offset = 0.
**  11/03/93      J. Looney                Corrected the fprintf statment to
**                                         print the local ItemCName not
**                                         the one in the ClientLayout
**                                         structure.
**
**  11/03/93      J. Looney                Corrected the fprintf statment to
**                                         print the local ItemOffset not
**                                         the one in the ClientLayout
**                                         structure.
**
**  11/05/93      C. Crampton              Changed RPLD_LINE_4 parms 4, 5 from i to u.
**
**  02/14/94      C. Crampton              Changed RPLD_LINE_4 to min literal value.
**
**  06/09/94      C. Crampton              Changed literal value to be strlen + 1
**
**  06/16/94      C. Crampton              Added high and low values logic
**
**  07/19/94      C. Crampton              Added logic for Date, Time and Timestamp
**                                          for low and high values
*****************************************************************/

#define RPLD_LINE_1 "********  R E P E A T I N G  L O A D  D A T A  ********\n"
#define RPLD_LINE_2 "**** ClientName                       ServiceName                       NestedLevel FromOffset  ToOffset  Length    LiteralUsed LiteralValue          LiteralDataType\n"
#define RPLD_LINE_3 "**** ----------                       -----------                       ----------- ----------  --------  ------    ----------- ------------          ---------------\n"
#define RPLD_LINE_4 "RPLD %-32.32s %-32.32s  %-10.1i  %-10.1u  %-10.1u%-10.1i%-1.1c           %-61.61s %-11.11s\n"

USHORT WriteRPLD( _LAYOUT_REC  ClientLayout[],
                  _LAYOUT_REC  ServiceLayout[],
                   USHORT      CurIndex,
                  _RELATE_RPMH RPMH[],
                  _RELATE_LD   LD[])
{
    SHORT Index = 0;

    Index = ServiceLayout[CurIndex].ChildIndex;


    while ( Index != -1 )
    {

         if (( ServiceLayout[Index].ItemType == 'E' ) &&
             (( LD[Index].LiteralUsed == 'Y' ) ||
              ( LD[Index].ClientLayoutIndex > 0 )))
// CSC: 09/23/93              ( LD[Index].ClientLayoutIndex != -1 )))

         {
            char DataType[_DATA_TYPE_LEN];

            /* JLL: 11/03/93 ADDED */
            char ItemCName[ITEM_NAME_LEN];
            short ItemOffset;

            /* Get the RPLD Data Type info */
            memset( DataType, '\0', _DATA_TYPE_LEN );

            DecodeDataType(DataType,
                           ServiceLayout,
                           Index );

            /* Get RPLD info and write line to the file */
            if ( PrintHeader )
            {
                fprintf( TmpFile, BLANK_LINE );
                fprintf( TmpFile, RPLD_LINE_1 );
                fprintf( TmpFile, RPLD_LINE_2 );
                fprintf( TmpFile, RPLD_LINE_3 );
                PrintHeader = FALSE;
            }

            /* JLL: 11/03/93 ADDED */
            if ( LD[Index].LiteralUsed == 'Y' )
            {
                strncpy( ItemCName, "NULL", ITEM_NAME_LEN );

                /* Set ItemOffset to 0 because this client offset is not
                 * used when a Literal is used.
                 */

                ItemOffset = 0;

                /*
                ** If the data type is a alphnumeric the length is minimum of
                ** the string length + NULL terminator or of the field length
                ** which would case truncation. But if the literal is High or
                ** Low values use the field length because the CSR will fill
                ** the field with high or low values not the literal string.
                */
                if (toupper(ServiceLayout[Index].Format) == 'A')
                {
                    if ((strcmp(LD[Index].LiteralValue, CMN_HIGH_VALUES_STR) == 0)
                       ||
                        (strcmp(LD[Index].LiteralValue,  CMN_LOW_VALUES_STR) == 0) )
                    {
                        /*
                        ** If Usage is DT (Date) change DataType to CSR_DATE
                        ** If Usage is TS (TimeStamp) change DataType to CSR_TMSTMP
                        ** If Usage is TM (Time) change DataType to CSR_TIME
                        ** Otherwise just leave it as CSR_STRING
                        */
                        /* CWOODS 11/15/96:  PTF-A Release - Check for 'V' Usage */
                        if ( (strcmp(ServiceLayout[Index].Usage, "DT") == 0) ||

                            ((ServiceLayout[Index].ElementTypeCode == 'D') &&
                             (!strcmp(ServiceLayout[Index].Usage,"V"))    ) )

                        {
                            strncpy(DataType, "CSR_DATE", _DATA_TYPE_LEN);
                        }
                        else
                        if (strcmp(ServiceLayout[Index].Usage, "TS") == 0)
                        {
                            strncpy(DataType, "CSR_TMSTMP", _DATA_TYPE_LEN);
                        }
                        else
                        if (strcmp(ServiceLayout[Index].Usage, "TM") == 0)
                        {
                            strncpy(DataType, "CSR_TIME", _DATA_TYPE_LEN);
                        }


                        fprintf( TmpFile,
                                 RPLD_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 LD[Index].LiteralUsed,
                                 LD[Index].LiteralValue,
                                 DataType );
                    }
                    else
                    {
                        fprintf( TmpFile,
                                 RPLD_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 min(ServiceLayout[Index].ItemCLength,
				     ((USHORT) strlen(LD[Index].LiteralValue) + 1)),
                                 LD[Index].LiteralUsed,
                                 LD[Index].LiteralValue,
                                 DataType );
                    } /* end else not high or low values */
                } /* end of if format is alphanumeric */
                else
                { /* not alphanumeric, so its numeric */
                    if (strcmp(LD[Index].LiteralValue, CMN_HIGH_VALUES_STR) == 0)
                    {
                        char acValue[61];
                        USHORT usRC=0;

                        usRC = FormatHighValues(ServiceLayout[Index],
                                                acValue,
                                                sizeof(acValue));

                        fprintf( TmpFile,
                                 RPLD_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 LD[Index].LiteralUsed,
                                 acValue,
                                 DataType );
                    }
                    else
                    if (strcmp(LD[Index].LiteralValue, CMN_LOW_VALUES_STR) == 0)
                    {

                        fprintf( TmpFile,
                                 RPLD_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 ServiceLayout[Index].ItemCLength,
                                 LD[Index].LiteralUsed,
                                 "0",
                                 DataType );
                    }
                    else
                    {
                        fprintf( TmpFile,
                                 RPLD_LINE_4,
                                 ItemCName,
                                 ServiceLayout[Index].ItemCobolName,
                                 GlobalNestedLevel,
                                 ItemOffset,
                                 ServiceLayout[Index].ItemOffset,
                                 min(ServiceLayout[Index].ItemCLength,
				     ((USHORT) strlen(LD[Index].LiteralValue) + 1)),
                                 LD[Index].LiteralUsed,
                                 LD[Index].LiteralValue,
                                 DataType );
                    } /* end else not high or low values */


                } /* end of not alphanumeric */

            }
            else
            {
                strncpy( ItemCName,
                         ClientLayout[LD[Index].ClientLayoutIndex].ItemCName,
                         ITEM_NAME_LEN );
                ItemOffset =
                        ClientLayout[LD[Index].ClientLayoutIndex].ItemOffset;

                fprintf( TmpFile,
                     RPLD_LINE_4,
                     ItemCName,
                     ServiceLayout[Index].ItemCobolName,
                     GlobalNestedLevel,
                     ItemOffset,
                     ServiceLayout[Index].ItemOffset,
                     min( ServiceLayout[Index].ItemCLength,
                          ClientLayout[LD[Index].ClientLayoutIndex].ItemCLength),
                     LD[Index].LiteralUsed,
                     LD[Index].LiteralValue,
                     DataType );
            }



            MapDataLength += _REPEATING_LOAD_DATA;

         }

         else if ((ServiceLayout[Index].ItemType == 'G') &&
                  (ServiceLayout[Index].ItemOccurs <= 1))
         {
              WriteRPLD(ClientLayout,
                        ServiceLayout,
                        Index,
                        RPMH,
                        LD);
         }

         Index = ServiceLayout[Index].SiblingIndex;

    } /* end of while */

    return CMN_SUCCESS;

} /* end of WriteRPLD */


/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  WriteSDM
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/09/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/09/93      J. Looney                Original Code
**
******************************************************************/

#define SDM_LINE_1 "********  S E A R C H  A N D  D E S T R O Y  ********\n"
#define SDM_LINE_2 "**** ReqId\n"
#define SDM_LINE_3 "**** -----\n"
#define SDM_LINE_4 "SDM  %-9.9s\n"
USHORT WriteSDM( CMN_ARCH_PARM_TYPES )
{
    SHORT i;


    /* Write the standard header to the file */
    fprintf( TmpFile, BLANK_LINE );
    fprintf( TmpFile, SDM_LINE_1 );
    fprintf( TmpFile, SDM_LINE_2 );
    fprintf( TmpFile, SDM_LINE_3 );

    for ( i = 0; i < pBFCD->pCSRMapBFCD->ClientInfo.NumSearchDestroy; i++ )
    {
        fprintf( TmpFile, SDM_LINE_4,
                 pBFCD->pCSRMapBFCD->ClientInfo.SearchDestroyTable[i].ReqId );
        MapDataLength += _SEARCH_DESTROY_MAP;
    }


    return(CMN_SUCCESS);

} /* end of WriteSDM */


/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  WriteRMH
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/10/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/10/93      J. Looney                Original Code
**  09/13/93      C. Crampton              Initialize FileNm before CmnStrCat.
******************************************************************/

#define RMH_LINE_1 "********  R E Q U E S T  M A P  H E A D E R  ********\n"
#define RMH_LINE_2 "**** ReqId     ReqType     ReqDataLength MapDataLength    Version #\n"
#define RMH_LINE_3 "**** -----     -------     ------------- ------------- ---------------\n"
#define RMH_LINE_4 "RMH  %-9.9s %-11.11s %-13.1i %-13.1i %-#15.0f\n"

USHORT WriteRMH( CMN_ARCH_PARM_TYPES )
{
    USHORT ReturnCode;
    CHAR ReqType[_REQ_TYPE_LEN];
    _FND_ERROR_BLOCK  FndGenErrorBlock;
    USHORT SelectedButton;
    USHORT FndGenRC;

    MapDataLength += _REQUEST_MAP_HEADER;

    strcpy(FileNm, ""); /* CSC: 09/13/93 ADDED */

    /* Obtain file name */
    ReturnCode = CmnStrCat( CMN_ARCH_PARMS,
                            FileNm,
                            _CSR_MAP_FILENAME_LEN,
                            5,
                            BFCD_pCSRMapBFCD->CsrMapGenPath,
                            "\\",
                            BFCD_pCSRMapBFCD->ClientInfo.ReqId,
                            ".",
                            CSR_MAP_GEN_FILE_EXT );

    /* Open the file. */
    if (( Stream = fopen( FileNm,"w" )) == NULL )
    {
       FndGenRC = FndMsgBoxDisplayText("Unable to write to map file.\n"
                                       "Make sure you have proper rights for this file.\n\n"
                                       "Generation of map failed.",
                                       NULL,
                                       CBI_hwnd,
                                       FND_MSGBOX_OK,
                                       FND_MSGBOX_ERROR,
                                       FND_MSGBOX_IDOK,
                                       NULL,
                                       &SelectedButton,
                                       &FndGenErrorBlock);


       return( CMN_FAIL );
    }

    if ( strcmp( BFCD_pCSRMapBFCD->ClientInfo.ReqType, "1" ) == 0 )
    {
        strncpy( ReqType, "INQUIRY", _REQ_TYPE_LEN );
    }
    else if ( strcmp( BFCD_pCSRMapBFCD->ClientInfo.ReqType, "2" ) == 0 )
    {
        strncpy( ReqType, "LUW", _REQ_TYPE_LEN );
    }

    /* Write the standard header to the file */
    fprintf( Stream, RMH_LINE_1 );
    fprintf( Stream, RMH_LINE_2 );
    fprintf( Stream, RMH_LINE_3 );
    fprintf( Stream, RMH_LINE_4,
             BFCD_pCSRMapBFCD->ClientInfo.ReqId,
             ReqType,
             BFCD_pCSRMapBFCD->ClientInfo.pReposClientLayoutTable[0].ItemCLength,
             MapDataLength,
             BFCD_pCSRMapBFCD->ClientInfo.Version );

    return( CMN_SUCCESS );

} /* end of WriteRMH */

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  DecodeDataType
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/14/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/14/93      J. Looney                Original Code
**
******************************************************************/
USHORT DecodeDataType( CHAR *DataType,
                       _LAYOUT_REC ServiceLayout[],
                       USHORT Index )
{

   if ( ServiceLayout[Index].DataType == CSR_STRING )
   {
        sscanf( "CSR_STRING", "%s", DataType );
   }
   else if ( ServiceLayout[Index].DataType == CSR_SHORT )
   {
        sscanf( "CSR_SHORT", "%s", DataType );
   }
   else if ( ServiceLayout[Index].DataType == CSR_LONG )
   {
        sscanf( "CSR_LONG", "%s", DataType );
   }
   else if ( ServiceLayout[Index].DataType == CSR_DOUBLE )
   {
        sscanf( "CSR_DOUBLE", "%s", DataType );
   }
   else if ( ServiceLayout[Index].DataType == CSR_LONG_DBL )
   {
        sscanf( "CSR_LONG_DBL", "%s", DataType );
   }
   else if ( ServiceLayout[Index].DataType == CSR_ULONG )
   {
        sscanf( "CSR_ULONG", "%s", DataType );
   }
   else if ( ServiceLayout[Index].DataType == CSR_FLOAT )
   {
        sscanf( "CSR_FLOAT", "%s", DataType );
   }
   else if ( ServiceLayout[Index].DataType == CSR_UCHAR )
   {
        sscanf( "CSR_UCHAR", "%s", DataType );
   }
   else if ( ServiceLayout[Index].DataType == CSR_USHORT )
   {
        sscanf( "CSR_USHORT", "%s", DataType );
   }
   else if ( ServiceLayout[Index].DataType == CSR_BYTE )
   {
        sscanf( "CSR_BYTE", "%s", DataType );
   }
   return( CMN_SUCCESS );
}


/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  FormatHighValues
**
**  DESCRIPTION   :  This function formats a string to match a variables COBOL
**                   high values format.
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  06/14/93
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**  06/15/94      C Crampton                Original Code
**
******************************************************************/
USHORT FormatHighValues(_LAYOUT_REC ServiceLayout,
                        CHAR *pszFormatString,
                        SHORT sFormatStringLen)
{
SHORT sIx;

/*
** Make sure only numeric data types are formated
*/

if (ServiceLayout.ElementTypeCode != 'N' &&
    ServiceLayout.ElementTypeCode != 'n')
    {
        return(CMN_FAIL);
    }
/*
** Clear out the string
*/
memset(pszFormatString, 0, sFormatStringLen);


for(sIx=0; sIx < (ServiceLayout.ItemLength - ServiceLayout.Precision); sIx++)
{
    strcat(pszFormatString, CMN_HIGH_VALUE_DIGIT);
}

/*
** If the precision is greater than its not an integer
*/

if (ServiceLayout.Precision > 0)
{
    strcat(pszFormatString, ".");

    for(sIx=0; sIx < ServiceLayout.Precision; sIx++)
    {
        strcat(pszFormatString, CMN_HIGH_VALUE_DIGIT);
    }

} /* End of if not an integer */

return( CMN_SUCCESS );

} /* End of function FormatHighValues */

/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**  FUNCTION         : LogError
**
**  DESCRIPTION      : This function opens the Error file for mass
**                     generation.
**
**
**  OUTPUTS          : Return Code - SHORT (Valid: CMN_SUCCESS or CMN_FAIL).
**
**  CALLED FUNCTIONS : NONE
**
**  AUTHOR           : M. Conner
**
**  DATE CREATED     : 11/21/96
**
**  REVISION HISTORY :
**
**  DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**  --------  -----------  -------  -------------------------------------
**  11/21/96  mconner               Created
**
***************************************************************************/
USHORT LogError( char * psMsg )
{
    int rc;

    rc = fprintf(fpError, "%s\n", psMsg);
    if (rc < 0 ) return CMN_FAIL;

 
    return CMN_SUCCESS;
}/*End of LogError*/


/***************************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION         : AZCS01MegaScrollPush
**
**  DESCRIPTION      : This function will create and add nodes to the top
**                     of a megascroll stack.  The stack is used to keep
**                     track of keys when megascrolling down so the window
**                     can megascroll up by using the keys stored on top
**                     of the stack.  This stack building function can be
**                     used by any program because it also allocates a block
**                     of memory for the keys area.  The stack structure
**                     uses a void pointer to the allocated key area.  When
**                     a programmer needs to query or copy the keys from
**                     the top of the stack, the programmer should typecast
**                     the pointer to the key area with the typedef of the
**                     key structure that was passed to this function.
**
**                     Companion functions to this function are
**                     AZCS01MegaScrollPop and AZCS01MegaScrollPopAll.
**
**  INPUTS           : _AZCS01MEGASCROLL **pMegaStruct - pointer to a pointer to
**                                     the megascroll structure
**
**                     VOID *pNewKeys - void pointer to a keys structure
**                                      allocated in the top node of the
**                                      stack
**
**                     size_t KeySize - size if the key structure.  size_t
**                                      typdef is used by malloc and memcpy
**
**                     CMN_ARCH_PARM_TYPES - standard CSS parameters
**
**  OUTPUTS          : Return Code - SHORT (Valid: CMN_SUCCESS or CMN_FAIL).
**
**                     _AZCS01MEGASCROLL **pMegaStruct - pointer to new address
**                                     for the megascroll structure pointer
**
**  CALLED FUNCTIONS : NONE
**
**  AUTHOR           : SolutionWorks/Andersen Consulting
**
**  DATE CREATED     : 03/25/99
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    03/25/99  NEYDE                 Original code.
**
***************************************************************************/

SHORT AZCS01MegaScrollPush(  _AZCS01MEGASCROLL **pMegaStruct,
                           VOID *pNewKeys,
                           size_t KeySize,
                           CMN_ARCH_PARM_TYPES)
{
    _AZCS01MEGASCROLL  *pLocalOldTopNode;
    _AZCS01MEGASCROLL  *pLocalNewTopNode;
    USHORT FndGenRC = 0;
    _FND_ERROR_BLOCK FndGenErrorBlock;

    /* Set a local pointer to the pointer to pointer pMegaStruct */
    pLocalOldTopNode =  (_AZCS01MEGASCROLL * ) *pMegaStruct ;

    /* if the stack pointer is NULL, the stack is empty,
       so start a new stack */
    if (pLocalOldTopNode == NULL)
    {
        /* allocate memory for the stack structure */
        pLocalNewTopNode = (_AZCS01MEGASCROLL * ) malloc(sizeof(_AZCS01MEGASCROLL));

        /* if there is a problem allocating memory,
           call error handler and log error */
        if( pLocalNewTopNode == NULL)
        {
            CmnErrHandler(CMN_ARCH_PARMS_INCOMING_LN_FL);

            FndWindowDestroy(CBI_hwnd,
                             &FndGenErrorBlock);

            return CMN_FAIL;
        }

        /* set the block of memory to zero */
        memset(pLocalNewTopNode, 0, sizeof(_AZCS01MEGASCROLL));

        /* allocate space for the key area */
        pLocalNewTopNode->pKeys = (VOID *) malloc(KeySize);

        /* if there is a problem allocating memory,
           call error handler and log error */
        if( pLocalNewTopNode->pKeys == NULL)
        {
            CmnErrHandler(CMN_ARCH_PARMS_INCOMING_LN_FL);

            FndWindowDestroy(CBI_hwnd,
                             &FndGenErrorBlock);

            return CMN_FAIL;
        }

        /* set the block of memory to zero */
        memset(pLocalNewTopNode->pKeys, 0, KeySize);

        /* copy the keys to the allocated block of memory */
        memcpy(pLocalNewTopNode->pKeys, pNewKeys, KeySize);

        /* set the pointer to the pointer to the mega srcoll structure
           equal to the local pointer */
        *pMegaStruct = pLocalNewTopNode;

    }
    /* if the stack pointer is not NULL, then add a new node to the
       top of the stack */
    else
    {

        /* allocate memory for the stack structure */
        pLocalNewTopNode = (_AZCS01MEGASCROLL * )  malloc(sizeof(_AZCS01MEGASCROLL));

        /* if there is a problem allocating memory,
           call error handler and log error */
        if( pLocalNewTopNode == NULL)
        {
            CmnErrHandler(CMN_ARCH_PARMS_INCOMING_LN_FL);

            FndWindowDestroy(CBI_hwnd,
                             &FndGenErrorBlock);

            return CMN_FAIL;
        }

        /* set the block of memory to zero */
        memset(pLocalNewTopNode, 0, sizeof(_AZCS01MEGASCROLL));

        /* allocate space for the key area */
        pLocalNewTopNode->pKeys = (void *) malloc(KeySize);

        /* if there is a problem allocating memory,
           call error handler and log error */
        if( pLocalNewTopNode->pKeys == NULL)
        {
            CmnErrHandler(CMN_ARCH_PARMS_INCOMING_LN_FL);

            FndWindowDestroy(CBI_hwnd,
                             &FndGenErrorBlock);

            return CMN_FAIL;
        }

        /* set the block of memory to zero */
        memset(pLocalNewTopNode->pKeys, 0, KeySize);

        /* copy the keys to the allocated block of memory */
        memcpy(pLocalNewTopNode->pKeys, pNewKeys, KeySize);

        /* move the new node to the top of the stack */
        pLocalNewTopNode->pNext = pLocalOldTopNode;

        /* set the pointer to the pointer to the mega srcoll structure
           equal to the local pointer */
        *pMegaStruct = pLocalNewTopNode;
    }

    return CMN_SUCCESS;

} /* End of AZCS01MegaScrollPush function  */

/***************************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION         : AZCS01MegaScrollPop
**
**  DESCRIPTION      : This function will free ("pop") the top node of the
**                     megascroll stack.  The stack is used to keep
**                     track of keys when megascrolling down so the window
**                     can megascroll up by using the keys stored on top
**                     of the stack.  This stack popping function can be
**                     used by any program.
**
**                     Companion functions to this function are
**                     AZCS01MegaScrollPush and AZCS01MegaScrollPopAll.
**
**  INPUTS           : _AZCS01MEGASCROLL **pMegaStruct - pointer to a pointer to
**                                     the megascroll structure
**
**                     CMN_ARCH_PARM_TYPES - standard CSS parameters
**
**  OUTPUTS          : Return Code - SHORT (Valid: CMN_SUCCESS or CMN_FAIL).
**
**                     _AZCS01MEGASCROLL **pMegaStruct - pointer to new address
**                                     for the megascroll structure pointer
**
**  CALLED FUNCTIONS : NONE
**
**  AUTHOR           : SolutionWorks/Andersen Consulting
**
**  DATE CREATED     : 03/25/99
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    03/25/99  NEYDE                 Original code.
**
***************************************************************************/

SHORT AZCS01MegaScrollPop ( _AZCS01MEGASCROLL **pMegaStruct,
                          CMN_ARCH_PARM_TYPES)
{
    _AZCS01MEGASCROLL  *pLocalOldTopNode;
    _AZCS01MEGASCROLL  *pLocalNewTopNode;

    /* Set a local pointer to the pointer to pointer pMegaStruct */
    pLocalOldTopNode =  (_AZCS01MEGASCROLL * ) *pMegaStruct;

	/* This function shouldn't have been called if a top node doesn't exist */
    if( pLocalOldTopNode == NULL)
    {
        return CMN_FAIL;

    }
    /* Set a local pointer to the pointer to the next node */
    pLocalNewTopNode = pLocalOldTopNode->pNext;

    /* if keys are not empty, free the key area */
    if(pLocalOldTopNode->pKeys != NULL)
    {
        /* free the block allocated to the keys */
        free(pLocalOldTopNode->pKeys);
    }
    /* free the allocated bock to the old top node */
    free(pLocalOldTopNode);

    /* set the pointer to the pointer to the mega srcoll structure
       equal to the local pointer */
    *pMegaStruct = pLocalNewTopNode;

    return CMN_SUCCESS;

} /* End of AZCS01MegaScrollPop function  */

/***************************************************************************
**
**               Customer Service System Application Function
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  DESCRIPTION      : This function will free ("pop") all the nodes of the
**                     megascroll stack by calling AZCS01MegaScrollPop until
**                     the stack is empty (NULL).  The stack is used to keep
**                     track of keys when megascrolling down so the window
**                     can megascroll up by using the keys stored on top
**                     of the stack.  This stack popping function can be
**                     used by any program.
**
**                     Companion functions to this function are
**                     AZCS01MegaScrollPush and AZCS01MegaScrollPop.
**
**  INPUTS           : _AZCS01MEGASCROLL **pMegaStruct - pointer to a pointer to
**                                     the megascroll structure
**
**                     CMN_ARCH_PARM_TYPES - standard CSS parameters
**
**  OUTPUTS          : Return Code - SHORT (Valid: CMN_SUCCESS or CMN_FAIL).
**
**                     _AZCS01MEGASCROLL **pMegaStruct - pointer to new address
**                                     for the megascroll structure pointer
**
**  CALLED FUNCTIONS : AZCS01MegaScrollPop
**
**  AUTHOR           : SolutionWorks/Andersen Consulting
**
**  DATE CREATED     : 03/25/99
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    03/25/99  NEYDE                 Original code.
**
***************************************************************************/

SHORT AZCS01MegaScrollPopAll ( _AZCS01MEGASCROLL **pMegaStruct,
                             CMN_ARCH_PARM_TYPES)
{
    _AZCS01MEGASCROLL  *pLocalTopNode;

    /* Set a local pointer to the pointer to pointer pMegaStruct */
    pLocalTopNode =  (_AZCS01MEGASCROLL * ) *pMegaStruct;

    /* while top of stack is not NULL, call AZCS01MegaScrollPop to
       pop off the top of the stack until the stack is empty (NULL)*/
    while (pLocalTopNode != NULL)
    {
        AZCS01MegaScrollPop (&pLocalTopNode,
                          CMN_ARCH_PARMS);
    }

    /* set the pointer to the pointer to the mega srcoll structure
       equal to NULL since all nodes should have been removed*/
    *pMegaStruct = NULL;

    return CMN_SUCCESS;

} /* End of AZCS01MegaScrollPopAll function  */
