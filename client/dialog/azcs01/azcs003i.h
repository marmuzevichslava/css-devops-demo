/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS003I                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/21/96                                                */
/*              Time: 14:20:22                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _AZCS003I                           */
/******************************************************************************/
                                                                                
#ifndef   ARC00305_LEN                                                          
#define   ARC00305_LEN                         10                               
#define   TRANMAP_LEN                          10                               
#endif                                                                          
#ifndef   ARC00307_LEN                                                          
#define   ARC00307_LEN                         11                               
#define   ANTICMODULE_LEN                      11                               
#endif                                                                          
#ifndef   ARC00329_LEN                                                          
#define   ARC00329_LEN                         2                                
#define   FLUSH_LEN                            2                                
#endif                                                                          
#ifndef   ARC00330_LEN                                                          
#define   ARC00330_LEN                         10                               
#define   ALTMAP_LEN                           10                               
#endif                                                                          
#ifndef   ARC00335_LEN                                                          
#define   ARC00335_LEN                         3                                
#define   SERVICEMAPTYPE_LEN                   3                                
#endif                                                                          
#ifndef   ARC00452_LEN                                                          
#define   ARC00452_LEN                         2                                
#define   FORCECALL_LEN                        2                                
#endif                                                                          
                                                                                
#ifndef _AZCS003I_z                                                             
#define _AZCS003I_z                                                             
                                                                                
   typedef struct __Azcs003i                                                    
   {                                                                            
      unsigned long       Arc00321;                                             
      unsigned long       Server;                                               
      unsigned short      ServiceID;                                            
      char                TranMap[10];                                          
      unsigned long       ServiceAge;                                           
      char                AnticModule[11];                                      
      char                Flush[2];                                             
      char                AltMap[10];                                           
      char                ServiceMapType[3];                                    
      char                ForceCall[2];                                         
   }  _AZCS003I;                                                                
#endif                                                                          
                                                                                
