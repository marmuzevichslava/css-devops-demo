
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


#define LOCK_TYPE_LEN    2
#define ENTITY_ID_LEN   33

/***************************************************************************/
/* Global Variables                                                        */
/***************************************************************************/
unsigned long counter_lu            = 0;
unsigned long counter_already_lu    = 0;
unsigned long counter_unable_to_lu  = 0;
char errmsg[512];
FILE *f;

/***************************************************************************/
/* LU_Table
/***************************************************************************/

short LU_Table(char *Table, char *Object_Name, unsigned short Lock)
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
      rc=err_chk("update");
      if (rc != FND_SUCCESS)
         return rc;
     
      counter_lu = counter_lu + sqlca.sqlerrd[2];
      counter_already_lu= counter_already_lu + (counter_select - sqlca.sqlerrd[2]);
   }
   else
   {
      sprintf (sql_statement1,"update %s "
                             " set entity_lock_by = '', "
                             " entity_lock_type = ''  "
                             " where entity_id like ? "
                             " and entity_lock_by   =  ? ", Table);
      if (strcmp (Table,"deprogrm") == 0)
         strcat( sql_statement1 ," and entity_status = 'U'");
      EXEC SQL prepare upd_stat2 
         from :sql_statement1 ;
      ERR_CHK2("prepare", sql_statement1);

      strcpy( entity_lock_by1, CID_RA_LOCK_BY_DOUBLEQUOTE);
      strcpy( entity_lock_type1, CID_RA_LOCK_TYPE_P );
      EXEC SQL execute upd_stat2
         using :entity_id1,
               :entity_lock_by1;
      rc=err_chk("update");
      if (rc != FND_SUCCESS)
         return rc;

      counter_lu = counter_lu + sqlca.sqlerrd[2];
      counter_already_lu= counter_already_lu + (counter_select - sqlca.sqlerrd[2]); 
   }
   return rc;
}


