VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CodesTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private sTable As String
Private sObjectNmae As String
Private sForm As String
Private bSortDecode As Boolean
Private bSortCode As Boolean
Private sDecodeColumn As String
Private sCodeColumn As String
Private Type objCT
    Decode As String
    Code As Integer
End Type
Private TableArray() As objCT
Property Let Table(T)
    sTable = T
End Property
Property Let DecodeColumn(D)
    sDecodeColumn = D
End Property
Property Let CodeColumn(C)
    sCodeColumn = C
End Property
Property Let SortDecode(S)
    bSortDecode = True
    bSortCode = False
End Property
Property Let SortCode(T)
    bSortDecode = False
    bSortCode = True
End Property

Public Sub Retrieve()
    ReDim TableArray(0)
    
    If (bSortDecode = True) Then
        strsql = "Select " & sCodeColumn & ", " & sDecodeColumn _
                & " From " & sTable _
                & " Order By " & sDecodeColumn
    Else
        strsql = "Select " & sCodeColumn & ", " & sDecodeColumn _
                & " From " & sTable _
                & " Order By " & sCodeColumn
    End If

    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then

        While Not DaoRS.EOF
            TableArray(UBound(TableArray)).Code = DaoRS(0).Value
            TableArray(UBound(TableArray)).Decode = DaoRS(1).Value
            ReDim Preserve TableArray(UBound(TableArray) + 1)
            DaoRS.MoveNext
        Wend

        DaoRS.Close

    End If

End Sub
Property Get Code(N)
    If N > UBound(TableArray) Or N < 0 Then
        Code = -1
    Else
        Code = TableArray(N).Code
    End If
End Property

Property Get Decode(E)
    If E > UBound(TableArray) Or E < 0 Then
        Decode = vbNullChar
    Else
        Decode = TableArray(E).Decode
    End If
End Property
