/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS008C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/21/96                                                */
/*              Time: 14:20:15                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _WCDAZCS008C                        */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZCS008C_z                                                          
#define _WCDAZCS008C_z                                                          
                                                                                
   typedef struct __WCDAzcs008c                                                 
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDAZCS008C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZCS008C                               
                                                                                
