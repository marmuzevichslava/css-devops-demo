VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.2#0"; "comctl32.ocx"
Begin VB.Form frmMain 
   Caption         =   "Codestable Explorer"
   ClientHeight    =   6000
   ClientLeft      =   165
   ClientTop       =   450
   ClientWidth     =   10380
   ForeColor       =   &H80000008&
   Icon            =   "CTMMain.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6000
   ScaleWidth      =   10380
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame famTable 
      Caption         =   "Current Table:"
      ClipControls    =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1095
      Left            =   105
      TabIndex        =   4
      Top             =   135
      Width           =   8895
      Begin VB.CheckBox chkStatic 
         Enabled         =   0   'False
         Height          =   270
         Left            =   7380
         MaskColor       =   &H80000012&
         TabIndex        =   17
         TabStop         =   0   'False
         Top             =   285
         UseMaskColor    =   -1  'True
         Width           =   255
      End
      Begin VB.TextBox txtCenturyDelim 
         BackColor       =   &H8000000B&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   270
         Left            =   6660
         Locked          =   -1  'True
         TabIndex        =   15
         TabStop         =   0   'False
         ToolTipText     =   "Length of the current tables Decodes"
         Top             =   645
         Width           =   495
      End
      Begin VB.TextBox txtTotalKeys 
         BackColor       =   &H8000000B&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   270
         Left            =   6660
         Locked          =   -1  'True
         TabIndex        =   13
         TabStop         =   0   'False
         ToolTipText     =   "Length of the current tables Decodes"
         Top             =   285
         Width           =   495
      End
      Begin VB.TextBox txtDecodeLength 
         BackColor       =   &H8000000B&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   270
         Left            =   4035
         Locked          =   -1  'True
         TabIndex        =   11
         TabStop         =   0   'False
         ToolTipText     =   "Length of the current tables Decodes"
         Top             =   645
         Width           =   495
      End
      Begin VB.TextBox txtDecodeDisplacement 
         BackColor       =   &H8000000B&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   270
         Left            =   4035
         Locked          =   -1  'True
         TabIndex        =   9
         TabStop         =   0   'False
         ToolTipText     =   "Length of the decode displacement"
         Top             =   285
         Width           =   495
      End
      Begin VB.TextBox txtKeyLength 
         BackColor       =   &H8000000B&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   270
         Left            =   1530
         Locked          =   -1  'True
         TabIndex        =   7
         TabStop         =   0   'False
         ToolTipText     =   "Length of current Key"
         Top             =   645
         Width           =   495
      End
      Begin VB.TextBox txtDataLength 
         BackColor       =   &H80000004&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   270
         Left            =   1530
         Locked          =   -1  'True
         TabIndex        =   6
         TabStop         =   0   'False
         ToolTipText     =   "Length of current Key"
         Top             =   285
         Width           =   495
      End
      Begin VB.Label txtStatic 
         Caption         =   "Static Table"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   7650
         TabIndex        =   18
         Top             =   300
         Width           =   1140
      End
      Begin VB.Label Label6 
         Alignment       =   1  'Right Justify
         Caption         =   "Century Delimeter:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   4620
         TabIndex        =   16
         Top             =   645
         Width           =   1950
      End
      Begin VB.Label Label5 
         Alignment       =   1  'Right Justify
         Caption         =   "Total Number of Keys:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   4590
         TabIndex        =   14
         Top             =   285
         Width           =   1950
      End
      Begin VB.Label Label4 
         Alignment       =   1  'Right Justify
         Caption         =   "Decode Length:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   1980
         TabIndex        =   12
         Top             =   645
         Width           =   1995
      End
      Begin VB.Label Label3 
         Alignment       =   1  'Right Justify
         Caption         =   "Decode Displacement:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   1980
         TabIndex        =   10
         Top             =   285
         Width           =   1995
      End
      Begin VB.Label Label2 
         Alignment       =   1  'Right Justify
         Caption         =   "Key Length:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   300
         TabIndex        =   8
         Top             =   645
         Width           =   1185
      End
      Begin VB.Label Label1 
         Alignment       =   1  'Right Justify
         Caption         =   "Data Length:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   300
         TabIndex        =   5
         Top             =   285
         Width           =   1185
      End
   End
   Begin VB.PictureBox picSplitter 
      BackColor       =   &H00808080&
      BorderStyle     =   0  'None
      FillColor       =   &H00808080&
      Height          =   3840
      Left            =   5400
      ScaleHeight     =   1672.101
      ScaleMode       =   0  'User
      ScaleWidth      =   780
      TabIndex        =   3
      Top             =   1545
      Visible         =   0   'False
      Width           =   72
   End
   Begin ComctlLib.TreeView tvTreeView 
      Height          =   4080
      Left            =   0
      TabIndex        =   0
      Top             =   1425
      Width           =   2970
      _ExtentX        =   5239
      _ExtentY        =   7197
      _Version        =   327680
      HideSelection   =   0   'False
      Indentation     =   529
      LabelEdit       =   1
      Style           =   7
      Appearance      =   1
      MouseIcon       =   "CTMMain.frx":030A
   End
   Begin ComctlLib.ListView lvListView 
      Height          =   4080
      Left            =   3015
      TabIndex        =   1
      Top             =   1425
      Width           =   4170
      _ExtentX        =   7355
      _ExtentY        =   7197
      View            =   3
      LabelEdit       =   1
      Sorted          =   -1  'True
      MultiSelect     =   -1  'True
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      _Version        =   327680
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      MouseIcon       =   "CTMMain.frx":0326
      NumItems        =   0
   End
   Begin ComctlLib.StatusBar sbStatusBar 
      Align           =   2  'Align Bottom
      Height          =   270
      Left            =   0
      TabIndex        =   2
      Top             =   5730
      Width           =   10380
      _ExtentX        =   18309
      _ExtentY        =   476
      SimpleText      =   ""
      _Version        =   327680
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            AutoSize        =   1
            Object.Width           =   17806
            Text            =   "Status"
            TextSave        =   "Status"
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
      EndProperty
      MouseIcon       =   "CTMMain.frx":0342
   End
   Begin VB.Image imgSplitter 
      Height          =   4065
      Left            =   2880
      MousePointer    =   9  'Size W E
      Top             =   1440
      Width           =   150
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
         Shortcut        =   ^X
      End
   End
   Begin VB.Menu mnuTable 
      Caption         =   "&Table"
      Begin VB.Menu mnuPrintTable 
         Caption         =   "&Print Contents"
         Enabled         =   0   'False
         Shortcut        =   ^P
      End
      Begin VB.Menu mnuFindTable 
         Caption         =   "&Find"
         Shortcut        =   ^F
      End
      Begin VB.Menu mnuRequest 
         Caption         =   "&Request Table Change..."
      End
   End
   Begin VB.Menu mnuAdmin 
      Caption         =   "&Admin"
      Visible         =   0   'False
      Begin VB.Menu mnuGenerate 
         Caption         =   "&Generate Copybook..."
         Enabled         =   0   'False
         Shortcut        =   ^G
      End
      Begin VB.Menu mnuSeperator 
         Caption         =   "-"
         Index           =   0
      End
      Begin VB.Menu mnuImport 
         Caption         =   "Import &SIR via Excel..."
         Shortcut        =   ^I
      End
      Begin VB.Menu mnuExport 
         Caption         =   "&Export To Foundation"
         Shortcut        =   ^E
      End
      Begin VB.Menu mnuSep1 
         Caption         =   "-"
         Index           =   2
      End
      Begin VB.Menu mnuAddTable 
         Caption         =   "&Add New Codes Table..."
         Shortcut        =   ^A
      End
      Begin VB.Menu mnuModifyTable 
         Caption         =   "&Modify Current Table..."
         Enabled         =   0   'False
         Shortcut        =   ^M
      End
      Begin VB.Menu mnuDeleteTable 
         Caption         =   "&Delete Current Table"
         Enabled         =   0   'False
         Shortcut        =   ^D
      End
      Begin VB.Menu mnuSep 
         Caption         =   "-"
         Index           =   0
      End
      Begin VB.Menu mnuAdminUsers 
         Caption         =   "Add/Delete Admin &Users..."
         Shortcut        =   ^U
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuContents 
         Caption         =   "&Contents"
      End
      Begin VB.Menu mnuSep2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "&About Explorer..."
      End
   End
   Begin VB.Menu mnuPopup 
      Caption         =   "Popup"
      Visible         =   0   'False
      Begin VB.Menu mnuAddKey 
         Caption         =   "&Add New Line..."
      End
      Begin VB.Menu mnuModifyKey 
         Caption         =   "&Modify Line..."
      End
      Begin VB.Menu mnuDeleteKey 
         Caption         =   "&Delete Line(s)"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public mbMoving As Boolean
Public bBrowseOnly As Boolean
Const sglSplitLimit = 500
Const CODES_TABLE = 1
Const MSG_BOX = 2
Const WES_CODE = 3






'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    
    Dim sParameter As String, CTMDatabase As String, msg As String, RC As Integer, sTransfer As String, x As Integer
    Dim iFileNum As Integer
    
    Me.Width = GetSetting(App.Title, "Settings", "MainWidth", (Screen.Width * 0.75))
    Me.Height = GetSetting(App.Title, "Settings", "MainHeight", (Screen.Height * 0.6))
    Me.Left = GetSetting(App.Title, "Settings", "MainLeft", (Screen.Width - Me.Width) / 2)
    Me.Top = GetSetting(App.Title, "Settings", "MainTop", (Screen.Height - Me.Height) / 2)
        
    'Set up the list view to remain highlighted when a row is selected.
    lvListView.HideSelection = False
      
    'Set up the list view so that it highlights the entire row.
    SendMessage lvListView.hwnd, LVM_SETEXTEDEDLISTVIEWSTYLE, 0, 33
    
    'Display the form.
    Me.Show
    Me.Refresh
    
    'Get the passed in argument (the full path and name of the database to go against).
    sParameter = Command
    
    'Check to make sure that the proper arguments are passed in.
    If (Len(sParameter) = 0) Then
        msg = "To Run the Codes Table Explorer, the following argument must be passed:" _
                    & vbCrLf & vbCrLf & "      - Path and name of CTM Database." _
                    & vbCrLf & "        Ex. " & Chr(34) & "C:\DATA\CTMBrowser.exe T:\Codesdat.mdb" & Chr(34) _
                    & vbCrLf & vbCrLf & "Contact " & AUTHOR & " at Solution Works for assistance."
        
        RC = MsgBox(msg, vbOKOnly + vbInformation + vbApplicationModal, "Codes Table Update")
        End
    ElseIf (InStr(LCase(sParameter), ".mdb") <> 0) Then
        CTMDatabase = sParameter
    Else
        If (Len(Dir(sParameter)) = 0) Then
            msg = "The initialization file (" & sParameter & ") does not exist. " _
                  & vbCrLf & vbCrLf & "Contact " & AUTHOR & " at Solution Works for assistance."
            RC = MsgBox(msg, vbOKOnly + vbInformation + vbApplicationModal, "Codes Table Update")
            End
        Else
            If (FileLen(sParameter) = 0) Then
                msg = "The initialization file (" & sParameter & ") is empty. " _
                      & vbCrLf & vbCrLf & "Contact " & AUTHOR & " at Solution Works for assistance."
                RC = MsgBox(msg, vbOKOnly + vbInformation + vbApplicationModal, "Codes Table Update")
                End
            Else
                iFileNum = FreeFile
                Open sParameter For Input As #iFileNum
                Line Input #iFileNum, CTMDatabase
                Close #iFileNum
            End If
        End If
    End If

    'Update the current status on the main form.
    sbStatusBar.Panels(1).Text = "Connecting to database..."
    Me.Refresh
    Screen.MousePointer = vbHourglass
    
    'Set up a browse only flag just in case we are unable to connect to the database in shared edit mode.
    bBrowseOnly = False
    
    'Set up the error handling.
    On Error GoTo ODBCError
    
    'Open the Jet workspace.
    Set wsCTM = DBEngine.Workspaces(0)

    'Attempt to open the database in shared edit mode. Comment this out to switch to using ODBC.
    Set dbCTM = Workspaces(0).OpenDatabase(CTMDatabase, False, False)
    
    'Set the length of the query timeouts.
    dbCTM.QueryTimeout = 15
    
    'Get the current transfer name of this database.
    strsql = "select Project from tblProject where ProjectFlag = True"
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        sTransfer = DaoRS(0).Value
        Me.Caption = "Codes Table Explorer - " & sTransfer
        DaoRS.Close
    End If
    
    'Build the treeview control.
    Call BuildTableList
    
    'Check the authority Level to see if the current user has admin rights.
    sbStatusBar.Panels(1).Text = "Determining Authority Levels..."
    Me.Refresh
    Sleep 2000
    
    'If the database was opened in shared edit mode, check for authority levels.
    If (Not bBrowseOnly) Then
        bAdmin = CheckAuthorityLevel()
    Else
        bAdmin = False
    End If

    'Set the administrative options based on the authority level.
    If (bAdmin) Then
        mnuAdmin.Visible = True
    Else
        mnuAdmin.Visible = False
    End If


    frmMain.tvTreeView.Nodes(1).Selected = True

    'Clean up the main form.
    sbStatusBar.Panels(1).Text = ""
    Screen.MousePointer = vbNormal

Exit Sub

ODBCError:
    
    'The database cannot be opened in shared mode - someone has it exclusively.
    If (Err.Number = 3051) Then
        RC = MsgBox("Unable to open the database in shared edit mode." & vbCrLf & _
                    "Would you like to open the database in browse mode only?", _
                    vbYesNo + vbQuestion + vbApplicationModal, _
                    "Codes Table Explorer")
        
        If (RC = vbYes) Then
            bBrowseOnly = True
            Set dbCTM = wsCTM.OpenDatabase(CTMDatabase, False, True)
            Resume Next
        Else
            End
        End If
    End If
    
    'Display the error information and exit.
    msg = "An error has occured during Form_Load" & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    
    RC = MsgBox(msg, _
                vbOKOnly + vbCritical + vbMsgBoxHelpButton + vbApplicationModal, _
                "Codes Table Explorer", _
                Err.HelpFile, Err.HelpContext)
    Err.Clear
    
    Unload Me
    
End Sub



'***************************************************************************************************************
Private Sub Form_Unload(Cancel As Integer)
'***************************************************************************************************************
    Dim i As Integer
    
    'Close the connection.
    On Error Resume Next
    
    dbCTM.Close
    wsCTM.Close

    'close all sub forms
    For i = Forms.Count - 1 To 1 Step -1
        Unload Forms(i)
    Next
    If Me.WindowState <> vbMinimized Then
        SaveSetting App.Title, "Settings", "MainLeft", Me.Left
        SaveSetting App.Title, "Settings", "MainTop", Me.Top
        SaveSetting App.Title, "Settings", "MainWidth", Me.Width
        SaveSetting App.Title, "Settings", "MainHeight", Me.Height
    End If
    SaveSetting App.Title, "Settings", "ViewMode", lvListView.View
End Sub



'***************************************************************************************************************
Private Sub Form_Resize()
'***************************************************************************************************************
    On Error Resume Next
    If Me.Width < 3000 Then Me.Width = 3000
    SizeControls imgSplitter.Left
End Sub

Private Sub Frame1_DblClick()
    If (bAdmin) Then
        If (Len(frmMain.txtKeyLength) > 0) Then
            frmAddModTable.Show vbModal
        End If
    End If
End Sub

'***************************************************************************************************************
Private Sub imgSplitter_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
'***************************************************************************************************************
    With imgSplitter
        picSplitter.Move .Left, .Top, .Width \ 2, .Height - 20
    End With
    picSplitter.Visible = True
    mbMoving = True
End Sub


'***************************************************************************************************************
Private Sub imgSplitter_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
'***************************************************************************************************************
    Dim sglPos As Single
    

    If mbMoving Then
        sglPos = x + imgSplitter.Left
        If sglPos < sglSplitLimit Then
            picSplitter.Left = sglSplitLimit
        ElseIf sglPos > Me.Width - sglSplitLimit Then
            picSplitter.Left = Me.Width - sglSplitLimit
        Else
            picSplitter.Left = sglPos
        End If
    End If
End Sub


'***************************************************************************************************************
Private Sub imgSplitter_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)
'***************************************************************************************************************
    SizeControls picSplitter.Left
    picSplitter.Visible = False
    mbMoving = False
End Sub


'***************************************************************************************************************
Sub SizeControls(x As Single)
'***************************************************************************************************************
    On Error Resume Next
    

    'set the width
    If x < 1500 Then x = 1500
    If x > (Me.Width - 1500) Then x = Me.Width - 1500
    tvTreeView.Width = x
    imgSplitter.Left = x
    lvListView.Left = x + 40
    lvListView.Width = Me.Width - (tvTreeView.Width + 140)
    
    famTable.Width = Me.Width - 400


    'set the top
    tvTreeView.Top = famTable.Height + 300
    lvListView.Top = tvTreeView.Top

    'set the height
     tvTreeView.Height = Me.ScaleHeight - (famTable.Top + famTable.Height + sbStatusBar.Height + 200)

    lvListView.Height = tvTreeView.Height
    imgSplitter.Top = tvTreeView.Top
    imgSplitter.Height = tvTreeView.Height

End Sub


'***************************************************************************************************************
Private Sub TreeView1_DragDrop(Source As Control, x As Single, Y As Single)
'***************************************************************************************************************
    If Source = imgSplitter Then
        SizeControls x
    End If
End Sub


'***************************************************************************************************************
Private Sub lvListView_DblClick()
'***************************************************************************************************************
    If (bAdmin) Then
        Call mnuModifyKey_Click
    End If
End Sub

'***************************************************************************************************************
Private Sub lvListView_ItemClick(ByVal Item As ComctlLib.ListItem)
'***************************************************************************************************************
    CurKey = CStr(Item.Text)
End Sub



'***************************************************************************************************************
Private Sub lvListView_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
'***************************************************************************************************************
    
    If ((Button = vbRightButton) And (bAdmin)) Then
        PopupMenu mnuPopup
        Me.Refresh
    End If

End Sub



'***************************************************************************************************************
Private Sub mnuAbout_Click()
'***************************************************************************************************************
    frmAbout.Show vbModal
End Sub

'***************************************************************************************************************
Private Sub mnuAddTable_Click()
'***************************************************************************************************************
    frmAddTable.Show vbModal

End Sub

'***************************************************************************************************************
Private Sub mnuAdminUsers_Click()
'***************************************************************************************************************
    frmAdminUsers.Show vbModal
End Sub


'***************************************************************************************************************
Private Sub mnuDeleteKey_Click()
'***************************************************************************************************************
    Dim RC As Integer, x As Integer, hDBTableName As String
    Dim myClient As New Client
    
    'Check to see if this what they really want to do.
    RC = MsgBox("Are you sure you wish to delete the selected line(s)?", _
                vbYesNo + vbQuestion + vbApplicationModal, "Codes Table Explorer")
    
    If (RC = vbYes) Then
        
        Screen.MousePointer = vbHourglass
    
        For x = 1 To lvListView.ListItems.Count
            If lvListView.ListItems.Item(x).Selected = True Then
        
                'Get the client code for this key.
                myClient.Decode = lvListView.ListItems.Item(x).SubItems(2)
                
                'Figure out which database table to delete from.
                If (CurTableType = CODES_TABLE) Then
                    strsql = "DELETE FROM tblEntries WHERE TableName = " & Chr(34) & tvTreeView.SelectedItem.Text & Chr(34) & _
                             " AND Key = " & Chr(34) & lvListView.ListItems.Item(x).Text & Chr(34) & _
                             " AND Client = " & myClient.Displaycode
        
                ElseIf (CurTableType = MSG_BOX) Then
                    strsql = "DELETE FROM tblMsgBoxEntries WHERE TableName = " & Chr(34) & tvTreeView.SelectedItem.Text & Chr(34) & _
                             " AND Code = " & Val(lvListView.ListItems.Item(x).Text) & _
                             " AND Client = " & myClient.Displaycode
                
                ElseIf (CurTableType = WES_CODE) Then
                    strsql = "DELETE FROM tblUserErrorMsgEntries WHERE TableName = " & Chr(34) & tvTreeView.SelectedItem.Text & Chr(34) & _
                             " AND ErrorNumber = " & Val(lvListView.ListItems.Item(x).Text) & _
                             " AND SequenceNumber = " & Val(lvListView.ListItems.Item(x).SubItems(6)) & _
                             " AND Client = " & myClient.Displaycode
                End If
    
                wsCTM.BeginTrans
                dbCTM.Execute strsql
                wsCTM.CommitTrans
                
            End If
        Next

        Screen.MousePointer = vbNormal
        
        Call RefreshCodeDecodeLB
        
    End If

    tvTreeView.SetFocus
    Me.Refresh

End Sub

'***************************************************************************************************************
Private Sub mnuDeleteTable_Click()
'***************************************************************************************************************
    Dim RC As Integer, i As Integer
    Dim sTableName As String
    
    If (CurTableType = CODES_TABLE) Then
        sTableName = tvTreeView.SelectedItem.Text
        
        'Check and see if current table contains any detail records
        strsql = "SELECT * FROM tblEntries WHERE TableName = " & Chr(34) & sTableName & Chr(34)
    
        Set DaoRS = dbCTM.OpenRecordset(strsql)
            
        If (DaoRS.EOF) Then
        
            RC = MsgBox("Are you sure you wish to delete " & sTableName & "?", _
                        vbYesNo + vbQuestion, "Codes Table Explorer")

        Else

            RC = MsgBox("Are you sure you wish to delete " & sTableName & " and " & _
                        vbCrLf & "all the Keys that it contains?", _
                        vbYesNo + vbQuestion, "Codes Table Explorer")

        End If
        
        DaoRS.Close
                
        If (RC = vbYes) Then
        
            Screen.MousePointer = vbHourglass
            
            strsql = "DELETE * FROM tblTables WHERE TableName = " & Chr(34) & sTableName & Chr(34)
                
            'Begin a new transaction.
            wsCTM.BeginTrans

            'Execute the delete
            dbCTM.Execute strsql

            'Check the results.
            If (Err.Number = 0) Then

                strsql = "DELETE * FROM tblEntries WHERE TableName = " & Chr(34) & sTableName & Chr(34)
                
                dbCTM.Execute strsql
                
                If (Err.Number = 0) Then
                    
                    wsCTM.CommitTrans
                    
                    RC = MsgBox(sTableName & " successfully deleted.", _
                                vbOKOnly + vbInformation, "Codes Table Explorer")
                                        
                    'Clear the control.
                    tvTreeView.Nodes.Clear
                    lvListView.ListItems.Clear

                    'Rebuild the table list.
                    Call BuildTableList
                    tvTreeView.Nodes(1).Selected = True
                    Call tvTreeView_NodeClick(tvTreeView.SelectedItem)
                    
                    Screen.MousePointer = vbNormal
                
                Else
                    RC = MsgBox("Unable to delete " & sTableName & "." & _
                                vbCrLf & "Contact Development Tools for assistance.", _
                                vbOKOnly + vbCritical, "Codes Table Explorer")
                    wsCTM.Rollback
                    Screen.MousePointer = vbNormal
                End If
            Else
                Screen.MousePointer = vbNormal
                RC = MsgBox("Unable to delete " & sTableName & "." & _
                            vbCrLf & "Contact Development Tools for assistance.", _
                            vbOKOnly + vbCritical, "Codes Table Explorer")
                wsCTM.Rollback
            End If
        End If
    Else
        Screen.MousePointer = vbNormal
        RC = MsgBox("Unable to delete " & sTableName & " using Codes " & vbCrLf & _
                    "Table Explorer. Please use Microsoft Access or contact" & vbCrLf & _
                    "Development tools for assistance.", vbOKOnly + vbExclamation, "Codes Table Explorer")
    End If
        
    
    
End Sub

'***************************************************************************************************************
Private Sub mnuExit_Click()
'***************************************************************************************************************
    Unload Me
End Sub


'***************************************************************************************************************
Private Sub mnuExport_Click()
'***************************************************************************************************************
    frmExportTable.Show

End Sub

'***************************************************************************************************************
Private Sub mnuFindTable_Click()
'***************************************************************************************************************
    frmFindTable.Show

End Sub


'***************************************************************************************************************
Private Sub mnuGenerate_Click()
'***************************************************************************************************************
    frmSourceFileGenerator.Show

End Sub

'***************************************************************************************************************
Private Sub mnuImport_Click()
'***************************************************************************************************************
    frmInsertTbl.Show
    
End Sub


'***************************************************************************************************************
Private Sub mnuModifyKey_Click()
'***************************************************************************************************************
    Dim RC As Integer, iSelected As Integer
    
    iSelected = 0
    
    If (CurKey = "") Then
        RC = MsgBox("No Key selected from current table.", vbOKOnly + vbExclamation, "Codes Table Explorer")
        Me.Refresh
        Exit Sub
    End If
    
    iSelected = lvListView.SelectedItem.Index
    
    If (CurTableType = CODES_TABLE) Then
        bAddNewKey = False
        frmAddModKey.Show vbModal
    ElseIf (CurTableType = MSG_BOX) Then
        bAddNewKey = False
        frmAddModMsg.Show vbModal
    ElseIf (CurTableType = WES_CODE) Then
        bAddNewKey = False
        frmAddModUMsg.Show vbModal
    Else
        RC = MsgBox("Unable determin type of table. Please contact" & vbCrLf & _
                    "Development tools for assistance.", vbOKOnly + vbExclamation, "Codes Table Explorer")
    End If
    
    'Get all the Keys and decodes.
    Screen.MousePointer = vbHourglass
    
    Call RefreshCodeDecodeLB
    
    Screen.MousePointer = vbDefault
    
    lvListView.ListItems(iSelected).Selected = True
    Set lvListView.SelectedItem = lvListView.ListItems(iSelected)
    lvListView.ListItems(iSelected).EnsureVisible
    lvListView.Refresh
    lvListView.SetFocus
    
End Sub


'***************************************************************************************************************
Private Sub mnuAddKey_Click()
'***************************************************************************************************************
    Dim RC As Integer
    
    If (CurTableType = CODES_TABLE) Then
        bAddNewKey = True
        frmAddModKey.Show vbModal
    ElseIf (CurTableType = MSG_BOX) Then
        bAddNewKey = True
        frmAddModMsg.Show vbModal
    ElseIf (CurTableType = WES_CODE) Then
        bAddNewKey = True
        frmAddModUMsg.Show vbModal
    Else
        RC = MsgBox("Unable determin type of table. Please contact" & vbCrLf & _
                    "Development tools for assistance.", vbOKOnly + vbExclamation, "Codes Table Explorer")
    End If
    
    Screen.MousePointer = vbHourglass
    
    'Get all the Keys and decodes.
    Call RefreshCodeDecodeLB
    tvTreeView.SetFocus
    
    Screen.MousePointer = vbNormal

End Sub


Private Sub mnuModifyTable_Click()
    frmAddModTable.Show vbModal
End Sub

'***************************************************************************************************************
Private Sub mnuPrintTable_Click()
'***************************************************************************************************************
    Dim x As Integer, iStr As Integer, iPg As Integer, iDecodeLenth As Integer
    Dim sDecode As String
        
    On Error GoTo PrinterError
    
    Screen.MousePointer = vbHourglass
    iPg = 1
    
    Printer.Orientation = vbPRORLandscape
    Printer.PrintQuality = vbPRPQHigh
    Printer.ScaleMode = 1
    Printer.CurrentX = 0
    Printer.Line Step(5, 5)-Step(15000, 50), , BF
    Printer.FontName = "Times New Roman"
    Printer.FontBold = True
    Printer.FontSize = 15
    Printer.Print vbLf & "Codes Table: " & CurTable
    Printer.FontBold = False
    Printer.FontSize = 10
    
    If (Len(sbStatusBar.Panels(1).Text) > 170) Then
        iStr = InStr(170, sbStatusBar.Panels(1).Text, " ")
        
        Printer.Print vbLf & Left(sbStatusBar.Panels(1).Text, iStr)
        Printer.Print Mid(sbStatusBar.Panels(1).Text, iStr + 1, Len(sbStatusBar.Panels(1).Text)) & vbLf
    Else
        Printer.Print vbLf & sbStatusBar.Panels(1).Text & vbLf
    End If
    
    Printer.Line Step(5, 5)-Step(15000, 10), , BF
    Printer.CurrentY = Printer.CurrentY + 40
    
    Printer.FontBold = True
    Printer.CurrentX = 0
    Printer.Print "Key"
    Printer.CurrentX = 1750
    Printer.CurrentY = Printer.CurrentY - 234
    Printer.Print "Client"
    Printer.CurrentX = 4000
    Printer.CurrentY = Printer.CurrentY - 234
    Printer.Print "Decode"
    Printer.FontBold = False
    
    Printer.CurrentY = Printer.CurrentY + 40
    
    Printer.Line Step(5, 5)-Step(15000, 10), , BF
    
    Printer.CurrentY = Printer.CurrentY + 40
    
    For x = 1 To lvListView.ListItems.Count
        
        If (Printer.CurrentY > 10500) Then
            
            Printer.CurrentY = 10800
            Printer.CurrentX = 0
            Printer.Line Step(5, 5)-Step(15000, 50), , BF
            
            Printer.CurrentX = 0
            Printer.Print Date & " - " & Time
            
            Printer.CurrentY = Printer.CurrentY - 234
            Printer.CurrentX = 14000
            Printer.Print "Page " & iPg
            iPg = iPg + 1
            
            Printer.NewPage
            
            Printer.CurrentX = 0
            Printer.Line Step(5, 5)-Step(15000, 50), , BF
            Printer.FontName = "System"
            Printer.FontBold = True
            Printer.FontSize = 15
            Printer.Print vbLf & "Codes Table: " & CurTable & vbLf
            Printer.FontBold = False
            Printer.FontSize = 10
            Printer.Line Step(5, 5)-Step(15000, 10), , BF
            Printer.CurrentY = Printer.CurrentY + 40
            
            Printer.FontBold = True
            Printer.CurrentX = 0
            Printer.Print "Key"
            Printer.CurrentX = 1750
            Printer.CurrentY = Printer.CurrentY - 234
            Printer.Print "Client"
            Printer.CurrentX = 4000
            Printer.CurrentY = Printer.CurrentY - 234
            Printer.Print "Decode"
            Printer.FontBold = False
            Printer.CurrentY = Printer.CurrentY + 40
            Printer.Line Step(5, 5)-Step(15000, 10), , BF
            Printer.CurrentY = Printer.CurrentY + 40
        
        End If
        
        Printer.CurrentX = 0
        Printer.Print lvListView.ListItems(x).Text
        Printer.CurrentX = 1750
        Printer.CurrentY = Printer.CurrentY - 234
        Printer.Print lvListView.ListItems(x).SubItems(2)
        Printer.CurrentX = 4000
        Printer.CurrentY = Printer.CurrentY - 234
        
        sDecode = lvListView.ListItems(x).SubItems(1)
        
        If (Len(sDecode) > 125) Then
            
            iStr = InStr(125, sDecode, " ")
            Printer.Print Left(sDecode, iStr)
            Printer.CurrentX = 4000
            Printer.CurrentY = Printer.CurrentY + 20
            
            sDecode = Mid(lvListView.ListItems(x).SubItems(1), iStr + 1, Len(sDecode))
            
            If (Len(sDecode) > 125) Then
            
                iStr = InStr(125, sDecode, " ")
                Printer.Print Left(sDecode, iStr)
                Printer.CurrentX = 4000
                Printer.CurrentY = Printer.CurrentY + 20
                Printer.Print Mid(sDecode, iStr + 1, Len(sDecode))
                
            Else
            
                Printer.Print sDecode
                Printer.CurrentY = Printer.CurrentY + 20
                
            End If
        
        Else
            
            Printer.Print sDecode
            Printer.CurrentY = Printer.CurrentY + 20
        
        End If
    
    Next
    
    Printer.CurrentY = 10800
    Printer.CurrentX = 0
    Printer.Line Step(5, 5)-Step(15000, 50), , BF
            
    Printer.CurrentX = 0
    Printer.Print Date & " - " & Time
            
    Printer.CurrentY = Printer.CurrentY - 234
    Printer.CurrentX = 14000
    Printer.Print "Page " & iPg
        
    Printer.EndDoc
    
    Screen.MousePointer = vbNormal
Exit Sub

PrinterError:
    Dim RC As Integer
    Screen.MousePointer = vbNormal
    RC = MsgBox("Unable to print to " & Printer.DeviceName & "." & vbCrLf & _
                "Please check your print settings and the printer.", _
                vbOKOnly + vbExclamation, "Codes Table Explorer")
End Sub


'***************************************************************************************************************
Private Sub mnuRequest_Click()
'***************************************************************************************************************
    Dim xlApp As Object, xlTemplate As Object, objSpreadSheet As Object
    
    Set xlApp = CreateObject("Excel.Application")
    
    'Set xlTemplate = xlApp.Workbooks.Open(App.Path & "\CTRequest.xlt", , True, , "c1admin", "c1admin", True)
    Set xlTemplate = xlApp.Workbooks.Open("n:\dzct01\CTRequest.xlt", , True, , "c1admin", "c1admin", True)
    xlApp.ActiveWorkbook.RunAutoMacros xlAutoOpen

    xlApp.Visible = True
    
End Sub

'***************************************************************************************************************
Private Sub tvTreeView_NodeClick(ByVal Node As ComctlLib.Node)
'***************************************************************************************************************
    Call MainTreeViewNodeClick(Node)

End Sub


