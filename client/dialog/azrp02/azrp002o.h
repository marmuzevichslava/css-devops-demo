/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZRP002O                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/29/96                                                */
/*              Time: 09:27:14                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _AZRP002OUTPUT                      */
/******************************************************************************/
                                                                                
#ifndef   AZRP0015_LEN                                                          
#define   AZRP0015_LEN                         2                                
#define   PRINTDEST_LEN                        2                                
#endif                                                                          
#ifndef   AZRP0017_LEN                                                          
#define   AZRP0017_LEN                         256                              
#define   PRINTFILE_LEN                        256                              
#endif                                                                          
#ifndef   AZRP0022_LEN                                                          
#define   AZRP0022_LEN                         2                                
#define   DUPLEX_LEN                           2                                
#endif                                                                          
                                                                                
#ifndef _AZRP002OUTPUT_z                                                        
#define _AZRP002OUTPUT_z                                                        
                                                                                
   typedef struct __AZRP002Output                                               
   {                                                                            
      char                PrintDest[2];                                         
      char                PrintFile[256];                                       
      char                Duplex[2];                                            
   }  _AZRP002OUTPUT;                                                           
#endif                                                                          
                                                                                
