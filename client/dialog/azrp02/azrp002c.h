/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZRP002C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/29/96                                                */
/*              Time: 09:27:13                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _WCDAZRP002C                        */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK *pArchBlock;                                                 
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZRP002C_z                                                          
#define _WCDAZRP002C_z                                                          
                                                                                
   typedef struct __WCDAZRP002C                                                 
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDAZRP002C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZRP002C                               
                                                                                
