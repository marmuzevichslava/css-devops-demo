/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS013C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/21/96                                                */
/*              Time: 14:20:27                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _WCDAZCS013C                        */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZCS013C_z                                                          
#define _WCDAZCS013C_z                                                          
                                                                                
   typedef struct __WCDAzcs013c                                                 
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDAZCS013C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZCS013C                               
                                                                                
