VERSION 5.00
Begin VB.Form frmAddModUMsg 
   ClientHeight    =   3285
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7500
   Icon            =   "frmAddModUMsg.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3285
   ScaleWidth      =   7500
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox cbxPlatform 
      Height          =   315
      Left            =   1440
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   1680
      Width           =   2295
   End
   Begin VB.ComboBox cbxApplication 
      Height          =   315
      ItemData        =   "frmAddModUMsg.frx":030A
      Left            =   1440
      List            =   "frmAddModUMsg.frx":030C
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   1320
      Width           =   2295
   End
   Begin VB.ComboBox cbxRelease 
      Height          =   315
      Left            =   1440
      Style           =   2  'Dropdown List
      TabIndex        =   7
      Top             =   2040
      Width           =   2295
   End
   Begin VB.CommandButton cmdProcess 
      Caption         =   "&Add"
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
      Left            =   2760
      TabIndex        =   8
      Top             =   2640
      Width           =   1215
   End
   Begin VB.ComboBox cbxClients 
      Height          =   315
      Left            =   4920
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   1320
      Width           =   2295
   End
   Begin VB.TextBox txtSeqNumber 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   6720
      TabIndex        =   2
      ToolTipText     =   "Key Code to Add/Modify"
      Top             =   240
      Width           =   450
   End
   Begin VB.TextBox txtComments 
      BackColor       =   &H00FFFFFF&
      Height          =   675
      Left            =   4920
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   14
      ToolTipText     =   "Key Code to Add/Modify"
      Top             =   1680
      Width           =   2325
   End
   Begin VB.TextBox txtLanguage 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   4680
      TabIndex        =   1
      ToolTipText     =   "Key Code to Add/Modify"
      Top             =   240
      Width           =   330
   End
   Begin VB.TextBox txtDecode 
      BackColor       =   &H00FFFFFF&
      Height          =   675
      Left            =   1440
      TabIndex        =   3
      ToolTipText     =   "Key Code to Add/Modify"
      Top             =   600
      Width           =   5730
   End
   Begin VB.TextBox txtKey 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   1440
      TabIndex        =   0
      ToolTipText     =   "Key Code to Add/Modify"
      Top             =   240
      Width           =   1650
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
      Left            =   4200
      TabIndex        =   10
      Top             =   2640
      Width           =   1215
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
      Left            =   240
      TabIndex        =   19
      Top             =   1350
      Width           =   1095
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
      Left            =   495
      TabIndex        =   18
      Top             =   1710
      Width           =   840
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
      Left            =   555
      TabIndex        =   17
      Top             =   2070
      Width           =   780
   End
   Begin VB.Label Label6 
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
      Height          =   255
      Left            =   3840
      TabIndex        =   16
      Top             =   1350
      Width           =   975
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      Caption         =   "Seq. Number:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   5280
      TabIndex        =   15
      Top             =   240
      Width           =   1335
   End
   Begin VB.Label Label5 
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
      Height          =   255
      Left            =   3840
      TabIndex        =   13
      Top             =   1680
      Width           =   975
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      Caption         =   "Language:"
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
      Left            =   3360
      TabIndex        =   12
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "Error Code:"
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
      Left            =   360
      TabIndex        =   11
      Top             =   600
      Width           =   975
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "Error Number:"
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
      Left            =   120
      TabIndex        =   9
      Top             =   240
      Width           =   1215
   End
End
Attribute VB_Name = "frmAddModUMsg"
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
Private Sub cmdCancel_Click()
'***************************************************************************************************************
Unload Me

End Sub

'***************************************************************************************************************
Public Function AddNewUMsgRecord() As Boolean
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
    
    strsql = "INSERT INTO tblUserErrorMsgEntries (TableName, ErrorNumber, ErrorCode, Client, SequenceNumber, Language, Coments, Application, Platform, CSSRelease)" _
             & " VALUES (" _
             & Chr(39) & CurTable & Chr(39) & ", " _
             & Me.txtKey & ", " _
             & Chr(39) & Me.txtDecode & Chr(39) & ", " _
             & myClient.Displaycode & ", " _
             & Me.txtSeqNumber & ", " _
             & Chr(39) & Me.txtLanguage & Chr(39) & ", " _
             & Chr(39) & myComment.DisplayComment & Chr(39) & ", " _
             & myApplication.Displaycode & ", " _
             & myPlatform.Displaycode & ", " _
             & myRelease.Displaycode & ") "
    
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
        AddNewUMsgRecord = True
    Else
        wsCTM.Rollback
        AddNewUMsgRecord = False
    End If

Exit Function

InsertError:
    Dim msg As String, RC As Integer
    msg = "An error has occured within AddNewRecord event." & vbCrLf & _
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
Private Sub cmdProcess_Click()
'***************************************************************************************************************

Dim RC As Integer
Dim myClient As New client

    'Are we in 'add' mode?
    If (bAddNewKey) Then
           
        'Check to see if this new key already exists.
        
        myClient.Decode = Me.cbxClients.Text
        
        If (CheckUMsgKeyExists(CurTable, txtKey.Text, myClient.Displaycode, Me.txtSeqNumber.Text) = True) Then
            RC = MessageBox(Me.hwnd, _
                            "This Key already exists on this table!" & vbCrLf & _
                            "Would you like to overwrite the existing Key?", _
                            "Codes Table Explorer", _
                            MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2)
            
            If (RC = IDNO) Then
                Exit Sub
            Else
               'Attempt to modify the record and display a status message.
                If (ModifyUMsgRecord = True) Then
            
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
            If (AddNewUMsgRecord = True) Then
        
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
         
            myClient.Decode = Me.cbxClients.Text
            
            'Check to see if this new key already exists.
            If (CheckUMsgKeyExists(CurTable, txtKey.Text, myClient.Displaycode, Me.txtSeqNumber.Text) = False) Then
                RC = MessageBox(Me.hwnd, _
                            "This Key does not currently exist on this table!" & vbCrLf & _
                            "Would you like to add the current Key?", _
                            "Codes Table Explorer", _
                            MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON1)
            
                If (RC = IDNO) Then
                    Exit Sub
                Else
                    'Attempt to add the record and display a status message.
                    If (AddNewUMsgRecord = True) Then
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
                    If (ModifyUMsgRecord = True) Then
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
            If (ModifyUMsgRecord = True) Then
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
Public Function ModifyUMsgRecord() As Boolean
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
    
    'Put together the base update SQL
    strsql = "UPDATE tblUserErrorMsgEntries SET " _
             & "ErrorNumber = " & Chr(39) & Me.txtKey.Text & Chr(39) & ", " _
             & "ErrorCode = " & Chr(39) & Me.txtDecode.Text & Chr(39) & ", " _
             & "Client = " & myClient.Displaycode & ", " _
             & "Coments = " & Chr(39) & myComment.DisplayComment & Chr(39) & ", " _
             & "Application = " & myApplication.Displaycode & ", " _
             & "Platform = " & myPlatform.Displaycode & ", " _
             & "CSSRelease = " & myRelease.Displaycode & ", " _
             & "Language = " & Chr(39) & Me.txtLanguage & Chr(39) & ", " _
             & "SequenceNumber = " & Me.txtSeqNumber
             
    'Finish the SQL string
    
    strsql = strsql & " WHERE TableName = " & Chr(39) & CurTable & Chr(39) & _
                      " AND ErrorNumber = " & txtKey.Text & _
                      " AND Client = " & myClient.Displaycode & _
                      " AND SequenceNumber = " & Me.txtSeqNumber
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
        ModifyUMsgRecord = True
    Else
        wsCTM.Rollback
        ModifyUMsgRecord = False
    Debug.Print strsql
    End If

Exit Function

UpdateError:
    Dim msg As String, RC As Integer
    msg = "An error has occured within ModifyRecord event." & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    
    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton + vbApplicationModal, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
    Resume Next
End Function

'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    Dim myClient As New client
    Dim x As Integer
    
    bFormLoaded = False
    bChangeKey = False
    
    'Build the list of available clients.
    GetClientCBox Me.cbxClients
    
    'Build Application combo box
    GetApplicationCBox Me.cbxApplication
        
    'Build Platform combo box
    GetPlatformCBox Me.cbxPlatform
    
    'Build Release combo box
    GetReleaseCBox Me.cbxRelease

    If (bAddNewKey) Then
        Me.Caption = CurTable & " - Add New Error Code"
        cmdProcess.Caption = "&Add"
    Else
        Me.Caption = CurTable & " - Modify Existing Error Code"
        cmdProcess.Caption = "&Modify"
        
        myClient.Decode = frmMain.lvListView.SelectedItem.SubItems(2)
        
        strsql = "SELECT DISTINCTROW tblUserErrorMsgEntries.ErrorNumber, tblUserErrorMsgEntries.Language, tblUserErrorMsgEntries.SequenceNumber, tblClients.Client, tblUserErrorMsgEntries.ErrorCode, tblUserErrorMsgEntries.Coments, tblApplications.Application, tblReleases.Release, tblPlatforms.Platform" _
                  & " FROM (((tblUserErrorMsgEntries INNER JOIN tblClients ON tblUserErrorMsgEntries.Client = tblClients.Code) INNER JOIN tblApplications ON tblUserErrorMsgEntries.Application = tblApplications.Code) INNER JOIN tblReleases ON tblUserErrorMsgEntries.CSSRelease = tblReleases.Code) INNER JOIN tblPlatforms ON tblUserErrorMsgEntries.Platform = tblPlatforms.Code" _
                  & " WHERE (((tblUserErrorMsgEntries.ErrorNumber)= " & CurKey & ") AND ((tblUserErrorMsgEntries.SequenceNumber)= " & frmMain.lvListView.SelectedItem.SubItems(6) & ") AND ((tblUserErrorMsgEntries.Client)= " & myClient.Displaycode & ") AND ((tblUserErrorMsgEntries.TableName)= " & Chr(39) & CurTable & Chr(39) & "));"
                    
        Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
        If Not DaoRS.EOF Then
            
            'Get the current decode.
            If Len(DaoRS(0).Value) > 0 Then
                txtKey.Text = RTrim(DaoRS(0).Value)
            Else
                txtKey.Text = ""
            End If
            
            If Len(DaoRS(1).Value) > 0 Then
                txtLanguage.Text = RTrim(DaoRS(1).Value)
            Else
                txtLanguage.Text = ""
            End If
            
            If Len(DaoRS(2).Value) > 0 Then
                txtSeqNumber.Text = RTrim(DaoRS(2).Value)
            Else
                txtSeqNumber.Text = ""
            End If

            'Set up the client combo box.
            For x = 0 To UBound(ClientArray)
                If (DaoRS(3).Value = ClientArray(x).client) Then
                    cbxClients.ListIndex = x
                    Exit For
                End If
            Next
            
            If Len(DaoRS(4).Value) > 0 Then
                txtDecode.Text = RTrim(DaoRS(4).Value)
            Else
                txtDecode.Text = ""
            End If

            If Len(DaoRS(5).Value) > 0 Then
                txtComments.Text = RTrim(DaoRS(5).Value)
            Else
                txtComments.Text = ""
            End If
            
            'Set up the Application combo box.
            For x = 0 To UBound(ApplicationArray)
                If (DaoRS(6).Value = ApplicationArray(x).Application) Then
                    cbxApplication.ListIndex = x
                    Exit For
                End If
            Next
            
            'Set up the Release combo box.
            For x = 0 To UBound(ReleaseArray)
                If (DaoRS(7).Value = ReleaseArray(x).Release) Then
                    cbxRelease.ListIndex = x
                    Exit For
                End If
            Next

            'Set up the Platform combo box.
            For x = 0 To UBound(PlatformArray)
                If (DaoRS(8).Value = PlatformArray(x).Platform) Then
                    cbxClients.ListIndex = x
                    Exit For
                End If
            Next

        
        End If
    End If
    
    bModified = False
    bFormLoaded = True
    
End Sub



'***************************************************************************************************************
Public Sub WindowRefresh()
'***************************************************************************************************************
    Dim DecodeMaxLen As Integer, KeyMaxLen As Integer, SeqMaxLen As Integer
    Dim RC As Integer
    
        'Take care of the Key field.
    KeyMaxLen% = frmMain.txtKeyLength.Text
    
    If (Len(txtKey.Text) = 0) Then
        txtKey.BackColor = &HFFFF&
        bKeyOK = False
    
    ElseIf ((Len(txtKey.Text) > 0) And (Len(txtKey.Text) <= KeyMaxLen)) Then
        txtKey.BackColor = &H80000005
        bKeyOK = True
        
        'Force the characters to be upper case.
        txtKey.Text = UCase(txtKey.Text)
    
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
    End If

    DecodeMaxLen% = frmMain.txtDecodeLength.Text
    
2    If ((Len(txtDecode.Text) > 0) And (Len(txtDecode.Text) <= DecodeMaxLen)) Then
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
    
    If (Len(txtSeqNumber.Text) > 0) Then
        txtSeqNumber.BackColor = &H80000005
        bSeqOK = True
    ElseIf (Len(txtSeqNumber.Text) = 0) Then
        txtSeqNumber.BackColor = &HFFFF&
        bSeqOK = False
    End If
 
    If bKeyOK And bDecodeOK And bSeqOK Then
        cmdProcess.Enabled = True
    Else
        cmdProcess.Enabled = False
    End If

    
End Sub


'***************************************************************************************************************
Private Sub txtKey_Change()
'***************************************************************************************************************
    'Set the modified flag to true
    bModified = True
    
    If (bFormLoaded = True) Then
        bChangeKey = True
    End If
    
    'Refresh the window controls.
    WindowRefresh
End Sub
'***************************************************************************************************************
Private Sub txtSeqNumber_Change()
'***************************************************************************************************************
    'Set the modified flag to true
    bModified = True
    
    If (bFormLoaded = True) Then
        bChangeKey = True
    End If
    
    'Refresh the window controls.
    WindowRefresh

End Sub
