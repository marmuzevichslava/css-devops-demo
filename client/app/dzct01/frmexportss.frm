VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.2#0"; "comctl32.ocx"
Begin VB.Form frmExportSS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Create Spreadsheet"
   ClientHeight    =   4065
   ClientLeft      =   150
   ClientTop       =   435
   ClientWidth     =   5265
   Icon            =   "frmexportss.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4065
   ScaleWidth      =   5265
   StartUpPosition =   1  'CenterOwner
   Begin ComctlLib.ProgressBar pBar 
      Height          =   255
      Left            =   3480
      TabIndex        =   9
      Top             =   3840
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   450
      _Version        =   327680
      Appearance      =   0
   End
   Begin ComctlLib.StatusBar sbStatusBar 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   8
      Top             =   3810
      Width           =   5265
      _ExtentX        =   9287
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
   Begin VB.Frame Frame1 
      Caption         =   "Export Path"
      Height          =   2775
      Left            =   2160
      TabIndex        =   5
      Top             =   0
      Width           =   3015
      Begin VB.TextBox txtName 
         Height          =   285
         Left            =   120
         TabIndex        =   10
         Text            =   "CTExport.xls"
         Top             =   2400
         Width           =   2775
      End
      Begin VB.DirListBox Dir1 
         Height          =   2115
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   2775
      End
      Begin VB.DriveListBox Drive1 
         Height          =   315
         Left            =   2520
         TabIndex        =   6
         Top             =   120
         Visible         =   0   'False
         Width           =   390
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Options"
      Height          =   855
      Left            =   2160
      TabIndex        =   2
      Top             =   2880
      Width           =   3015
      Begin VB.OptionButton optSaveOpen 
         Caption         =   "Save to Disk and Open"
         Height          =   255
         Left            =   240
         TabIndex        =   4
         Top             =   480
         Width           =   2295
      End
      Begin VB.OptionButton optSave 
         Caption         =   "Save to Disk Only"
         Height          =   255
         Left            =   240
         TabIndex        =   3
         Top             =   240
         Width           =   2535
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "SelectTable(s) "
      Height          =   3735
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   1935
      Begin VB.ListBox SelectTable 
         Height          =   3375
         Left            =   120
         MultiSelect     =   2  'Extended
         Sorted          =   -1  'True
         TabIndex        =   1
         Top             =   240
         Width           =   1695
      End
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuProcess 
         Caption         =   "&Process"
         Shortcut        =   ^P
      End
      Begin VB.Menu mnuSpaces 
         Caption         =   "-"
      End
      Begin VB.Menu mnuClose 
         Caption         =   "&Close"
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
Attribute VB_Name = "frmExportSS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'***************************************************************************************************************
Private Sub Drive1_Change()
'***************************************************************************************************************
    Dir1.Path = Drive1.Drive
End Sub
'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    'Get the list of valid codes tables and add them to the combo box.
    Screen.MousePointer = vbHourglass
    
    strsql = "select TableName From tblTables"
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            SelectTable.AddItem DaoRS(0).Value
            DaoRS.MoveNext
        Wend
        DaoRS.Close
    End If
    
    Dir1.Path = "c:\data"
    
    optSave.Value = True
    
    sbStatusBar.Panels(1).Width = Me.Width * 0.64
    sbStatusBar.Panels(2).Width = Me.Width * 0.33
    sbStatusBar.Panels(1).Text = "Ready."
    pBar.Height = sbStatusBar.Height - 42
    pBar.Width = sbStatusBar.Panels(2).Width - 50
 
    pBar.Visible = False
    
    Screen.MousePointer = vbNormal
    
End Sub
'***************************************************************************************************************
Private Sub mnuClose_Click()
'***************************************************************************************************************
    Unload Me
End Sub
'***************************************************************************************************************
Private Sub mnuFind_Click()
'***************************************************************************************************************
    frmFindExportSS.Show
End Sub
'***************************************************************************************************************
Public Sub mnuProcess_Click()
'***************************************************************************************************************
    Dim xlApp As Object, xlTemplate As Object, objSpreadSheet As Object
    Dim Title As String
    Dim TblCnt As Integer, x As Integer, j As Integer, RC As Integer
    Dim sXls_Path As String
    Dim sXls_Name As String
    
    Const START_ROW = 13
    Const XLS_TEMP_NAME = "CTETemp.xls"
    
    sXls_Name = Me.txtName.Text
    
    FileName = Dir("n:\dzct01\CTExport.xls")
    If Len(FileName) <> 0 Then
         sXls_Path = "n:\dzct01\CTExport.xls"
    Else
         sXls_Path = "c:\dzct01\CTExport.xls"
    End If
    
    On Error GoTo FileCopyError
    
    If InStr(Len(Dir1.Path) - 1, Dir1.Path, "\") Then
        msg = "Invalid directory " & Dir1.Path & ".  Please select another path." & vbCrLf
        RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton, "Codes Table Explorer")
        Exit Sub
    End If

    Screen.MousePointer = vbHourglass
    
    FileCopy sXls_Path, Dir1.Path & "\" & sXls_Name
    
    On Error GoTo ExcelError
    
    Set xlApp = CreateObject("Excel.Application")
    Set xlTemplate = xlApp.Workbooks.Open(Dir1.Path & "\" & sXls_Name, , True, , "c1admin", "c1admin", True)
    
    Set objSpreadSheet = xlApp.ActiveWorkbook.ActiveSheet
    
    j = START_ROW
    
    On Error GoTo DatabaseError
    
    For x = 0 To frmExportSS.SelectTable.ListCount - 1
        If (frmExportSS.SelectTable.Selected(x) = True) Then
    
            sbStatusBar.Panels(1).Text = "Initializing " & Me.SelectTable.List(x) & "..."
            sbStatusBar.Refresh
            
            strsql = "SELECT * from tblTables where TableName = " & _
                      Chr(34) & frmExportSS.SelectTable.List(x) & Chr(34)
    
            Set TableSet = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
            If Not IsEmpty(TableSet!TableName) Then
    
                ' Export all the entries of the current table
                Select Case TableSet!TableType  ' Type of Table defines the export
                    Case 1  ' Export regular Entries
                        strsql = "SELECT DISTINCTROW tblEntries.Key, tblEntries.Decode, tblClients.Client " _
                                & " FROM (tblEntries INNER JOIN tblClients ON tblEntries.Client = tblClients.Code) " _
                                & " WHERE ((tblEntries.TableName) = " & Chr(34) & frmExportSS.SelectTable.List(x) & Chr(34) & ")" _
                                & " ORDER BY tblEntries.Key;"
                    Case 2  ' Export Msg Box Entries
                        strsql = "SELECT DISTINCTROW tblMsgBoxEntries.Code, tblMsgBoxEntries.MsgBoxText, tblClients.Client, tblMsgBoxButtons.Buttons, tblMsgBoxIcons.Icon, tblMsgBoxDefaultButtons.[Defualt Button]" _
                                & " FROM ((((tblMsgBoxEntries INNER JOIN tblMsgBoxButtons ON tblMsgBoxEntries.Buttons = tblMsgBoxButtons.[Button ID]) INNER JOIN tblMsgBoxDefaultButtons ON tblMsgBoxEntries.DefaultButton = tblMsgBoxDefaultButtons.[Default Button ID]) INNER JOIN tblMsgBoxIcons ON tblMsgBoxEntries.Icon = tblMsgBoxIcons.[Icon ID])INNER JOIN tblClients ON tblMsgBoxEntries.Client = tblClients.Code) " _
                                & " Where ((tblMsgBoxEntries.TableName) = " & Chr(34) & frmExportSS.SelectTable.List(x) & Chr(34) & ")" _
                                & " ORDER BY tblMsgBoxEntries.Code;"
                    Case 3  ' Export User Codes for WES map
                        strsql = "SELECT DISTINCTROW tblUserErrorMsgEntries.ErrorNumber, tblUserErrorMsgEntries.ErrorCode, tblClients.Client" _
                                & " FROM (tblUserErrorMsgEntries INNER JOIN tblClients ON tblUserErrorMsgEntries.Client = tblClients.Code) " _
                                & " Where ((tblUserErrorMsgEntries.TableName) = " & Chr(34) & frmExportSS.SelectTable.List(x) & Chr(34) & ")" _
                                & " ORDER BY tblUserErrorMsgEntries.ErrorNumber;"
                    Case Else
                        msg = "Table name '" & TableSet!TableName & "' has invalid type: " & TableSet!TableType
                        MsgBox msg
                        RetVal = MessageBox(frmExportTable.hwnd, _
                                            msg, _
                                            "Codes Table Update", _
                                            MB_OK Or MB_ICONHAND)
                End Select
                          
                Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
                
                If Not DaoRS.EOF Then
                    TblCnt = 0
                    While Not DaoRS.EOF
                        TblCnt = TblCnt + 1
                        DaoRS.MoveNext
                    Wend
                Else
                    msg = "No codes exist for " & Me.SelectTable.List(x) & "." & vbCrLf
                    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton, "Codes Table Explorer")
                End If
                
                DaoRS.Close
                
                Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
                
                If Not DaoRS.EOF Then
                    sbStatusBar.Panels(1).Text = "Exporting " & Me.SelectTable.List(x) & "..."
                    sbStatusBar.Refresh
                    pBar.Visible = True
                    With pBar
                        .Max = TblCnt
                        .Min = 0
                        .Value = 0
                    End With
                    While Not DaoRS.EOF
                        pBar.Value = pBar.Value + 1
                        objSpreadSheet.Cells(j, 1).Value = Me.SelectTable.List(x)
                        objSpreadSheet.Cells(j, 2).Value = RTrim(DaoRS(0).Value)
                        objSpreadSheet.Cells(j, 3).Value = RTrim(DaoRS(1).Value)
                        objSpreadSheet.Cells(j, 4).Value = RTrim(DaoRS(1).Value)
                        objSpreadSheet.Cells(j, 5).Value = RTrim(DaoRS(2).Value)
                        objSpreadSheet.Cells(j, 6).Value = "Change"
                        If TableSet!TableType = 2 Then
                            objSpreadSheet.Cells(j, 8).Value = RTrim(DaoRS(3).Value)
                            objSpreadSheet.Cells(j, 9).Value = RTrim(DaoRS(3).Value)
                            objSpreadSheet.Cells(j, 10).Value = RTrim(DaoRS(3).Value)
                        End If
                        j = j + 1
                        DaoRS.MoveNext
                    Wend
                End If
            End If
        End If
    Next
    
    DaoRS.Close
    
    If optSave = True Then
        FileName = Dir(Dir1.Path & "\" & XLS_TEMP_NAME)
        If Len(FileName) <> 0 Then
            Kill Dir1.Path & "\" & XLS_TEMP_NAME
        End If
        
        xlTemplate.SaveAs Dir1.Path & "\" & XLS_TEMP_NAME
        xlApp.Quit
        
        Kill Dir1.Path & "\" & sXls_Name
        Name Dir1.Path & "\" & XLS_TEMP_NAME As Dir1.Path & "\" & sXls_Name
        
        Title = "Successful Export"
        MsgLine = "Successfully created " & Dir1.Path & "\" & sXls_Name
        MsgBox MsgLine, 64, Title
    Else
        xlApp.Visible = True
    End If

    Set xlApp = Nothing
    Set xlTemplate = Nothing
    Set objSpreadSheet = Nothing
    
    With pBar
        .Min = 0
        .Value = 0
    End With
    
    pBar.Visible = False
    sbStatusBar.Panels(1).Text = "Ready."
    sbStatusBar.Refresh
    
    Screen.MousePointer = vbNormal
    
    Exit Sub
    
FileCopyError:
    
    msg = "An error has occured while copying " & sXls_Path & " to " & Dir1.Path & "\" & sXls_Name & "." & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    
    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
    Err.Clear

    Screen.MousePointer = vbNormal
    
    Exit Sub
    
ExcelError:
   
    msg = "An error has occured while writing to " & Dir1.Path & "\" & sXls_Name & "." & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    
    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
    Err.Clear

    Screen.MousePointer = vbNormal
        
    Exit Sub

DatabaseError:
    
    msg = "An error has occured while the database is open." & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    
    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
    Err.Clear

    Screen.MousePointer = vbNormal
    
    Exit Sub

End Sub

Private Sub txtName_LostFocus()
    If InStr(txtName.Text, "\") Or InStr(txtName.Text, " ") Then
        msg = "Invalid file name. Make sure it does not a space or slash." & vbCrLf & _
                "Contact " & AUTHOR & " for assistance."
        
        RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
    
        Me.txtName.SetFocus
        
    End If
End Sub
