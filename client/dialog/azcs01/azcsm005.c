/***********************************************************************
**
**         CUSTOMER SERVICE SYSTEM CSR MAP GENERATOR MODULE
**
**
**  FILENAME          : AZCSM005.C
**
**  DESCRIPTION       : CSR Map Generator Function CsrMapWriteMapFile
**
**  DATE CREATED      : 06/17/93
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  07/13/94    C CRAMPTON                 ADDED ERROR HANDLING FOR BAD OPEN
**                                         OF MAP FILE.
**
***********************************************************************/
#define  INCL_WIN
#define  INCL_DOS
#define CMN_ERR_ARCH_WRAP_FUNC FALSE

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

#include "csrcmn.h"
#include "mapgen.h"
#include "azcs01b.gnb"
#include "AZCS003.GNH"

#include <C1CEAB.H>
#define INCL_C1CBASE
#include <c1c.h>
/***********************************************************************
**
**               CUSTOMER SERVICE SYSTEM CSR FUNCTION
**
**  FUNCTION         :  CsrMapWriteMapFile
**
**  DESCRIPTION      :  Writes the contents of the map data structures to
**                      a temporary file with the extension ".CSM".
**
**  INPUTS           :  NONE
**
**  OUTPUTS          :  CMN_SUCCESS, CMN_FAIL
**
**  AUTHOR           :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED     :  06/17/93
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**  06/17/93    JLOONEY                    Original Code.
**  09/17/93    CCRAMPTON                  Modified code for deleted services.
************************************************************************/

USHORT CsrMapWriteMapFile( CMN_ARCH_PARM_TYPES )
{
    FILE *Stream;
    USHORT FndGenRC;
    CHAR FileNm[_CSR_MAP_FILENAME_LEN] = "";
    _LAYOUT_REC  *pCurRec;
    _RELATE_RPMH *pCurRPMH;
    _RELATE_CK   *pCurCK;
    _RELATE_RD   *pCurRD;
    _RELATE_LK   *pCurLK;
    _RELATE_LD   *pCurLD;
    SHORT i;
    SHORT j;
    CHAR ReqType[_REQ_TYPE_LEN];
    USHORT usNumValidServices = 0;
    _FND_ERROR_BLOCK  FndGenErrorBlock;
    USHORT SelectedButton;

    /* Open Map File */
    FndGenRC = CmnStrCat(  CMN_ARCH_PARMS,
                           FileNm,
                           _CSR_MAP_FILENAME_LEN,
                           5,
                           BFCD_CSRMapBFCD->CsrMapSavePath,
                           "\\",
                           BFCD_CSRMapBFCD->ClientInfo.ReqId,
                           ".",
                           CSR_MAP_SAVE_FILE_EXT );

    if (( Stream = fopen(FileNm,"w")) == NULL )
    {
       FndGenRC = FndMsgBoxDisplayText("Unable to write to SAVE file.\n"
                                       "Make sure you have proper rights for this file.\n\n"
                                       "Saving of map failed.",
                                       NULL,
                                       CBI_hwnd,
                                       FND_MSGBOX_OK,
                                       FND_MSGBOX_ERROR,
                                       FND_MSGBOX_IDOK,
                                       NULL,
                                       &SelectedButton,
                                       &FndGenErrorBlock);

        return(CMN_FAIL);
    }

    if ( strcmp( BFCD_CSRMapBFCD->ClientInfo.ReqType, "1" ) == 0 ||
         strcmp( BFCD_CSRMapBFCD->ClientInfo.ReqType, "INQUIRY") == 0)
    {
        strncpy( ReqType, "INQUIRY", _REQ_TYPE_LEN );
    }
    else if ( strcmp( BFCD_CSRMapBFCD->ClientInfo.ReqType, "2" ) == 0 ||
              strcmp( BFCD_CSRMapBFCD->ClientInfo.ReqType, "LUW" ) == 0 )
    {
        strncpy( ReqType, "LUW", _REQ_TYPE_LEN );
    }

    /*
    ** Calculate the number of valid services
    **  The BFCD counter includes any services that are marked as deleted
    **  but in the save map we will not include them.
    ** CSC: 09/17/93
    */

    for ( i = 0; i < BFCD_CSRMapBFCD->NumServices; i++ )
    {
       if ( BFCD_CSRMapBFCD->ServiceInfoTable[i].DeleteFlag )
          {
            /* if deleted, continue onto the next service */
            continue;
          }
       usNumValidServices++;
    }

    /* Write the Request Header to the file */
    fprintf( Stream,
             CSR_MAP_REQ_HEADER_WRITE_STR,
             "REQUESTHEADER",
             "***RequestID= ",
             BFCD_CSRMapBFCD->ClientInfo.ReqId,
             "***ClientLayoutName= ",
             BFCD_CSRMapBFCD->ClientInfo.ClientLayoutName,
             "***RequestType= ",
             ReqType,
             "***NumSearchDestroys= ",
             BFCD_CSRMapBFCD->ClientInfo.NumSearchDestroy,
             "***NumClientRows= ",
             BFCD_CSRMapBFCD->ClientInfo.NumReposClientRows,
             "***NumServices= ",
             usNumValidServices,
             "***ClientVersion=",
             BFCD_CSRMapBFCD->ClientInfo.Version);

    /* Write the Task List Completion Status to the file. */
    fprintf( Stream,
             CSR_MAP_TL_STATUS_WRITE_STR,
             "TASKLISTCOMPLETIONS",
             "***CompareKeys= ",
             BFCD_CSRMapBFCD->CKTaskListComplete,
             "***ReturnData= ",
             BFCD_CSRMapBFCD->RDTaskListComplete,
             "***LoadKeys= ",
             BFCD_CSRMapBFCD->LKTaskListComplete,
             "***LoadData= ",
             BFCD_CSRMapBFCD->LDTaskListComplete,
             "***RepeatingMaps= ",
             BFCD_CSRMapBFCD->RPMHTaskListComplete );


    /* Write the SearchDestroys to the file */
    for ( i = 0; i < BFCD_CSRMapBFCD->ClientInfo.NumSearchDestroy; i++ )
    {
         fprintf( Stream,
                  CSR_MAP_SD_WRITE_STR,
                  "SEARCHDESTROY",
                  "***RequestId= ",
                  BFCD_CSRMapBFCD->ClientInfo.SearchDestroyTable[i].ReqId );
    }


    /* Write the Client Layouts to the file */
    for ( i = 0, pCurRec = BFCD_CSRMapBFCD->ClientInfo.pReposClientLayoutTable ;
          i < BFCD_CSRMapBFCD->ClientInfo.NumReposClientRows;
          i++, pCurRec++ )
    {
         if ( pCurRec->ItemType != 'E' )
         {
            pCurRec->Format = 'X';
            strncpy( pCurRec->Usage, "XX", _USAGE_LEN );
         }

         if ( pCurRec->ItemCName[0] == '\0' )
         {
            strncpy( pCurRec->ItemCName, "X", ITEM_NAME_LEN );
         }

         if ( pCurRec->ItemCobolName[0] == '\0' )
         {
            strncpy( pCurRec->ItemCobolName, "X", ITEM_NAME_LEN );
         }

         if ( pCurRec->Format == '\0' )
         {
            pCurRec->Format = 'X';
         }

         if ( pCurRec->Usage[0] == '\0' )
         {
            strncpy( pCurRec->Usage, "XX", _USAGE_LEN );
         }

         fprintf( Stream,
                  CSR_MAP_LAYOUT_WRITE_STR,
                  "CLIENTLAYOUT",
                  "***ItemId= ",
                  pCurRec->ItemId,
                  "***ItemType= ",
                  pCurRec->ItemType,
                  "***ItemCName= ",
                  pCurRec->ItemCName,
                  "***ItemCobolName= ",
                  pCurRec->ItemCobolName,
                  "***Format= ",
                  pCurRec->Format,
                  "***ItemLength= ",
                  pCurRec->ItemLength,
                  "***Precision= ",
                  pCurRec->Precision,
                  "***Usage= ",pCurRec->Usage,
                  "***ItemOccurs= ",
                  pCurRec->ItemOccurs,
                  "***DataType= ",
                  pCurRec->DataType,
                  "***ItemLevel= ",
                  pCurRec->ItemLevel,
                  "***ItemOffset= ",
                  pCurRec->ItemOffset,
                  "***ItemCLength= ",
                  pCurRec->ItemCLength,
                  "***ChildIndex= ",
                  pCurRec->ChildIndex,
                  "***SiblingIndex= ",
                  pCurRec->SiblingIndex,
                  "***ParentIndex= ",
                  pCurRec->ParentIndex );
    }


    /* Process each Service */
    for ( i = 0; i < BFCD_CSRMapBFCD->NumServices; i++ )
    {
         CHAR Flush[_FLUSH_LEN];
         CHAR ServiceType[2];

         /* Check if Service is deleted */
         if ( BFCD_CSRMapBFCD->ServiceInfoTable[i].DeleteFlag )
         {
            /* if deleted, continue onto the next service */
            continue;
         }

         /* Write the Service Header to the file */
         if ( BFCD_CSRMapBFCD->ServiceInfoTable[i].FlushFlag )
         {
            strncpy( Flush, "TRUE", _FLUSH_LEN );
         }
         else
         {
            strncpy( Flush, "FALSE", _FLUSH_LEN );
         }

         if ( strcmp( BFCD_CSRMapBFCD->ServiceInfoTable[i].ServiceType,
              LT_Primary ) == 0 )
         {
            strncpy( ServiceType, "P", 2 );
         }
         else if ( strcmp( BFCD_CSRMapBFCD->ServiceInfoTable[i].ServiceType,
                   LT_Alternate ) == 0 )
         {
            strncpy( ServiceType, "A", 2 );
         }

         fprintf( Stream,
                  CSR_MAP_SERVICE_HDR_WRITE_STR,
                  "SERVICEHEADER",
                  "***ServiceLayoutName= ",
                  BFCD_CSRMapBFCD->ServiceInfoTable[i].ServiceLayoutName,
                  "***Server= ",
                  BFCD_CSRMapBFCD->ServiceInfoTable[i].Server,
                  "***ServiceId= ",
                  BFCD_CSRMapBFCD->ServiceInfoTable[i].ServiceId,
                  "***ServiceAgeLimit= ",
                  BFCD_CSRMapBFCD->ServiceInfoTable[i].ServiceAgeLimit,
                  "***AnticCallModule= ",
                  BFCD_CSRMapBFCD->ServiceInfoTable[i].AnticCallModule,
                  "***FlushFlag= ",
                  Flush,
                  "***ServiceType= ",
                  ServiceType,
                  "***AlternateService= ",
                  BFCD_CSRMapBFCD->ServiceInfoTable[i].AlternateService,
                  "***NumServiceRows= ",
                  BFCD_CSRMapBFCD->ServiceInfoTable[i].NumReposServiceRows,
                  "***Version=",
                  BFCD_CSRMapBFCD->ServiceInfoTable[i].Version,
                  "***ForceCall=",
                  BFCD_CSRMapBFCD->ServiceInfoTable[i].ForceCall);

         /* Write the Service Layout Row to the file */

         for ( j = 0, pCurRec = BFCD_CSRMapBFCD->ServiceInfoTable[i].pReposServiceLayoutTable;
               j < BFCD_CSRMapBFCD->ServiceInfoTable[i].NumReposServiceRows;
               j++, pCurRec++ )
         {
              if ( pCurRec->ItemType != 'E' )
              {
                 pCurRec->Format = 'X';
                 strncpy( pCurRec->Usage, "XX", _USAGE_LEN );
              }


              if ( pCurRec->ItemCName[0] == '\0' )
              {
                 strncpy( pCurRec->ItemCName, "UNKNOWN", ITEM_NAME_LEN );
              }

              if ( pCurRec->ItemCobolName[0] == '\0' )
              {
                 strncpy( pCurRec->ItemCobolName, "UNKNOWN", ITEM_NAME_LEN );
              }

              if ( pCurRec->Format == '\0' )
              {
                 pCurRec->Format = 'X';
              }

              if ( pCurRec->Usage[0] == '\0' )
              {
                 strncpy( pCurRec->Usage, "XX", _USAGE_LEN );
              }

              fprintf( Stream,
                       CSR_MAP_LAYOUT_WRITE_STR,
                       "SERVICELAYOUT",
                       "***ItemId= ",
                       pCurRec->ItemId,
                       "***ItemType= ",
                       pCurRec->ItemType,
                       "***ItemCName= ",
                       pCurRec->ItemCName,
                       "***ItemCobolName= ",
                       pCurRec->ItemCobolName,
                       "***Format= ",
                       pCurRec->Format,
                       "***ItemLength= ",
                       pCurRec->ItemLength,
                       "***Precision= ",
                       pCurRec->Precision,
                       "***Usage= ",
                       pCurRec->Usage,
                       "***ItemOccurs= ",
                       pCurRec->ItemOccurs,
                       "***DataType= ",
                       pCurRec->DataType,
                       "***ItemLevel= ",
                       pCurRec->ItemLevel,
                       "***ItemOffset= ",
                       pCurRec->ItemOffset,
                       "***ItemCLength= ",
                       pCurRec->ItemCLength,
                       "***ChildIndex= ",
                       pCurRec->ChildIndex,
                       "***SiblingIndex= ",
                       pCurRec->SiblingIndex,
                       "***ParentIndex= ",
                       pCurRec->ParentIndex );
         }


         /* Write the Repeating Map Header Relationships to the file */
         if ( BFCD_CSRMapBFCD->ServiceInfoTable[i].pRepeatingMaps != NULL )
         {
            for ( j = 0, pCurRPMH = BFCD_CSRMapBFCD->ServiceInfoTable[i].pRepeatingMaps;
                  j < BFCD_CSRMapBFCD->ServiceInfoTable[i].NumReposServiceRows;
                  j++, pCurRPMH++ )
            {
                fprintf( Stream,
                         CSR_MAP_RELATE_RPMH_WRITE_STR,
                         "RELATE-RPMH",
                         "***ClientLayoutIndex= ",
                         pCurRPMH->ClientLayoutIndex,
                         "***SingleOccurence= ",
                         pCurRPMH->SingleOccurence );
            }
        } /* end of if */


         /* Write the Compare Key Relationships to the file */
         if ( BFCD_CSRMapBFCD->ServiceInfoTable[i].pCompareKeys != NULL )
         {
            for ( j = 0, pCurCK = BFCD_CSRMapBFCD->ServiceInfoTable[i].pCompareKeys;
                  j < BFCD_CSRMapBFCD->ServiceInfoTable[i].NumReposServiceRows;
                  j++, pCurCK++ )
            {
                  fprintf( Stream,
                           CSR_MAP_RELATE_CK_WRITE_STR,
                           "RELATE-CK",
                           "***ClientLayoutIndex= ",
                           pCurCK->ClientLayoutIndex,
                           "***LiteralUsed= ",
                           pCurCK->LiteralUsed,
                           "***LiteralValue= ",
                           pCurCK->LiteralValue,
                           "***WildCardUsed= ",
                           pCurCK->WildCardUsed,
                           "***WildCardValue= ",
                           pCurCK->WildCardValue,
                           "***Operation= ",
                           pCurCK->Operation );
            }

         } /* end of if */

         /* Write the Return Data Relationships to the file */
         if ( BFCD_CSRMapBFCD->ServiceInfoTable[i].pReturnData != NULL )
         {
            for ( j = 0, pCurRD = BFCD_CSRMapBFCD->ServiceInfoTable[i].pReturnData;
                  j < BFCD_CSRMapBFCD->ServiceInfoTable[i].NumReposServiceRows;
                  j++, pCurRD++ )
           {
                fprintf( Stream,
                         CSR_MAP_RELATE_RD_WRITE_STR,
                         "RELATE-RD",
                         "***ClientLayoutIndex= ",
                         pCurRD->ClientLayoutIndex );

           }
         }  /* end of if */

         /* Write the Load Key Relationships to the file */
         if ( BFCD_CSRMapBFCD->ServiceInfoTable[i].pLoadKeys != NULL )
         {
            for ( j = 0, pCurLK = BFCD_CSRMapBFCD->ServiceInfoTable[i].pLoadKeys;
                  j < BFCD_CSRMapBFCD->ServiceInfoTable[i].NumReposServiceRows;
                  j++, pCurLK++)
            {
                 fprintf( Stream,
                          CSR_MAP_RELATE_LK_WRITE_STR,
                          "RELATE-LK",
                          "***ClientLayoutIndex= ",
                          pCurLK->ClientLayoutIndex,
                          "***LiteralUsed= ",
                          pCurLK->LiteralUsed,
                          "***LiteralValue= ",
                          pCurLK->LiteralValue );
            }
         } /* end of if */

         /* Write the Load Data Relationships to the file */
         if ( BFCD_CSRMapBFCD->ServiceInfoTable[i].pLoadData != NULL )
         {
            for ( j = 0, pCurLD = BFCD_CSRMapBFCD->ServiceInfoTable[i].pLoadData;
                  j < BFCD_CSRMapBFCD->ServiceInfoTable[i].NumReposServiceRows;
                  j++, pCurLD++ )
            {
                fprintf( Stream,
                         CSR_MAP_RELATE_LD_WRITE_STR,
                         "RELATE-LD",
                         "***ClientLayoutIndex= ",
                         pCurLD->ClientLayoutIndex,
                         "***LiteralUsed= ",
                         pCurLD->LiteralUsed,
                         "***LiteralValue= ",
                         pCurLD->LiteralValue);
            }
         } /* end of if */

         /* Denote the end of service */
         fprintf( Stream,
                  "%s\n",
                  "ENDOFSERVICE" );

    }

    /* Close the file */
    fclose( Stream );

    return(CMN_SUCCESS);

}
