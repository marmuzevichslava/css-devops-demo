/******************************************************************************/
/*                                                                            */
/*   Header name  :   ATDW004C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 08/27/95                                                */
/*              Time: 14:56:09                                                */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDATDW004C_z                                                          
#define _WCDATDW004C_z                                                          
                                                                                
   typedef struct __WCDAtdw004c                                                 
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDATDW004C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDATDW004C                               
                                                                                
