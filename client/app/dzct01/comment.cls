VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Comment"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private sInComment As String
Private sOutComment As String
Private sCommentsTemp As String
Dim lFromLen As Long, lLen As Long, lLeft As Long
'Private t As String


Property Let Text(T)
    sInComment = T
    
    If (Len(sInComment) = 0) Then
        sOutComment = "Last Updated " & Date & " - " & Time & " by " & UCase(CurrentUser)
    ElseIf (InStr(sInComment, "Last Updated") > 0) Then
        lFromLen = InStr(sInComment, "Last Updated") - 1
        sCommentsTemp = Left(sInComment, lFromLen)
        sOutComment = sCommentsTemp & " Last Updated " & Date & " - " & Time & " by " & UCase(CurrentUser)
    Else
        sOutComment = sInComment & " Last Updated " & Date & " - " & Time & " by " & UCase(CurrentUser)
    End If

End Property

Property Get DisplayComment()
    DisplayComment = sOutComment
End Property
