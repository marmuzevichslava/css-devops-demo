VERSION 5.00
Begin VB.Form frmAddModKey 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   4635
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6465
   Icon            =   "frmAddModKey.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4635
   ScaleWidth      =   6465
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Close"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3450
      TabIndex        =   11
      ToolTipText     =   "Add the current user id"
      Top             =   3975
      Width           =   1215
   End
   Begin VB.CommandButton cmdProcess 
      Caption         =   "&Add"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1800
      TabIndex        =   10
      ToolTipText     =   "Add the current user id"
      Top             =   3975
      Width           =   1215
   End
   Begin VB.CheckBox chkStatic 
      Caption         =   "Static Tables"
      Height          =   255
      Left            =   900
      TabIndex        =   7
      ToolTipText     =   "Indicates the current Key is used in a Static Table"
      Top             =   3375
      Width           =   1560
   End
   Begin VB.CheckBox chkCodes 
      Caption         =   "Codes Tables"
      Height          =   255
      Left            =   4650
      TabIndex        =   9
      ToolTipText     =   "Indicates the current Key is used in another Codes Table"
      Top             =   3375
      Width           =   1485
   End
   Begin VB.CheckBox chkSystem 
      Caption         =   "System Code"
      Height          =   255
      Left            =   2775
      TabIndex        =   8
      ToolTipText     =   "Indicates the current Key is used in System Code"
      Top             =   3375
      Width           =   1485
   End
   Begin VB.TextBox txtComments 
      Height          =   315
      Left            =   1350
      TabIndex        =   6
      ToolTipText     =   "Comments for current Key"
      Top             =   2925
      Width           =   4890
   End
   Begin VB.TextBox txtCobolName 
      Height          =   315
      Left            =   1350
      TabIndex        =   5
      ToolTipText     =   "COBOL language name"
      Top             =   2475
      Width           =   4890
   End
   Begin VB.ComboBox cbxClients 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1350
      Style           =   2  'Dropdown List
      TabIndex        =   2
      ToolTipText     =   "Client this entry applies to"
      Top             =   1125
      Width           =   2790
   End
   Begin VB.TextBox txtCName 
      Height          =   315
      Left            =   1350
      TabIndex        =   4
      ToolTipText     =   "C lanquage variable"
      Top             =   2025
      Width           =   4890
   End
   Begin VB.TextBox txtDesc 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1350
      TabIndex        =   3
      ToolTipText     =   "Decription of the current Key"
      Top             =   1575
      Width           =   4890
   End
   Begin VB.TextBox txtDecode 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   1350
      TabIndex        =   1
      ToolTipText     =   "Decode for the current Key"
      Top             =   675
      Width           =   4890
   End
   Begin VB.TextBox txtKey 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1350
      TabIndex        =   0
      ToolTipText     =   "Key Code to Add/Modify"
      Top             =   225
      Width           =   1290
   End
   Begin VB.Label Label7 
      Caption         =   "Comments:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   150
      TabIndex        =   18
      Top             =   2955
      Width           =   840
   End
   Begin VB.Label Label6 
      Caption         =   "Cobol Name:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   150
      TabIndex        =   17
      Top             =   2505
      Width           =   1140
   End
   Begin VB.Label Label5 
      Caption         =   "C Name:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   150
      TabIndex        =   16
      Top             =   2055
      Width           =   840
   End
   Begin VB.Label Label4 
      Caption         =   "Description:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   150
      TabIndex        =   15
      Top             =   1605
      Width           =   990
   End
   Begin VB.Label Label3 
      Caption         =   "Client:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   150
      TabIndex        =   14
      Top             =   1155
      Width           =   615
   End
   Begin VB.Label Label1 
      Caption         =   "Decode:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   150
      TabIndex        =   13
      Top             =   705
      Width           =   840
   End
   Begin VB.Label Label2 
      Caption         =   "Key:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   150
      TabIndex        =   12
      Top             =   255
      Width           =   615
   End
End
Attribute VB_Name = "frmAddModKey"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public bFormLoaded As Boolean
Public bModified As Boolean
Public CurClient As Integer
Public bDecodeOK As Boolean
Public bKeyOK As Boolean


'***************************************************************************************************************
Private Sub cbxClients_Click()
'***************************************************************************************************************
    Dim x As Integer
    
    If (bFormLoaded = True) Then
    
        bModified = True
    
        For x = 0 To UBound(ClientArray)
            If (cbxClients.Text = ClientArray(x).Client) Then
                CurClient = ClientArray(x).Code
                Exit For
            End If
        Next
    End If
End Sub

'***************************************************************************************************************
Private Sub cmdCancel_Click()
'***************************************************************************************************************
    Unload Me
End Sub

'***************************************************************************************************************
Private Sub cmdProcess_Click()
'***************************************************************************************************************
    Dim RC As Integer
    
    'Are we in 'add' mode?
    If (bAddNewKey) Then
        
        'Check to see if this new key already exists.
        If (CheckKeyExists(CurTable, txtKey.Text, GetClientDecode(frmMain.lvListView.SelectedItem.SubItems(2))) = True) Then
            RC = MessageBox(Me.hwnd, _
                            "This Key already exists on this table!" & vbCrLf & _
                            "Would you like to overwrite the existing Key?", _
                            "Codes Table Explorer", _
                            MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2)
            
            If (RC = IDNO) Then
                Exit Sub
            Else
                'Attempt to modify the record and display a status message.
                If (ModifyRecord = True) Then
            
                    RC = MessageBox(Me.hwnd, _
                                    "Record successfully updated!", _
                                    "Codes Table Explorer", _
                                    MB_OK Or MB_ICONEXCLAMATION)
                Else
                    RC = MsgBox(Me.hwnd, _
                                "Unable to process current record!", _
                                "Codes Table Explorer", _
                                MB_OK Or MB_ICONEXCLAMATION)
                End If
            End If
        Else
            'Attempt to add the record and display a status message.
            If (AddNewRecord = True) Then
        
                RC = MessageBox(Me.hwnd, _
                                "Record successfully added!", _
                                "Codes Table Explorer", _
                                MB_OK Or MB_ICONEXCLAMATION)
            Else
                RC = MsgBox(Me.hwnd, _
                            "Unable to process new record!", _
                            "Codes Table Explorer", _
                            MB_OK Or MB_ICONEXCLAMATION)
        
            End If
        End If
    'We are in Modify mode.
    Else
        
        'Check to see if this new key already exists.
        If (CheckKeyExists(CurTable, txtKey.Text, GetClientDecode(frmMain.lvListView.SelectedItem.SubItems(2))) = False) Then
            RC = MessageBox(Me.hwnd, _
                            "This Key does not current exists on this table!" & vbCrLf & _
                            "Would you like to add the current Key?", _
                            "Codes Table Explorer", _
                            MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON1)
            
            If (RC = IDNO) Then
                Exit Sub
            Else
                'Attempt to add the record and display a status message.
                If (AddNewRecord = True) Then
                    RC = MessageBox(Me.hwnd, _
                                    "Record successfully added!", _
                                    "Codes Table Explorer", _
                                    MB_OK Or MB_ICONEXCLAMATION)
                Else
                    RC = MsgBox(Me.hwnd, _
                                "Unable to process new record!", _
                                "Codes Table Explorer", _
                                MB_OK Or MB_ICONEXCLAMATION)
                End If
            End If
        Else
            'Attempt to modify the record and display a status message.
            If (ModifyRecord = True) Then
                RC = MessageBox(Me.hwnd, _
                                "Record successfully Modified!", _
                                "Codes Table Explorer", _
                                MB_OK Or MB_ICONEXCLAMATION)
            Else
                RC = MessageBox(Me.hwnd, _
                                "Unable to modify current record!", _
                                "Codes Table Explorer", _
                                MB_OK Or MB_ICONEXCLAMATION)
            End If
        End If

    End If

    'Refresh the list box on the main window.
    RefreshCodeDecodeLB
    bModified = False
    
End Sub


'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    Dim RC As Integer, x As Integer
    
    bFormLoaded = False
    
     'Build the list of available clients.
    GetClientCBox
   
   
    'If we are adding a new Key...
    If (bAddNewKey) Then
        
        Me.Caption = CurTable & " - Add New Key"
        cmdProcess.Caption = "&Add"
        txtKey.Text = "E"
        txtKey.SelStart = Len(txtKey.Text) + 1
        
    
    'We are modifying a current Key.
    Else
        
        Me.Caption = CurTable & " - Modify Existing Key"
        cmdProcess.Caption = "&Modify"
        txtKey.Text = CurKey
        
        strSQL = "select Decode, Client, Description, CName, CobolName, Comments " & _
                 "from tblEntries where TableName = " & Chr(39) & CurTable & Chr(39) & _
                 " and Key = " & Chr(39) & CurKey & Chr(39)
        Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
        If Not DaoRS.EOF Then
            
            'Get the current decode.
            If Len(DaoRS(0).Value) > 0 Then
                txtDecode.Text = RTrim(DaoRS(0).Value)
            Else
                txtDecode.Text = " "
            End If
            
            
            'Get the description.
            If Len(DaoRS(2).Value) > 0 Then
                txtDesc.Text = RTrim(DaoRS(2).Value)
            Else
                txtDesc.Text = " "
            End If
            
            
            'Get the C variable name.
            If (Len(DaoRS(3).Value) > 0) Then
                txtCName.Text = RTrim(DaoRS(3).Value)
            Else
                txtCName.Text = ""
            End If
            
            
            'Get the Cobol variable name.
            If (Len(DaoRS(4).Value) > 0) Then
                txtCobolName.Text = RTrim(DaoRS(4).Value)
            Else
                txtCobolName.Text = ""
            End If
            
            
            'Get the comments.
            If (Len(DaoRS(5).Value) > 0) Then
                txtComments.Text = RTrim(DaoRS(5).Value)
            Else
                txtComments.Text = " "
            End If
            
            
            'Set up the client combo box.
            For x = 0 To UBound(ClientArray)
                If (DaoRS(1).Value = ClientArray(x).Code) Then
                    cbxClients.ListIndex = x
                    CurClient = DaoRS(1).Value
                    Exit For
                End If
            Next

            DaoRS.Close
        
        End If
    
    End If
    
    bModified = False
    bFormLoaded = True
    
End Sub



'***************************************************************************************************************
Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
'***************************************************************************************************************
    Dim RC As Integer
    
    'If something was modified then query to save changes.
    If ((bModified) And (cmdProcess.Enabled)) Then
        RC = MessageBox(Me.hwnd, _
                        "Some of the fields have been modified." & vbCrLf & _
                        "Do you wish to save these changes?", _
                        "Codes Table Explorer", _
                        MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON1)
    
        If (RC = IDYES) Then
            cmdProcess_Click
        End If
    
    End If
End Sub


'***************************************************************************************************************
Private Sub txtCName_Change()
'***************************************************************************************************************
        bModified = True
End Sub

'***************************************************************************************************************
Private Sub txtCobolName_Change()
'***************************************************************************************************************
    bModified = True
End Sub

'***************************************************************************************************************
Private Sub txtComments_Change()
'***************************************************************************************************************
    bModified = True
End Sub


'***************************************************************************************************************
Private Sub txtDecode_Change()
'***************************************************************************************************************
    'Set the modified flag to true
    bModified = True
    
    'Refresh the window controls.
    WindowRefresh

End Sub


'***************************************************************************************************************
Private Sub txtDesc_Change()
'***************************************************************************************************************
    bModified = True
End Sub


'***************************************************************************************************************
Private Sub txtKey_Change()
'***************************************************************************************************************
    bModified = True
    
    'Refresh the window controls
    WindowRefresh
    
End Sub



'***************************************************************************************************************
Public Sub WindowRefresh()
'***************************************************************************************************************
    Dim DecodeMaxLen As Integer, KeyMaxLen As Integer
    Dim RC As Integer
    
    'Take care of the Key field.
    KeyMaxLen% = frmMain.txtKeyLength.Text
    
    If (Len(txtKey.Text) = 1) Then
        txtKey.BackColor = &HFFFF&
        bKeyOK = False
    
    ElseIf ((Len(txtKey.Text) > 1) And (Len(txtKey.Text) <= KeyMaxLen)) Then
        txtKey.BackColor = &H80000005
        bKeyOK = True
        
        'Force the characters to be upper case.
        txtKey.Text = UCase(txtKey.Text)
        
        'If there is not an 'E' at the front of the key, put it there.
        If (Not Left(txtKey.Text, 1) = "E") Then
            txtKey.Text = "E" & txtKey.Text
        End If
        
        'Move the cursor to the end of the text.
        txtKey.SelStart = Len(txtKey.Text) + 1
    
    ElseIf (Len(txtKey.Text) > KeyMaxLen) Then
        txtKey.BackColor = &HFF&
        If bKeyOK Then
            bKeyOK = False
            RC = MessageBox(Me.hwnd, _
                            "Maximum Key length exceeded!" & vbCrLf & _
                            "The Key length for this table is " & KeyMaxLen, _
                            "Codes Table Explorer", _
                            MB_OK Or MB_ICONEXCLAMATION)
        End If
        
    ElseIf (Len(txtKey.Text) < 1) Then
            
            txtKey.Text = "E" & txtKey.Text
            
            'Move the cursor to the end of the text.
            txtKey.SelStart = Len(txtKey.Text) + 1
            
            bKeyOK = False
    End If

    
    'Take care of the decode field.
    DecodeMaxLen% = frmMain.txtDecodeLength.Text
    
    If ((Len(txtDecode.Text) > 0) And (Len(txtDecode.Text) <= DecodeMaxLen)) Then
        txtDecode.BackColor = &H80000005
        bDecodeOK = True
        
    ElseIf (Len(txtDecode.Text) = 0) Then
        txtDecode.BackColor = &HFFFF&
        bDecodeOK = False
        
    ElseIf (Len(txtDecode.Text) > DecodeMaxLen) Then
        txtDecode.BackColor = &HFF&
        If bDecodeOK Then
            bDecodeOK = False
            RC = MessageBox(Me.hwnd, _
                            "Maximum Decode length exceeded!" & vbCrLf & _
                            "The Decode length for this table is " & DecodeMaxLen, _
                            "Codes Table Explorer", _
                            MB_OK Or MB_ICONEXCLAMATION)
        End If
    End If

    
    If bKeyOK And bDecodeOK Then
        cmdProcess.Enabled = True
    Else
        cmdProcess.Enabled = False
    End If


End Sub



'***************************************************************************************************************
Public Function AddNewRecord() As Boolean
'***************************************************************************************************************
    
    'Make sure that there is at least a space within each text field.
    If (txtDesc.Text = "") Then txtDesc.Text = " "
    If (txtCName.Text = "") Then txtCName.Text = " "
    If (txtCobolName.Text = "") Then txtCobolName = " "
   
   
    strSQL = "INSERT INTO tblEntries" & _
            " (TableName, Key, Decode, Client, Description, CName, CobolName, Comments, SystemUse, StaticTableUse, CodesTableUse) " & _
            "VALUES (" & _
            Chr(39) & CurTable & Chr(39) & ", " & _
            Chr(39) & txtKey.Text & Chr(39) & ", " & _
            Chr(39) & txtDecode.Text & Chr(39) & ", " & _
            CurClient & ", " & _
            Chr(39) & txtDesc.Text & Chr(39) & ", " & _
            Chr(39) & txtCName.Text & Chr(39) & ", " & _
            Chr(39) & txtCobolName.Text & Chr(39) & ", "
   
   
   
    
    'Figure out what the comment should be
    If ((txtComments.Text = "") Or (InStr(txtComments.Text, "Last Updated") > 0) Or (txtComments.Text = " ")) Then
        strSQL = strSQL & Chr(39) & "Last Updated " & Date & " - " & Time & " by " & UCase(CurrentUser) & Chr(39) & ", "
    End If
    
    
    'Add the System Usage Flags.
    If (chkSystem.Value = 1) Then
        strSQL = strSQL & True & ", "
    Else
        strSQL = strSQL & False & ", "
    End If
    
    
    'Add the Static Table Usage Flags.
    If (chkStatic.Value = 1) Then
        strSQL = strSQL & True & ", "
    Else
        strSQL = strSQL & False & ", "
    End If
    
    
    'Add the Codes Table Usage Flags.
    If (chkCodes.Value = 1) Then
        strSQL = strSQL & True
    Else
        strSQL = strSQL & False
    End If
    
    'Finish the SQL string
    strSQL = strSQL & ");"
    
    Debug.Print strSQL
    
    'Set up the error handling.
    On Error GoTo InsertError
    
    'Begin a new transaction.
     wsCTM.BeginTrans

    'Execute the update.
    dbCTM.Execute strSQL
            
    'Check the results of the insert.
    If (dbCTM.RecordsAffected = 1) Then
        wsCTM.CommitTrans
        CurKey = txtKey.Text
        AddNewRecord = True
    Else
        wsCTM.Rollback
        AddNewRecord = False
    End If

Exit Function

InsertError:
    Dim msg As String, RC As Integer
    msg = "An error has occured within AddNewRecord of frmAddModKey" & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    
    Debug.Print Err.Number
    Debug.Print Err.Description
    
    RC = MsgBox(msg, _
                vbOKOnly + vbCritical + vbMsgBoxHelpButton, _
                "Codes Table Explorer", _
                Err.HelpFile, _
                Err.HelpContext)
    Resume Next
End Function



'***************************************************************************************************************
Public Function ModifyRecord() As Boolean
'***************************************************************************************************************

    'Make sure that there is at least a space within each text field.
    If (txtDesc.Text = "") Then txtDesc.Text = " "
    If (txtCName.Text = "") Then txtCName.Text = " "
    If (txtCobolName.Text = "") Then txtCobolName = " "
   
    'Put together the base update SQL
    strSQL = "UPDATE tblEntries SET " & _
             "Key = " & Chr(39) & txtKey.Text & Chr(39) & ", " & _
             "Decode = " & Chr(39) & txtDecode.Text & Chr(39) & ", " & _
             "Client = " & CurClient & ", " & _
             "Description = " & Chr(39) & txtDesc.Text & Chr(39) & ", " & _
             "CName = " & Chr(39) & txtCName.Text & Chr(39) & ", " & _
             "CobolName = " & Chr(39) & txtCobolName.Text & Chr(39) & ", " & _
             "Comments = " & Chr(39)
    
    
    'Figure out what the comment should be
    If ((txtComments.Text = "") Or (InStr(txtComments.Text, "Last Updated") > 0) Or (txtComments.Text = " ")) Then
        strSQL = strSQL & "Last Updated " & Date & " - " & Time & " by " & UCase(CurrentUser) & Chr(39) & ", "
    Else
        strSQL = strSQL & txtComments.Text & Chr(39) & " ,"
    End If
    
    
    'Add the System Usage Flags.
    If (chkSystem.Value = 1) Then
        strSQL = strSQL & "SystemUse = " & True & ", "
    Else
        strSQL = strSQL & "SystemUse = " & False & ", "
    End If
    
    
    'Add the Static Table Usage Flags.
    If (chkStatic.Value = 1) Then
        strSQL = strSQL & "StaticTableUse = " & True & ", "
    Else
        strSQL = strSQL & "StaticTableUse = " & False & ", "
    End If
    
    
    'Add the Codes Table Usage Flags.
    If (chkCodes.Value = 1) Then
        strSQL = strSQL & "CodesTableUse = " & True
    Else
        strSQL = strSQL & "CodesTableUse = " & False
    End If
    
    'Finish the SQL string
    strSQL = strSQL & " WHERE TableName = " & Chr(39) & CurTable & Chr(39) & _
                      " AND Key = " & Chr(39) & txtKey.Text & Chr(39) & _
                      " AND Client = " & GetClientDecode(frmMain.lvListView.SelectedItem.SubItems(2))
    
    Debug.Print strSQL
    
    'Set up the error handling.
    On Error GoTo UpdateError
    
    'Begin a new transaction.
     wsCTM.BeginTrans

    'Execute the update.
    dbCTM.Execute strSQL
            
    'Check the results of the insert.
    If (dbCTM.RecordsAffected = 1) Then
        wsCTM.CommitTrans
        CurKey = txtKey.Text
        ModifyRecord = True
    Else
        wsCTM.Rollback
        ModifyRecord = False
    End If

Exit Function

UpdateError:
    Dim msg As String, RC As Integer
    msg = "An error has occured within ModifyRecord of frmAddModKey" & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    
    Debug.Print Err.Number
    Debug.Print Err.Description
    
    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton + vbApplicationModal, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
    Resume Next
End Function


'***************************************************************************************************************
Public Sub GetClientCBox()
'***************************************************************************************************************
    
    ReDim ClientArray(0)

    cbxClients.Enabled = False
    cbxClients.Clear
    Screen.MousePointer = vbHourglass
    
    strSQL = "select Client, Code from tblClients order by Code"
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        
        While Not DaoRS.EOF
            cbxClients.AddItem DaoRS(0).Value
            ClientArray(UBound(ClientArray)).Client = DaoRS(0).Value
            ClientArray(UBound(ClientArray)).Code = DaoRS(1).Value
            ReDim Preserve ClientArray(UBound(ClientArray) + 1)
            DaoRS.MoveNext
        Wend
    
        DaoRS.Close
        cbxClients.ListIndex = 0
    End If

    Screen.MousePointer = vbNormal

    'Enable the combo box.
    cbxClients.Enabled = True

End Sub


