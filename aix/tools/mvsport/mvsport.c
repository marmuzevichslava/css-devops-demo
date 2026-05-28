/***********************************************************************
*
* Program ID:  mvsport.c	 
*
* Author : ADAM KREUGER
*          Andersen Consulting
*          SolutionWorks
*
* Description:  This program is used to check COBOL codes for any
*               inconsistencies/incompatibilities with the mainframe
*               system.  
*
* HISTORY:
* 02/20/96 blim Original code.  
* 03/15/96 blim Added cobol verb switches.
* 03/20/96 akreuger Modified to become reverse port processor.
*	1) changed tab replacement.  Six spaces are added for comment
*	   lines.  Seven spaces are added for working code. 
*	2) Made the processor remove all control characters
*	3) Move all code in columns one through six to column seven.
*	   If it is working code move to column eight.
*	4) Made CHECK_PER_CHAR modify actual code. No longer gives
*	   warnings.
*       5) Paragraph names are now moved to the proper column by the
* 	   processor.
*	6) Author is now moved by processor to column 8. When necessary.
*	7) 01 levels are moved to column 8 if they are not there already.
*	   Needed to add "linestring" as an argument to the function call 
*	   check_01_level.
*	8) corrected check_verb, so that, it will move the verbs to column 12
*	   Also, added EXEC to list.  Added linestring arguement to funcion. 
*	9) Converted code for CHECK_COMP5.  Now COMP-5 will be changed to COMP.
*	10)Added function to convert WFNDCODE to CIMFN000
*	11)Added function to convert SOURCE-COMPUTER to 
*	   SOURCE-COMPUTER.IBM-ES-9000-820.  Listed as #define SOURCE_COMPUTER 
*	12)Added function to convert OBJECT-COMPUTER to 
*          OBJECT-COMPUTER.IBM-ES-9000-820.  Listed as #define OBJECT_COMPUTER 
*	13)Added function to convert "ASSIGN TO EXTERNAL" to "UT-S-".  All of the white spaces
*	   between "UT-S-" and CODE are removed.
*	14)Added function that scans for EXEC SQL BEGIN DECLARE and EXEC SQL END DECLARE.
*	   If there isn't SQL code between the two statements, comment the lines out.
*	15)Modified error output.  Now the errors go to ERROR.txt
*	16)Only code that is beyond column will be output to the ERROR.txt file.  Hence,
*          no comment statements that are beyond column 72 will be in the ERROR.txt file.
*	17)Added "SELECT" to the check_verb list.
*
* 07/22/96 akreuger added logic for commenting or uncommenting flagged strings.
*	1)  Added the function comment_out_lines()
*	2)  Added the function uncomment_lines()
*
* M.DANNEELS - removed errfile because nothing was being written to it. 
*
* 11/13/96 iperezar modified check_external so that it would not be dependent
*          upon the number of spaces after the word ASSIGN
*
* 03/14/97 iperezar Added logic to flush print buffer to correct a bug found when
*          writing files accross servers.
*
* 04/29/97 Marc Danneels 
*          SIR 16416 added function to replace "-     '',"  with spaces and 
*          adjust the above line.  
*          This FOUNDATION generated string causes problems in MVS copybooks.
*
* 04/30/97 iperezar
*          Added check_comments function to verify if a line is commented out.
*          Commented out lines not containing port comments are not processed.
*
* 07/29/97 jrashid
*          Added logic to the fix_quote function to handle continuation
*          characters when the above line ends with '. 
*
* 12/01/98 edeutsch
*          Added logic to switch oracle mode comments similar to unix/mvs port comments.
*
* (c) 1996 Copyright Andersen Consulting - All rights reserved. 
*THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.
*
***********************************************************************/

/**************************************************************/
/*                                                            */
/*   INCLUDE FILES                                            */
/*                                                            */
/**************************************************************/

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <time.h>
#include "mvsport.h"

/**************************************************************/
/*                                                            */
/*   MAIN PROGRAM                                             */
/*                                                            */
/**************************************************************/

int main (int argc, char *argv[])
{
  
  char line1[LINESIZE];
  char line2[LINESIZE];
  char mvcommand[LINESIZE];
  char sProject[EXTERNAL_LEN];
  char sFileName[PATH_LEN];
  char *linestring;
  char *linestring2;
  int  i;

  time_t porttime;
  struct tm *fmt_time;
 

  memset (mvcommand, 0, sizeof(mvcommand) );

  if (argc != 3)
  {
      fprintf (stderr, "\nError: Invalid number of arguments!\n");
      printf("\nUSAGE: mvsport <PROJECT> <OBJECT>\n");
      exit(ERROR);
  }

  for (i = 1; i < argc; ++i)
  {
      switch (i)
      {
	   case 1: strcpy(sProject,  argv[i]); break;
           case 2: strcpy(sFileName, argv[i]); break; 
           default: 
		   fprintf (stderr, "\nERROR: Invalid parameter!\n.");
	           printf("\nUSAGE: mvsport <PROJECT> <FILENAME>\n");
	           exit(ERROR);
      }
  }
  
  get_parameters(sProject);
  open_files(sFileName);

  /* load the queue with the first two lines of code  */

  memset(line1, 0, sizeof(line1) );
  memset(line2, 0, sizeof(line2) );

  fgets(line1, LINESIZE, fpcoin);
  fgets(line2, LINESIZE, fpcoin);

  linestring = line1;
  linestring2 = line2;

   if(strstr(line1, HEADER) == 0)
  {
     porttime = time(NULL);
     fmt_time = localtime(&porttime);

     fprintf(fpcnew,"%s",HEADER);
     fprintf(fpcnew, HEADER2, asctime(fmt_time) );

     processed = 0;
  }
  else
  {
     fprintf(fpcnew,"%s",REPROCESS);
     processed = 1;
  }

  /* did the parse here because I needed the verbs in both linestring
     and linestring2 to be in the proper columns.  This parse will 
     run on linestring.  The parses that follow will run on
     linestring2.  */

  line_count++;

  if (strcmp(OracleFlag, "ON") == 0)
  {
      comment_out_oracle_lines(linestring);
      uncomment_oracle_lines(linestring);
  }

  if (strcmp(MVSClientFlag, "ON") == 0)
  {
      comment_out_lines(linestring);
      uncomment_lines(linestring);

      /* if the file has already been processed don't do this line again */
      if (processed == 0)
       {  
          convert_source_computer(linestring);
          convert_object_computer(linestring);
      }

      if (check_comments(linestring) == NON_COMMENT_LINE)
          convert_external(linestring);
  }   

  fprintf(fpcnew,"%s",linestring);
  strcpy(line1, line2);
  fgets(line2, LINESIZE, fpcoin);

  while ( !feof(fpcoin) )
  {
      /* do all processing on the linestring for the rest of the file  */
      line_count++;

      if (strcmp(OracleFlag, "ON") == 0)
      {
	  comment_out_oracle_lines(linestring);
	  uncomment_oracle_lines(linestring);
      }

      if (strcmp(MVSClientFlag, "ON") == 0)
      {
          comment_out_lines(linestring);
          uncomment_lines(linestring);

          /* if the file has already been processed don't do this line again */
          if (processed == 0)
          {
              convert_source_computer(linestring );
              convert_object_computer(linestring );
          }

          if (check_comments(linestring) == NON_COMMENT_LINE)
               convert_external(linestring );

          fix_quote(linestring, linestring2);
          scan_exec(linestring, linestring2);
      }

      fprintf(fpcnew,"%s",linestring );
      strcpy(line1, line2);
      fgets(line2, LINESIZE, fpcoin);

  }  /** end of while not end of file **/

  /* do all of the functions on the last line of code */

  line_count++;

  if (strcmp(OracleFlag, "ON") == 0)
  {
      comment_out_oracle_lines(linestring);
      uncomment_oracle_lines(linestring);
  }

  if (strcmp(MVSClientFlag, "ON") == 0)
  {
      comment_out_lines(linestring);
      uncomment_lines(linestring);

      /* if the file has already been processed don't do this line again */
      if (processed == 0)
      { 
          convert_source_computer(linestring );
          convert_object_computer(linestring );
      }

      if (check_comments(linestring) == NON_COMMENT_LINE)
          convert_external(linestring );

      scan_exec(linestring, linestring2);
  }

  fprintf(fpcnew,"%s",linestring );

  close_files();

/* Suresh Pellakur FCP Upgrade AIX portability issue: 2006/06/09 */
  char *filename2;
  char *newfile2;

  if ( (newfile2 = malloc( WORKING_DIRECTORY_LEN )) == NULL )
  {
     printf(MEM_ERROR);
     exit (ERROR);
  }

  memset(newfile2,'0',strlen(newfile2));

   filename2 = malloc( 8 );


  if ((filename2 = strrchr(sFileName, '/')) == NULL)
  {
    strcpy(newfile2,WORKING_DIRECTORY);
    strcat(newfile2,DIRECTORY_MARK);
    strcat(newfile2,sFileName);
    strcat(newfile2,".new");
  }
  else
  {
    strcpy(newfile2,WORKING_DIRECTORY);
    strcat(newfile2,filename2);
    strcat(newfile2,".new");
  }
/* Change Complete by Suresh Pellakur */

  if ( RENAME_FLAG==0 )
  {
      if ( remove(sFileName) != 0 )
         printf("\n");
      else
      {
 
        if ( rename(newfile, sFileName) != 0 )
          {
	      /******************************************************

              printf("Rename Failed\n");
              printf("Copying from %s\n", newfile);
              printf("To %s\n", argv[1]);
              printf("Renaming new output filename to original filename failed.\n");

              *****************************************************/
              strcpy(mvcommand, "mv ");
	      strcat(mvcommand, newfile2);
	      strcat(mvcommand, " ");
	      strcat(mvcommand, sFileName);

              system( mvcommand );
 
              if ( ( fpcoin = fopen(sFileName,"rb") ) == NULL )
              {
                  puts("Failed to rename output file\n");
                  exit(ERROR);
              }
	      else
                  fclose(fpcoin);
          }
      }
  }

  exit(SUCCESS);

}  /** end of main **/

/*-----------------------------------------------------------------------
OPEN_FILES

The function reads the input file in binary and at the same time
creates two other files: <filename>.err and <filename>.new.
The error file redisplays the lines with error and the message
associated with it.  The new file is merely just a copy of the original
but without the tabs. ( Note: The new output filename would be renamed 
to the original filename at the end of the program.)

-------------------------------------------------------------------------*/

void open_files(char *FileName)
{
  char *filename;

  if ( (newfile = malloc( WORKING_DIRECTORY_LEN )) == NULL )
  {
     printf(MEM_ERROR);
     exit (ERROR);
  }

  memset(newfile,'0',strlen(newfile));

   filename = malloc( 8 );

  strcpy(newfile,WORKING_DIRECTORY);
  strcat(newfile,DIRECTORY_MARK);
  strcat(newfile,FileName);

  if ((filename = strrchr(FileName, '/')) == NULL)
  {
    strcpy(newfile,WORKING_DIRECTORY);
    strcat(newfile,DIRECTORY_MARK);
    strcat(newfile,FileName);
    strcat(newfile,".new");
  }
  else
  {
    strcpy(newfile,WORKING_DIRECTORY);
    strcat(newfile,filename);
    strcat(newfile,".new");
 }

  RENAME_FLAG=0;

  if ((fpcoin = fopen(FileName,"rb")) == NULL)
  {
     puts("Cannot open input file\n");
     exit(ERROR);
  }


  if ((fpcnew = fopen(newfile,"wb")) == NULL)
  {
     puts("Cannot open output file\n");
     exit(ERROR);
  }

  return;
}

/*---------------------------------------------------------- 
GET_PARAMETERS

This function is used to get the parameter out the project 
specific PVCS ini file to determine if the project needs the
filename to be processed for MVS or ORACLE.
----------------------------------------------------------*/
void get_parameters (char *Project)
{
    char sPVCSDir[PATH_LEN];
    char sIniPath[PATH_LEN];
    char sParameter[PATH_LEN];
    char *pvcs_home;
    char *getenv();
    int  iIteration = 0;
    FILE *fpIniFile;

    pvcs_home = getenv ("PVCS_BINDIR");

    if (pvcs_home)
    {
        strcpy (sPVCSDir, pvcs_home);
	if (access(sPVCSDir, 0) == -1)
	{
	    fprintf(stderr, "\nERROR: Could not get the home area for pvcs from the environment variable.");
	    fprintf(stderr, "\nMake sure you have logged in properly and your .profile has been executed.\n\n");
	    exit (ERROR);
        }
    }
    else
    {
        fprintf(stderr, "\nERROR: Could not get the home area for pvcs from the environment variable.");
	fprintf(stderr, "\nMake sure you have logged in properly and your .profile has been executed.\n\n");
        exit (ERROR);
    }

    sprintf(sIniPath, "%s/%s.ini", sPVCSDir, Project);
    if ((fpIniFile = fopen(sIniPath,"r")) != NULL)
    {
        iIteration=1;
        while (fgets(sParameter, PATH_LEN, fpIniFile) != NULL)
        {
	    if (strstr(sParameter, "#") == NULL)
            {
		if (iIteration == 22)
		{
		    strcpy(MVSClientFlag, sParameter);
		    *(strchr(MVSClientFlag, '\n')) = '\0';
                }
	        if (iIteration == 46)
	        {
	            strcpy(OracleFlag, sParameter);
		    *(strchr(OracleFlag, '\n')) = '\0';
                }
		iIteration++;
            }
        }
    }
    else
    {
	fprintf(stderr, "\nERROR: Could not open %s to get the oracle parameter.", sIniPath);
	fprintf(stderr, "\nMake sure the project name is correct.");
	exit (ERROR);
    }
}

/*---------------------------------------------------------------
ALLOCATE_MEMORY

This function returns a size of 100 bytes character.  Basically,
it is used to store a copy of a line read from the input file.

-----------------------------------------------------------------*/

char *alloc_mem(void)
{
   char *tmpbuff;

   if ( ( tmpbuff = malloc(LINESIZE) ) == NULL )
   {
      printf(MEM_ERROR);
      exit (ERROR);
   }
   memset(tmpbuff,'\0',LINESIZE);
   return tmpbuff;
}
/*-------------------------------------------------------------
CONVERT_SOURCE_COMPUTER

This function replaces all occurrences of SOURCE-COMPUTER with
SOURCE-COMPUTER.IBM-ES-9000-820.  All code on the end of the
line will be truncated.
-------------------------------------------------------------*/

void convert_source_computer(char *linestring)
{

   char *linebuffer;

   linebuffer = alloc_mem();
   strcpy(linebuffer, linestring);

   if(strstr(linebuffer, OLD_SOURCE))
   {
	 strcpy(linebuffer, NEW_SOURCE);
	 strcpy(linestring, linebuffer);
   }


   free(linebuffer);
   return;

}

/*-------------------------------------------------------------
CONVERT_OBJECT_COMPUTER

This function replaces all occurrences of OBJECT-COMPUTER with
OBJECT-COMPUTER.IBM-ES-9000-820. All code on the end of the
line will be truncated.
-------------------------------------------------------------*/

void convert_object_computer(char *linestring)
{

   char *linebuffer;

   linebuffer = alloc_mem();
   strcpy(linebuffer, linestring);

   if(strstr(linebuffer, OLD_OBJECT))
   {
      strcpy(linebuffer, NEW_OBJECT);
      strcpy(linestring, linebuffer);
    }

    free(linebuffer);
    return;

}

/*-------------------------------------------------------------
CONVERT_EXTERNAL

This function replaces all occurrences of ASSIGN TO EXTERNAL with
ASIGN TO UT-S-.
-------------------------------------------------------------*/

void convert_external(char *linestring)
{

   char *chrptr;
   char *linebuffer;
   char *tmpptr;

   linebuffer = alloc_mem();
   strcpy(linebuffer, linestring);

 if( chrptr = strstr(linebuffer, ASSIGN))
 {
   if (strstr(linebuffer, EXTERNAL))
   {
       tmpptr = strstr(linestring, EXTERNAL);
       tmpptr = tmpptr + EXTERNAL_LEN;
       *chrptr = NULL;
       strcat(linebuffer, UT_S_);
       while(*(tmpptr) == ' ')
       {
           tmpptr++;
       }

       strcat(linebuffer, (tmpptr));
       strcpy(linestring, linebuffer);
   }
 }

 free(linebuffer);
 return;

}

/*-------------------------------------------------------------
FIX CONTINUATION ''

This function replaces all occurrences "-    ''[,.]" with spaces
and modifies the preceeding line accordlingly.

If there is a comma following the two quotes then the previous line
will be shortened by removing two spaces and a "'," will be added to the end..

If there is a period following the two quotes then the previous line
will be shortened by removing one space and a period will be added to the end.

07/29/97 jrashid
Added logic to handle continuation characters where the above line
ends with an apostrophe (').

FOUNDATION copybooks get generated with two single quotes 
following continuation characters.  This is acceptable in UNIX
but causes problems in MVS. 
-------------------------------------------------------------*/

void fix_quote(char *linestring, char *linestring2)
{
  char *chrptr;
  char *lstptr1;
  char *lstptr2;
  char *linebuffer;
  char *linebuffer2;
  char *tmpptr;
  char *tmpptr2;

  linebuffer  = alloc_mem();
  linebuffer2 = alloc_mem();
  tmpptr      = alloc_mem();
  tmpptr2     = alloc_mem();

  strcpy(linebuffer, linestring);
  strcpy(linebuffer2, linestring2);

  if ( chrptr = strstr(linebuffer2, CON_DBLQUOTE_CM))
  {
    tmpptr2 = strstr(linestring2, CON_DBLQUOTE_CM);
    tmpptr2 = tmpptr2 + CON_DBLQUOTE_CM_LEN;
    *chrptr = NULL;

    strcat(linebuffer2, BLANK_SPACES);

    while(*(tmpptr2) == ' ')
      tmpptr2++;

    strcat(linebuffer2, tmpptr2);
    strcpy(linestring2, linebuffer2);
       
    /* Remove two blank spaces from the previous line and append a "'," to the end.*/
    if ( chrptr = strstr(linebuffer, ", '"))
    {
      tmpptr = strstr(linestring, ", '");
      tmpptr = tmpptr + 2;
      chrptr++;
      *chrptr = NULL;
      strcat(linebuffer, tmpptr);
      strcpy(linestring, linebuffer);

      if ( chrptr = strstr(linebuffer, ", '"))
      {
        tmpptr = strstr(linestring, ", '");
        tmpptr = tmpptr + 2;
        chrptr++;
        *chrptr = NULL;

       /* Testing revealed that the generated copybooks have additional spaces beyond col 72 */
       /* Position chrptr at the last character in tmpptr */
        chrptr = strchr(tmpptr, '\n');
        chrptr--;

       /* Position backwards through the string until you find the first non ' ' */
        while( *chrptr == ' ')
          chrptr--;

       /* Set the next character = NULL */
        chrptr++;
        *chrptr = NULL;

        strcat(linebuffer, tmpptr);
        strcat(linebuffer, "',\n");
        strcpy(linestring, linebuffer);
      }
    } 
  }

  if ( chrptr = strstr(linebuffer2, CON_DBLQUOTE_PR))
  {
    tmpptr2 = strstr(linestring2, CON_DBLQUOTE_PR);
    tmpptr2 = tmpptr2 + CON_DBLQUOTE_PR_LEN;
    *chrptr = NULL;

    strcat(linebuffer2, BLANK_SPACES);

    while(*(tmpptr2) == ' ')
      tmpptr2++;

    strcat(linebuffer2, tmpptr2);
    strcpy(linestring2, linebuffer2);

    /* Remove two blank spaces from the previous line and append a "'." to the end. */

    if ( chrptr = strstr(linebuffer, ", '"))
    {
      tmpptr = strstr(linestring, ", '");
      tmpptr = tmpptr + 2;
      chrptr++;
      *chrptr = NULL;
      strcat(linebuffer, tmpptr);
      strcpy(linestring, linebuffer);

      if ( chrptr = strstr(linebuffer, ", '"))
      {
        tmpptr = strstr(linestring, ", '");
        tmpptr = tmpptr + 2;
        chrptr++;
        *chrptr = NULL;

       /* Testing revealed that the generated copybooks have additional spaces beyond col 72 */
       /* Position chrptr at the newline character in tmpptr */
        chrptr = strchr(tmpptr, '\n');
        chrptr--;

       /* Position backwards through the string until you find the first non ' ' */
        while( *chrptr == ' ')
          chrptr--;

       /* Set the next character = NULL */
        chrptr++;
        *chrptr = NULL;

        strcat(linebuffer, tmpptr);
        strcat(linebuffer, "'.\n");
        strcpy(linestring, linebuffer);
      }
    }
  }

  if ( chrptr = strstr(linebuffer2, CON_SNGQUOTE) )
  {

    /* The following two 'if' statements check to see if this continuation 
       is of the type where the above line ends with a single quote ('). */
    if (lstptr1 = strrchr(linebuffer, ',') )
    {
	  if (lstptr2 = strstr(lstptr1, "'\n") )
          {
              tmpptr2 = strstr(linestring2, CON_SNGQUOTE);
              tmpptr2 = tmpptr2 + (CON_SNGQUOTE_LEN - 1);
              *chrptr = NULL;

              strcat(linebuffer2, BLANK_SPACES2);

              while(*(tmpptr2) == ' ')
                 tmpptr2++;

              strcat(linebuffer2, tmpptr2);
              strcpy(linestring2, linebuffer2);

              if ( chrptr = strstr(linebuffer, ", '"))
              {
                  tmpptr = strstr(linestring, ", '");
                  tmpptr = tmpptr + 2;
                  chrptr++;
                  *chrptr = NULL;
                  strcat(linebuffer, tmpptr);
                  strcpy(linestring, linebuffer);

                  if ( chrptr = strstr(linebuffer, ", '"))
                  {
                      tmpptr = strstr(linestring, ", '");
                      tmpptr = tmpptr + 2;
                      chrptr++;
                      *chrptr = NULL;

                      /* Testing revealed that the generated copybooks have additional spaces beyond col 72 */
                      /* Position chrptr at the newline character in tmpptr */
                      chrptr = strchr(tmpptr, '\n');
                      chrptr--;

                      /* Position backwards through the string until you find the first non ' ' */
                      while( *chrptr == ' ' )
                      chrptr--;

                      /* backup another byte in order to delete the apostrophe from the end of the line */
                      chrptr--;

                      /* Set the next character = NULL */
                      chrptr++;
                      *chrptr = NULL;

                      strcat(linebuffer, tmpptr);
                      strcat(linebuffer, "\n");
                      strcpy(linestring, linebuffer);
                  }
              }
              else
              {
                  chrptr = strchr(linebuffer,'\n');
                  chrptr--;

                  /* Position backwards through the string until you find the first non ' ' */
                  while( *chrptr == ' ' )
                  chrptr--;

                  /* backup another byte in order to delete the apostrophe from the end of the line */
                  chrptr--;

                  /* Set the next character = NULL */
                  chrptr++;
                  *chrptr = NULL;

                  strcat(linebuffer, "\n");
                  strcpy(linestring, linebuffer);
        	    
             }
          }
    }
  }
  free(linebuffer);
  free(linebuffer2);
  return;

}

/*-------------------------------------------------------------
COMMENT_OUT_LINES

This function will scan the code for the comment
"*MVS PORT-- BEGIN UNIX" and then set the comment_flag to 1.
If the function finds "*MVS PORT-- END UNIX", the comment_flag is
set to 0.  When the comment_flag is 1 the function will comment the
lines out until the comment_flag is reset to zero.

-------------------------------------------------------------*/
void comment_out_lines(char *linestring)
{
   char *chrptr; 

   chrptr = linestring;

   if (strstr(linestring, BEGIN_COMMENT) != NULL)
   {
    comment_flag = 1;
     return;
   }

   if (strstr(linestring, END_COMMENT) != NULL)
   {
     comment_flag = 0;
     return;
   }

   if (comment_flag == 1 )
     chrptr[6] = '*';

   return;
}      

/*-------------------------------------------------------------
COMMENT_OUT_ORACLE_LINES

This function will scan the code for the comment
"*ORACLE PORT-- BEGIN MODE ANSI" and then set the comment_flag to 1.
If the function finds "*ORACLE PORT-- END MODE ANSI", the comment_flag is
set to 0.  When the comment_flag is 1 the function will comment the
lines out until the comment_flag is reset to zero.

-------------------------------------------------------------*/
void comment_out_oracle_lines(char *linestring)
{
   char *chrptr;

   chrptr = linestring;

   if (strstr(linestring, BEGIN_ORACLE_COMMENT) != NULL)
   {
    comment_flag = 1;
     return;
   }

   if (strstr(linestring, END_ORACLE_COMMENT) != NULL)
   {
     comment_flag = 0;
     return;
   }

   if (comment_flag == 1 )
     chrptr[6] = '*';

   return;
}

/*-------------------------------------------------------------
UNCOMMENT_LINES

This function will scan the code for the comment
"*MVS PORT-- BEGIN MVS" and then set the uncomment_flag to 1.
If the function finds "*MVS PORT-- END MVS", the uncomment_flag is
set to 0.  When the uncomment_flag is 1 the function will uncomment the
lines until the uncomment_flag is reset to zero.

-------------------------------------------------------------*/
void uncomment_lines(char *linestring)
{
   char *chrptr;

   chrptr = linestring;

   if (strstr(linestring, BEGIN_UNCOMMENT) != NULL)
   {
     uncomment_flag = 1;
     return;
   }

   if (strstr(linestring, END_UNCOMMENT) != NULL)
   {
     uncomment_flag = 0;
     return;
   }

   if (uncomment_flag == 1 )
     chrptr[6] = ' ';

   return;
}

/*-------------------------------------------------------------
UNCOMMENT_LINES

This function will scan the code for the comment
"*ORACLE PORT-- BEGIN MODE ORACLE" and then set the uncomment_flag to 1.
If the function finds "*ORACLE PORT-- END MODE ORACLE", the uncomment_flag is
set to 0.  When the uncomment_flag is 1 the function will uncomment the
lines until the uncomment_flag is reset to zero.

-------------------------------------------------------------*/
void uncomment_oracle_lines(char *linestring)
{
   char *chrptr;

   chrptr = linestring;

   if (strstr(linestring, BEGIN_ORACLE_UNCOMMENT) != NULL)
   {
     uncomment_flag = 1;
     return;
   }

   if (strstr(linestring, END_ORACLE_UNCOMMENT) != NULL)
   {
     uncomment_flag = 0;
     return;
   }

   if (uncomment_flag == 1 )
     chrptr[6] = ' ';

   return;
}

/*--------------------------------------------------------------
SCAN_EXEC

This function checks two sequential lines of code for 
EXEC SQL BEGIN DECLARE and EXEC SQL END DECLARE.  If no SQL
code is in between them, the lines are commented out.
--------------------------------------------------------------*/

void scan_exec(char *linestring, char *linestring2)
{
   char *linebuffer;
   char *linebuffer2;
   char *tmpptr;
   char *tmpptr2;

   tmpptr = linestring;
   tmpptr2 = linestring2;
   if (strstr(linestring, EXEC_BEGIN) != NULL)
   {
	if(strstr(linestring2, EXEC_END) != NULL)
	{
	   linebuffer = alloc_mem();
	   linebuffer2 = alloc_mem();

	   strcpy(linebuffer, "      *    ");
	   while( isspace(*tmpptr))
	   {
	     tmpptr++;
	   }
	   strcat(linebuffer, tmpptr);
	   strcpy(linestring, linebuffer);

	   strcpy(linebuffer2, "      *    ");
  	   while( isspace(*tmpptr2))
	   {
	      tmpptr2++;
	   }
	   strcat(linebuffer2, tmpptr2);
	   strcpy(linestring2, linebuffer2);
  	   
	   free(linebuffer);
	   free(linebuffer2);
	}
   } 
}

/*--------------------------------------------------------------
CLOSE_FILES

This function closes all file pointers used in the program.  
It also frees the memory used for all filenames.

--------------------------------------------------------------*/

void close_files(void)
{
   free(newfile);

   fclose(fpcoin);
   fclose(fpcout);
   fclose(fpcnew);
}
   
/*-------------------------------------------------------------

This function checks if a line has been commented out. It is called
after comment_out_lines and it checks if a line has been commented
out. If so, its return code will indicate to the program that 
the current line need not be processed as it is properly 
commented out.

-------------------------------------------------------------*/
int check_comments(char *linestring)
{
  char * comment_string;
  char input_line[LINESIZE];
  int in_length = 0;
  int comment_length = 0;
  int comment_pos=0;

  strncpy(input_line, linestring, LINESIZE);

   comment_string = strchr(input_line, '*');

   in_length = strlen(linestring);

   comment_length = strlen(comment_string);

   if (comment_string != NULL)
   {
      comment_pos = in_length - comment_length;

/*-------------------------------------------------------------
  If comment_pos = 6, then there are 6 spaces before the comment 
  character.
  That means that the comment character is on the 7th position 
  and the string has been properly commented out.
-------------------------------------------------------------*/

      if (comment_pos == COMMENT_LEN)
	  return COMMENT_LINE;
      else
	  return NON_COMMENT_LINE;
   }

   return NON_COMMENT_LINE;
}      

/*--------------------------------------------------------------
THE END
--------------------------------------------------------------*/
