VERSION 5.00
Begin VB.Form frmFindRelTable 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Find Codes Table"
   ClientHeight    =   1095
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3255
   Icon            =   "frmfindreltable.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
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
Attribute VB_Name = "frmFindRelTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdFind_Click()

    Dim SearchTable As String, SetValue As String, SQLquery As String, MsgLine As String, SQLquery2 As String
    Dim X As Integer
    Dim DaoRS2 As Recordset
    Const Title = "Search Table"
    Dim LeftTableSelected As Boolean
    Dim RightTableSelected As Boolean

    Screen.MousePointer = vbHourglass
    
    SearchTable = efTableName
    SetValue = UCase$(SearchTable)
    SearchTable = UCase$(SearchTable)
   
    For X = 0 To frmAddStaticTable.SelectTable.ListCount - 1
        frmAddStaticTable.SelectTable.Selected(X) = False
    Next
        
    For X = 0 To frmAddStaticTable.StaticTables.ListCount - 1
        frmAddStaticTable.StaticTables.Selected(X) = False
    Next
        
    For X = 0 To frmAddStaticTable.SelectTable.ListCount - 1
        If (frmAddStaticTable.SelectTable.List(X) = SearchTable) Then
            frmAddStaticTable.SelectTable.Selected(X) = True
            frmAddStaticTable.sbStatusBar.Panels(1).Text = "Found " & SearchTable & "..."
            frmAddStaticTable.sbStatusBar.Refresh
            LeftTableSelected = True
        Else
            frmAddStaticTable.SelectTable.Selected(X) = False
        End If
    Next
     
    For X = 0 To frmAddStaticTable.StaticTables.ListCount - 1
        If (frmAddStaticTable.StaticTables.List(X) = SearchTable) Then
            frmAddStaticTable.StaticTables.Selected(X) = True
            frmAddStaticTable.sbStatusBar.Panels(1).Text = "Found " & SearchTable & "..."
            frmAddStaticTable.sbStatusBar.Refresh
            RightTableSelected = True
        Else
            frmAddStaticTable.StaticTables.Selected(X) = False
        End If
    Next
             
    frmAddStaticTable.SelectTable.Refresh
    frmAddStaticTable.StaticTables.Refresh
    
    If Not LeftTableSelected And Not RightTableSelected Then
        MsgLine = "Can not find table name: '" & SetValue & "'"
        MsgBox MsgLine, 64, Title
        Screen.MousePointer = vbNormal
        Unload Me
        Exit Sub
    End If
        
Exit_Find_Table:
    Screen.MousePointer = vbNormal
    Unload Me
    'DoCmd.Close
    Exit Sub
    
End Sub

Private Sub Form_Load()
    efTableName.Text = "CU"
    efTableName.SelStart = Len(efTableName.Text) + 1
End Sub
