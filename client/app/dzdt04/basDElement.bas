Attribute VB_Name = "modDE"
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
Public sCobolNam As String
Public orgArray() As String


Public Sub LoadProc(strDatabase As String, mControl As Control, strTable As String, strCode As String, strDecode As String, strObjectValue As String, Optional strObjectColumn As String, Optional bSpace As Boolean)

    Dim myCodestable As New CodesTable
    Dim counter As Integer
    Dim i As Integer
    Dim TempString As String
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
            TempString = myCodestable.Code(counter)
            TempString = Right(TempString, Len(TempString) - 1)
            If bSpace = True Then
                mControl.AddItem TempString & myCodestable.Decode(counter)
            Else
                mControl.AddItem TempString & "  " & myCodestable.Decode(counter)
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


Public Function ResetProperties()

   'clear out any data in fields after file has been written, this will also reset fields
   'back to yellow background.
     
    Dim cControl As Control
    
    On Error Resume Next
    
    For Each cControl In frmDataElem.Controls
        cControl.Text = ""
    Next cControl
    
    For Each cControl In frmCOBOLVal.Controls
        cControl.Text = ""
    Next cControl
    
    For Each cControl In frmListValues.Controls
        cControl.Text = ""
    Next cControl
    
    
End Function

Public Function SpecialCharsChk(sString As String, Optional iChar As Integer, Optional bDash As Boolean) As Boolean
On Error GoTo Err_specialcharschk

    Dim intAscii As Integer
    Dim TempString As String
    Dim index As Integer
    Dim i As Integer
    
    SpecialCharsChk = False
    
    index = 1
    
    'Loop through the string that was passed
    For i = 1 To Len(sString)
    
        TempString = Mid(sString, index, 1)
        index = index + 1
        
        'convert single string to ascii code value
        intAscii = Asc(TempString)
        
        'check to see if you need to consider a special character is ok
        If bDash = True Then
        
                If intAscii = iChar Then
                
                    SpecialCharsChk = False     'the ascii character was found
                    
                ElseIf (intAscii > 32 And intAscii < 48) Or (intAscii > 57 And intAscii < 65) Or (intAscii > 90 And intAscii < 97) Or (intAscii > 122 And intAscii < 128) Then
                
                    SpecialCharsChk = True      'special character found
                    
                    
                End If
                
        Else
        
            If (intAscii > 32 And intAscii < 48) Or (intAscii > 57 And intAscii < 65) Or (intAscii > 90 And intAscii < 97) Or (intAscii > 122 And intAscii < 128) Then
                SpecialCharsChk = True
                Exit For
            End If
            
        End If
        
    Next i

Exit_SpecialCharsChk:
    Exit Function

Err_specialcharschk:
    GoTo Exit_SpecialCharsChk
    
    
    
End Function

Public Function CheckControls(fFormpassed As Form) As Boolean
On Error GoTo Err_CheckControls

    Dim cControl As Control
    
    
    CheckControls = False
    
    On Error Resume Next
    
    For Each cControl In fFormpassed.Controls
        If cControl.Text = "" Or cControl.Text = "CISnnnnn" Then
            CheckControls = False
        Else
            CheckControls = True
            Exit Function
            
        End If
    Next cControl
    
    
Exit_CheckControls:
    Exit Function

Err_CheckControls:
    MsgBox Error$
    GoTo Exit_CheckControls

End Function

Public Function NoSpace(sString As String) As Boolean
    On Error GoTo Err_NoSpace

    Dim intAscii As Integer
    Dim sTempString As String
    Dim index As Integer
    Dim i As Integer
    
    NoSpace = False
    
    index = 1
    
    'Loop through the string that was passed
    For i = 1 To Len(sString)
    
        sTempString = Mid(sString, index, 1)
        index = index + 1
        
        'convert single string to ascii code value
        intAscii = Asc(sTempString)
        
        'check to see if you need to consider a special character is ok
        
        If (intAscii = 32) Then
            NoSpace = True
            Exit For
        End If
        
    Next i

Exit_NoSpace:
    Exit Function

Err_NoSpace:
    GoTo Exit_NoSpace
    
    
End Function
