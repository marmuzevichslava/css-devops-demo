/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS002C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/21/96                                                */
/*              Time: 14:19:51                                                */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZCS002C_z                                                          
#define _WCDAZCS002C_z                                                          
                                                                                
   typedef struct __WCDAzcs002c                                                 
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDAZCS002C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZCS002C                               
                                                                                
