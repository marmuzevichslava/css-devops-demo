/*************************************************************************
**
**		AZDI0201.C - Get Burst Information
**
*************************************************************************/

#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "AZDI02.H"

/* FOUNDATION # Defines for Include File Support */
#define  FND_MS_INCL
#define  FND_FE_INCL
#define  FND_IM_INCL
#define  FND_EH_INCL
#define  FND_PS_INCL
#define  FND_CF_INCL
#define  FND_CT_INCL
#define  FND_ST_INCL
#define  FND_VERSION2

/* Main FOUNDATION # Include File */
#include <kglxk000.h>

#define ENVIRON_LEN 2

typedef struct
{
  unsigned short burst_number;
  unsigned short burst_delay;
  unsigned short group_delay;
  unsigned short message_length;
  unsigned long appl;
  unsigned short nbr_iterations;
  unsigned short translation;
  unsigned char  environ[ENVIRON_LEN];
} _PARAMETERS;

typedef struct
{
  unsigned char   char1[80];
  unsigned short  short1[8];
  unsigned short  short2[8];
  unsigned long   long1[8];
  unsigned long   long2[7];
  float      float1[7];
  double   double1[7];
} _MESSAGE_TYPE;


#define UNIX_APPL_ID 989
#define CICS_APPL_ID 987

#define BURST_TIMEOUT_LEN 30

SHORT SendBurstMsg( _BURST_HDR *pBurstHdr, _APPL Appl );

SHORT GetBurstInfo( _BURST_HDR *pBurstHdr )
{
  SHORT rc;

  /* Send Burst Messages */
  if( !rc )
  {
    pBurstHdr->CmnHdrInfo.DtlCount = 0;

    rc = SendBurstMsg( pBurstHdr, UNIX_APPL_ID );
    strcpy( pBurstHdr->BurstDtl[pBurstHdr->CmnHdrInfo.DtlCount++].Platform,
	        "UNIX" );

    rc = SendBurstMsg( pBurstHdr, CICS_APPL_ID );
    strcpy( pBurstHdr->BurstDtl[pBurstHdr->CmnHdrInfo.DtlCount++].Platform,
	        "CICS" );
  }

  return 0;
}


SHORT SendBurstMsg( _BURST_HDR *pBurstHdr, _APPL Appl )
{
  _MESSAGE_TYPE   SendDataBlock;
  _MESSAGE_TYPE   RecvDataBlock;
  _ABHI ABHI;
  _MSG_PARM_BLOCK ParmBlock;
  USHORT j, k, m, n, p, q;
  USHORT rc;

  /* Initialize Parm Block */
  memset( &ParmBlock, 0, sizeof( _MSG_PARM_BLOCK ));
  memcpy( ParmBlock.commarea.ver, FND_MSG_VER, _VER_LEN);
  rc = MSGInit( &ParmBlock, &ABHI );

  /* Populate Parm Block */
  ParmBlock.commarea.function_code = MSGIO_SEND;
  ParmBlock.actual_length_send = sizeof( _MESSAGE_TYPE );
  ParmBlock.buffer_size = sizeof( _MESSAGE_TYPE );
  ParmBlock.src.language = FND_LANGUAGE_C;
  ParmBlock.dest.service_id.appl = Appl;
  ParmBlock.dest.service_id.srvc = 1;
  memcpy( ParmBlock.dest.service_id.service_ver, "01", 2);
  ParmBlock.request_or_reply = FND_REQUEST_MSG_FLG;
  ParmBlock.reply_requested = MSGIO_REPLY_REQUESTED_YES;
  memcpy( ParmBlock.environ, "D1", ENVIRON_LEN);
  ParmBlock.timeout_interval = BURST_TIMEOUT_LEN;
  ParmBlock.priority = MSGIO_PRIORITY_MEDIUM;

  /* Use translation map BURST2 */
  memcpy( ParmBlock.translation.map_name, "BURST2  ", 8);
  memcpy( ParmBlock.translation.map_version, "01", 2);

  /* Populate userid/password */
  memcpy( ParmBlock.secur.user_id, "USERID  ", 8);
  memcpy( ParmBlock.secur.user_pw, "PASSWORD", 8);

  /* Populate Data Block */
  memset( SendDataBlock.char1, 'a', 80 );
  SendDataBlock.char1[0] = 'Y'; /* Translation is ON */
    for (j = 0; j < 8; j++)
      SendDataBlock.short1[j] = j;
    for (k = 0; k < 8; k++)
      SendDataBlock.short2[k] = (k + 10);
    for (m = 0; m < 8; m++)
      SendDataBlock.long1[m] = m + 1000; 
    for (n = 0; n < 7; n++)
      SendDataBlock.long2[n] = n + 1000;
    for (p = 0; p < 7; p++)
      SendDataBlock.float1[p] = (p + 100.0) / 10.0;
    for (q = 0; q < 7; q++)
      SendDataBlock.double1[q] = (q + 1000) / 10;

  rc = MSGConvUI( &ParmBlock, (CHAR *) &SendDataBlock, (CHAR *) &RecvDataBlock, &ABHI );

  /* Set results */
  pBurstHdr->BurstDtl[pBurstHdr->CmnHdrInfo.DtlCount].MsgConvRc  = rc;
  pBurstHdr->BurstDtl[pBurstHdr->CmnHdrInfo.DtlCount].ApplSeverity   = 
      ParmBlock.appl_status.severity;
  pBurstHdr->BurstDtl[pBurstHdr->CmnHdrInfo.DtlCount].ApplExplanCode =
      ParmBlock.appl_status.explan_code;
  pBurstHdr->BurstDtl[pBurstHdr->CmnHdrInfo.DtlCount].CommSeverity   = 
      ParmBlock.commarea.status.severity;
  pBurstHdr->BurstDtl[pBurstHdr->CmnHdrInfo.DtlCount].CommExplanCode =
      ParmBlock.commarea.status.explan_code;

/*
   if ((usRetCode) || (pb->appl_status.severity))
   {
    fprintf(fp, "     : MSGRecv failure (return code = %d, application return code = %d)\n",
      usRetCode,  ParmBlock.appl_status.explan_code);
    exit(1);
  }
  else
  {
    // ERROR: MSGInit failed
  }
*/

  rc = MSGShut( &ParmBlock, &ABHI );

  return 0;
}


struct _SEVERITY
{
  SHORT Code;
  CHAR *Decode;
} SeverityTable =
  {
    FND_SUCCESS, "SUCCESS"
  };

SHORT RptBurstInfo( HANDLE hOut, _BURST_HDR *pBurstHdr )
{
  CHAR szOut[255];
  //CHAR Severity[32];
  //CHAR ExplainCode[32];
  SHORT i;

  Report( hOut, "\n*** BURST INFORMATION ***\n\n" );

  for( i=0; i<2; i++ )
  {
	if( pBurstHdr->BurstDtl[i].MsgConvRc == MSGIO_SUCCESS )
	{
	  /* MSGConvUI succeeded */
      sprintf( szOut, "  Burst to %s returned %d.  Severity: %d.  Explain Code: %d\n",
	           pBurstHdr->BurstDtl[i].Platform,
	           pBurstHdr->BurstDtl[i].MsgConvRc,
	           pBurstHdr->BurstDtl[i].ApplSeverity,
	           pBurstHdr->BurstDtl[i].ApplExplanCode );
	}
	else
	{
	  /* MSGConvUI failed */
      sprintf( szOut, "  Burst to %s returned %d.  Severity: %d.  Explain Code: %d\n",
	           pBurstHdr->BurstDtl[i].Platform,
	           pBurstHdr->BurstDtl[i].MsgConvRc,
	           pBurstHdr->BurstDtl[i].CommSeverity,
	           pBurstHdr->BurstDtl[i].CommExplanCode );
	}

    Report( hOut, szOut );
  }

  return 0;
}

