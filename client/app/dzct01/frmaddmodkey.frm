VERSION 5.00
Begin VB.Form frmAddModKey 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   3570
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7695
   Icon            =   "frmAddModKey.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3570
   ScaleWidth      =   7695
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox cbxApplication 
      Height          =   315
      ItemData        =   "frmAddModKey.frx":030A
      Left            =   1350
      List            =   "frmAddModKey.frx":030C
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   999
      Width           =   2295
   End
   Begin VB.ComboBox cbxRelease 
      Height          =   315
      Left            =   1350
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   1773
      Width           =   2295
   End
   Begin VB.ComboBox cbxPlatform 
      Height          =   315
      Left            =   1350
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   1386
      Width           =   2295
   End
   Begin VB.TextBox txtKey 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1350
      TabIndex        =   0
      ToolTipText     =   "Key Code to Add/Modify"
      Top             =   225
      Width           =   2295
   End
   Begin VB.TextBox txtDecode 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1350
      TabIndex        =   1
      ToolTipText     =   "Decode for the current Key"
      Top             =   612
      Width           =   5970
   End
   Begin VB.TextBox txtComments 
      Height          =   675
      Left            =   4920
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   7
      ToolTipText     =   "Comments for current Key"
      Top             =   1440
      Width           =   2370
   End
   Begin VB.ComboBox cbxClients 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   4920
      Style           =   2  'Dropdown List
      TabIndex        =   3
      ToolTipText     =   "Client this entry applies to"
      Top             =   1017
      Width           =   2415
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Close"
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
      Left            =   4080
      TabIndex        =   12
      ToolTipText     =   "Add the current user id"
      Top             =   3015
      Width           =   1215
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
      Height          =   375
      Left            =   2520
      TabIndex        =   11
      ToolTipText     =   "Add the current user id"
      Top             =   3015
      Width           =   1215
   End
   Begin VB.CheckBox chkStatic 
      Caption         =   "Static Tables"
      Height          =   255
      Left            =   1740
      TabIndex        =   8
      ToolTipText     =   "Indicates the current Key is used in a Static Table"
      Top             =   2655
      Width           =   1560
   End
   Begin VB.CheckBox chkCodes 
      Caption         =   "Codes Tables"
      Height          =   255
      Left            =   5490
      TabIndex        =   10
      ToolTipText     =   "Indicates the current Key is used in another Codes Table"
      Top             =   2655
      Width           =   1485
   End
   Begin VB.CheckBox chkSystem 
      Caption         =   "System Code"
      Height          =   255
      Left            =   3615
      TabIndex        =   9
      ToolTipText     =   "Indicates the current Key is used in System Code"
      Top             =   2655
      Width           =   1485
   End
   Begin VB.TextBox txtDesc 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1350
      TabIndex        =   5
      ToolTipText     =   "Decription of the current Key"
      Top             =   2160
      Width           =   5925
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
      Left            =   480
      TabIndex        =   20
      Top             =   1800
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
      Left            =   420
      TabIndex        =   19
      Top             =   1440
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
      TabIndex        =   18
      Top             =   1080
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
      Left            =   3720
      TabIndex        =   17
      Top             =   1440
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
      TabIndex        =   16
      Top             =   2160
      Width           =   1095
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
      Left            =   4200
      TabIndex        =   15
      Top             =   1155
      Width           =   615
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
      TabIndex        =   14
      Top             =   630
      Width           =   840
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
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
      Left            =   645
      TabIndex        =   13
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
    Dim myClient As New client
    
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
    RefreshCodeDecodeLB
    bModified = False
    
End Sub


'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    Dim RC As Integer, x As Integer
    Dim myClient As New client
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
                 
        strsql = "SELECT DISTINCTROW tblEntries.Key, tblEntries.Decode, tblClients.Client, tblApplications.Application, tblReleases.Release, tblPlatforms.Platform, tblEntries.Comments, tblEntries.Description, tblEntries.SystemUse, tblEntries.StaticTableUse, tblEntries.CodesTableUse" _
                 & " FROM (((tblEntries INNER JOIN tblApplications ON tblEntries.Application = tblApplications.Code) INNER JOIN tblClients ON tblEntries.Client = tblClients.Code) INNER JOIN tblReleases ON tblEntries.CSSRelease = tblReleases.Code) INNER JOIN tblPlatforms ON tblEntries.Platform = tblPlatforms.Code" _
                 & " WHERE TableName = " & Chr(39) & CurTable & Chr(39) & "AND Key = " & Chr(39) & CurKey & Chr(39) & " and tblEntries.Client = " & myClient.Displaycode
                 
         Debug.Print strsql
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
                If (DaoRS(2).Value = ClientArray(x).client) Then
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
                    cbxClients.ListIndex = x
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
             
            If (Len(DaoRS(8).Value) > 0) Then
                If (DaoRS(8).Value = False) Then
                    Me.chkSystem.Value = 0
                Else
                    Me.chkSystem.Value = 1
                End If
            Else
                Me.chkSystem.Value = 0
            End If
             
            If (Len(DaoRS(9).Value) > 0) Then
                If (DaoRS(9).Value = False) Then
                    Me.chkStatic.Value = 0
                Else
                    Me.chkStatic.Value = 1
                End If
            Else
                Me.chkStatic.Value = 0
            End If

            If (Len(DaoRS(10).Value) > 0) Then
                If (DaoRS(10).Value = False) Then
                    Me.chkCodes.Value = 0
                Else
                    Me.chkCodes.Value = 1
                End If
            Else
                Me.chkCodes.Value = False
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
    Dim myClient As New client
    Dim myApplication As New Application
    Dim myPlatform As New Platform
    Dim myRelease As New Release
    Dim myComment As New Comment
    Dim lFromLen As Long, lLen As Long, lLeft As Long
    
    myClient.Decode = Me.cbxClients.Text
    myApplication.Decode = Me.cbxApplication.Text
    myPlatform.Decode = Me.cbxPlatform.Text
    myRelease.Decode = Me.cbxRelease.Text

    'Figure out what the comment should be
    myComment.Text = Me.txtComments.Text
   
    'Make sure that there is at least a space within each text field.
    If (txtDesc.Text = "") Then txtDesc.Text = " "
    
    strsql = "INSERT INTO tblEntries" _
            & " (TableName, Key, Decode, Client, Description, Comments, Application, Platform, CSSRelease, SystemUse, StaticTableUse, CodesTableUse) " _
            & "VALUES (" _
            & Chr(39) & CurTable & Chr(39) & ", " _
            & Chr(39) & txtKey.Text & Chr(39) & ", " _
            & Chr(39) & txtDecode.Text & Chr(39) & ", " _
            & myClient.Displaycode & ", " _
            & Chr(39) & txtDesc.Text & Chr(39) & ", " _
            & Chr(39) & myComment.DisplayComment & Chr(39) & ", " _
            & myApplication.Displaycode & ", " _
            & myPlatform.Displaycode & ", " _
            & myRelease.Displaycode & ", "
    
    'Add the System Usage Flags.
    If (chkSystem.Value = 1) Then
        strsql = strsql & True & ", "
    Else
        strsql = strsql & False & ", "
    End If
    
    
    'Add the Static Table Usage Flags.
    If (chkStatic.Value = 1) Then
        strsql = strsql & True & ", "
    Else
        strsql = strsql & False & ", "
    End If
    
    
    'Add the Codes Table Usage Flags.
    If (chkCodes.Value = 1) Then
        strsql = strsql & True
    Else
        strsql = strsql & False
    End If
    
    'Finish the SQL string
    strsql = strsql & ");"
    
    Debug.Print strsql
    
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
    Dim myClient As New client
    Dim myApplication As New Application
    Dim myPlatform As New Platform
    Dim myRelease As New Release
    Dim myComment As New Comment


    
    myClient.Decode = Me.cbxClients.Text
    myApplication.Decode = Me.cbxApplication.Text
    myPlatform.Decode = Me.cbxPlatform.Text
    myRelease.Decode = Me.cbxRelease.Text
    
    'Figure out what the comment should be
    myComment.Text = Me.txtComments.Text
    
    'Make sure that there is at least a space within each text field.
    If (txtDesc.Text = "") Then txtDesc.Text = " "
    
    'Put together the base update SQL
    strsql = "UPDATE tblEntries SET " _
             & "Key = " & Chr(39) & txtKey.Text & Chr(39) & ", " _
             & "Decode = " & Chr(39) & txtDecode.Text & Chr(39) & ", " _
             & "Client = " & myClient.Displaycode & ", " _
             & "Description = " & Chr(39) & txtDesc.Text & Chr(39) & ", " _
             & "Comments = " & Chr(39) & myComment.DisplayComment & Chr(39) & ", " _
             & "Application = " & myApplication.Displaycode & ", " _
             & "Platform = " & myPlatform.Displaycode & ", " _
             & "CSSRelease = " & myRelease.Displaycode & ", " _


    'Add the System Usage Flags.
    If (chkSystem.Value = 1) Then
        strsql = strsql & "SystemUse = " & True & ", "
    Else
        strsql = strsql & "SystemUse = " & False & ", "
    End If
    
    'Add the Static Table Usage Flags.
    If (chkStatic.Value = 1) Then
        strsql = strsql & "StaticTableUse = " & True & ", "
    Else
        strsql = strsql & "StaticTableUse = " & False & ", "
    End If
    
    
    'Add the Codes Table Usage Flags.
    If (chkCodes.Value = 1) Then
        strsql = strsql & "CodesTableUse = " & True
    Else
        strsql = strsql & "CodesTableUse = " & False
    End If
    
    
    'Finish the SQL string
    myClient.Decode = frmMain.lvListView.SelectedItem.SubItems(2)
    strsql = strsql & " WHERE TableName = " & Chr(39) & CurTable & Chr(39) & _
                      " AND Key = " & Chr(39) & txtKey.Text & Chr(39) & _
                      " AND Client = " & myClient.Displaycode
    
Debug.Print strsql
    
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
    Debug.Print strsql
    End If

Exit Function

UpdateError:
    Dim msg As String, RC As Integer
    msg = "An error has occured within ModifyRecord of frmAddModKey" & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    Debug.Print strsql
    Debug.Print Err.Number
    Debug.Print Err.Description
    
    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton + vbApplicationModal, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
    Resume Next
End Function


''***************************************************************************************************************
'Public Sub GetClientCBox()
''***************************************************************************************************************
'
'    ReDim ClientArray(0)
'
'    cbxClients.Enabled = False
'    cbxClients.Clear
'    Screen.MousePointer = vbHourglass
'
'    strsql = "select Client, Code from tblClients order by Code"
'    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
'
'    If Not DaoRS.EOF Then
'
'        While Not DaoRS.EOF
'            cbxClients.AddItem DaoRS(0).Value
'            ClientArray(UBound(ClientArray)).Client = DaoRS(0).Value
'            ClientArray(UBound(ClientArray)).Code = DaoRS(1).Value
'            ReDim Preserve ClientArray(UBound(ClientArray) + 1)
'            DaoRS.MoveNext
'        Wend
'
'        DaoRS.Close
'        cbxClients.ListIndex = 0
'    End If
'
'    Screen.MousePointer = vbNormal
'
'    'Enable the combo box.
'    cbxClients.Enabled = True
'
'End Sub


