/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS014C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/21/96                                                */
/*              Time: 14:20:29                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _WCDAZCS014C                        */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZCS014C_z                                                          
#define _WCDAZCS014C_z                                                          
                                                                                
   typedef struct __WCDAzcs014c                                                 
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDAZCS014C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZCS014C                               
                                                                                
