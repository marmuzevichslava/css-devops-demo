
/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**                            Common Function
**
**
** FUNCTION	    :	DZIO001XResetWindow
**
** DESCRIPTION      :   This function will enable a command on the window.
**
** INPUTS           :   o  void * CommandName - pointer to the WES Field Name
**
**                      o  CMN_ARCH_PARM_TYPES - macro that expands to the
**                         architecture standard parameter types:
**
**
**
** OUTPUTS          :   CMN_SUCCESS  or  CMN_FAIL
**
**
** CALLED FUNCTIONS :   NONE
**
** SYNTAX           :
**
**	    OLD:   Ncqnrdhl8096_Predisplay
**
**
**
**
** AUTHOR           :   Florida Power Corporation & Andersen Consulting
**
** DATE CREATED     :   03/16/94
**
**
** REVISION HISTORY
**
**  DATE     REVISED BY        SIR #      DESCRIPTION OF CHANGE
** -------   ----------------  ---------  ----------------------------------
**
** 08/09/95  I Perez-Armesto		  Adapted for I/O Module Generator
**
***************************************************************************/


SHORT DZIO001XResetWindow(CMN_ARCH_PARM_TYPES)
{

unsigned short           FndGenRC = FND_SUCCESS;



FndGenRC = DZIO01FieldSetValue(ALRCBOOK,
				"",
				9,
				CMN_ARCH_PARMS);


FndGenRC = DZIO01FieldSetValue(PRIMTAB,
				"",
				9,
				CMN_ARCH_PARMS);


FndGenRC = DZIO01CommandDisable(MNTMGEN,
				CMN_ARCH_PARMS);



FndGenRC = DZIO01FieldDisable(TASKLIST,
			      CMN_ARCH_PARMS);



FndGenRC = DZIO01CommandDisable(FINDPB1,
				CMN_ARCH_PARMS);


FndGenRC = DZIO01CommandDisable(FINDPB2,
				CMN_ARCH_PARMS);


FndGenRC = DZIO01CommandDisable(VIEWPB1,
				CMN_ARCH_PARMS);


FndGenRC = DZIO01CommandDisable(VIEWPB2,
				CMN_ARCH_PARMS);



DeleteData[0] = 'Y';

FetchData[0] = 'Y';

FetNxData[0] = 'Y';

UpdateData[0] = 'Y';

InsertData[0] = 'Y';

InsSetData[0] = 'N';

UpdSetData[0] = 'N';

SumData[0] = 'N';

CntMulData[0] = 'N';

UniqueData[0] = 'N';

DynScrData[0] = 'N';

CstFunData[0] = 'N';

CountData[0] = 'N';

DelSetData[0] = 'N';

SumMulData[0] = 'N';

FetPrevData[0] = 'N';

RenameData[0] = 'N';



return CMN_SUCCESS;


}
