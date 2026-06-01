/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS006C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/21/96                                                */
/*              Time: 14:20:03                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _WCDAZCS006C                        */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZCS006C_z                                                          
#define _WCDAZCS006C_z                                                          
                                                                                
   typedef struct __WCDAzcs006c                                                 
   {                                                                            
      _ARCHDATA ArchData;
      _WCD_DATA WCD; /*mdc 03/21/96 Structure not in FCP*/                                                       
      CHAR      *pWorkingStorageData;	/* NEYDE 03/25/99 */
   }  _WCDAZCS006C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZCS006C                               
                                                                                
