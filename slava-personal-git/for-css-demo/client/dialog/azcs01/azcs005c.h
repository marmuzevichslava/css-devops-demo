/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS005C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/21/96                                                */
/*              Time: 14:20:13                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _WCDAZCS005C                        */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZCS005C_z                                                          
#define _WCDAZCS005C_z                                                          
                                                                                
   typedef struct __WCDAzcs005c                                                 
   {                                                                            
      _ARCHDATA ArchData;   
      _WCD_DATA WCD; /*mdc 03/22/96 not defined in FCP*/                                                    
      CHAR      *pWorkingStorageData;	/* NEYDE 03/25/99 */
   }  _WCDAZCS005C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZCS005C                               
                                                                                
