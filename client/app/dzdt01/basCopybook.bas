Attribute VB_Name = "Module1"
Option Explicit
Public bRequired As Boolean
Public SirTemplate As String
Public xSir As String
Public ySir As String
Public zSir As String
Public strPrefix88 As String
Public strImplied As String
Public gblsComp As String
Public bAdded As Boolean
Public gblBClick As Boolean
Public orgArray() As String

Public Const PATH_TO_DATATEAM_MDB = "\HKEY_LOCAL_MACHINE\SOFTWARE\DTT\DataTeamTable"
Public Const PATH_TO_HELP_FILE = "\HKEY_LOCAL_MACHINE\SOFTWARE\DTT\CopybookHelpFile"


Public Sub LoadProc(strDatabase As String, mControl As Control, strTable As String, strCode As String, strDecode As String, strObjectValue As String, Optional strObjectColumn As String, Optional bSpace As Boolean)
    
    Dim myCodestable As New DataTeamToolDLL.CodesTable
'    Dim myCodestable As New CodesTable
    Dim counter As Integer
    Dim i As Integer
    Dim tempString As String
    Dim sString As String
    
    i = 0
    
     With myCodestable
        .Connection = strDatabase
        .Table = strTable
        .CodeColumn = strCode
        .DecodeColumn = strDecode
        .ObjectColumn = strObjectColumn
        .ObjectValue = strObjectValue
    End With
    
    myCodestable.Retrieve
    
    
    'Load the cboOriging and cboDestination with data from Codesdat.mdb file
    Do
        If (myCodestable.Decode(counter) = vbNullChar) Or (myCodestable.Decode(counter) = "") Then Exit Do
        
            'found a value and adding to the combo boxes
            tempString = myCodestable.Code(counter)
            tempString = Right(tempString, Len(tempString) - 1)
            If bSpace = True Then
                mControl.AddItem tempString & myCodestable.Decode(counter)
            Else
                mControl.AddItem tempString & "  " & myCodestable.Decode(counter)
            End If
            counter = counter + 1
    Loop
    
End Sub

Public Function FileExists(strFilename As String) As Boolean
On Error GoTo notfound

    Open strFilename For Input As #2
    Close #2

    FileExists = True
    Exit Function

notfound:

    'file does not exist
    FileExists = False


End Function



Public Function FieldCheck(mNumCorrect As Integer, mLen As Integer) As Boolean

    'compare passed number correct and the actual length
    If mLen > mNumCorrect Then
         FieldCheck = True
    Else
         FieldCheck = False
    End If
    
End Function

