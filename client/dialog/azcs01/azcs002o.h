/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS002O                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 03/18/96                                                */
/*              Time: 14:42:24                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _REQUESTINFO                        */
/******************************************************************************/
                                                                                
#ifndef   ARC00301_LEN                                                          
#define   ARC00301_LEN                         10                               
#define   REQUESTID_LEN                        10                               
#endif                                                                          
#ifndef   ARC00302_LEN                                                          
#define   ARC00302_LEN                         12                               
#define   REQUESTTYPE_LEN                      12                               
#endif                                                                          
#ifndef   ARC00303_LEN                                                          
#define   ARC00303_LEN                         33                               
#define   CLIENTLAYOUT_LEN                     33                               
#endif                                                                          
                                                                                
#ifndef _REQUESTINFO_z                                                          
#define _REQUESTINFO_z                                                          
                                                                                
   typedef struct __RequestInfo                                                 
   {                                                                            
      char                RequestID[10];                                        
      char                RequestType[12];                                      
      char                ClientLayout[33];                                     
   }  _REQUESTINFO;                                                             
#endif                                                                          
                                                                                
