#include "azgsstub.h"

/***/
#include <sys/timeb.h>

FILE *pFile = NULL;

VOID LogTime( char *Event, struct _timeb StartTime, struct _timeb EndTime )
{
	char ElapsedTime[15] = "";
	pFile = fopen( "c:\\azgs\\weblog.txt", "a+" );
	fseek( pFile, 0L, SEEK_END );

	sprintf( ElapsedTime, "%.3f", (( EndTime.time	+ 
		                           ( EndTime.millitm * .001 )) -
					               ( StartTime.time + 
								   ( StartTime.millitm * .001 ))));

	fprintf( pFile, "%s%s", ElapsedTime, Event );	

	fclose( pFile );

	return;
}

/***/

int displaymsg ()
{
	printf( "\nAZGSSTUB: invalid parameter(s) \n" );
	printf( "USAGE:    webstub -<value type><value> ...\n" );
	printf( "EXAMPLE:  webstub -i1 -v2 -r10 -dKyBa=0657580001 \n\n" );
	printf( "<value types> \n" );
	printf( " d - pipe data (account number) \n" );
	printf( " h - host name. default = 'c1proxyhost'\n" );
	printf( " i - transaction id \n" );
	printf( " r - repeat x time\n" );
	printf( " s - service name. default = 'c1proxy'\n" );
	printf( " v - transaction version \n\n" );

	return (0);
}


int main( int argc, char *argv[] )
{
	int				i = 0, j = 0;
	int				Repeat = 1;
	short			rc = 0;
	long			DataLen = 0;
	long			TxID = 0;
	long			TxVersion = 0;
	char			PipeName[40] = "";
	char			HostName[15] = "";
	char			ServiceName[15] = "";
	char			InData[200] = "";
	char			*pOutData = NULL;
	PIPE_HANDLE		hPipe;
	MESSAGE_HDR		MsgHeader;

/****/
//struct _timeb StartTime, EndTime;
/***/

	memset( &hPipe, 0, sizeof( PIPE_HANDLE ));
	memset( &MsgHeader, 0, sizeof( MESSAGE_HDR ));
	
	if( argc > 1 )
	{	
		if ( argv[1][0] == '/' && argv[1][1] == '?')
		{
			/* show help message */
			displaymsg();
		}
		else
		{
			for ( i = 1; i <= (argc - 1); ++i )
			{
				switch( (int) (argv[i][0]) )
				{
					case '-':
						/* switch on option type */
						switch( (int) ( argv[i][1]) )
						{
							/* pipe data */
							case 'd':
								strcpy( InData, &argv[i][2] );
								MsgHeader.DataLen = 1 + strlen( InData );
								break;

							/* host name */
							case 'h':
								strcpy( HostName, &argv[i][2] );
								break;

							/* transaction id */
							case 'i':
								MsgHeader.TxID = atol( &argv[i][2] );
								break;
								
							/* repeat x times */
							case 'r':
								Repeat = atol( &argv[i][2] );
								break;
							
							/* service name */
							case 's':
								strcpy( ServiceName, &argv[i][2] );

							/* transaction version */
							case 'v':
								MsgHeader.TxVersion = atol( &argv[i][2] );
								break;

							default:
								displaymsg();
								break;
						}
						break;

					default:
						displaymsg();
						break;
				}
			}
		}
	}

//	MsgHeader.AgsTxID = 1;

	/* use default info if none are provided */
	if( strlen( HostName ) == 0 )
	{
		strcpy ( HostName, "c1proxyhost" );
	}
		
	if( strlen( ServiceName ) == 0 )
	{
		strcpy( ServiceName, "c1proxy" );
	}

	if( strlen( InData ) == 0 )
	{
		strcpy( InData, "KyBa=0656390004" );
//		strcpy( InData, "KyBa=0135710139|TblName=CIS00059|NumRecReq=15|TblKey=E0004" );
//		strcpy( InData, "TblName=CIS00059|NumRecReq=15|TblKey=E0004" );
//		strcpy( InData, "TblName=CIS00059|NumRecReq=15" );
//		strcpy( InData, "TblName=C1CMBMSG|TblKey=10000" );
//		strcpy( InData, "TblName=C1CMBMSG|NumRecReq=200" );
//		strcpy( InData, "TblName=CIS00059|TblKey=E0004" );
	}

//	if( MsgHeader.DataLen == 0 )
//	{

//	}

	if( MsgHeader.TxID == 0 )
	{
		MsgHeader.TxID = 1;
//		MsgHeader.TxID = 51;
	}

	if( MsgHeader.TxVersion == 0 )
	{
		MsgHeader.TxVersion = 1;
//		MsgHeader.TxVersion = 2;
	}

	/*
	** bdl 10/29/97
	** data caching settings
	*/
	MsgHeader.CacheTimeLen = 60;			
	MsgHeader.ForceCall    = FALSE;
	MsgHeader.ForceCache   = TRUE;

   for ( j = 1; j <= Repeat; ++j )
   {				 
		sprintf( PipeName, "\\\\%s\\%s", HostName, ServiceName );
		
		/* open pipe */
		printf( "\nTcpPipeOpen... \n" );

/***/
//_ftime( &StartTime );
/***/	

		rc = TcpPipeOpen ( PipeName, &hPipe); 

/***/
//_ftime( &EndTime );
//LogTime( ",", StartTime, EndTime );
/***/

		if (!rc)
		{
			/* write pipe header */
			printf( "\nTcpPipeWrite MsgHeader... \n" );

/***/
//_ftime( &StartTime );
/***/	
			/* data length */
			MsgHeader.DataLen = 1 + strlen( InData );

			/* convert to network byte order */
			AZGS02FormatMsgHdr( ORDER_TO_NET, 
						        &MsgHeader ); 

/***/
//_ftime( &EndTime );
//LogTime( ",", StartTime, EndTime );
/***/

			DataLen = sizeof( MESSAGE_HDR );

/***/
//_ftime( &StartTime );
/***/	

			rc = TcpPipeWrite( hPipe,
							   &MsgHeader,
							   &DataLen,
							   0 );

/***/
//_ftime( &EndTime );
//LogTime( ",", StartTime, EndTime );
/***/

			if ( !rc )
			{
				/* write pipe header */
				printf( "\nTcpPipeWrite Data... \n" );

				DataLen = 1 + strlen( InData );

/***/
//_ftime( &StartTime );
/***/	

				rc = TcpPipeWrite( hPipe,
								   &InData,
								   &DataLen,
								   0 );

/***/
//_ftime( &EndTime );
//LogTime( ",", StartTime, EndTime );
/***/

				if (!rc)
				{
					/* read retrun message header from pipe */
					printf( "\nTcpPipeRead MsgHeader... \n" );

					DataLen = sizeof( MESSAGE_HDR );

/***/
//_ftime( &StartTime );
/***/	

					rc = TcpPipeRead ( hPipe,
									   &MsgHeader,
									   &DataLen,
									   0 );

/***/
//_ftime( &EndTime );
//LogTime( ",", StartTime, EndTime );
/***/


					if (!rc)
					{
						/* convert to network byte order */
						AZGS02FormatMsgHdr( ORDER_TO_HOST, 
									        &MsgHeader );

						DataLen = MsgHeader.DataLen;
						pOutData = malloc( MsgHeader.DataLen );
						memset( pOutData, 0, MsgHeader.DataLen );

						/* read retrun data header from pipe */
						printf( "\nTcpPipeRead Data... \n" );

/***/
//_ftime( &StartTime );
/***/	
						
						rc = TcpPipeRead ( hPipe,
										   pOutData,
										   &DataLen,
										   0 );
/***/
//_ftime( &EndTime );
//LogTime( ",", StartTime, EndTime );
/***/

/***/
//_ftime( &StartTime );
/***/	
						
						rc = TcpPipeClose ( hPipe );
/***/
//_ftime( &EndTime );
//LogTime( "\n", StartTime, EndTime );
/***/



					
						if (!rc)
						{
							/* return data from pipe read */
							printf( "\nReturn Value: %s\n",pOutData );
						}
						else
						{
							/* error reading from pipe */
							printf( "\nError: TcpPipeRead... Error Code:%d\n", rc );
						}
					}
				}
				else
				{
					/* error writing pipe */
					printf( "\nError: TcpPipeWrite... Error Code:%d\n", rc );	
				}
			}
		}
		else
		{
			/* error opening pipe */
			printf( "\nError: TcpPipeOpen... Error Code:%d\n", rc );
		} 
	}
			
	return 0;
}