/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZDW003C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 08/10/93                                                */
/*              Time: 17:31:11                                                */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK        *pArchBlock;                                          
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZCS003C_z                                                          
#define _WCDAZCS003C_z                                                          
                                                                                
   typedef struct __WCDAzcs003c                                                 
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDAZCS003C;                                                             
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZCS003C                               
                                                                                
