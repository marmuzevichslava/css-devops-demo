VERSION 5.00
Begin VB.Form frmAddModUMsg 
   ClientHeight    =   3390
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7335
   Icon            =   "frmaddmodumsg.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3390
   ScaleWidth      =   7335
   StartUpPosition =   2  'CenterScreen
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
      Height          =   330
      Left            =   2573
      TabIndex        =   6
      ToolTipText     =   "Add/Modify error message"
      Top             =   2940
      Width           =   1215
   End
   Begin VB.ComboBox cbxClients 
      Height          =   315
      Left            =   1425
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   615
      Width           =   2295
   End
   Begin VB.TextBox txtSeqNumber 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   5085
      TabIndex        =   2
      Top             =   615
      Width           =   450
   End
   Begin VB.TextBox txtComments 
      BackColor       =   &H00FFFFFF&
      Height          =   1050
      Left            =   1425
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   5
      Top             =   1800
      Width           =   2325
   End
   Begin VB.TextBox txtLanguage 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   6780
      TabIndex        =   3
      Top             =   615
      Width           =   330
   End
   Begin VB.TextBox txtDecode 
      BackColor       =   &H00FFFFFF&
      Height          =   675
      Left            =   1425
      TabIndex        =   4
      Top             =   984
      Width           =   5730
   End
   Begin VB.TextBox txtKey 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   1425
      TabIndex        =   0
      ToolTipText     =   "Key Code to Add/Modify"
      Top             =   240
      Width           =   1650
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
      Left            =   4013
      TabIndex        =   7
      ToolTipText     =   "Return to main"
      Top             =   2940
      Width           =   1215
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
      Left            =   405
      TabIndex        =   13
      Top             =   645
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
      Height          =   210
      Left            =   3705
      TabIndex        =   12
      Top             =   660
      Width           =   1305
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
      Left            =   370
      TabIndex        =   11
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
      Left            =   5805
      TabIndex        =   10
      Top             =   645
      Width           =   900
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "Error Message:"
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
      Left            =   -315
      TabIndex        =   9
      Top             =   1020
      Width           =   1695
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
      Left            =   165
      TabIndex        =   8
      Top             =   270
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
Const DEFVALUE = 0

Private Sub cbxClients_Click()

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
Public Function AddNewUMsgRecord() As Boolean
'***************************************************************************************************************
    Dim myClient As New Client
    Dim myApplication As New Application
    Dim myPlatform As New Platform
    Dim myRelease As New Release
    Dim myComment As New Comment
    
    myClient.Decode = Me.cbxClients.Text
   ' myApplication.Decode = Me.cbxApplication.Text
   ' myPlatform.Decode = Me.cbxPlatform.Text
   ' myRelease.Decode = Me.cbxRelease.Text
    
    'Figure out what the comment should be
    myComment.Text = Me.txtComments.Text
    
    strsql = "INSERT INTO tblUserErrorMsgEntries (TableName, ErrorNumber, ErrorCode, Client, SequenceNumber, Language, Coments, Application, Platform, CSSRelease)" _
             & " VALUES (" _
             & Chr(34) & CurTable & Chr(34) & ", " _
             & Me.txtKey & ", " _
             & Chr(34) & Me.txtDecode & Chr(34) & ", " _
             & myClient.Displaycode & ", " _
             & Me.txtSeqNumber & ", " _
             & Chr(34) & Me.txtLanguage & Chr(34) & ", " _
             & Chr(34) & myComment.DisplayComment & Chr(34) & ", " _
             & DEFVALUE & ", " _
             & DEFVALUE & ", " _
             & DEFVALUE & ");"
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
Dim myClient As New Client

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
    Screen.MousePointer = vbHourglass
    
    RefreshCodeDecodeLB
    
    Screen.MousePointer = vbDefault
    
    bModified = False

End Sub

'***************************************************************************************************************
Public Function ModifyUMsgRecord() As Boolean
'***************************************************************************************************************
    Dim myClient As New Client
   ' Dim myApplication As New Application
   ' Dim myPlatform As New Platform
   ' Dim myRelease As New Release
    Dim myComment As New Comment
    
    myClient.Decode = Me.cbxClients.Text
   ' myApplication.Decode = Me.cbxApplication.Text
   ' myPlatform.Decode = Me.cbxPlatform.Text
   ' myRelease.Decode = Me.cbxRelease.Text
    
    'Figure out what the comment should be
    myComment.Text = Me.txtComments.Text
    
    'Put together the base update SQL
    strsql = "UPDATE tblUserErrorMsgEntries SET " _
             & "ErrorNumber = " & Chr(34) & Me.txtKey.Text & Chr(34) & ", " _
             & "ErrorCode = " & Chr(34) & Me.txtDecode.Text & Chr(34) & ", " _
             & "Client = " & myClient.Displaycode & ", " _
             & "Coments = " & Chr(34) & myComment.DisplayComment & Chr(34) & ", " _
             & "Language = " & Chr(34) & Me.txtLanguage & Chr(34) & ", " _
             & "SequenceNumber = " & Me.txtSeqNumber
             
    'Finish the SQL string
    
    strsql = strsql & " WHERE TableName = " & Chr(34) & CurTable & Chr(34) & _
                      " AND ErrorNumber = " & txtKey.Text & _
                      " AND Client = " & myClient.Displaycode & _
                      " AND SequenceNumber = " & Me.txtSeqNumber
    
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
    Dim myClient As New Client
    Dim x As Integer

    Const SEQNUM_DEFAULT = "1"
    Const LANGUAGE_DEFAULT = "E"
    
    bFormLoaded = False
    bChangeKey = False
    
    'Build the list of available clients.
    GetClientCBox Me.cbxClients
    
    'Build Application combo box
    'GetApplicationCBox Me.cbxApplication
        
    'Build Platform combo box
    'GetPlatformCBox Me.cbxPlatform
    
    'Build Release combo box
    'GetReleaseCBox Me.cbxRelease

    If (bAddNewKey) Then
        Me.Caption = CurTable & " - Add New Error Code"
        cmdProcess.Caption = "&Add"
        txtSeqNumber.Text = SEQNUM_DEFAULT 'Default this field to 0
        txtLanguage.Text = LANGUAGE_DEFAULT 'Default this field to E (English)
    Else
        Me.Caption = CurTable & " - Modify Existing Error Code"
        cmdProcess.Caption = "&Modify"
        
        myClient.Decode = frmMain.lvListView.SelectedItem.SubItems(2)
        
         strsql = "SELECT DISTINCTROW tblUserErrorMsgEntries.ErrorNumber, tblUserErrorMsgEntries.Language, tblUserErrorMsgEntries.SequenceNumber, tblClients.Client, tblUserErrorMsgEntries.ErrorCode, tblUserErrorMsgEntries.Coments " _
                  & " FROM (tblUserErrorMsgEntries INNER JOIN tblClients ON tblUserErrorMsgEntries.Client = tblClients.Code) " _
                  & " WHERE (((tblUserErrorMsgEntries.ErrorNumber)= " & CurKey & ") AND ((tblUserErrorMsgEntries.SequenceNumber)= " & frmMain.lvListView.SelectedItem.SubItems(3) & ") AND ((tblUserErrorMsgEntries.Client)= " & myClient.Displaycode & ") AND ((tblUserErrorMsgEntries.TableName)= " & Chr(34) & CurTable & Chr(34) & "));"
        
        
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
                If (DaoRS(3).Value = ClientArray(x).Client) Then
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
            'For x = 0 To UBound(ApplicationArray)
            '    If (DaoRS(6).Value = ApplicationArray(x).Application) Then
            '        cbxApplication.ListIndex = x
            '        Exit For
            '    End If
            'Next
            
            'Set up the Release combo box.
            'For x = 0 To UBound(ReleaseArray)
            '    If (DaoRS(7).Value = ReleaseArray(x).Release) Then
            '        cbxRelease.ListIndex = x
            '        Exit For
            '    End If
            'Next

            'Set up the Platform combo box.
            'For x = 0 To UBound(PlatformArray)
            '    If (DaoRS(8).Value = PlatformArray(x).Platform) Then
            '        cbxPlatform.ListIndex = x
            '        Exit For
            '    End If
            'Next
        
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
        
        'Insure that the message code is numeric, if not send error message
        If Not IsNumeric(txtKey.Text) Then
            
            txtKey.BackColor = &HFF&
            bKeyOK = False
            RC = MessageBox(Me.hwnd, _
                            "Error Number must be numeric!", _
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
    End If

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
    
    If (Len(txtSeqNumber.Text) > 0) Then
        txtSeqNumber.BackColor = &H80000005
        bSeqOK = True
                
        If Not IsNumeric(txtSeqNumber.Text) Then
            
            txtSeqNumber.BackColor = &HFF&
            bSeqOK = False
            RC = MessageBox(Me.hwnd, _
                            "Sequence Numbers must be numeric!", _
                            "Codes Table Explorer", _
                            MB_OK)
        End If

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


Private Sub txtDecode_Change()
    bModified = True
    
    'Refresh the window controls
    WindowRefresh
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


