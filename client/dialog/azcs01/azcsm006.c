/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***********************************************************************
**
**         CUSTOMER SERVICE SYSTEM CSR MAP GENERATOR MODULE
**
**
**  FILENAME          : AZCSM006.C
**
**  DESCRIPTION       : CSR Map Generator Function CsrMapReadMapFile
**
**  DATE CREATED      : 06/10/93
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**
***********************************************************************/
#define  INCL_WIN
#define  INCL_DOS
#define CMN_ERR_ARCH_WRAP_FUNC FALSE
#define WINDOWMOD

#include <os2.h>
#include <string.h>
#include <stdio.h>
#include <float.h>
#include <limits.h>
#include <stdlib.h>
#include <malloc.h>
#include <ctype.h>
#include <stdarg.h>
#include <time.h>


#define  FND_FE_INCL
#define  FND_IM_INCL
#define  FND_EH_INCL
#define  FND_PS_INCL
#define  FND_CF_INCL
#define  FND_CTCONV_INCL
#define  FND_VERSION2

#include <kglzk000.h>

/*mdc 03/20/96 already included in azcs01b.gnb
#include "csrcmn.h"
#include "mapgen.h"
*/
#include "azcs01b.gnb"
#include "AZCS003.GNH"

#include <C1CEAB.H>
#define INCL_C1CBASE
#include <c1c.h>

#define _DUMMY_LEN  30

/***********************************************************************
**
**               CUSTOMER SERVICE SYSTEM CSR FUNCTION
**
**  FUNCTION         :  CsrMapReadMapFile
**
**  DESCRIPTION      :  Brings data "back" (save) from Map File
**
**  INPUTS           :  CMN_ARCH_PARM_TYPES
**
**  OUTPUTS          :  CMN_SUCCESS, CMN_FAIL
**
**  AUTHOR           :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED     :  06/10/93
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  06/09/93    SCHUNGSA                       Original Code.
**
**  06/10/93 -  JLOONEY                        Modifications.
**  07/12/93
**
**  07/13/93    JLOONEY                        Created additional comments.
**
**  07/14/93    JLOONEY                        Replaced all CmnMemAlloc-
**                                             Private with malloc.
**
**  08/0293     JLOONEY                        Added code to handle the
**                                             reading in of "UNKNOWN" C and
**                                             COBOL names, and "X" formats
**                                             and Usages from the client
**                                             and service layouts.
**
**  09/07/93    CCRAMPTO                       Changed the mallocs for the
**                                             relationship data to the total
**                                             possible size of the array.
**                                             Added memsets for those areas.
**
**  03/22/94    CCrampto                       Added validation logic to clean up
**                                                maps.
**
*****************************************************************************/


USHORT CsrMapReadMapFile( CMN_ARCH_PARM_TYPES )
{
    FILE *Stream;
    USHORT FndGenRC;
    CHAR FileNm[_CSR_MAP_FILENAME_LEN]  = "";
    CHAR CurLine[_MAPGN_MAX_MAP_LINE_LEN] = "";
    _LAYOUT_REC  *pCurRec               = NULL;
    _RELATE_RPMH *pCurRPMH              = NULL;
    _RELATE_CK   *pCurCK                = NULL;
    _RELATE_RD   *pCurRD                = NULL;
    _RELATE_LK   *pCurLK                = NULL;
    _RELATE_LD   *pCurLD                = NULL;
    CHAR d1[_DUMMY_LEN],d2[_DUMMY_LEN],d3[_DUMMY_LEN],
         d4[_DUMMY_LEN],d5[_DUMMY_LEN],d6[_DUMMY_LEN],
         d7[_DUMMY_LEN],d8[_DUMMY_LEN],d9[_DUMMY_LEN],
         d10[_DUMMY_LEN],d11[_DUMMY_LEN],d12[_DUMMY_LEN],
         d13[_DUMMY_LEN],d14[_DUMMY_LEN],d15[_DUMMY_LEN],
         d16[_DUMMY_LEN],d17[_DUMMY_LEN];
    SHORT i,j;
    CHAR ReqType[_REQ_TYPE_LEN];


    /* Build Map File Name */
    FndGenRC = CmnStrCat( CMN_ARCH_PARMS,
                          FileNm,
                          _CSR_MAP_FILENAME_LEN,
                          5,
                          BFCD_pCSRMapBFCD->CsrMapSavePath,
                          "\\",
                          BFCD_pCSRMapBFCD->ClientInfo.ReqId,
                          ".",
                          CSR_MAP_SAVE_FILE_EXT );

    /* Open Map File */
    if (( Stream = fopen( FileNm,"r" )) == NULL )
    {

        /* Open failure may actually be OK but use CMN_FAIL as a flag */

        return( CMN_FAIL );
    }


    /* Format the Request Header */
    fgets( CurLine,_MAPGN_MAX_MAP_LINE_LEN,Stream );

    sscanf( CurLine,CSR_MAP_REQ_HEADER_FORMAT_STR,
            d1,d2,BFCD_pCSRMapBFCD->ClientInfo.ReqId,
            d3,BFCD_pCSRMapBFCD->ClientInfo.ClientLayoutName,
            d4,ReqType,
            d5,&BFCD_pCSRMapBFCD->ClientInfo.NumSearchDestroy,
            d6,&BFCD_pCSRMapBFCD->ClientInfo.NumClientRows,
            d7,&BFCD_pCSRMapBFCD->NumServices,
            d8,&BFCD_pCSRMapBFCD->ClientInfo.Version);

    if ( strcmp( ReqType, "INQUIRY" ) == 0 )
    {
       strcpy( BFCD_pCSRMapBFCD->ClientInfo.ReqType, "1" );
    }
    else
    {
       strcpy( BFCD_pCSRMapBFCD->ClientInfo.ReqType, "2" );
    }

    /* Format the Task List Completions */
    fgets( CurLine,
           _MAPGN_MAX_MAP_LINE_LEN,
           Stream );

    sscanf( CurLine,
            CSR_MAP_TL_STATUS_FORMAT_STR,
            d1, d2,
            &(BFCD_pCSRMapBFCD->CKTaskListComplete),
            d3,
            &(BFCD_pCSRMapBFCD->RDTaskListComplete),
            d4,
            &(BFCD_pCSRMapBFCD->LKTaskListComplete),
            d5,
            &(BFCD_pCSRMapBFCD->LDTaskListComplete),
            d6,
            &(BFCD_pCSRMapBFCD->RPMHTaskListComplete) );

    /* Format SearchDestroys */
    for ( i = 0; i < BFCD_pCSRMapBFCD->ClientInfo.NumSearchDestroy; i++ )
    {
         fgets( CurLine,_MAPGN_MAX_MAP_LINE_LEN,Stream );
         sscanf( CurLine,CSR_MAP_SD_FORMAT_STR,
                 d1,d2,BFCD_pCSRMapBFCD->ClientInfo.SearchDestroyTable[i].ReqId );
    }


    /* Format Client Layouts */
    BFCD_pCSRMapBFCD->ClientInfo.pClientLayoutTable =
                         (_LAYOUT_REC *)malloc((sizeof(_LAYOUT_REC)*
                          MAXCLIENTROWS));

    /* Clear it out before reading in any data */
    memset(BFCD_pCSRMapBFCD->ClientInfo.pClientLayoutTable,
           0,
           sizeof(_LAYOUT_REC)*MAXCLIENTROWS);

    for ( i = 0, pCurRec = BFCD_pCSRMapBFCD->ClientInfo.pClientLayoutTable;
              i < BFCD_pCSRMapBFCD->ClientInfo.NumClientRows; i++, pCurRec++ )
    {
         fgets( CurLine,_MAPGN_MAX_MAP_LINE_LEN,Stream );
         sscanf( CurLine,CSR_MAP_LAYOUT_FORMAT_STR,
                 d1,d2,pCurRec->ItemId,
                 d3,&(pCurRec->ItemType),
                 d4,pCurRec->ItemCName,
                 d5,pCurRec->ItemCobolName,
                 d6,&(pCurRec->Format),
                 d7,&(pCurRec->ItemLength),
                 d8,&(pCurRec->Precision),
                 d9,pCurRec->Usage,
                 d10,&(pCurRec->ItemOccurs),
                 d11,&(pCurRec->DataType),
                 d12,&(pCurRec->ItemLevel),
                 d13,&(pCurRec->ItemOffset),
                 d14,&(pCurRec->ItemCLength),
                 d15,&(pCurRec->ChildIndex),
                 d16,&(pCurRec->SiblingIndex),
                 d17,&(pCurRec->ParentIndex) );

         if ( strcmp( pCurRec->ItemCName, "UNKNOWN" ) == 0 )
         {
            pCurRec->ItemCName[0] = '\0';
         }

         if ( strcmp( pCurRec->ItemCobolName, "UNKNOWN" ) == 0 )
         {
            pCurRec->ItemCobolName[0] = '\0';
         }

         if ( pCurRec->Format == 'X' )
         {
            pCurRec->Format = '\0';
         }

         if ( pCurRec->Usage[0] == 'X' )
         {
            pCurRec->Usage[0] = '\0';
         }

    }


    /* Process each Service (Format Service Layout) */
    for ( i = 0; i < BFCD_pCSRMapBFCD->NumServices; i++ )
    {
         /* Format Service Header */

         char Flush[_FLUSH_LEN];
         char ServiceType[2];

         fgets( CurLine,_MAPGN_MAX_MAP_LINE_LEN,Stream );
         sscanf( CurLine,CSR_MAP_SERVICE_HDR_FORMAT_STR,
                 d1,d2,BFCD_pCSRMapBFCD->ServiceInfoTable[i].ServiceLayoutName,
                 d3,&(BFCD_pCSRMapBFCD->ServiceInfoTable[i].Server),
                 d4,&(BFCD_pCSRMapBFCD->ServiceInfoTable[i].ServiceId),
                 d5,&(BFCD_pCSRMapBFCD->ServiceInfoTable[i].ServiceAgeLimit),
                 d6,BFCD_pCSRMapBFCD->ServiceInfoTable[i].AnticCallModule,
                 d7,Flush,
                 d8,ServiceType,
                 d9,BFCD_pCSRMapBFCD->ServiceInfoTable[i].AlternateService,
                 d10,&(BFCD_pCSRMapBFCD->ServiceInfoTable[i].NumServiceRows),
                 d11,&(BFCD_pCSRMapBFCD->ServiceInfoTable[i].Version),
                 d12,BFCD_pCSRMapBFCD->ServiceInfoTable[i].ForceCall );

         if ( stricmp(Flush,"FALSE") == 0 )
         {
              BFCD_pCSRMapBFCD->ServiceInfoTable[i].FlushFlag = 0;
         }
         else
         {
              BFCD_pCSRMapBFCD->ServiceInfoTable[i].FlushFlag = 1;
         }

         if ( strncmp(ServiceType, "P", 1 ) == 0 )
         {
              strncpy( BFCD_pCSRMapBFCD->ServiceInfoTable[i].ServiceType,
                       LT_Primary, 2 );
         }
         else
         {
              strncpy( BFCD_pCSRMapBFCD->ServiceInfoTable[i].ServiceType,
                       LT_Alternate, 2 );
         }

         /* Format Service Layout */
         BFCD_pCSRMapBFCD->ServiceInfoTable[i].pServiceLayoutTable =
                          (_LAYOUT_REC *)malloc((sizeof(_LAYOUT_REC)*
                          MAXSERVICEROWS));


         /* Clear it out before reading in any data */
         memset(BFCD_pCSRMapBFCD->ServiceInfoTable[i].pServiceLayoutTable,
           0,
           sizeof(_LAYOUT_REC)*MAXSERVICEROWS);


         for ( j = 0, pCurRec = BFCD_pCSRMapBFCD->ServiceInfoTable[i].pServiceLayoutTable;
                   j < BFCD_pCSRMapBFCD->ServiceInfoTable[i].NumServiceRows; j++, pCurRec++)

         {
              fgets( CurLine,_MAPGN_MAX_MAP_LINE_LEN,Stream );
              sscanf( CurLine,CSR_MAP_LAYOUT_FORMAT_STR,
                              d1,d2,pCurRec->ItemId,
                              d3,&(pCurRec->ItemType),
                              d4,pCurRec->ItemCName,
                              d5,pCurRec->ItemCobolName,
                              d6,&(pCurRec->Format),
                              d7,&(pCurRec->ItemLength),
                              d8,&(pCurRec->Precision),
                              d9,pCurRec->Usage,
                              d10,&(pCurRec->ItemOccurs),
                              d11,&(pCurRec->DataType),
                              d12,&(pCurRec->ItemLevel),
                              d13,&(pCurRec->ItemOffset),
                              d14,&(pCurRec->ItemCLength),
                              d15,&(pCurRec->ChildIndex),
                              d16,&(pCurRec->SiblingIndex),
                              d17,&(pCurRec->ParentIndex) );

              if ( strcmp( pCurRec->ItemCName, "UNKNOWN" ) == 0 )
              {
                 pCurRec->ItemCName[0] = '\0';
              }

              if ( strcmp( pCurRec->ItemCobolName, "UNKNOWN" ) == 0 )
              {
                 pCurRec->ItemCobolName[0] = '\0';
              }

              if ( pCurRec->Format == 'X' )
              {
                 pCurRec->Format = '\0';
              }

              if ( pCurRec->Usage[0] == 'X' )
              {
                 pCurRec->Usage[0] = '\0';
              }

         }

         while ( 1 )
         {
            fgets( CurLine, _MAPGN_MAX_MAP_LINE_LEN, Stream );
            strcpy( d1, "\0" );
            sscanf( CurLine, "%s", d1 );

            if (( BFCD_pCSRMapBFCD->RPMHTaskListComplete == 'Y' )
                && (( strcmp( d1, "RELATE-RPMH" ) == 0 )))
            {
               /* Format Repeating Map Header Relationships */
               BFCD_pCSRMapBFCD->ServiceInfoTable[i].pRepeatingMaps =
                              (_RELATE_RPMH *)malloc((sizeof(_RELATE_RPMH)*
                              MAXSERVICEROWS));

               /* Clear out the memory before adding data */
               memset(BFCD_pCSRMapBFCD->ServiceInfoTable[i].pRepeatingMaps,
                      0,
                      sizeof(_RELATE_RPMH)*MAXSERVICEROWS);

               /* Read in the first line of RPMH */
               pCurRPMH = BFCD_pCSRMapBFCD->ServiceInfoTable[i].pRepeatingMaps;
               sscanf( CurLine,CSR_MAP_RELATE_RPMH_FORMAT_STR,
                       d1,d2,&(pCurRPMH->ClientLayoutIndex),
                       d3,&(pCurRPMH->SingleOccurence) );
               pCurRPMH++;

               /* Retrieve the remaining lines of Repeating Maps. */
               for ( j = 1;
                     j < BFCD_pCSRMapBFCD->ServiceInfoTable[i].NumServiceRows;
                     j++, pCurRPMH++ )
               {
                 fgets( CurLine, _MAPGN_MAX_MAP_LINE_LEN, Stream );
                 sscanf( CurLine,CSR_MAP_RELATE_RPMH_FORMAT_STR,
                         d1,d2,&(pCurRPMH->ClientLayoutIndex),
                         d3,&(pCurRPMH->SingleOccurence) );
               }
            } /* end of outer if */

            else if (( BFCD_pCSRMapBFCD->CKTaskListComplete == 'Y' )
                    && (( strcmp( d1, "RELATE-CK" ) == 0 )))
            {
               /* Format Compare Key Relationships */
               BFCD_pCSRMapBFCD->ServiceInfoTable[i].pCompareKeys =
                              (_RELATE_CK *)malloc((sizeof(_RELATE_CK)*
                              MAXSERVICEROWS));

               /* Clear out the memory before adding data */
               memset(BFCD_pCSRMapBFCD->ServiceInfoTable[i].pCompareKeys,
                      0,
                      sizeof(_RELATE_CK)*MAXSERVICEROWS);

               /* Read in the first line of Compare Keys */
               pCurCK = BFCD_pCSRMapBFCD->ServiceInfoTable[i].pCompareKeys;
               sscanf( CurLine,CSR_MAP_RELATE_CK_FORMAT_STR,
                       d1,d2,&(pCurCK->ClientLayoutIndex),
                       d3,&(pCurCK->LiteralUsed),
                       d4,pCurCK->LiteralValue,
                       d5,&(pCurCK->WildCardUsed),
                       d6,pCurCK->WildCardValue,
                       d7,pCurCK->Operation );
               /* CSC: 03/22/94 Add validation logic */
               if (pCurCK->LiteralUsed != 'Y')
               {
                   pCurCK->LiteralUsed = 'N';
                   strcpy(pCurCK->LiteralValue, "NULL");
               }
               if (pCurCK->WildCardUsed != 'Y')
               {
                   pCurCK->WildCardUsed = 'N';
                   strcpy(pCurCK->WildCardValue, "NULL");
               }
               if (strcmp(pCurCK->Operation, "EQ") != 0)
               {
                   strcpy(pCurCK->Operation, "EQ");
               }

               pCurCK++;

               /* Retrieve the remaining lines of Compare Keys. */
               for ( j = 1;
                     j < BFCD_pCSRMapBFCD->ServiceInfoTable[i].NumServiceRows;
                     j++, pCurCK++ )
               {
                 fgets( CurLine, _MAPGN_MAX_MAP_LINE_LEN, Stream );
                 sscanf( CurLine,CSR_MAP_RELATE_CK_FORMAT_STR,
                         d1,d2,&(pCurCK->ClientLayoutIndex),
                         d3,&(pCurCK->LiteralUsed),
                         d4,pCurCK->LiteralValue,
                         d5,&(pCurCK->WildCardUsed),
                         d6,pCurCK->WildCardValue,
                         d7,pCurCK->Operation );
               /* CSC: 03/22/94 Add validation logic */
               if (pCurCK->LiteralUsed != 'Y')
               {
                   pCurCK->LiteralUsed = 'N';
                   strcpy(pCurCK->LiteralValue, "NULL");
               }
               if (pCurCK->WildCardUsed != 'Y')
               {
                   pCurCK->WildCardUsed = 'N';
                   strcpy(pCurCK->WildCardValue, "NULL");
               }
               if (strcmp(pCurCK->Operation, "EQ") != 0)
               {
                   strcpy(pCurCK->Operation, "EQ");
               }


               }
            } /* end of else if */


            else if (( BFCD_pCSRMapBFCD->RDTaskListComplete == 'Y')
                    && (( strcmp( d1, "RELATE-RD" ) == 0 )))
            {
               /* Format Return Data Relationships */
               BFCD_pCSRMapBFCD->ServiceInfoTable[i].pReturnData =
                              (_RELATE_RD *)malloc((sizeof(_RELATE_RD)*
                              MAXSERVICEROWS));

               /* Clear out the area before adding data */
               memset(BFCD_pCSRMapBFCD->ServiceInfoTable[i].pReturnData,
                      0,
                      sizeof(_RELATE_RD)*MAXSERVICEROWS);

               /* Read in the first line of Return Data */
               pCurRD = BFCD_pCSRMapBFCD->ServiceInfoTable[i].pReturnData;
               sscanf( CurLine,CSR_MAP_RELATE_RD_FORMAT_STR,
                       d1,d2,&(pCurRD->ClientLayoutIndex) );
               pCurRD++;

               /* Retrieve the remaining lines of Return Data. */
               for ( j = 1;
                     j < BFCD_pCSRMapBFCD->ServiceInfoTable[i].NumServiceRows;
                     j++,pCurRD++ )
               {
                 fgets( CurLine, _MAPGN_MAX_MAP_LINE_LEN, Stream );
                 sscanf( CurLine,CSR_MAP_RELATE_RD_FORMAT_STR,
                         d1,d2,&(pCurRD->ClientLayoutIndex) );

               }
            } /* end of else if */

            else if (( BFCD_pCSRMapBFCD->LKTaskListComplete  == 'Y' )
                    && (( strcmp( d1, "RELATE-LK" ) == 0 )))
            {
               /* Format Load Key Relationships */
               BFCD_pCSRMapBFCD->ServiceInfoTable[i].pLoadKeys =
                              (_RELATE_LK *)malloc((sizeof(_RELATE_LK)*
                              MAXSERVICEROWS));

               /* Clear out the area before adding data */
               memset(BFCD_pCSRMapBFCD->ServiceInfoTable[i].pLoadKeys,
                      0,
                      sizeof(_RELATE_LK)*MAXSERVICEROWS);


               /* Read in the first line of Load Keys */
               pCurLK = BFCD_pCSRMapBFCD->ServiceInfoTable[i].pLoadKeys;
               sscanf( CurLine,CSR_MAP_RELATE_LK_FORMAT_STR,
                       d1,d2,&(pCurLK->ClientLayoutIndex),
                       d3,&(pCurLK->LiteralUsed),
                       d4,pCurLK->LiteralValue );

               /* CSC: Add validation logic to clean up maps */
               if (pCurLK->LiteralUsed != 'Y')
               {
                   pCurLK->LiteralUsed = 'N';
                   strcpy(pCurLK->LiteralValue, "NULL");
               }

               pCurLK++;

               /* Retrieve the remaining lines of Load Keys. */
               for ( j = 1;
                     j < BFCD_pCSRMapBFCD->ServiceInfoTable[i].NumServiceRows;
                     j++, pCurLK++ )
               {
                 fgets( CurLine, _MAPGN_MAX_MAP_LINE_LEN, Stream );
                 sscanf( CurLine,CSR_MAP_RELATE_LK_FORMAT_STR,
                                 d1,d2,&(pCurLK->ClientLayoutIndex),
                                 d3,&(pCurLK->LiteralUsed),
                                 d4,pCurLK->LiteralValue );

               /* CSC: Add validation logic to clean up maps */
               if (pCurLK->LiteralUsed != 'Y')
               {
                   pCurLK->LiteralUsed = 'N';
                   strcpy(pCurLK->LiteralValue, "NULL");
               }


               }
            } /* end of else if */

            else if (( BFCD_pCSRMapBFCD->LDTaskListComplete == 'Y' )
                    && (( strcmp( d1, "RELATE-LD" ) == 0 )))
            {
               /* Format Load Data Relationships */
               BFCD_pCSRMapBFCD->ServiceInfoTable[i].pLoadData =
                              (_RELATE_LD *)malloc((sizeof(_RELATE_LD)*
                              MAXSERVICEROWS));

               /* Clear out the area before adding data */
               memset(BFCD_pCSRMapBFCD->ServiceInfoTable[i].pLoadData,
                      0,
                      sizeof(_RELATE_LD)*MAXSERVICEROWS);


               /* Read in the first line of Load Data */
               pCurLD = BFCD_pCSRMapBFCD->ServiceInfoTable[i].pLoadData;
               sscanf( CurLine,CSR_MAP_RELATE_LD_FORMAT_STR,
                       d1,d2,&(pCurLD->ClientLayoutIndex),
                       d3,&(pCurLD->LiteralUsed),
                       d4,pCurLD->LiteralValue );

               /* CSC: Add validation logic to clean up maps */
               if (pCurLD->LiteralUsed != 'Y')
               {
                   pCurLD->LiteralUsed = 'N';
                   strcpy(pCurLD->LiteralValue, "NULL");
               }


               pCurLD++;

               /* Retrieve the remaining lines of Load Data. */
               for ( j = 1;
                     j < BFCD_pCSRMapBFCD->ServiceInfoTable[i].NumServiceRows;
                     j++, pCurLD++ )
               {
                 fgets( CurLine, _MAPGN_MAX_MAP_LINE_LEN, Stream );
                 sscanf( CurLine,CSR_MAP_RELATE_LD_FORMAT_STR,
                         d1,d2,&(pCurLD->ClientLayoutIndex),
                         d3,&(pCurLD->LiteralUsed),
                         d4,pCurLD->LiteralValue );

               /* CSC: Add validation logic to clean up maps */
               if (pCurLD->LiteralUsed != 'Y')
               {
                   pCurLD->LiteralUsed = 'N';
                   strcpy(pCurLD->LiteralValue, "NULL");
               }

               }
            } /* end of else if */

            /* Check if at the end of the service. */
            else if ( strcmp( d1, "ENDOFSERVICE" ) == 0)
            {
                break;
            }

         } /* end of while */

    } /* end of service for loop */

    /* Close the file */
    fclose( Stream );

    return(CMN_SUCCESS);

}
