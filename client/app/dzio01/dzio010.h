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

#define DZIO001X  "DZIO001X"
#define DZIO002X  "DZIO002X"
#define DZIO003X  "DZIO003X"
#define DZIO004X  "DZIO004X"
#define DZIO005X  "DZIO005X"
#define DZIO006X  "DZIO006X"
#define DZIO007X  "DZIO007X"
#define DZIO008X  "DZIO008X"
#define DZIO009X  "DZIO009X"

#define INST1	  "INST1"

#define DZIO002R  "DZIO002R"

#define ALRCOPYB  "ALRCBOOK"
#define PRITABLE  "PRIMTABL"
#define MODNAME	  "IOMODULE"

#define IOMODNM   "Iomodnm"
#define PRIMTAB   "PrimTab"
#define ALRCBOOK  "Alrcbook"

#define NULL_STR  ""

#define FINDPB	  "FindPB"

#define BOX_TITLE "Key Check"


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
