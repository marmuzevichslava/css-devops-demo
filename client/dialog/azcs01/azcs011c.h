/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS011C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/21/96                                                */
/*              Time: 14:20:25                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _WCDAZCS011C                        */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZCS011C_z                                                          
#define _WCDAZCS011C_z                                                          
                                                                                
   typedef struct __WCDAzcs011c                                                 
   {                                                                            
      _ARCHDATA ArchData;  
      _WCD_DATA WCD; /*mdc 03/22/96 not defined in FCP*/                                                     
   }  _WCDAZCS011C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZCS011C                               
                                                                                
