/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZDW005C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 08/18/93                                                */
/*              Time: 14:20:39                                                */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK        *pArchBlock;                                          
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZDW005C_z
#define _WCDAZDW005C_z
                                                                                
   typedef struct __WCDAzdw005c
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDAZDW005C;
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZDW005C
                                                                                
