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
**   08/29/95	IPEREZAR	      Creation
**
***************************************************************************/

#define IOMODNM   "Iomodnm"
#define PRIMTAB   "PrimTab"
#define ALRCBOOK  "Alrcbook"
#define FETCH	  "Fetch"
#define INSERT	  "Insert"
#define UPDATE	  "Update"
#define SUM	      "Sum"
#define COUNT	  "Count"
#define DEL 	  "Delete"
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
#define MNTSAVEAS "MntSaveAs"

#define DZIO001X  "DZIO001X"
#define DZIO002X  "DZIO002X"
#define DZIO003X  "DZIO003X"
#define DZIO004X  "DZIO004X"
#define DZIO005X  "DZIO005X"
#define DZIO006X  "DZIO006X"
#define DZIO007X  "DZIO007X"
#define DZIO008X  "DZIO008X"
#define DZIO009X  "DZIO009X"
#define DZIO010X  "DZIO010X"
#define DZIO012X  "DZIO012X"
#define DZIO015X  "DZIO015X"

#define INST1	  "INST1"

#define BOX_TITLE  "Save Results"
#define BOX_TITLE2 "Save Process"
#define BOX_TITLE3 "Search Process"
#define BOX_TITLE4 "Generating Process"

#define NEWMOD	  "NewModul"
#define GENMOD	  "GenModul"
#define OPNMOD	  "OpnModul"
#define SAVEAS	  "SaveModl"

#define IOMODULE  "IOMODULE"
#define PRIMTABL  "PRIMTABL"
#define ALRCOPYB  "ALRCBOOK"

#define NULL_STR  ""

#define FOUND	  "Found"
#define PASSED	  "Passed"

#define OPNMOD	  "OpnModul"
#define NOTFOUND  "NotFound"
#define NEWMOD	  "NewModul"

#define DESCKYS   "Desc Keys..."
#define TBLJOINS  "Table Joins..."
#define MASSGEN   "Mass Generation..."
#define CHECKED   'Y'

#define TITLE1	  "I/O Module Saved Successfully."
#define TITLE2	  "Database Update Failed. Alr Copybook must be unique"
#define TITLE3	  "This I/O Module Was Not Found."
#define TITLE4	  "Bad Return Fom Service"
#define TITLE5	  "This I/O Module Already Exists."
#define TITLE6	  "Saving I/O Module... Please Wait"
#define TITLE7	  "Searching for I/O Module... Please Wait"
#define TITLE8	  "Generating I/O Module... Please Wait"
#define TITLE9	  "Generation Process Completed"
#define TITLE10	  "I/O Module Generation Failed"

#define APPL_ID			8002
#define SRVC_ID			8002
#define SRVC_MAP		"DZCR002I"

#define SRVC_VER		"01"

#define LUW_APPL_ID		9002
#define LUW_SRVC_ID		9002
#define LUW_SRVC_MAP	"DZCL002I"



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


SHORT DZIO001XResetWindow(CMN_ARCH_PARM_TYPES);

SHORT DZIO01ServiceCall(CMN_ARCH_PARM_TYPES,
			     char * function_type, 
				 char * module_name,
				 _DZCR001OUTPUT  *MessageOutput,
                 _DZCR001INPUT   *MessageInput);

SHORT	DZIO01MsgBoxDisplay(char *pMsgBoxText,
			    char MsgBoxName[32],
			    FND_HWND OwnerHwnd,
			    unsigned short Buttons,
			    unsigned short Icon,
			    unsigned short DefaultButton,
			    char *pMsgBoxTitle,
			    CMN_ARCH_PARM_TYPES);


#include "FieldSet.h"


#include "winset.h"


#include "servcall.h"
