/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZRP003O                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/29/96                                                */
/*              Time: 09:27:16                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _AZRP003OUTPUT                      */
/******************************************************************************/
                                                                                
#ifndef   AZRP0015_LEN                                                          
#define   AZRP0015_LEN                         2                                
#define   PRINTDEST_LEN                        2                                
#endif                                                                          
#ifndef   AZRP0016_LEN                                                          
#define   AZRP0016_LEN                         256                              
#define   BATCHLISTFILE_LEN                    256                              
#endif                                                                          
#ifndef   AZRP0017_LEN                                                          
#define   AZRP0017_LEN                         256                              
#define   PRINTFILE_LEN                        256                              
#endif                                                                          
#ifndef   AZRP0022_LEN                                                          
#define   AZRP0022_LEN                         2                                
#define   DUPLEX_LEN                           2                                
#endif                                                                          
                                                                                
#ifndef _AZRP003OUTPUT_z                                                        
#define _AZRP003OUTPUT_z                                                        
                                                                                
   typedef struct __AZRP003Output                                               
   {                                                                            
      char                PrintDest[2];                                         
      char                BatchListFile[256];                                   
      char                PrintFile[256];                                       
      char                Duplex[2];                                            
   }  _AZRP003OUTPUT;                                                           
#endif                                                                          
                                                                                
