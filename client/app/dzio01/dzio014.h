/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME         : <CUffnnn>.H
**
**  DESCRIPTION      : Window Header File
**
**  AUTHOR	     : Andersen Consulting
**
**  DATE CREATED     : 08/29/95
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
**    08/29/95	IPEREZAR	      Creation
**
***************************************************************************/

#define PRIMTABNM "PrimTabNm"
#define ALRPREFIX "ALRPrefix"
#define NULL_STR  ""

_MainJoinLBRow DeleteMainJoinLBRow;

USHORT  JoinTable1Counter = 0; 
USHORT  JoinTable2Counter = 0; 

USHORT  MainJoinLBCounter = 0;

#define    DotFill  "."
#define    RelatEq  "EQUAL"



SHORT	DZIO01FieldSetValue( void * FieldSetName,
                            void * FieldSetValue,
                            USHORT FieldSetSize,
			    CMN_ARCH_PARM_TYPES);

SHORT	DZIO01FieldEnable( void * FieldName,
			    CMN_ARCH_PARM_TYPES);

SHORT	DZIO01FieldDisable( void * FieldName,
			    CMN_ARCH_PARM_TYPES);

SHORT	DZIO01CommandEnable( void * CommandName,
			    CMN_ARCH_PARM_TYPES);

SHORT	DZIO01CommandDisable( void * CommandName,
			    CMN_ARCH_PARM_TYPES);


SHORT	DZIO01FieldQueryValue( void * FieldQryName,
                              void * FieldQryValue,
                              USHORT FieldQrySize,
                              CMN_ARCH_PARM_TYPES);

SHORT DZIO007PopulateJoinTable1( _ENTITYDATA *pEntityDataTable,
                                 _REPLYHDR *pReplyHdr,
                                 CMN_ARCH_PARM_TYPES );

#include "viewsett.h"
