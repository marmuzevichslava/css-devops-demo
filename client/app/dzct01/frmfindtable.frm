VERSION 5.00
Begin VB.Form frmFindTable 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Find Codes Table"
   ClientHeight    =   1230
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3405
   Icon            =   "frmFindTable.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1230
   ScaleWidth      =   3405
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
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
      Left            =   1785
      TabIndex        =   2
      ToolTipText     =   "Return to main"
      Top             =   735
      Width           =   1215
   End
   Begin VB.CommandButton cmdFind 
      Caption         =   "&Find"
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
      Left            =   435
      TabIndex        =   1
      ToolTipText     =   "Find codes table"
      Top             =   735
      Width           =   1215
   End
   Begin VB.TextBox txtFindTable 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1875
      TabIndex        =   0
      Top             =   225
      Width           =   1365
   End
   Begin VB.Label Label1 
      Caption         =   "Enter Table Name:"
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
      TabIndex        =   3
      Top             =   255
      Width           =   1665
   End
End
Attribute VB_Name = "frmFindTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'***************************************************************************************************************
Private Sub cmdCancel_Click()
'***************************************************************************************************************
    Unload Me
End Sub

Private Sub cmdCancel_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyEscape Then Unload Me

End Sub

'***************************************************************************************************************
Private Sub cmdFind_Click()
'***************************************************************************************************************
    Dim x As Integer, RetVal As Variant, bFound As Boolean
    
    bFound = False
    For x = 1 To frmMain.tvTreeView.Nodes.Count
        If (UCase(txtFindTable.Text) = frmMain.tvTreeView.Nodes(x).Text) Then
            frmMain.tvTreeView.SetFocus
            frmMain.tvTreeView.Nodes(x).Selected = True
            Call MainTreeViewNodeClick(frmMain.tvTreeView.SelectedItem)
            bFound = True
        End If
    Next

    If Not (bFound) Then
        RC = MessageBox(Me.hwnd, _
                        "Unable to find codes table " & UCase(txtFindTable.Text) & ".", _
                        "Codes Table Explorer", _
                        MB_OK Or MB_ICONEXCLAMATION)
        Call Form_Load
    Else
        Unload Me
    End If
    
End Sub

'***************************************************************************************************************
Private Sub cmdFind_KeyDown(KeyCode As Integer, Shift As Integer)
'***************************************************************************************************************
    If KeyCode = vbKeyEscape Then Unload Me

End Sub

'***************************************************************************************************************
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
'***************************************************************************************************************
    If KeyCode = vbKeyEscape Then Unload Me
    
End Sub

'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    txtFindTable.Text = "CIS"
    txtFindTable.SelStart = Len(txtFindTable.Text) + 1

End Sub

'***************************************************************************************************************
Private Sub txtFindTable_Change()
'***************************************************************************************************************
    If (Len(txtFindTable.Text) > 0) Then
        txtFindTable.BackColor = &H80000005
        cmdFind.Enabled = True
        cmdFind.Default = True
    Else
        txtFindTable.BackColor = &HFFFF&
        cmdFind.Enabled = False
        cmdCancel.Default = True
    End If

End Sub

'***************************************************************************************************************
Private Sub txtFindTable_KeyDown(KeyCode As Integer, Shift As Integer)
'***************************************************************************************************************
    If KeyCode = vbKeyEscape Then Unload Me
End Sub

