/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZRP003C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/29/96                                                */
/*              Time: 09:27:15                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _WCDAZRP003C                        */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZRP003C_z                                                          
#define _WCDAZRP003C_z                                                          
                                                                                
   typedef struct __WCDAZRP003C                                                 
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDAZRP003C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZRP003C                               
                                                                                
