
/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZCLM01                             *
*                                  by: IPEREZAR                            *
*                                                                          *
*  Short Description: This file contains error handling functions and      *
*  macros used by the FOUNDATION NT Lock manager.  They are based on       *
*  functions part of the IDEA lock manager.                                *
*                                                                          *
****************************************************************************
*                                                                          *
* Designed by:     IPEREZAR                                                * 
* Programmed by:   IPEREZAR                                                *
*                                                                          *
****************************************************************************/


/*
**  err_chk() checks sqlca.sqlcode and if an error has occurred, it uses
**  rgetmsg() [Informix] to display the message for the error condition in 
**  sqlca.
 */

short err_chk(char *name)
{
   char errmsg[400];

   if(sqlca.sqlcode < 0)
   {
      memset(errmsg, 0, sizeof(errmsg) );

      /* Informix function */
      /*rgetmsg((short)sqlca.sqlcode, errmsg, sizeof(errmsg));*/

      printf("\nError %d during %s: %s\n",sqlca.sqlcode, name, errmsg);

      return(CID_RA_SQL_ERROR);
   }
   else
   {
      return(FND_SUCCESS);
   }
}

/* The following macros were #defined to simplify error checking */

#define ERR_CHK2(op,text)                                                     \
   {                                                                          \
      short  rc;                                                              \
      char   msg[512];                                                        \
                                                                              \
      strncpy(msg, op, sizeof(msg) - 1);                                      \
      msg[sizeof(msg) - 1] = '\0';                                            \
      strncat(msg, text, sizeof(msg) - strlen(msg) - 1);                      \
      msg[sizeof(msg) - 1] = '\0';                                            \
      rc = err_chk(msg);                                                      \
      if (rc != FND_SUCCESS)                                                  \
         return rc;                                                           \
   }


