VERSION 5.00
Begin VB.Form frmAddModMsg 
   ClientHeight    =   3285
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8295
   Icon            =   "frmaddmodmsg.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3285
   ScaleWidth      =   8295
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox cbxRelease 
      Height          =   315
      Left            =   1410
      TabIndex        =   5
      Top             =   2055
      Width           =   2295
   End
   Begin VB.ComboBox cbxApplication 
      Height          =   315
      Left            =   1410
      TabIndex        =   3
      Top             =   1335
      Width           =   2295
   End
   Begin VB.ComboBox cbxPlatform 
      Height          =   315
      Left            =   1410
      TabIndex        =   4
      Top             =   1695
      Width           =   2295
   End
   Begin VB.ComboBox cbxClients 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   5190
      TabIndex        =   1
      Top             =   240
      Width           =   2895
   End
   Begin VB.ComboBox cbxDefaultButton 
      Height          =   315
      Left            =   5250
      TabIndex        =   8
      Top             =   2055
      Width           =   2895
   End
   Begin VB.ComboBox cbxIcon 
      Height          =   315
      Left            =   5250
      TabIndex        =   7
      Top             =   1695
      Width           =   2895
   End
   Begin VB.ComboBox cbxButtons 
      Height          =   315
      Left            =   5250
      TabIndex        =   6
      Top             =   1335
      Width           =   2895
   End
   Begin VB.TextBox txtKey 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   1440
      TabIndex        =   0
      ToolTipText     =   "Message Code to Add/Modify"
      Top             =   240
      Width           =   1680
   End
   Begin VB.TextBox txtDecode 
      BackColor       =   &H00FFFFFF&
      Height          =   675
      Left            =   1410
      TabIndex        =   2
      ToolTipText     =   "Decode for the current Key"
      Top             =   615
      Width           =   6705
   End
   Begin VB.TextBox txtComments 
      Height          =   315
      Left            =   1395
      TabIndex        =   9
      Top             =   2430
      Width           =   6765
   End
   Begin VB.CommandButton cmdProcess 
      Caption         =   "&Add"
      Default         =   -1  'True
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
      Height          =   330
      Left            =   2955
      TabIndex        =   10
      ToolTipText     =   "Add/Modify Message"
      Top             =   2850
      Width           =   1215
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Cancel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   4605
      TabIndex        =   11
      ToolTipText     =   "Return to main"
      Top             =   2850
      Width           =   1215
   End
   Begin VB.Label Label10 
      Caption         =   "Release:"
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
      Left            =   600
      TabIndex        =   21
      Top             =   2085
      Width           =   780
   End
   Begin VB.Label Label9 
      Caption         =   "Platform:"
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
      Left            =   600
      TabIndex        =   20
      Top             =   1732
      Width           =   840
   End
   Begin VB.Label Label8 
      Caption         =   "Application:"
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
      Left            =   345
      TabIndex        =   19
      Top             =   1372
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "Message Code:"
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
      Left            =   120
      TabIndex        =   18
      Top             =   270
      Width           =   1335
   End
   Begin VB.Label Label1 
      Caption         =   "Message Box Text:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   465
      Left            =   585
      TabIndex        =   17
      Top             =   615
      Width           =   840
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
      Left            =   4590
      TabIndex        =   16
      Top             =   270
      Width           =   615
   End
   Begin VB.Label Label4 
      Caption         =   "Buttons:"
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
      Left            =   4455
      TabIndex        =   15
      Top             =   1372
      Width           =   735
   End
   Begin VB.Label Label5 
      Caption         =   "Icons:"
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
      Left            =   4605
      TabIndex        =   14
      Top             =   1732
      Width           =   585
   End
   Begin VB.Label Label6 
      Caption         =   "Default Button:"
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
      Left            =   3840
      TabIndex        =   13
      Top             =   2092
      Width           =   1350
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
      Left            =   450
      TabIndex        =   12
      Top             =   2460
      Width           =   960
   End
End
Attribute VB_Name = "frmAddModMsg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public bFormLoaded As Boolean
Public bModified As Boolean
Public bDecodeOK As Boolean
Public bKeyOK As Boolean
Public bChangeKey As Boolean

'***************************************************************************************************************
Private Sub cbxClients_Click()
'***************************************************************************************************************
    
    If (bFormLoaded = True) Then
        
        bChangeKey = True
        bModified = True

    End If
End Sub




'***************************************************************************************************************
Private Sub cmdCancel_Click()
'***************************************************************************************************************
    Unload Me
End Sub

'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    Dim RC As Integer, x As Integer
    Dim myClient As New Client
    
    bFormLoaded = False
    bChangeKey = False
   
    'Build Combo Boxes
    BuildComboBoxes
   
    'If we are adding a new Key...
    If (bAddNewKey) Then

        Me.Caption = CurTable & " - Add New Message"
        cmdProcess.Caption = "&Add"
        txtKey.SelStart = Len(txtKey.Text) + 0

    'We are modifying a current Key.
    Else

        Me.Caption = CurTable & " - Modify Existing Message"
        cmdProcess.Caption = "&Modify"
        txtKey.Text = CurKey
        
        'Gets the code for Client
        myClient.Decode = frmMain.lvListView.SelectedItem.SubItems(2)

        'Set up the client combo box.
        For x = 0 To UBound(ClientArray)
            If ((myClient.Displaycode = ClientArray(x).Code)) Then
                cbxClients.ListIndex = x
                Exit For
            End If
        Next
        
        strsql = "SELECT MsgBoxText, Buttons, Icon, DefaultButton, Application, Platform, CSSRelease, Comments " & _
                 " From tblMsgBoxEntries " & _
                 " WHERE TableName = " & Chr(34) & CurTable & Chr(34) & _
                 " AND   Code = " & CurKey & _
                 " AND   Client = " & myClient.Displaycode
        
        Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

        If Not DaoRS.EOF Then

            'Get the current message box text
            If Len(DaoRS(0).Value) > 0 Then
                txtDecode.Text = RTrim(DaoRS(0).Value)
            Else
                txtDecode.Text = " "
            End If

            'Get the message box buttons
            For x = 0 To UBound(ButtonsArray)
                If ((DaoRS(1).Value = ButtonsArray(x).ButtonID)) Then
                    cbxButtons.ListIndex = x
                    Exit For
                End If
            Next

            'Get the message box icons
            For x = 0 To UBound(IconArray)
                If ((DaoRS(2).Value = IconArray(x).IconID)) Then
                    cbxIcon.ListIndex = x
                    Exit For
                End If
            Next

            'Get the message box default button
            For x = 0 To UBound(DefaultButtonArray)
                If ((DaoRS(3).Value = DefaultButtonArray(x).DefaultButtonID)) Then
                    cbxDefaultButton.ListIndex = x
                    Exit For
                End If
            Next

            'Get the application
            For x = 0 To UBound(ApplicationArray)
                If ((DaoRS(4).Value = ApplicationArray(x).Code)) Then
                    cbxApplication.ListIndex = x
                    Exit For
                End If
            Next

            'Get the platform
            For x = 0 To UBound(PlatformArray)
                If ((DaoRS(5).Value = PlatformArray(x).Code)) Then
                    cbxPlatform.ListIndex = x
                    Exit For
                End If
            Next

            'Get the release
            For x = 0 To UBound(ReleaseArray)
                If ((DaoRS(6).Value = ReleaseArray(x).Code)) Then
                    cbxRelease.ListIndex = x
                    Exit For
                End If
            Next

            'Get the comments.
            If (Len(DaoRS(7).Value) > 0) Then
                txtComments.Text = RTrim(DaoRS(7).Value)
            Else
                txtComments.Text = " "
            End If

            DaoRS.Close

        End If

    End If
    
    bModified = False
    bFormLoaded = True
End Sub


'***************************************************************************************************************
Private Sub cmdProcess_Click()
'***************************************************************************************************************
    Dim RC As Integer
    Dim strsql As String
    Dim myClient As New Client
    
    'Are we in 'add' mode?
    If (bAddNewKey) Then
        
        myClient.Decode = Me.cbxClients.Text
        
        'Check to see if this new key already exists.
        If (CheckMsgKeyExists(CurTable, txtKey.Text, myClient.Displaycode) = True) Then
            RC = MessageBox(Me.hwnd, _
                            "This Message Code already exists on this table!" & vbCrLf & _
                            "Would you like to overwrite the existing Code?", _
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
                    RC = MessageBox(Me.hwnd, _
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
                RC = MessageBox(Me.hwnd, _
                            "Unable to process new record!", _
                            "Codes Table Explorer", _
                            MB_OK Or MB_ICONEXCLAMATION)
        
            End If
        End If
    'We are in Modify mode.
    Else
        
        If (bChangeKey) Then
         
            myClient.Decode = Me.cbxClients
         
            'Check to see if this new key already exists.
            If (CheckMsgKeyExists(CurTable, txtKey.Text, myClient.Displaycode) = False) Then
                RC = MessageBox(Me.hwnd, _
                            "This Message Code does not currently exist on this table!" & vbCrLf & _
                            "Would you like to add the current Message Code?", _
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
                        RC = MessageBox(Me.hwnd, _
                                "Unable to process new record!", _
                                "Codes Table Explorer", _
                                MB_OK Or MB_ICONEXCLAMATION)
                    End If
                End If
            Else
                RC = MessageBox(Me.hwnd, _
                            "This Message Key currently exists on this table!" & vbCrLf & _
                            "Would you like to modify the current Key?", _
                            "Codes Table Explorer", _
                            MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON1)
            
                If (RC = IDNO) Then
                    Exit Sub
                Else
                    'Attempt to add the record and display a status message.
                    If (ModifyRecord = True) Then
                        RC = MessageBox(Me.hwnd, _
                                    "Record successfully modified!", _
                                    "Codes Table Explorer", _
                                    MB_OK Or MB_ICONEXCLAMATION)
                    Else
                        RC = MessageBox(Me.hwnd, _
                                "Unable to modify record!", _
                                "Codes Table Explorer", _
                                MB_OK Or MB_ICONEXCLAMATION)
                    End If
                End If
            End If
            bChangeKey = False
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
    Screen.MousePointer = vbHourglass
    
    RefreshCodeDecodeLB
    
    Screen.MousePointer = vbDefault
    
    bModified = False
    
End Sub


'***************************************************************************************************************
Public Function AddNewRecord() As Boolean
'***************************************************************************************************************
    Dim myClient As New Client
    Dim myMsgButtons As New MsgButtons
    Dim myMsgIcon As New MsgIcon
    Dim myMsgDefaultButton As New MsgDefaultButtons
    Dim myApplication As New Application
    Dim myPlatform As New Platform
    Dim myRelease As New Release
    Dim myComment As New Comment
    
    myClient.Decode = Me.cbxClients.Text
    myMsgButtons.Decode = Me.cbxButtons.Text
    myMsgIcon.Decode = Me.cbxIcon.Text
    myMsgDefaultButton.Decode = Me.cbxDefaultButton.Text
    myApplication.Decode = Me.cbxApplication.Text
    myPlatform.Decode = Me.cbxPlatform.Text
    myRelease.Decode = Me.cbxRelease.Text

    'Figure out what the comment should be
    myComment.Text = Me.txtComments.Text
    
    strsql = "INSERT INTO tblMsgBoxEntries " _
            & " (TableName, Client, Application, CSSRelease, Platform, Code, Buttons, Icon, DefaultButton, MsgBoxText, Comments) " _
            & "VALUES (" _
            & Chr(34) & CurTable & Chr(34) & ", " _
            & myClient.Displaycode & ", " _
            & myApplication.Displaycode & ", " _
            & myRelease.Displaycode & ", " _
            & myPlatform.Displaycode & ", " _
            & txtKey.Text & ", " _
            & myMsgButtons.Displaycode & ", " _
            & myMsgIcon.Displaycode & ", " _
            & myMsgDefaultButton.Displaycode & ", " _
            & Chr(34) & txtDecode.Text & Chr(34) & ", " _
            & Chr(34) & myComment.DisplayComment & Chr(34) & ");"
    
    'Set up the error handling.
    On Error GoTo InsertError
    
    'Begin a new transaction.
     wsCTM.BeginTrans

    'Execute the update.
    dbCTM.Execute strsql
            
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
    msg = "An error has occured within AddNewRecord of frmAddModmSG" & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    
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
    Dim myClient As New Client
    Dim myMsgButtons As New MsgButtons
    Dim myMsgIcon As New MsgIcon
    Dim myMsgDefaultButton As New MsgDefaultButtons
    Dim myApplication As New Application
    Dim myPlatform As New Platform
    Dim myRelease As New Release
    Dim myComment As New Comment
    
    myClient.Decode = Me.cbxClients.Text
    myMsgButtons.Decode = Me.cbxButtons.Text
    myMsgIcon.Decode = Me.cbxIcon.Text
    myMsgDefaultButton.Decode = Me.cbxDefaultButton.Text
    myApplication.Decode = Me.cbxApplication.Text
    myPlatform.Decode = Me.cbxPlatform.Text
    myRelease.Decode = Me.cbxRelease.Text
    
    'Figure out what the comment should be
    myComment.Text = Me.txtComments.Text
    
    'Put together the base update SQL
    strsql = " UPDATE tblMsgBoxEntries SET " _
             & " Client = " & myClient.Displaycode & ", " _
             & " Application = " & myApplication.Displaycode & ", " _
             & " CSSRelease = " & myRelease.Displaycode & ", " _
             & " Platform = " & myPlatform.Displaycode & ", " _
             & " Code = " & txtKey.Text & ", " _
             & " Buttons = " & myMsgButtons.Displaycode & ", " _
             & " Icon = " & myMsgIcon.Displaycode & ", " _
             & " DefaultButton = " & myMsgDefaultButton.Displaycode & ", " _
             & " MsgBoxText = " & Chr(34) & txtDecode.Text & Chr(34) & ", " _
             & " Comments = " & Chr(34) & myComment.DisplayComment & Chr(34) _
             & " WHERE TableName = " & Chr(34) & CurTable & Chr(34) _
             & " AND Code = " & txtKey.Text _
             & " AND Client = " & myClient.Displaycode
    
    'Set up the error handling.
    On Error GoTo UpdateError
    
    'Begin a new transaction.
     wsCTM.BeginTrans

    'Execute the update.
    dbCTM.Execute strsql
            
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
    msg = "An error has occured within ModifyRecord of frmAddModMsg" & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    
    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton + vbApplicationModal, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
    Resume Next
End Function


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
Private Sub txtComments_Change()
'***************************************************************************************************************
    bModified = True
End Sub



'***************************************************************************************************************
Private Sub txtDesc_Change()
'***************************************************************************************************************
    bModified = True
End Sub


Private Sub txtDecode_Change()
    bModified = True
    
    'Refresh the window controls
    WindowRefresh
End Sub

'***************************************************************************************************************
Private Sub txtKey_Change()
'***************************************************************************************************************
    bModified = True
    
    If (bFormLoaded = True) Then
        bChangeKey = True
    End If
        
    
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
        
    If (Len(txtKey.Text) = 0) Then
        txtKey.BackColor = &HFFFF&
        bKeyOK = False
    
    ElseIf ((Len(txtKey.Text) > 0) And (Len(txtKey.Text) <= KeyMaxLen)) Then
        txtKey.BackColor = &H80000005
        bKeyOK = True
        
        'Move the cursor to the end of the text.
        txtKey.SelStart = Len(txtKey.Text) + 1
        
        'Insure that the message code is numeric, if not send error message
        If Not IsNumeric(txtKey.Text) Then
            
            txtKey.BackColor = &HFF&
            bKeyOK = False
            RC = MessageBox(Me.hwnd, _
                            "Message Code must be numeric!", _
                            "Codes Table Explorer", _
                            MB_OK)
        End If
    
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
            
            'Move the cursor to the end of the text.
            txtKey.SelStart = Len(txtKey.Text) + 1
            
            bKeyOK = False
    End If

    
    'Take care of the decode field.
    DecodeMaxLen% = frmMain.txtDecodeLength.Text
    
    If ((Len(txtDecode.Text) > 0) And (Len(txtDecode.Text) <= DecodeMaxLen)) Then
        txtDecode.BackColor = &H80000005
        bDecodeOK = True
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
    Else
        bDecodeOK = True
    End If

    
    If bKeyOK And bDecodeOK Then
        cmdProcess.Enabled = True
    Else
        cmdProcess.Enabled = False
    End If


End Sub


'***************************************************************************************************************
Private Sub BuildComboBoxes()
'***************************************************************************************************************
       
    'Build Buttons combo box
    GetButtonCBox Me.cbxButtons
    
    'Build Icon combo box
    GetIconCBox Me.cbxIcon
    
    'Build DefaultButton combo box
    GetDefaultButtonCBox Me.cbxDefaultButton
    
    'Build Client combo box
    GetClientCBox Me.cbxClients
    
    'Build Application combo box
    GetApplicationCBox Me.cbxApplication
        
    'Build Platform combo box
    GetPlatformCBox Me.cbxPlatform
    
    'Build Release combo box
    GetReleaseCBox Me.cbxRelease
    
End Sub
