/***************************************************************************
**  (c) Copyright 1995 Andersen Consulting - All Rights Reserved.         **
**  This work is protected by copyright law as an unpublished work.       **
****************************************************************************/
/****************************************************************
**
**					CUSTOMER SERVICE SYSTEM
**                     CSR MAP GENERATOR
**
**   FILENAME       :  azcs01.H
**
**   DESCRIPTION    :  This file contains  CSR Map Generator Prototypes
**
**	 AUTHOR 		:  M. Conner
**
**   REVISION HISTORY
**
**	 DATE	   REVISED BY	 SIR #		DESCRIPTION OF CHANGE
**   ------    ----------    -----      ---------------------
**   03/25/99  N.Eyde                   Added various megascrolling items.
**
*****************************************************************/


/************************************************************************
**
**  USER DEFINES
**
************************************************************************/
#ifndef LT_Primary
#define LT_Primary       "1"
#endif

/* NEYDE - 03/25/99 - Added this reference for a listbox without a 
**                    selected row.
*/
#ifndef ROW_NOT_SELECTED
#define ROW_NOT_SELECTED -1
#endif

/* NEYDE - 03/25/99 - This structure defines each megascrolling node.
*/
typedef struct __Azcs01MegaScroll
{
    VOID *pKeys;
    struct __Azcs01MegaScroll *pNext;
} _AZCS01MEGASCROLL;

/************************************************************************
**
**  PROTOTYPES
**
************************************************************************/

FILE *fpError; /*global error file pointer*/

/*mdc 11/13/96 Moved here from c1cbase.h */
USHORT CsrMapReadMapFile( CMN_ARCH_PARM_TYPES );

USHORT CsrMapWriteMapFile( CMN_ARCH_PARM_TYPES );

USHORT GenerateMap( CMN_ARCH_PARM_TYPES );

USHORT WriteSDM( CMN_ARCH_PARM_TYPES);

USHORT WriteRMH( CMN_ARCH_PARM_TYPES);

/*mdc 11/21/96 These prototypes came from azcs013
               These functions are now global*/
CHAR *BuildFullName( SHORT sElementx, _LAYOUT_REC *pLayout);
SHORT FindFullName( SHORT sSavedIndex,
                   _LAYOUT_REC *pSavedLayout,
                   _LAYOUT_REC *pReposLayout,
                   SHORT sNumReposRows,
                   SHORT *sReposIndex);

USHORT LogError( char * );

/*mdc 12/20/96 New prototypes for checking occurring groups */
USHORT CheckOccurGrps( CMN_ARCH_PARM_TYPES );

USHORT CheckServiceRPMH( _LAYOUT_REC  ServiceLayout[],
                 _LAYOUT_REC  ClientLayout[], 
                  USHORT      CurIndex,
                 _RELATE_RPMH RPMH[],
                 CMN_ARCH_PARM_TYPES);

USHORT CheckRPMH( _LAYOUT_REC  ServiceLayout[],
                             _LAYOUT_REC  ClientLayout[],
                              USHORT      CurIndex,
                             _RELATE_RPMH RPMH[],
                             CMN_ARCH_PARM_TYPES);

/* NEYDE - 03/25/99 - Added prototypes to this dialogs mega scrolling
**                    functions.
*/
SHORT AZCS01MegaScrollPush(  _AZCS01MEGASCROLL **pMegaStruct,
                             VOID *pNewKeys,
                             size_t KeySize,
                             CMN_ARCH_PARM_TYPES);

SHORT AZCS01MegaScrollPop ( _AZCS01MEGASCROLL **pMegaStruct,
                            CMN_ARCH_PARM_TYPES);

SHORT AZCS01MegaScrollPopAll ( _AZCS01MEGASCROLL **pMegaStruct,
                            CMN_ARCH_PARM_TYPES);
