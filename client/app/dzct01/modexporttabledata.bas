Attribute VB_Name = "modExportTableData"
Public nClient As Integer, nAppl As Integer, nPlatform As Integer, nRelease As Integer
Public FileNumber As Integer

'***************************************************************************************************************
Public Sub ExportProcedure()
'***************************************************************************************************************
    Dim TableSet As Recordset
    Dim SysFlg As Integer, TblCnt As Integer
    Dim RetVal As Variant
    Dim msg As String
    Dim FileName As String
    Dim SQLquery As String
    Dim MsgText As String
    Dim MyCIS As String
    Dim Table As String
    Dim x As Integer
    Const ALL = 1
    Const CIS = 3

    On Error GoTo Err_Export

    TblCnt = 0   ' Exported table counter
    FileNumber = FreeFile
    
    'Check to see if this directory exists.
    If (Dir(frmExportTable.efPath, vbDirectory) = "") Then
        RetVal = MessageBox(frmExportTable.hwnd, _
                            "The directory, " & frmExportTable.efPath & ", does not currently exist." & vbCrLf & "Would you like to create it?", _
                            "Codes Table Update", _
                            MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON1)
        If (RetVal = IDNO) Then
            frmExportTable.efPath.SetFocus
            Exit Sub
        Else
            MkDir (frmExportTable.efPath)
        End If
    End If

    frmExportTable.Refresh
    
    
    For x = 0 To frmExportTable.SelectTable.ListCount - 1
        If (frmExportTable.SelectTable.Selected(x) = True) Then
            If (frmExportTable.SelectTable.SelCount = 1) Then
                FileName = frmExportTable.efPath & "\" & frmExportTable.efExportFile
            ElseIf (frmExportTable.SelectTable.SelCount > 1) Then
                FileName = frmExportTable.efPath & "\" & LCase(Trim$(frmExportTable.SelectTable.List(x))) & ".dat"
            End If
            
            'Check to see if the file DOES exist.
            If (Not Dir(FileName, vbNormal) = "") Then
                If (frmExportTable.optCreateFile) Then
                    RetVal = MessageBox(frmExportTable.hwnd, _
                                        "The export file, " & Trim$(frmExportTable.SelectTable.List(x)) & ".DAT, already exists." & vbCrLf & _
                                        "Would you like to overwrite it?", _
                                        "Codes Table Update", _
                                        MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON1)
                    If (RetVal = IDYES) Then
                        Open FileName For Output As #FileNumber
                    Else
                        frmExportTable.efPath.SetFocus
                        Exit Sub
                    End If
                Else
                    Open FileName For Append As #FileNumber
                End If
    
            'The file does NOT exist.
            Else
                If (frmExportTable.optAppendFile) Then
                    RetVal = MessageBox(frmExportTable.hwnd, _
                                        "The export file, " & Trim$(frmExportTable.SelectTable.List(x)) & ".DAT, does not exist." & vbCrLf & "Would you like to create it?", _
                                        "Codes Table Update", _
                                        MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON1)
                            
                    If (RetVal = IDYES) Then
                        Open FileName For Output As #FileNumber
                    Else
                        frmExportTable.efPath.SetFocus
                        Exit Sub
                    End If
                Else
                    Open FileName For Output As #FileNumber
                End If
    
            End If
        
            frmExportTable.Refresh

            'Get the client code value.
            strsql = "select Code from tblClients where Client = " & Chr(34) & frmExportTable.cbClient.Text & Chr(34)
            Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
            If Not DaoRS.EOF Then
                nClient% = DaoRS(0).Value
                DaoRS.Close
            End If
    
            'Get the release code.
'            strsql = "select Code from tblReleases where Release = " & Chr(34) & frmExportTable.cbRelease.Text & Chr(34)
'            Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
'
'            If Not DaoRS.EOF Then
'                nRelease% = DaoRS(0).Value
'                DaoRS.Close
'            End If
                 nRelease% = 0
            'Get the platform code.
'            strsql = "select Code from tblPlatforms where Platform = " & Chr(34) & frmExportTable.cbPlatform.Text & Chr(34)
'            Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
'
'            If Not DaoRS.EOF Then
'                nPlatform% = DaoRS(0).Value
'                DaoRS.Close
'            End If
                 nPlatform% = 0
            'Get the application code.
'            strsql = "select Code from tblApplications where Application = " & Chr(34) & frmExportTable.cbApplication.Text & Chr(34)
'            Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
'
'            If Not DaoRS.EOF Then
'                nAppl% = DaoRS(0).Value
'                DaoRS.Close
'            End If
                 nAppl% = 0
            strsql = "SELECT * from tblTables where TableName = " & _
                     Chr(34) & frmExportTable.SelectTable.List(x) & Chr(34)
    
            Set TableSet = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
        
            If Not IsEmpty(TableSet!TableName) Then
                ExportOneTable TableSet
    
                ' Export all the entries of the current table
                Select Case TableSet!TableType  ' Type of Table defines the export
                    Case 1  ' Export regular Entries
                        ExportCodesTable TableSet
                    Case 2  ' Export Msg Box Entries
                        ExportMsgBoxTable TableSet
                    Case 3  ' Export User Codes for WES map
                        ExportUserErrTable TableSet
                    Case Else
                        msg = "Table name '" & TableSet!TableName & "' has invalid type: " & TableSet!TableType
                        MsgBox msg
                        RetVal = MessageBox(frmExportTable.hwnd, _
                                            msg, _
                                            "Codes Table Update", _
                                            MB_OK Or MB_ICONHAND)
                End Select
                TblCnt = TblCnt + 1
            End If
        End If
        Close #FileNumber
    Next
    
    
    RetVal = MessageBox(frmExportTable.hwnd, _
                        "A total of " & TblCnt & " table(s) were successfully exported to their respective .dat file(s).", _
                        "Codes Table Update", _
                        MB_OK Or MB_ICONINFORMATION)


Exit_Export:
    Screen.MousePointer = vbNormal
    Exit Sub

Err_Export:
    'MsgBox Error$
    MsgBox "An error occured while exporting.", 64, Title
    MsgText = "Export Failed!"
    Resume Exit_Export

End Sub

'***************************************************************************************************************
Public Sub ExportCodesTable(TblData As Recordset)
'***************************************************************************************************************
    ' This procedure export all the entries for the Codes table selection
    Dim SQLquery As String, EntrySet As Recordset
    Dim Descript As String * 370
    Dim ctr As Integer
    Const CMN = 0
    Const CSS = 6
    Const ALL = 1
    Const CIS = 3
    
    SQLquery = "SELECT * FROM tblEntries WHERE TableName = '" & TblData!TableName & "' ORDER BY Application, Client, CSSRelease, Platform, Key;"
    Set EntrySet = dbCTM.OpenRecordset(SQLquery)
    
    If EntrySet.EOF Then
        Exit Sub
    End If

    EntrySet.MoveFirst

    If ((frmExportTable.optExportAll) Or (frmExportTable.optExportCISOnly)) Then
        
        Do Until EntrySet.EOF

            If EntrySet!Application <> CMN And EntrySet!Application <> nAppl Then
                GoTo Continue_LOOP0
            End If

            If EntrySet!CSSRelease <> CMN And EntrySet!CSSRelease <> nRelease Then
                GoTo Continue_LOOP0
            End If

            If EntrySet!Platform <> CMN And EntrySet!Platform <> nPlatform Then
                GoTo Continue_LOOP0
            End If
            
            If EntrySet!Client = CSS Then
                GoTo Continue_LOOP0
            End If

            ' If the current entry is valid for export - output to the file
            Print #FileNumber, "R2" & Format$(TblData!TableName, "!@@@@@@@@");

            If IsNull(EntrySet!Key) Then
                Print #FileNumber, Space$(21);
            Else
                Print #FileNumber, Format$(EntrySet!Key, "!@@@@@@@@@@@@@@@@@@@@@");
            End If

            If IsNull(EntrySet!EffDateSign) Then
                Print #FileNumber, " ";
            Else
                Print #FileNumber, Format$(EntrySet!EffDateSign, "@");
            End If

            If IsNull(EntrySet!EffDate) Then
                Print #FileNumber, Space$(8);
            Else
                Print #FileNumber, Format$(EntrySet!EffDate, "@@@@@@@@");
            End If

            If IsNull(EntrySet!Decode) Then
                Print #FileNumber, Space$(370)
            Else
                Descript = EntrySet!Decode
                Print #FileNumber, Descript
            End If
Continue_LOOP0: ' Continue with the loop with no processing
        EntrySet.MoveNext

        Loop

    Else

        Do Until EntrySet.EOF
            If EntrySet!Client <> CMN And EntrySet!Client <> nClient Then
                GoTo Continue_LOOP1
            End If

            If EntrySet!Application <> CMN And EntrySet!Application <> nAppl Then
                GoTo Continue_LOOP1
            End If

            If EntrySet!CSSRelease <> CMN And EntrySet!CSSRelease <> nRelease Then
                GoTo Continue_LOOP1
            End If

            If EntrySet!Platform <> CMN And EntrySet!Platform <> nPlatform Then
                GoTo Continue_LOOP1
            End If

            ' If the current entry is valid for export - output to the file
            Print #FileNumber, "R2" & Format$(TblData!TableName, "!@@@@@@@@");

            If IsNull(EntrySet!Key) Then
                Print #FileNumber, Space$(21);
            Else
                Print #FileNumber, Format$(EntrySet!Key, "!@@@@@@@@@@@@@@@@@@@@@");
            End If

            If IsNull(EntrySet!EffDateSign) Then
                Print #FileNumber, " ";
            Else
                Print #FileNumber, Format$(EntrySet!EffDateSign, "@");
            End If

            If IsNull(EntrySet!EffDate) Then
                Print #FileNumber, Space$(8);
            Else
                Print #FileNumber, Format$(EntrySet!EffDate, "@@@@@@@@");
            End If

            If IsNull(EntrySet!Decode) Then
                Print #FileNumber, Space$(370)
            Else
                Descript = EntrySet!Decode
                Print #FileNumber, Descript
            End If

   
Continue_LOOP1: ' Continue with the loop with no processing
        EntrySet.MoveNext
    Loop

    End If
    EntrySet.Close

End Sub

'***************************************************************************************************************
Public Sub ExportMsgBoxTable(TblData As Recordset)
'***************************************************************************************************************

    ' This procedure export all the entries for the Msg Box selection
    Dim SQL1 As String, MsgSet As Recordset, Value As String
    Dim Description As String * 370, StrCode As String * 6
    Const CMN = 0

    SQL1 = "SELECT * FROM tblMsgBoxEntries WHERE TableName = '" & TblData!TableName & "' ORDER BY Application, Client, CSSRelease, Platform, Code;"
    Set MsgSet = dbCTM.OpenRecordset(SQL1)

    If MsgSet.EOF Then
        Exit Sub
    End If

    MsgSet.MoveFirst
    Do Until MsgSet.EOF
        If MsgSet!Client <> CMN And MsgSet!Client <> nClient Then
            GoTo Continue_LOOP2
        End If

        If MsgSet!Application <> CMN And MsgSet!Application <> nAppl Then
            GoTo Continue_LOOP2
        End If

        If MsgSet!CSSRelease <> CMN And MsgSet!CSSRelease <> nRelease Then
            GoTo Continue_LOOP2
        End If

        If MsgSet!Platform <> CMN And MsgSet!Platform <> nPlatform Then
            GoTo Continue_LOOP2
        End If

        ' If the current entry is valid for export - output to the file
        Print #FileNumber, "R2"; Format$(TblData!TableName, "!@@@@@@@@");

        If IsEmpty(MsgSet!Code) Or IsNull(MsgSet!Code) Then
            Print #FileNumber, Space$(30);
        Else
            Print #FileNumber, Format$(MsgSet!Code, "!@@@@@@"); Space$(24);
        End If

        If IsEmpty(MsgSet!Buttons) Or IsNull(MsgSet!Buttons) Then
            Value = "1|"
        Else
            Value = Str$(MsgSet!Buttons) & "|"
        End If

        If IsEmpty(MsgSet!Icon) Or IsNull(MsgSet!Icon) Then
            Value = Value & "0|"
        Else
            Value = Value & Str$(MsgSet!Icon) & "|"
        End If

        If IsEmpty(MsgSet!DefaultButton) Or IsNull(MsgSet!DefaultButton) Then
            Value = Value & "1|"
        Else
            Value = Value & Str$(MsgSet!DefaultButton) & "|"
        End If

        If IsEmpty(MsgSet!MsgBoxText) = False Or IsNull(MsgSet!MsgBoxText) = False Then
            Value = Value & MsgSet!MsgBoxText
        End If
        Description = Value
        Print #FileNumber, Description

Continue_LOOP2: ' Continue with the loop with no processing
        MsgSet.MoveNext
    Loop
    MsgSet.Close


End Sub

'***************************************************************************************************************
Public Sub ExportOneTable(TableData As Recordset)
'***************************************************************************************************************
    Print #FileNumber, "R1"; Format$(TableData!TableName, "!@@@@@@@@"); Spc(21);
    If IsEmpty(TableData!DecodeLen) Or IsNull(TableData!DecodeLen) Then
        Print #FileNumber, Spc(5);
    Else
        Print #FileNumber, Format$(TableData!DecodeLen, "00000");
    End If

    If IsEmpty(TableData!DecodeDisplacement) Or IsNull(TableData!DecodeDisplacement) Then
        Print #FileNumber, Spc(5);
    Else
        Print #FileNumber, Format$(TableData!DecodeDisplacement, "00000");
    End If

    If TableData!EffDate = True Then
        Print #FileNumber, "Y";
    Else
        Print #FileNumber, "N";
    End If

    If TableData!Residency = True Then
        Print #FileNumber, "Y";
    Else
        Print #FileNumber, "N";
    End If

    If IsEmpty(TableData!DataLen) Or IsNull(TableData!DataLen) Then
        Print #FileNumber, Spc(5);
    Else
        Print #FileNumber, Format$(TableData!DataLen, "00000");
    End If

    If IsEmpty(TableData!KeyLen) Or IsNull(TableData!KeyLen) Then
        Print #FileNumber, Spc(5);
    Else
        Print #FileNumber, Format$(TableData!KeyLen, "00000");
    End If

    If IsEmpty(TableData!CenturyDelim) Or IsNull(TableData!CenturyDelim) Then
        Print #FileNumber, Spc(2);
    Else
        Print #FileNumber, Format$(TableData!CenturyDelim, "00");
    End If

    If IsEmpty(TableData!Class) Or IsNull(TableData!Class) Then
        Print #FileNumber, "  ";
    Else
        Print #FileNumber, Format$(TableData!Class, "@@");
    End If

    Print #FileNumber, Space$(353);
    Print #FileNumber,
End Sub

'***************************************************************************************************************
Public Sub ExportUserErrTable(TblData As Recordset)
'***************************************************************************************************************
    ' This procedure export all the entries for the User Codes WES Errors selection
    Dim SQL1 As String, UsrSet As Recordset, Value As String
    Dim ErrorMsg As String * 389
    Const CMN = 0

    SQL1 = "SELECT * FROM tblUserErrorMsgEntries WHERE TableName = '" & TblData!TableName & "' ORDER BY Application, Client, CSSRelease, Platform, ErrorNUmber;"
    Set UsrSet = dbCTM.OpenRecordset(SQL1)

    If UsrSet.EOF Then
        Exit Sub
    End If
    
    UsrSet.MoveFirst
    Do Until UsrSet.EOF
        If UsrSet!Client <> CMN And UsrSet!Client <> nClient Then
            GoTo Continue_LOOP3
        End If

        If UsrSet!Application <> CMN And UsrSet!Application <> nAppl Then
            GoTo Continue_LOOP3
        End If

        If UsrSet!CSSRelease <> CMN And UsrSet!CSSRelease <> nRelease Then
            GoTo Continue_LOOP3
        End If

        If UsrSet!Platform <> CMN And UsrSet!Platform <> nPlatform Then
            GoTo Continue_LOOP3
        End If

        ' If the current entry is valid for export - output to the file
        Print #FileNumber, "R2"; Format$(TblData!TableName, "!@@@@@@@@"); "+";

        If IsNull(UsrSet!ErrorNumber) Then
            Print #FileNumber, Space$(5);
        Else
            Print #FileNumber, Format$(UsrSet!ErrorNumber, "!@@@@@");
        End If

        If IsNull(UsrSet!Language) Then
            Print #FileNumber, "E+";
        Else
            Print #FileNumber, Format$(UsrSet!Language, "@"); "+";
        End If

        If IsNull(UsrSet!SequenceNumber) Then
            Print #FileNumber, "001";
        Else
            Print #FileNumber, Format$(UsrSet!SequenceNumber, "000");
        End If

        If IsNull(UsrSet!ErrorCode) Then
            ErrorMsg = " "
        Else
            ErrorMsg = UsrSet!ErrorCode
        End If

        Print #FileNumber, ErrorMsg

Continue_LOOP3: ' Continue with the loop with no processing
        UsrSet.MoveNext
    Loop
    UsrSet.Close


End Sub


