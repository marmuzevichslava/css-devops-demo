/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZDW004C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 08/10/93                                                */
/*              Time: 17:31:14                                                */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK        *pArchBlock;                                          
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZCS004C_z                                                          
#define _WCDAZCS004C_z                                                          
                                                                                
   typedef struct __WCDAzcs004c                                                 
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDAZCS004C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZCS004C                               
                                                                                
