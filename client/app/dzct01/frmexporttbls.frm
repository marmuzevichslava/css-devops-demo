VERSION 5.00
Begin VB.Form frmExportTable 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Export Tables"
   ClientHeight    =   5115
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5130
   Icon            =   "frmExportTbls.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5115
   ScaleWidth      =   5130
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame3 
      Caption         =   "File &Options"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   915
      Left            =   2625
      TabIndex        =   19
      Top             =   3525
      Width           =   2340
      Begin VB.OptionButton optCreateFile 
         Caption         =   "Create New File"
         Height          =   240
         Left            =   150
         TabIndex        =   20
         ToolTipText     =   "Create a new export file"
         Top             =   300
         Width           =   1590
      End
      Begin VB.OptionButton optAppendFile 
         Caption         =   "Append to existing file"
         Height          =   240
         Left            =   150
         TabIndex        =   21
         ToolTipText     =   "Append to an existing export file"
         Top             =   600
         Width           =   1965
      End
   End
   Begin VB.CommandButton pbCancel 
      Caption         =   "&Cancel"
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
      Height          =   390
      Left            =   3825
      TabIndex        =   23
      Top             =   4575
      Width           =   1140
   End
   Begin VB.CommandButton pbOK 
      Caption         =   "&Export"
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
      Height          =   390
      Left            =   2625
      TabIndex        =   22
      ToolTipText     =   "Perform"
      Top             =   4560
      Width           =   1140
   End
   Begin VB.Frame Frame2 
      Caption         =   "Export T&ype"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1290
      Left            =   150
      TabIndex        =   15
      Top             =   3525
      Width           =   2340
      Begin VB.OptionButton optExportCISOnly 
         Caption         =   """CIS"" Codes Tables"
         Height          =   240
         Left            =   150
         TabIndex        =   18
         ToolTipText     =   "Export only the ""CIS"" codes tables"
         Top             =   900
         Width           =   1965
      End
      Begin VB.OptionButton optExportCustom 
         Caption         =   "Custom Export"
         Height          =   240
         Left            =   150
         TabIndex        =   17
         ToolTipText     =   "Perform a custom export"
         Top             =   600
         Width           =   1965
      End
      Begin VB.OptionButton optExportAll 
         Caption         =   "All Tables"
         Height          =   240
         Left            =   150
         TabIndex        =   16
         ToolTipText     =   "Export all the tables"
         Top             =   300
         Width           =   1515
      End
   End
   Begin VB.TextBox efExportFile 
      Height          =   285
      Left            =   1875
      TabIndex        =   14
      ToolTipText     =   "Name of file to export to"
      Top             =   3000
      Width           =   3090
   End
   Begin VB.TextBox efPath 
      Height          =   285
      Left            =   1875
      TabIndex        =   12
      ToolTipText     =   "Output directory for export"
      Top             =   2625
      Width           =   3090
   End
   Begin VB.Frame Frame1 
      Caption         =   "Export Table &For"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2070
      Left            =   1890
      TabIndex        =   2
      Top             =   225
      Width           =   3090
      Begin VB.ComboBox cbPlatform 
         Height          =   315
         Left            =   1125
         TabIndex        =   10
         Top             =   1650
         Width           =   1815
      End
      Begin VB.ComboBox cbApplication 
         Height          =   315
         Left            =   1125
         TabIndex        =   8
         Top             =   1200
         Width           =   1815
      End
      Begin VB.ComboBox cbRelease 
         Height          =   315
         Left            =   1125
         TabIndex        =   6
         Top             =   750
         Width           =   1815
      End
      Begin VB.ComboBox cbClient 
         Enabled         =   0   'False
         Height          =   315
         Left            =   1125
         TabIndex        =   4
         Top             =   300
         Width           =   1815
      End
      Begin VB.Label Label5 
         Caption         =   "Platform:"
         Height          =   240
         Left            =   150
         TabIndex        =   9
         Top             =   1680
         Width           =   915
      End
      Begin VB.Label Label4 
         Caption         =   "Application:"
         Height          =   240
         Left            =   150
         TabIndex        =   7
         Top             =   1230
         Width           =   1065
      End
      Begin VB.Label Label3 
         Caption         =   "Release:"
         Height          =   240
         Left            =   150
         TabIndex        =   5
         Top             =   780
         Width           =   915
      End
      Begin VB.Label Label2 
         Caption         =   "Client:"
         Height          =   240
         Left            =   150
         TabIndex        =   3
         Top             =   330
         Width           =   915
      End
   End
   Begin VB.ListBox SelectTable 
      Height          =   1815
      ItemData        =   "frmExportTbls.frx":030A
      Left            =   150
      List            =   "frmExportTbls.frx":030C
      MultiSelect     =   2  'Extended
      Sorted          =   -1  'True
      TabIndex        =   1
      ToolTipText     =   "Selected table(s) for exporting"
      Top             =   450
      Width           =   1590
   End
   Begin VB.Label Label7 
      Caption         =   "&Export File:"
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
      Left            =   750
      TabIndex        =   13
      Top             =   3075
      Width           =   990
   End
   Begin VB.Label Label6 
      Caption         =   "&Path:"
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
      Left            =   1275
      TabIndex        =   11
      Top             =   2670
      Width           =   465
   End
   Begin VB.Label Label1 
      Caption         =   "Table &List:"
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
      TabIndex        =   0
      Top             =   195
      Width           =   915
   End
End
Attribute VB_Name = "frmExportTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public OldPath As String

'***************************************************************************************************************
Private Sub efPath_Change()
'***************************************************************************************************************
    
    'Set the background color accordinly.
    If (Len(efPath.Text) <= 1) Then
        efPath.BackColor = &HFFFF&
    
    Else
        efPath.BackColor = &H80000005
    End If

    'Check the export buttons state.
    Call SetExportButtonState

End Sub

'***************************************************************************************************************
Private Sub efPath_LostFocus()
'***************************************************************************************************************
    OldPath = UCase(efPath.Text)
End Sub

'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************

    Me.Show
    Screen.MousePointer = vbHourglass
    Me.Refresh
    
    'Get the list of valid codes tables and add them to the combo box.
    strSQL = "select TableName From tblTables"
    Debug.Print strSQL
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            SelectTable.AddItem DaoRS(0).Value
            DaoRS.MoveNext
        Wend
        DaoRS.Close
    End If
    
    
    'Get the list of clients
    Call LoadClients
    
    'Get the list of releases
    Call LoadReleases
    
    'Get the list of applications
    Call LoadApplications
    
    'Get the list of platforms
    Call LoadPlatforms
    
    'Set the default directory for the export path
    efPath.Text = "K:\DATA\TABLECHG"
    
    'Set the default export type
    optExportCustom.Value = True
    
    'Set the default file option
    optCreateFile.Value = True
    
    Screen.MousePointer = vbNormal
    SelectTable.SetFocus
    Me.Refresh

End Sub


'***************************************************************************************************************
Private Sub optExportAll_Click()
'***************************************************************************************************************
    Dim x As Integer
    
    Screen.MousePointer = vbHourglass
    SelectTable.Enabled = False
    
    For x = 0 To SelectTable.ListCount - 1
        SelectTable.Selected(x) = True
    Next
    
    Screen.MousePointer = vbNormal
    cbClient.Enabled = False
    SelectTable.Enabled = True
    
    efPath = OldPath
    Me.Refresh
    
    Call SetExportButtonState

End Sub

'***************************************************************************************************************
Private Sub optExportCISOnly_Click()
'***************************************************************************************************************
    Dim x As Integer
    
    Screen.MousePointer = vbHourglass
    SelectTable.Enabled = False
    
    For x = 0 To SelectTable.ListCount - 1
        If (Left(SelectTable.List(x), 3) = "CIS") Then
            SelectTable.Selected(x) = True
        Else
            SelectTable.Selected(x) = False
        End If
    Next
    
    Screen.MousePointer = vbNormal
    
    cbClient.Enabled = False
    SelectTable.Enabled = True
    
    efPath.Text = "C:\DEV\FND30\DATA"
    efExportFile.Text = "TCODF010"
    
    Me.Refresh
    
    Call SetExportButtonState

End Sub

'***************************************************************************************************************
Private Sub optExportCustom_Click()
'***************************************************************************************************************
    Dim x As Integer
    
    Screen.MousePointer = vbHourglass
    SelectTable.Enabled = False
    
    For x = 0 To SelectTable.ListCount - 1
        SelectTable.Selected(x) = False
    Next
    
    SelectTable.Enabled = True
    cbClient.Enabled = True
    
    Screen.MousePointer = vbNormal
    efPath = OldPath
    
    Me.Refresh
    
End Sub


'***************************************************************************************************************
Private Sub pbCancel_Click()
'***************************************************************************************************************
    Unload Me
End Sub



'***************************************************************************************************************
Public Sub LoadClients()
'***************************************************************************************************************
    
    cbClient.Enabled = False
    cbClient.Clear
    
    strSQL = "select Client, Code from tblClients order by Code"
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            cbClient.AddItem DaoRS(0).Value
            DaoRS.MoveNext
        Wend
        DaoRS.Close
        cbClient.ListIndex = 0
    End If

    'Enable the combo box.
    cbClient.Enabled = True

End Sub


'***************************************************************************************************************
Public Sub LoadReleases()
'***************************************************************************************************************
    
    cbRelease.Enabled = False
    cbRelease.Clear
    
    strSQL = "select Release, Code from tblReleases order by Code"
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            cbRelease.AddItem DaoRS(0).Value
            DaoRS.MoveNext
        Wend
        DaoRS.Close
        cbRelease.ListIndex = 0
    End If

    cbRelease.Enabled = True

End Sub


'***************************************************************************************************************
Public Sub LoadApplications()
'***************************************************************************************************************
    
    cbApplication.Enabled = False
    cbApplication.Clear
    
    strSQL = "select Application, Code from tblApplications order by Code"
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            cbApplication.AddItem DaoRS(0).Value
            DaoRS.MoveNext
        Wend
        DaoRS.Close
        cbApplication.ListIndex = 0
    End If

    cbApplication.Enabled = True

End Sub

'***************************************************************************************************************
Public Sub LoadPlatforms()
'***************************************************************************************************************
    Dim x As Integer
    
    x = 0
    cbPlatform.Enabled = False
    cbPlatform.Clear
    
    strSQL = "select Platform, Code from tblPlatforms order by Code"
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            cbPlatform.AddItem DaoRS(0).Value
            If (DaoRS(0).Value = "Windows NT") Then
                cbPlatform.ListIndex = x
            Else
                x = x + 1
            End If
            
            DaoRS.MoveNext
        Wend
        DaoRS.Close
    End If

    cbPlatform.Enabled = True

End Sub


'***************************************************************************************************************
Private Sub pbOK_Click()
'***************************************************************************************************************
    
    'Set the mouse pointer accordingly
    Screen.MousePointer = vbHourglass
    
    'Process all the selected tables
    Call ExportProcedure
    
    'Reset the mouse pointer
    Screen.MousePointer = vbNormal

End Sub

'***************************************************************************************************************
Private Sub SelectTable_Click()
'***************************************************************************************************************
    'No items selected
    If (SelectTable.SelCount = 0) Then
        efExportFile.Text = ""
        
    'One item selected
    ElseIf (SelectTable.SelCount = 1) Then
        efExportFile.Text = SelectTable.Text & ".DAT"
    
    'Multiple tables selected.
    Else
        efExportFile.Text = "CTEXPORT.DAT"
    End If
    
    Call SetExportButtonState
        
End Sub


'***************************************************************************************************************
Public Sub SetExportButtonState()
'***************************************************************************************************************
    If ((SelectTable.SelCount > 0) And (Len(efPath.Text) > 0) And (Len(efExportFile.Text) > 0)) Then
        pbOK.Enabled = True
    Else
        pbOK.Enabled = False

    End If

End Sub
