/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZRP001C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/29/96                                                */
/*              Time: 09:27:06                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _WCDAZRP001C                        */
/******************************************************************************/
                                                                                
#ifndef   ARC00402_LEN                                                          
#define   ARC00402_LEN                         9                                
#define   ENTITYTYPE_LEN                       9                                
#endif                                                                          
#ifndef   ARC00403_LEN                                                          
#define   ARC00403_LEN                         33                               
#define   ENTITYID_LEN                         33                               
#endif                                                                          
#ifndef   _REPLYHDR__ENTITYTEXT_SIZE                                            
#define   _REPLYHDR__ENTITYTEXT_SIZE           8                                
#endif                                                                          
#ifndef   ARC00421_LEN                                                          
#define   ARC00421_LEN                         80                               
#define   ENTITYTEXT_LEN                       80                               
#endif                                                                          
#ifndef   ARC00429_LEN                                                          
#define   ARC00429_LEN                         32                               
#define   TABNAME_LEN                          32                               
#endif                                                                          
#ifndef   _AZRP001C__ENTITYDATA_SIZE                                            
#define   _AZRP001C__ENTITYDATA_SIZE           200                              
#endif                                                                          
#ifndef   ARC00401_LEN                                                          
#define   ARC00401_LEN                         9                                
#define   ENTITYINTERNALID_LEN                 9                                
#endif                                                                          
#ifndef   ARC00402_LEN                                                          
#define   ARC00402_LEN                         9                                
#define   ENTITYTYPE_LEN                       9                                
#endif                                                                          
#ifndef   ARC00403_LEN                                                          
#define   ARC00403_LEN                         33                               
#define   ENTITYID_LEN                         33                               
#endif                                                                          
#ifndef   ARC00404_LEN                                                          
#define   ARC00404_LEN                         31                               
#define   ENTITYCOBOLNAME_LEN                  31                               
#endif                                                                          
#ifndef   ARC00405_LEN                                                          
#define   ARC00405_LEN                         32                               
#define   ENTITYCNAME_LEN                      32                               
#endif                                                                          
#ifndef   ARC00408_LEN                                                          
#define   ARC00408_LEN                         1                                
#define   DTETYPECODE_LEN                      1                                
#endif                                                                          
#ifndef   ARC00410_LEN                                                          
#define   ARC00410_LEN                         1                                
#define   DTEINTFORMAT_LEN                     1                                
#endif                                                                          
#ifndef   ARC00412_LEN                                                          
#define   ARC00412_LEN                         3                                
#define   DTEINTSTRUCT_LEN                     3                                
#endif                                                                          
#ifndef   ARC00413_LEN                                                          
#define   ARC00413_LEN                         3                                
#define   DTEINTUSAGE_LEN                      3                                
#endif                                                                          
#ifndef   ARC00415_LEN                                                          
#define   ARC00415_LEN                         1                                
#define   RELATNULFL_LEN                       1                                
#endif                                                                          
#ifndef   ARC00416_LEN                                                          
#define   ARC00416_LEN                         1                                
#define   RELATDEFAULTFL_LEN                   1                                
#endif                                                                          
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
#ifndef _REQUESTHDR_z                                                           
#define _REQUESTHDR_z                                                           
typedef struct __RequestHdr                                                     
{                                                                               
   char                EntityType[9];                                           
   char                EntityId[33];                                            
   unsigned short      MaxRows;                                                 
}  _REQUESTHDR;                                                                 
#endif                                                                          
#ifndef _REPLYHDR_z                                                             
#define _REPLYHDR_z                                                             
typedef struct __ReplyHdr                                                       
{                                                                               
   unsigned short      NumTextRows;                                             
   char                EntityText[_REPLYHDR__ENTITYTEXT_SIZE][80];              
   unsigned short      RowsReturned;                                            
   unsigned long       SqlCode;                                                 
   char                TabName[32];                                             
}  _REPLYHDR;                                                                   
#endif                                                                          
#ifndef _ENTITYDATA_z                                                           
#define _ENTITYDATA_z                                                           
typedef struct __EntityData                                                     
{                                                                               
   char                EntityInternalId[9];                                     
   char                EntityType[9];                                           
   char                EntityId[33];                                            
   char                EntityCobolName[31];                                     
   char                EntityCName[32];                                         
   unsigned long       EntityLgth;                                              
   unsigned short      EntityLevel;                                             
   char                DteTypeCode;                                             
   unsigned long       DteIntLength;                                            
   char                DteIntFormat;                                            
   unsigned short      DteIntPrecision;                                         
   char                DteIntStruct[3];                                         
   char                DteIntUsage[3];                                          
   unsigned long       RelatOccFact;                                            
   char                RelatNulFl;                                              
   char                RelatDefaultFl;                                          
   unsigned short      EntityParent;                                            
   unsigned short      EntityChild;                                             
   unsigned short      EntitySibling;                                           
}  _ENTITYDATA;                                                                 
#endif                                                                          
                                                                                
#ifndef _WCDAZRP001C_z                                                          
#define _WCDAZRP001C_z                                                          
                                                                                
   typedef struct __WCDAZRP001C                                                 
   {                                                                            
      _ARCHDATA ArchData;                                                       
      _REQUESTHDR RequestHdr;                                                   
      _REPLYHDR ReplyHdr;                                                       
      _ENTITYDATA EntityData[_AZRP001C__ENTITYDATA_SIZE];                       
   }  _WCDAZRP001C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WCD_RequestHdr pWindContextData->RequestHdr                             
#define WCD_ReplyHdr pWindContextData->ReplyHdr                                 
#define WCD_EntityData pWindContextData->EntityData                             
#define WINCONTEXTNAME               _WCDAZRP001C                               
                                                                                
