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
Public strSQL As String

'***************************************************************************************************************
'** TYPE DECLARATIONS                                                                                         **
'***************************************************************************************************************

'Table type information
Type TableType
    TableTypeName As String
    TableTypeCode As Integer
End Type

Public TableTypes() As TableType


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
    Dim x As Integer

    frmMain.sbStatusBar.Panels(1).Text = "Retrieving Keys for " & RTrim(Node.Text) & "..."
    frmMain.txtDecodeLength.Text = ""
    frmMain.txtDecodeDisplacement.Text = ""
    frmMain.txtDataLength.Text = ""
    frmMain.txtKeyLength.Text = ""
    frmMain.txtCenturyDelim.Text = ""
    frmMain.chkSystem.Value = False
    frmMain.chkStatic.Value = False
    frmMain.chkCodes.Value = False
        
    frmMain.mnuPrintTable.Enabled = False
    frmMain.mnuDeleteTable.Enabled = False
    frmMain.mnuModifyTable.Enabled = False
    frmMain.mnuGenerate.Enabled = False
    
    Screen.MousePointer = vbHourglass
    
    'If this is the top node then exit.
    If (Node.Key = "Base") Then
        frmMain.lvListView.ListItems.Clear
        frmMain.sbStatusBar.Panels(1).Text = ""
        frmMain.txtTotalKeys.Text = ""
        Screen.MousePointer = vbNormal
        frmMain.Refresh
        Exit Sub
    End If
    
    'If this a + node then don't do anything.
    For x = 0 To UBound(TableTypes)
        If (Node.Key = TableTypes(x).TableTypeName) Then
            frmMain.lvListView.ListItems.Clear
            frmMain.sbStatusBar.Panels(1).Text = ""
            frmMain.txtTotalKeys.Text = ""
            Screen.MousePointer = vbNormal
            frmMain.Refresh
            Exit Sub
        End If
    Next
    
    'Get the parent table type code for this node.
    For x = 0 To UBound(TableTypes)
        If (Node.Parent = TableTypes(x).TableTypeName) Then
            CurTableType = TableTypes(x).TableTypeCode
            Exit For
        End If
    Next
    
    
    'Get all the Keys and decodes.
    Call RefreshCodeDecodeLB
    
    'Save the current table to a global variable.
    CurTable = Node.Text
    CurKey = ""
    
    'Enable the delete Table Key.
    frmMain.mnuDeleteTable.Enabled = True
    frmMain.mnuModifyTable.Enabled = True
                 
    'If this is a Codes table, then enable printing and generation.
    'If (Left(frmMain.tvTreeView.SelectedItem.Text, 3) = "CIS") Then
    If (CurTableType = 1) Then
        frmMain.mnuPrintTable.Enabled = True
        frmMain.mnuGenerate.Enabled = True
    End If
    
    'Enable the check boxes.
    frmMain.chkSystem.Enabled = True
    frmMain.chkStatic.Enabled = True
    frmMain.chkCodes.Enabled = True
        
    strSQL = "select Description, DecodeLen, DecodeDisplacement, " & _
             "DataLen, KeyLen, SystemUse, StaticTableUse, CodesTableUse, CenturyDelim " & _
             "from tblTables where TableName = " & Chr(39) & Node.Text & Chr(39)
     
    Debug.Print strSQL
        
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then
        
        If Not (DaoRS(0).Value = vbNullChar) Then
            frmMain.sbStatusBar.Panels(1).Text = DaoRS(0)
        Else
            frmMain.sbStatusBar.Panels(1).Text = "No Description Available"
        End If
                    
        frmMain.txtDecodeLength.Text = CStr(DaoRS(1).Value)
            
        If (IsNull(DaoRS(2).Value)) Then
            frmMain.txtDecodeDisplacement.Text = " "
        Else
            frmMain.txtDecodeDisplacement.Text = CStr(DaoRS(2).Value)
        End If
            
        frmMain.txtDataLength.Text = CStr(DaoRS(3).Value)
        frmMain.txtKeyLength.Text = CStr(DaoRS(4).Value)
            
        If DaoRS(5).Value Then
            frmMain.chkSystem.Value = 1
        Else
            frmMain.chkSystem.Value = 0
        End If
            
        If DaoRS(6).Value Then
            frmMain.chkStatic.Value = 1
        Else
            frmMain.chkStatic.Value = 0
        End If
            
        If DaoRS(7).Value Then
            frmMain.chkCodes.Value = 1
        Else
            frmMain.chkCodes.Value = 0
        End If
        
        If (IsNull(DaoRS(8).Value)) Then
            frmMain.txtCenturyDelim.Text = ""
        Else
            frmMain.txtCenturyDelim.Text = DaoRS(8).Value
        End If
        
        DaoRS.Close
    End If
    
    'refresh the screen.
    Screen.MousePointer = vbNormal
    frmMain.Refresh

End Sub



'***************************************************************************************************************
Public Sub BuildTableList()
'***************************************************************************************************************
    Dim nodx As Node, x As Integer

    'Clear the control.
    frmMain.tvTreeView.Nodes.Clear
    
    'Set up the base treeview node.
    Set nodx = frmMain.tvTreeView.Nodes.Add(, , "Base", "Table Types")
    
    ReDim TableTypes(0)
    
    'Build the list of possible table types
    strSQL = "select distinct TableTypeCode, Decode From tblTableCodes order by TableTypeCode"
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            TableTypes(UBound(TableTypes)).TableTypeCode = DaoRS(0).Value
            TableTypes(UBound(TableTypes)).TableTypeName = DaoRS(1).Value
        
            Set nodx = frmMain.tvTreeView.Nodes.Add("Base", 4, _
                                                     TableTypes(UBound(TableTypes)).TableTypeName, _
                                                     TableTypes(UBound(TableTypes)).TableTypeName)
        
            ReDim Preserve TableTypes(UBound(TableTypes) + 1)
            DaoRS.MoveNext
        Wend
    
        DaoRS.Close
    End If
    
    frmMain.Refresh
    
    For x = 0 To UBound(TableTypes)
    
        'Build the tree control with all the tables available within the CTM database.
        strSQL = "Select TableName From tblTables where TableType = " & TableTypes(x).TableTypeCode & _
                         " order by TableName"

        Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
        If Not DaoRS.EOF Then
            
            While Not DaoRS.EOF
            
                Set nodx = frmMain.tvTreeView.Nodes.Add(TableTypes(x).TableTypeName, 4, _
                                                        DaoRS!TableName.Value, _
                                                        DaoRS!TableName.Value)
                nodx.Sorted = True
                
                DaoRS.MoveNext
            Wend
        
            frmMain.tvTreeView.Nodes(1).Expanded = True
            frmMain.Refresh
            DaoRS.Close
        End If
    Next

End Sub


'***************************************************************************************************************
Public Function CheckKeyExists(ByVal TableName As String, _
                               ByVal Key As String, _
                               ByVal Client As Integer) As Boolean
'***************************************************************************************************************
    
    'Put together the sql to perform the check.
    strSQL = "SELECT 1 FROM tblEntries WHERE TableName = " & Chr(39) & TableName & Chr(39) & " " & _
             "AND Key = " & Chr(39) & Key & Chr(39) & "AND Client = " & Client
    Debug.Print strSQL
    
    'Open the recordset.
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
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
    
    strSQL = "select 1 from tblAdmin where AdminName = " & Chr(39) & CurrentUser & Chr(39)

    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    'If something was returned then the current user is on the admin table. Otherwise
    If (DaoRS.RecordCount = 1) Then
        CheckAuthorityLevel = True
    Else
        CheckAuthorityLevel = False
    End If

    DaoRS.Close
    
End Function



'*********************************************************************************************************
Public Function FormatDecode(Decode As String) As String
'*********************************************************************************************************
    Dim pos As Integer
    
    pos = InStr(Decode, "'")
    
    If pos > 0 Then
        FormatDecode = Left(Decode, pos - 1) & "'" & Mid(Decode, pos, Len(Decode))
    Else
        FormatDecode = Decode
    End If

End Function


'*********************************************************************************************************
Public Sub RefreshCodeDecodeLB()
'*********************************************************************************************************
    Dim itmX As ListItem, cnt As Integer
    
    KeyCntr = 0
    
    frmMain.lvListView.ListItems.Clear


    On Error GoTo ODBCError
    
    If (CurTableType = CODES_TABLE) Then
        strSQL = "SELECT tblEntries.Key, tblEntries.Decode, tblClients.Client, " & _
                 "tblPlatforms.Platform,  tblReleases.Release, " & _
                 "tblEntries.SystemUse,  tblEntries.StaticTableUse,  tblEntries.CodesTableUse, " & _
                 "tblEntries.Description " & _
                 "FROM tblEntries, tblClients, tblPlatforms, tblReleases " & _
                 "WHERE tblEntries.TableName = " & Chr(39) & frmMain.tvTreeView.SelectedItem.Text & Chr(39) & " AND " & _
                 "tblClients.Code = tblEntries.Client and tblPlatforms.Code = tblEntries.Platform AND " & _
                 "tblReleases.Code = tblEntries.CSSRelease " & _
                 "ORDER BY tblEntries.Key ASC"
    
    
    ElseIf (CurTableType = MSG_BOX) Then
        strSQL = "SELECT tblMsgBoxEntries.Code, tblMsgBoxEntries.MsgBoxText, " & _
                 "tblClients.Client, tblPlatforms.Platform, tblReleases.Release, tblMsgBoxEntries.Comments " & _
                 "FROM tblMsgBoxEntries, tblClients, tblPlatforms, tblReleases " & _
                 "WHERE tblMsgBoxEntries.TableName = " & Chr(39) & frmMain.tvTreeView.SelectedItem.Text & Chr(39) & " AND " & _
                 "tblClients.Code = tblMsgBoxEntries.Client and tblPlatforms.Code = tblMsgBoxEntries.Platform AND " & _
                 "tblReleases.Code = tblMsgBoxEntries.CSSRelease " & _
                 "ORDER BY tblMsgBoxEntries.Code ASC"
 
    Else
        strSQL = "SELECT tblUserErrorMsgEntries.ErrorNumber,  tblUserErrorMsgEntries.ErrorCode, " & _
                 "tblClients.Client, tblPlatforms.Platform,  tblReleases.Release, " & _
                 "tblUserErrorMsgEntries.Coments, tblUserErrorMsgEntries.SequenceNumber " & _
                 "FROM tblUserErrorMsgEntries, tblClients, tblPlatforms, tblReleases " & _
                 "WHERE tblUserErrorMsgEntries.TableName = " & Chr(39) & frmMain.tvTreeView.SelectedItem.Text & Chr(39) & " AND " & _
                 "tblClients.Code = tblUserErrorMsgEntries.Client and tblPlatforms.Code = tblUserErrorMsgEntries.Platform AND " & _
                 "tblReleases.Code = tblUserErrorMsgEntries.CSSRelease " & _
                 "ORDER BY tblUserErrorMsgEntries.ErrorNumber ASC, tblUserErrorMsgEntries.SequenceNumber ASC"
    End If
    
    Debug.Print strSQL
    
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then
    
        While Not DaoRS.EOF
             Set itmX = frmMain.lvListView.ListItems.Add(, , CStr(DaoRS(0).Value))
                
                If (DaoRS(1).Value = vbNullChar) Then
                    itmX.SubItems(1) = " "
                Else
                    itmX.SubItems(1) = RTrim(DaoRS(1).Value)
                End If
                
                itmX.SubItems(2) = RTrim(DaoRS(2).Value)
                itmX.SubItems(3) = DaoRS(3).Value
                itmX.SubItems(4) = DaoRS(4).Value
                
                If (CurTableType = CODES_TABLE) Then
                    itmX.SubItems(5) = DaoRS(5).Value
                    itmX.SubItems(6) = DaoRS(6).Value
                    itmX.SubItems(7) = DaoRS(7).Value
                
                    If ((Not DaoRS(8).Value = vbNullChar) And (Not DaoRS(8).Value = "Null")) Then
                        itmX.SubItems(8) = CStr(DaoRS(8).Value)
                    Else
                        itmX.SubItems(8) = " "
                    End If
                
                Else
                    itmX.SubItems(5) = False
                    itmX.SubItems(6) = False
                    itmX.SubItems(7) = False
                    
                    If ((Not DaoRS(5).Value = vbNullChar) And (Not DaoRS(5).Value = "Null")) Then
                        itmX.SubItems(8) = DaoRS(5).Value
                    Else
                        itmX.SubItems(8) = " "
                    End If
                End If
                    
                KeyCntr = KeyCntr + 1
                DaoRS.MoveNext
            Wend
    
        DaoRS.Close
        
        'Update the total number of keys.
        frmMain.txtTotalKeys.Text = KeyCntr
        frmMain.sbStatusBar.Panels(1).Text = "No Description Available"
    End If

Exit Sub


ODBCError:
    Dim msg As String, RC As Integer
    
    msg = "An error has occured while loading Keys & Decodes." & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    
    Debug.Print Err.Number
    Debug.Print Err.Description
    
    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
    Err.Clear
    
    Unload frmMain


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
Public Function GetButtonCode(strButton As String) As Integer
'***************************************************************************************************************
    strSQL = "select [Button ID] From tblMsgBoxButtons where Buttons = 'FND_MSGBOX_" & strButton & Chr(39)
                
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
            
    If Not DaoRS.EOF Then
        GetButtonCode = DaoRS(0)
    Else
        'Default to just the OK button if nothing was found.
        GetButtonCode = 1
    End If
            
    DaoRS.Close
End Function

'***************************************************************************************************************
Public Function GetIconCode(strIcon As String) As Integer
'***************************************************************************************************************
    strSQL = "select [Icon ID] From tblMsgBoxIcons where Icon = 'FND_MSGBOX_" & strIcon & Chr(39)
                
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
            
    If Not DaoRS.EOF Then
        GetIconCode = DaoRS(0)
    Else
                
        'Default to the information icon.
        GetIconCode = 4
    End If
            
    DaoRS.Close

End Function


'***************************************************************************************************************
Public Function GetDefaultButtonCode(strButton As String) As Integer
'***************************************************************************************************************
    strSQL = "select [Default Button ID] From tblMsgBoxDefaultButtons where [Defualt Button] = 'FND_MSGBOX_" & strButton & Chr(39)
                
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
            
    If Not DaoRS.EOF Then
        GetDefaultButtonCode = DaoRS(0)
    Else
        'Default to the ok button.
        GetDefaultButtonCode = 1
    End If
            
    DaoRS.Close
    
End Function


'***************************************************************************************************************
Public Function GetClientDecode(strClient As String) As Integer
'***************************************************************************************************************
    strSQL = "select Code From tblClients where Client = " & Chr(39) & strClient & Chr(39)
                
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
            
    If Not DaoRS.EOF Then
        GetClientDecode = DaoRS(0)
        DaoRS.Close
    Else
        GetClientDecode = SQL_NOT_FOUND
    End If

End Function

