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
**  01/10/96	CWOODS		       Modify GenerateMap to remove
**				       temp file created.
******************************************************************/

/**************************************************************************
**
**   OS/2 #defines
**
***************************************************************************/
#define  INCL_DOS
#include <os2.h>

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
#include <kglzk000.h>

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
**   CSR Map Generator #includes
**
***************************************************************************/
#include "csrcmn.h"
#include "mapgen.h"
#include "azcs01b.gnb"
#include "AZCS003.GNH"

/**************************************************************************
**
**   AZCSM010.C Function Prototypes
**
***************************************************************************/
USHORT FormatHighValues(_LAYOUT_REC ServiceLayout,
                        CHAR *pszFormatString,
                        SHORT sFormatStringLen);

/**************************************************************************
**
**   AZCSM010.C Variable Declarations
**
***************************************************************************/
CHAR FileNm[_CSR_MAP_FILENAME_LEN];
FILE *Stream, *TmpFile;
SHORT MapDataLength;

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
**  01/10/96	  CWOODS		   Add Remove Command to
**					   delete temp file created.
******************************************************************/

USHORT GenerateMap( CMN_ARCH_PARM_TYPES )
{
    CHAR CopyCommand[_COPY_COMMAND_LEN];
    CHAR RmCommand[_RM_COMMAND_LEN];
    SHORT NumberClosed;
    SHORT i;
    SHORT j;
    USHORT FndGenRC;
    CHAR TmpFileNm[_CSR_MAP_FILENAME_LEN] = "";
    _FND_ERROR_BLOCK  FndGenErrorBlock;
    USHORT SelectedButton;


    /* Initialize CopyCommand */
    memset(CopyCommand, '\0', _COPY_COMMAND_LEN);

    MapDataLength = 0;

    sprintf(TmpFileNm, "%s\\%s", BFCD_CSRMapBFCD->CsrMapGenPath, MAP_TMP_FILE);

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


    for ( i = 0; i < BFCD_CSRMapBFCD->NumServices; i++ )
    {
      /* Check if Service is deleted */
      if ( BFCD_CSRMapBFCD->ServiceInfoTable[i].DeleteFlag )
      {
         /* if deleted, continue onto the next service */
         continue;
      }

      if ( strcmp( BFCD_CSRMapBFCD->ServiceInfoTable[i].ServiceType,
                   LT_Primary ) == 0 )
      {

         FndGenRC = GenerateService ( BFCD_CSRMapBFCD->ServiceInfoTable[i].pReposServiceLayoutTable,
                                      BFCD_CSRMapBFCD->ClientInfo.pReposClientLayoutTable,
                                      BFCD_CSRMapBFCD->ServiceInfoTable[i].pRepeatingMaps,
                                      BFCD_CSRMapBFCD->ServiceInfoTable[i].pCompareKeys,
                                      BFCD_CSRMapBFCD->ServiceInfoTable[i].pReturnData,
                                      BFCD_CSRMapBFCD->ServiceInfoTable[i].pLoadKeys,
                                      BFCD_CSRMapBFCD->ServiceInfoTable[i].pLoadData,
                                      i,
                                      BFCD_CSRMapBFCD->ServiceInfoTable );

         if (( strcmp( BFCD_CSRMapBFCD->ServiceInfoTable[i].AlternateService,
               "NULL" ) != 0 ))
         {
            /* Search for Alternate Service */
            for ( j = 0; j < BFCD_CSRMapBFCD->NumServices; j++ )
            {
                if (( strcmp( BFCD_CSRMapBFCD->ServiceInfoTable[j].ServiceLayoutName,
                      BFCD_CSRMapBFCD->ServiceInfoTable[i].AlternateService )
                      == 0 ))
                {
                  FndGenRC = GenerateService ( BFCD_CSRMapBFCD->ServiceInfoTable[j].pReposServiceLayoutTable,
                                               BFCD_CSRMapBFCD->ClientInfo.pReposClientLayoutTable,
                                               BFCD_CSRMapBFCD->ServiceInfoTable[j].pRepeatingMaps,
                                               BFCD_CSRMapBFCD->ServiceInfoTable[j].pCompareKeys,
                                               BFCD_CSRMapBFCD->ServiceInfoTable[j].pReturnData,
                                               BFCD_CSRMapBFCD->ServiceInfoTable[j].pLoadKeys,
                                               BFCD_CSRMapBFCD->ServiceInfoTable[j].pLoadData,
                                               j,
                                               BFCD_CSRMapBFCD->ServiceInfoTable );
                  break;
                } /* end of 3rd if */

             } /* end of inner for loop */

         } /* end of 2nd if */

      } /* end of 1st if */

    } /* end of outer for loop */

    if ( BFCD_CSRMapBFCD->ClientInfo.NumSearchDestroy > 0 )
    {
       WriteSDM( CMN_ARCH_PARMS );
    }

    WriteRMH( CMN_ARCH_PARMS ); /* To a separate file */

    /* Close all files */
    if ((NumberClosed = fcloseall()) != 2)
    {
       return(CMN_FAIL);
    }

    /* Combine RMH file with other file */
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

   FndGenRC = system(CopyCommand);

    /* CWOODS 01/10/96 : Remove temp file */
    FndGenRC = CmnStrCat( CMN_ARCH_PARMS,
			  RmCommand,
			  _RM_COMMAND_LEN,
			  2,
			  "RM ",
			  TmpFileNm);

   FndGenRC = system(RmCommand);


} /* end of GenerateMap */

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
                       _SERVICE_INFO ServiceInfoTable[] )
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
******************************************************************/

#define CK_LINE_1 "********  C O M P A R E  K E Y S  ********\n"
#define CK_LINE_2 "**** ClientName                       ServiceName                       FromOffset  ToOffset  Length    DataType    Operation   WildCardUsed WildCard              LiteralUsed LiteralValue \n"
#define CK_LINE_3 "**** ----------                       -----------                       ----------  --------  ------    --------    ---------   ------------ --------              ----------- ------------ \n"
#define CK_LINE_4 "CK   %-32.32s %-32.32s  %-10.1u  %-10.1u%-10.1i%-11.11s %-11.11s %-1.1c            %-21.21s %-1.1c           %-61.61s\n"

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
                        if (strcmp(ServiceLayout[Index].Usage, "DT") == 0)
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
                                     strlen(CK[Index].LiteralValue) + 1),
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
                                     strlen(CK[Index].LiteralValue) + 1),
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
                        if (strcmp(ServiceLayout[Index].Usage, "DT") == 0)
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
                                     strlen(LK[Index].LiteralValue) + 1),
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
                                     strlen(LK[Index].LiteralValue) + 1),
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
                        if (strcmp(ServiceLayout[Index].Usage, "DT") == 0)
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
                                     strlen(LD[Index].LiteralValue) + 1),
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
                                     strlen(LD[Index].LiteralValue) + 1),
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
                        if (strcmp(ServiceLayout[Index].Usage, "DT") == 0)
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
                                     strlen(CK[Index].LiteralValue) + 1),
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
                                     strlen(CK[Index].LiteralValue) + 1),
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
                        if (strcmp(ServiceLayout[Index].Usage, "DT") == 0)
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
                                     strlen(LK[Index].LiteralValue) + 1),
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
                                     strlen(LK[Index].LiteralValue) + 1),
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
                        if (strcmp(ServiceLayout[Index].Usage, "DT") == 0)
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
                                     strlen(LD[Index].LiteralValue) + 1),
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
                                     strlen(LD[Index].LiteralValue) + 1),
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
                            BFCD_CSRMapBFCD->CsrMapGenPath,
                            "\\",
                            BFCD_CSRMapBFCD->ClientInfo.ReqId,
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

    if ( strcmp( BFCD_CSRMapBFCD->ClientInfo.ReqType, "1" ) == 0 )
    {
        strncpy( ReqType, "INQUIRY", _REQ_TYPE_LEN );
    }
    else if ( strcmp( BFCD_CSRMapBFCD->ClientInfo.ReqType, "2" ) == 0 )
    {
        strncpy( ReqType, "LUW", _REQ_TYPE_LEN );
    }

    /* Write the standard header to the file */
    fprintf( Stream, RMH_LINE_1 );
    fprintf( Stream, RMH_LINE_2 );
    fprintf( Stream, RMH_LINE_3 );
    fprintf( Stream, RMH_LINE_4,
             BFCD_CSRMapBFCD->ClientInfo.ReqId,
             ReqType,
             BFCD_CSRMapBFCD->ClientInfo.pReposClientLayoutTable[0].ItemCLength,
             MapDataLength,
             BFCD_CSRMapBFCD->ClientInfo.Version );

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
