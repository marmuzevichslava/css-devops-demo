VERSION 5.00
Begin VB.Form frmAddModKey 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   3975
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7545
   FillStyle       =   6  'Cross
   Icon            =   "frmaddmodkey.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3975
   ScaleWidth      =   7545
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkClientUse 
      Caption         =   "Check1"
      Enabled         =   0   'False
      Height          =   255
      Left            =   1350
      TabIndex        =   21
      Top             =   2185
      Width           =   255
   End
   Begin VB.TextBox txtDecode 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1350
      TabIndex        =   1
      ToolTipText     =   "Decode for the current Key"
      Top             =   653
      Width           =   5970
   End
   Begin VB.ComboBox cbxApplication 
      Height          =   315
      Left            =   1350
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   1449
      Width           =   2415
   End
   Begin VB.TextBox txtKey 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   1350
      TabIndex        =   0
      ToolTipText     =   "Key Code to Add/Modify"
      Top             =   255
      Width           =   2295
   End
   Begin VB.ComboBox cbxClients 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1350
      Style           =   2  'Dropdown List
      TabIndex        =   2
      ToolTipText     =   "Client this entry applies to"
      Top             =   1051
      Width           =   2415
   End
   Begin VB.TextBox txtComments 
      Height          =   315
      Left            =   1350
      TabIndex        =   7
      ToolTipText     =   "Comments for current Key"
      Top             =   2925
      Width           =   5925
   End
   Begin VB.TextBox txtDesc 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1350
      TabIndex        =   6
      ToolTipText     =   "Decription of the current Key"
      Top             =   2523
      Width           =   5925
   End
   Begin VB.CheckBox chkHostUse 
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
      Height          =   255
      Left            =   1350
      MaskColor       =   &H00000000&
      TabIndex        =   20
      TabStop         =   0   'False
      ToolTipText     =   "Indicates the current Key is used to drive system logic"
      Top             =   1847
      UseMaskColor    =   -1  'True
      Width           =   255
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
      Left            =   2392
      TabIndex        =   8
      ToolTipText     =   "Add/Modify Key"
      Top             =   3375
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
      Left            =   3937
      TabIndex        =   9
      ToolTipText     =   "Return to main"
      Top             =   3375
      Width           =   1215
   End
   Begin VB.ComboBox cbxRelease 
      Height          =   315
      Left            =   4920
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   1410
      Width           =   2415
   End
   Begin VB.ComboBox cbxPlatform 
      Height          =   315
      Left            =   4920
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   1005
      Width           =   2415
   End
   Begin VB.Label lblClientLogic 
      Caption         =   "Drives Client Logic"
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
      Left            =   1680
      TabIndex        =   19
      Top             =   2220
      Width           =   2295
   End
   Begin VB.Label lblHostLogic 
      Caption         =   "Drives Host Logic"
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
      Left            =   1680
      TabIndex        =   18
      Top             =   1875
      Width           =   2295
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "Code:"
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
      Left            =   645
      TabIndex        =   17
      Top             =   285
      Width           =   615
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
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
      Left            =   645
      TabIndex        =   16
      Top             =   1080
      Width           =   615
   End
   Begin VB.Label Label10 
      Alignment       =   1  'Right Justify
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
      Left            =   4125
      TabIndex        =   15
      Top             =   1485
      Width           =   780
   End
   Begin VB.Label Label9 
      Alignment       =   1  'Right Justify
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
      Left            =   4065
      TabIndex        =   14
      Top             =   1080
      Width           =   840
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
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
      Left            =   165
      TabIndex        =   13
      Top             =   1485
      Width           =   1095
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
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
      Left            =   180
      TabIndex        =   12
      Top             =   2970
      Width           =   1080
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
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
      Left            =   165
      TabIndex        =   11
      Top             =   2595
      Width           =   1095
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
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
      Left            =   420
      TabIndex        =   10
      Top             =   630
      Width           =   840
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
Public bDecodeOK As Boolean
Public bKeyOK As Boolean
Public bSeqOK As Boolean
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
Private Sub cmdProcess_Click()
'***************************************************************************************************************
    Dim RC As Integer
    Dim strsql As String
    Dim myClient As New Client
    
    'Are we in 'add' mode?
    If (bAddNewKey) Then
        
        myClient.Decode = Me.cbxClients.Text
        
        'Check to see if this new key already exists.
        If (CheckKeyExists(CurTable, txtKey.Text, myClient.Displaycode) = True) Then
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
            If (CheckKeyExists(CurTable, txtKey.Text, myClient.Displaycode) = False) Then
                RC = MessageBox(Me.hwnd, _
                            "This Key does not currently exist on this table!" & vbCrLf & _
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
                        RC = MessageBox(Me.hwnd, _
                                "Unable to process new record!", _
                                "Codes Table Explorer", _
                                MB_OK Or MB_ICONEXCLAMATION)
                    End If
                End If
            Else
                RC = MessageBox(Me.hwnd, _
                            "This Key currently exists on this table!" & vbCrLf & _
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
Private Sub Form_Load()
'***************************************************************************************************************
    Dim RC As Integer, x As Integer
    Dim myClient As New Client
    bFormLoaded = False
    bChangeKey = False
    
     'Build the list of available clients.
    GetClientCBox cbxClients
    
    'Build Application combo box
    GetApplicationCBox Me.cbxApplication
        
    'Build Platform combo box
    GetPlatformCBox Me.cbxPlatform
    
    'Build Release combo box
    GetReleaseCBox Me.cbxRelease
    
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
        
        myClient.Decode = frmMain.lvListView.SelectedItem.SubItems(2)
                 
        strsql = "SELECT DISTINCTROW tblEntries.Key, tblEntries.Decode, tblClients.Client, tblApplications.Application, tblReleases.Release, tblPlatforms.Platform, tblEntries.Comments, tblEntries.Description, tblEntries.HostSystemUse, tblEntries.HostOccurs, tblEntries.ClientSystemUse, tblEntries.ClientOccurs" _
               & " FROM (((tblEntries INNER JOIN tblReleases ON tblEntries.CSSRelease = tblReleases.Code) INNER JOIN tblClients ON tblEntries.Client = tblClients.Code) INNER JOIN tblPlatforms ON tblEntries.Platform = tblPlatforms.Code) INNER JOIN tblApplications ON tblEntries.Application = tblApplications.Code" _
               & " WHERE TableName = " & Chr(34) & CurTable & Chr(34) & "AND Key = " & Chr(34) & CurKey & Chr(34) & " and tblEntries.Client = " & myClient.Displaycode
        
        Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
        If Not DaoRS.EOF Then
            
            'Get the current key.
            If Len(DaoRS(0).Value) > 0 Then
                Me.txtKey = RTrim(DaoRS(0).Value)
            Else
                Me.txtKey = ""
            End If
            
            'Get the decode.
            If Len(DaoRS(1).Value) > 0 Then
                Me.txtDecode = RTrim(DaoRS(1).Value)
            Else
                Me.txtDecode = ""
            End If
            
            'Set up the client combo box.
            For x = 0 To UBound(ClientArray)
                If (DaoRS(2).Value = ClientArray(x).Client) Then
                    cbxClients.ListIndex = x
                    Exit For
                End If
            Next
            
            'Set up the Application combo box.
            For x = 0 To UBound(ApplicationArray)
                If (DaoRS(3).Value = ApplicationArray(x).Application) Then
                    cbxApplication.ListIndex = x
                    Exit For
                End If
            Next
            
            'Set up the Release combo box.
            For x = 0 To UBound(ReleaseArray)
                If (DaoRS(4).Value = ReleaseArray(x).Release) Then
                    cbxRelease.ListIndex = x
                    Exit For
                End If
            Next

            'Set up the Platform combo box.
            For x = 0 To UBound(PlatformArray)
                If (DaoRS(5).Value = PlatformArray(x).Platform) Then
                    cbxPlatform.ListIndex = x
                    Exit For
                End If
            Next
 
            'Get the comments.
            If (Len(DaoRS(6).Value) > 0) Then
                txtComments.Text = RTrim(DaoRS(6).Value)
            Else
                txtComments.Text = ""
            End If
            
            'Get the description.
            If (Len(DaoRS(7).Value) > 0) Then
                Me.txtDesc.Text = RTrim(DaoRS(7).Value)
            Else
                Me.txtDesc.Text = ""
            End If
             
            'Update the check boxes.
            If (Len(DaoRS(8).Value) > 0) Then
                If (DaoRS(8).Value = False) Then
                    Me.chkHostUse.Value = 0
                Else
                    Me.chkHostUse.Value = 1
                    lblHostLogic.Caption = "Drives Host Logic (" & DaoRS(9).Value & ")"
                End If
            Else
                Me.chkHostUse.Value = 0
            End If
            
            If (Len(DaoRS(10).Value) > 0) Then
                If (DaoRS(10).Value = False) Then
                    Me.chkClientUse.Value = 0
                Else
                    Me.chkClientUse.Value = 1
                    lblClientLogic.Caption = "Drives Client Logic (" & DaoRS(11).Value & ")"
                End If
            Else
                Me.chkClientUse.Value = 0
            End If
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



Private Sub Label6_Click()

End Sub

'***************************************************************************************************************
Private Sub txtComments_Change()
'***************************************************************************************************************
    bModified = True
End Sub



Private Sub txtDecode_Change()
    bModified = True
    
    'Refresh the window controls
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
Public Function AddNewRecord() As Boolean
'***************************************************************************************************************
    Dim myClient As New Client
    Dim myApplication As New Application
    Dim myPlatform As New Platform
    Dim myRelease As New Release
    Dim myComment As New Comment
    Dim hDecode As String
    
    myClient.Decode = Me.cbxClients.Text
    myApplication.Decode = Me.cbxApplication.Text
    myPlatform.Decode = Me.cbxPlatform.Text
    myRelease.Decode = Me.cbxRelease.Text

    'Figure out what the comment should be
    myComment.Text = Me.txtComments.Text
    
    'Initialize checkboxes and values for driving logic.
    Me.chkHostUse.Value = 0
    Me.lblHostLogic = "Drives Host Logic"
    Me.chkClientUse.Value = 0
    Me.lblClientLogic = "Drives Client Logic"
    
    'Make sure that there is at least a space within each text field.
    If (txtDesc.Text = "") Then txtDesc.Text = " "
    
'    hDecode = CheckForSpecialChars(txtDecode.Text)
    
    strsql = "INSERT INTO tblEntries" _
            & " (TableName, Key, Decode, Client, Description, Comments, Application, Platform, CSSRelease) " _
            & "VALUES (" _
            & Chr(34) & CurTable & Chr(34) & ", " _
            & Chr(34) & txtKey.Text & Chr(34) & ", " _
            & Chr(34) & txtDecode.Text & Chr(34) & ", " _
            & myClient.Displaycode & ", " _
            & Chr(34) & txtDesc.Text & Chr(34) & ", " _
            & Chr(34) & myComment.DisplayComment & Chr(34) & ", " _
            & myApplication.Displaycode & ", " _
            & myPlatform.Displaycode & ", " _
            & myRelease.Displaycode & ");"
    
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
    msg = "An error has occured within AddNewRecord of frmAddModKey" & vbCrLf & _
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
    Dim myApplication As New Application
    Dim myPlatform As New Platform
    Dim myRelease As New Release
    Dim myComment As New Comment
    Dim hDecode As String
        
    myClient.Decode = Me.cbxClients.Text
    myApplication.Decode = Me.cbxApplication.Text
    myPlatform.Decode = Me.cbxPlatform.Text
    myRelease.Decode = Me.cbxRelease.Text
      
    'Figure out what the comment should be.
    myComment.Text = Me.txtComments.Text
    
    'Update check boxes and captions for driving logic.
    strsql = "SELECT DISTINCTROW tblEntries.HostSystemUse, tblEntries.HostOccurs, tblEntries.ClientSystemUse, tblEntries.ClientOccurs" _
               & " FROM tblEntries" _
               & " WHERE TableName = " & Chr(34) & CurTable & Chr(34) & "AND Key = " & Chr(34) & txtKey.Text & Chr(34) & " And tblEntries.Client = " & myClient.Displaycode
        
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        'Update the check boxes.
            If (Len(DaoRS(0).Value) > 0) Then
                If (DaoRS(0).Value = False) Then
                    Me.chkHostUse.Value = 0
                    lblHostLogic.Caption = "Drives Host Logic"
                Else
                    Me.chkHostUse.Value = 1
                    lblHostLogic.Caption = "Drives Host Logic (" & DaoRS(1).Value & ")"
                End If
            Else
                Me.chkHostUse.Value = 0
                lblHostLogic.Caption = "Drives Host Logic"
            End If
            
            If (Len(DaoRS(2).Value) > 0) Then
                If (DaoRS(2).Value = False) Then
                    Me.chkClientUse.Value = 0
                    lblClientLogic.Caption = "Drives Client Logic"
                Else
                    Me.chkClientUse.Value = 1
                    lblClientLogic.Caption = "Drives Client Logic (" & DaoRS(3).Value & ")"
                End If
            Else
                Me.chkClientUse.Value = 0
                lblClientLogic.Caption = "Drives Client Logic"
            End If
            DaoRS.Close
        
    End If
        
    'Make sure that there is at least a space within each text field.
    If (txtDesc.Text = "") Then txtDesc.Text = " "
    
'    hDecode = CheckForSpecialChars(txtDecode.Text)
    
    'Put together the base update SQL
    strsql = "UPDATE tblEntries SET " _
             & "Key = " & Chr(34) & txtKey.Text & Chr(34) & ", " _
             & "Decode = " & Chr(34) & txtDecode.Text & Chr(34) & ", " _
             & "Client = " & myClient.Displaycode & ", " _
             & "Description = " & Chr(34) & txtDesc.Text & Chr(34) & ", " _
             & "Comments = " & Chr(34) & myComment.DisplayComment & Chr(34) & ", " _
             & "Application = " & myApplication.Displaycode & ", " _
             & "Platform = " & myPlatform.Displaycode & ", " _
             & "CSSRelease = " & myRelease.Displaycode _
             & " WHERE TableName = " & Chr(34) & CurTable & Chr(34) _
             & " AND Key = " & Chr(34) & txtKey.Text & Chr(34) _
             & " AND Client = " & myClient.Displaycode & ";"
    
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
    Debug.Print strsql
    Dim msg As String, RC As Integer
    msg = "An error has occured within ModifyRecord of frmAddModKey" & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    
    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton + vbApplicationModal, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
    Resume Next
End Function
