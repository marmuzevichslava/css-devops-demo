Attribute VB_Name = "Module1"
Option Explicit
Public gblsComp As String
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
    Dim counter As Integer
    Dim strTemp As String
    
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
            strTemp = myCodestable.Code(counter)
            strTemp = Right(strTemp, Len(strTemp) - 1)
            mControl.AddItem strTemp & "  " & myCodestable.Decode(counter)
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


Public Function ResetProperties()

    'clear out any data in fields after file has been written
    frmRecGrp.cboOriging.Text = ""
    frmRecGrp.txtSirNo.Text = ""
    frmRecGrp.cboDestination.Text = ""
    frmRecGrp.txtLongDesc.Text = ""
    frmRecGrp.txtShortDesc.Text = ""
    frmRecGrp.txtCOBOLNm.Text = ""
    frmRecGrp.txtCName = ""
    frmRecGrp.txtAlias.Text = ""
    frmRecGrp.txtPrefix.Text = ""
    
    'Set required fields back to yellow
    frmRecGrp.cboOriging.BackColor = &HFFFF&
    frmRecGrp.cboDestination.BackColor = &HFFFF&
    frmRecGrp.txtSirNo.BackColor = &HFFFF&
    frmRecGrp.txtLongDesc.BackColor = &HFFFF&
    frmRecGrp.txtShortDesc.BackColor = &HFFFF&
    frmRecGrp.txtCOBOLNm.BackColor = &HFFFF&
    frmRecGrp.txtCName.BackColor = &HFFFF&
  
 
End Function
