/* SCCS: AZEH001A.c  2.3  05/26/95  09:05:37 */
/***************************************************************/
/* Program ID: AZEH001A           this id to simulate program  */
/*                                by the same name written in  */
/*                                in assembler for the IBM     */
/*                                mainframe applications       */
/* Author: Michael D. Conner                                   */
/*                                                             */
/*         SolutionWorks                                       */
/*         Andersen Consulting                                 */
/*         St. Petersburg, Florida                             */
/*                                                             */
/* Date: 11/21/94                                              */
/*                                                             */
/* This program checks the environment variable PROCTYPE.      */
/* PROCTYPE should be set to a "B" for Batch or "C" for online */
/* (C is used for mainframe compatibility) by the script       */
/* calling the calling the parent process.  Theis module       */
/* returns a "B" or a "C".                                     */
/***************************************************************/

#include <stdlib.h>
#include <stdio.h>  
#include <string.h>
#include <sw_globals.h>

void AZEH001A(char *prctype)
{
   char *s;

       s=swaGetProcType();
       if(s == NULL)
       {
		fprintf(stderr,"\nPROCTYPE environmnt variable not set...\n");
		exit(5);
	}
	if(strcmp(s,"B") && strcmp(s,"C"))
	{
		fprintf(stderr, "\nPROCTYPE is invalid.....\n");
		exit(6);
	}
	else
	{
	/*	printf("\nPROCTYPE = %s\n\n",s);   */ /*commented out after testing*/
		strcpy(prctype,s);
	}
}
