Attribute VB_Name = "Module1"
Option Explicit
Public gblsComp As String
Public RowCounter As Integer
Public bRequired As Boolean
Public SirTemplate As String ' = "\S" & ySir & zSir & "'.txt"
Public xSir As String
Public ySir As String
Public zSir As String
Public strPrefix88 As String
Public strImplied As String
Public bAdded As Boolean



Public Sub LoadProc(strDatabase As String, mControl As Control, strTable As String, strCode As String, strDecode As String, strObjectValue As String, Optional strObjectColumn As String)

    Dim myCodestable As New CodesTable
    Dim tempString As String
    Dim Counter As Integer
    
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
        If (myCodestable.Decode(Counter) = vbNullChar) Or (myCodestable.Decode(Counter) = "") Then Exit Do
        
            'found a value and adding to the combo boxes
            tempString = myCodestable.Code(Counter)
            tempString = Right(tempString, Len(tempString) - 1)
            mControl.AddItem tempString & "  " & myCodestable.Decode(Counter)
            Counter = Counter + 1
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


Public Function ResetProperties()

    'clear out any data in fields after file has been written
    frmRecord.cboOriging.Text = ""
    frmRecord.txtSirNo.Text = ""
    frmRecord.cboDestination.Text = ""
    frmRecord.txtLongDesc.Text = ""
    frmRecord.txtShortDesc.Text = ""
    frmRecord.txtCOBOLNm.Text = ""
    frmRecord.txtCName = ""
    frmRecord.txtAlias.Text = ""
    
    'Set required fields back to yellow
    frmRecord.cboOriging.BackColor = &HFFFF&
    frmRecord.cboDestination.BackColor = &HFFFF&
    frmRecord.txtSirNo.BackColor = &HFFFF&
    frmRecord.txtLongDesc.BackColor = &HFFFF&
    frmRecord.txtShortDesc.BackColor = &HFFFF&
    frmRecord.txtCOBOLNm.BackColor = &HFFFF&
    frmRecord.txtCName.BackColor = &HFFFF&
  
 
End Function
