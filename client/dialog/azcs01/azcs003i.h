/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS003I                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 08/11/94                                                */
/*              Time: 13:33:24                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _AZCS003I                           */
/******************************************************************************/
                                                                                
#ifndef   ARC00305_LEN                                                          
#define   ARC00305_LEN                         10                               
#endif                                                                          
#ifndef   ARC00307_LEN                                                          
#define   ARC00307_LEN                         11                               
#endif                                                                          
#ifndef   ARC00329_LEN                                                          
#define   ARC00329_LEN                         2                                
#endif                                                                          
#ifndef   ARC00330_LEN                                                          
#define   ARC00330_LEN                         10                               
#endif                                                                          
#ifndef   ARC00335_LEN                                                          
#define   ARC00335_LEN                         3                                
#endif                                                                          
#ifndef   ARC00452_LEN                                                          
#define   ARC00452_LEN                         2                                
#endif                                                                          
                                                                                
#ifndef _AZCS003I_z                                                             
#define _AZCS003I_z                                                             
                                                                                
   typedef struct __Azcs003i                                                    
   {                                                                            
      unsigned long       Arc00321;                                             
      unsigned long       Server;                                               
      unsigned short      ServiceID;                                            
      char                TranMap[ARC00305_LEN];                                
      unsigned long       ServiceAge;                                           
      char                AnticModule[ARC00307_LEN];                            
      char                Flush[ARC00329_LEN];                                  
      char                AltMap[ARC00330_LEN];                                 
      char                ServiceMapType[ARC00335_LEN];                         
      char                ForceCall[ARC00452_LEN];                              
   }  _AZCS003I;                                                                
#endif                                                                          
                                                                                
