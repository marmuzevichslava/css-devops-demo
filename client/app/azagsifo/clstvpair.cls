VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsTvPair"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'***************************************************************************
'*
'*                CUSTOMER/1 Cooperative Architecture Module
'*
'*  CLASS NAME       : clsTvPair
'*
'*  DESCRIPTION      : clsTvPair...
'*
'*  PROPERTIES       : none
'*
'*  METHODS          : none
'*
'*  REVISION HISTORY
'*
'*  DATE        REVISED BY  SIR #    DESCRIPTION OF CHANGE
'*  --------    ----------  ------   ---------------------------------------
'*  01/05/97    B Lucas              original code
'*
'***************************************************************************

Public Tag As String
Public Value As Variant
Public pNext As clsTvPair
