VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.1#0"; "COMDLG32.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.2#0"; "comctl32.ocx"
Begin VB.Form frmInsertTbl 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Insert SIR Data"
   ClientHeight    =   3885
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5940
   Icon            =   "frmInsertTbl.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3885
   ScaleWidth      =   5940
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin ComctlLib.ProgressBar ImportProgressBar 
      Height          =   315
      Left            =   -75
      TabIndex        =   4
      Top             =   3600
      Visible         =   0   'False
      Width           =   6015
      _ExtentX        =   10610
      _ExtentY        =   556
      _Version        =   327680
      Appearance      =   1
      MouseIcon       =   "frmInsertTbl.frx":030A
   End
   Begin ComctlLib.StatusBar stbInsert 
      Align           =   2  'Align Bottom
      Height          =   240
      Left            =   0
      TabIndex        =   3
      Top             =   3645
      Width           =   5940
      _ExtentX        =   10478
      _ExtentY        =   423
      SimpleText      =   ""
      ShowTips        =   0   'False
      _Version        =   327680
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            AutoSize        =   1
            Object.Width           =   10425
            TextSave        =   ""
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
      EndProperty
      MouseIcon       =   "frmInsertTbl.frx":0326
   End
   Begin MSComDlg.CommonDialog ComDlg 
      Left            =   750
      Top             =   3000
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   327680
   End
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
      Left            =   3030
      TabIndex        =   2
      Top             =   3090
      Width           =   1215
   End
   Begin VB.CommandButton cmdSubmit 
      Caption         =   "&Submit"
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
      Left            =   1590
      TabIndex        =   1
      ToolTipText     =   "Submit the current import file"
      Top             =   3090
      Width           =   1215
   End
   Begin ComctlLib.ListView lvSIRData 
      Height          =   2160
      Left            =   150
      TabIndex        =   0
      Top             =   150
      Width           =   5655
      _ExtentX        =   9975
      _ExtentY        =   3810
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      _Version        =   327680
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      MouseIcon       =   "frmInsertTbl.frx":0342
      NumItems        =   0
   End
   Begin VB.Label lblImportFile 
      Height          =   240
      Left            =   1275
      TabIndex        =   6
      Top             =   2550
      Width           =   4365
   End
   Begin VB.Label Label1 
      Caption         =   "Import File:"
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
      Top             =   2550
      Width           =   1065
   End
End
Attribute VB_Name = "frmInsertTbl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public xlsFile As String
Public iTotalRec As Integer
Public bCancel As Boolean
Public bRunning As Boolean

Const COL_TABLE As Integer = 0
Const COL_KEY As Integer = 1
Const COL_DECODE As Integer = 2
Const COL_CLIENT As Integer = 3
Const COL_METHOD As Integer = 4
Const COL_COMMENTS As Integer = 5
Const COL_BUTTONS As Integer = 6
Const COL_ICONS As Integer = 7
Const COL_DEF_BUTTON As Integer = 8

Const TEMPLATE_STARTING_ROW As Integer = 13

'***************************************************************************************************************
Private Sub cmdCancel_Click()
'***************************************************************************************************************
    
    If bRunning Then
        bCancel = True
    Else
        Unload Me
    End If
End Sub



'***************************************************************************************************************
Private Sub cmdSubmit_Click()
'***************************************************************************************************************
    Dim RC As Integer, x As Integer, hClient As String, hDesc As String, hDecode As String, hComments As String
    Dim bBadClient As Boolean, hButton As Integer, hIcon As Integer, hDefButton As Integer
    
    RC = MessageBox(Me.hwnd, _
                    "Are you sure you wish to import the displayed Key(s)?", _
                    "Codes Table Explorer", _
                    MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON1)
    
    Me.Refresh
    
    
    If (RC = IDYES) Then
            
        'Set up the error handling
        On Error GoTo DAOError
            
    
        Screen.MousePointer = vbHourglass
        bRunning = True
        
        ReDim ImportErrArray(0)
         
        stbInsert.Visible = False
        ImportProgressBar.Visible = True
        
        ImportProgressBar.Max = iTotalRec
        ImportProgressBar.Min = 0
        ImportProgressBar.Value = 0
        Me.Refresh
        
        'Begin a new transaction.
        wsCTM.BeginTrans
        
        ImportCntr = 0
        
        'Loop down the list box inserting each record into the table.
        For x = 1 To lvSIRData.ListItems.Count
            
            'Check to see if there is a description.
            If (lvSIRData.ListItems.Item(x).SubItems(COL_COMMENTS) = "") Then
                hComments = "Added on " & Date & " - " & Time & " by " & UCase(CurrentUser)
            Else
                hComments = lvSIRData.ListItems.Item(x).SubItems(COL_COMMENTS)
            End If
            
            
            'Check to see if there are any single quotes in the decode.
            hDecode = FormatDecode(lvSIRData.ListItems.Item(x).SubItems(COL_DECODE))
            
            
            'Get the client code using the client decode.
            hClient = GetClientDecode(lvSIRData.ListItems.Item(x).SubItems(COL_CLIENT))
            If (hClient = SQL_NOT_FOUND) Then bBadClient = True
            
            
            'If this is an add, use the insert method, otherwise it's an update.
            If (UCase(Left(lvSIRData.ListItems.Item(x).SubItems(COL_METHOD), 1)) = "A") Then
                
                '*******************************************************************************
                '**  ADD - TYPICAL CODES TABLE                                                **
                '*******************************************************************************
                If (Left(lvSIRData.ListItems.Item(x).Text, 3) = "CIS") Then
                    
                    strSQL = "INSERT INTO tblEntries (TableName, Key, Decode, Client, Comments) VALUES (" & _
                              Chr(39) & lvSIRData.ListItems.Item(x).Text & Chr(39) & ", " & _
                              Chr(39) & lvSIRData.ListItems.Item(x).SubItems(COL_KEY) & Chr(39) & ", " & _
                              Chr(39) & hDecode & Chr(39) & ", " & _
                              hClient & ", " & _
                              Chr(39) & hComments & Chr(39) & ");"
                    
                '*******************************************************************************
                '**  ADD - USER DEFINED MESSAGE BOX                                           **
                '*******************************************************************************
                ElseIf (UCase(lvSIRData.ListItems.Item(x).Text) = "C1CMBMSG") Then
                    
                    'Create the SQL to perform the insert.
                    strSQL = "INSERT INTO tblMsgBoxEntries (TableName, Code, MsgBoxText, Client, " & _
                             "Comments, Buttons, Icon, DefaultButton) VALUES (" & _
                              Chr(39) & lvSIRData.ListItems.Item(x).Text & Chr(39) & ", " & _
                              Val(lvSIRData.ListItems.Item(x).SubItems(COL_KEY)) & ", " & _
                              Chr(39) & hDecode & Chr(39) & ", " & _
                              hClient & ", " & _
                              Chr(39) & hComments & Chr(39) & ", " & _
                              GetButtonCode(lvSIRData.ListItems.Item(x).SubItems(COL_BUTTONS)) & ", " & _
                              GetIconCode(lvSIRData.ListItems.Item(x).SubItems(COL_ICONS)) & ", " & _
                              GetDefaultButtonCode(lvSIRData.ListItems.Item(x).SubItems(COL_DEF_BUTTON)) & ");"
                
                '*******************************************************************************
                '**  ADD - WES ERROR MESSAGE                                                  **
                '*******************************************************************************
                ElseIf (UCase(lvSIRData.ListItems.Item(x).Text) = "UERRMSGS") Then
                    strSQL = "INSERT INTO tblUserErrorMsgEntries (TableName, ErrorNumber, " & _
                             "ErrorCode, Client, Coments, SequenceNumber) VALUES (" & _
                             Chr(39) & lvSIRData.ListItems.Item(x).Text & Chr(39) & ", " & _
                             Val(lvSIRData.ListItems.Item(x).SubItems(COL_KEY)) & ", " & _
                             Chr(39) & hDecode & Chr(39) & ", " & _
                             hClient & ", " & _
                             Chr(39) & hComments & Chr(39) & ", 1);"
                End If


            ElseIf (UCase(Left(lvSIRData.ListItems.Item(x).SubItems(COL_METHOD), 1)) = "C") Then
                
                '*******************************************************************************
                '**  CHANGE - TYPICAL CODES TABLE                                             **
                '*******************************************************************************
                If (Left(lvSIRData.ListItems.Item(x).Text, 3) = "CIS") Then
                    strSQL = "UPDATE tblEntries SET " & _
                             "TableName = " & Chr(39) & lvSIRData.ListItems.Item(x).Text & Chr(39) & ", " & _
                             "Key = " & Chr(39) & lvSIRData.ListItems.Item(x).SubItems(COL_KEY) & Chr(39) & ", " & _
                             "Decode = " & Chr(39) & hDecode & Chr(39) & ", " & _
                             "Client = " & hClient & ", " & _
                             "Description = " & Chr(39) & "Updated on " & Date & " - " & Time & " by " & UCase(CurrentUser) & Chr(39) & ", " & _
                             "Comments = " & Chr(39) & lvSIRData.ListItems.Item(x).SubItems(COL_COMMENTS) & Chr(39) & _
                             " WHERE TableName = " & Chr(39) & lvSIRData.ListItems.Item(x).Text & Chr(39) & _
                             " AND Key = " & Chr(39) & lvSIRData.ListItems.Item(x).SubItems(COL_KEY) & Chr(39) & _
                             " AND Client = " & hClient
                             
                
                '*******************************************************************************
                '**  CHANGE - USER DEFINED MESSAGE BOX                                        **
                '*******************************************************************************
                ElseIf (UCase(lvSIRData.ListItems.Item(x).Text) = "C1CMBMSG") Then
                    
                    strSQL = "UPDATE tblMsgBoxEntries SET " & _
                             "TableName = " & Chr(39) & lvSIRData.ListItems.Item(x).Text & Chr(39) & ", " & _
                             "Code = " & Val(lvSIRData.ListItems.Item(x).SubItems(COL_KEY)) & ", " & _
                             "MsgBoxText = " & Chr(39) & hDecode & Chr(39) & ", " & _
                             "Client = " & hClient & ", " & _
                             "Comments = " & Chr(39) & lvSIRData.ListItems.Item(x).SubItems(COL_COMMENTS) & Chr(39) & ", " & _
                             "Buttons = " & GetButtonCode(lvSIRData.ListItems.Item(x).SubItems(COL_BUTTONS)) & ", " & _
                             "Icon = " & GetIconCode(lvSIRData.ListItems.Item(x).SubItems(COL_ICONS)) & ", " & _
                             "DefaultButton = " & GetDefaultButtonCode(lvSIRData.ListItems.Item(x).SubItems(COL_DEF_BUTTON)) & _
                             " WHERE TableName = " & Chr(39) & lvSIRData.ListItems.Item(x).Text & Chr(39) & _
                             " AND Code = " & Val(lvSIRData.ListItems.Item(x).SubItems(COL_KEY)) & _
                             " AND Client = " & hClient
                    
                '*******************************************************************************
                '**  CHANGE - WES ERROR MESSAGE                                               **
                '*******************************************************************************
                ElseIf (UCase(lvSIRData.ListItems.Item(x).Text) = "UERRMSGS") Then
                    
                    strSQL = "UPDATE tblUserErrorMsgEntries SET " & _
                             "TableName = " & Chr(39) & lvSIRData.ListItems.Item(x).Text & Chr(39) & ", " & _
                             "ErrorNumber = " & Val(lvSIRData.ListItems.Item(x).SubItems(COL_KEY)) & ", " & _
                             "ErrorCode = " & Chr(39) & hDecode & Chr(39) & ", " & _
                             "Client = " & hClient & ", " & _
                             "Coments = " & Chr(39) & lvSIRData.ListItems.Item(x).SubItems(COL_COMMENTS) & Chr(39) & _
                             " WHERE TableName = " & Chr(39) & lvSIRData.ListItems.Item(x).Text & Chr(39) & _
                             " AND ErrorNumber = " & Val(lvSIRData.ListItems.Item(x).SubItems(COL_KEY)) & _
                             " AND Client = " & hClient
                End If
            
            ElseIf (UCase(Left(lvSIRData.ListItems.Item(x).SubItems(COL_METHOD), 1)) = "D") Then
                
                '*******************************************************************************
                '**  DELETE - TYPICAL CODES TABLE                                             **
                '*******************************************************************************
                If (Left(lvSIRData.ListItems.Item(x).Text, 3) = "CIS") Then
                    strSQL = "DELETE FROM tblEntries WHERE TableName = " & _
                             Chr(39) & lvSIRData.ListItems.Item(x).Text & Chr(39) & _
                             " AND Key = " & Chr(39) & lvSIRData.ListItems.Item(x).SubItems(COL_KEY) & Chr(39) & _
                             " AND Client = " & hClient
                
                '*******************************************************************************
                '**  DELETE - USER DEFINED MESSAGE BOX                                        **
                '*******************************************************************************
                ElseIf (UCase(lvSIRData.ListItems.Item(x).Text) = "C1CMBMSG") Then
                    strSQL = "DELETE FROM tblMsgBoxEntries WHERE TableName = " & _
                             Chr(39) & lvSIRData.ListItems.Item(x).Text & Chr(39) & _
                             " AND Code = " & Val(lvSIRData.ListItems.Item(x).SubItems(COL_KEY)) & _
                             " AND Client = " & hClient
                
                '*******************************************************************************
                '**  DELETE - WES ERROR MESSAGE                                               **
                '*******************************************************************************
                ElseIf (UCase(lvSIRData.ListItems.Item(x).Text) = "UERRMSGS") Then
                    strSQL = "DELETE FROM tblUserErrorMsgEntries WHERE TableName = " & Chr(39) & lvSIRData.ListItems.Item(x).Text & Chr(39) & _
                             " AND ErrorNumber = " & Val(lvSIRData.ListItems.Item(x).SubItems(COL_KEY)) & _
                             " AND Client = " & hClient
                End If
       
            End If
            
            
            If (Not bBadClient) Then
            
                Debug.Print strSQL
            
                'Execute the SQL.
                dbCTM.Execute strSQL
            
            
                'Update the progress bar.
                ImportProgressBar.Value = ImportCntr
                Me.Refresh
            
            
                'Check the number of affected rows.
                If (dbCTM.RecordsAffected = 1) Then
                    ImportCntr = ImportCntr + 1
                Else
                    ImportErrArray(UBound(ImportErrArray)).Table = lvSIRData.ListItems.Item(x).Text
                    ImportErrArray(UBound(ImportErrArray)).Key = lvSIRData.ListItems.Item(x).SubItems(COL_KEY)
                    ImportErrArray(UBound(ImportErrArray)).Decode = hDecode
                    ImportErrArray(UBound(ImportErrArray)).Client = UCase(lvSIRData.ListItems.Item(x).SubItems(COL_CLIENT))
                    ImportErrArray(UBound(ImportErrArray)).Action = UCase(Left(lvSIRData.ListItems.Item(x).SubItems(COL_METHOD), 1))
                    ReDim Preserve ImportErrArray(UBound(ImportErrArray) + 1)
                End If
            Else
                ImportErrArray(UBound(ImportErrArray)).Table = lvSIRData.ListItems.Item(x).Text
                ImportErrArray(UBound(ImportErrArray)).Key = lvSIRData.ListItems.Item(x).SubItems(COL_KEY)
                ImportErrArray(UBound(ImportErrArray)).Decode = hDecode
                ImportErrArray(UBound(ImportErrArray)).Client = UCase(lvSIRData.ListItems.Item(x).SubItems(COL_CLIENT))
                ImportErrArray(UBound(ImportErrArray)).Action = UCase(Left(lvSIRData.ListItems.Item(x).SubItems(COL_METHOD), 1))
                ReDim Preserve ImportErrArray(UBound(ImportErrArray) + 1)
                bBadClient = False
            End If
        
            'Process any window level events
            DoEvents
            
            'Check to see if the cancel button was pressed.
            If bCancel Then
                RC = MessageBox(Me.hwnd, _
                                "Are you sure you want to cancel?", _
                                "Codes Table Explorer", _
                                MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON1)
                If (RC = IDYES) Then
                    wsCTM.Rollback
                    Screen.MousePointer = vbNormal
                    Exit For
                End If
            End If
        
        Next
        
        
        ImportProgressBar.Value = ImportProgressBar.Max
        Screen.MousePointer = vbNormal
        Me.Refresh
        
        If Not bCancel Then frmImportStatus.Show vbModal
    End If
    
    Unload Me


Exit Sub

DAOError:
    Dim msg As String
    msg = "An error occured" & vbCrLf & "Number = " & Err.Number & vbCrLf & "Description: " & Err.Description & vbCrLf
    Screen.MousePointer = vbNormal
    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
    Unload Me
   
End Sub


'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    Dim x As Integer, itmX As ListItem
    Dim xlApp As Object, objSS As Object, objSpreadSheet As Object
    
    
    
    bCloseImport = False
    bCancel = False
    bRunning = False
    iTotalRec = 0
    Me.Caption = "Import SIR Data"
    
    'Add the column headers
    lvSIRData.ColumnHeaders.Add , , "Table", 800, 0
    lvSIRData.ColumnHeaders.Add , , "Key", 800, 0
    lvSIRData.ColumnHeaders.Add , , "Decode", 1500, 0
    lvSIRData.ColumnHeaders.Add , , "Client", 800, 0
    lvSIRData.ColumnHeaders.Add , , "Add/Change/Delete", 1500, 0
    lvSIRData.ColumnHeaders.Add , , "Comments", 3000, 0
    lvSIRData.ColumnHeaders.Add , , "Button(s)", 1000, 0
    lvSIRData.ColumnHeaders.Add , , "Icon", 1000, 0
    lvSIRData.ColumnHeaders.Add , , "Default Button", 1000, 0
    
    Me.Show
    Me.Refresh
    
    'Display the file open dialog.
    On Error GoTo ErrComDlg
    ComDlg.CancelError = True
    ComDlg.DialogTitle = "Import SIR Spreadsheet..."
    ComDlg.Filter = "Excel Spreadsheet|*.xls"
    ComDlg.Flags = cdlOFNHideReadOnly
    ComDlg.ShowOpen
    
    Me.Visible = True
    
    'Update the name of the file on the form.
    lblImportFile.Caption = LongDirFix(ComDlg.FileName, 32)
    
    Screen.MousePointer = vbHourglass
    Me.Refresh
    
    'Open the spreadsheet
    If Not (bCloseImport) Then
        
        'Open up the excel object.
        'Set xlApp = CreateObject("Excel.Application")
        
        'Get the filename.
        xlsFile = ComDlg.FileName
    
        Set objSS = GetObject(xlsFile)
        'Set objSS = xlApp.Workbooks.Open(xlsFile, , True, , "c1admin", "c1admin", True)
        'Set objSpreadSheet = xlApp.ActiveWorkbook.ActiveSheet

        stbInsert.Panels(1).Text = "Reading Excel Workbook..."
        Me.Refresh

        'Loop down the spreadsheet until there are no more Keys.
        x = TEMPLATE_STARTING_ROW
        
        
        While Not (objSS.Cells(x, 1).Value = "")
        'While Not (objSpreadSheet.Cells(x, 1).Value = "")
            
            'Add the table name into the first column of the list view.
            Set itmX = lvSIRData.ListItems.Add(, , RTrim(CStr(objSS.Cells(x, 1).Value)))
                
                'Add the remaining data into the other cells.
                itmX.SubItems(COL_KEY) = LTrim(RTrim(CStr(objSS.Cells(x, 2).Value)))
                itmX.SubItems(COL_DECODE) = LTrim(RTrim(CStr(objSS.Cells(x, 3).Value)))
                itmX.SubItems(COL_CLIENT) = LTrim(RTrim(CStr(objSS.Cells(x, 4).Value)))
                itmX.SubItems(COL_METHOD) = LTrim(RTrim(CStr(objSS.Cells(x, 5).Value)))
                itmX.SubItems(COL_COMMENTS) = LTrim(RTrim(CStr(objSS.Cells(x, 6).Value)))
                itmX.SubItems(COL_BUTTONS) = LTrim(RTrim(CStr(objSS.Cells(x, 7).Value)))
                itmX.SubItems(COL_ICONS) = LTrim(RTrim(CStr(objSS.Cells(x, 8).Value)))
                itmX.SubItems(COL_DEF_BUTTON) = LTrim(RTrim(CStr(objSS.Cells(x, 9).Value)))
            
            x = x + 1
            iTotalRec = iTotalRec + 1
               
        Wend
    
        Set objSS = Nothing
        
        'Free up the memory of excel.
        'Set objSS = Nothing
        'Set objSpreadSheet = Nothing
        'Set xlApp = Nothing
        
        
        
        'Enable the submit button.
        cmdSubmit.Enabled = True
        
    End If
    
    
    Screen.MousePointer = vbNormal
    
    'Update the total displayed in the status bar.
    If iTotalRec = 0 Then iTotalRec = 1
    stbInsert.Panels(1).Text = "Total Number of Records = " & iTotalRec
    
    
Exit Sub

ErrComDlg:
    bCloseImport = True
    Resume Next
End Sub


