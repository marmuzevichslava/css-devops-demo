VERSION 5.00
Begin VB.Form frmExportTable 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Export Tables"
   ClientHeight    =   4230
   ClientLeft      =   45
   ClientTop       =   615
   ClientWidth     =   5295
   Icon            =   "frmexporttbls.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4230
   ScaleWidth      =   5295
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox efPath 
      Height          =   315
      Left            =   720
      Style           =   2  'Dropdown List
      TabIndex        =   21
      Top             =   2115
      Width           =   4425
   End
   Begin VB.TextBox efExportFile 
      Height          =   285
      Left            =   720
      TabIndex        =   20
      ToolTipText     =   "Name of file to export to"
      Top             =   2475
      Width           =   4425
   End
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
      Left            =   2700
      TabIndex        =   19
      Top             =   2850
      Width           =   2475
      Begin VB.OptionButton optCreateFile 
         Caption         =   "Create New File"
         Height          =   240
         Left            =   150
         TabIndex        =   8
         ToolTipText     =   "Create a new export file"
         Top             =   300
         Width           =   1590
      End
      Begin VB.OptionButton optAppendFile 
         Caption         =   "Append to existing file"
         Height          =   240
         Left            =   150
         TabIndex        =   9
         ToolTipText     =   "Append to an existing export file"
         Top             =   600
         Width           =   1965
      End
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
      Left            =   120
      TabIndex        =   18
      Top             =   2850
      Width           =   2355
      Begin VB.OptionButton optExportCISOnly 
         Caption         =   """CIS"" Codes Tables"
         Height          =   240
         Left            =   150
         TabIndex        =   7
         ToolTipText     =   "Export only the ""CIS"" codes tables"
         Top             =   885
         Width           =   1965
      End
      Begin VB.OptionButton optExportCustom 
         Caption         =   "Custom Export"
         Height          =   240
         Left            =   150
         TabIndex        =   6
         ToolTipText     =   "Perform a custom export"
         Top             =   285
         Width           =   1965
      End
      Begin VB.OptionButton optExportAll 
         Caption         =   "Export All Clients"
         Height          =   240
         Left            =   150
         TabIndex        =   5
         ToolTipText     =   "Export all the tables"
         Top             =   585
         Width           =   1515
      End
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
      Height          =   1890
      Left            =   1890
      TabIndex        =   11
      Top             =   105
      Width           =   3285
      Begin VB.ComboBox cbPlatform 
         Height          =   315
         Left            =   1290
         TabIndex        =   4
         Top             =   1440
         Width           =   1815
      End
      Begin VB.ComboBox cbApplication 
         Height          =   315
         Left            =   1290
         TabIndex        =   3
         Top             =   1050
         Width           =   1815
      End
      Begin VB.ComboBox cbRelease 
         Height          =   315
         Left            =   1290
         TabIndex        =   2
         Top             =   660
         Width           =   1815
      End
      Begin VB.ComboBox cbClient 
         Enabled         =   0   'False
         Height          =   315
         Left            =   1290
         TabIndex        =   1
         Top             =   285
         Width           =   1815
      End
      Begin VB.Label Label5 
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
         Left            =   450
         TabIndex        =   15
         Top             =   1470
         Width           =   810
      End
      Begin VB.Label Label4 
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
         TabIndex        =   14
         Top             =   1080
         Width           =   1095
      End
      Begin VB.Label Label3 
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
         Left            =   465
         TabIndex        =   13
         Top             =   690
         Width           =   795
      End
      Begin VB.Label Label2 
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
         Left            =   660
         TabIndex        =   12
         Top             =   315
         Width           =   600
      End
   End
   Begin VB.ListBox SelectTable 
      Height          =   1620
      Left            =   120
      MultiSelect     =   2  'Extended
      Sorted          =   -1  'True
      TabIndex        =   0
      ToolTipText     =   "Selected table(s) for exporting"
      Top             =   300
      Width           =   1590
   End
   Begin VB.Label Label7 
      Caption         =   "&File:"
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
      Left            =   195
      TabIndex        =   17
      Top             =   2490
      Width           =   510
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
      Left            =   195
      TabIndex        =   16
      Top             =   2145
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
      TabIndex        =   10
      Top             =   75
      Width           =   915
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuExport 
         Caption         =   "&Export"
         Shortcut        =   ^E
      End
      Begin VB.Menu mnuSeparator 
         Caption         =   "-"
      End
      Begin VB.Menu mnuClose 
         Caption         =   "&Close"
         Shortcut        =   ^C
      End
   End
   Begin VB.Menu mnuTable 
      Caption         =   "&Table"
      Begin VB.Menu mnuFind 
         Caption         =   "&Find"
         Shortcut        =   ^F
      End
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
    Dim mycodestable As New CodesTable
    Dim ctr As String
    
    Screen.MousePointer = vbHourglass
    
    'Get the list of valid codes tables and add them to the combo box.
    strsql = "select TableName From tblTables " _
           & "where TableType <> 4;"
           
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
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
    
    'Get the list of paths
    ctr = 0
    With mycodestable
        .Table = "tblExportPath"
        .CodeColumn = "code"
        .DecodeColumn = "path"
        .SortCode = True
    End With

    mycodestable.Retrieve

    Do
        If (mycodestable.Decode(ctr) = vbNullChar) Then Exit Do
            If Len(mycodestable.Decode(ctr)) Then
                efPath.AddItem mycodestable.Decode(ctr)
            End If
            ctr = ctr + 1
    Loop
    
    efPath.Text = mycodestable.Decode(0)
    
    'Set the default export type
    optExportCustom.Value = True
    
    'Set the default file option
    optCreateFile.Value = True
    
    Screen.MousePointer = vbNormal
    
    'Me.Show
    Me.Refresh

End Sub

'***************************************************************************************************************
Private Sub mnuClose_Click()
'***************************************************************************************************************
    Unload Me
End Sub
'***************************************************************************************************************
Private Sub mnuExport_Click()
'***************************************************************************************************************
    
    'Set the mouse pointer accordingly
    Screen.MousePointer = vbHourglass
    
    'Process all the selected tables
    Call ExportProcedure
    
    'Reset the mouse pointer
    Screen.MousePointer = vbNormal
End Sub

'***************************************************************************************************************
Private Sub mnuFind_Click()
'***************************************************************************************************************
    frmFindExportTable.Show vbModal
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
    
    'cmdFind.Enabled = True
    mnuFind.Enabled = True
    
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
    SelectTable.Enabled = False
    
    efExportFile.Text = "Multiple Export - Filename Will Be Provided."
    efExportFile.Enabled = False
    
    'cmdFind.Enabled = False
    mnuFind.Enabled = False
    
    
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
    
    SelectTable.Selected(0) = True
    
   'Select table in listbox that is selected on tree view.
    For x = 0 To SelectTable.ListCount - 1
        If (SelectTable.List(x) = frmMain.tvTreeView.SelectedItem.Text) Then
            SelectTable.Selected(0) = False
            SelectTable.Selected(x) = True
        End If
    Next
             
    SelectTable.Enabled = True
    cbClient.Enabled = True

    Screen.MousePointer = vbNormal
    
'    cmdFind.Enabled = True
    mnuFind.Enabled = True
    
    Me.Refresh
    
End Sub

'***************************************************************************************************************
Public Sub LoadClients()
'***************************************************************************************************************
    
    cbClient.Enabled = False
    cbClient.Clear
    
    strsql = "select Client, Code from tblClients order by Code"
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
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
    
    strsql = "select Release, Code from tblReleases order by Code"
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
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
    
    strsql = "select Application, Code from tblApplications order by Code"
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
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
    
    strsql = "select Platform, Code from tblPlatforms order by Code"
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
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
Private Sub SelectTable_Click()
'***************************************************************************************************************
    'No items selected
    If (SelectTable.SelCount = 0) Then
        efExportFile.Text = ""
        
    'One item selected
    ElseIf (SelectTable.SelCount = 1) Then
        efExportFile.Enabled = True
        efExportFile.Text = LCase(Trim$(SelectTable.Text)) & ".dat"
    
    'Multiple tables selected.
    Else
        efExportFile.Text = "Multiple Export - Filename Will Be Provided."
        efExportFile.Enabled = False
    End If
    
    Call SetExportButtonState
        
End Sub
'***************************************************************************************************************
Public Sub SetExportButtonState()
'***************************************************************************************************************
    
    If ((Len(efPath.Text) > 0) And (Len(efExportFile.Text) > 0)) Then
        mnuExport.Enabled = True
    Else
        mnuExport.Enabled = False
    End If
       
    If (optExportCISOnly = True) Then
        mnuFind.Enabled = False
    Else
        mnuFind.Enabled = True
    End If
    
End Sub
