#include "azgsstub.h"


#ifdef AGS_DEBUG
#include <sys/timeb.h>

FILE *pFile = NULL;

VOID LogTime( char *Event, struct _timeb StartTime, struct _timeb EndTime )
{
 	char ElapsedTime[15] = "";
	pFile = fopen( "c:\\agslog.txt", "a+" );

    if( pFile )
    {
	    fseek( pFile, 0L, SEEK_END );

	    sprintf( ElapsedTime, "%.3f", (( EndTime.time	+ 
		                               ( EndTime.millitm * .001 )) -
					                   ( StartTime.time + 
								       ( StartTime.millitm * .001 ))));

	    fprintf( pFile, "%s%s", ElapsedTime, Event );	

	    fclose( pFile );
    }

	return;
}
#endif

void displaymsg ()
{
	printf( "\nAZGSSTUB: invalid parameter(s) \n" );
	printf( "USAGE:    azgsstub -<flag><flag value>\n" );
    printf( "EXAMPLE:  azgsstub -i1 -v2 -r10 -fc:\\temp\\indata.txt -oc:\\temp\\outdata.txt \n\n" );
	printf( "<flags> \n" );
	printf( " d - data \n" );
    printf( " f - input data file \n" );
	//printf( " h - host name. default = 'c1proxyhost'\n" );
	printf( " i - transaction id \n" );
    printf( " o - output data file \n" );
	printf( " r - repeat n time\n" );
	//printf( " s - service name. default = 'c1proxy'\n" );
	printf( " v - transaction version \n" );	

	return;
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
	char			InData[500] = "";
	char			*pOutData = NULL;
	CHAR            InFileName[20] = "";
	CHAR            OutFileName[20] = "";
	FILE            *pInFile  = NULL;
	FILE            *pOutFile = NULL;
    DWORD           StartTime = 0;
    DWORD           EndTime = 0;
	PIPE_HANDLE		hPipe;
	MESSAGE_HDR		MsgHeader;

    #ifdef AGS_DEBUG
     struct _timeb StartTime, EndTime;

     memset( &StartTime, 0, sizeof( struct _timeb ));
     memset( &EndTime,   0, sizeof( struct _timeb ));
    #endif

	memset( &hPipe, 0, sizeof( PIPE_HANDLE ));
	memset( &MsgHeader, 0, sizeof( MESSAGE_HDR ));
	
	if( argc > 1 )
	{	
		if ( argv[1][0] == '/' && argv[1][1] == '?')
		{
			/* show help message */
			displaymsg();
            return 1;
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
								break;

							/* transaction version */
							case 'v':
								MsgHeader.TxVersion = atol( &argv[i][2] );
								break;

							case 'f':
								strcpy( InFileName, &argv[i][2] );
								break;

							case 'o':
								strcpy( OutFileName, &argv[i][2] );
								break;
							
							default:
								displaymsg();
                                return 1;
								break;
						}
						break;

					default:
						displaymsg();
                        return 1;
						break;
				}
			}
		}
	}

	if( strlen( InFileName ))
	{
		pInFile = fopen( InFileName, "r" );

		if( pInFile )
		{
			fgets( InData, 499, pInFile );
            fclose( pInFile );
		}
	}

    else if( strlen( InData ) == 0 )
	{
		strcpy( InData, "TblName=CIS00059|NumRecReq=15" );
	}

	/*
	MsgHeader.AgsTxID = 1;
	*/

	/* use default info if none are provided */
	if( strlen( HostName ) == 0 )
	{
		strcpy ( HostName, "c1proxyhost" );
	}
		
	if( strlen( ServiceName ) == 0 )
	{
		strcpy( ServiceName, "c1proxy" );
	}

	if( MsgHeader.TxID == 0 )
	{
/*
		MsgHeader.TxID = 1;
*/
		MsgHeader.TxID = 51;
	}

	if( MsgHeader.TxVersion == 0 )
	{
		MsgHeader.TxVersion = 1;
/*
		MsgHeader.TxVersion = 2;
*/
	}

	/*
	** bdl 10/29/97
	** data caching settings
	*/
	MsgHeader.CacheTimeLen = 10;			
	MsgHeader.ForceCall    = TRUE;
	MsgHeader.ForceCache   = FALSE;

    /* display tx info */
    printf( "\nTx Settings    -> TxID:            %.*d  TxVer:     %.*d\n", 2, MsgHeader.TxID, 2, MsgHeader.TxVersion );
    printf( "Cache Settings -> CacheTime: %.*d sec  ForceCall:  %d  ForceCache: %d\n", 4, MsgHeader.CacheTimeLen, MsgHeader.ForceCall, MsgHeader.ForceCache );

    printf( "Input File     -> " );
    if( strlen( InFileName ))
    {
        printf( "%s\n", InFileName );
    }
    else
    {
        printf( "None\n" );
    }

    printf( "Output File    -> " );
    if( strlen( OutFileName ))
    {
        printf( "%s\n", OutFileName );
    }
    else
    {
        printf( "None\n" );
    }

   for ( j = 1; j <= Repeat; ++j )
   {			
		sprintf( PipeName, 
			     "%c%c%s%c%s", 
				 PIPE_SEPERATOR,
				 PIPE_SEPERATOR,
			     HostName, 
				 PIPE_SEPERATOR,
				 ServiceName );

        /* open pipe */
		printf( "\nTcpPipeOpen..." );

        #ifdef AGS_DEBUG
         _ftime( &StartTime );
        #endif

        StartTime = GetTickCount();

		rc = TcpPipeOpen ( PipeName, &hPipe); 

        #ifdef AGS_DEBUG
         _ftime( &EndTime );
         LogTime( ",", StartTime, EndTime );
        #endif

		if (!rc)
		{
			/* write pipe header */
			printf( "            Done.\nTcpPipeWrite MsgHeader..." );

            #ifdef AGS_DEBUG
             _ftime( &StartTime );
            #endif

			/* data length */
			MsgHeader.DataLen = 1 + strlen( InData );

			/* convert to network byte order */
			AZGS02FormatMsgHdr( ORDER_TO_NET, 
						        &MsgHeader ); 

            #ifdef AGS_DEBUG
             _ftime( &EndTime );
             LogTime( ",", StartTime, EndTime );
            #endif

			DataLen = sizeof( MESSAGE_HDR );

            #ifdef AGS_DEBUG
             _ftime( &StartTime );
            #endif

			rc = TcpPipeWrite( hPipe,
							   &MsgHeader,
							   &DataLen,
							   0 );

            #ifdef AGS_DEBUG
             _ftime( &EndTime );
             LogTime( ",", StartTime, EndTime );
            #endif

			if ( !rc )
			{
				/* write pipe header */
				printf( " Done, Data..." );

				DataLen = 1 + strlen( InData );

                #ifdef AGS_DEBUG
                 _ftime( &StartTime );
                #endif

				rc = TcpPipeWrite( hPipe,
								   &InData,
								   &DataLen,
								   0 );                

                #ifdef AGS_DEBUG
                 _ftime( &EndTime );
                 LogTime( ",", StartTime, EndTime );
                #endif

				if (!rc)
				{
					/* read retrun message header from pipe */
					printf( " Done.\nTcpPipeRead  MsgHeader..." );

					DataLen = sizeof( MESSAGE_HDR );

                    #ifdef AGS_DEBUG
                     _ftime( &StartTime );
                    #endif

					rc = TcpPipeRead ( hPipe,
									   &MsgHeader,
									   &DataLen,
									   0 );                    

                    #ifdef AGS_DEBUG
                     _ftime( &EndTime );
                     LogTime( ",", StartTime, EndTime );
                    #endif

					if (!rc)
					{
                        printf( " Done, Data..." );

						/* convert to network byte order */
						AZGS02FormatMsgHdr( ORDER_TO_HOST, 
									        &MsgHeader );

						DataLen = MsgHeader.DataLen;
						pOutData = malloc( MsgHeader.DataLen );
						memset( pOutData, 0, MsgHeader.DataLen );

						/* read retrun data header from pipe */
                        #ifdef AGS_DEBUG
                         _ftime( &StartTime );
                        #endif
						
						rc = TcpPipeRead ( hPipe,
										   pOutData,
										   &DataLen,
										   0 );
                        printf( " Done.\nTcpPipeClose... " );

                        #ifdef AGS_DEBUG
                         _ftime( &EndTime );
                         LogTime( ",", StartTime, EndTime );
                         _ftime( &StartTime );
                        #endif

						rc = TcpPipeClose ( hPipe );
                        printf( "          Done.\n\n" );

                        EndTime = GetTickCount();

                        #ifdef AGS_DEBUG
                         _ftime( &EndTime );
                         LogTime( "\n", StartTime, EndTime );
                        #endif
					
						if (!rc)
						{
							/* return data from pipe read */
                            printf( "Tx Time:        %.3f sec\n", ( EndTime - StartTime ) * .001 );
                            printf( "Return Code:    %d\n", MsgHeader.RC );
                            printf( "Return Length:  %d bytes\n", MsgHeader.DataLen );
							printf( "Return Data:    %s\n",pOutData );							

                            /* write output to file */
                            if( strlen( OutFileName ))
							{
								 pOutFile = fopen( OutFileName, "w" );

								 if( pOutFile )
								 {
									fprintf( pOutFile, "%s", pOutData );
                                    fclose( pOutFile );
								 }
							}
						}
						else
						{
							/* error reading from pipe */
							printf( " Error: %d\n", rc );
						}

                        /* release resources */
                        free( pOutData );
					}
				}
				else
				{
					/* error writing pipe */
					printf( " Error: %d\n", rc );
				}
			}
		}
		else
		{
			/* error opening pipe */
			printf( " Error: %d\n", rc );
		} 
	}
			
	return 0;
}