VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Table"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private sTableName As String
Private iTableType As Integer
Private iDecodeLen As Integer
Private iDisplayDecodeLen As Integer
Private bFound As Boolean
Private sqlstr As String

Property Let Name(N)
    sTableName = N
    
    bFound = True
    
    sqlstr = "SELECT TableType, DecodeLen FROM tblTables " & _
             " WHERE TableName = " & Chr(34) & sTableName & Chr(34) & ";"
    
    Set DaoRS = dbCTM.OpenRecordset(sqlstr, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
            
    If Not DaoRS.EOF Then
        iTableType = DaoRS(0)
        iDecodeLen = DaoRS(1)
    Else
        bFound = False
        iTableType = SQL_NOT_FOUND
    End If

    DaoRS.Close

End Property

Property Get DisplayType()
    DisplayType = iTableType
End Property

Property Get DisplayDecodeLen()
    DisplayDecodeLen = iDecodeLen
End Property

Property Get Found()
    Found = bFound
End Property





