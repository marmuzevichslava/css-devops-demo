/***************************************************************************
**
**               Customer Service System Business Logic Function
**
**  FUNCTION	     : Dzio001BusStdFunClk
**
**  DESCRIPTION      : This sets up the parent window
**
**  INPUTS           : WCBPROC - Six standard FOUNDATION callback parameters.
**
**  OUTPUTS          : Return Code - SHORT (Valid: CMN_SUCCESS or CMN_FAIL).
**
**
**  CALLED FUNCTIONS : NONE
**
**  AUTHOR	     : Andersen Consulting - Solutionworks
**
**  DATE CREATED     : 07/23/95
**
**  REVISION HISTORY :
**
**    DATE      REVISED BY   SIR #    DESCRIPTION OF CHANGE
**    --------  -----------  -------  -------------------------------------
** 07/13/95    IPEREZAR		  Creation
**
***************************************************************************/
WCBPROC( Dzio001BusStdFunClk )
{
unsigned short           FndGenRC = FND_SUCCESS;
_FND_ERROR_BLOCK         FndGenErrorBlock;


if ( strcmp( FetchData, "Y") == 0 )
   {

   if ( ( ( ( ( strcmp( FetchData, "Y") == 0 ) && ( strcmp( FetNxData, "Y") == 0 ) ) && ( strcmp( UpdateData, "Y") == 0 ) ) && ( strcmp( InsertData, "Y") == 0 ) ) && ( strcmp( DeleteData, "Y") == 0 ) )
      {

      strncpy(FunctData,LT_Limit,9);

      FndGenRC = FndFieldDisable(CBI_hwnd,
                             "CntMul",
                             &FndGenErrorBlock);

      FndGenRC = FndFieldDisable(CBI_hwnd,
                             "Unique",
                             &FndGenErrorBlock);

      FndGenRC = FndFieldDisable(CBI_hwnd,
                             "Count",
                             &FndGenErrorBlock);

      FndGenRC = FndFieldDisable(CBI_hwnd,
                             "CstFun",
                             &FndGenErrorBlock);

      FndGenRC = FndFieldDisable(CBI_hwnd,
                             "DelSet",
                             &FndGenErrorBlock);

      FndGenRC = FndFieldDisable(CBI_hwnd,
                             "DynScr",
                             &FndGenErrorBlock);

      FndGenRC = FndFieldDisable(CBI_hwnd,
                             "FetPrev",
                             &FndGenErrorBlock);

      FndGenRC = FndFieldDisable(CBI_hwnd,
                             "InsSet",
                             &FndGenErrorBlock);

      FndGenRC = FndFieldDisable(CBI_hwnd,
                             "Rename",
                             &FndGenErrorBlock);

      FndGenRC = FndFieldDisable(CBI_hwnd,
                             "Sum",
                             &FndGenErrorBlock);

      FndGenRC = FndFieldDisable(CBI_hwnd,
                             "SumMul",
                             &FndGenErrorBlock);

      FndGenRC = FndFieldDisable(CBI_hwnd,
                             "UpdSet",
                             &FndGenErrorBlock);

      } /* end if */

   }
else
   {

   strncpy(FunctData,LT_Std,9);

   FndGenRC = FndFieldDisable(CBI_hwnd,
                             "CntMul",
                             &FndGenErrorBlock);

   FndGenRC = FndFieldDisable(CBI_hwnd,
                             "Unique",
                             &FndGenErrorBlock);

   FndGenRC = FndFieldDisable(CBI_hwnd,
                             "Count",
                             &FndGenErrorBlock);

   FndGenRC = FndFieldDisable(CBI_hwnd,
                             "CstFun",
                             &FndGenErrorBlock);

   FndGenRC = FndFieldDisable(CBI_hwnd,
                             "DelSet",
                             &FndGenErrorBlock);

   FndGenRC = FndFieldDisable(CBI_hwnd,
                             "DynScr",
                             &FndGenErrorBlock);

   FndGenRC = FndFieldDisable(CBI_hwnd,
                             "FetPrev",
                             &FndGenErrorBlock);

   FndGenRC = FndFieldDisable(CBI_hwnd,
                             "InsSet",
                             &FndGenErrorBlock);

   FndGenRC = FndFieldDisable(CBI_hwnd,
                             "Rename",
                             &FndGenErrorBlock);

   FndGenRC = FndFieldDisable(CBI_hwnd,
                             "Sum",
                             &FndGenErrorBlock);

   FndGenRC = FndFieldDisable(CBI_hwnd,
                             "SumMul",
                             &FndGenErrorBlock);

   FndGenRC = FndFieldDisable(CBI_hwnd,
                             "UpdSet",
                             &FndGenErrorBlock);

   } /* end if */

return 0;


}
