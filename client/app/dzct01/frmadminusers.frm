VERSION 5.00
Begin VB.Form frmAdminUsers 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Add/Delete Administrators"
   ClientHeight    =   1590
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4665
   Icon            =   "frmAdminUsers.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1590
   ScaleWidth      =   4665
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
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
      Height          =   330
      Left            =   3112
      TabIndex        =   3
      ToolTipText     =   "Return to main"
      Top             =   1170
      Width           =   1215
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "&Delete"
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
      Height          =   315
      Left            =   1762
      TabIndex        =   2
      ToolTipText     =   "Delete the current user id"
      Top             =   1170
      Width           =   1215
   End
   Begin VB.CommandButton cmdAdd 
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
      Left            =   337
      TabIndex        =   1
      ToolTipText     =   "Add the current user id"
      Top             =   1170
      Width           =   1215
   End
   Begin VB.ComboBox cbxAdminList 
      Height          =   315
      Left            =   990
      TabIndex        =   0
      ToolTipText     =   "User ID of Administrator"
      Top             =   735
      Width           =   2565
   End
   Begin VB.Label Label2 
      Caption         =   "or select a current id from the list below."
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
      Left            =   75
      TabIndex        =   5
      Top             =   375
      Width           =   4365
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label1 
      Caption         =   "Enter the Windows User ID of the new Administrator "
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
      Left            =   75
      TabIndex        =   4
      Top             =   150
      Width           =   4440
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "frmAdminUsers"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'***************************************************************************************************************
Private Sub cmdAdd_Click()
'***************************************************************************************************************
    Dim RC As Integer, x As Integer
    
    'Check to see if the current user is trying to add themself again.
    If (cbxAdminList.Text = CurrentUser) Then
        RC = MessageBox(Me.hwnd, _
                        "You already have administrative authority.", _
                        "Codes Table Explorer", _
                        MB_OK Or MB_ICONINFORMATION)
        Exit Sub
    'Check to see if this already has authority.
    Else
        For x = 0 To cbxAdminList.ListCount
            If (cbxAdminList.Text = cbxAdminList.List(x)) Then
                RC = MessageBox(Me.hwnd, _
                                "This ID already has administrative authority.", _
                                "Codes Table Explorer", _
                                MB_OK Or MB_ICONINFORMATION)
                Exit Sub
            End If
        Next
    End If


    'If we made it here, then this is a new ID.
    strsql = "INSERT INTO tblAdmin (AdminName) VALUES (" & Chr(39) & cbxAdminList.Text & Chr(39) & ");"


    'Begin a new transaction.
     wsCTM.BeginTrans

    'Execute the insert.
    dbCTM.Execute strsql
            
    'Check the results of the insert.
    If (dbCTM.RecordsAffected = 1) Then
        RC = MessageBox(Me.hwnd, _
                        "Administrative rights for " & cbxAdminList.Text & " successfully added.", _
                        "Codes Table Explorer", _
                        MB_OK Or MB_ICONINFORMATION)
        wsCTM.CommitTrans
    Else
        RC = MessageBox(Me.hwnd, _
                        "Unable to grant Administrative rights for " & cbxAdminList.Text & "." & _
                        vbCrLf & "Contact Development Tools for assistance.", _
                        "Codes Table Explorer", _
                        MB_OK Or MB_ICONHAND)
        wsCTM.Rollback
    End If
            
    'Refresh the combo box of administrators.
    GetAdminList

End Sub

'***************************************************************************************************************
Private Sub cmdCancel_Click()
'***************************************************************************************************************
    Unload Me

End Sub


'***************************************************************************************************************
Private Sub cmdDelete_Click()
'***************************************************************************************************************
    Dim RC As Integer, x As Integer
    
    'Check to see if this is the current user.
    If (cbxAdminList.Text = CurrentUser) Then
        RC = MessageBox(Me.hwnd, _
                        "You are about to delete your own administrative " & vbCrLf & _
                        "authority.  Are you sure your wish to delete this id?", _
                        "Codes Table Explorer", _
                        MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2)

        'Exit this procedure if they select no.
        If (RC = IDNO) Then
            Exit Sub
        End If
        
    'Check to see if this entity is in the list.
    Else
        For x = 0 To cbxAdminList.ListCount - 1
            If (cbxAdminList.Text = cbxAdminList.List(x)) Then
                Exit For
            End If
        Next
        
        
        'If not found display an error message and exit.
        If (x = cbxAdminList.ListCount) Then
            RC = MessageBox(Me.hwnd, _
                            "The current ID does not currently exist.", _
                            "Codes Table Explorer", _
                            MB_OK Or MB_ICONHAND)
            cbxAdminList.ListIndex = 0
            Exit Sub
        End If
    End If
        

    'If we made it here, then this id exists.
    strsql = "DELETE * FROM tblAdmin WHERE AdminName = " & Chr(39) & cbxAdminList.Text & Chr(39)

    'Begin a new transaction.
    wsCTM.BeginTrans

    'Execute the insert.
    dbCTM.Execute strsql
    
    'Check the results.
    If (dbCTM.RecordsAffected = 1) Then
        RC = MessageBox(Me.hwnd, _
                        cbxAdminList.Text & " successfully deleted.", _
                        "Codes Table Explorer", _
                        MB_OK Or MB_ICONINFORMATION)
        wsCTM.CommitTrans
    Else
        RC = MessageBox(Me.hwnd, _
                        "Unable to delete Administrative rights for " & cbxAdminList.Text & "." & _
                        vbCrLf & "Contact Development Tools for assistance.", _
                        "Codes Table Explorer", _
                        MB_OK Or MB_ICONSTOP)
        wsCTM.Rollback
    End If

    
    'Refresh the combo box of administrators.
    GetAdminList


End Sub

'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    
    'Get the list of current administrators.
    GetAdminList

End Sub


'***************************************************************************************************************
Public Sub GetAdminList()
'***************************************************************************************************************
    
    cmdDelete.Enabled = False
    cmdAdd.Enabled = False
    cbxAdminList.Enabled = False
    cbxAdminList.Clear
    Screen.MousePointer = vbHourglass
    
    strsql = "select AdminName from tblAdmin"
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        
        While Not DaoRS.EOF
        
            cbxAdminList.AddItem DaoRS(0).Value
            DaoRS.MoveNext
        Wend
    
        DaoRS.Close
        cbxAdminList.ListIndex = 0
    End If

    Screen.MousePointer = vbNormal

    'Enable the add button and the combo box.
    cmdAdd.Enabled = True
    cbxAdminList.Enabled = True


    'Enable the objects if there are administrators.
    If (cbxAdminList.ListCount > 0) Then
        cmdDelete.Enabled = True
    End If

End Sub
