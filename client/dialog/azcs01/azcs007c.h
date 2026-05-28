/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS007C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/21/96                                                */
/*              Time: 14:20:07                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _WCDAZCS007C                        */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZCS007C_z                                                          
#define _WCDAZCS007C_z                                                          
                                                                                
   typedef struct __WCDAzcs007c                                                 
   {                                                                            
      _ARCHDATA ArchData; 
      _WCD_DATA WCD; /*mdc 03/21/96 Structure not in FCP*/                                                      
   }  _WCDAZCS007C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZCS007C                               
                                                                                
