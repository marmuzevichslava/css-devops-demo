VERSION 5.00
Begin VB.Form frmModifyVarNames 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Modify Variable"
   ClientHeight    =   1845
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4020
   Icon            =   "frmModifyVarNames.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1845
   ScaleWidth      =   4020
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
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
      Height          =   375
      Left            =   2153
      TabIndex        =   3
      Top             =   1275
      Width           =   1215
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "&OK"
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
      Left            =   653
      TabIndex        =   2
      ToolTipText     =   "Add the current user id"
      Top             =   1275
      Width           =   1215
   End
   Begin VB.TextBox txtCobolName 
      Height          =   315
      Left            =   1500
      TabIndex        =   1
      ToolTipText     =   "Variable name for Cobol generation"
      Top             =   675
      Width           =   2340
   End
   Begin VB.TextBox txtCName 
      Height          =   315
      Left            =   1500
      TabIndex        =   0
      ToolTipText     =   "Variable name for C generation"
      Top             =   225
      Width           =   2340
   End
   Begin VB.Label Label2 
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
      TabIndex        =   5
      Top             =   712
      Width           =   1215
   End
   Begin VB.Label Label1 
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
      TabIndex        =   4
      Top             =   262
      Width           =   1215
   End
End
Attribute VB_Name = "frmModifyVarNames"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public bModify As Boolean

'***************************************************************************************************************
Private Sub cmdCancel_Click()
'***************************************************************************************************************
    Dim RC As Integer
    
    If (bModify) Then
        RC = MessageBox(Me.hwnd, _
                        "Would you like to save your changes?", _
                        "Codes Table Explorer", _
                        MB_YESNO Or MB_ICONQUESTION)
                        
        If (RC = IDYES) Then Call SubmitVarNames
    End If
    
    Unload Me
    
End Sub

'***************************************************************************************************************
Private Sub cmdCancel_KeyDown(KeyCode As Integer, Shift As Integer)
'***************************************************************************************************************
    If KeyCode = vbKeyEscape Then Unload Me

End Sub

'***************************************************************************************************************
Private Sub cmdOK_Click()
'***************************************************************************************************************
    Call SubmitVarNames
    Unload Me
End Sub

'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    
    'Populate the variable names with values from the previous screen.
    txtCName.Text = frmSourceFileGenerator.lvSrcGenerate.SelectedItem.SubItems(1)
    txtCobolName.Text = frmSourceFileGenerator.lvSrcGenerate.SelectedItem.SubItems(2)
    
    'Set up the caption.
    Me.Caption = "Modify Variable Names - " & frmSourceFileGenerator.lvSrcGenerate.SelectedItem.Text
    
    'Initialize the modify flag.
    bModify = False
    
    
End Sub

'***************************************************************************************************************
Private Sub txtCName_Change()
'***************************************************************************************************************
    bModify = True
    cmdOK.Enabled = True
    
End Sub

'***************************************************************************************************************
Private Sub txtCName_KeyDown(KeyCode As Integer, Shift As Integer)
'***************************************************************************************************************
    If KeyCode = vbKeyEscape Then Unload Me

End Sub

'***************************************************************************************************************
Private Sub txtCobolName_Change()
'***************************************************************************************************************
    bModify = True
    cmdOK.Enabled = True

End Sub

'***************************************************************************************************************
Private Sub txtCobolName_KeyDown(KeyCode As Integer, Shift As Integer)
'***************************************************************************************************************
    If KeyCode = vbKeyEscape Then Unload Me

End Sub


'***************************************************************************************************************
Public Function SubmitVarNames() As Boolean
'***************************************************************************************************************
    If (txtCName.Text = "") Then txtCName.Text = " "
    If (txtCobolName.Text = "") Then txtCobolName.Text = " "
    
    strsql = "UPDATE tblEntries SET CName = '" & txtCName.Text & "', CobolName = '" & _
             txtCobolName.Text & "' WHERE TableName = '" & frmMain.tvTreeView.SelectedItem.Text & _
             "' AND Key = '" & frmSourceFileGenerator.lvSrcGenerate.SelectedItem.Text & "'"
    
    wsCTM.BeginTrans
    dbCTM.Execute strsql
    
    If (dbCTM.RecordsAffected > 0) Then
        wsCTM.CommitTrans
        SubmitVarNames = True
        frmSourceFileGenerator.lvSrcGenerate.SelectedItem.SubItems(1) = txtCName.Text
        frmSourceFileGenerator.lvSrcGenerate.SelectedItem.SubItems(2) = txtCobolName.Text
    Else
        wsCTM.Rollback
        SubmitVarNames = False
    End If
    
End Function
