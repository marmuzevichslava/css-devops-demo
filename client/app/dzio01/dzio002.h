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
** 08/29/95    IPEREZAR 	   Creation
**
***************************************************************************/

/***************************************************************************/
/* Application #includes                                                   */
/***************************************************************************/


#define IOMODNM   "Iomodnm"
#define PRIMTAB   "PrimTab"
#define ALRCBOOK  "Alrcbook"
#define FETCH	  "Fetch"
#define INSERT	  "Insert"
#define UPDATE	  "Update"
#define SUM	  "Sum"
#define COUNT	  "Count"
#define DELETE_2  "Delete"
#define FETNX	  "FetNx"
#define INSSET	  "InsSet"
#define UPDSET	  "UpdSet"
#define UNIQUE	  "Unique"
#define CSTFUN	  "CstFun"
#define DELSET	  "DelSet"
#define SUMMUL	  "SumMul"
#define CNTMUL	  "CntMul"
#define RENAME	  "Rename"
#define DYNSCR	  "DynScr"
#define FETPREV   "FetPrev"
#define SUMCOL	  "SumCol"
#define FINDPB1   "FindPB1"
#define FINDPB2   "FindPB2"
#define VIEWPB1   "VIEW1"
#define VIEWPB2   "VIEW2"
#define TASKLIST  "TaskList"
#define FUNCT	  "Funct"
#define FOLDERPB  "FolderPB"
#define MNTMGEN   "MntmGen"
#define MNTSAVE   "MntSave"

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

#define WORDRET   "N"
#define FUNCTCODE "ER"

#define PBOK	  "OKPB"

#define DEIOMOD   "DZ01TB01"
#define DEDTABLE  "DEDTABLE"
#define DECOPYBK  "DECOPYBK"

#define SECTABB_Char 'B'
#define SECTABC_Char 'C'

#define SECTABB   "SECTABB"
#define SECTABC   "SECTABC"


#define TITLE1	  "Select I/O Module"
#define TITLE2	  "Select Primary Table"
#define TITLE3	  "Select ALR Copybook"
#define TITLE4	  "No Returns From Repository"
#define TITLE5	  "Searching ..."

#define IMPOBJ	  "ImpObjNmLB"
#define CSRRQST   "DZSR002R"

#define BOX_TITLE "Find Process"


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

SHORT	DZIO01MsgBoxDisplay(char *pMsgBoxText,
			    char MsgBoxName[32],
			    FND_HWND OwnerHwnd,
			    unsigned short Buttons,
			    unsigned short Icon,
			    unsigned short DefaultButton,
			    char *pMsgBoxTitle,
			    CMN_ARCH_PARM_TYPES);

SHORT	DZIO01MsgBoxDestroy(char MsgBoxName[32],
			    CMN_ARCH_PARM_TYPES);

