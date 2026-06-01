VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Release"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private sDecode As String
Private iCode As Integer
Private mysql As String

Property Let Code(C)
    iCode = C
    
    mysql = "select Release From tblReleases where Code = " & iCode
                
    Set DaoRS = dbCTM.OpenRecordset(mysql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
            
    If Not DaoRS.EOF Then
        sDecode = DaoRS(0)
    Else
        sDecode = SQL_NOT_FOUND
    End If

    DaoRS.Close

End Property


Property Let Decode(D)
    sDecode = D
    mysql = "select Code From tblReleases where Release = " & Chr(34) & sDecode & Chr(34)
                
    Set DaoRS = dbCTM.OpenRecordset(mysql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
            
    If Not DaoRS.EOF Then
        iCode = DaoRS(0)
    Else
        iCode = SQL_NOT_FOUND
    End If

    DaoRS.Close

End Property

Property Get Displaydecode()
    Displaydecode = sDecode
End Property

Property Get Displaycode()
    Displaycode = iCode
End Property
