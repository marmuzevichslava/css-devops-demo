VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsTvList"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'***************************************************************************
'*
'*                CUSTOMER/1 Cooperative Architecture Module
'*
'*  CLASS NAME       : clsTvList
'*
'*  DESCRIPTION      : clsTvList is a linked list created from one or more
'*                     clsTvPairs
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

Public pHead As clsTvPair
Public pTail As clsTvPair
Public NumTvPair As Integer

