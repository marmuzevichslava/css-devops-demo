/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                                                                         */
/*  Filename         : burst.c                                             */
/*  Module Name      : CICS to OS/2 Network Burst Program                  */
/*  Author           : Matthew Barnes                                      */
/*  Date Written     : April 29th 1991                                     */
/*                                                                         */
/*  Description      : Program that tests network time and stability by    */
/*                     bursting a series of messages with a delay.         */
/*                                                                         */
/*  Revision History : APR 29 1991  MRB  Inital version                    */
/*                     JUN 13 1991  MJC  Customizing time calculation      */
/*                     JUN 18 1991  MCQ  Customizing time display          */
/*                     JUN 20 1991  MCQ  Adding translation map option     */
/*                                       Adding multiple typed message     */
/*                     JUL 11 1992  SJS  Add command line arg for environ  */
/*                     NOV 12 1993  BJC  1.Add code to ensure parm included*/
/*                                       with command line arg (switch).   */
/*                                       2.Accept upper/lower case args.   */
/*                                       3.Translation option uses message */
/*                                       length to compute datasendmsg/recv  */
/*                                       size, based on xlat struct size.  */
/*                                                                         */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                                                                         */
/* include files: C, OS/2, Communcations Manager and Foundation            */
/*                                                                         */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/* Standard C Libary Include Files */
#include <windows.h>
#include <string.h>
#include <stdio.h>
#include <conio.h>
#include <float.h>
#include <limits.h>
#include <stdlib.h>
#include <malloc.h>
#include <ctype.h>
#include <stdarg.h>
#include <time.h>
#include <math.h>
#include <sys\timeb.h>

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


/*
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <conio.h>
#include <time.h>
#include <math.h>

#define INCL_BASE
#include <os2.h>

#define FND_CF_INCL
#define FND_EH_INCL
#define FND_IM_INCL
#define FND_FE_INCL

#include <kglzk000.h>
*/
#define ENVIRON_LEN     2
#define MAX_LENGTH 16384
#define TRUE       1
#define FALSE      0

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                                                                         */
/* structure definitions                                                   */
/*                                                                         */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

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

double bt, ts, tr, tt, rt;    /* begin time, sent, received, total time, return 
time */
double et,at;
  FILE                           *fp;


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                                                                         */
/* function prototypes                                                     */
/*                                                                         */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

void cdecl data_init (_PARAMETERS *);
void cdecl parse (int, char **, _PARAMETERS *);
void cdecl initialise (_MSG_PARM_BLOCK *, char **, char **, _ABHI *, 
_PARAMETERS *, _MESSAGE_TYPE **, _MESSAGE_TYPE **, _MESSAGE_TYPE *);

void cdecl sendmsg (_MSG_PARM_BLOCK *, char *, _MESSAGE_TYPE *, char *, 
_MESSAGE_TYPE *, _ABHI *, _PARAMETERS *);
//void cdecl receive (_MSG_PARM_BLOCK *, char *, _MESSAGE_TYPE *, _ABHI *, 
//_PARAMETERS *);

void cdecl printtime (void);
double cdecl converttime (void);       /* converts time to total seconds  */
                                 /* since beginning of day      */
void cdecl print_usage( void );

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                                                                         */
/* main                                                                    */
/*                                                                         */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*
int WINAPI WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpszCmdLine, int nCmdShow ) 

//void cdecl main(int argc, char **argv)
{
 _MSG_PARM_BLOCK  MSGParms;
 unsigned char  *DataSend;
 unsigned char  *DataRecv;
 _ABHI        ErrBlk;
 _PARAMETERS    UserBlk;
 _MESSAGE_TYPE  *MsgBlkSend;
 _MESSAGE_TYPE  *MsgBlkRecv;
 _MESSAGE_TYPE   MsgStruct;
 int            argc = 0;
 char           **argv;  
 unsigned short i;

 remove ("C:\\DATA\\BURSTNT.DAT");
 fp = fopen( "C:\\DATA\\BURSTNT.DAT", "a" );
  

 data_init(&UserBlk);
 parse(argc, argv, &UserBlk);
 initialise(&MSGParms, &DataSend, &DataRecv, &ErrBlk, &UserBlk,
      &MsgBlkSend, &MsgBlkRecv, &MsgStruct);


 bt = converttime();
 
 for (i = 0; i < UserBlk.nbr_iterations; i++)
 
 {
 sendmsg(&MSGParms, DataSend, MsgBlkSend, DataRecv, MsgBlkRecv, &ErrBlk, &UserBlk);
//  receive(&MSGParms, DataRecv, MsgBlkRecv, &ErrBlk, &UserBlk);
 }

 tt = converttime();

 et =  tt - bt;

 at = et/UserBlk.nbr_iterations;
// fprintf(fp, "Average response time was %.2f seconds.\n", at);

 fclose( fp );

 return(0);
}
*/

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                                                                         */
/* initialise data                                                         */
/*                                                                         */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

void cdecl data_init (_PARAMETERS *ub)
{
 ub->burst_number = 1;
 ub->burst_delay = 0;
 ub->group_delay = 0;
 ub->message_length = 256;
 ub->appl = 989;
 ub->nbr_iterations = 1;
 ub->translation = FALSE;
 memcpy(ub->environ, "D1", ENVIRON_LEN);
   return;
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                                                                         */
/* parse                                                                   */
/*                                                                         */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

void cdecl parse (int argc, char **argv, _PARAMETERS *ub)
{
 int arg_counter = 1;

 while( arg_counter < argc )
 {

      if( argv[arg_counter][0] != '-' && argv[arg_counter][0] != '/' )
      {
         fprintf(fp, "\nInvalid syntax.\n");
         print_usage();
      }

  switch( tolower( argv[arg_counter][1] ) )
  {
   case 'n':
            if( arg_counter != argc-1 )
            {
               arg_counter++;
               if( argv[arg_counter][0] == '-' || argv[arg_counter][0] == '/' )
               {
                  fprintf(fp, "\nThe /n switch requires a parameter.\n");
                  print_usage();
               }
       ub->burst_number = atoi(argv[arg_counter++]);
            }
            else
            {
               fprintf(fp, "\nThe /n switch requires a parameter.\n");
               print_usage();
            }
    break;
   case 'l':
            if( arg_counter != argc-1 )
            {
               arg_counter++;
               if( argv[arg_counter][0] == '-' || argv[arg_counter][0] == '/' )
               {
                  fprintf(fp, "\nThe /l switch requires a parameter.\n");
                  print_usage();
               }
       ub->message_length = atoi(argv[arg_counter++]);
            }
            else
            {
               fprintf(fp, "\nThe /l switch requires a parameter.\n");
               print_usage();
            }
    break;
   case 'd':
            if( arg_counter != argc-1 )
            {
               arg_counter++;
               if( argv[arg_counter][0] == '-' || argv[arg_counter][0] == '/' )
               {
                  fprintf(fp, "\nThe /d switch requires a parameter.\n");
                  print_usage();
               }
       ub->burst_delay = atoi(argv[arg_counter++]);
            }
            else
            {
               fprintf(fp, "\nThe /d switch requires a parameter.\n");
               print_usage();
            }
    break;
   case 'g':
            if( arg_counter != argc-1 )
            {
               arg_counter++;
               if( argv[arg_counter][0] == '-' || argv[arg_counter][0] == '/' )
               {
                  fprintf(fp, "\nThe /g switch requires a parameter.\n");
                  print_usage();
               }
       ub->group_delay = atoi(argv[arg_counter++]);
            }
            else
            {
               fprintf(fp, "\nThe /g switch requires a parameter.\n");
               print_usage();
            }
    break;
   case 'i':
            if( arg_counter != argc-1 )
            {
               arg_counter++;
               if( argv[arg_counter][0] == '-' || argv[arg_counter][0] == '/' )
               {
                  fprintf(fp, "\nThe /i switch requires a parameter.\n");
                  print_usage();
               }
       ub->nbr_iterations = atoi(argv[arg_counter++]);
            }
            else
            {
               fprintf(fp, "\nThe /i switch requires a parameter.\n");
               print_usage();
            }
    break;
         case 'e':
            if( arg_counter != argc-1 )
            {
               arg_counter++;
               if( argv[arg_counter][0] == '-' || argv[arg_counter][0] == '/' )
               {
                  fprintf(fp, "\nThe /e switch requires a parameter.\n");
                  print_usage();
               }
               memcpy(ub->environ, argv[arg_counter++], ENVIRON_LEN);
            }
            else
            {
               fprintf(fp, "\nThe /e switch requires a parameter.\n");
               print_usage();
            }
    break;
     case 'c':
    ub->appl = 987;
            arg_counter++;
    break;
   case 'v':
    ub->appl = 988;
            arg_counter++;
    break;
   case 'o':
    ub->appl = 986;
            arg_counter++;
    break;
   case 'u':
    ub->appl = 989;
            arg_counter++;
    break;
   case 't':
    ub->translation = TRUE;
            arg_counter++;
    break;
         case '?':
            print_usage();

     default:
            fprintf(fp, "\nUnrecognized option in parameter list.\n");
            print_usage();

    }
 }
 
 return;
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                                                                         */
/* print_usage                                                             */
/*                                                                         */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

void cdecl print_usage( void )
{
 fprintf(fp, "Usage: burst [/c|/v|/u|/o] [/e environment] [/t] [/d seconds]\n");
 fprintf(fp, "             [/l bytes] [/g seconds] [/n number] [/i number]\n");
 fprintf(fp, "\n");
 fprintf(fp, "OPTIONS:\n");
 fprintf(fp, "  /o OS/2 server option (default)\n");
 fprintf(fp, "  /c CICS server option\n");
 fprintf(fp, "  /v VMS  server option\n");
 fprintf(fp, "  /u UNIX server option\n");
 fprintf(fp, "  /t translation option\n");
 fprintf(fp, "  /e environment (default=D1)\n");
 fprintf(fp, "  /d burst delay (seconds; default=0)\n");
 fprintf(fp, "  /g group delay (seconds; default=0)\n");
 fprintf(fp, "  /l message length (bytes; default=256)\n");
 fprintf(fp, "  /n number of messages (default=1)\n");
 fprintf(fp, "  /i number of iterations (default=5)\n");
        fprintf(fp, "  /?   displays this usage message\n");
 exit(1);
}
 
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                                                                         */
/* initialise                                                              */
/*                                                                         */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

void cdecl initialise (_MSG_PARM_BLOCK *pb, char **ds, char **dr, _ABHI *er, 
_PARAMETERS *ub, _MESSAGE_TYPE **mbs, _MESSAGE_TYPE **mbr, _MESSAGE_TYPE *ms)
{
 unsigned short usRetCode;
 unsigned short i, j, k, m, n, p, q;
 _MESSAGE_TYPE  *mbscopy;
 _MESSAGE_TYPE *mbrcopy;

   unsigned int   number_of_structs;
   const unsigned int struct_size=sizeof(_MESSAGE_TYPE);
 
 memset(pb, 0x00, sizeof(_MSG_PARM_BLOCK));
 memset(er, 0x00, sizeof(_ABHI));

 if (ub->translation == FALSE)
 {
  *ds = malloc(ub->message_length);
  memset(*ds, 0x00, ub->message_length);
  *dr = malloc(ub->message_length);
  memset(*dr, 0x00, ub->message_length);
 }

 else  /* fill structure with data to translate */
 {
  memset(ms->char1, 'a', 80);
  for (j = 0; j < 8; j++)
   ms->short1[j] = j;
  for (k = 0; k < 8; k++)
   ms->short2[k] = (k + 10);
  for (m = 0; m < 8; m++)
   ms->long1[m] = m + 1000; 
  for (n = 0; n < 7; n++)
   ms->long2[n] = n + 1000;
  for (p = 0; p < 7; p++)
   ms->float1[p] = (p + 100) / 10;
  for (q = 0; q < 7; q++)
   ms->double1[q] = (q + 1000) / 10;

      /* calculate number of structures for desired message length, allocate, 
and fill */

      if ( fmod((double) ub->message_length, (double) struct_size) > (double) 
0.00)
      {
         number_of_structs = (ub->message_length/struct_size) + 1;
         ub->message_length = ((unsigned int) number_of_structs) * struct_size;
      }
      else
         number_of_structs = (ub->message_length/struct_size);


      *mbs = (_MESSAGE_TYPE *) malloc(ub->message_length);
  mbscopy = *mbs;
  *mbr = (_MESSAGE_TYPE *) malloc(ub->message_length);
  mbrcopy = *mbr;

      for (i = 0; i < number_of_structs; i++)
  {
   memcpy(mbscopy, ms, sizeof(*ms));
   mbscopy++;
   memcpy(mbrcopy, ms, sizeof(*ms));
   mbrcopy++;
  }

 }
  
 memcpy(pb->commarea.ver, FND_MSG_VER, _VER_LEN);
 usRetCode = MSGInit(pb, er);
 if (usRetCode)
 {
  fprintf(fp, "     : MSGInit failed\n");
  exit(1);
 }
 
 return;
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                                                                         */
/*sendmsg                                                                    */
/*                                                                         */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

void cdecl sendmsg (_MSG_PARM_BLOCK *pb, char *ds, _MESSAGE_TYPE *mbs,  
                    char *dr, _MESSAGE_TYPE *mbr, _ABHI *er, _PARAMETERS *ub)
{
 unsigned short usRetCode, usMsgNo;
 static unsigned short i;


 pb->commarea.function_code = MSGIO_SEND;
 pb->actual_length_send = ub->message_length;
 pb->buffer_size = ub->message_length;
 pb->src.language = FND_LANGUAGE_C;
 pb->dest.service_id.appl = ub->appl;
 pb->dest.service_id.srvc = 1;
 memcpy(pb->dest.service_id.service_ver, "01", 2);
 pb->request_or_reply = FND_REQUEST_MSG_FLG;
 pb->reply_requested = MSGIO_REPLY_REQUESTED_NO;
   memcpy(pb->environ, ub->environ, ENVIRON_LEN);
 pb->timeout_interval = MS_INFINITE_TIMEOUT;
 pb->priority = MSGIO_PRIORITY_MEDIUM;
 
 if( ub->translation == FALSE )
 {
  memcpy(pb->translation.map_name, "BURST   ", 8);
  memcpy(pb->translation.map_version, "01", 2);
      *ds = 'N';
   }
   else
   {
  memcpy(pb->translation.map_name, "BURST2  ", 8);
  memcpy(pb->translation.map_version, "01", 2);
  mbs->char1[0] = 'N';
 }

   ts = converttime();
      
   usMsgNo = ub->burst_number;
 do
 {
  if (usMsgNo == 1)
  {
   pb->reply_requested = MSGIO_REPLY_REQUESTED_YES;
   if( ub->translation == FALSE )
    *ds = 'Y';
   else
    mbs->char1[0] = 'Y';
  }

  memcpy (pb->secur.user_id, "OT00543 ", 8);
  memcpy (pb->secur.user_pw, "0MISICAT", 8);

  if (ub->translation == FALSE)
   usRetCode = MSGConvUI(pb, ds, dr, er);
  else
   usRetCode = MSGConvUI(pb, (char *)mbs, (char *)mbr, er);

 if ((usRetCode) || (pb->appl_status.severity))
 {
  fprintf(fp, "     : MSGRecv failure (return code = %d, application return code = %d)\n",
    usRetCode, pb->appl_status.explan_code);
  exit(1);
 }

 tr = converttime();
 rt = tr - ts;
   
 fprintf(fp, "Unix Address Server Connection Established...\n");
 fprintf(fp, "    Domain: %d Station: %d\n", pb->dest.net_addr.node.domain,
 											 pb->dest.net_addr.node.station);   
 fprintf(fp, "    Burst response time was %.2f seconds.\n", rt);
 fprintf(fp, "\n");   
  
  if (ub->burst_delay != 0)
   Sleep(ub->burst_delay * 1000);
  
 } while (--usMsgNo != 0);
 return;
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                                                                         */
/* receive                                                                 */
/*                                                                         */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*void cdecl receive (_MSG_PARM_BLOCK *pb, char *dr, _MESSAGE_TYPE *mbr, _ABHI 
*er, _PARAMETERS *ub)
{
 unsigned short usRetCode;
 static unsigned short i;
 
 pb->buffer_size = ub->message_length;
 pb->priority = MSGIO_PRIORITY_NONE;

 if (ub->translation == FALSE)
  usRetCode = MSGRecv(pb, dr, er);
 else
  usRetCode = MSGRecv(pb, (char *)mbr, er);

 if ((usRetCode) || (pb->appl_status.severity))
 {
  fprintf(fp, "     : MSGRecv failure (return code = %d, application return code = 
%d)\n",
    usRetCode, pb->appl_status.explan_code);
  exit(1);
 }

 tr = converttime();
 rt = tr - ts;
   
 fprintf(fp, "Iteration number %u response time was %.2f seconds.\n", ++i, rt);   

 return;
}

*/
/** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/**                                                                         */
/** printtime                                                               */
/**                                                                         */
/** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

void cdecl printtime(void)                                                    
{                                                                        
  struct tm *curtime;
  time_t bintime;
  char                           TimeString[24];

// Fetch The Current Date and Time

  time(&bintime);
  curtime = localtime(&bintime);
  memcpy (TimeString, asctime(curtime), 24);
                                                                         
 fprintf(fp, "@ %s", TimeString);               
                                                                       
 return;                                                               
}


/** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/**                                                                         */
/** converttime                                                             */
/**                                                                         */
/** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
                                                            
double cdecl converttime(void)

{
 struct timeb timemilli;
// struct _DATETIME dt;                                                 
   double time_in_sec;
//   , dhours, dminutes, dseconds, dhundredths;
   
//   DosGetDateTime(&dt);

//   dhours = (double)dt.hours;
//   dminutes = (double)dt.minutes;
//   dseconds = (double)dt.seconds;
//   dhundredths = (double)dt.hundredths;


 ftime(&timemilli);
// dSaveStartTime = (1000 * (double) timemilli.time) +
//		   (double) timemilli.millitm;



 time_in_sec = ((double) timemilli.time + (double) timemilli.millitm/1000);
   
return(time_in_sec);                                                               
}


