VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.2#0"; "comctl32.ocx"
Begin VB.Form frmTableLoad 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Table Load Process"
   ClientHeight    =   2265
   ClientLeft      =   150
   ClientTop       =   435
   ClientWidth     =   3735
   Icon            =   "frmloadtable.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2265
   ScaleWidth      =   3735
   StartUpPosition =   1  'CenterOwner
   Begin VB.Frame Frame2 
      Caption         =   "Load Options:"
      Height          =   735
      Left            =   120
      TabIndex        =   10
      Top             =   1200
      Width           =   3495
      Begin VB.OptionButton optXltOnly 
         Caption         =   "Xlt Only"
         Height          =   255
         Left            =   1200
         TabIndex        =   3
         Top             =   360
         Width           =   975
      End
      Begin VB.OptionButton optDatOnly 
         Caption         =   "Dat Only"
         Height          =   255
         Left            =   2280
         TabIndex        =   4
         Top             =   360
         Width           =   1095
      End
      Begin VB.OptionButton optBoth 
         Caption         =   "Both"
         Height          =   255
         Left            =   240
         TabIndex        =   2
         Top             =   360
         Width           =   855
      End
   End
   Begin ComctlLib.ProgressBar pBar 
      Height          =   255
      Left            =   2520
      TabIndex        =   6
      Top             =   2040
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   450
      _Version        =   327680
      Appearance      =   0
   End
   Begin VB.Frame Frame1 
      Caption         =   "Environment Settings:"
      Height          =   1095
      Left            =   120
      TabIndex        =   7
      Top             =   0
      Width           =   3495
      Begin VB.ComboBox cboProject 
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   480
         Width           =   1575
      End
      Begin VB.ComboBox cboEnvironment 
         Height          =   315
         Left            =   1800
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   480
         Width           =   1575
      End
      Begin VB.Label Label2 
         Caption         =   "Environment:"
         Height          =   255
         Left            =   1800
         TabIndex        =   9
         Top             =   240
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Project:"
         Height          =   255
         Left            =   120
         TabIndex        =   8
         Top             =   240
         Width           =   1215
      End
   End
   Begin ComctlLib.StatusBar sbStatusBar 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   5
      Top             =   2010
      Width           =   3735
      _ExtentX        =   6588
      _ExtentY        =   450
      SimpleText      =   ""
      _Version        =   327680
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   2
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            TextSave        =   ""
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel2 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            TextSave        =   ""
            Object.Tag             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuLoad 
         Caption         =   "&Process"
         Shortcut        =   ^P
      End
      Begin VB.Menu mnuSeperator 
         Caption         =   "-"
      End
      Begin VB.Menu mnuClose 
         Caption         =   "&Close"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuContents 
         Caption         =   "&Contents"
      End
      Begin VB.Menu mnuSeperator2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "&About"
      End
   End
End
Attribute VB_Name = "frmTableLoad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Const XLT_REMOTE_PATH = "/sw/working/pvcs/xltmap"
Const KCOD_PATH = "c:\dev\fnd32\data"
Const BASE_PATH = "k:\data\codestbl\tablechange"
Const KCOD_NAME = "KCODF010.TBL"
Const TOTAL_STEPS = 10
Const TOTAL_STEPS_NO_DAT = 9
Const TOTAL_STEPS_NO_XLT = 7
Const TEMP_PATH = "c:\temp"
Const USER = "pvcs"
Const PWD = "frog42"
Const DAT_LOAD_EXE = "c:\dev\fnd32\bin\cdtupdat.exe"
Const MAP_LOAD_EXE = "c:\dev\fnd32\bin\mapload.exe"
Const MAP_LOAD_CFG = "c:\temp\mapload.cfg"
Const MAP_LOAD_LOG = "c:\temp\mapload.log"

Public sRemoteKcodFile As String
Public sLocalKcodFile As String
Public sArchiveKcodFile As String
Public sServer As String
Public sDatPath As String
Public sDatArchivePath As String
Public sXltPath As String
Public sXltArchivePath As String
Public sXltRemotePath As String
Public mywdj As New wdj
Public myftp As New FTP

'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
Dim mycodestable As New CodesTable
Dim ctr As Integer
Dim Decode As String

'Populate the Environment combo box
ctr = 0

With mycodestable
    .Table = "tblEnvironment"
    .CodeColumn = "code"
    .DecodeColumn = "environment"
    .SortDecode = True
End With

mycodestable.Retrieve

Do
    If (mycodestable.Decode(ctr) = vbNullChar) Then Exit Do
    If Len(mycodestable.Decode(ctr)) Then
        cboEnvironment.AddItem mycodestable.Decode(ctr)
    End If
    ctr = ctr + 1
Loop

cboEnvironment.Text = mycodestable.Decode(0)

'Populate the Project combo box
ctr = 0

With mycodestable
    .Table = "tblProjectEnv"
    .CodeColumn = "code"
    .DecodeColumn = "projectenv"
    .SortDecode = True
End With

mycodestable.Retrieve

Do
    If (mycodestable.Decode(ctr) = vbNullChar) Then Exit Do
    If Len(mycodestable.Decode(ctr)) Then
        cboProject.AddItem mycodestable.Decode(ctr)
    End If
    ctr = ctr + 1
Loop

cboProject.Text = mycodestable.Decode(0)

Me.optBoth = True

sbStatusBar.Panels(1).Width = Me.Width * 0.64
sbStatusBar.Panels(2).Width = Me.Width * 0.33
sbStatusBar.Panels(1).Text = "Ready."
pBar.Height = sbStatusBar.Height - 42
pBar.Width = sbStatusBar.Panels(2).Width - 50

End Sub
'***************************************************************************************************************
Private Sub mnuClose_Click()
'***************************************************************************************************************
    Unload Me
End Sub
'***************************************************************************************************************
Private Sub mnuLoad_Click()
'***************************************************************************************************************
    Dim bNoXlt As Boolean
    Dim bNoDat As Boolean
    Dim iTotalSteps As Integer
    Dim msg As String
    
    bNoXlt = False
    bNoDat = False
    
    If Me.optDatOnly Then
        bNoXlt = True
        iTotalSteps = TOTAL_STEPS_NO_XLT
    ElseIf Me.optXltOnly Then
        bNoDat = True
        iTotalSteps = TOTAL_STEPS_NO_DAT
    Else
        iTotalSteps = TOTAL_STEPS
    End If
    
    With pBar
        .Max = iTotalSteps
        .Min = 0
        .Value = 0
    End With
    
    Screen.MousePointer = vbHourglass
    
    'Set path and server settings
    pBar.Value = pBar.Value + 1
    sbStatusBar.Panels(1).Text = "Initializing..."
    If Not InitializeSettings Then
        Unload Me
        Exit Sub
    End If
    
    'Make a backup of the users current kcodfile (currently kcodf010.tbl)
    pBar.Value = pBar.Value + 1
    sbStatusBar.Panels(1).Text = "Backing up " & KCOD_NAME
    sbStatusBar.Refresh
    If Not BackupTblFile Then
        Unload Me
        Exit Sub
    End If
    
    'Get remote version of kcodf010.tbl
    pBar.Value = pBar.Value + 1
    sbStatusBar.Panels(1).Text = "Downloading " & KCOD_NAME
    sbStatusBar.Refresh
    If Not GetTblFile Then
        Unload Me
        Exit Sub
    End If
      
    If Not bNoXlt Then
        'Get all xlt maps from remote server
        pBar.Value = pBar.Value + 1
        sbStatusBar.Panels(1).Text = "Downloading all xlt maps"
        sbStatusBar.Refresh
        If Not GetXltMaps Then
            Unload Me
            Exit Sub
        End If
    
        'Load xlt maps
        pBar.Value = pBar.Value + 1
        sbStatusBar.Panels(1).Text = "Loading xlt's to " & KCOD_NAME
        sbStatusBar.Refresh
        If Not LoadXltMaps Then
            Unload Me
            Exit Sub
        End If
    End If
    
    If Not bNoDat Then
        'Load codes tables
        pBar.Value = pBar.Value + 1
        sbStatusBar.Panels(1).Text = "Loading dat's to " & KCOD_NAME
        sbStatusBar.Refresh
        If Not LoadCodesTables Then
            Unload Me
            Exit Sub
        End If
    End If
    
    'Archive xlt's and dat's
    pBar.Value = pBar.Value + 1
    sbStatusBar.Panels(1).Text = "Archiving dat's and xlt's"
    sbStatusBar.Refresh
    If Not Archive(bNoDat, bNoXlt) Then
        Unload Me
        Exit Sub
    End If
    
    If Not bNoXlt Then
        'Remove remote xlt maps
        pBar.Value = pBar.Value + 1
        sbStatusBar.Panels(1).Text = "Removing remote xlt's"
        sbStatusBar.Refresh
        If Not RemoveRemoteXlt Then
            Unload Me
            Exit Sub
        End If
    End If
    
    'Put new kcod file in direcory structure
    pBar.Value = pBar.Value + 1
    sbStatusBar.Panels(1).Text = "Putting new " & KCOD_NAME
    sbStatusBar.Refresh
    If Not PutTblFile Then
        Unload Me
        Exit Sub
    End If
    
    'Restore original Kcod file
    pBar.Value = pBar.Value + 1
    sbStatusBar.Panels(1).Text = "Restoring local " & KCOD_NAME
    sbStatusBar.Refresh
    If Not RestoreTblFile Then
        Unload Me
        Exit Sub
    End If
    
    msg = "Completed load for " & KCOD_NAME & vbCrLf _
          & "Poject: " & cboProject.Text & vbCrLf _
          & "Environment: " & cboEnvironment.Text & vbCrLf
        
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbExclamation, App.Title)
    
    With pBar
        .Min = 0
        .Value = 0
    End With
    
    sbStatusBar.Panels(1).Text = "Ready."
    sbStatusBar.Refresh
    
End Sub
'***************************************************************************************************************
Function RestoreTblFile() As Boolean
'***************************************************************************************************************
    Dim msg As String
    
    On Error GoTo ErrorHandler
    
    FileCopy TEMP_PATH & "\" & KCOD_NAME, KCOD_PATH & "\" & KCOD_NAME
    Kill TEMP_PATH & "\" & KCOD_NAME
    
    RestoreTblFile = True
    
    Exit Function
    
ErrorHandler:
            
    msg = "An error occured while restoring " & KCOD_NAME & vbCrLf _
                & "Number = " & Err.Number & vbCrLf _
                & "Description: " & Err.Description & vbCrLf
        
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
    RestoreTblFile = False
End Function
'***************************************************************************************************************
Function PutTblFile() As Boolean
'***************************************************************************************************************
    Dim msg As String
    
    With myftp
        .HostName = sServer
        .UserName = USER
        .Password = PWD
        .RemoteFile = sRemoteKcodFile
        .LocalFile = sLocalKcodFile
        .ErrorMessageBox = True
        .PutFile
    End With

    'Check to see if get was successful
    If myftp.Error Then
               
         msg = "An error occured while putting " & sRemoteKcodFile & vbCrLf _
                & KCOD_NAME & " was not replaced. No changes will be visible." & vbCrLf
        
        Screen.MousePointer = vbNormal
        RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
        PutTblFile = False
    Else
        PutTblFile = True
    End If
    
End Function
'***************************************************************************************************************
Function RemoveRemoteXlt() As Boolean
'***************************************************************************************************************
    Dim msg As String
    Dim RC As Integer
    
    With myftp
        .HostName = sServer
        .UserName = USER
        .Password = PWD
        .RemoteDirectory = sXltRemotePath
        .RemoteFile = "*.xlt"
        .ErrorMessageBox = True
        .DeleteDirectory
    End With

    If myftp.Error Then
        
         msg = "Xlt maps were not removed from holding area on " & sServer & vbCrLf _
                & "Do you want to continue with process?" & vbCrLf
        
        Screen.MousePointer = vbNormal
        RC = MsgBox(msg, vbYesNo + vbQuestion, App.Title)
        If RC = vbYes Then
            RemoveRemoteXlt = True
            Screen.MousePointer = vbHourglass
        Else
            RemoveRemoteXlt = False
        End If
    Else
        RemoveRemoteXlt = True
    End If
    
End Function
'***************************************************************************************************************
Function Archive(ByVal bNoDat As Boolean, ByVal bNoXlt As Boolean) As Boolean
'***************************************************************************************************************
    Dim sFile As String
    Dim msg As String
    Dim RC As Integer
    
    On Error GoTo ErrorHandler
    
    If Not bNoDat Then
        sFile = Dir(sDatPath & "\*")
        Do While sFile <> ""
            FileCopy sDatPath & "\" & sFile, sDatArchivePath & "\" & sFile
            Kill sDatPath & "\" & sFile
            sFile = Dir
        Loop
    End If
    
    If Not bNoXlt Then
        sFile = Dir(sXltPath & "\*")
        Do While sFile <> ""
            FileCopy sXltPath & "\" & sFile, sXltArchivePath & "\" & sFile
            Kill sXltPath & "\" & sFile
            sFile = Dir
        Loop
    End If
    
    Archive = True
    Exit Function
    
ErrorHandler:
       
    msg = "An error occured archiving files." & vbCrLf _
                & "Number = " & Err.Number & vbCrLf _
                & "Description: " & Err.Description & vbCrLf _
                & "Do you want to continue with process?" & vbCrLf
                
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbYesNo + vbQuestion, App.Title)
        If RC = vbYes Then
            Archive = True
            Screen.MousePointer = vbHourglass
        Else
            Archive = False
        End If

End Function
'***************************************************************************************************************
Function LoadCodesTables() As Boolean
'***************************************************************************************************************
    Dim sFile As String
    Dim sKcodTime1 As Variant
    Dim sKcodTime2 As Variant
    Dim msg As String
    Dim RC As Integer
    
    On Error GoTo ErrorHandler
    
    sFile = Dir(sDatPath & "\*")
    If sFile <> "" Then
        Do While sFile <> ""
            sKcodTime1 = FileDateTime(KCOD_PATH & "\" & KCOD_NAME)
            
            Sleep 2000
            
            'Load dat files
            With mywdj
                .Command = DAT_LOAD_EXE & " " & sDatPath & "\" & sFile
                .Execute
            End With
            
            sKcodTime2 = FileDateTime(KCOD_PATH & "\" & KCOD_NAME)
            
            If ((sKcodTime1 = sKcodTime2) Or mywdj.Error) Then
                msg = "An error occured while loading codestable " & sFile & vbCrLf _
                    & KCOD_NAME & " was not changed." & vbCrLf
        
                Screen.MousePointer = vbNormal
                RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
                LoadCodesTables = False
                Exit Function
            End If
            
            LoadCodesTables = True
            sFile = Dir
        Loop
    Else

        msg = "No dat files were found." & vbCrLf _
                & "Do you want to continue with process?" & vbCrLf
                
        Screen.MousePointer = vbNormal
        RC = MsgBox(msg, vbYesNo + vbQuestion, App.Title)
        If RC = vbYes Then
            LoadCodesTables = True
            Screen.MousePointer = vbHourglass
        Else
            LoadCodesTables = False
        End If
    End If

    Exit Function
ErrorHandler:
    
    msg = "An error occured while loading xlt maps. " & vbCrLf _
                & "Number = " & Err.Number & vbCrLf _
                & "Description: " & Err.Description & vbCrLf
        
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
    LoadCodesTables = False
    
End Function
'***************************************************************************************************************
Function InitializeSettings() As Boolean
'***************************************************************************************************************
    Dim mycodestable As New CodesTable
    Dim ctr As Integer
    Dim sFile As String
    Dim sDate As String
    Dim msg As String
    Dim RC As Integer
    
    sDate = Date
    
    On Error GoTo ErrorHandler
    
    'Initialize Variables
    sRemoteKcodFile = "/sw/c1/" & cboProject.Text & "/client/" & cboEnvironment.Text & "/runtime/nt/codestbl/" & KCOD_NAME
    sLocalKcodFile = KCOD_PATH & "\" & KCOD_NAME
    sArchiveKcodFile = BASE_PATH & "\" & cboProject.Text & "\" & KCOD_NAME & "." _
                    & cboEnvironment.Text _
                    & "." _
                    & ParseString(sDate, "/", 1) _
                    & ParseString(sDate, "/", 2) _
                    & ParseString(sDate, "/", 3)
    sDatPath = BASE_PATH & "\" & cboProject.Text & "\dat\" & cboEnvironment.Text
    sDatArchivePath = BASE_PATH & "\" & cboProject.Text & "\dat\archive\" & cboEnvironment.Text
    sXltPath = BASE_PATH & "\" & cboProject.Text & "\xlt\" & cboEnvironment.Text
    sXltArchivePath = BASE_PATH & "\" & cboProject.Text & "\xlt\archive\" & cboEnvironment.Text
    sXltRemotePath = XLT_REMOTE_PATH & "/" & cboProject.Text & "/" & cboEnvironment.Text
         
    'Find out what server the project resides on
    strsql = "Select server " _
             & "From tblProjectEnv " _
             & "Where projectenv = " & Chr(39) & cboProject.Text & Chr(39)
             
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then
        sServer = DaoRS(0).Value
    Else
        DaoRS.Close
        Err.Raise 1, "DAO", "Database Error - No rows returned for server name."
    End If

    DaoRS.Close
    InitializeSettings = True
    
    Exit Function
    
ErrorHandler:
    
msg = "An error occured while initializing variables. " & vbCrLf _
                & "Number = " & Err.Number & vbCrLf _
                & "Description: " & Err.Description & vbCrLf
        
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
    InitializeSettings = False
    
End Function
'***************************************************************************************************************
Function LoadXltMaps() As Boolean
'***************************************************************************************************************
    Dim iFileNum As Integer
    Dim sFile As String
    Dim msg As String
    Dim RC As Integer
    Dim sLine As String
    Dim sNoExt As String
    Dim bFound As Boolean
    
    On Error GoTo ErrorHandler

    iFileNum = FreeFile
    
    Open MAP_LOAD_CFG For Output As iFileNum
    
    Print #iFileNum, "# Temporary mapload configuration file"
    Print #iFileNum, "[Options]"
    Print #iFileNum, "Enabled = Yes"
    Print #iFileNum, "CoreLoad = No"
    Print #iFileNum, "ErrorMessageBox = Yes"
    Print #iFileNum, "LogFile=" & MAP_LOAD_LOG
    Print #iFileNum, " "
    Print #iFileNum, "[Files]"
       
    sFile = Dir(sXltPath & "\*")
    If sFile <> "" Then
        Do While sFile <> ""
            Print #iFileNum, sXltPath & "\" & sFile
            sFile = Dir
        Loop
        
        Close iFileNum
        
        'Remove old log files
        sFile = Dir(MAP_LOAD_LOG)
        If sFile <> "" Then
            Kill MAP_LOAD_LOG
        End If
        
        'Load xlt maps
        With mywdj
            .Command = MAP_LOAD_EXE & " ### " & MAP_LOAD_CFG
            .Execute
        End With
        
        sFile = Dir(sXltPath & "\*")
        Do While sFile <> ""
            iFileNum = FreeFile
            bFound = False
            sNoExt = ParseString(sFile, ".", 1)
            Open MAP_LOAD_LOG For Input As iFileNum
            Do Until EOF(iFileNum)
                Input #iFileNum, sLine
                If InStr(sLine, "Imported table " & Chr(39) & UCase(sNoExt) & Chr(39) & " successfully") Then
                    bFound = True
                    Exit Do
                End If
            Loop
            Close iFileNum
            If Not bFound Then
                msg = "An error occured while loading xlt maps." & vbCrLf _
                    & "Error: " & sFile & " not loaded." & vbCrLf
                Screen.MousePointer = vbNormal
                RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
                LoadXltMaps = False
                Exit Function
            Else
                sFile = Dir
            End If
        Loop
        
        LoadXltMaps = True
    Else
        Close iFileNum
        
        msg = "No xlt maps were found." & vbCrLf _
                & "Do you want to continue with process?" & vbCrLf
                        
        Screen.MousePointer = vbNormal
        RC = MsgBox(msg, vbYesNo + vbQuestion, App.Title)
        If RC = vbYes Then
            LoadXltMaps = True
            Screen.MousePointer = vbHourglass
        Else
            LoadXltMaps = False
        End If
   End If
    
    Exit Function

ErrorHandler:
        
    msg = "An error occured while loading xlt maps. " & vbCrLf _
                & "Number = " & Err.Number & vbCrLf _
                & "Description: " & Err.Description & vbCrLf
        
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbCritical, App.Title)
    LoadXltMaps = False
    
End Function
'***************************************************************************************************************
Function GetXltMaps() As Boolean
'***************************************************************************************************************
    Dim sFile As String
    Dim msg As String
    Dim RC As Integer
    
    On Error GoTo ErrorHandler
    
    'Remove all files from the xlt map area
    sFile = Dir(sXltPath & "\*")
    Do While sFile <> ""
        Kill sXltPath & "\" & sFile
        sFile = Dir
    Loop
    
    'Get all xlt maps from remote server
    With myftp
        .HostName = sServer
        .UserName = USER
        .Password = PWD
        .RemoteDirectory = sXltRemotePath
        .LocalDirectory = sXltPath
        .RemoteFile = "*.xlt"
        .ErrorMessageBox = True
        .GetDirectory
    End With
    
    If myftp.Error Then
         msg = "Xlt maps were not ftp'd from " & sServer & vbCrLf _
                & "Do you want to continue with process?" & vbCrLf
        
        Screen.MousePointer = vbNormal
        RC = MsgBox(msg, vbYesNo + vbQuestion, App.Title)
        If RC = vbYes Then
            GetXltMaps = True
            Screen.MousePointer = vbHourglass
        Else
            GetXltMaps = False
        End If
        
        sFile = Dir(sXltPath & "\*")
        Do While sFile <> ""
            Kill sXltPath & "\" & sFile
            sFile = Dir
        Loop
    Else
        GetXltMaps = True
    End If
    
    Exit Function
    
ErrorHandler:
            
    msg = "An error occured while backing up " & KCOD_NAME & vbCrLf _
                & "Number = " & Err.Number & vbCrLf _
                & "Description: " & Err.Description & vbCrLf
        
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
    GetXltMaps = False
End Function
'***************************************************************************************************************
Function GetTblFile() As Boolean
'***************************************************************************************************************
    Dim msg As String
    Dim RC As Integer
    Dim iCtr As Integer
    Dim sFile As String
    Dim bCheckFlag As Boolean
    
    iCtr = 1
    bCheckFlag = True
    
    On Error GoTo ErrorHandler
    
    'Get remote version of kcodf010.tbl
    With myftp
        .HostName = sServer
        .UserName = USER
        .Password = PWD
        .RemoteFile = sRemoteKcodFile
        .LocalFile = sLocalKcodFile
        .ErrorMessageBox = True
        .GetFile
    End With

    'Check to see if get was successful
    If myftp.Error Then
        Err.Raise 1, , "FTP ERROR.  Could not get file"
    End If
    
    While (bCheckFlag)
        sFile = Dir(sArchiveKcodFile & "." & iCtr)
        If (Len(sFile) = 0) Then
            bCheckFlag = False
        Else
            iCtr = iCtr + 1
        End If
    Wend
    
    With myftp
        .HostName = sServer
        .UserName = USER
        .Password = PWD
        .RemoteFile = sRemoteKcodFile
        .LocalFile = sArchiveKcodFile & "." & iCtr
        .ErrorMessageBox = True
        .GetFile
    End With
    
    'Check to see if get was successful
    If myftp.Error Then
        Err.Raise 1, , "FTP ERROR.  Could not get file"
    End If
    
    GetTblFile = True
    
    Exit Function
    
ErrorHandler:
    Screen.MousePointer = vbNormal
    msg = "An error occured while getting " & KCOD_NAME & vbCrLf _
                & "Number = " & Err.Number & vbCrLf _
                & "Description: " & Err.Description & vbCrLf
    RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
    GetTblFile = False
    
End Function

'***************************************************************************************************************
Function BackupTblFile() As Boolean
'***************************************************************************************************************
    Dim sFile As String
    Dim sDir As String
    Dim msg As String
    
    On Error GoTo ErrorHandler
    
    sFile = Dir(KCOD_PATH & "\" & KCOD_NAME)
    
    If (sFile <> "") Then
        sDir = Dir(TEMP_PATH & "\*")
        If (sDir = "") Then
            MkDir (TEMP_PATH)
        End If
        FileCopy KCOD_PATH & "\" & KCOD_NAME, TEMP_PATH & "\" & KCOD_NAME
    End If
    
    BackupTblFile = True
    
    Exit Function
    
ErrorHandler:
            
    msg = "An error occured while backing up " & KCOD_NAME & vbCrLf _
                & "Number = " & Err.Number & vbCrLf _
                & "Description: " & Err.Description & vbCrLf
        
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
    BackupTblFile = False
End Function



