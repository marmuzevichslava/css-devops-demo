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

/***************************************************************************
 * Platform Header Files                                                   *
 ***************************************************************************/
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <limits.h>
#include <float.h>

/*************************************************************************** 
 * Foundation Global Header File                                           *
 ***************************************************************************/
#include <kglhk000.h>

/***************************************************************************/
/* #INCLUDEs                                                               */
/***************************************************************************/
#define   FND_DBMGR_INCL
#define   DTA_INCL_DB
#define   DTA_INCL_OS

EXEC SQL INCLUDE sqlca;

#include "dzlm51.h"
#include "dzerr01.h"

#include  <ctype.h>


/***************************************************************************/
/* FORWARD DECLARATIONS                                                    */
/***************************************************************************/

short LU_Table( char *Table, 
		char *Object_Name, 
		unsigned short Lock);

short LU_Table_WT( char *Table, 
		char *Object_Name, 
		unsigned short Lock);

short LU_Program( char *Object_Name, 
		  unsigned short Lock, 
		  unsigned short Recurs_Lock, 
		  short Level);

short LU_Copybook(char *Object_Name, 
		  unsigned short Lock, 
		  unsigned short Recurs_Lock, 
		  short Level);

short LU_Message( char *Object_Name, 
		  unsigned short Lock, 
		  unsigned short Recurs_Lock, 
		  short Level);

short LU_Record( char *Object_Name, 
		 unsigned short Lock, 
		 unsigned short Recurs_Lock, 
		 short Level);

short LU_Record_Group( char *Object_Name, 
		       unsigned short Lock, 
		       unsigned short Recurs_Lock, 
		       short Level);

short LU_Record_Group_Level2( char *Object_Name, 
			      unsigned short Lock, 
			      unsigned short Recurs_Lock, 
			      short Level);

short LU_Record_Group_Level3( char *Object_Name, 
                              unsigned short Lock, 
			      unsigned short Recurs_Lock, 
			      short Level);

short LU_Record_Group_Level4( char *Object_Name, 
                              unsigned short Lock, 
			      unsigned short Recurs_Lock, 
			      short Level);

short LU_Source( char *Object_Name, 
		 unsigned short Lock, 
		 unsigned short Recurs_Lock, 
		 short Level);


short LU_Service( char *Object_Name, 
		  unsigned short Lock, 
		  unsigned short Recurs_Lock, 
		  short Level);

short LU_Server( char *Object_Name, 
		 unsigned short Lock, 
		 unsigned short Recurs_Lock, 
		 short Level);

short LU_Window( char *Object_Name, 
		 unsigned short Lock, 
		 unsigned short Recurs_Lock, 
		 short Level);

short LU_Client( char *Object_Name, 
		 unsigned short Lock, 
		 unsigned short Recurs_Lock, 
		 short Level);

short LU_Executable( char *Object_Name, 
		     unsigned short Lock, 
		     unsigned short Recurs_Lock, 
		     short Level);

short LU_Data_Elt( char *Object_Name, 
		   unsigned short Lock, 
		   unsigned short Recurs_Lock, 
		   short Level);

short LU_Mask( char *Object_Name, 
	       unsigned short Lock, 
	       unsigned short Recurs_Lock, 
	       short Level);

short LU_Generic( char *Object_Name, 
	          unsigned short Lock, 
	          unsigned short Recurs_Lock, 
	          char *Object_Table);

short LU_Generic_WT( char *Object_Name, 
	             unsigned short Lock, 
	             unsigned short Recurs_Lock, 
	             char *Object_Table);

short LU_Codes_Table( char *Object_Name, 
		      unsigned short Lock, 
		      unsigned short Recurs_Lock, 
		      short Level);

short LU_Relat_Table( char *Object_Name, 
		      unsigned short Lock, 
		      unsigned short Recurs_Lock, 
		      short Level);

short LU_File( char *Object_Name, 
	       unsigned short Lock, 
	       unsigned short Recurs_Lock, 
	       short Level);

/***************************************************************************/
/* Constants (#DEFINE)                                                     */
/***************************************************************************/
/***************************************************************************/
/* Macros    (#DEFINE)                                                     */
/***************************************************************************/

#define LOCK_TYPE_LEN    2
#define ENTITY_ID_LEN   33

/***************************************************************************/
/* Global Variables                                                        */
/***************************************************************************/
/*unsigned long counter_lu            = 0;
unsigned long counter_already_lu    = 0;
unsigned long counter_unable_to_lu  = 0;
*/
char errmsg[512];

EXEC SQL BEGIN DECLARE SECTION;
   short  counter_select;
EXEC SQL END DECLARE SECTION;

/***************************************************************************/
/* LU_Table                                                                */
/***************************************************************************/

short LU_Table( char *Table, 
		char *Object_Name, 
		unsigned short Lock)
{
   short rc;
   EXEC SQL BEGIN DECLARE SECTION;
      char sql_statement1[400];
      char entity_id1[ ENTITY_ID_LEN ];
      char entity_lock_by1[ ENTITY_ID_LEN ];
      char entity_lock_type1[ LOCK_TYPE_LEN ];
   EXEC SQL END DECLARE SECTION;

   strcpy( entity_id1, Object_Name);
   if (Lock)
   {
      sprintf (sql_statement1,"update %s "
                 " set entity_lock_by = ?, "
                 " entity_lock_type = ? "
                 " where entity_id LIKE ? "
                 " and entity_lock_by = ''", Table);

      printf("\n%s\n", sql_statement1 );

      if (strcmp (Table,"deprogrm") == 0)
         strcat( sql_statement1 ," and entity_status = 'U'");

      EXEC SQL prepare upd_stat1
         from :sql_statement1;

      ERR_CHK2("prepare", sql_statement1);

      strcpy( entity_lock_by1, CID_RA_LOCK_BY_DOUBLEQUOTE);
      strcpy( entity_lock_type1, CID_RA_LOCK_TYPE_P );
      EXEC SQL execute upd_stat1
         using :entity_lock_by1,
               :entity_lock_type1,
               :entity_id1;

      printf("entity_lock_by1 %s\n",entity_lock_by1);
      printf("entity_lock_type1 %s\n",entity_lock_type1);
      printf("entity_id1 %s\n",entity_id1);

      rc=err_chk("update");
      if (rc != FND_SUCCESS)
         return rc;
     
      counter_lu = counter_lu + sqlca.sqlerrd[2];
      counter_already_lu= counter_already_lu + (counter_select - sqlca.sqlerrd[2]);
   }
   else /* if unlock */
   {
      sprintf (sql_statement1,"update %s "
                             " set entity_lock_by = '', "
                             " entity_lock_type = ''  "
                             " where entity_id like ? "
                             " and entity_lock_by   =  ? ", Table);

      if (strcmp (Table,"deprogrm") == 0)
         strcat( sql_statement1 ," and entity_status = 'U'");

      printf("\n%s\n", sql_statement1 );

      EXEC SQL prepare upd_stat2 
         from :sql_statement1 ;

      ERR_CHK2("prepare", sql_statement1);

      strcpy( entity_lock_by1, CID_RA_LOCK_BY_DOUBLEQUOTE);
      strcpy( entity_lock_type1, CID_RA_LOCK_TYPE_P );

      EXEC SQL execute upd_stat2
         using :entity_id1,
               :entity_lock_by1;

      printf("entity_id1 %s\n",entity_id1);
      printf("entity_lock_by1 %s\n",entity_lock_by1);

      rc=err_chk("update");
      if (rc != FND_SUCCESS)
         return rc;

      counter_lu = counter_lu + sqlca.sqlerrd[2];
      counter_already_lu= counter_already_lu + (counter_select - sqlca.sqlerrd[2]); 
   }
   return rc;
}


/***************************************************************************/
/* LU_Copybook                                                             */
/***************************************************************************/

short LU_Copybook(char *Object_Name, 
		  unsigned short Lock, 
		  unsigned short Recurs_Lock, 
		  short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id9[ ENTITY_ID_LEN ];
      char rec_entity_id9[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id9, Object_Name);

   EXEC SQL select count(*)
      into :counter_select
      from decopybk
      where entity_id like :entity_id9;

   rc=err_chk("select");

   if (rc != FND_SUCCESS)
      return rc;

   if (counter_select == 0)
      return 0;

   rc = LU_Table("decopybk", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   if (Recurs_Lock)
   {
      EXEC SQL declare copybcursor cursor for
         select c.entity_id
            from wdd0d020 a, decopybk b, derecord c
            where b.entity_id like :entity_id9
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open copybcursor;
      for (;;)
      {
         EXEC SQL fetch copybcursor into :rec_entity_id9;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Record(rec_entity_id9, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close copybcursor;
   }
   return rc;
}




/***************************************************************************/
/* LU_Record                                                               */
/***************************************************************************/

short LU_Record( char *Object_Name, 
		 unsigned short Lock, 
		 unsigned short Recurs_Lock, 
		 short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id4[ ENTITY_ID_LEN ];
      char rgr_entity_id4[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id4, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from derecord
      where entity_id like :entity_id4;

   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("derecord", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   /* record to record group  */
   if (Recurs_Lock)
   {
      EXEC SQL declare recordcursor cursor for
         select c.entity_id
            from drrecrgr a, derecord b, degroup c
            where b.entity_id like :entity_id4
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open recordcursor;
      for (;;)
      {
         EXEC SQL fetch recordcursor into :rgr_entity_id4;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Record_Group(rgr_entity_id4, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;

      }
      EXEC SQL close recordcursor;
   }

   /* record to data element */
   /*
   if (Recurs_Lock)
   {
      EXEC SQL declare recordcursor1 cursor for
         select c.entity_id
            from drrecdte a, derecord b, dedtelem c
            where b.entity_id like :entity_id4
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open recordcursor1;
      for (;;)
      {
         EXEC SQL fetch recordcursor1 into :dte_entity_id4;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Data_Elt(dte_entity_id4, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close recordcursor1;
   }

   */
   return rc;
}



/***************************************************************************/
/* LU_Record_Group                                                         */
/***************************************************************************/

short LU_Record_Group( char *Object_Name, 
		       unsigned short Lock, 
		       unsigned short Recurs_Lock, 
		       short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id5[ ENTITY_ID_LEN ];
      char rgr_entity_id5[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id5, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from degroup
      where entity_id like :entity_id5;

   printf("Conter Select = %d\n", counter_select);
   rc=err_chk("select");

   if (rc != FND_SUCCESS)
      return rc;

   if (counter_select == 0)
      return 0;

   rc = LU_Table("degroup", Object_Name, Lock);

   if (rc != FND_SUCCESS) {
      return rc;
   }
   /* record group to data element */
   /*
   if (Recurs_Lock)
   {
      EXEC SQL declare groupcursor cursor for
         select c.entity_id
            from drrgrdte a, degroup b, dedtelem c
            where b.entity_id like :entity_id5
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open groupcursor;
      for (;;)
      {
         EXEC SQL fetch groupcursor into :dte_entity_id;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Data_Elt(dte_entity_id, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close groupcursor;
   }
   */

   /* record group to record group */
   if (Recurs_Lock)
   {
      EXEC SQL declare rgrcursor cursor for
         select c.entity_id
            from drrgrrgr a, degroup b, degroup c
            where b.entity_id like :entity_id5
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      rc=err_chk("declare");
      EXEC SQL open rgrcursor;
      rc=err_chk("open");
      for (;;)
      {
         EXEC SQL fetch rgrcursor into :rgr_entity_id5;
         rc=err_chk("fetch");
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Record_Group_Level2(rgr_entity_id5, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close rgrcursor;
   }
   return rc;
}

/***************************************************************************/
/* LU_Record_Group_Level2                                                 */
/***************************************************************************/

short LU_Record_Group_Level2( char *Object_Name, 
			      unsigned short Lock, 
			      unsigned short Recurs_Lock, 
			      short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id6[ ENTITY_ID_LEN ];
      char rgr_entity_id6[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id6, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from degroup
      where entity_id like :entity_id6;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("degroup", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   /* record group to record group */
   if (Recurs_Lock)
   {
      EXEC SQL declare rgrcursor2 cursor for
         select c.entity_id
            from drrgrrgr a, degroup b, degroup c
            where b.entity_id like :entity_id6
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;

      rc=err_chk("declare");
      
      EXEC SQL open rgrcursor2;

      rc=err_chk("open");

      for (;;)
      {
         EXEC SQL fetch rgrcursor2 into :rgr_entity_id6;
         rc=err_chk("fetch");
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Record_Group_Level3(rgr_entity_id6, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close rgrcursor2;
   }
   return rc;
}


/***************************************************************************/
/* LU_Record_Group_Level3                                                 */
/***************************************************************************/

short LU_Record_Group_Level3( char *Object_Name, 
                              unsigned short Lock, 
			      unsigned short Recurs_Lock, 
			      short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id7[ ENTITY_ID_LEN ];
      char rgr_entity_id7[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id7, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from degroup
      where entity_id like :entity_id7;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("degroup", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   /* record group to record group */
   if (Recurs_Lock)
   {
      EXEC SQL declare rgrcursor3 cursor for
         select c.entity_id
            from drrgrrgr a, degroup b, degroup c
            where b.entity_id like :entity_id7
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      rc=err_chk("declare");
      EXEC SQL open rgrcursor3;
      rc=err_chk("open");
      for (;;)
      {
         EXEC SQL fetch rgrcursor3 into :rgr_entity_id7;
         rc=err_chk("fetch");
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Record_Group_Level3(rgr_entity_id7, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close rgrcursor3;
   }
   return rc;
}


/***************************************************************************/
/* LU_Record_Group_Level4                                                 */
/***************************************************************************/

short LU_Record_Group_Level4( char *Object_Name, 
                              unsigned short Lock, 
			      unsigned short Recurs_Lock, 
			      short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id7[ ENTITY_ID_LEN ];
      char rgr_entity_id7[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id7, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from degroup
      where entity_id like :entity_id7;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("degroup", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   /* record group to record group */
   if (Recurs_Lock)
   {
      EXEC SQL declare rgrcursor4 cursor for
         select c.entity_id
            from drrgrrgr a, degroup b, degroup c
            where b.entity_id like :entity_id7
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      rc=err_chk("declare");
      EXEC SQL open rgrcursor4;
      rc=err_chk("open");
      for (;;)
      {
         EXEC SQL fetch rgrcursor4 into :rgr_entity_id7;
         rc=err_chk("fetch");
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Record_Group_Level3(rgr_entity_id7, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close rgrcursor3;
   }
   return rc;
}

/***************************************************************************/
/*  LU_Message                                                             */
/***************************************************************************/


short LU_Message( char *Object_Name, 
		  unsigned short Lock, 
		  unsigned short Recurs_Lock, 
		  short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id8[ ENTITY_ID_LEN ];
      char rec_entity_id8[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id8, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from demessge
      where entity_id like :entity_id8;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("demessge", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   if (Recurs_Lock)
   {
      EXEC SQL declare recordcursor2 cursor for
         select c.entity_id
            from wdd0d020 a, demessge b, derecord c
            where b.entity_id like :entity_id8
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open recordcursor2;
      for (;;)
      {
         EXEC SQL fetch recordcursor2 into :rec_entity_id8;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Record(rec_entity_id8, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close recordcursor2;
   }
   return rc;
}

/***************************************************************************/
/*  LU_Source                                                              */
/***************************************************************************/

short LU_Source( char *Object_Name, 
		 unsigned short Lock, 
		 unsigned short Recurs_Lock, 
		 short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id16[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id16, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from desource
      where entity_id like :entity_id16;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("desource", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;
   return rc;
}


/***************************************************************************/
/*  LU_Program                                                             */
/***************************************************************************/

short LU_Program( char *Object_Name, 
		  unsigned short Lock, 
		  unsigned short Recurs_Lock, 
		  short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id13[ ENTITY_ID_LEN ];
      char cop_entity_id13[ ENTITY_ID_LEN ];
      char sou_entity_id13[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id13, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from deprogrm
      where entity_id like :entity_id13
         and entity_status = 'U';
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("deprogrm", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   /* program to copy book */
   if (Recurs_Lock)
   {
      EXEC SQL declare copcursor2 cursor for
         select c.entity_id
            from wdd0d020 a, deprogrm b, decopybk c
            where b.entity_id like :entity_id13
               and b.entity_status ='U'
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open copcursor2;
      for (;;)
      {
         EXEC SQL fetch copcursor2 into :cop_entity_id13;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Copybook(cop_entity_id13, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close copcursor2;
   }

   /* program to source component */
   if (Recurs_Lock)
   {
      EXEC SQL declare soucursor cursor for
         select c.entity_id
            from wdd0d020 a, deprogrm b, desource c
            where b.entity_id like :entity_id13
               and b.entity_status ='U'
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open soucursor;
      for (;;)
      {
         EXEC SQL fetch soucursor into :sou_entity_id13;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Source(sou_entity_id13, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close soucursor;
   }
   return rc;
}



/***************************************************************************/
/*  LU_Service                                                             */
/***************************************************************************/

short LU_Service( char *Object_Name, 
		  unsigned short Lock, 
		  unsigned short Recurs_Lock, 
		  short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id14[ ENTITY_ID_LEN ];
      char mes_entity_id14[ ENTITY_ID_LEN ];
      char pgm_entity_id14[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id14, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from desrvstp
      where entity_id like :entity_id14;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("desrvstp", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   /* service to message */
   if (Recurs_Lock)
   {
      EXEC SQL declare mescursor cursor for
         select c.entity_id
            from wdd0d020 a, desrvstp b, demessge c
            where b.entity_id like :entity_id14
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open mescursor;
      for (;;)
      {
         EXEC SQL fetch mescursor into :mes_entity_id14;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Message(mes_entity_id14, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close mescursor;
   }

   /* service to program */
   if (Recurs_Lock)
   {
      EXEC SQL declare pgmcursor2 cursor for
         select c.entity_id
            from wdd0d020 a, desrvstp b, deprogrm c
            where b.entity_id like :entity_id14
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open pgmcursor2;
      for (;;)
      {
         EXEC SQL fetch pgmcursor2 into :pgm_entity_id14;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Program(pgm_entity_id14, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close pgmcursor2;
   }
   return rc;
}


/***************************************************************************/
/*  LU_Server                                                              */
/***************************************************************************/

short LU_Server( char *Object_Name, 
		 unsigned short Lock, 
		 unsigned short Recurs_Lock, 
		 short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id11[ ENTITY_ID_LEN ];
      char pgm_entity_id11[ ENTITY_ID_LEN ];
      char svc_entity_id11[ ENTITY_ID_LEN ];
      char cop_entity_id11[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id11, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from deserver
      where entity_id like :entity_id11;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("deserver", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   /* server to program */
   if (Recurs_Lock)
   {
      EXEC SQL declare pgmcursor1 cursor for
         select c.entity_id
            from wdd0d020 a, deserver b, deprogrm c
            where b.entity_id like :entity_id11
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open pgmcursor1;
      for (;;)
      {
         EXEC SQL fetch pgmcursor1 into :pgm_entity_id11;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Program(pgm_entity_id11, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close pgmcursor1;
   }

   /* server to service */
   if (Recurs_Lock)
   {
      EXEC SQL declare svccursor cursor for
         select c.entity_id
            from wdd0d020 a, deserver b, desrvstp c
            where b.entity_id like :entity_id11
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open svccursor;
      for (;;)
      {
         EXEC SQL fetch svccursor into :svc_entity_id11;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Service(svc_entity_id11, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close svccursor;
   }

   /* server to copybook */
   if (Recurs_Lock)
   {
      EXEC SQL declare copcursor1 cursor for
         select c.entity_id
            from wdd0d020 a, deserver b, decopybk c
            where b.entity_id like :entity_id11
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open copcursor1;
      for (;;)
      {
         EXEC SQL fetch copcursor1 into :cop_entity_id11;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Copybook(cop_entity_id11, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close copcursor1;
   }
   return rc;
}


/***************************************************************************/
/*  LU_Control                                                             */
/***************************************************************************/


short LU_Control( char *Object_Name, 
	       unsigned short Lock, 
	       unsigned short Recurs_Lock, 
	       short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id20[ ENTITY_ID_LEN ];
      char con_entity_id20[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id20, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from decontrl
      where entity_id like :entity_id20;

   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("decontrl", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   /* menu to menu item*/
   if (Recurs_Lock)
   {
      EXEC SQL declare concursor3 cursor for
         select c.entity_id
            from drctlctl a, decontrl b, decontrl c
            where b.entity_id like :entity_id20
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open concursor3;
      for (;;)
      {
         EXEC SQL fetch concursor3 into :con_entity_id20;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Control(con_entity_id20, Lock, 0, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close concursor3;
   }
   return rc;
}


/***************************************************************************/
/*  LU_List_Box                                                            */
/***************************************************************************/

short LU_List_Box( char *Object_Name, 
		   unsigned short Lock, 
		   unsigned short Recurs_Lock, 
		   short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id17[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id17, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from desgroup
      where entity_id like :entity_id17;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("desgroup", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;
   return rc;
}


/***************************************************************************/
/*  LU_Icon                                                                */
/***************************************************************************/

short LU_Icon( char *Object_Name, 
	       unsigned short Lock, 
	       unsigned short Recurs_Lock, 
	       short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id18[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id18, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from dewinres
      where entity_id like :entity_id18;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("dewinres", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;
   return rc;
}



/***************************************************************************/
/*  LU_Icon                                                                */
/***************************************************************************/

short LU_Window( char *Object_Name, 
		 unsigned short Lock, 
		 unsigned short Recurs_Lock, 
		 short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id15[ ENTITY_ID_LEN ];
      char pgm_entity_id15[ ENTITY_ID_LEN ];
      char con_entity_id15[ ENTITY_ID_LEN ];
      char lib_entity_id15[ ENTITY_ID_LEN ];
      char ico_entity_id15[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id15, Object_Name);

   EXEC SQL select count(*)
      into :counter_select
      from descreen
      where entity_id like :entity_id15;
   
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("descreen", Object_Name, Lock);

   if (rc != FND_SUCCESS)
      return rc;

   /* window to program */
   if (Recurs_Lock)
   {
      EXEC SQL declare pgmcursor3 cursor for
         select c.entity_id
            from drscrpgm a, descreen b, deprogrm c
            where b.entity_id like :entity_id15
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open pgmcursor3;
      for (;;)
      {
         EXEC SQL fetch pgmcursor3 into :pgm_entity_id15;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Program(pgm_entity_id15, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close pgmcursor3;
   }

   /* window to data element */
   /*
   if (Recurs_Lock)
   {
      EXEC SQL declare dtecursor cursor for
         select c.entity_id
            from drscrdte a, descreen b, dedtelem c
            where b.entity_id like :entity_id15
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open dtecursor;
      for (;;)
      {
         EXEC SQL fetch dtecursor into :dte_entity_id15;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Data_Elt(dte_entity_id15, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close dtecursor;
   }
   */

   /* window to push button */
   if (Recurs_Lock)
   {
      EXEC SQL declare concursor1 cursor for
         select c.entity_id
            from drscrctl a, descreen b, decontrl c
            where b.entity_id like :entity_id15
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open concursor1;
      for (;;)
      {
         EXEC SQL fetch concursor1 into :con_entity_id15;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Control(con_entity_id15, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close concursor1;
   }

   /* window to list box */
   if (Recurs_Lock)
   {
      EXEC SQL declare libcursor cursor for
         select c.entity_id
            from drscrsgr a, descreen b, desgroup c
            where b.entity_id like :entity_id15
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open libcursor;
      for (;;)
      {
         EXEC SQL fetch libcursor into :lib_entity_id15;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_List_Box(lib_entity_id15, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close libcursor;
   }

   /* window to icon */
   if (Recurs_Lock)
   {
      EXEC SQL declare icocursor cursor for
         select c.entity_id
            from drscrwrs a, descreen b, dewinres c
            where b.entity_id like :entity_id15
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open icocursor;
      for (;;)
      {
         EXEC SQL fetch icocursor into :ico_entity_id15;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Icon(ico_entity_id15, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close icocursor;
   }
   return rc;
}


/***************************************************************************/
/*  LU_Client                                                              */
/***************************************************************************/

short LU_Client( char *Object_Name, 
		 unsigned short Lock, 
		 unsigned short Recurs_Lock, 
		 short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id10[ ENTITY_ID_LEN ];
      char win_entity_id10[ ENTITY_ID_LEN ];
      char pgm_entity_id10[ ENTITY_ID_LEN ];
      char cop_entity_id10[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id10, Object_Name);

   EXEC SQL select count(*)
      into :counter_select
      from deconv
      where entity_id like :entity_id10;

   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("deconv", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   /* client to window */
   if (Recurs_Lock)
   {
      EXEC SQL declare wincursor cursor for
         select e.entity_id
            from wdd0d020 a, deconv b, destep c, wdd0d020 d, descreen e
            where b.entity_id like :entity_id10
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id
               and c.entity_internal_id = d.parent_internal_id
               and d.child_internal_id = e.entity_internal_id;
      EXEC SQL open wincursor;
      for (;;)
      {
         EXEC SQL fetch wincursor into :win_entity_id10;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Window(win_entity_id10, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close wincursor;
   }

   /* client to program */
   if (Recurs_Lock)
   {
      EXEC SQL declare pgmcursor cursor for
         select c.entity_id
            from drscrpgm a, deconv b, deprogrm c
            where b.entity_id like :entity_id10
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open pgmcursor;
      for (;;)
      {
         EXEC SQL fetch pgmcursor into :pgm_entity_id10;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Program(pgm_entity_id10, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close pgmcursor;
   }

   /* client to BFCD copybook */
   if (Recurs_Lock)
   {
      EXEC SQL declare copcursor cursor for
         select c.entity_id
            from wdd0d020 a, deconv b, decopybk c
            where b.entity_id like :entity_id10
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open copcursor;
      for (;;)
      {
         EXEC SQL fetch copcursor into :cop_entity_id10;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Copybook(cop_entity_id10, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close copcursor;
   }
   return rc;
}


/***************************************************************************/
/*  LU_Executable                                                          */
/***************************************************************************/

short LU_Executable( char *Object_Name, 
		     unsigned short Lock, 
		     unsigned short Recurs_Lock, 
		     short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id23[ ENTITY_ID_LEN ];
      char dll_entity_id23[ ENTITY_ID_LEN ];
      char srv_entity_id23[ ENTITY_ID_LEN ];
      char clt_entity_id23[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy(entity_id23, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from deexunit
      where entity_id like :entity_id23
         and exe_type ='00';
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("deexunit", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   /* Executable to DLL */
   /*
   if (Recurs_Lock)
   {
      EXEC SQL declare dllcursor cursor for
         select c.entity_id
            from wdd0d020 a, deexunit b, deexunit c
            where b.entity_id like :entity_id23
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id
               and b.exe_type='00';
      EXEC SQL open dllcursor;
      for (;;)
      {
         EXEC SQL fetch dllcursor into :dll_entity_id23;
         if (sqlca.sqlcode == SQLNOTFOUND)
            break;
         rc=LU_DLL(dll_entity_id23, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close dllcursor;
   }
   */

   /* Executable to Server */
   if (Recurs_Lock)
   {
      EXEC SQL declare srvcursor cursor for
         select c.entity_id
            from wdd0d020 a, deexunit b, deserver c
            where b.entity_id like :entity_id23
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id
               and b.exe_type='00';
      EXEC SQL open srvcursor;
      for (;;)
      {
         EXEC SQL fetch srvcursor into :srv_entity_id23;
         if (sqlca.sqlcode == SQLNOTFOUND)
            break;
         rc=LU_Server(srv_entity_id23, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close srvcursor;
   }

   /* Executable to Client */
   if (Recurs_Lock)
   {
      EXEC SQL declare cltcursor cursor for
         select c.entity_id
            from wdd0d020 a, deexunit b, deconv c
            where b.entity_id like :entity_id23
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id
               and b.exe_type='00';
      EXEC SQL open cltcursor;
      for (;;)
      {
         EXEC SQL fetch cltcursor into :clt_entity_id23;
         if (sqlca.sqlcode == SQLNOTFOUND)
            break;
         rc=LU_Client(clt_entity_id23, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close cltcursor;
   }
   return rc;
}


/***************************************************************************/
/*  LU_Data_Elt                                                            */
/***************************************************************************/

short LU_Data_Elt( char *Object_Name, 
		   unsigned short Lock, 
		   unsigned short Recurs_Lock, 
		   short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id3[ ENTITY_ID_LEN ];
      char msk_entity_id3[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id3, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from dedtelem
      where entity_id like :entity_id3;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("dedtelem", Object_Name, Lock);
   /* datat elt to mask */
   /*
   if (Recurs_Lock)
   {
      EXEC SQL declare mskcursor cursor for
         select c.entity_id
            from wdd0d020 a, dedtelem b, dedtstrc c
            where b.entity_id like :entity_id3
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open mskcursor;
      for (;;)
      {
         EXEC SQL fetch mskcursor into :msk_entity_id3;
         if (sqlca.sqlcode == SQLNOTFOUND)
            break;
         rc=LU_Mask(msk_entity_id3, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close mskcursor;
   }
   */

   return rc;
} /* end of LU_Data_Elt */


/***************************************************************************/
/*  LU_Mask                                                                */
/***************************************************************************/

short LU_Mask( char *Object_Name, 
	       unsigned short Lock, 
	       unsigned short Recurs_Lock, 
	       short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id19[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id19, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from dedtstrc
      where entity_id like :entity_id19;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("dedtstrc", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;
   return rc;
}


/***************************************************************************/
/*  LU_Generic                                                             */
/***************************************************************************/

short LU_Generic( char *Object_Name, 
	          unsigned short Lock, 
	          unsigned short Recurs_Lock, 
	          char *Object_Table)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id20[ ENTITY_ID_LEN ];
      char entity_type[ 9 ];
   EXEC SQL END DECLARE SECTION;
   short rc;


   strcpy( entity_id20, Object_Name);
   strcpy( entity_type, Object_Table);

   EXEC SQL select count(*)
      into :counter_select
      from document
      where entity_id like :entity_id20
      and entity_type = :entity_type;

   rc=err_chk("select");

   if (rc != FND_SUCCESS)
      return rc;

   if (counter_select == 0)
      return 0;

   rc = LU_Table("document", Object_Name, Lock); 

   if (rc != FND_SUCCESS)
      return rc;

   return rc;
}


/***************************************************************************/
/*  LU_Generic_Wt                                                          */
/***************************************************************************/

short LU_Generic_WT( char *Object_Name, 
	             unsigned short Lock, 
	             unsigned short Recurs_Lock, 
	             char *Object_Table)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id20[ ENTITY_ID_LEN ];
      char entity_type_upp[ 9 ];
      char entity_type_low[ 9 ];
   EXEC SQL END DECLARE SECTION;
   short rc;


   strcpy( entity_id20, Object_Name);
   strcpy( entity_type_upp, Object_Table);
   strcpy( entity_type_low, Object_Table);

   if ((entity_type_low[0] == 'W' ) || (entity_type_low[0] == 'w' ))
   {
      entity_type_low[0] = 'w';
      entity_type_low[1] = 't';

      entity_type_upp[0] = 'W';
      entity_type_upp[1] = 'T';
   }

   EXEC SQL select count(*)
      into :counter_select
      from document
      where entity_id like :entity_id20
      and (entity_type = :entity_type_low
      or entity_type = :entity_type_upp);

   printf("entity_id %s\n", entity_id20);
   printf("entity_type_upp %s\n", entity_type_upp);
   printf("entity_type_low %s\n", entity_type_low);
   printf("object selections %d\n", counter_select );

   rc=err_chk("select");

   if (rc != FND_SUCCESS)
      return rc;

   if (counter_select == 0)
      return 0;

   rc = LU_Table_WT(Object_Table, Object_Name, Lock); 

   if (rc != FND_SUCCESS)
      return rc;

   return rc;
}



/***************************************************************************/
/* LU_Table_WT                                                             */
/***************************************************************************/

short LU_Table_WT( char *Table, 
		char *Object_Name, 
		unsigned short Lock)
{
   short rc;
   EXEC SQL BEGIN DECLARE SECTION;
      char sql_statement1[400];
      char entity_id1[ ENTITY_ID_LEN ];
      char entity_type_upp[ 9 ];
      char entity_type_low[ 9 ];
      char entity_lock_by1[ ENTITY_ID_LEN ];
      char entity_lock_type1[ LOCK_TYPE_LEN ];
   EXEC SQL END DECLARE SECTION;

   strcpy( entity_type_upp, Table);
   strcpy( entity_type_low, Table);
   strcpy( entity_id1, Object_Name);

   printf("Table %s\n", Table);

   if ((entity_type_low[0] == 'W' ) || (entity_type_low[0] == 'w' ))
   {
       entity_type_low[0] = 'w';
       entity_type_low[1] = 't';

       entity_type_upp[0] = 'W';
       entity_type_upp[1] = 'T';
   }

   printf("%s\n", entity_type_upp);
   printf("%s\n", entity_type_low);

   if (Lock)
   {
      sprintf (sql_statement1,"update document "
                 " set entity_lock_by = ?, "
                 " entity_lock_type = ? "
                 " where entity_id LIKE ? "
                 " and ( entity_type = ? "
                 " or entity_type = ? ) "
                 " and entity_lock_by = ''");

      printf("\n%s\n", sql_statement1 );


      EXEC SQL prepare upd_stat1
         from :sql_statement1;

      ERR_CHK2("prepare", sql_statement1);

      strcpy( entity_lock_by1, CID_RA_LOCK_BY_DOUBLEQUOTE);
      strcpy( entity_lock_type1, CID_RA_LOCK_TYPE_P );
      EXEC SQL execute upd_stat1
         using :entity_lock_by1,
               :entity_lock_type1,
               :entity_id1,
               :entity_type_low,
               :entity_type_upp;

      printf("entity_lock_by1 %s\n",entity_lock_by1);
      printf("entity_lock_type1 %s\n",entity_lock_type1);
      printf("entity_id1 %s\n",entity_id1);

      printf("entity_type_low %s\n",entity_type_low);
      printf("entity_type_upp %s\n",entity_type_upp);

      rc=err_chk("update");
      if (rc != FND_SUCCESS)
         return rc;
     
      counter_lu = counter_lu + sqlca.sqlerrd[2];
      counter_already_lu= counter_already_lu + (counter_select - sqlca.sqlerrd[2]);
   }
   else /* if unlock */
   {
      memset(sql_statement1 , 0, sizeof(sql_statement1) );

      sprintf (sql_statement1,"update document "
                             " set entity_lock_by = '', "
                             " entity_lock_type = ''  "
                             " where entity_id like ? "
                             " and entity_lock_by   =  ? "
                             " and (entity_type = ? "
                             " or entity_type = ? )");

      printf("\n%s\n", sql_statement1 );

      EXEC SQL prepare upd_stat2 
         from :sql_statement1 ;

      ERR_CHK2("prepare", sql_statement1);

      strcpy( entity_lock_by1, CID_RA_LOCK_BY_DOUBLEQUOTE);
      strcpy( entity_lock_type1, CID_RA_LOCK_TYPE_P );

      EXEC SQL execute upd_stat2
         using :entity_id1,
               :entity_lock_by1,
               :entity_type_low,
               :entity_type_upp;

      printf("entity_id1 %s\n",entity_id1);
      printf("entity_lock_by1 %s\n",entity_lock_by1);
      printf("entity_type_low %s\n",entity_type_low);
      printf("entity_type_upp %s\n",entity_type_upp);


      rc=err_chk("update");
      if (rc != FND_SUCCESS)
         return rc;

      counter_lu = counter_lu + sqlca.sqlerrd[2];
      counter_already_lu= counter_already_lu + (counter_select - sqlca.sqlerrd[2]); 
   }
   return rc;
}




/***************************************************************************/
/* LU_Codes_Table                                                          */
/***************************************************************************/

short LU_Codes_Table( char *Object_Name, 
		      unsigned short Lock, 
		      unsigned short Recurs_Lock, 
		      short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id25[ ENTITY_ID_LEN ];
      char rec_entity_id25[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id25, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from dectable
      where entity_id like :entity_id25;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("dectable", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   /* codes toble to record */
   if (Recurs_Lock)
   {
      EXEC SQL declare reccursor cursor for
         select c.entity_id
            from wdd0d020 a, dectable b, derecord c
            where b.entity_id like :entity_id25
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id ;
      EXEC SQL open reccursor;
      for (;;)
      {
         EXEC SQL fetch reccursor into :rec_entity_id25;
         if (sqlca.sqlcode == SQLNOTFOUND)
            break;
         rc=LU_Record(rec_entity_id25, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close reccursor;
   }
   return rc;
}



/***************************************************************************/
/* LU_Relat_Table                                                          */
/***************************************************************************/

short LU_Relat_Table( char *Object_Name, 
		      unsigned short Lock, 
		      unsigned short Recurs_Lock, 
		      short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id12[ ENTITY_ID_LEN ];
      char rec_entity_id12[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id12, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from dedtable
      where entity_id like :entity_id12;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("dedtable", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;

   /* relational table to records */
   if (Recurs_Lock)
   {
      EXEC SQL declare reccursor1 cursor for
         select c.entity_id
            from wdd0d020 a, dedtable b, derecord c
            where b.entity_id like :entity_id12
               and b.entity_internal_id = a.parent_internal_id
               and a.child_internal_id  = c.entity_internal_id;
      EXEC SQL open reccursor1;
      for (;;)
      {
         EXEC SQL fetch reccursor1 into :rec_entity_id12;
         if (sqlca.sqlcode != 0)
            break;
         rc=LU_Record(rec_entity_id12, Lock, Recurs_Lock, Level+1);
         if (rc != FND_SUCCESS)
            break;
      }
      EXEC SQL close reccursor1;
   }
   return rc;

}




/***************************************************************************/
/*  LU_File                                                                */
/***************************************************************************/

short LU_File( char *Object_Name, 
	       unsigned short Lock, 
	       unsigned short Recurs_Lock, 
	       short Level)
{
   EXEC SQL BEGIN DECLARE SECTION;
      char entity_id19[ ENTITY_ID_LEN ];
   EXEC SQL END DECLARE SECTION;
   short rc;

   strcpy( entity_id19, Object_Name);
   EXEC SQL select count(*)
      into :counter_select
      from defile
      where entity_id like :entity_id19;
   rc=err_chk("select");
   if (rc != FND_SUCCESS)
      return rc;
   if (counter_select == 0)
      return 0;

   rc = LU_Table("defile", Object_Name, Lock);
   if (rc != FND_SUCCESS)
      return rc;
   return rc;
}


