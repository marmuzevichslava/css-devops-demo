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

USHORT SelectElementsCount = 0;

#define PRIMTABNM "PrimTabNm"
#define ALRPREFIX "ALRPrefix"
#define NULL_STR  ""

#define DEDTABLE  "DEDTABLE"

#define SECTABB   "SECTABB"
#define SECTABC   "SECTABC"

#define CDOPERAND "CdOperandB1"
#define DZ00751   "DZ00751"
#define REPOSDAT  "ReposDataLB"


#define BOX_TITLE "Key Check"
#define TITLE1	  "A Select Key Can Only Be Selected Once"


SHORT DZIO007RetrieveLayout( _REQUESTHDR *pRequestHdr,
                            _REPLYHDR *pReplyHdr,
                            _ENTITYDATA *pEntityDataTable,
			                CMN_ARCH_PARM_TYPES );


SHORT DZIO007PopulateWindow( _ENTITYDATA *pEntityDataTable,
                             _REPLYHDR *pReplyHdr,
			                CMN_ARCH_PARM_TYPES );


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

// #include "boxset.h"
