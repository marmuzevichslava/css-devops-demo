/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/******************************************************************************/
/*                                                                            */
/*   Header name  :   AZDW006C                                                */
/*                                                                            */
/*   Description  :                                                           */
/*                                                                            */
/*   Generation Date: 08/18/93                                                */
/*              Time: 14:20:39                                                */
/******************************************************************************/
                                                                                
#ifndef _ARCHDATA_z                                                             
#define _ARCHDATA_z                                                             
typedef struct __ArchData                                                       
{                                                                               
   _CMN_ARCH_BLOCK        *pArchBlock;                                          
}  _ARCHDATA;                                                                   
#endif                                                                          
                                                                                
#ifndef _WCDAZDW006C_z
#define _WCDAZDW006C_z
                                                                                
   typedef struct __WCDAzdw006c
   {                                                                            
      _ARCHDATA ArchData;                                                       
   }  _WCDAZDW006C;
#endif                                                                          
                                                                                
#define WCD_ArchData pWindContextData->ArchData                                 
#define WINCONTEXTNAME               _WCDAZDW006C
                                                                                
