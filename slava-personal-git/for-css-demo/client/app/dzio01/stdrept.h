/***************************************************************************
*                                                                          *
*                      C    H E A D E R    F I L E                         *
*                                                                          *
*    (c) Copyright 1994,1996  Andersen Consulting.  All Rights Reserved.   *
*                                                                          *
****************************************************************************
*                                                                          *
*                     Header file for: STDREPT                             *
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
* Definition for Record.AZRP001C
***************************************************************************/
#ifndef   _AZRP001C__ENTITYDATA_SIZE
#define   _AZRP001C__ENTITYDATA_SIZE            416
#endif
#ifndef _WCDAZRP001C_z
#define _WCDAZRP001C_z

typedef struct __WCDAZRP001C
{
   _ARCHDATA             ArchData;
   _REQUESTHDR           RequestHdr;
   _REPLYHDR             ReplyHdr;
   _ENTITYDATA           EntityData[416];
}  _WCDAZRP001C;
#endif

#define  WCD_ArchData          pWindContextData->ArchData
#define  WCD_RequestHdr        pWindContextData->RequestHdr
#define  WCD_ReplyHdr          pWindContextData->ReplyHdr
#define  WCD_EntityData        pWindContextData->EntityData

#define  WINCONTEXTNAME        _WCDAZRP001C

