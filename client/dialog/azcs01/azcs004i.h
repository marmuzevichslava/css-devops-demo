/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS004I                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 05/10/93                                                */
/*              Time: 14:10:07                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _AZCS004I                           */
/******************************************************************************/
/* csc: 06/04/93 added relate.h stuff for now */

#ifndef   ARC00311_LEN
#define   ARC00311_LEN                         34                               
#endif                                                                          
#ifndef   ARC00311_LEN                                                          
#define   ARC00311_LEN                         34                               
#endif                                                                          
#ifndef _CLNTGRP_z                                                              
#define _CLNTGRP_z                                                              
typedef struct __ClntGrp                                                        
{                                                                               
   char            ControlName[ARC00311_LEN];                                   
   unsigned long   LevelNumber;                                                 
}  _CLNTGRP;                                                                    
#endif                                                                          
#ifndef _SRVGRP_z                                                               
#define _SRVGRP_z                                                               
typedef struct __SrvGrp                                                         
{                                                                               
   char            ControlName[ARC00311_LEN];                                   
   unsigned long   LevelNumber;                                                 
}  _SRVGRP;                                                                     
#endif                                                                          
                                                                                
#ifndef _RELATE_z                                                               
#define _RELATE_z                                                               
                                                                                
   typedef struct __Relate                                                      
   {                                                                            
      _CLNTGRP ClntGrp;                                                         
      _SRVGRP SrvGrp;                                                           
      struct __RELATE   *pNextRelate;
   }  _RELATE;                                                                  
#endif                                                                          

#ifndef   ARC00303_LEN                                                          
#define   ARC00303_LEN                         33                               
#endif                                                                          
#ifndef   _AZCS004I__SERVICES_SIZE                                              
#define   _AZCS004I__SERVICES_SIZE             10                               
#endif                                                                          
#ifndef _SERVICES_z                                                             
#define _SERVICES_z                                                             
typedef struct __Services                                                       
{                                                                               
   char ServerLayout[10];    /* CSC: 06/03/93 */
}  _SERVICES;
#endif                                                                          
                                                                                
#ifndef _AZCS004I_z
#define _AZCS004I_z
                                                                                
   typedef struct __Azcs004i
   {                                                                            
      char            ClientLayout[ARC00303_LEN];
      short    NumServices;                       /* CSC:07/21/93 */
      _SERVICES Services[_AZCS004I__SERVICES_SIZE];                             
      _RELATE        *pRelate;                                                  
   }  _AZCS004I;
#endif                                                                          
