Attribute VB_Name = "modGenerateCopybook"
Option Explicit
Public RC As Variant
Public bCancel As Boolean

'***************************************************************************************************************
Public Sub CreateVariableNames()
'***************************************************************************************************************
    Dim vFailures As Variant, vCurrFailure As Variant, iBadChar As Boolean
    Dim szColumn As String, szDecode As String, szAbbrDecode As String, szMsg As String, szArrayName As String, szArrayTemp As String
    Dim szType As String, x As Integer
    Dim szDataElement As String, szSQLquery As String, szTemp As String, szWord As String, szAbbrWord As String
    Dim iFileType As Integer, iPosition As Integer, iDecodeLen As Integer, iCount As Integer, iVarLen As Integer
    
    Dim EntriesSet As Recordset, AbbrSet As Recordset

    Screen.MousePointer = vbHourglass
    
    'Set up the cancel button on the status window.
    bCancel = False
    
    
    'Set up what the output should be.
    If (frmSourceFileGenerator.optCOutput) Then
        iFileType = 1
    Else
        iFileType = 2
    End If
    
    szDataElement = FormatDataElement(iFileType)

    vFailures = False       ' This flag will be set to True if any variables fail generation.
        
    'Loop down the list view.
    For x = 1 To frmSourceFileGenerator.lvSrcGenerate.ListItems.Count
     
     'If there is NOT a value already in the C or Cobol variable field then create one.
     If (frmSourceFileGenerator.lvSrcGenerate.ListItems(x).SubItems(iFileType) = " ") Or _
          (frmSourceFileGenerator.lvSrcGenerate.ListItems(x).SubItems(iFileType) = vbNullString) Then
        
        szDecode = ""
        szAbbrDecode = ""
        szTemp = ""
        szArrayTemp = ""
        szArrayName = ""

        'Determine beginning of abbreviated var name by iFileType
        If iFileType = 1 Then
            szTemp = szTemp & szDataElement
            szArrayName = "Vs"
        Else
            szTemp = "VS"
        End If

        'For each word in decode, check for abbreviation
        szDecode = RTrim(UCase(frmSourceFileGenerator.lvSrcGenerate.ListItems(x).SubItems(3)))

        'Where possible, abbreviate each piece of the current EntriesSet!Decode
        Do
            iPosition = 1
                
            szDecode = ValidateChars(szDecode, iFileType)

            iDecodeLen = Len(szDecode)
            iPosition = InStr(iPosition, szDecode, " ", 1)

            If iPosition = 0 Then   'this means there are no more spaces in string
                szWord = szDecode
                szAbbrWord = AbbreviateWord(szWord, iFileType)
                    
                If iFileType = 1 Then
                    szTemp = szTemp & "_" & szAbbrWord
                        
                    'Convert the case of the abbreviated word to lower case with the
                    'first letter in upper case and add it to the ArrayName string.
                    szArrayTemp = szAbbrWord
                    szArrayName = szArrayName & UCase(Mid(szArrayTemp, 1, 1)) & LCase(Mid(szArrayTemp, 2))
                                        
                Else
                    szTemp = szTemp & "-" & szAbbrWord
                End If

                Exit Do
                    
            Else
                'Run abbreviation routine for each piece of data element and format it.
                szWord = Mid$(szDecode, 1, (iPosition - 1))
                szAbbrWord = AbbreviateWord(szWord, iFileType)

                If iFileType = 1 Then
                    szTemp = szTemp & "_" & szAbbrWord
                        
                    'Convert the case of the abbreviated word to lower case with the
                    'first letter in upper case and add it to the ArrayName string.
                    szArrayTemp = szAbbrWord
                    szArrayName = szArrayName & UCase(Mid(szArrayTemp, 1, 1)) & LCase(Mid(szArrayTemp, 2))
                        
                Else
                    szTemp = szTemp & "-" & szAbbrWord
                End If
            
            End If

            'Chop off the the converted portion of the string in prep for next iteration.
            szDecode = Mid(szDecode, (iPosition + 1))
                
        Loop
            
        szAbbrDecode = szTemp

        'If a Cobol variable, validate the length of the variable
        If iFileType = 2 Then
                
            iVarLen = Len(szAbbrDecode)
               
            If iVarLen > 27 Then
                vCurrFailure = True
                vFailures = True
            Else
                vCurrFailure = False
            End If

        End If

        If vCurrFailure = False Then
                
            szAbbrDecode = UCase(szAbbrDecode)
            szAbbrDecode = ValidateChars(szAbbrDecode, iFileType)
            szArrayName = ValidateChars(szArrayName, iFileType)
                
            'Begin a new transaction.
            wsCTM.BeginTrans
            
            'Update the field on the entries table (tblEntries).
            If iFileType = 1 Then
                
                strSQL = "UPDATE tblEntries SET CName = " & Chr(39) & szAbbrDecode & Chr(39) & _
                         " WHERE TableName = " & Chr(39) & frmMain.tvTreeView.SelectedItem.Text & Chr(39) & _
                         " AND Key = " & Chr(39) & frmSourceFileGenerator.lvSrcGenerate.ListItems(x).Text & Chr(39)
                
                dbCTM.Execute strSQL
                
                'If the array name is null, then update that value as well.
                If IsNull(frmSourceFileGenerator.lvSrcGenerate.ListItems(x).SubItems(4)) Then
                    strSQL = "UPDATE tblEntries SET ArrayName = " & Chr(39) & szAbbrDecode & Chr(39) & _
                             " WHERE TableName = " & frmMain.tvTreeView.SelectedItem.Text & Chr(39) & _
                             " AND Key = " & Chr(39) & frmSourceFileGenerator.lvSrcGenerate.ListItems(x).Text & Chr(39)
                
                    dbCTM.Execute strSQL
                End If
                
            Else
                strSQL = "UPDATE tblEntries SET CobolName = " & Chr(39) & szAbbrDecode & Chr(39) & _
                         " WHERE TableName = " & Chr(39) & frmMain.tvTreeView.SelectedItem.Text & Chr(39) & _
                         " AND Key = " & Chr(39) & frmSourceFileGenerator.lvSrcGenerate.ListItems(x).Text & Chr(39)
                
                dbCTM.Execute strSQL
            
            End If
                
            'Update the pending transaction.
            wsCTM.CommitTrans
        End If
     End If
     
     'Process any pending events
     DoEvents
     
     'Check to see if the cancel button was pressed.
     If bCancel Then Exit For
     
    Next
        
    Screen.MousePointer = vbNormal

    If vFailures = True Then
        szMsg = "At least one variable name failed generation." & vbCrLf & _
                "Please review all variable names for the type " & vbCrLf & _
                "of file you are generating, and enter any blank" & vbCrLf & _
                "values manually (by double clicking on the desired row)" & vbCrLf & _
                "before generating the copybook."
        
        RC = MessageBox(frmSourceFileGenerator.hwnd, _
                        szMsg, "Codes Table Explorer", MB_OK Or MB_ICONINFORMATION)
    End If

  Call frmSourceFileGenerator.PopulateListView
  frmSourceFileGenerator.Refresh


End Sub



'***************************************************************************************************************
Public Function FormatDataElement(ByVal iFileType As Integer) As String
'***************************************************************************************************************

    Dim szTemp As String, szDataElement As String, szWord As String, szAbbrWord As String
    Dim iPosition As Integer, iElementLen As Integer
    

'   Format the data element according to the file type being generated.
    szDataElement = UCase(frmSourceFileGenerator.DataElement.Text)

    If iFileType = 1 Then
        szTemp = ""
    Else
        szTemp = "VS"
    End If

    '  Where possible, abbreviate each piece of the data element name
    Do
        iPosition = 1
        iElementLen = Len(szDataElement)
                
        iPosition = InStr(iPosition, szDataElement, " ", 1)

        If iPosition = 0 Then   'this means there are no more spaces in string
            szWord = szDataElement
            szAbbrWord = AbbreviateWord(szWord, iFileType)

            If iFileType = 1 Then
                szTemp = szTemp & szAbbrWord
            Else
                szTemp = szTemp & "-" & szAbbrWord
            End If
            Exit Do

        Else
        '   Run abbreviation routine for each piece of data element and format it.
            szWord = Mid$(szDataElement, 1, (iPosition - 1))
            szAbbrWord = AbbreviateWord(szWord, iFileType)

            If iFileType = 1 Then
                szTemp = szTemp & szAbbrWord
            Else
                szTemp = szTemp & "-" & szAbbrWord
            End If
            
        End If

        ' Chop off the the converted portion of the string in prep for next iteration.
        szDataElement = Mid(szDataElement, (iPosition + 1))

    Loop

    FormatDataElement = szTemp

End Function


'***************************************************************************************************************
Public Function AbbreviateWord(ByVal szWord As String, _
                                ByVal iFileType As Integer)
'***************************************************************************************************************

    Dim szQuery As String, szTemp As String, szAbbrWord As String
    Dim iCount As Integer, iWord As Integer, iPosition As Integer
    Dim AbbrSet As Recordset

    szQuery = "SELECT Abbreviation from tblAbbreviations where Word = '" + szWord + "';"
    Set AbbrSet = dbCTM.OpenRecordset(szQuery)
    
    If AbbrSet.RecordCount = 1 Then
        AbbreviateWord = AbbrSet!Abbreviation
    Else
        AbbreviateWord = szWord
    End If

    AbbrSet.Close

End Function



'***************************************************************************************************************
Public Function ValidateChars(ByVal szTestString As String, _
                               ByVal iFileType As Integer) As String
'***************************************************************************************************************

    Dim iBadChar As Integer, szTempStr As String, szMsg As String, szTitle As String, szDefValue As String
        
    iBadChar = False
        
    'Check for illegal chars
    If 0 <> InStr(1, szTestString, "~") Then
        szTestString = StripIllegalChar(szTestString, "~")
    End If
    If 0 <> InStr(1, szTestString, "`") Then
        szTestString = StripIllegalChar(szTestString, "`")
    End If
    If 0 <> InStr(1, szTestString, "!") Then
        szTestString = StripIllegalChar(szTestString, "!")
    End If
    If 0 <> InStr(1, szTestString, "@") Then
        szTestString = StripIllegalChar(szTestString, "@")
    End If
    If 0 <> InStr(1, szTestString, "#") Then
        szTestString = StripIllegalChar(szTestString, "#")
    End If
    If 0 <> InStr(1, szTestString, "$") Then
        szTestString = StripIllegalChar(szTestString, "$")
    End If
    If 0 <> InStr(1, szTestString, "%") Then
        szTestString = StripIllegalChar(szTestString, "%")
    End If
    If 0 <> InStr(1, szTestString, "^") Then
        szTestString = StripIllegalChar(szTestString, "^")
    End If
    If 0 <> InStr(1, szTestString, "&") Then
        szTestString = StripIllegalChar(szTestString, "&")
    End If
    If 0 <> InStr(1, szTestString, "*") Then
        szTestString = StripIllegalChar(szTestString, "*")
    End If
    If 0 <> InStr(1, szTestString, "(") Then
        szTestString = StripIllegalChar(szTestString, "(")
    End If
    If 0 <> InStr(1, szTestString, ")") Then
        szTestString = StripIllegalChar(szTestString, ")")
    End If
    If iFileType = 1 Then
        If 0 <> InStr(1, szTestString, "-") Then
        szTestString = StripIllegalChar(szTestString, "-")
        End If
    End If
    If 0 <> InStr(1, szTestString, "+") Then
        szTestString = StripIllegalChar(szTestString, "+")
    End If
    If 0 <> InStr(1, szTestString, "=") Then
        szTestString = StripIllegalChar(szTestString, "=")
    End If
    If 0 <> InStr(1, szTestString, "[") Then
        szTestString = StripIllegalChar(szTestString, "[")
    End If
    If 0 <> InStr(1, szTestString, "]") Then
        szTestString = StripIllegalChar(szTestString, "]")
    End If
    If 0 <> InStr(1, szTestString, "{") Then
        szTestString = StripIllegalChar(szTestString, "{")
    End If
    If 0 <> InStr(1, szTestString, "}") Then
        szTestString = StripIllegalChar(szTestString, "}")
    End If
    If 0 <> InStr(1, szTestString, "'") Then
        szTestString = StripIllegalChar(szTestString, "'")
    End If

    szTempStr = "" & Chr(34)
    If 0 <> InStr(1, szTestString, szTempStr) Then
        szTestString = StripIllegalChar(szTestString, szTempStr)
    End If
    If 0 <> InStr(1, szTestString, ";") Then
        szTestString = StripIllegalChar(szTestString, ";")
    End If
    If 0 <> InStr(1, szTestString, ":") Then
        szTestString = StripIllegalChar(szTestString, ":")
    End If
    If 0 <> InStr(1, szTestString, "?") Then
        szTestString = StripIllegalChar(szTestString, "?")
    End If
    If 0 <> InStr(1, szTestString, "/") Then
        szTestString = StripIllegalChar(szTestString, "/")
    End If
    If 0 <> InStr(1, szTestString, ">") Then
        szTestString = StripIllegalChar(szTestString, ">")
    End If
    If 0 <> InStr(1, szTestString, "<") Then
        szTestString = StripIllegalChar(szTestString, "<")
    End If
    If 0 <> InStr(1, szTestString, ",") Then
        szTestString = StripIllegalChar(szTestString, ",")
    End If
    If 0 <> InStr(1, szTestString, ".") Then
        szTestString = StripIllegalChar(szTestString, ".")
    End If
    If 0 <> InStr(1, szTestString, "\") Then
        szTestString = StripIllegalChar(szTestString, "\")
    End If
    If 0 <> InStr(1, szTestString, "|") Then
        szTestString = StripIllegalChar(szTestString, "|")
    End If

    ValidateChars = szTestString

End Function


'***************************************************************************************************************
Public Function StripIllegalChar(ByVal szBadStr As String, _
                                  ByVal szBadChar As String) As String
'***************************************************************************************************************

    Dim szTempStr As String, szNewStr As String
    Dim iPosition As Integer, iBadStrLen As Integer

    szNewStr = ""
    
    Do
        iPosition = 1
        iBadStrLen = Len(szBadStr)
                
        iPosition = InStr(iPosition, szBadStr, szBadChar, 1)

        If iPosition = 0 Then   'this means the bad char doesn't exist in the current string
            szNewStr = szNewStr & szBadStr
            Exit Do

        Else
        '   Cut the portion of the string up to the illegal char, and add it to the new string.
            szTempStr = Mid$(szBadStr, 1, (iPosition - 1))
            szNewStr = szNewStr & szTempStr
            szBadStr = Mid$(szBadStr, (iPosition + 1))
        End If

    Loop

    StripIllegalChar = szNewStr

End Function

'***************************************************************************************************************
Public Sub GenerateCopybook()
'***************************************************************************************************************

        Dim szFileTitle As String, szDataElement As String, szDataType As String, szPathAndFile As String
        Dim szTempDataType As String, szPicClause As String, szMsg As String, szSigned As String, szComp As String
        Dim iFileType As Integer, iLength As Integer, iElementLen As Integer, szColumn As String, szSQLquery As String
        Dim EntriesSet As Recordset, AbbrSet As Recordset, NullSet As Recordset
        Dim RC As Integer
        
        Screen.MousePointer = vbHourglass
                    
        'Set up what the output should be.
        If (frmSourceFileGenerator.optCOutput) Then
            iFileType = 1
        Else
            iFileType = 2
        End If
                
                
        szFileTitle = frmSourceFileGenerator.FileName
        szDataElement = FormatDataElement(iFileType)
        iElementLen = Len(szDataElement)
        szDataType = frmSourceFileGenerator.DataType
        iLength = frmSourceFileGenerator.Length
        szPathAndFile = frmSourceFileGenerator.efPath & "\" & frmSourceFileGenerator.efCUVFile
        
        ' Using the file type, determine the column to use for the select query, then format query
        If iFileType = 1 Then
            szColumn = "CName"
        Else
            szColumn = "CobolName"
        End If

        'Check to see if the path exists
        If (Dir(frmSourceFileGenerator.efPath, vbDirectory) = "") Then
                
            RC = MessageBox(frmSourceFileGenerator.hwnd, _
                            "This output directory does not currently exist." & _
                            vbCrLf & "Would you like to create it?", _
                            "Codes Table Update", _
                            MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON1)
                                    
            If (RC = IDNO) Then
                frmSourceFileGenerator.efPath.SetFocus
                Exit Sub
            Else
                MkDir (frmSourceFileGenerator.efPath)
            End If
        End If

            
        Open szPathAndFile For Output Access Write As 1
        Call WriteFileHeader(iFileType, szFileTitle, szDataElement)
        
        If iFileType = 2 Then
            
            Print #1, Spc(7); "01  "; szDataElement; "-88."
            szTempDataType = szDataType
            
            If szDataType = "S" Then
                szTempDataType = "X"
            End If
            
            If (frmSourceFileGenerator.cbSigned = 0) Then
                szSigned = ""
            Else
                szSigned = "S"
            End If
            
            If (frmSourceFileGenerator.CompType = "0") Then
                szComp = "."
            Else
                szComp = " " & frmSourceFileGenerator.CompType & "."
            End If
            
            szPicClause = "PIC " & szSigned & szTempDataType & "(" & iLength & ")" & szComp

            Print #1, Spc(9); "03 "; szDataElement; Spc((60 - 12) - iElementLen); szPicClause
        
        End If
            
        'Write out the entries for this copybook.
        Call WriteFileEntries(iFileType, szDataType)
        
        Screen.MousePointer = vbNormal
     
        'szPathAndFile = UCase(szPathAndFile)
        RC = MessageBox(frmSourceFileGenerator.hwnd, _
                        "Source file generation complete for:  " & szPathAndFile & ".", _
                        "Codes Table Explorer", _
                        MB_OK Or MB_ICONINFORMATION)
        
        'Close the copybook.
        Close #1
    

End Sub

'***************************************************************************************************************
Public Sub WriteFileEntries(ByVal iFileType As Integer, _
                            ByVal szDataType As String)
'***************************************************************************************************************

    Dim FileEntries As Recordset, DupKey As Recordset, ValuesSet As Recordset
    Dim szSQLquery As String, szKey As String, szValue As String, szMsg As String
    Dim iWriteEntry As Boolean
    Dim iValueLen As Integer, iVarLen As Integer

    szSQLquery = "SELECT DISTINCTROW Key, CName, CobolName, Client, ArrayName " & _
                 "FROM tblEntries WHERE TableName = '" + frmMain.tvTreeView.SelectedItem.Text & _
                 "' ORDER BY Key;"
    
    Set FileEntries = dbCTM.OpenRecordset(szSQLquery, dbOpenDynaset)

    If FileEntries.RecordCount > 0 Then

        FileEntries.MoveFirst
         
        Do Until FileEntries.EOF

            '================================================================================
            ' Validate entries that have duplicate Keys but different client codes...
            '================================================================================
            ' The current business rule, as outlined by the DA Team is as follows:
            ' If there are duplicate entries in a codes table, SoCo has priority over all
            ' other client codes.  If entries have duplicate keys, and neither is a SoCo
            ' entry, it doesn't matter which one is used (by default, the entry with the
            ' lower numeric client code will be selected for inclusion in the output file.
            
            iWriteEntry = False
            
            If FileEntries!Client = 5 Then
                
                iWriteEntry = True

            Else
                
                szSQLquery = "SELECT Key, Client FROM tblEntries WHERE TableName = '" & _
                             frmMain.tvTreeView.SelectedItem.Text & "' and Key = '" & _
                             FileEntries!Key & "' and (Client < " & FileEntries!Client & _
                             " or Client = 5) ORDER BY Key;"

                Set DupKey = dbCTM.OpenRecordset(szSQLquery, dbOpenDynaset)

                If DupKey.RecordCount > 0 Then   'Key has a duplicate, non-SoCo entry with a lower client code
                
                    iWriteEntry = False
            
                Else ' Current EntrySet!Key has no non-SoCo duplicate Keys with a lower client code.
                
                    iWriteEntry = True

                End If

            End If

            If iWriteEntry = True Then
            
                'Strip the 'E' off the beginning of the Key
                szKey = Mid$(FileEntries!Key, 2)
                
                'Check entry for multiple values
                szSQLquery = "SELECT tblValues.TableName, tblValues.Client, tblValues.Key, tblValues.Value, tblValues.Description"
                szSQLquery = szSQLquery & " FROM tblValues "
                szSQLquery = szSQLquery & " WHERE tblValues.TableName = '" & frmMain.tvTreeView.SelectedItem.Text & "'"
                szSQLquery = szSQLquery & " And tblValues.Client = " & FileEntries!Client
                szSQLquery = szSQLquery & " And tblValues.Key = '" & FileEntries!Key & "' ORDER BY tblValues.Value;"
                
                Set ValuesSet = dbCTM.OpenRecordset(szSQLquery)
                            
                If ValuesSet.EOF Then
                
                    Call WriteSingleValue(FileEntries, szKey)
                
                Else
                
                    Call WriteMultipleValues(FileEntries, ValuesSet, szKey)
                
                End If
                
            End If
            
            FileEntries.MoveNext
        
        Loop

    End If

    FileEntries.Close

End Sub

'***************************************************************************************************************
Public Sub WriteFileHeader(ByVal iFileType As Integer, _
                           ByVal szFileTitle As String, _
                           ByVal szDataElement As String)
'***************************************************************************************************************

    Dim iTitleLen As Integer, iElementLen As Integer, iDateLen As Integer, iTimeLen As Integer
    Dim szDate As String, szTime As String
    
    szDate = Date$
    szTime = Time$
    
    iTitleLen = Len(szFileTitle)
    iElementLen = Len(szDataElement)
    iDateLen = Len(szDate)
    iTimeLen = Len(szTime)

    If iFileType = 1 Then   'C Include file header

        Print #1, "/******************************************************************************/"
        Print #1, "/*"; Spc(76); "*/"
        Print #1, "/*  Header for:    "; szFileTitle & " " & frmSourceFileGenerator.DataElement; Spc((80 - 25) - (iTitleLen + iElementLen)); "*/"
        Print #1, "/*  Generated on:  "; szDate; Spc((80 - 21) - iDateLen); "*/"
        Print #1, "/*            at:  "; szTime; Spc((80 - 21) - iTimeLen); "*/"
        Print #1, "/*"; Spc(76); "*/"
        Print #1, "/*  Source Input File: "; szFileTitle; Spc((80 - 25) - iTitleLen); "*/"
        Print #1, "/*"; Spc(76); "*/"
        Print #1, "/*  (c) COPYRIGHT 1996,1997 ANDERSEN CONSULTING, LLP--ALL RIGHTS RESERVED.    */"
        Print #1, "/*  THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.           */"
        Print #1, "/*"; Spc(76); "*/"
        Print #1, "/******************************************************************************/"
        Print #1,
        Print #1, "/*  Data Element "; frmMain.tvTreeView.SelectedItem.Text; " "; frmSourceFileGenerator.DataElement; Spc((80 - 31) - iElementLen); "*/"
        Print #1,

    Else    ' Cobol Header

        Print #1, Spc(6); "******************************************************************"
        Print #1, Spc(6); "* (c) COPYRIGHT 1996,1997 ANDERSEN CONSULTING, LLP--ALL RIGHTS   *"
        Print #1, Spc(6); "* RESERVED.  THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN       *"
        Print #1, Spc(6); "* UNPUBLISHED WORK.                                              *"
        Print #1, Spc(6); "******************************************************************"
        Print #1, Spc(6); "*"; Spc(64); "*"
        Print #1, Spc(6); "*  COPYBOOK NAME:    "; szFileTitle; Spc((72 - 28) - iTitleLen); "*"
        Print #1, Spc(6); "*"; Spc(64); "*"
        Print #1, Spc(6); "*  COPYBOOK DESC:    "; szFileTitle; Spc((72 - 28) - iTitleLen); "*"
        Print #1, Spc(6); "*"; Spc(64); "*"
        Print #1, Spc(6); "*  GENERATION DATE:  "; szDate; Spc((72 - 28) - iDateLen); "*"
        Print #1, Spc(6); "*             TIME:  "; szTime; Spc((72 - 28) - iTimeLen); "*"
        Print #1, Spc(6); "*"; Spc(64); "*"
        Print #1, Spc(6); "******************************************************************"

    End If

End Sub

'***************************************************************************************************************
Public Sub WriteSingleValue(FileEntries As Recordset, szKey As String)
'***************************************************************************************************************

    Dim iValueLen As Integer, iVarLen As Integer, szValue As String, iFileType As Integer
                    
    'Set up what the output should be.
    If (frmSourceFileGenerator.optCOutput) Then
        iFileType = 1
    Else
        iFileType = 2
    End If
    
    If (frmSourceFileGenerator.DataType = "X") Then   ' single character data type
            
       iValueLen = (Len(szKey) + 2)
                    
       If iFileType = 1 Then
                                         
          szValue = "'" & szKey & "'"
          iVarLen = Len(FileEntries!CName)
          Print #1, "#ifndef  "; FileEntries!CName
          Print #1, "#define  "; FileEntries!CName; Spc((70 - 9) - (Len(FileEntries!CName))); szValue
          Print #1, "#endif"
          
       Else
                        
          szValue = "'" & szKey & "'."
          iVarLen = Len(FileEntries!CobolName)
          Print #1, Spc(11); "88 "; FileEntries!CobolName; Spc((62 - 19) - (Len(FileEntries!CobolName))); "VALUE "; szValue

       End If

    End If

    If (frmSourceFileGenerator.DataType = "9") Then   ' numeric data type
                    
       If iFileType = 1 Then

          szValue = szKey
          Print #1, "#ifndef  "; FileEntries!CName
          Print #1, "#define  "; FileEntries!CName; Spc((70 - 9) - (Len(FileEntries!CName))); szValue
          Print #1, "#endif"

       Else
          
          szValue = szKey
          szValue = FormatCobolInteger(szValue)
          iVarLen = Len(FileEntries!CobolName)
          Print #1, Spc(11); "88 "; FileEntries!CobolName; Spc((62 - 19) - (Len(FileEntries!CobolName))); "VALUE "; szValue; "."

       End If
                
    End If
            
    If (frmSourceFileGenerator.DataType = "S") Then   ' string data type

       iValueLen = (Len(szKey) + 2)
                    
       If iFileType = 1 Then

          szValue = "" & Chr(34) & szKey & "" & Chr(34)
          iVarLen = Len(FileEntries!CName)
          Print #1, "#ifndef  "; FileEntries!CName
          Print #1, "#define  "; FileEntries!CName; Spc((70 - 9) - (Len(FileEntries!CName))); szValue
          Print #1, "#endif"
                    
       Else
                        
          szValue = "'" & szKey & "'."
          iVarLen = Len(FileEntries!CobolName)
          Print #1, Spc(11); "88 "; FileEntries!CobolName; Spc((62 - 19) - (Len(FileEntries!CobolName))); "VALUE "; szValue

       End If

    End If

End Sub

'***************************************************************************************************************
Public Sub WriteMultipleValues(FileEntries As Recordset, ValuesSet As Recordset, szKey As String)
'***************************************************************************************************************

    Dim iValueLen As Integer, iVarLen As Integer, szValue As String, iFileType As Integer, iDataType As String
    Dim szDeclaration As String, szDefinition As String, szDefStatement As String, szLine As String, szNewStatement As String
    Dim iCounter As Integer, iRowCount As Integer, szParen As String
    
    'Format the variable declaration up to the list of values, and write it to the file...
    'Set up what the output should be.
    If (frmSourceFileGenerator.optCOutput) Then
        iFileType = 1
    Else
        iFileType = 2
    End If
    
    
    
    If (iFileType = 1) Then    ' Format an array declaration in the C include file.  All array elements
                             ' are defined as strings.
        iValueLen = (Len(szKey) + 2)
        szDeclaration = "#define  " & FileEntries!CName & "  "
        szDefinition = "CHAR *" & FileEntries!ArrayName & "[]={"
        szDefStatement = szDeclaration & szDefinition
        
        ' Write the C Array declaration to the include file...
        Print #1, "#ifndef  "; FileEntries!CName
        
        If Len(szDefStatement) > 70 Then
            Print #1, szDeclaration; " \"
            szLine = "                    " & szDefinition
        Else
            szLine = szDefStatement
        End If
        
        ValuesSet.MoveLast
        iRowCount = ValuesSet.RecordCount
        ValuesSet.MoveFirst
        iCounter = 1
        
        Do Until ValuesSet.EOF
        
            szValue = "" & Chr(34) & ValuesSet!Value & "" & Chr(34)
            
            If ((Len(szLine)) + (Len(szValue)) + (3)) > 76 Then  'won't fit on line
                
                If iCounter < iRowCount Then
                    szValue = szValue
                    Print #1, szLine; ","; " \"
                End If
                    szLine = "                    " & szValue
            
            Else 'will fit on line
            
                If iCounter = 1 Then
                   szLine = szLine & szValue
                Else
                   szLine = szLine & ", " & szValue
                End If
            
            End If
                
            ValuesSet.MoveNext
            iCounter = iCounter + 1
           
        Loop
        
        Print #1, szLine & "}"
        Print #1, "#endif"
    
    Else ' format a COBOL level-88 entry with multiple value
    
        szLine = "           88 " & FileEntries!CobolName & "                                     VALUE "
        
        If (frmSourceFileGenerator.DataType = "9") Then   ' numeric data type
            szParen = ""
        Else                       ' alphanumeric data type
            szParen = "'"
        End If
        
        ValuesSet.MoveLast
        iRowCount = ValuesSet.RecordCount
        ValuesSet.MoveFirst
        iCounter = 1

        Do Until ValuesSet.EOF
                                               
            szValue = ValuesSet!Value
            
            If (frmSourceFileGenerator.DataType = "9") Then
            
                szValue = FormatCobolInteger(szValue)
                
                If szValue = "failure" Then
                    ValuesSet.MoveLast
                    FileEntries.MoveLast
                End If
                                
            End If
            
            szValue = szParen & szValue & szParen
            
            If ((Len(szLine)) + (Len(szValue)) + (2)) > 70 Then  'won't fit on line
                
                If iCounter < iRowCount Then
                    'szValue = szValue
                    If iCounter = 1 Then
                        Print #1, szLine
                        
                    ElseIf iCounter > 1 Then
                        
                        Print #1, szLine; ", "
                    End If
                Else
                    Print #1, szLine; ", "
                End If
                
                szLine = "      -       " & szValue
            
            Else 'will fit on line
            
                If iCounter = 1 Then
                   szLine = szLine & szValue
                Else
                   szLine = szLine & ", " & szValue
                
                End If
            
            End If
            
            ValuesSet.MoveNext
            iCounter = iCounter + 1
           
        Loop
        
        Print #1, szLine & "."
            
    End If

End Sub

'***************************************************************************************************************
Public Function FormatCobolInteger(ByVal szOldValue As String) As String
'***************************************************************************************************************

    ' This function takes a level-88 integer value and pads it with leading
    ' zeroes according to the length of the integer defined in the PIC clause.
    
    Dim szNewValue As String, szZeroes As String, szStrippedValue, szReturnValue As String
    Dim bContinue As Boolean, bNegative As Boolean, szSign As String, bStripped As Boolean
    Dim iSignedAddend As Integer, RC As Integer
    
    '  while the first char in szOldValue = 0, trim it off
    bContinue = True
    bNegative = False
    bStripped = False
    
    If ((frmSourceFileGenerator.cbSigned.Value = 1) And _
        ((1 <= InStr(1, szOldValue, "-")) Or _
        (1 <= InStr(1, szOldValue, "+")))) Then
        iSignedAddend = 1
    Else
        iSignedAddend = 0
    End If
        
    If (frmSourceFileGenerator.Length + iSignedAddend) < Len(szOldValue) Then
    
        RC = MessageBox(frmSourceFileGenerator.hwnd, _
                        "The data element length is too short for a specified value.  " & _
                        "To correct this error, adjust the length of the data element " & _
                        "or remove the invalid value(s).  WARNING! THE SOURCE FILE BEING GENERATED IS INVALID.", _
                        "Codes Table Explorer", _
                        MB_OK Or MB_ICONEXCLAMATION)
        szReturnValue = "failure"
    
    Else
        
        If (frmSourceFileGenerator.cbSigned.Value = 0) Then
    
            While bContinue = True
    
                If (("+" = Mid(szOldValue, 1, 1)) Or ("-" = Mid(szOldValue, 1, 1))) Then
                    szOldValue = Mid(szOldValue, 2)
                    bContinue = True
                ElseIf ("" = Mid(szOldValue, 1, 1)) Then
                    bContinue = False
                Else
                    szStrippedValue = szStrippedValue & Mid(szOldValue, 1, 1)
                    szOldValue = Mid(szOldValue, 2)
                End If
            Wend
        
            szOldValue = szStrippedValue
            
        End If

        While bContinue = True

            If ("0" = Mid(szOldValue, 1, 1)) Then
            
                szOldValue = Mid(szOldValue, 2)
        
            Else
        
                If (frmSourceFileGenerator.cbSigned.Value = 1) Then
                    If ("-" = Mid(szOldValue, 1, 1)) Then
                        szOldValue = Mid(szOldValue, 2)
                        bNegative = True
                        bContinue = True
                    ElseIf ("+" = Mid(szOldValue, 1, 1)) Then
                        szOldValue = Mid(szOldValue, 2)
                        bContinue = True
                    Else
                        bContinue = False
                    End If
                Else
                    bContinue = False
                End If
            
            End If
        
        Wend
   
        If (frmSourceFileGenerator.cbSigned.Value = 1) Then
    
            If bNegative = True Then
                szSign = "-"
            Else
                szSign = "+"
            End If
        
        End If
       
        szZeroes = String((frmSourceFileGenerator.Length - Len(szOldValue)), "0")
        szNewValue = szSign & szZeroes & szOldValue
        szReturnValue = szNewValue

    End If
    
    FormatCobolInteger = szReturnValue
    
End Function

