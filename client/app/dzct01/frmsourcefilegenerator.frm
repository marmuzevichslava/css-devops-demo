VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.1#0"; "comdlg32.ocx"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.2#0"; "comctl32.ocx"
Begin VB.Form frmSourceFileGenerator 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "CUV Source File Generator"
   ClientHeight    =   4590
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7140
   Icon            =   "frmSourceFileGenerator.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4590
   ScaleWidth      =   7140
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin MSComDlg.CommonDialog ComDlg 
      Left            =   2925
      Top             =   3375
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   327680
   End
   Begin VB.CommandButton pbExit 
      Caption         =   "E&xit"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   465
      Left            =   5363
      TabIndex        =   10
      Top             =   3975
      Width           =   1590
   End
   Begin VB.CommandButton pbGenerate 
      Caption         =   "&Generate"
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
      Height          =   465
      Left            =   3638
      TabIndex        =   9
      Top             =   3975
      Width           =   1590
   End
   Begin VB.CommandButton pbValues 
      Caption         =   "&Multiple Values"
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
      Height          =   465
      Left            =   1913
      TabIndex        =   8
      Top             =   3975
      Width           =   1590
   End
   Begin VB.CommandButton pbAbbreviated 
      Caption         =   "Create &Variables"
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
      Height          =   465
      Left            =   188
      TabIndex        =   11
      Top             =   3975
      Width           =   1590
   End
   Begin VB.Frame Frame2 
      Caption         =   "File Options"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   765
      Left            =   3825
      TabIndex        =   21
      Top             =   2925
      Width           =   3165
      Begin VB.OptionButton optCobolOutput 
         Caption         =   "Cobol Copybook"
         Height          =   195
         Left            =   1575
         TabIndex        =   7
         Top             =   300
         Value           =   -1  'True
         Width           =   1515
      End
      Begin VB.OptionButton optCOutput 
         Caption         =   "C Include File"
         Height          =   240
         Left            =   150
         TabIndex        =   6
         Top             =   300
         Width           =   1290
      End
   End
   Begin VB.TextBox efCUVFile 
      BackColor       =   &H0000FFFF&
      Height          =   285
      Left            =   1125
      TabIndex        =   5
      Top             =   3450
      Width           =   1290
   End
   Begin VB.TextBox efPath 
      BackColor       =   &H0000FFFF&
      Height          =   285
      Left            =   1125
      TabIndex        =   4
      Top             =   3000
      Width           =   2490
   End
   Begin ComctlLib.ListView lvSrcGenerate 
      Height          =   1365
      Left            =   150
      TabIndex        =   18
      TabStop         =   0   'False
      Top             =   1425
      Width           =   6840
      _ExtentX        =   12065
      _ExtentY        =   2408
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      _Version        =   327680
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      MouseIcon       =   "frmSourceFileGenerator.frx":030A
      NumItems        =   0
   End
   Begin VB.Frame Frame1 
      Caption         =   "Data Element"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1140
      Left            =   150
      TabIndex        =   12
      Top             =   150
      Width           =   6840
      Begin VB.CheckBox cbSigned 
         Alignment       =   1  'Right Justify
         Caption         =   "Signed:"
         Enabled         =   0   'False
         Height          =   240
         Left            =   5775
         TabIndex        =   1
         Top             =   300
         Width           =   915
      End
      Begin VB.ComboBox cboComp 
         Enabled         =   0   'False
         Height          =   315
         Left            =   4800
         Style           =   2  'Dropdown List
         TabIndex        =   3
         ToolTipText     =   "Types available for integer elements"
         Top             =   675
         Width           =   1890
      End
      Begin VB.TextBox Length 
         BackColor       =   &H8000000F&
         BorderStyle     =   0  'None
         Height          =   315
         Left            =   5040
         Locked          =   -1  'True
         TabIndex        =   16
         TabStop         =   0   'False
         Top             =   270
         Width           =   690
      End
      Begin VB.ComboBox cboDataType 
         Height          =   315
         Left            =   1320
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   675
         Width           =   1770
      End
      Begin VB.TextBox DataElement 
         BackColor       =   &H0000FFFF&
         Height          =   315
         Left            =   1320
         TabIndex        =   0
         Top             =   263
         Width           =   2490
      End
      Begin VB.Label lblIntType 
         Alignment       =   1  'Right Justify
         Caption         =   "Integer Type:"
         Enabled         =   0   'False
         Height          =   240
         Left            =   3675
         TabIndex        =   17
         Top             =   750
         Width           =   990
      End
      Begin VB.Label Label7 
         Alignment       =   1  'Right Justify
         Caption         =   "Length:"
         Height          =   240
         Left            =   4290
         TabIndex        =   15
         Top             =   300
         Width           =   615
      End
      Begin VB.Label Label6 
         Alignment       =   1  'Right Justify
         Caption         =   "Data Type:"
         Height          =   240
         Left            =   300
         TabIndex        =   14
         Top             =   750
         Width           =   915
      End
      Begin VB.Label Label5 
         Alignment       =   1  'Right Justify
         Caption         =   "Element Name:"
         Height          =   165
         Left            =   75
         TabIndex        =   13
         Top             =   338
         Width           =   1140
      End
   End
   Begin VB.Label Label10 
      Caption         =   "&File Name:"
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
      TabIndex        =   20
      Top             =   3472
      Width           =   915
   End
   Begin VB.Label Label9 
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
      Left            =   150
      TabIndex        =   19
      Top             =   3022
      Width           =   615
   End
End
Attribute VB_Name = "frmSourceFileGenerator"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public bLoading As Boolean
Public FileName As String
Public DataType As String
Public CompType As String






'***************************************************************************************************************
Private Sub cboComp_Change()
'***************************************************************************************************************


End Sub

'***************************************************************************************************************
Private Sub cboComp_Click()
'***************************************************************************************************************
    Dim x As Integer
    
    x = 0
    
    If Not bLoading Then
        
        For x = 0 To UBound(CompTypes)
            If (Me.cboComp.Text = CompTypes(x).CompTypeName) Then
                CompType = CompTypes(x).CompTypeCodes
                Exit For
            End If
        Next
    
    End If
End Sub


'***************************************************************************************************************
 Public Sub cboDataType_Click()
'***************************************************************************************************************
    Dim x As Integer
    
    x = 0
    
    If Not bLoading Then
        
        If (cboDataType.Text = "Integer") Then
            cboComp.Enabled = True
            cbSigned.Enabled = True
            lblIntType.Enabled = True
        Else
            cboComp.Enabled = False
            cbSigned.Enabled = False
            lblIntType.Enabled = False
        End If
    
        For x = 0 To UBound(DataTypes)
            If (Me.cboDataType.Text = DataTypes(x).DataTypeName) Then
                DataType = DataTypes(x).DataTypeCodes
                Exit For
            End If
        Next
     End If

End Sub
'***************************************************************************************************************
Private Sub cboDataType_LostFocus()
'***************************************************************************************************************


End Sub


'***************************************************************************************************************
Private Sub DataElement_Change()
'***************************************************************************************************************
    If (Len(DataElement.Text) < 1) Then
        DataElement.BackColor = &HFFFF&
        pbAbbreviated.Enabled = False
    Else
        DataElement.BackColor = &H80000005
        pbAbbreviated.Enabled = True
    End If

    Call SetExportButtonState

End Sub


Private Sub efCUVFile_Change()
    If (Len(efCUVFile.Text) < 1) Then
        efCUVFile.BackColor = &HFFFF&
    Else
        efCUVFile.BackColor = &H80000005
    End If

    Call SetExportButtonState
End Sub

'***************************************************************************************************************
Private Sub efPath_Change()
'***************************************************************************************************************
    If (Len(efPath.Text) < 1) Then
        efPath.BackColor = &HFFFF&
    Else
        efPath.BackColor = &H80000005
    End If

    Call SetExportButtonState

End Sub


'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    Dim x As Integer
    Dim msg As String
    Dim bDataTypeFlag As Boolean
    
    bDataTypeFlag = False
    
    lvSrcGenerate.ColumnHeaders.Add , , "Key", 600, 0
    lvSrcGenerate.ColumnHeaders.Add , , "C Name", 1500, 0
    lvSrcGenerate.ColumnHeaders.Add , , "Cobol Name", 1500, 0
    lvSrcGenerate.ColumnHeaders.Add , , "Decode", 2000, 0
    lvSrcGenerate.ColumnHeaders.Add , , "Array Name", 2000, 0
    
    'Set up the list view to remain highlighted when a row is selected.
    lvSrcGenerate.HideSelection = False
    
    'Set up the list view so that it highlights the entire row.
    SendMessage lvSrcGenerate.hwnd, LVM_SETEXTEDEDLISTVIEWSTYLE, 0, 33
    
    ReDim DataTypes(0)
    ReDim CompTypes(0)
    
    'Build the list of possible data types
    strsql = "SELECT DISTINCT DataTypeCode, DataTypeDecode From tblDataTypes order by DataTypeCode"
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            DataTypes(UBound(DataTypes)).DataTypeCodes = DaoRS(0).Value
            DataTypes(UBound(DataTypes)).DataTypeName = DaoRS(1).Value
            ReDim Preserve DataTypes(UBound(DataTypes) + 1)
            DaoRS.MoveNext
        Wend
    End If
    
    DaoRS.Close
      
    For x = 0 To UBound(DataTypes)
        Me.cboDataType.AddItem DataTypes(x).DataTypeName
    Next
    
    'Build the list of possible Comp types
    strsql = "SELECT CompTypeCd, CompTypeDecode from tblCompTypes " & _
             "ORDER By CompTypeCd"
        
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            CompTypes(UBound(CompTypes)).CompTypeCodes = DaoRS(0).Value
            CompTypes(UBound(CompTypes)).CompTypeName = DaoRS(1).Value
            ReDim Preserve CompTypes(UBound(CompTypes) + 1)
            DaoRS.MoveNext
        Wend
    End If
    
    DaoRS.Close
    
    For x = 0 To UBound(CompTypes)
        Me.cboComp.AddItem CompTypes(x).CompTypeName
    Next
    
    DataElement.Text = ""
    
    strsql = "SELECT TableName, DataElement, DataType, Signed, Comp FROM tblCUVHeaderData"
    strsql = strsql & " WHERE tblCUVHeaderData.TableName = " & Chr(39) & frmMain.tvTreeView.SelectedItem.Text & Chr(39)
    
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If (DaoRS.EOF = False) Then
        If (Len(DaoRS(1).Value) > 0) Then
            Me.DataElement.Text = DaoRS(1).Value
        Else
            Me.DataElement.Text = ""
        End If
        
        For x = 0 To UBound(DataTypes)
            If (RTrim(DaoRS(2).Value) = DataTypes(x).DataTypeCodes) Then
                Me.cboDataType.Text = DataTypes(x).DataTypeName
                bDataTypeFlag = True
                Exit For
            End If
        Next
        
        If (bDataTypeFlag = False) Then
            Me.cboDataType.Text = DataTypes(x).DataTypeName
        End If
        
        If (Len(DaoRS(3).Value) > 0) Then
            If (DaoRS(3).Value = True) Then
                Me.cbSigned.Value = 1
            Else
                Me.cbSigned.Value = 0
            End If
        Else
            Me.cbSigned.Value = 0
        End If
        
        For x = 0 To UBound(CompTypes)
            If (RTrim(DaoRS(4).Value) = CompTypes(x).CompTypeCodes And DaoRS(4).Value <> " ") Then
                Me.cboComp.Text = CompTypes(x).CompTypeName
                Exit For
            End If
        Next
        
    Else
    
        strsql = "INSERT INTO tblCUVHeaderData (TableName) VALUES (" & Chr(39) & frmMain.tvTreeView.SelectedItem.Text & Chr(39) & ")"
        wsCTM.BeginTrans
        dbCTM.Execute strsql
        If (dbCTM.RecordsAffected = 1) Then
            wsCTM.CommitTrans
        Else
            msg = "Could not insert " & frmMain.tvTreeView.SelectedItem.Text & " into tblCUVHeaderData table."
            RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton + vbApplicationModal, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
            wsCTM.Rollback
        End If
    End If
    
    DaoRS.Close
    
    Me.Caption = "Generate CUV Copybook - " & frmMain.tvTreeView.SelectedItem.Text
    efPath.Text = "c:\temp"
    Length.Text = frmMain.txtKeyLength.Text - 1
    
    
    If (Left(frmMain.tvTreeView.SelectedItem.Text, 3) = "CIS") Then
        FileName = "CUV" & Right(frmMain.tvTreeView.SelectedItem.Text, 5)
    Else
        FileName = frmMain.tvTreeView.SelectedItem.Text
    End If
    
    efCUVFile.Text = FileName
    
    Me.Show
    Me.Refresh
    
    'Populate the list view with the entries contained in this table.
    Call PopulateListView
    
    bLoading = False
    
    Me.Refresh
    
End Sub

'***************************************************************************************************************
Private Sub lvSrcGenerate_DblClick()
'***************************************************************************************************************
    frmModifyVarNames.Show
End Sub

'***************************************************************************************************************
Private Sub optCobolOutput_Click()
'***************************************************************************************************************
    efCUVFile.Text = FileName

End Sub

'***************************************************************************************************************
Private Sub optCOutput_Click()
'***************************************************************************************************************
    efCUVFile.Text = LCase(FileName) & ".h"

End Sub

'***************************************************************************************************************
Private Sub pbAbbreviated_Click()
'***************************************************************************************************************
    
    If (frmSourceFileGenerator.optCOutput) Then
        Call GenerateCNames
    Else
        Call GenerateCobolNames
    End If
    
End Sub

'***************************************************************************************************************
Private Sub pbExit_Click()
'***************************************************************************************************************
    Unload Me
End Sub

'***************************************************************************************************************
Public Sub SetExportButtonState()
'***************************************************************************************************************
    If ((Len(efPath.Text) > 0) And _
        (Len(DataElement.Text) > 0) And _
        (Len(efCUVFile.Text) > 0)) Then
        pbGenerate.Enabled = True
    Else
        pbGenerate.Enabled = False
    End If


End Sub


'***************************************************************************************************************
Public Sub PopulateListView()
'***************************************************************************************************************
    
    Dim itmX As ListItem
    
    'Clear out all the old values.
    lvSrcGenerate.ListItems.Clear
    
    'Get all the keys decodes.
    strsql = "SELECT Key, CName, CobolName, Decode, ArrayName from tblEntries " & _
             "WHERE TableName = " & Chr(39) & frmMain.tvTreeView.SelectedItem.Text & _
             Chr(39) & "ORDER By Key"
             
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then
    
        While Not DaoRS.EOF
             Set itmX = lvSrcGenerate.ListItems.Add(, , CStr(DaoRS(0).Value))
                
                If (IsNull(DaoRS(1).Value)) Then
                    itmX.SubItems(1) = " "
                Else
                    itmX.SubItems(1) = DaoRS(1).Value
                End If
                
                If (IsNull(DaoRS(2).Value)) Then
                    itmX.SubItems(2) = " "
                Else
                    itmX.SubItems(2) = DaoRS(2).Value
                End If
                
                If (IsNull(DaoRS(3).Value)) Then
                    itmX.SubItems(3) = " "
                Else
                    itmX.SubItems(3) = DaoRS(3).Value
                End If
                
                If (IsNull(DaoRS(4).Value)) Then
                    itmX.SubItems(4) = " "
                Else
                    itmX.SubItems(4) = DaoRS(4).Value
                End If
                
                DaoRS.MoveNext
        Wend
        
        DaoRS.Close
    End If

End Sub

'***************************************************************************************************************
Private Sub pbGenerate_Click()
'***************************************************************************************************************
    Dim bFound As Boolean, Col As Integer, RC As Integer, x As Integer
    Dim bSignedFlag As Boolean, msg As String
    
    'On Error GoTo UpdateError
    
    If (Me.cbSigned = 1) Then
        bSignedFlag = True
    Else
        bSignedFlag = False
    End If
       
    If (Len(cboComp.Text) = 0) Then
        CompType = " "
    End If
    
    strsql = "UPDATE DISTINCTROW tblCUVHeaderData SET tblCUVHeaderData.DataType = " & Chr(39) & DataType & Chr(39)
    strsql = strsql & ", tblCUVHeaderData.DataElement = " & Chr(39) & Me.DataElement & Chr(39)
    strsql = strsql & ", tblCUVHeaderData.Comp = " & Chr(39) & CompType & Chr(39)
    strsql = strsql & ", tblCUVHeaderData.Signed = " & bSignedFlag
    strsql = strsql & " WHERE (((tblCUVHeaderData.TableName)=" & Chr(39) & frmMain.tvTreeView.SelectedItem.Text & Chr(39) & "));"

Debug.Print strsql

    wsCTM.BeginTrans
    dbCTM.Execute strsql
    
    If (dbCTM.RecordsAffected = 1) Then
        wsCTM.CommitTrans
    Else
        wsCTM.Rollback
        Debug.Print strsql
        msg = "An error has occured while trying to modify the Data Element header fields. Copybook was not generated." & vbCrLf
        RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton + vbApplicationModal, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
        Exit Sub
    End If
    
    bFound = False
    
    If (frmSourceFileGenerator.optCOutput) Then
        Col = 1
    Else
        Col = 2
    End If
    
    
    'Check to see if all the variables have been generated.
    For x = 1 To lvSrcGenerate.ListItems.Count
        If (IsNull(lvSrcGenerate.ListItems(x).SubItems(Col)) Or _
            (lvSrcGenerate.ListItems(x).SubItems(Col) = " ")) Then
            bFound = True
            Exit For
        End If
    Next
    
    If Not bFound Then
        Call GenerateCopybook
        'Unload Me
    Else
        lvSrcGenerate.ListItems(x).Selected = True
        Set lvSrcGenerate.SelectedItem = lvSrcGenerate.ListItems(x)
        lvSrcGenerate.ListItems(x).EnsureVisible
        lvSrcGenerate.Refresh
        lvSrcGenerate.SetFocus
        
        RC = MessageBox(Me.hwnd, _
                        "A Key was found that does not currently have a variable defined." & vbCrLf & _
                        "Please regenerate the variable names or manually add the variable" & vbCrLf & _
                        "by double clicking on the line.", _
                        "Codes Table Explorer", _
                        MB_OK Or MB_ICONHAND)
    
    End If
End Sub

'***************************************************************************************************************
Public Function FindExistingCopybook(TblName As String) As String
'***************************************************************************************************************
    Dim RC As Integer
    
    On Error GoTo ErrComDlg


RedisplayDlg:



    ComDlg.CancelError = True
    ComDlg.DialogTitle = "Open Existing Copybook..."
    
    If (Right(TblName, 2) = ".h") Then
        ComDlg.Filter = "C Header File|*.h"
    Else
        ComDlg.Filter = "COBOL Copybook|Cuv*"
    End If
    
    ComDlg.Flags = cdlOFNHideReadOnly Or cdlOFNFileMustExist
    ComDlg.DefaultExt = "CUV*"
    ComDlg.ShowOpen
    
    If (UCase(Right(ComDlg.FileName, Len(TblName))) = UCase(TblName)) Then
        FindExistingCopybook = ComDlg.FileName
    Else
        RC = MessageBox(Me.hwnd, _
                        "The selected copybook does not match?" & vbCrLf & _
                        "Would you like to attempt to locate the file again?", _
                        "Codes Table Explorer", _
                        MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2)
        
        If (RC = IDYES) Then
            GoTo RedisplayDlg
        Else
            FindExistingCopybook = ""
        End If
    End If


Exit Function

ErrComDlg:
    FindExistingCopybook = ""
    Exit Function
End Function


'***************************************************************************************************************
Public Sub GenerateCNames()
'***************************************************************************************************************
    Dim RC As Integer, FileLoc As String, iFileNum As Integer, sLine As String, bDataElementFound As Boolean
    Dim pos As Integer, TempString As String, KeyVal As String, x As Integer
    Dim bBadKeysInFile As Boolean, bFound As Boolean
    
    bFound = False
    
    'Check to see if there are already c variable names
    For x = 1 To lvSrcGenerate.ListItems.Count
        If (Not IsNull(lvSrcGenerate.ListItems(x).SubItems(1)) And _
            (Not lvSrcGenerate.ListItems(x).SubItems(1) = " ")) Then
            bFound = True
            Exit For
        End If
    Next
    
    Me.Refresh
    
    'If there are variables prompt the user to determine how to proceed.
    If bFound Then
        RC = MessageBox(Me.hwnd, _
                        "There are variables already existing for this table." & vbCrLf & _
                        "Would you like to generate new variables?", _
                        "Codes Table Explorer", _
                        MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2)
            
        If (RC = IDNO) Then
            Exit Sub
        Else
            Screen.MousePointer = vbHourglass
            
            For x = 1 To lvSrcGenerate.ListItems.Count
                
                strsql = "UPDATE tblEntries SET CName = ' ' WHERE TableName = " & Chr(39) & _
                         frmMain.tvTreeView.SelectedItem.Text & Chr(39) & _
                         " AND Key = " & Chr(39) & lvSrcGenerate.ListItems(x).Text & Chr(39)
                wsCTM.BeginTrans
                dbCTM.Execute strsql
                wsCTM.CommitTrans
                
                lvSrcGenerate.ListItems(x).SubItems(1) = vbNullString
            Next
            
            Screen.MousePointer = vbNormal
        End If
    
    End If
    
    Me.Refresh
    
    'Check to see if the user wants to import variable names from an exising copybook.
    RC = MessageBox(Me.hwnd, _
                    "Do you wish to use variables from an existing copybook?", _
                    "Codes Table Explorer", _
                    MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2)
    
    Me.Refresh
    
    'If not, then generate new values.
    If (RC = IDNO) Then
        
        'Generate the new variable names.
        Call CreateVariableNames
    
    'Use values from an existing copybook
    Else
        
        'Get the name and location of the copybook to open.
        FileLoc = FindExistingCopybook(efCUVFile.Text)
        
        'If no file was returned then exit this sub.
        If (FileLoc = "") Then Exit Sub
        
        'Disable the mouse pointer.
        Screen.MousePointer = vbHourglass
        
        'Open the copybook for reading.
        iFileNum = FreeFile
        Open FileLoc For Input As iFileNum

        'Set the default state of the bad keys flags
        bBadKeysInFile = False
        
        'Set up the flag for getting the data element name just once.
        bDataElementFound = False
        
        'Loop down the opened copybook file.
        Do Until EOF(iFileNum)

            'Get the next line in the file.
            Line Input #iFileNum, sLine

            'Determine if this is a line containg a key definition.
            If (InStr(sLine, "#define ") > 0) Then
                
                
                'Get rid of the leading and trailing spaces.
                sLine = Trim(sLine)
                
                'Trim off the #define.
                pos = InStr(sLine, " ")
                TempString = Mid(sLine, pos, Len(sLine))
                TempString = Trim(TempString)
                

                'Get the data element name - just the first time though.
                If (Not bDataElementFound) Then
                    bDataElementFound = True
                    'Populate the data element field.
                    DataElement.Text = ParseString(TempString, "_", 1)
                End If
                

                'Get the variable name.
                pos = InStr(TempString, " ")
                TempString = Left(TempString, pos)
                TempString = Trim(TempString)


                'Find the double quote.
                pos = InStr(sLine, Chr(34))
                
                KeyVal = Mid(sLine, pos + 1, Length.Text)
            
                bFound = False
                
                'see if this key is currently a legitimate codes table value.
                For x = 1 To lvSrcGenerate.ListItems.Count
                    If (lvSrcGenerate.ListItems(x).Text = "E" & KeyVal) Then
                        bFound = True
                        Exit For
                    End If
                Next
            
                'If it wasn't found, then this copybook contains values which
                'are not currently valid. Set the bad keys flag and continue.
                'At the end we will display an error message indicating the condition.
                If (Not bFound) Then
                    bBadKeysInFile = True
                
                'If it was found then go ahead and get the variable name and add it to
                'the c name.
                Else
                    wsCTM.BeginTrans
                    
                    strsql = "UPDATE tblEntries SET CName = " & Chr(39) & _
                             TempString & Chr(39) & ", ArrayName = " & Chr(39) & _
                             TempString & Chr(39) & " WHERE TableName = " & Chr(39) & _
                             frmMain.tvTreeView.SelectedItem.Text & Chr(39) & _
                             " AND Key = " & Chr(39) & "E" & KeyVal & Chr(39)
                    
                    dbCTM.Execute strsql
                    wsCTM.CommitTrans
                    
                    'Update the list view.
                    lvSrcGenerate.ListItems(x).SubItems(1) = TempString
                End If
            End If

        Loop
        
        'Close the file and continue with any other keys that still need variables.
        Close iFileNum
    
        'Now, go ahead and generate variable names for any that weren't in the
        'existing copybook.
        Call CreateVariableNames
    
        'If there were any extra keys within the copybook, display a message here.
        If (bBadKeysInFile) Then
            RC = MessageBox(Me.hwnd, _
                            "The existing copybook contained Keys that are " & vbCrLf & _
                            "not currently defined within the this table.", _
                            "Codes Table Explorer", _
                            MB_OK Or MB_ICONHAND)
        End If
    End If
    
    'Reenable the mouse pointer and refresh the window.
    Screen.MousePointer = vbNormal
    Me.Refresh

End Sub


'***************************************************************************************************************
Public Sub GenerateCobolNames()
'***************************************************************************************************************
    Dim RC As Integer, FileLoc As String, iFileNum As Integer, sLine As String
    Dim pos As Integer, TempString As String, KeyVal As String, x As Integer
    Dim bBadKeysInFile As Boolean, bFound As Boolean
    
    bFound = False
    
    'Check to see if there are already cobol variable names
    For x = 1 To lvSrcGenerate.ListItems.Count
        If (Not IsNull(lvSrcGenerate.ListItems(x).SubItems(2)) And _
            (Not lvSrcGenerate.ListItems(x).SubItems(2) = " ")) Then
            bFound = True
            Exit For
        End If
    Next
    
    Me.Refresh
    
    'If there are variables prompt the user to determine how to proceed.
    If bFound Then
        RC = MessageBox(Me.hwnd, _
                        "There are variables already existing for this table." & vbCrLf & _
                        "Would you like to generate new variables?", _
                        "Codes Table Explorer", _
                        MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2)
            
        If (RC = IDNO) Then
            Exit Sub
        Else
            Screen.MousePointer = vbHourglass
            
            For x = 1 To lvSrcGenerate.ListItems.Count
                
                strsql = "UPDATE tblEntries SET CobolName = ' ' WHERE TableName = " & Chr(39) & _
                         frmMain.tvTreeView.SelectedItem.Text & Chr(39) & _
                         " AND Key = " & Chr(39) & lvSrcGenerate.ListItems(x).Text & Chr(39)
                wsCTM.BeginTrans
                dbCTM.Execute strsql
                wsCTM.CommitTrans
                
                lvSrcGenerate.ListItems(x).SubItems(2) = vbNullString
            Next
            
            Screen.MousePointer = vbNormal
        End If
    
    End If
    
    Me.Refresh
    
    'Check to see if the user wants to import variable names from an exising copybook.
    RC = MessageBox(Me.hwnd, _
                    "Do you wish to use variables from an existing copybook?", _
                    "Codes Table Explorer", _
                    MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2)
    
    Me.Refresh
    
    'If not, then generate new values.
    If (RC = IDNO) Then
        
        'Generate the new variable names.
        Call CreateVariableNames
    
    'Use values from an existing copybook
    Else
        
        'Get the name and location of the copybook to open.
        FileLoc = FindExistingCopybook(efCUVFile.Text)
        
        'If no file was returned then exit this sub.
        If (FileLoc = "") Then Exit Sub
        
        'Disable the mouse pointer.
        Screen.MousePointer = vbHourglass
        
        'Open the copybook for reading.
        iFileNum = FreeFile
        Open FileLoc For Input As iFileNum

        'Set the default state of the bad keys flags
        bBadKeysInFile = False
        
        'Loop down the opened copybook file.
        Do Until EOF(iFileNum)

            'Get the next line in the file.
            Line Input #iFileNum, sLine

            'If this is the 01 level, grab the existing data element name.
            If (Not (Mid(sLine, 7, 1) = "*") And (InStr(sLine, " 01 ") > 0)) Then
                
                'Get rid of the leading and trailing spaces.
                sLine = RTrim(LTrim(sLine))
                
                'Trim out just the variable name.
                pos = InStr(sLine, "VS-")
                TempString = Mid(sLine, pos + 3, Len(sLine))
                pos = InStr(TempString, "-88")
                
                'Populate the data element field.
                DataElement.Text = Left(TempString, pos - 1)
            
            End If


            'If this is an 88 level, then we first need the value.
            If (Not (Mid(sLine, 7, 1) = "*") And (InStr(sLine, " 88 ") > 0) _
                And (InStr(sLine, " VALUE") > 0)) Then

                'Get rid of the leading and trailing spaces.
                sLine = RTrim(LTrim(sLine))
                
                'Find the single quote.
                pos = InStr(sLine, "'")
                
                KeyVal = Mid(sLine, pos + 1, Length.Text)
            
                bFound = False
                
                'see if this key is currently a legitimate codes table value.
                For x = 1 To lvSrcGenerate.ListItems.Count
                    If (lvSrcGenerate.ListItems(x).Text = "E" & KeyVal) Then
                        bFound = True
                        Exit For
                    End If
                Next
            
                'If it wasn't found, then this copybook contains values which
                'are not currently valid. Set the bad keys flag and continue.
                'At the end we will display an error message indicating the condition.
                If (Not bFound) Then
                    bBadKeysInFile = True
                
                'If it was found then go ahead and get the variable name and add it to
                'the cobol name.
                Else
                    TempString = ParseString(sLine, " ", 2)
                    
                    wsCTM.BeginTrans
                    
                    strsql = "UPDATE tblEntries SET CobolName = " & Chr(39) & _
                             TempString & Chr(39) & " WHERE TableName = " & Chr(39) & _
                             frmMain.tvTreeView.SelectedItem.Text & Chr(39) & _
                             " AND Key = " & Chr(39) & "E" & KeyVal & Chr(39)
                    
                    dbCTM.Execute strsql
                    wsCTM.CommitTrans
                    
                    'Update the list view.
                    lvSrcGenerate.ListItems(x).SubItems(2) = TempString
                End If
            End If

        Loop
        
        'Close the file and continue with any other keys that still need variables.
        Close iFileNum
    
        'Now, go ahead and generate variable names for any that weren't in the
        'existing copybook.
        Call CreateVariableNames
    
        'If there were any extra keys within the copybook, display a message here.
        If (bBadKeysInFile) Then
            RC = MessageBox(Me.hwnd, _
                            "The existing copybook contained Keys that are " & vbCrLf & _
                            "not currently defined within the this table.", _
                            "Codes Table Explorer", _
                            MB_OK Or MB_ICONHAND)
        End If
    End If
    
    'Reenable the mouse pointer and refresh the window.
    Screen.MousePointer = vbNormal
    Me.Refresh

End Sub

