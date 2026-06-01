/***************************************************************************
**
**               Customer Service System Application Header File
**
**  FILENAME	     : DZIO008.H
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
**   08/29/95	IPEREZAR	      Creation
**
***************************************************************************/

#define PRIMTABL "PRIMTABL"
#define ENTID	 "EntId"
#define ENTTYP	 "EntTyp"
#define TABLE	 "TABLE"
#define DEDTABLE "DEDTABLE"
#define ALRCBOOK "ALRCBOOK"
#define DECOPYBK "DECOPYBK"
#define COPYBOOK "COPYBOOK"
#define TABLE_SZ  5
#define BOOK_SZ   8


SHORT DZIO008RetrieveLayout( _REQUESTHDR *pRequestHdr,
                            _REPLYHDR *pReplyHdr,
                            _ENTITYDATA *pEntityDataTable,
			    CMN_ARCH_PARM_TYPES );


SHORT DZIO008PopulateWindow( _ENTITYDATA *pEntityDataTable,
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


#include "viewset.h"
