/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/***********************************************************************
**
**                  CUSTOMER SERVICE SYSTEM CSR MODULE
**
**
**  FILENAME          : AZCSM001.C
**
**  DESCRIPTION       : Provides the DataType, ItemOffset, and ItemClLength
**                      to the layout record.
**
**
**  DATE CREATED      : 06/09/93
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**                                         Original Code.
**  07/22/93    C. CRAMPTON                Added entityId to the Info Msg Box
**
**  01/11/96    mconner                    Removed stackavail() not in NT
**
**  01/11/96    mconner                    Restored MSGConvUI in replace of
**                                         MSGConv
**
**  04/03/96    mconner                    Added inclusion of version.h
**                                         for version number definition
**
**  08/03/96    CWOODS                     CsrMapProcessElement:
**										   Discovery Release:  The INT3DATE
**										   data type generated incorrectly.
**										   Added a row to the table for
**										   a 'DT' usage to generate as
**										   alpha 11.
**
**
**
***********************************************************************/
#define  INCL_WIN
#define  INCL_DOS
#define WINDOWMOD
#ifdef FND_WIN32
#include <windows.h>
#endif
#ifdef FND_OS2
#include <os2.h>
#endif
#include <string.h>
#include <stdio.h>
#include <float.h>
#include <limits.h>
#include <stdlib.h>
#include <malloc.h>
#include <ctype.h>
#include <stdarg.h>
#include <time.h>
#include <sys\types.h>
#include <sys\timeb.h>

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


#include "azcs01b.gnb"

#define CMN_ERR_ARCH_WRAP_FUNC FALSE
#define INCL_C1CBASE
#include <c1c.h>

/* JSH: 07/01/93 ADDED */
//#include "explode.h"

/*mdc 11/25/96 azcs01b.gnb includes these headers
#include "csrcmn.h"
#include "mapgen.h"
*/
/*mdc 11/25/96 Added for LogError prototype*/
#include "azcs01.h"

/*mdc this must be included for prototype of BuildVersionNumber*/
#include "version.h" 

#define  DataType_len 15
#define _LITERAL_DATA_TYPES enum LITERAL_DATA_TYPES

/*mdc 12/11/96 Added for Check Occurring groups*/
#define _MESSAGE_LEN  255
#define CMN_MAPGEN_NAME "CSR Map Generator"


USHORT CsrMapInitItem( _ENTITYDATA *pEntityData, _LAYOUT_REC *pLayoutRec,
                       CMN_ARCH_PARM_TYPES );

USHORT CsrMapProcessDataLayout(  _ENTITYDATA *pEntityDataTable,
                                 USHORT      *Offsets,
                                 _LAYOUT_REC *ReposLayout,
                                 USHORT      CurIndex,
                                 USHORT      CurLevel,
                                 USHORT      CurOffset,
                                 USHORT      *pGroupCLength);

USHORT CsrMapProcessElement( _LAYOUT_REC DataElement,
                              USHORT  *pCLength,
              enum LITERAL_DATA_TYPES  *pDataType );



SHORT CsrMapRetrieveLayout( CHAR *EntityId, CHAR ClientLayoutFlag,
                            _LAYOUT_REC **ppLayoutRecTable,
                            USHORT *pNumberRows,
                            double *pVersionNumber,
                            CMN_ARCH_PARM_TYPES )
{

  #define DEST_APPL_ID   1
  #define DEST_SRVC_ID   1
  #define DEST_SRVC_VER  "00"

  USHORT FndGenRC = 0;
  _FND_STANDARD_PB  FndStandardPB;
  _FND_ERROR_BLOCK  FndGenErrorBlock;
  _MSG_PARM_BLOCK   ParmBlock;

  _LAYOUT_REC *pLayoutRecTable;
  USHORT OffsetTable[ MAP_GEN_MAX_LEVELS ];
  USHORT GroupCLength;

  USHORT i;
  USHORT usCounter;
  /* mdc 01-11-96 used by stackavail only stackavail commented out
  size_t stackleft;
  */

  _MESSAGEINPUT  *pMessageInput;
  _MESSAGEOUTPUT *pMessageOutput;

  SHORT ReturnCode = 0;
  CHAR Message[ 255 ];
  /*mdc 04/30/97 Added to satisfy Bounds Checker bad argument error*/
  CHAR MsgBxName[32] = "ReposWait";
  USHORT SelectedButton;

  CHAR MsgBoxText[255];

#ifdef DEBUG
  FILE *fp;
/*  time_t SendTime, RecvTime; */
  struct tm    *pSendTimeStruct;
  struct tm    *pRecvTimeStruct;
  struct timeb SendTimeb;
  struct timeb RecvTimeb;
  double ElapsedTime;
  double Temp;
  short  Temp2;
#endif

  /* CSC: 07/19/93 added */
  /*mdc 11/25/96 Make this conditional on Mass Gen*/
  if (BFCD_pCSRMapBFCD->CsrFLMassGen != CMN_YES)
  {
         FndWindowSetPointer(CBI_hwnd,
                                 FNDSYSPTR_WAIT,
                                 &FndGenErrorBlock);
  }

  /* "\n\nRetrieving Data From The Repository ...\n\n Please be patient.",
                                   "ReposWait"
  */

  strcpy(MsgBoxText, "Retrieving ");
  if( ClientLayoutFlag == MAP_GEN_CLIENT_LAYOUT )
    {
     strcat( MsgBoxText, "Client Layout " );
    }
  else
    {
     strcat( MsgBoxText, "Translation Map " );
    }
  strcat(MsgBoxText, EntityId);
  strcat(MsgBoxText, " \n  from the Design Repository ...");

  /*mdc 11/25/96 Make this conditional on Mass Gen */
  /*mdc 04/30/97 Chamged "ReposWait" to MsgBxName to satisfy BC error*/
  if (BFCD_pCSRMapBFCD->CsrFLMassGen != CMN_YES)
  {

      FndMsgBoxDisplayMdlssText( MsgBoxText,
                                   MsgBxName,
                                   CBI_hwnd,
                                   FND_MSGBOX_NOBUTTONS,
                                   FND_MSGBOX_INFORMATION,
                                   FND_MSGBOX_IDNOBUTTON,
                                   CMN_CSS_APPL_NAME,
                                   &FndGenErrorBlock);
  }
  else
  {
      LogError( MsgBoxText );
  }

  /* CSC: 07/19/93 end added */


  pMessageInput  = malloc( sizeof( _MESSAGEINPUT ));
  pMessageOutput = malloc( sizeof( _MESSAGEOUTPUT ));

  memset(pMessageInput,0,sizeof(_MESSAGEINPUT));
  memset(pMessageOutput,0,sizeof(_MESSAGEOUTPUT));

  memcpy( FndStandardPB.ver, FND_MSG_VER, _VER_LEN );

  /* Set up Request Header */
  if( ClientLayoutFlag == MAP_GEN_CLIENT_LAYOUT )
  {
    strcpy( pMessageInput->RequestHdr.EntityType, "DEGROUP" );
  }
  else
  {
    strcpy( pMessageInput->RequestHdr.EntityType, "DERECORD" );
  }

  strcpy( pMessageInput->RequestHdr.EntityId, EntityId );

  /*
  ** If the EntityId is less than 8 pad it with  spaces
  */
  while (strlen(pMessageInput->RequestHdr.EntityId) < 8)
  {
      usCounter = strlen(pMessageInput->RequestHdr.EntityId);
      (*(pMessageInput->RequestHdr.EntityId + usCounter)) = ' ';
      (*(pMessageInput->RequestHdr.EntityId + usCounter + 1)) = '\0';
  }

  HEAP_CHECK
  pMessageInput->RequestHdr.MaxRows = *pNumberRows;

  /* Initialize Foundation Parm Block */
  MSGInitPB( &FndStandardPB, &ParmBlock, pEAIA, DEST_APPL_ID,
             DEST_SRVC_ID, DEST_SRVC_VER, pABHI );

  memcpy( ParmBlock.commarea.ver, FND_MSG_VER, _VER_LEN );
  ParmBlock.commarea.function_code = MSGIO_CONVERSE;
  ParmBlock.buffer_size = sizeof( _MESSAGEOUTPUT );
  ParmBlock.actual_length_send = sizeof( _REQUESTHDR );
  ParmBlock.timeout_interval = 99;

  memcpy( ParmBlock.translation.map_name, "AZCR001O", _FND_MAP_NAME_LEN );
  memcpy( ParmBlock.translation.map_version, "01", _VER_LEN );

  HEAP_CHECK
  /* mdc - 01-11-96 - stackavail unrecognized function in windows
  stackleft = stackavail();
  */

  FndGenRC = MSGConvUI( &ParmBlock, (_MSG_SEND_AREA) pMessageInput,
                      (_MSG_RECV_AREA) pMessageOutput, pABHI );

#ifdef DEBUG
  ftime( &SendTimeb );
  pSendTimeStruct = localtime( &SendTimeb.time );
#endif
/* mdc 01-11-96 function not recognized restoring MSGConvUI
  FndGenRC = MSGConv( &ParmBlock, (_MSG_SEND_AREA) pMessageInput,
                      (_MSG_RECV_AREA) pMessageOutput, pABHI );
*/

#ifdef DEBUG
  ftime( &RecvTimeb );
  pRecvTimeStruct = localtime( &RecvTimeb.time );

  fp = fopen( "azrp01.inf", "a" );
  Temp = difftime( RecvTimeb.time, SendTimeb.time );

  fprintf( fp, "difftime: %lf\n", Temp );
  fprintf( fp, "difftime*1000: %lf\n", Temp*1000.0 );
  fprintf( fp, "difftime (ms): %lf\n", RecvTimeb.millitm - SendTimeb.millitm );

  Temp2 = RecvTimeb.millitm - SendTimeb.millitm;

  ElapsedTime = Temp*1000.0 + ((DOUBLE) Temp2 );

  fprintf( fp, "difftime (s): %lf\n", ElapsedTime );

  fprintf( fp, "Request for %s %s at %s\n",
/*           ParmBlock.secur.user_id, */
           pMessageInput->RequestHdr.EntityType,
           pMessageInput->RequestHdr.EntityId,
           asctime( pSendTimeStruct ));

  fprintf( fp, "Message sent:   %02d:%02d:%02d.%d\n",
           pSendTimeStruct->tm_hour,
           pSendTimeStruct->tm_min,
           pSendTimeStruct->tm_sec,
           SendTimeb.millitm );

  fprintf( fp, "Reply received: %02d:%02d:%02d.%d\n",
           pRecvTimeStruct->tm_hour,
           pRecvTimeStruct->tm_min,
           pRecvTimeStruct->tm_sec,
           RecvTimeb.millitm );
  fprintf( fp, "Elapsed time: %lf\n", ElapsedTime );
  fprintf( fp, "Rows returned:    %d\n\n",
           pMessageOutput->ReplyHdr.RowsReturned );
  fclose( fp );
#endif

  HEAP_CHECK

  if( FndGenRC == MSGIO_SUCCESS &&
      ParmBlock.appl_status.explan_code == FND_SUCCESS &&
      pMessageOutput->ReplyHdr.RowsReturned < MAX_ROWS_RETURNED)
  {
    /* Allocate space for Layout Record Table */
    *pNumberRows = pMessageOutput->ReplyHdr.RowsReturned;

    /* Check if any rows were returned */
    if( *pNumberRows )
    {
      pLayoutRecTable = (_LAYOUT_REC *)
           malloc( pMessageOutput->ReplyHdr.RowsReturned * sizeof( _LAYOUT_REC ));

      /* Initialize memory */
      memset( pLayoutRecTable, 0,
              pMessageOutput->ReplyHdr.RowsReturned * sizeof( _LAYOUT_REC ));

      for( i=0; i<pMessageOutput->ReplyHdr.RowsReturned; i++ )
      {
        CsrMapInitItem( &(pMessageOutput->EntityData[i]),
                        &(pLayoutRecTable[i]), CMN_ARCH_PARMS );
      }

      HEAP_CHECK

      *ppLayoutRecTable = pLayoutRecTable;

      /* Initialize OffsetTable */
      memset( OffsetTable, 0, sizeof( OffsetTable ));

      CsrMapProcessDataLayout( pMessageOutput->EntityData,
                               OffsetTable,
                               pLayoutRecTable,
                               0,
                               0,
                               0,
                               &GroupCLength );

      HEAP_CHECK

      BuildVersionNumber(pMessageOutput->EntityData,
                         pMessageOutput->ReplyHdr.RowsReturned,
                         pVersionNumber);

	  HEAP_CHECK


    }

    else
    {
      /* No rows were returned */
      /* Check SQL Code */
      switch( pMessageOutput->ReplyHdr.SqlCode )
      {
        case 0:
            sprintf( Message, "No rows were returned by the Repository "
                              "Extract Service.  The SQL Code was %ld.",
                     pMessageOutput->ReplyHdr.SqlCode );
            break;

        default:
            sprintf( Message, "No rows were returned by the Repository "
                              "Extract Service.  The SQL Code was %ld.",
                     pMessageOutput->ReplyHdr.SqlCode );
            break;
      }

      /*mdc 11/25/96 Make display conditional on Mass Gen*/
      if (BFCD_pCSRMapBFCD->CsrFLMassGen != CMN_YES )
      {
        FndMsgBoxDisplayText( Message, NULL, CBI_hwnd, FND_MSGBOX_OK,
                            FND_MSGBOX_CRITICAL, FND_MSGBOX_OK,
                            NULL, &SelectedButton, &FndGenErrorBlock );
      }
      else
      {
          LogError( Message );
      }

      /* Set ReturnCode to indicate error */
      ReturnCode = 1;
    }
  }
  else if (pMessageOutput->ReplyHdr.RowsReturned >= MAX_ROWS_RETURNED)
  {
      sprintf(Message,
             "The requested layout was to large for the Repository Extract Service.\n\n"
             "Please contact the Technical Services Department");

      /*mdc 11/25/96 Make display conditional on Mass Gen */
      if (BFCD_pCSRMapBFCD->CsrFLMassGen != CMN_YES )
      {
        FndMsgBoxDisplayText( Message, NULL, CBI_hwnd, FND_MSGBOX_OK,
                            FND_MSGBOX_CRITICAL, FND_MSGBOX_OK,
                            NULL, &SelectedButton, &FndGenErrorBlock );
      }
      else
      {
          LogError( Message );
      }

      /* Set ReturnCode to indicate error */
       ReturnCode = 1;

    }

  else
  {
    sprintf( Message, "Distribution Services returned an error.  "
                      "The return code from MSGConv is %d.  "
                      "The explanation code is %d.",
             FndGenRC, ParmBlock.appl_status.explan_code );

    /*mdc 11/25/96 Make display conditional on Mass Gen */
    if ( BFCD_pCSRMapBFCD->CsrFLMassGen != CMN_YES )
    {
        FndMsgBoxDisplayText( Message, NULL, CBI_hwnd, FND_MSGBOX_OK,
                          FND_MSGBOX_CRITICAL, FND_MSGBOX_OK,
                          NULL, &SelectedButton, &FndGenErrorBlock );
    }
    else
    {
        LogError( Message );
    }

    /* DS Error occurred */
    ReturnCode = 1;
  }

  /* Free the memory allocated for Message Input and Output */
  free( pMessageInput );
  free( pMessageOutput ); 


/* CSC: 07/19/93 added */

  /*mdc 11/25/96 if the Mass Gen flag was not set then the pointer
                 was not changed.  Not necessary to set it back*/
  if ( BFCD_pCSRMapBFCD->CsrFLMassGen != CMN_YES )
  {
     FndWindowSetPointer(CBI_hwnd,
                                 FNDSYSPTR_ARROW,
                                 &FndGenErrorBlock);


    FndGenRC = FndMsgBoxDestroy(MsgBxName,
                               &FndGenErrorBlock);
  }

   /* CSC: 07/19/93 added */
  return ReturnCode;
}


/***********************************************************************
**
**               CUSTOMER SERVICE SYSTEM CSR FUNCTION
**
**  FUNCTION         :  CsrMapProcessDataLayout
**
**  DESCRIPTION      :  This function fills in the missing data elements
**                      by calling itself or CsrMapProcessElement.
**
**
**  INPUTS           :  _LAYOUT_REC ReposLayout[] : A structure containing
**                                                  records and elements.
**
**                      USHORT  CurIndex  : ReposLayout's subscript.
**
**                      USHORT  CurLevel  : Level of recursion.
**
**                      USHORT  CurOffset : Group Offset.
**
**                      USHORT  *pGroupCLength : Length of Current Group.
**
**
**  OUTPUTS          :  CMN_SUCCESS
**
**  AUTHOR           :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED     :  06/09/93
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**                                         Original Code.
************************************************************************/


USHORT CsrMapProcessDataLayout(  _ENTITYDATA *pEntityDataTable,
                                 USHORT      *Offsets,
                                 _LAYOUT_REC *ReposLayout,
                                 USHORT      CurIndex,
                                 USHORT      CurLevel,
                                 USHORT      CurOffset,
                                 USHORT      *pGroupCLength)
   {
    SHORT Index = 0;
    USHORT CLength = 0;
    _LITERAL_DATA_TYPES DataType = 0;
    USHORT ReturnGroupCLength;
    USHORT FndGenRC = 0;


    /* Traverse ReposLayout and perform calculations */
    *pGroupCLength = 0;

    if (ReposLayout[CurIndex].ItemOccurs > 1)
       {
        Offsets[CurLevel] = 0;
       }
    else
       {
        Offsets[CurLevel] = CurOffset;
       }

    Index = ReposLayout[CurIndex].ChildIndex;

    while (Index != -1)
        {
         if (ReposLayout[Index].ItemType == 'E')
             {

              FndGenRC = CsrMapProcessElement(ReposLayout[Index],
                                       &CLength,
                                       &DataType);
              ReposLayout[Index].ItemOffset = Offsets[CurLevel];

/* JLL: 08/03/93 Deleted following line to handle repeating elements. */
//              ReposLayout[Index].ItemCLength = CLength;
/* JLL: 08/03/93 Modified the following line to handle repeating elements*/
              ReposLayout[Index].ItemCLength = CLength *
                                               ReposLayout[Index].ItemOccurs;
              ReposLayout[Index].DataType = DataType;

              /* JLL: 07/18/93 MODIFIED */
              Offsets[CurLevel] += (CLength *  
                    ReposLayout[Index].ItemOccurs);

              /* JLL: 07/18/93 MODIFIED */
              *pGroupCLength += (CLength * 
                    ReposLayout[Index].ItemOccurs);


             }
         else if (ReposLayout[Index].ItemType == 'G')
             {

               ReturnGroupCLength = 0;

               FndGenRC = CsrMapProcessDataLayout( pEntityDataTable,
                                            Offsets, 
                                            ReposLayout,
                                            Index,
                                            (USHORT)(CurLevel+1),
                                            Offsets[CurLevel],
                                            &ReturnGroupCLength);

              Offsets[CurLevel] += (ReturnGroupCLength *  \
                    ReposLayout[Index].ItemOccurs);

              *pGroupCLength += (ReturnGroupCLength *  \
                    ReposLayout[Index].ItemOccurs);
             }

         Index = ReposLayout[Index].SiblingIndex;
        }

    /* Format the missing values for this group */

    ReposLayout[CurIndex].ItemOffset = CurOffset;

    ReposLayout[CurIndex].ItemCLength = *pGroupCLength;

    return (CMN_SUCCESS);
   }


USHORT CsrMapInitItem( _ENTITYDATA *pEntityData, _LAYOUT_REC *pLayoutRec,
                       CMN_ARCH_PARM_TYPES )
{
  USHORT FndGenRC = 0;
  /*mdc 01-11-96 not used in this function
  _FND_ERROR_BLOCK FndGenErrorBlock;
  */
  SHORT i = 0;

  /* JSH: 07/01/93 ADDED */
  /* Move record from EntityDataTable to ReposLayout */
  /* JSH: 07/29/93 MODIFIED */
  /* strncpy( pLayoutRec->ItemId, pEntityData->EntityId, 9 ); */

  HEAP_CHECK

  while( pEntityData->EntityId[i] != ' ' )
  {
    pLayoutRec->ItemId[i] = pEntityData->EntityId[i];
    i++;
    HEAP_CHECK
  }
  pLayoutRec->ItemId[i] = '\0';

HEAP_CHECK

  /* Can we set EntityType = to the third char of EntityType? */
  if( strcmp( pEntityData->EntityType, "DERECORD" ) == 0 )
  {
    pLayoutRec->ItemType = 'R';
  }
  else if( strncmp( pEntityData->EntityType, "DEGROUP", 7 ) == 0 )
  {
    pLayoutRec->ItemType = 'G';
  }
  else if( strcmp( pEntityData->EntityType, "DEDTELEM" ) == 0 )
  {
    pLayoutRec->ItemType = 'E';
  }

  strncpy( pLayoutRec->ItemCName, pEntityData->EntityCName, C_NAME_LEN );

  strncpy( pLayoutRec->ItemCobolName, pEntityData->EntityCobolName,
           COBOL_NAME_LEN );

  //pLayoutRec->ItemLevel = pEntityData->EntityLevel;
  pLayoutRec->IndentLevel = pEntityData->EntityLevel;

  pLayoutRec->ElementTypeCode = pEntityData->DteTypeCode;

  pLayoutRec->Format = pEntityData->DteIntFormat;

  pLayoutRec->ItemLength = (SHORT) pEntityData->DteIntLength;

  pLayoutRec->Precision = pEntityData->DteIntPrecision;

  //strncpy( pLayoutRec->Usage, pEntityData->DteIntUsage, _USAGE_LEN );
  FndGenRC = CmnStrCopyTrimTrailBlanks( pLayoutRec->Usage,
                                        pEntityData->DteIntUsage,
                                        _USAGE_LEN, CMN_ARCH_PARMS );

  if( pEntityData->RelatOccFact == 0 )
  {
    pLayoutRec->ItemOccurs = 1;
  }
  else
  {
    pLayoutRec->ItemOccurs = (SHORT) pEntityData->RelatOccFact;
  }

  pLayoutRec->ChildIndex = pEntityData->EntityChild;

  pLayoutRec->ParentIndex = pEntityData->EntityParent;

  pLayoutRec->SiblingIndex = pEntityData->EntitySibling;

  return CMN_SUCCESS;
}


/***********************************************************************
**
**               CUSTOMER SERVICE SYSTEM CSR FUNCTION
**
**  FUNCTION         :  CsrMapProcessElement
**
**  DESCRIPTION      :  This function fills in the missing data elements
**                      by lookups on the EltTypeTable.
**
**
**  INPUTS           :  _LAYOUT_REC DataElement : The current element
**                                                  being processed.
**
**                      USHORT  *pCLength       : The C Length being returned.
**
**                      LITERAL_DATA_TYPES *pDataType : The Data Type
**                                                      being returned.
**
**
**
**  OUTPUTS          :  pCLength, pDataType
**
**  AUTHOR           :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED     :  06/09/93
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**                                         Original Code.
**  09/13/94    CCRAMPTON         427      Add CSR_POINTER.
**  08/03/96    CWOODS                     Discovery Release:  The INT3DATE
**										   data type generated incorrectly.
**										   Added a row to the table for
**										   a 'DT' usage to generate as
**										   alpha 11.
************************************************************************/

USHORT CsrMapProcessElement( _LAYOUT_REC DataElement,
                              USHORT  *pCLength,
                 _LITERAL_DATA_TYPES  *pDataType )
   {

/* Resolve the difference between NT and non-NT strings, they have different C Lengths */

    USHORT i;

    typedef struct _ELEMENT_TYPE
    {
        CHAR  Code;
        CHAR  Format;
        CHAR  Usage[3];
        SHORT MinLength;
        SHORT MaxLength;
        SHORT MinPrecision;
        SHORT MaxPrecision;
        _LITERAL_DATA_TYPES DataType;
        SHORT CLength;
     } _ELEMENT_TYPE;


    _ELEMENT_TYPE EltTypeTable[] = {


/* Code: Fmt: Usage:  Lengths:   Precision:  DType:       CLength:         */
/* ----- ---- ------  ---------  ----------  ----------   --------         */
   't', 'A',  ""   ,   1 ,   1 ,  -1 ,  -1 , CSR_STRING  ,   1 , /* char   */
   '\0', 'A', ""   ,   1 ,  -1 ,  -1 ,  -1 , CSR_STRING  ,  -1 , /* char[] */
//   '\0', 'A', ""   ,   1 ,  -1 ,  -1 ,  -1 , CSR_STRING  ,  -1 , /* char[] */
//   '\0', 'A', ""   ,   1 ,  -1 ,  -1 ,  -1 , CSR_STRING  ,  -1 , /* char[] */

   'A', 'N',  "DS" ,   1 ,   1 ,   0 ,   0 , CSR_STRING  ,   1 , /* char   */
   'A', 'N',  "DS" ,   2 ,   4 ,   0 ,   0 , CSR_SHORT   ,   2 , /* short  */
   'A', 'N',  "DS" ,   5 ,   9 ,   0 ,   0 , CSR_LONG    ,   4 , /* long   */
   'A', 'N',  "DS" ,  10 ,  14 ,   0 ,   0 , CSR_DOUBLE  ,   8 , /* double */
   'A', 'N',  "DS" ,   1 ,   7 ,   1 ,  -1 , CSR_FLOAT   ,   4 , /* float  */
   'A', 'N',  "DS" ,   8 ,  14 ,   1 ,  -1 , CSR_DOUBLE  ,   8 , /* double */
   'A', 'N',  "DS" ,  14 ,  -1 ,  -1 ,  -1 , CSR_LONG_DBL,  10 , /* longdbl*/

   'A', 'N',  "D"  ,   1 ,   1 ,   0 ,   0 , CSR_STRING  ,   1 , /* uchar  */
   'A', 'N',  "D"  ,   2 ,   4 ,   0 ,   0 , CSR_SHORT   ,   2 , /* ushort */
   'A', 'N',  "D"  ,   5 ,   9 ,   0 ,   0 , CSR_LONG    ,   4 , /* ulong  */
   'A', 'N',  "D"  ,  10 ,  14 ,   0 ,   0 , CSR_DOUBLE  ,   8 , /* double */
   'A', 'N',  "D"  ,   1 ,   7 ,   1 ,  -1 , CSR_FLOAT   ,   4 , /* float  */
   'A', 'N',  "D"  ,   8 ,  14 ,   1 ,  -1 , CSR_DOUBLE  ,   8 , /* double */
   'A', 'N',  "D"  ,  14 ,  -1 ,  -1 ,  -1 , CSR_LONG_DBL,  10 , /* longdbl*/

   /* CWOODS 08/03/96:  Numeric Date Type generate as alpha 11 - This fixes
      the INT3DATE Discovery problem */
   'A', 'N',  "DT" ,  10 ,  10 ,   0 ,   0 , CSR_STRING  ,   11 , /* uchar  */


   'A', 'N',  "C"  ,   1 ,   1 ,   0 ,   0 , CSR_UCHAR   ,   1 , /* char   */
   'A', 'N',  "C"  ,   2 ,   4 ,   0 ,   0 , CSR_USHORT  ,   2 , /* short  */
   'A', 'N',  "C"  ,   5 ,   9 ,   0 ,   0 , CSR_ULONG   ,   4 , /* long   */
   'A', 'N',  "C"  ,  10 ,  14 ,   0 ,   0 , CSR_DOUBLE  ,   8 , /* double */
   'A', 'N',  "C"  ,   1 ,   7 ,   1 ,  -1 , CSR_FLOAT   ,   4 , /* float  */
   'A', 'N',  "C"  ,   8 ,  14 ,   1 ,  -1 , CSR_DOUBLE  ,   8 , /* double */
   'A', 'N',  "C"  ,  14 ,  -1 ,  -1 ,  -1 , CSR_LONG_DBL,  10 , /* longdbl*/

   'A', 'N',  "C3" ,   1 ,   1 ,   0 ,   0 , CSR_BYTE    ,   1 , /* char   */
   'A', 'N',  "C3" ,   2 ,   4 ,   0 ,   0 , CSR_SHORT   ,   2 , /* short  */
   'A', 'N',  "C3" ,   5 ,   9 ,   0 ,   0 , CSR_LONG    ,   4 , /* long   */
   'A', 'N',  "C3" ,  10 ,  14 ,   0 ,   0 , CSR_DOUBLE  ,   8 , /* double */
   'A', 'N',  "C3" ,   1 ,   7 ,   1 ,  -1 , CSR_FLOAT   ,   4 , /* float  */
   'A', 'N',  "C3" ,   8 ,  14 ,   1 ,  -1 , CSR_DOUBLE  ,   8 , /* double */
   'A', 'N',  "C3" ,  14 ,  -1 ,  -1 ,  -1 , CSR_LONG_DBL,  10 , /* longdbl*/

   'A', 'N',  "FL" ,  -1 ,  -1 ,  -1 ,  -1 , CSR_FLOAT   ,   4 , /* float  */

   'A', 'N',  "F1" ,  -1 ,  -1 ,  -1 ,  -1 , CSR_FLOAT   ,   4 , /* float  */

   'A', 'N',  "F2" ,  -1 ,  -1 ,  -1 ,  -1 , CSR_DOUBLE  ,   8 , /* double */

   '\0', '\0', "P" ,   4 ,  4  ,  0  ,  0  , CSR_POINTER  ,  4 , /* pointer */
	
   /*mdc 02/05/97 Added pointer data type for graphic */
   'A',  'N',  "P" ,   4 ,  4  ,  0  ,  0  , CSR_POINTER  ,  4 , /* pointer */

  };

    USHORT MaxEltTypeEntries = sizeof(EltTypeTable)/sizeof(_ELEMENT_TYPE);


    for (i=0; i < MaxEltTypeEntries; i++)
        {
         /* Move onto next iteration if Formats don't match */
         if ((DataElement.Format) != (EltTypeTable[i].Format))
            {
             continue;
            }

         /* Move onto next iteration if Codes don't match */
         if ((DataElement.Format == 'A') &&
             (EltTypeTable[i].Code != '\0' ))
            {
               if( DataElement.ElementTypeCode != EltTypeTable[i].Code)
                 {
                  continue;
                 }
            }

         /* Move onto next iteration if Usages don't match */
         //if (strcmp(DataElement.Usage, EltTypeTable[i].Usage))
         if (( DataElement.Format != 'A' ) &&
             ( strcmp(DataElement.Usage, EltTypeTable[i].Usage)))
            {
             continue;
            }

         /* Start Next iteration if Item Length is less than Minimum */
         if ((EltTypeTable[i].MinLength != -1) &&
                (DataElement.ItemLength < EltTypeTable[i].MinLength))
            {
             continue;
            }

         /* Start Next iteration if Item Length exceeds Maximum */
         if ((EltTypeTable[i].MaxLength != -1) &&
                (DataElement.ItemLength > EltTypeTable[i].MaxLength))
            {
             continue;
            }

         /* Start Next iteration if Precision is less than Minimum */
         if ((EltTypeTable[i].MinPrecision != -1) &&
                (DataElement.Precision < EltTypeTable[i].MinPrecision))
            {
             continue;
            }

         /* Start Next iteration if Precision exceeds Maximum */
         if ((EltTypeTable[i].MaxPrecision != -1) &&
                (DataElement.Precision > EltTypeTable[i].MaxPrecision))
            {
             continue;
            }

         /* Only arrive here if all tests have been satisfied */
         *pDataType = EltTypeTable[i].DataType;

         if (EltTypeTable[i].CLength == -1)
            {
             *pCLength = (DataElement.ItemLength + 1);
            }
         else
            {
             *pCLength = EltTypeTable[i].CLength;
            }
         return (CMN_SUCCESS);

        }

   }


//_LAYOUT_REC TestLayout[] =
//{
//  /*
//  ID Itype  Names  Code Fmt IL Prec Usge IO  DT   ILv  IO  ICL  CSP Indexs
//  -- ----- ------  ---- --- --  --- ---- --  --   --  --  ---  --------- */
//  "R0000001", 'R', "R0000001", "R0000001", ' ', ' ',  2,  2,   "",  1, CSR_LONG,  0,  0,  0,  1, -1, 0,
//  "G0000001", 'G', "G0000001", "G0000001", ' ', ' ',  1,  1,   "",  1, CSR_LONG,  1,  0,  0,  2, 12, 0,
//  "E0000001", 'E', "E0000001", "E0000001", 't', 'A',  1, -1,   "",  1, CSR_LONG,  2,  0,  0, -1,  3, 0,
//  "E0000002", 'E', "E0000002", "E0000002", 'A', 'A',  1, -1,   "",  1, CSR_LONG,  3,  0,  0, -1,  4, 0,
//  "G0000002", 'G', "G0000002", "G0000002", 'A', ' ',  0,  0,   "",  2, CSR_LONG,  4,  0,  0,  5,  9, 0,
//  "E0000003", 'E', "E0000003", "E0000003", 'A', 'A',  3, -1,   "",  2, CSR_LONG,  5,  0,  0, -1,  6, 0,
//  "G0000003", 'G', "G0000003", "G0000003", 't', ' ',  0,  0,   "",  3, CSR_LONG,  6,  0,  0,  7, -1, 0,
//  "E0000004", 'E', "E0000004", "E0000004", 't', 'N',  1,  0, "DS",  3, CSR_LONG,  7,  0,  0, -1,  8, 0,
//  "E0000005", 'E', "E0000005", "E0000005", 't', 'N',  3,  0, "DS",  3, CSR_LONG,  8,  0,  0, -1, -1, 0,
//  "G0000004", 'G', "G0000004", "G0000004", 't', ' ',  0,  0,   "",  2, CSR_LONG,  9,  0,  0, 10, -1, 0,
//  "E0000006", 'E', "E0000006", "E0000006", 't', 'N',  5,  0, "DS",  2, CSR_LONG, 10,  0,  0, -1, 11, 0,
//  "E0000007", 'E', "E0000007", "E0000007", 't', 'N', 14,  0, "DS",  2, CSR_LONG, 11,  0,  0, -1, -1, 0,
//  "G0000005", 'G', "G0000005", "G0000005", 't', ' ',  0,  0,   "",  2, CSR_LONG, 12,  0,  0, 13, 16, 0,
//  "E0000008", 'E', "E0000008", "E0000008", 't', 'N',  7,  3, "DS",  2, CSR_LONG, 13,  0,  0, -1, 14, 0,
//  "G0000006", 'G', "G0000006", "G0000006", 't', ' ',  0,  0,   "",  1, CSR_LONG, 14,  0,  0, 15, -1, 0,
//  "E0000009", 'E', "E0000009", "E0000009", 't', 'N',  8,  1, "DS",  1, CSR_LONG, 15,  0,  0, -1, -1, 0,
//  "E0000010", 'E', "E0000010", "E0000010", 't', 'N', 17, -1, "DS",  1, CSR_LONG, 16,  0,  0, -1, 17, 0,
//  "E0000011", 'E', "E0000011", "E0000011", 't', 'N',  1,  0,  "D",  1, CSR_LONG, 17,  0,  0, -1, 18, 0,
//  "E0000012", 'E', "E0000012", "E0000012", 't', 'N',  4,  0,  "D",  1, CSR_LONG, 18,  0,  0, -1, 19, 0,
//  "G0000007", 'G', "G0000007", "G0000007", 't', ' ',  0,  0,   "",  2, CSR_LONG, 19,  0,  0, 20, 21, 0,
//  "E0000013", 'E', "E0000013", "E0000013", 't', 'N',  6,  0,  "D",  2, CSR_LONG, 20,  0,  0, -1, -1, 0,
//  "G0000008", 'G', "G0000008", "G0000008", 't', ' ',  0,  0,   "",  1, CSR_LONG, 21,  0,  0, 22, 25, 0,
//  "E0000014", 'E', "E0000014", "E0000014", 't', 'N', 10,  0,  "D",  1, CSR_LONG, 22,  0,  0, -1, 23, 0,
//  "E0000015", 'E', "E0000015", "E0000015", 't', 'N',  1,  6,  "D",  1, CSR_LONG, 23,  0,  0, -1, 24, 0,
//  "E0000016", 'E', "E0000016", "E0000016", 't', 'N', 14,  5,  "D",  1, CSR_LONG, 24,  0,  0, -1, -1, 0,
//  "G0000009", 'G', "G0000009", "G0000009", 't', ' ',  0,  0,   "",  1, CSR_LONG, 25,  0,  0, 26, 28, 0,
//  "E0000017", 'E', "E0000017", "E0000017", 't', 'N', 15, -1,  "D",  1, CSR_LONG, 26,  0,  0, -1, 27, 0,
//  "E0000018", 'E', "E0000018", "E0000018", 't', 'N',  1,  0,  "C",  1, CSR_LONG, 27,  0,  0, -1, -1, 0,
//  "G0000010", 'G', "G0000010", "G0000010", 't', ' ',  0,  0,   "",  2, CSR_LONG, 28,  0,  0, 29, 33, 0,
//  "E0000019", 'E', "E0000019", "E0000019", 't', 'N',  2,  0,  "C",  2, CSR_LONG, 29,  0,  0, -1, 30, 0,
//  "E0000020", 'E', "E0000020", "E0000020", 't', 'N',  9,  0,  "C",  2, CSR_LONG, 30,  0,  0, -1, 31, 0,
//  "E0000021", 'E', "E0000021", "E0000021", 't', 'N', 10,  0,  "C",  2, CSR_LONG, 31,  0,  0, -1, 32, 0,
//  "E0000022", 'E', "E0000022", "E0000022", 't', 'N',  7,  2,  "C",  2, CSR_LONG, 32,  0,  0, -1, -1, 0,
//  "E0000023", 'E', "E0000023", "E0000023", 't', 'N',  8,  1,  "C",  1, CSR_LONG, 33,  0,  0, -1, 34, 0,
//  "E0000024", 'E', "E0000024", "E0000024", 't', 'N', 15, -1,  "C",  1, CSR_LONG, 34,  0,  0, -1, 35, 0,
//  "G0000011", 'G', "G0000011", "G0000011", 't', ' ',  0,  0,   "",  2, CSR_LONG, 35,  0,  0, 36, 45, 0,
//  "E0000025", 'E', "E0000025", "E0000025", 't', 'N',  1,  0, "C3",  2, CSR_LONG, 36,  0,  0, -1, 37, 0,
//  "G0000012", 'G', "G0000012", "G0000012", 't', ' ',  0,  0,   "",  1, CSR_LONG, 37,  0,  0, 38, 43, 0,
//  "E0000026", 'E', "E0000026", "E0000026", 't', 'N',  2,  0, "C3",  1, CSR_LONG, 38,  0,  0, -1, 39, 0,
//  "G0000013", 'G', "G0000013", "G0000013", 't', ' ',  0,  0,   "",  1, CSR_LONG, 39,  0,  0, 40, 41, 0,
//  "E0000027", 'E', "E0000027", "E0000027", 't', 'N',  5,  0, "C3",  1, CSR_LONG, 40,  0,  0, -1, -1, 0,
//  "G0000014", 'G', "G0000014", "G0000014", 't', ' ',  0,  0,   "",  1, CSR_LONG, 41,  0,  0, 42, -1, 0,
//  "E0000028", 'E', "E0000028", "E0000028", 't', 'N', 14,  0, "C3",  1, CSR_LONG, 42,  0,  0, -1, -1, 0,
//  "G0000015", 'G', "G0000015", "G0000015", 't', ' ',  0,  0,   "",  1, CSR_LONG, 43,  0,  0, 44, -1, 0,
//  "E0000029", 'E', "E0000029", "E0000029", 't', 'N',  1,  3, "C3",  1, CSR_LONG, 44,  0,  0, -1, -1, 0,
//  "G0000016", 'G', "G0000016", "G0000016", 't', ' ',  0,  0,   "",  2, CSR_LONG, 45,  0,  0, 46, 47, 0,
//  "E0000030", 'E', "E0000030", "E0000030", 't', 'N',  8,  5, "C3",  2, CSR_LONG, 46,  0,  0, -1, -1, 0,
//  "E0000031", 'E', "E0000031", "E0000031", 't', 'N', 20, -1, "C3",  1, CSR_LONG, 47,  0,  0, -1, 48, 0,
//  "E0000032", 'E', "E0000032", "E0000032", 't', 'N', -1, -1, "FL",  1, CSR_LONG, 48,  0,  0, -1, 49, 0,
//  "E0000033", 'E', "E0000033", "E0000033", 't', 'N', -1, -1, "F2",  1, CSR_LONG, 49,  0,  0, -1, 50, 0,
//};


/***********************************************************************
**
**               CUSTOMER SERVICE SYSTEM CSR FUNCTION
**
**  FUNCTION         :  CheckOccurGrps
**
**  DESCRIPTION      :  Checks for valid occurring groups mapping
**
**  INPUTS           :  CMN_ARCH_PARM_TYPES
**
**  OUTPUTS          :  CMN_SUCCESS, CMN_FAIL
**
**  AUTHOR           :  ANDERSEN CONSULTING 
**
**  DATE CREATED     :  12/10/96
**
**  REVISION HISTORY
**
**  DATE        REVISED BY      SIR #      DESCRIPTION OF CHANGE
**  --------    ----------      -----      ---------------------
**
*****************************************************************************/
USHORT CheckOccurGrps( CMN_ARCH_PARM_TYPES )
{
    SHORT i;
    SHORT j;
    USHORT FndGenRC;


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

         FndGenRC = CheckServiceRPMH( BFCD_pCSRMapBFCD->ServiceInfoTable[i].pReposServiceLayoutTable,
                                      BFCD_pCSRMapBFCD->ClientInfo.pReposClientLayoutTable,
                                      i,
                                      BFCD_pCSRMapBFCD->ServiceInfoTable[i].pRepeatingMaps,
                                      CMN_ARCH_PARMS);

         if ( FndGenRC != CMN_SUCCESS )
         {
             return( CMN_FAIL );
         }

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
                  FndGenRC = CheckServiceRPMH( BFCD_pCSRMapBFCD->ServiceInfoTable[j].pReposServiceLayoutTable,
                                               BFCD_pCSRMapBFCD->ClientInfo.pReposClientLayoutTable,
                                               j,
                                               BFCD_pCSRMapBFCD->ServiceInfoTable[j].pRepeatingMaps,
                                               CMN_ARCH_PARMS);

                  if (FndGenRC != CMN_SUCCESS )
                  {
                      return ( CMN_FAIL );
                  }
                  break;
                } /* end of 3rd if */

             } /* end of inner for loop */

         } /* end of 2nd if */

      } /* end of 1st if */

    } /* end of outer for loop */

    return( CMN_SUCCESS );

}/*end of CheckOccurGrps */

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  CheckServiceRPMH
**
**  DESCRIPTION   :  Verifies repeating map header info.
**
**  INPUTS        :  _LAYOUT_REC  ServiceLayout[]
**                   _LAYOUT_REC  ClientLayout[]
**                   USHORT CurIndex
**                   _RELATE_RPMH RPMH[]

**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  12/10/96
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**
******************************************************************/
USHORT CheckServiceRPMH( _LAYOUT_REC  ServiceLayout[],
                 _LAYOUT_REC  ClientLayout[], 
                  USHORT      CurIndex,
                 _RELATE_RPMH RPMH[],
                 CMN_ARCH_PARM_TYPES)

{
    SHORT Index = 0;
    USHORT FndGenRC;

    Index = ServiceLayout[CurIndex].ChildIndex;

    while (Index != -1)
    {
         if ((RPMH != NULL ) &&
             (ServiceLayout[Index].ItemType == 'G') &&
             (ServiceLayout[Index].ItemOccurs > 1))
         {
              FndGenRC = CheckRPMH(ServiceLayout,
                                   ClientLayout,
                                   Index,
                                   RPMH,
                                   CMN_ARCH_PARMS);

              if (FndGenRC != CMN_SUCCESS )
              {
                  return( CMN_FAIL );
              }
         }
         else if (ServiceLayout[Index].ItemType == 'G')
         {
              FndGenRC = CheckServiceRPMH(ServiceLayout,
                                       ClientLayout,
                                       Index,
                                       RPMH,
                                       CMN_ARCH_PARMS);

              if (FndGenRC != CMN_SUCCESS )
              {
                  return( CMN_FAIL );
              }
         }

         Index = ServiceLayout[Index].SiblingIndex;
    }

    return( CMN_SUCCESS );

} /* end of CheckServiceRPMH */

/*****************************************************************
**
**       CUSTOMER SERVICE SYTEM CSR MAP GENERATOR FUNCTION
**
**  FUNCTION      :  CheckRPMH
**
**  DESCRIPTION   :
**
**  INPUTS        :
**
**  OUTPUTS       :  CMN_SUCCESS
**
**  AUTHOR        :  ANDERSEN CONSULTING & FLORIDA POWER CORP.
**
**  DATE CREATED  :  12/10/96
**
**  REVISION HISTORY
**
**    DATE        REVISED BY     SIR #     DESCRIPTION OF CHANGE
**  --------      ----------     -----     ---------------------
**
******************************************************************/

USHORT CheckRPMH( _LAYOUT_REC  ServiceLayout[],
                             _LAYOUT_REC  ClientLayout[],
                              USHORT      CurIndex,
                             _RELATE_RPMH RPMH[],
                             CMN_ARCH_PARM_TYPES)
{

    USHORT usSelectedButton, FndGenRC, usIcon;
    CHAR sMessage[_MESSAGE_LEN];
    _FND_ERROR_BLOCK FndGenErrorBlock;


    GlobalNestedLevel++;
    

    memset( sMessage, 0, _MESSAGE_LEN );

    if (( RPMH[CurIndex].ClientLayoutIndex == -1) &&
        ( RPMH[CurIndex].SingleOccurence == 'N' ))
    {
        sprintf( sMessage, "Occurring Groups not valid!\n"
                 "You MUST remap Occurring Groups before generating!\n"
                 "Generation terminating!\n\n");

        if( BFCD_pCSRMapBFCD->CsrFLMassGen != CMN_YES )
        {
            /*Notify users*/
            FndGenRC = FndMsgBoxDisplayText( sMessage,
                                      NULL,
                                      CBI_hwnd,
                                      FND_MSGBOX_OK,
                                      FND_MSGBOX_ERROR,
                                      FND_MSGBOX_IDYES,
                                      CMN_MAPGEN_NAME,
                                      &usSelectedButton,
                                      &FndGenErrorBlock);

            /*rest the task list to not complete*/
            pBFCD->pCSRMapBFCD->RPMHTaskListComplete = 'N';

            /*TaskListCdStatusIconicData[TL_RM_ROW_NUM] =
                                       CMN_LBROW_STATUS_AVAILABLE;
            */
            usIcon = CMN_LBROW_STATUS_AVAILABLE;
            FndLstBoxCellSetData( CBI_hwnd,
                                  CMN_LB_TLB_CONTROL_NAME,
                                  TL_RM_ROW_NUM,
                                  0,
                                  sizeof(SHORT),
                                  (void *) &usIcon,
                                  &FndGenErrorBlock);


            FndLstBoxRowSetAttr( CBI_hwnd,
                                CMN_LB_TLB_CONTROL_NAME,
                                TL_RM_ROW_NUM,
                                AT_REQUIRED,
                                &FndGenErrorBlock );
        }
        else
        {
            LogError( sMessage );
        }


        return( CMN_FAIL );
    }

    FndGenRC = CheckServiceRPMH(ServiceLayout,
                             ClientLayout,
                             CurIndex,
                             RPMH,
                             CMN_ARCH_PARMS);

    if (FndGenRC != CMN_SUCCESS )
    {
        return( CMN_FAIL );
    }

    GlobalNestedLevel--;
    
    return( CMN_SUCCESS );

}  /*end of CheckRPMH */
