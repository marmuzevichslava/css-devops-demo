/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZCS002O                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 05/23/93                                                */
/*              Time: 18:47:17                                                */
/******************************************************************************/
                                                                                
/******************************************************************************/
/* The following are #DEFINES for typedef _REQUESTINFO                        */
/******************************************************************************/
                                                                                
#ifndef   ARC00301_LEN                                                          
#define   ARC00301_LEN                         10                               
#endif                                                                          
#ifndef   ARC00302_LEN                                                          
#define   ARC00302_LEN                         12                               
#endif                                                                          
#ifndef   ARC00303_LEN                                                          
#define   ARC00303_LEN                         33                               
#endif                                                                          
                                                                                
#ifndef _REQUESTINFO_z                                                          
#define _REQUESTINFO_z                                                          
                                                                                
   typedef struct __RequestInfo                                                 
   {                                                                            
      char            RequestID[ARC00301_LEN];                                  
      char            RequestType[ARC00302_LEN];                                
      char            ClientLayout[ARC00303_LEN];                               
   }  _REQUESTINFO;                                                             
#endif                                                                          
                                                                                
