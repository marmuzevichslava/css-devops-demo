VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "MsgIcon"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Private sDecode As String
Private iCode As Integer
Private mysql As String

Property Let Code(C)
    iCode = C
    
    mysql = "select Icon From tblMsgBoxIcons where [Icon ID] = " & iCode
                
    Set DaoRS = dbCTM.OpenRecordset(mysql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
            
    If Not DaoRS.EOF Then
        sDecode = DaoRS(0)
        DaoRS.Close
    Else
        sDecode = SQL_NOT_FOUND
    End If

End Property


Property Let Decode(D)
    sDecode = D
    
    mysql = "select [Icon ID] From tblMsgBoxIcons where Icon = " & Chr(39) & sDecode & Chr(39)
                
    Set DaoRS = dbCTM.OpenRecordset(mysql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
            
    If Not DaoRS.EOF Then
        iCode = DaoRS(0)
        DaoRS.Close
    Else
        iCode = SQL_NOT_FOUND
    End If

End Property

Property Get Displaydecode()
    Displaydecode = sDecode
End Property

Property Get Displaycode()
    Displaycode = iCode
End Property


