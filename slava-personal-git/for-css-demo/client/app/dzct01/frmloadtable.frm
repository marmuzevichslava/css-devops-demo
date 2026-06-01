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
      MouseIcon       =   "frmloadtable.frx":030A
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
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel2 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            TextSave        =   ""
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
      EndProperty
      MouseIcon       =   "frmloadtable.frx":0326
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
Const XLT_LOG_PATH = "/sw/working/pvcs/cte/xltmap"
Const XLT_LOG_FILE = "cte_xlt.log"
Const DAT_LOG_PATH = "/sw/working/pvcs/cte/dat"
Const DAT_LOG_FILE = "cte_dat.log"
Const KCOD_PATH = "c:\dev\fnd32\data"
Const KCOD_NAME = "KCODF010.TBL"
Const XLT_WORKING_DIR = "c:\temp\cte_xlt"
Const DAT_WORKING_DIR = "c:\temp\cte_dat"
Const FILE_IN_LOG_ARG = 1
Const REV_NUM_ARG = 2
Const STAMP_ARG = 3
Const USER_ARG = 4
Const FILE_NAME_ARG = 9
Const TOTAL_STEPS = 10
Const TOTAL_STEPS_NO_DAT = 9
Const TOTAL_STEPS_NO_XLT = 7
Const TEMP_PATH = "c:\temp"
Const USER = "pvcs"
Const DAT_LOAD_EXE = "c:\dev\fnd32\bin\cdtupdat.exe"
Const MAP_LOAD_EXE = "c:\dev\fnd32\bin\mapload.exe"
Const MAP_LOAD_CFG = "c:\temp\mapload.cfg"
Const MAP_LOAD_LOG = "c:\temp\mapload.log"

Public sFTPParameter As String
Public sRemoteKcodFile As String
Public sLocalKcodFile As String
Public sArchiveKcodFile As String
Public sServer As String
Public sRemoteDatLogDir As String
Public sRemoteDatLogFile As String
Public sLocalDatLogFile As String
Public sLocalDatFile As String
Public sLocalXltLogFile As String
Public sRemoteXltLogDir As String
Public sRemoteXltLogFile As String
Public sLocalXltFile As String
Public sRevNum As String
Public sInputStamp As String
Public sInputUser As String
Public mywdj As New wdj
Public myftp As New FTP

'************************************************************
'**                       GetFTPParameters                 **
'************************************************************
Public Function GetFTPParameters()

    Dim strsql As String
    Dim msg As String
    Dim DaoRS As Recordset
  
    On Error GoTo SQLError
    
    'Find out what server the project resides on.
    strsql = "Select Value " _
           & "From tblFTPParameter"
             
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then
        sFTPParameter = DaoRS(0).Value
    Else
        Err.Raise 15, PutTblFile, "No more records in recordset."
    End If
    
    DaoRS.Close
    
    GetFTPParameters = True
    
    Exit Function
    
SQLError:
    GetFTPParameters = False
    msg = "An error occurred while trying to get the FTP parameter." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
End Function

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
    
    'Get Parameters for FTP functions.
    If Not GetFTPParameters Then
        Unload Me
        Exit Sub
    End If
    
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
        'Get all dats from remote server
        pBar.Value = pBar.Value + 1
        sbStatusBar.Panels(1).Text = "Downloading all codes tables"
        sbStatusBar.Refresh
        If Not GetCodesTables Then
            Unload Me
            Exit Sub
        End If

        'Load codes tables
        pBar.Value = pBar.Value + 1
        sbStatusBar.Panels(1).Text = "Loading dat's to " & KCOD_NAME
        sbStatusBar.Refresh
        If Not LoadCodesTables Then
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
Function InitializeSettings() As Boolean
'***************************************************************************************************************
    Dim mycodestable As New CodesTable
    Dim ctr As Integer
    Dim sFile As String
    Dim msg As String
    Dim RC As Integer
                    
    On Error GoTo ErrorHandler
    
    'Initialize Variables
    sRemoteKcodFile = "/sw/c1/" & cboProject.Text & "/client/" & cboEnvironment.Text & "/runtime/nt/codestbl/" & KCOD_NAME
    sLocalKcodFile = KCOD_PATH & "\" & KCOD_NAME
    sArchiveKcodFile = "/sw/c1/" & cboProject.Text & "/client/" & cboEnvironment.Text & "/runtime/nt/codestbl/" & KCOD_NAME & ".BAK"
    sRemoteDatLogDir = DAT_LOG_PATH & "/" & cboProject.Text & "/" & cboEnvironment.Text
    sRemoteDatLogFile = sRemoteDatLogDir & "/" & DAT_LOG_FILE
    sLocalDatLogFile = DAT_WORKING_DIR & "\" & DAT_LOG_FILE
    sLocalXltLogFile = XLT_WORKING_DIR & "\" & XLT_LOG_FILE
    sRemoteXltLogDir = XLT_LOG_PATH & "/" & cboProject.Text & "/" & cboEnvironment.Text
    sRemoteXltLogFile = sRemoteXltLogDir & "/" & XLT_LOG_FILE
               
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
        .Password = sFTPParameter
        .RemoteFile = sRemoteKcodFile
        .LocalFile = sLocalKcodFile
        .ErrorMessageBox = True
        .PutFile
    End With

    'Check to see if put was successful
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
Function LoadCodesTables() As Boolean
'***************************************************************************************************************
    Dim sFile As String
    Dim sKcodTime1 As Variant
    Dim sKcodTime2 As Variant
    Dim msg As String
    Dim sLine As String
    Dim RC As Integer
    Dim iFileNum As Integer
    Dim iFileNum2 As Integer
    Dim sCurDateTime As String
    Dim sDatLoadLogName As String
    Dim sRemoteDatLoadFile As String
    Dim sLoadStamp As String
    Dim sLoadLogFile As String
    Dim sTimestamp As String
    Dim sCurLoadDate As String
    Const LOAD_LOG_FILE = "datload.log"
    
    On Error GoTo ErrorHandler
    
    'Get current date and time for dat log archive file name.
    sCurDateTime = Now
    sTimestamp = Format(sCurDateTime, "yyyymmddhhmmss")

    sLoadLogFile = DAT_WORKING_DIR & "\" & LOAD_LOG_FILE

    iFileNum = FreeFile

    sFile = Dir(DAT_WORKING_DIR & "\*.dat")
    If sFile <> "" Then
        Do While sFile <> ""
            sKcodTime1 = FileDateTime(KCOD_PATH & "\" & KCOD_NAME)
            
            Sleep 2000
            
            'Load dat files
            With mywdj
                .Command = DAT_LOAD_EXE & " " & DAT_WORKING_DIR & "\" & sFile
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
            Else
                sLoadStamp = Now
                sCurLoadDate = Format(sLoadStamp, "d mmm yyyy hh:mm:ss")
                iFileNum = FreeFile
                Open sLocalDatLogFile For Input As iFileNum
                Do Until EOF(iFileNum)
                    Line Input #iFileNum, sLine
                    If (InStr(sLine, sFile) And Not InStr(sLine, "loaded")) Then
                        iFileNum2 = FreeFile
                        'Append load info. to input dat log.
                        Open sLoadLogFile For Append As iFileNum2
                        Print #iFileNum2, sLine & ",loaded by " & CurrentUser & " on " & sCurLoadDate
                        Close iFileNum2
                    End If
                Loop
                
                Close iFileNum
                
                sFile = Dir
            End If
        Loop
        
        sDatLoadLogName = Dir(sLoadLogFile)
        sRemoteDatLoadFile = DAT_LOG_PATH & "/" & cboProject.Text & "/" _
                        & cboEnvironment.Text & "/archive/" & sDatLoadLogName & "." & sTimestamp
               
        'FTP the datload.log to the UNIX server.
        With myftp
            .HostName = sServer
            .UserName = USER
            .Password = sFTPParameter
            .RemoteFile = sRemoteDatLoadFile
            .LocalFile = sLoadLogFile
            .ErrorMessageBox = True
            .PutFile
        End With
        
        'Check to see if put was successful
        If myftp.Error Then
            Err.Raise 1, , "FTP ERROR. Could not put " & sDatLoadLogName
        End If
        
        'Remove the remote input dat log file.
        With myftp
             .ErrorMessageBox = True
             .HostName = sServer
             .UserName = USER
             .Password = sFTPParameter
             .RemoteDirectory = sRemoteDatLogDir
             .RemoteFile = DAT_LOG_FILE & "*"
             .DeleteDirectory
        End With
                
        'Check to see if remove was successful.
        If myftp.Error Then
            Err.Raise 1, , "FTP ERROR. Could not delete " & sRemoteDatLogFile
        End If
        
        LoadCodesTables = True
        
    Else
        msg = "No dat files were found to be loaded." & vbCrLf _
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

    sFile = Dir(DAT_WORKING_DIR & "\*")
    Do While sFile <> ""
        Kill DAT_WORKING_DIR & "\" & sFile
        sFile = Dir
    Loop
    
    RmDir (DAT_WORKING_DIR)
    
    Exit Function
    
ErrorHandler:
    
    msg = "An error occured while loading codes tables. " & vbCrLf _
                & "Number = " & Err.Number & vbCrLf _
                & "Description: " & Err.Description & vbCrLf
        
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
    LoadCodesTables = False
    
End Function
'***************************************************************************************************************
Function GetCodesTables() As Boolean
'***************************************************************************************************************
    Dim sFile As String
    Dim msg As String
    Dim CurLine As String
    Dim sRemoteDatFile As String
    Dim sDatFileName As String
    Dim RC As Integer
    Dim iFileNum As Integer
            
    'Check to see if xlt working path exists.
    If (Dir(DAT_WORKING_DIR, vbDirectory) = "") Then
        MkDir (DAT_WORKING_DIR)
    End If
    
    sFile = Dir(DAT_WORKING_DIR)
    Do While sFile <> ""
        Kill DAT_WORKING_DIR & "\" & sFile
        sFile = Dir
    Loop
        
    'Get the dat log file from the remote server
    If Not GetDatLogFile Then
        Unload Me
        Exit Function
    End If
    
    If (Not Dir(sLocalDatLogFile, vbNormal) = "") Then
        'Open dat log file.
        iFileNum = FreeFile
        Open sLocalDatLogFile For Input As iFileNum
            
        'Priming read on dat log  file.
        Line Input #iFileNum, CurLine
    
        Do Until EOF(iFileNum)
        
            'Parse out the dat remote file path and name.
            sRemoteDatFile = ParseString(CurLine, ",", FILE_IN_LOG_ARG)
            sDatFileName = ParseString(sRemoteDatFile, "/", FILE_NAME_ARG)
            sLocalDatFile = DAT_WORKING_DIR & "\" & sDatFileName
                              
            On Error GoTo ErrorHandler
            
            'Get remote xltmap file.
            With myftp
                .HostName = sServer
                .UserName = USER
                .Password = sFTPParameter
                .RemoteFile = sRemoteDatFile
                .LocalFile = sLocalDatFile
                .ErrorMessageBox = True
                .GetFile
            End With
            
            If myftp.Error Then
                Err.Raise 1, , "FTP ERROR. Could not get " & sRemoteDatFile
            End If
                            
            'Get the next line.
            Line Input #iFileNum, CurLine
        Loop
        
        'Close input file.
        Close iFileNum
    End If
          
    GetCodesTables = True
        
    Exit Function
   
ErrorHandler:
    msg = "An error occured while getting codes tables." & vbCrLf _
                & "Number = " & Err.Number & vbCrLf _
                & "Description: " & Err.Description & vbCrLf
        
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
    
    sFile = Dir(DAT_WORKING_DIR & "\*")
    Do While sFile <> ""
        Kill DAT_WORKING_DIR & "\" & sFile
        sFile = Dir
    Loop
    
    RmDir (DAT_WORKING_DIR)
    
    GetCodesTables = False
End Function

'***************************************************************************************************************
Function GetDatLogFile() As Boolean
'***************************************************************************************************************
    Dim msg As String
    Dim RC As Integer
    Dim bCheckFlag As Boolean
    Dim iCtr As Integer
    Dim iFileNum As Integer
    Dim sFile As String
    
    iCtr = 1
    bCheckFlag = True
    
    'Get remote log file.
    With myftp
        .HostName = sServer
        .UserName = USER
        .Password = sFTPParameter
        .RemoteFile = sRemoteDatLogFile
        .LocalFile = sLocalDatLogFile
        .ErrorMessageBox = True
        .GetFile
    End With

    'Check to see if get was successful
    If myftp.Error Then
        msg = "FTP ERROR. Could not get dat log file from " & sServer & vbCrLf _
              & "Do you want to continue with process?" & vbCrLf
       
        Screen.MousePointer = vbNormal
        RC = MsgBox(msg, vbYesNo + vbQuestion, App.Title)
        If RC = vbYes Then
            GetDatLogFile = True
            Screen.MousePointer = vbHourglass
        Else
            GetDatLogFile = False
        End If
    Else
        'Open dat log file.
        iFileNum = FreeFile
        Open sLocalDatLogFile For Append As iFileNum
        
        'Print blank line so last valid line will be read.
        Print #iFileNum, ""
        
        Close iFileNum
               
        GetDatLogFile = True
    End If
         
End Function
'***************************************************************************************************************
Function LoadXltMaps() As Boolean
'***************************************************************************************************************
    Dim iFileNum As Integer
    Dim iFileNum2 As Integer
    Dim sFile As String
    Dim sCurDateTime As String
    Dim msg As String
    Dim RC As Integer
    Dim sLine As String
    Dim sNoExt As String
    Dim sRemoteMapLogFileName As String
    Dim sRemoteMapLog As String
    Dim sLoadStamp As String
    Dim sLoadLogFile As String
    Dim sMapLogFileName As String
    Dim sTimestamp As String
    Dim sCurLoadDate As String
    Dim bFound As Boolean
    Const LOAD_LOG_FILE = "mapload.log"
    
    On Error GoTo ErrorHandler
    
    'Get current date and time for xlt log archive file name.
    sCurDateTime = Now
    sTimestamp = Format(sCurDateTime, "yyyymmddhhmmss")
    
    sLoadLogFile = XLT_WORKING_DIR & "\" & LOAD_LOG_FILE

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
       
    sFile = Dir(XLT_WORKING_DIR & "\*.xlt")
    If sFile <> "" Then
        Do While sFile <> ""
            Print #iFileNum, XLT_WORKING_DIR & "\" & sFile
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
                
        sFile = Dir(XLT_WORKING_DIR & "\*.xlt")
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
                sLoadStamp = Now
                sCurLoadDate = Format(sLoadStamp, "d mmm yyyy hh:mm:ss")
                iFileNum = FreeFile
                Open sLocalXltLogFile For Input As iFileNum
                Do Until EOF(iFileNum)
                    Line Input #iFileNum, sLine
                    If (InStr(sLine, sFile) And Not InStr(sLine, "loaded")) Then
                        iFileNum2 = FreeFile
                        'Append load info. to input dat log.
                        Open sLoadLogFile For Append As iFileNum2
                        Print #iFileNum2, sLine & ",loaded by " & CurrentUser & " on " & sCurLoadDate
                        Close iFileNum2
                    End If
                Loop
                
                Close iFileNum
                           
                sFile = Dir
            End If
        Loop
        
        sMapLogFileName = Dir(sLoadLogFile)
        sRemoteMapLog = XLT_LOG_PATH & "/" & cboProject.Text & "/" _
                        & cboEnvironment.Text & "/archive/" & sMapLogFileName & "." & sTimestamp
               
        'FTP the mapload.log to the UNIX server.
        With myftp
            .HostName = sServer
            .UserName = USER
            .Password = sFTPParameter
            .RemoteFile = sRemoteMapLog
            .LocalFile = sLoadLogFile
            .ErrorMessageBox = True
            .PutFile
        End With
        
        'Check to see if put was successful
        If myftp.Error Then
            Err.Raise 1, , "FTP ERROR. Could not put " & sRemoteMapLog
        End If
        
        'Remove the remote input xlt log file.
        With myftp
             .ErrorMessageBox = True
             .HostName = sServer
             .UserName = USER
             .Password = sFTPParameter
             .RemoteDirectory = sRemoteXltLogDir
             .RemoteFile = XLT_LOG_FILE & "*"
             .DeleteDirectory
        End With
                
        'Check to see if remove was successful.
        If myftp.Error Then
            Err.Raise 1, , "FTP ERROR. Could not delete " & sRemoteXltLogFile
        End If
        
        LoadXltMaps = True
    Else
        Close iFileNum
        
        msg = "No xlt maps were found to be loaded." & vbCrLf _
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
  
    sFile = Dir(XLT_WORKING_DIR & "\*")
    Do While sFile <> ""
        Kill XLT_WORKING_DIR & "\" & sFile
        sFile = Dir
    Loop
    
    RmDir (XLT_WORKING_DIR)
    
    Exit Function

ErrorHandler:
        
    msg = "An error occured while loading xlt maps. " & vbCrLf _
                & "Number = " & Err.Number & vbCrLf _
                & "Description: " & Err.Description & vbCrLf
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
    LoadXltMaps = False
    
End Function
'***************************************************************************************************************
Function GetXltMaps() As Boolean
'***************************************************************************************************************
    Dim sFile As String
    Dim msg As String
    Dim CurLine As String
    Dim sRemoteXltFile As String
    Dim sXltFileName As String
    Dim RC As Integer
    Dim iFileNum As Integer
            
    'Check to see if xlt working path exists.
    'If not, then create it.  If yes, delete its contents.
    If (Dir(XLT_WORKING_DIR, vbDirectory) = "") Then
        MkDir (XLT_WORKING_DIR)
    End If
    
    sFile = Dir(XLT_WORKING_DIR & "\*")
    Do While sFile <> ""
        Kill XLT_WORKING_DIR & "\" & sFile
        sFile = Dir
    Loop
        
    'Get the xlt log file from the remote server
    If Not GetXltLogFile Then
        Unload Me
        Exit Function
    End If
    
    If (Not Dir(sLocalXltLogFile, vbNormal) = "") Then
        'Open xlt log file.
        iFileNum = FreeFile
        Open sLocalXltLogFile For Input As iFileNum
            
        'Priming read on xlt log  file.
        Line Input #iFileNum, CurLine
    
        Do Until EOF(iFileNum)
        
            'Parse out the xlt remote file path and name.
            sRemoteXltFile = ParseString(CurLine, ",", FILE_IN_LOG_ARG)
            sXltFileName = ParseString(sRemoteXltFile, "/", FILE_NAME_ARG)
            sLocalXltFile = XLT_WORKING_DIR & "\" & sXltFileName
                              
            On Error GoTo ErrorHandler
            
            'Get remote xltmap file.
            With myftp
                .HostName = sServer
                .UserName = USER
                .Password = sFTPParameter
                .RemoteFile = sRemoteXltFile
                .LocalFile = sLocalXltFile
                .ErrorMessageBox = True
                .GetFile
            End With
            
            If myftp.Error Then
                Err.Raise 1, , "FTP ERROR. Could not get " & sRemoteXltFile
            End If
                            
            'Get the next line.
            Line Input #iFileNum, CurLine
        Loop
        
        'Close input file.
        Close iFileNum
    End If
          
    GetXltMaps = True
        
    Exit Function
   
ErrorHandler:
    msg = "An error occured while getting xltmaps." & vbCrLf _
                & "Number = " & Err.Number & vbCrLf _
                & "Description: " & Err.Description & vbCrLf
        
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbCritical, "PROCESS STOPPED - " & App.Title)
    
    sFile = Dir(XLT_WORKING_DIR & "\*")
    Do While sFile <> ""
        Kill XLT_WORKING_DIR & "\" & sFile
        sFile = Dir
    Loop
    
    RmDir (XLT_WORKING_DIR)
    
    GetXltMaps = False
End Function

'***************************************************************************************************************
Function GetXltLogFile() As Boolean
'***************************************************************************************************************
    Dim msg As String
    Dim RC As Integer
    Dim bCheckFlag As Boolean
    Dim iCtr As Integer
    Dim iFileNum As Integer
    Dim sFile As String
    
    iCtr = 1
    bCheckFlag = True
    
    'Get remote log file.
    With myftp
        .HostName = sServer
        .UserName = USER
        .Password = sFTPParameter
        .RemoteFile = sRemoteXltLogFile
        .LocalFile = sLocalXltLogFile
        .ErrorMessageBox = True
        .GetFile
    End With

    'Check to see if get was successful
    If myftp.Error Then
        msg = "FTP ERROR. Could not get xlt log file from " & sServer & vbCrLf _
              & "Do you want to continue with process?" & vbCrLf
       
        Screen.MousePointer = vbNormal
        RC = MsgBox(msg, vbYesNo + vbQuestion, App.Title)
        If RC = vbYes Then
            GetXltLogFile = True
            Screen.MousePointer = vbHourglass
        Else
            GetXltLogFile = False
        End If
    Else
        'Open xlt log file.
        iFileNum = FreeFile
        Open sLocalXltLogFile For Append As iFileNum
        
        'Print blank line so last valid line will be read.
        Print #iFileNum, ""
        
        Close iFileNum
               
        GetXltLogFile = True
    End If
         
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
        .Password = sFTPParameter
        .RemoteFile = sRemoteKcodFile
        .LocalFile = sLocalKcodFile
        .ErrorMessageBox = True
        .GetFile
    End With

    'Check to see if get was successful
    If myftp.Error Then
        Err.Raise 1, , "FTP ERROR.  Could not get " & sRemoteKcodFile & "."
    End If

    With myftp
        .HostName = sServer
        .UserName = USER
        .Password = sFTPParameter
        .RemoteFile = sArchiveKcodFile
        .LocalFile = sLocalKcodFile
        .ErrorMessageBox = True
        .PutFile
    End With

    'Check to see if get was successful
    If myftp.Error Then
        Err.Raise 1, , "FTP ERROR.  Could not put " & sArchiveKcodFile & "."
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

