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


char OpenWindow;

#define PRIMTABNM "PrimTabNm"
#define ALRPREFIX "ALRPrefix"
#define NULL_STR  ""

#define SECTABB_Char 'B'
#define SECTABC_Char 'C'

#define SECTABB   "SECTABB"
#define SECTABC   "SECTABC"

#define INST1	  "INST1"

#define DZIO002X  "DZIO002X"

#define DZIO012X  "DZIO012X"
#define DZIO013X  "DZIO013X"
#define DZIO014X  "DZIO014X"


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



WCBFWD( DZIO012XEnableOkPb )
