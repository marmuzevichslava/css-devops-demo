/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS004C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/21/96                                                */
/*              Time: 14:20:09                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _WCDAZCS004C                        */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZCS004C_z                                                          
#define _WCDAZCS004C_z                                                          
                                                                                
   typedef struct __WCDAzcs004c                                                 
   {                                                                            
      _ARCHDATA ArchData;  
      _WCD_DATA WCD; /*mdc 03/21/96 not in FCP*/                                                     
   }  _WCDAZCS004C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZCS004C                               
                                                                                
