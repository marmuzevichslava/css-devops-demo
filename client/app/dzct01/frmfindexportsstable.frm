VERSION 5.00
Begin VB.Form frmFindExportSS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Find Codes Table"
   ClientHeight    =   1095
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3255
   Icon            =   "frmfindexportsstable.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1095
   ScaleWidth      =   3255
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
      Left            =   1755
      TabIndex        =   2
      ToolTipText     =   "Return to export"
      Top             =   615
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
      Left            =   405
      TabIndex        =   1
      ToolTipText     =   "Return to main"
      Top             =   630
      Width           =   1215
   End
   Begin VB.TextBox efTableName 
      Height          =   315
      Left            =   1845
      TabIndex        =   0
      Top             =   120
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
      Left            =   120
      TabIndex        =   3
      Top             =   150
      Width           =   1665
   End
End
Attribute VB_Name = "frmFindExportSS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdFind_Click()
On Error GoTo Err_Find
    Dim SearchTable As String, SetValue As String, SQLquery As String, MsgLine As String
    Dim x As Integer
    Const Title = "Search Table"

    Screen.MousePointer = vbHourglass
    
    SearchTable = efTableName
    SetValue = UCase$(SearchTable)
    SearchTable = UCase$(SearchTable) & "*"
    SQLquery = "SELECT TableName FROM tblTables WHERE TableName LIKE '" & SearchTable & "';"

On Error GoTo Err_SQL
    
    Set DaoRS = dbCTM.OpenRecordset(SQLquery, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If DaoRS.EOF Then GoTo Err_SQL
    
    For x = 0 To frmExportSS.SelectTable.ListCount - 1
            frmExportSS.SelectTable.Selected(x) = False
    Next
    
    For x = 0 To frmExportSS.SelectTable.ListCount - 1
        If (frmExportSS.SelectTable.List(x) = DaoRS(0).Value) Then
            frmExportSS.SelectTable.Selected(x) = True
        Else
            frmExportSS.SelectTable.Selected(x) = False
        End If
    Next
    
    frmExportSS.SelectTable.Refresh
    
Exit_Find_Table:
    Screen.MousePointer = vbNormal
    Unload Me
    'DoCmd.Close
    Exit Sub

Err_SQL:
    MsgLine = "Can not find table name: '" & SetValue & "'"
    MsgBox MsgLine, 64, Title
    Screen.MousePointer = vbNormal
    Exit Sub

Err_Find:
    'MsgBox Error$
    MsgLine = "Can not find table name: '" & SetValue & "'"
    MsgBox MsgLine, 64, Title
    Screen.MousePointer = vbNormal
    Unload Me

    Exit Sub
    
End Sub

Private Sub Form_Load()
    efTableName.Text = "CIS"
    efTableName.SelStart = Len(efTableName.Text) + 1
End Sub
