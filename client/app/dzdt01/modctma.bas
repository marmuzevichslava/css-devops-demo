Attribute VB_Name = "modCTM"
Option Explicit

'***************************************************************************************************************
'** CONSTANTS                                                                                                 **
'***************************************************************************************************************
Public Const AUTHOR As String = "technical support team"
Public Const SQL_FOUND As Integer = 0
Public Const SQL_NOT_FOUND As Integer = 100

Const CODES_TABLE = 1
Const MSG_BOX = 2
Const WES_CODE = 3

'***************************************************************************************************************
'** VARIABLES                                                                                                 **
'***************************************************************************************************************
Public CurTable As String, CurKey As String, CurTableType As Integer
Public ImportCntr As Integer
Public KeyCntr As Integer
Public bCloseImport As Boolean
Public bAddNewKey As Boolean
Public bAdmin As Boolean
Public CurrentUser As String

'***************************************************************************************************************
'** DAO VARIABLES                                                                                             **
'***************************************************************************************************************
Public wsCTM As Workspace
Public dbCTM As Database
Public DaoRS As Recordset
Public strsql As String

'***************************************************************************************************************
'** TYPE DECLARATIONS                                                                                         **
'***************************************************************************************************************

'Table type information
Type TableType
    TableTypeName As String
    TableTypeCode As Integer
End Type

Public TableTypes() As TableType

Type DataType
    DataTypeName As String
    DataTypeCodes As String
End Type

Public DataTypes() As DataType

Type CompType
    CompTypeName As String
    CompTypeCodes As String
End Type

Public CompTypes() As CompType

'Structure used during the import process for error handling.
Type ImportError
    Table As String
    Key As String
    Decode As String
    Client As String
    Action As String * 1
End Type
Public ImportErrArray() As ImportError

'Structure for adding & modifying Key codes.
Type objClient
    Client As String
    Code As Integer
End Type
Public ClientArray() As objClient

'Structure for populating Buttons List Box.
Type objButtons
    Buttons As String
    ButtonID As Integer
End Type
Public ButtonsArray() As objButtons

'Structure for populating Icon List Box.
Type objIcon
    Icon As String
    IconID As Integer
End Type
Public IconArray() As objIcon

'Structure for populating Default Buttons List Box.
Type objDefaultButton
    DefaultButton As String
    DefaultButtonID As Integer
End Type
Public DefaultButtonArray() As objDefaultButton

'Structure for populating the Application List Box.
Type objApplication
    Application As String
    Code As Integer
End Type
Public ApplicationArray() As objApplication

'Structure for populating the Platform List Box.
Type objPlatform
    Platform As String
    Code As Integer
End Type
Public PlatformArray() As objPlatform

'Structure for populating the Release List Box.
Type objRelease
    Release As String
    Code As Integer
End Type
Public ReleaseArray() As objRelease

'***************************************************************************************************************
'** FUNCTION DECLARATIONS & CONSTANTS                                                                         **
'***************************************************************************************************************
Declare Function GetUserName Lib "advapi32.dll" Alias "GetUserNameA" (ByVal lpBuffer As String, _
                                                                     nSize As Long) As Long
Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, _
                                                                       ByVal msg As Long, _
                                                                       ByVal wParam As Long, _
                                                                       ByVal lParam As Long) As Long
Public Const LVM_FIRST = &H1000
Public Const LVM_SETEXTEDEDLISTVIEWSTYLE = LVM_FIRST + 54
                                                               
                                                               
                                                               
                                                               
'***************************************************************************************************************
Public Function LongDirFix(Incomming As String, _
                           Max As Integer) As String
'***************************************************************************************************************
    Dim i As Integer, LblLen As Integer, StringLen As Integer, TempString As String
    
    TempString = Incomming
    LblLen = Max
    
    If Len(TempString) <= LblLen Then
        LongDirFix = TempString
        Exit Function
    End If
                           
    LblLen = LblLen - 6
    
    For i = Len(TempString) - LblLen To Len(TempString)
        If Mid$(TempString, i, 1) = "\" Then Exit For
    Next
                           
    LongDirFix = Left$(TempString, 3) & "..." & Right$(TempString, Len(TempString) - (i - 1))
    
End Function
                                                               
                                                               

'***************************************************************************************************************
Public Sub MainTreeViewNodeClick(ByVal Node As Node)
'***************************************************************************************************************
'    Dim x As Integer
'
''    frmMain.sbStatusBar.Panels(1).Text = "Retrieving Keys for " & RTrim(Node.Text) & "..."
''    frmMain.txtDecodeLength.Text = ""
''    frmMain.txtDecodeDisplacement.Text = ""
''    frmMain.txtDataLength.Text = ""
''    frmMain.txtKeyLength.Text = ""
''    frmMain.txtCenturyDelim.Text = ""
''    frmMain.txtTotalKeys = ""
''    frmMain.chkSystem.Value = False
''    frmMain.chkStatic.Value = False
''    frmMain.chkCodes.Value = False
'
''    frmMain.mnuPrintTable.Enabled = False
''    frmMain.mnuDeleteTable.Enabled = False
''    frmMain.mnuModifyTable.Enabled = False
''    frmMain.mnuGenerate.Enabled = False
'
''    Screen.MousePointer = vbHourglass
'
'    'If this is the top node then exit.
'    If (Node.Key = "Base") Then
''        frmMain.lvListView.ListItems.Clear
''        frmMain.sbStatusBar.Panels(1).Text = ""
''        frmMain.txtTotalKeys.Text = ""
''        Screen.MousePointer = vbNormal
''        frmMain.famTable.Caption = "Current Table"
''        frmMain.Refresh
'        Exit Sub
'    End If
'
'    'If this a + node then don't do anything.
'    For x = 0 To UBound(TableTypes)
'        If (Node.Key = TableTypes(x).TableTypeName) Then
''            frmMain.lvListView.ListItems.Clear
''            frmMain.famTable.Caption = "Current Table"
''            frmMain.sbStatusBar.Panels(1).Text = ""
''            frmMain.txtTotalKeys.Text = ""
''            Screen.MousePointer = vbNormal
''            frmMain.Refresh
'            Exit Sub
'        End If
'    Next
'
'    'Get the parent table type code for this node.
'    For x = 0 To UBound(TableTypes)
'        If (Node.Parent = TableTypes(x).TableTypeName) Then
'            CurTableType = TableTypes(x).TableTypeCode
'            Exit For
'        End If
'    Next
'
'    'Save the current table to a global variable.
'    CurTable = Node.Text
'    CurKey = ""
'
'    'Get all the Keys and decodes.
'    Call RefreshCodeDecodeLB
'
'    'Enable the delete Table Key.
'    frmMain.mnuDeleteTable.Enabled = True
'    frmMain.mnuModifyTable.Enabled = True
'
'    If (CurTableType = 1) Then
'        frmMain.mnuPrintTable.Enabled = True
'        frmMain.mnuGenerate.Enabled = True
'    End If
'
'    'Enable the check boxes.
'    frmMain.chkSystem.Enabled = True
'    frmMain.chkStatic.Enabled = True
'    frmMain.chkCodes.Enabled = True
'
'    strsql = "select Description, DecodeLen, DecodeDisplacement, " & _
'             "DataLen, KeyLen, SystemUse, StaticTableUse, CodesTableUse, CenturyDelim " & _
'             "from tblTables where TableName = " & Chr(34) & Node.Text & Chr(34)
'
'    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
'
'    If Not DaoRS.EOF Then
'
'        frmMain.famTable.Caption = "Table " & Node.Text & ":"
'
'        If Not (DaoRS(0).Value = vbNullChar) Then
'            frmMain.sbStatusBar.Panels(1).Text = DaoRS(0)
'        Else
'            frmMain.sbStatusBar.Panels(1).Text = "No Description Available"
'        End If
'
'        frmMain.txtDecodeLength.Text = CStr(DaoRS(1).Value)
'
'        If (IsNull(DaoRS(2).Value)) Then
'            frmMain.txtDecodeDisplacement.Text = " "
'        Else
'            frmMain.txtDecodeDisplacement.Text = CStr(DaoRS(2).Value)
'        End If
'
'        frmMain.txtDataLength.Text = CStr(DaoRS(3).Value)
'        frmMain.txtKeyLength.Text = CStr(DaoRS(4).Value)
'
'        If DaoRS(5).Value Then
'            frmMain.chkSystem.Value = 1
'        Else
'            frmMain.chkSystem.Value = 0
'        End If
'
'        If DaoRS(6).Value Then
'            frmMain.chkStatic.Value = 1
'        Else
'            frmMain.chkStatic.Value = 0
'        End If
'
'        If DaoRS(7).Value Then
'            frmMain.chkCodes.Value = 1
'        Else
'            frmMain.chkCodes.Value = 0
'        End If
'
'        If (IsNull(DaoRS(8).Value)) Then
'            frmMain.txtCenturyDelim.Text = ""
'        Else
'            frmMain.txtCenturyDelim.Text = DaoRS(8).Value
'        End If
'
'        DaoRS.Close
'    End If
'
'    'refresh the screen.
'    Screen.MousePointer = vbNormal
'    frmMain.Refresh

End Sub



'***************************************************************************************************************
Public Sub BuildTableList()
'***************************************************************************************************************
'    Dim nodx As Node, x As Integer
'
'    'Clear the control.
'    frmMain.tvTreeView.Nodes.Clear
'
'    'Set up the base treeview node.
'    Set nodx = frmMain.tvTreeView.Nodes.Add(, , "Base", "Table Types")
'
'    ReDim TableTypes(0)
'
'    'Build the list of possible table types
'    strsql = "select distinct TableTypeCode, Decode From tblTableCodes order by TableTypeCode"
'    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
'
'    If Not DaoRS.EOF Then
'        While Not DaoRS.EOF
'            TableTypes(UBound(TableTypes)).TableTypeCode = DaoRS(0).Value
'            TableTypes(UBound(TableTypes)).TableTypeName = DaoRS(1).Value
'
'            Set nodx = frmMain.tvTreeView.Nodes.Add("Base", 4, _
'                                                     TableTypes(UBound(TableTypes)).TableTypeName, _
'                                                     TableTypes(UBound(TableTypes)).TableTypeName)
'
'            ReDim Preserve TableTypes(UBound(TableTypes) + 1)
'            DaoRS.MoveNext
'        Wend
'
'        DaoRS.Close
'    End If
'
'    frmMain.Refresh
'
'    For x = 0 To UBound(TableTypes)
'
'        'Build the tree control with all the tables available within the CTM database.
'        strsql = "Select TableName From tblTables where TableType = " & TableTypes(x).TableTypeCode & _
'                         " order by TableName"
'
'        Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
'
'        If Not DaoRS.EOF Then
'
'            While Not DaoRS.EOF
'
'                Set nodx = frmMain.tvTreeView.Nodes.Add(TableTypes(x).TableTypeName, 4, _
'                                                        DaoRS!TableName.Value, _
'                                                        DaoRS!TableName.Value)
'                nodx.Sorted = True
'
'                DaoRS.MoveNext
'            Wend
'
'            frmMain.tvTreeView.Nodes(1).Expanded = True
'            frmMain.Refresh
'            DaoRS.Close
'        End If
'    Next

End Sub

'***************************************************************************************************************
Public Function CheckUMsgKeyExists(ByVal TableName As String, _
                               ByVal Key As Integer, _
                               ByVal Client As Integer, _
                               ByVal SeqNumber As Integer) As Boolean
'***************************************************************************************************************
    
    'Put together the sql to perform the check.
    strsql = "SELECT 1 FROM tblUserErrorMsgEntries" _
                 & " Where TableName = " & Chr(34) & TableName & Chr(34) & " AND Client = " & Client & " AND ErrorNumber = " & Key & " AND SequenceNumber = " & SeqNumber
        
    'Open the recordset.
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    'If the recordset is NOT empty then the key already exists.
    If Not DaoRS.EOF Then
        CheckUMsgKeyExists = True
    Else
        CheckUMsgKeyExists = False
    End If
    
    'Close the recordset.
    DaoRS.Close

End Function


'***************************************************************************************************************
Public Function CheckMsgKeyExists(ByVal TableName As String, _
                               ByVal Code As Integer, _
                               ByVal Client As Integer) As Boolean
'***************************************************************************************************************
    
    'Put together the sql to perform the check.
    strsql = " SELECT 1 FROM tblMsgBoxEntries " _
             & " Where TableName = " & Chr(34) & TableName & Chr(34) _
             & " AND Client = " & Client _
             & " AND Code = " & Code
        
    'Open the recordset.
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    'If the recordset is NOT empty then the key already exists.
    If Not DaoRS.EOF Then
        CheckMsgKeyExists = True
    Else
        CheckMsgKeyExists = False
    End If
    
    'Close the recordset.
    DaoRS.Close

End Function


'***************************************************************************************************************
Public Function CheckKeyExists(ByVal TableName As String, _
                               ByVal Key As String, _
                               ByVal Client As Integer) As Boolean
'***************************************************************************************************************
    
    'Put together the sql to perform the check.
    strsql = "SELECT 1 FROM tblEntries WHERE TableName = " & Chr(34) & TableName & Chr(34) & " " & _
             "AND Key = " & Chr(34) & Key & Chr(34) & "AND Client = " & Client
    
    'Open the recordset.
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    'If the recordset is NOT empty then the key already exists.
    If Not DaoRS.EOF Then
        CheckKeyExists = True
    Else
        CheckKeyExists = False
    End If
    
    'Close the recordset.
    DaoRS.Close

End Function




'*********************************************************************************************************
Public Function CheckAuthorityLevel() As Boolean
'*********************************************************************************************************
    Dim lpBuffer As String * 255, x As Integer
    Dim lRet As Long, lSize As Long
    
    lRet = GetUserName(lpBuffer, 255)

    CurrentUser = Left(lpBuffer, InStr(lpBuffer, vbNullChar) - 1)
    
    'First see if the Admin table exists.
    For x = 1 To wsCTM.Databases(0).TableDefs.Count - 1
        If (wsCTM.Databases(0).TableDefs(x).Name = "tblAdmin") Then Exit For
    Next
    
    If (x = wsCTM.Databases(0).TableDefs.Count) Then
        CheckAuthorityLevel = False
        Exit Function
    End If
    
    strsql = "select 1 from tblAdmin where AdminName = " & Chr(34) & CurrentUser & Chr(34)

    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    'If something was returned then the current user is on the admin table. Otherwise
    If (DaoRS.RecordCount = 1) Then
        CheckAuthorityLevel = True
    Else
        CheckAuthorityLevel = False
    End If

    DaoRS.Close
    
End Function





'*********************************************************************************************************
Public Function CheckForSpecialChars(s As String) As String
'*********************************************************************************************************
    Dim pos As Integer
    Dim res As String

    res = s
    s = ""
    'Check for pipe character
    Do While InStr(res, Chr(124))
        pos = InStr(res, Chr(124))
        s = s & Chr(39) & Left(res, pos - 1) & Chr(39) & " & Chr(124) & "
        res = Mid(res, pos + 1)
    Loop

    CheckForSpecialChars = s & Chr(39) & res & Chr(39)

End Function

'*********************************************************************************************************
Public Sub RefreshCodeDecodeLB()
'*********************************************************************************************************
'    Dim itmX As ListItem, cnt As Integer
'    Dim x As Integer
'
'    KeyCntr = 0
'
'    frmMain.lvListView.ListItems.Clear
'
'    On Error GoTo ODBCError
'
'    If (CurTableType = CODES_TABLE) Then
'        strsql = "SELECT DISTINCTROW tblEntries.Key, tblEntries.Decode, tblClients.Client, tblApplications.Application, tblPlatforms.Platform, tblReleases.Release, tblEntries.SystemUse, tblEntries.StaticTableUse, tblEntries.CodesTableUse, tblEntries.Comments, tblEntries.Description" _
'                 & " FROM (((tblEntries INNER JOIN tblReleases ON tblEntries.CSSRelease = tblReleases.Code) INNER JOIN tblClients ON tblEntries.Client = tblClients.Code) INNER JOIN tblPlatforms ON tblEntries.Platform = tblPlatforms.Code) INNER JOIN tblApplications ON tblEntries.Application = tblApplications.Code" _
'                 & " WHERE (((tblEntries.TableName) = " & Chr(34) & frmMain.tvTreeView.SelectedItem.Text & Chr(34) & "))" _
'                 & " ORDER BY tblEntries.Key;"
'
'        frmMain.lvListView.ColumnHeaders.Clear
'
'        'Add the column headings.
'        frmMain.lvListView.ColumnHeaders.Add , , "Key", 700, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Decode", 3000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Client", 1500, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Application", 1000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Platform", 1000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Release", 1000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "SystemUse", 1300, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "StaticTableUse", 1300, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "CodesTableUse", 1300, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Comment", 3000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Description", 3000, 0
'
'        'UnHide Check boxes
'        frmMain.chkCodes.Visible = True
'        frmMain.chkStatic.Visible = True
'        frmMain.chkSystem.Visible = True
'
'    ElseIf (CurTableType = MSG_BOX) Then
'        strsql = "SELECT DISTINCTROW tblMsgBoxEntries.Code, tblMsgBoxEntries.MsgBoxText, tblClients.Client, tblApplications.Application, tblPlatforms.Platform, tblReleases.Release, tblMsgBoxIcons.Icon, tblMsgBoxDefaultButtons.[Defualt Button], tblMsgBoxButtons.Buttons, tblMsgBoxEntries.Comments, tblMsgBoxEntries.TableName" _
'                 & " FROM ((((((tblMsgBoxEntries INNER JOIN tblMsgBoxButtons ON tblMsgBoxEntries.Buttons = tblMsgBoxButtons.[Button ID]) INNER JOIN tblMsgBoxDefaultButtons ON tblMsgBoxEntries.DefaultButton = tblMsgBoxDefaultButtons.[Default Button ID]) INNER JOIN tblMsgBoxIcons ON tblMsgBoxEntries.Icon = tblMsgBoxIcons.[Icon ID]) INNER JOIN tblReleases ON tblMsgBoxEntries.CSSRelease = tblReleases.Code) INNER JOIN tblClients ON tblMsgBoxEntries.Client = tblClients.Code) INNER JOIN tblPlatforms ON tblMsgBoxEntries.Platform = tblPlatforms.Code) INNER JOIN tblApplications ON tblMsgBoxEntries.Application = tblApplications.Code" _
'                 & " Where (((tblMsgBoxEntries.TableName) = " & Chr(34) & frmMain.tvTreeView.SelectedItem.Text & Chr(34) & "))" _
'                 & " ORDER BY tblMsgBoxEntries.Code;"
'
'        frmMain.lvListView.ColumnHeaders.Clear
'
'        'Add the column headings.
'        frmMain.lvListView.ColumnHeaders.Add , , "Msg Key", 700, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Message Box Decode", 4000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Client", 1500, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Application", 1000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Platform", 1000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Release", 1000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Icon", 2500, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Default Button", 2500, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Buttons", 2500, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Comment", 3000, 0
'
'        'Hide Check boxes
'        frmMain.chkCodes.Visible = False
'        frmMain.chkStatic.Visible = False
'        frmMain.chkSystem.Visible = False
'
'    Else
'        strsql = "SELECT DISTINCTROW tblUserErrorMsgEntries.ErrorNumber, tblUserErrorMsgEntries.ErrorCode, tblClients.Client, tblApplications.Application, tblReleases.Release, tblPlatforms.Platform, tblUserErrorMsgEntries.SequenceNumber, tblUserErrorMsgEntries.Language, tblUserErrorMsgEntries.Coments" _
'                 & " FROM (((tblUserErrorMsgEntries INNER JOIN tblClients ON tblUserErrorMsgEntries.Client = tblClients.Code) INNER JOIN tblReleases ON tblUserErrorMsgEntries.CSSRelease = tblReleases.Code) INNER JOIN tblPlatforms ON tblUserErrorMsgEntries.Platform = tblPlatforms.Code) INNER JOIN tblApplications ON tblUserErrorMsgEntries.Application = tblApplications.Code" _
'                 & " Where (((tblUserErrorMsgEntries.TableName) = " & Chr(34) & frmMain.tvTreeView.SelectedItem.Text & Chr(34) & "))" _
'                 & " ORDER BY tblUserErrorMsgEntries.ErrorNumber;"
'
'        frmMain.lvListView.ColumnHeaders.Clear
'
'        'Add the column headings.
'        frmMain.lvListView.ColumnHeaders.Add , , "Error Key", 700, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Error Message Decode", 3000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Client", 1500, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Application", 1000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Platform", 1000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Release", 1000, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Seq. No.", 700, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Language", 700, 0
'        frmMain.lvListView.ColumnHeaders.Add , , "Comment", 3000, 0
'
'        'Hide Check boxes
'        frmMain.chkCodes.Visible = False
'        frmMain.chkStatic.Visible = False
'        frmMain.chkSystem.Visible = False
'
'    End If
'
'    frmMain.sbStatusBar.Panels(1).Text = "Running Query..."
'    frmMain.Refresh
'    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
'
'    If Not DaoRS.EOF Then
'
'        While Not DaoRS.EOF
'
'                Set itmX = frmMain.lvListView.ListItems.Add(, , CStr(DaoRS(0).Value))
'
'                If (DaoRS(1).Value = Null) Then
'                    itmX.SubItems(1) = " "
'                Else
'                    itmX.SubItems(1) = RTrim(DaoRS(1).Value)
'                End If
'
'                itmX.SubItems(2) = RTrim(DaoRS(2).Value)
'                itmX.SubItems(3) = DaoRS(3).Value
'                itmX.SubItems(4) = DaoRS(4).Value
'                itmX.SubItems(5) = DaoRS(5).Value
'                itmX.SubItems(6) = DaoRS(6).Value
'                itmX.SubItems(7) = DaoRS(7).Value
'                itmX.SubItems(8) = DaoRS(8).Value
'
'                If (CurTableType <> WES_CODE) Then
'
'                    If ((Not DaoRS(9).Value = vbNullChar) And (Not DaoRS(9).Value = "Null")) Then
'                        itmX.SubItems(9) = CStr(DaoRS(9).Value)
'                    Else
'                        itmX.SubItems(9) = " "
'                    End If
'
'                    If (CurTableType = CODES_TABLE) Then
'                        If ((Not DaoRS(10).Value = vbNullChar) And (Not DaoRS(10).Value = "Null")) Then
'                            itmX.SubItems(10) = CStr(DaoRS(10).Value)
'                        Else
'                            itmX.SubItems(10) = " "
'                        End If
'                    End If
'                End If
'
'                frmMain.sbStatusBar.Refresh
'
'                KeyCntr = KeyCntr + 1
'                DaoRS.MoveNext
'        Wend
'
'    End If
'
'    frmMain.sbStatusBar.Panels(1).Text = " "
'    frmMain.txtTotalKeys.Text = KeyCntr
'
'    DaoRS.Close
'
'Exit Sub
'
'
'ODBCError:
'    Dim msg As String, RC As Integer
'
'    msg = "An error has occured while loading Keys & Decodes." & vbCrLf & _
'          "Error number = " & Err.Number & vbCrLf & _
'          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
'          "Contact " & AUTHOR & " for assistance."
'
'    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
'    Err.Clear
'
'    Unload frmMain


End Sub

'**********************************************************************
Public Function ParseString(ByVal SrcString As String, _
                            Delimiter As String, _
                            Position As Integer) As String
'**********************************************************************
    Dim s As Integer, delpos As Integer
    
    SrcString = SrcString & Delimiter
    
    If Position = 0 Then Position = 1
    
    For s% = 1 To Position - 1
        delpos% = InStr(SrcString, Delimiter)
        SrcString = Mid$(SrcString, delpos% + 1, Len(SrcString))
    Next s%
    
    delpos% = InStr(SrcString, Delimiter)
    
    If delpos% = 0 Then delpos% = Len(SrcString) + 1
    
    ParseString = Left$(SrcString, delpos% - 1)

End Function


'***************************************************************************************************************
Public Sub GetClientCBox(cboSource As Control)
'***************************************************************************************************************

    ReDim ClientArray(0)

    cboSource.Enabled = False
    cboSource.Clear
    Screen.MousePointer = vbHourglass

     strsql = "Select Client, Code " _
            & " From tblClients " _
            & " Order By Code"

    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then

        While Not DaoRS.EOF
            cboSource.AddItem DaoRS(0).Value
            ClientArray(UBound(ClientArray)).Client = DaoRS(0).Value
            ClientArray(UBound(ClientArray)).Code = DaoRS(1).Value
            ReDim Preserve ClientArray(UBound(ClientArray) + 1)
            DaoRS.MoveNext
        Wend

        DaoRS.Close
        cboSource.ListIndex = 0
    End If

    Screen.MousePointer = vbNormal

    'Enable the combo box.
    cboSource.Enabled = True

End Sub


'***************************************************************************************************************
Public Sub GetButtonCBox(cboSource As Control)
'***************************************************************************************************************

    ReDim ButtonsArray(0)

    cboSource.Enabled = False
    cboSource.Clear
    Screen.MousePointer = vbHourglass

    strsql = "SELECT Buttons, [Button ID] " _
           & " From tblMsgBoxButtons " _
           & " ORDER BY [Button ID]"

    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then

        While Not DaoRS.EOF
            cboSource.AddItem DaoRS(0).Value
            ButtonsArray(UBound(ButtonsArray)).Buttons = DaoRS(0).Value
            ButtonsArray(UBound(ButtonsArray)).ButtonID = DaoRS(1).Value
            ReDim Preserve ButtonsArray(UBound(ButtonsArray) + 1)
            DaoRS.MoveNext
        Wend

        DaoRS.Close
        cboSource.ListIndex = 0
    End If

    Screen.MousePointer = vbNormal

    'Enable the combo box.
    cboSource.Enabled = True

End Sub


'***************************************************************************************************************
Public Sub GetIconCBox(cboSource As Control)
'***************************************************************************************************************

    ReDim IconArray(0)

    cboSource.Enabled = False
    cboSource.Clear
    Screen.MousePointer = vbHourglass

    strsql = "SELECT Icon, [Icon ID] " _
           & " From tblMsgBoxIcons " _
           & "ORDER BY [Icon ID]"

    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then

        While Not DaoRS.EOF
            cboSource.AddItem DaoRS(0).Value
            IconArray(UBound(IconArray)).Icon = DaoRS(0).Value
            IconArray(UBound(IconArray)).IconID = DaoRS(1).Value
            ReDim Preserve IconArray(UBound(IconArray) + 1)
            DaoRS.MoveNext
        Wend

        DaoRS.Close
        cboSource.ListIndex = 0
    End If

    Screen.MousePointer = vbNormal

    'Enable the combo box.
    cboSource.Enabled = True

End Sub


'***************************************************************************************************************
Public Sub GetDefaultButtonCBox(cboSource As Control)
'***************************************************************************************************************

    ReDim DefaultButtonArray(0)

    cboSource.Enabled = False
    cboSource.Clear
    Screen.MousePointer = vbHourglass

    strsql = "SELECT [Defualt Button], [Default Button ID] " _
           & " From tblMsgBoxDefaultButtons " _
           & " ORDER BY [Default Button ID]"

    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then

        While Not DaoRS.EOF
            cboSource.AddItem DaoRS(0).Value
            DefaultButtonArray(UBound(DefaultButtonArray)).DefaultButton = DaoRS(0).Value
            DefaultButtonArray(UBound(DefaultButtonArray)).DefaultButtonID = DaoRS(1).Value
            ReDim Preserve DefaultButtonArray(UBound(DefaultButtonArray) + 1)
            DaoRS.MoveNext
        Wend

        DaoRS.Close
        cboSource.ListIndex = 0
    End If

    Screen.MousePointer = vbNormal

    'Enable the combo box.
    cboSource.Enabled = True

End Sub


'***************************************************************************************************************
Public Sub GetApplicationCBox(cboSource As Control)
'***************************************************************************************************************

    ReDim ApplicationArray(0)

    cboSource.Enabled = False
    cboSource.Clear
    Screen.MousePointer = vbHourglass

    strsql = "SELECT Application, Code " _
           & " From tblApplications " _
           & " ORDER BY Code"

    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then

        While Not DaoRS.EOF
            cboSource.AddItem DaoRS(0).Value
            ApplicationArray(UBound(ApplicationArray)).Application = DaoRS(0).Value
            ApplicationArray(UBound(ApplicationArray)).Code = DaoRS(1).Value
            ReDim Preserve ApplicationArray(UBound(ApplicationArray) + 1)
            DaoRS.MoveNext
        Wend

        DaoRS.Close
        cboSource.ListIndex = 0
    End If

    Screen.MousePointer = vbNormal

    'Enable the combo box.
    cboSource.Enabled = True

End Sub

'***************************************************************************************************************
Public Sub GetPlatformCBox(cboSource As Control)
'***************************************************************************************************************

    ReDim PlatformArray(0)

    cboSource.Enabled = False
    cboSource.Clear
    Screen.MousePointer = vbHourglass

    strsql = "SELECT Platform, Code " _
           & " From tblPlatforms " _
           & " ORDER BY Code"

    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then

        While Not DaoRS.EOF
            cboSource.AddItem DaoRS(0).Value
            PlatformArray(UBound(PlatformArray)).Platform = DaoRS(0).Value
            PlatformArray(UBound(PlatformArray)).Code = DaoRS(1).Value
            ReDim Preserve PlatformArray(UBound(PlatformArray) + 1)
            DaoRS.MoveNext
        Wend

        DaoRS.Close
        cboSource.ListIndex = 0
    End If

    Screen.MousePointer = vbNormal

    'Enable the combo box.
    cboSource.Enabled = True

End Sub

'***************************************************************************************************************
Public Sub GetReleaseCBox(cboSource As Control)
'***************************************************************************************************************

    ReDim ReleaseArray(0)

    cboSource.Enabled = False
    cboSource.Clear
    Screen.MousePointer = vbHourglass

    strsql = "SELECT Release, Code " _
           & " From tblReleases " _
           & " ORDER BY Code"

    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then

        While Not DaoRS.EOF
            cboSource.AddItem DaoRS(0).Value
            ReleaseArray(UBound(ReleaseArray)).Release = DaoRS(0).Value
            ReleaseArray(UBound(ReleaseArray)).Code = DaoRS(1).Value
            ReDim Preserve ReleaseArray(UBound(ReleaseArray) + 1)
            DaoRS.MoveNext
        Wend

        DaoRS.Close
        cboSource.ListIndex = 0
    End If

    Screen.MousePointer = vbNormal

    'Enable the combo box.
    cboSource.Enabled = True

End Sub

