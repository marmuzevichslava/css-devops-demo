/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZDW002C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 08/10/93                                                */
/*              Time: 17:31:08                                                */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK        *pArchBlock;                                          
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZDW001C_z
#define _WCDAZDW001C_z
                                                                                
   typedef struct __WCDAzdw001c
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDAZDW001C;
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZDW001C
                                                                                
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK        *pArchBlock;                                          
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDARCHDATA_z                                                          
#define _WCDARCHDATA_z                                                          
                                                                                
   typedef struct __WCDArchData                                                 
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDARCHDATA;                                                             
#endif                                                                          
                                                                                
                                                                                
