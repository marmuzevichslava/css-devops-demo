/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: DZIO014C                            *
*                        Generated on: Tue Oct 01 09:25:43 1996            *
*                                  by: IPEREZAR                            *
*                   Short Description:                                     *
*                                                                          *
****************************************************************************/

/***************************************************************************
* Definition for Record Group.AGRCO10
***************************************************************************/
#ifndef _ARCHDATA_z
#define _ARCHDATA_z

typedef struct __ArchData
{
   _CMN_ARCH_BLOCK*      pArchBlock;
}  _ARCHDATA;
#endif
/***************************************************************************
* Definition for Record Group.AZRP0001 ENTITYDATA
***************************************************************************/
#ifndef   ARC00401_LEN
#define   ARC00401_LEN                          9
#define   ENTITYINTERNALID_LEN                  9
#endif
#ifndef   ARC00402_LEN
#define   ARC00402_LEN                          9
#define   ENTITYTYPE_LEN                        9
#endif
#ifndef   ARC00403_LEN
#define   ARC00403_LEN                          33
#define   ENTITYID_LEN                          33
#endif
#ifndef   ARC00404_LEN
#define   ARC00404_LEN                          31
#define   ENTITYCOBOLNAME_LEN                   31
#endif
#ifndef   ARC00405_LEN
#define   ARC00405_LEN                          32
#define   ENTITYCNAME_LEN                       32
#endif
#ifndef   ARC00412_LEN
#define   ARC00412_LEN                          3
#define   DTEINTSTRUCT_LEN                      3
#endif
#ifndef   ARC00413_LEN
#define   ARC00413_LEN                          3
#define   DTEINTUSAGE_LEN                       3
#endif
#ifndef _ENTITYDATA_z
#define _ENTITYDATA_z

typedef struct __EntityData
{
   char                  EntityInternalId[9];
   char                  EntityType[9];
   char                  EntityId[33];
   char                  EntityCobolName[31];
   char                  EntityCName[32];
   unsigned long         EntityLgth;
   unsigned short        EntityLevel;
   char                  DteTypeCode;
   unsigned long         DteIntLength;
   char                  DteIntFormat;
   unsigned short        DteIntPrecision;
   char                  DteIntStruct[3];
   char                  DteIntUsage[3];
   unsigned long         RelatOccFact;
   char                  RelatNulFl;
   char                  RelatDefaultFl;
   unsigned short        EntityParent;
   unsigned short        EntityChild;
   unsigned short        EntitySibling;
}  _ENTITYDATA;
#endif
/***************************************************************************
* Definition for Record Group.AZRP0002 REQUESTHDR
***************************************************************************/
#ifndef   ARC00402_LEN
#define   ARC00402_LEN                          9
#define   ENTITYTYPE_LEN                        9
#endif
#ifndef   ARC00403_LEN
#define   ARC00403_LEN                          33
#define   ENTITYID_LEN                          33
#endif
#ifndef _REQUESTHDR_z
#define _REQUESTHDR_z

typedef struct __RequestHdr
{
   char                  EntityType[9];
   char                  EntityId[33];
   unsigned short        MaxRows;
}  _REQUESTHDR;
#endif
/***************************************************************************
* Definition for Record Group.AZRP0003 REPLYHDR
***************************************************************************/
#ifndef   ARC00421_LEN
#define   ARC00421_LEN                          80
#define   ENTITYTEXT_LEN                        80
#endif
#ifndef   _REPLYHDR__ENTITYTEXT_SIZE
#define   _REPLYHDR__ENTITYTEXT_SIZE            8
#endif
#ifndef   ARC00429_LEN
#define   ARC00429_LEN                          32
#define   TABNAME_LEN                           32
#endif
#ifndef _REPLYHDR_z
#define _REPLYHDR_z

typedef struct __ReplyHdr
{
   unsigned short        NumTextRows;
   char                  EntityText[8][80];
   unsigned short        RowsReturned;
   unsigned long         SqlCode;
   char                  TabName[32];
}  _REPLYHDR;
#endif
/***************************************************************************
* Definition for Record Group.DZIO014R
***************************************************************************/
#ifndef   DZ00732_VIEW_NAME_LEN
#define   DZ00732_VIEW_NAME_LEN                 19
#define   VW_NM_LEN                             19
#endif
#ifndef   DZ00806_ELM_TBL_ID_LEN
#define   DZ00806_ELM_TBL_ID_LEN                19
#define   ELMTBLID_LEN                          19
#endif
#ifndef   DZ00805_ELM_ID_LEN
#define   DZ00805_ELM_ID_LEN                    9
#define   ELMID_LEN                             9
#endif
#ifndef   DZ00807_JOIN_ELM_TBL_NM_LEN
#define   DZ00807_JOIN_ELM_TBL_NM_LEN           19
#define   JOINELMTBLNM_LEN                      19
#endif
#ifndef   DZ00808_JOIN_ELM_ID_LEN
#define   DZ00808_JOIN_ELM_ID_LEN               9
#define   JOINELMID_LEN                         9
#endif
#ifndef _DZIO014RQST_z
#define _DZIO014RQST_z

typedef struct __DZIO014Rqst
{
   unsigned long         QyJoins;
   char                  Vw_Nm[19];
   char                  ElmTblId[19];
   char                  ElmId[9];
   char                  JoinElmTblNm[19];
   char                  JoinElmId[9];
}  _DZIO014RQST;
#endif
/***************************************************************************
* Definition for Record.DZIO014C
***************************************************************************/
#ifndef _DZIO014C_z
#define _DZIO014C_z

typedef struct __Dzio014c
{
   _ARCHDATA             ArchData;
   _ENTITYDATA           EntityData;
   _REQUESTHDR           RequestHdr;
   _REPLYHDR             ReplyHdr;
   _DZIO014RQST          DZIO014Rqst;
}  _DZIO014C;
#endif


