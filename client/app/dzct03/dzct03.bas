Attribute VB_Name = "mdldzct03"
Option Explicit

'**********************************************************
'**            Global Variable Declarations              **
'**********************************************************
Public fUNIXPath As String
Public fWorkFile As String
Public fCTMDatabase As String
Public fProject As String
Public wsCTM As Workspace
Public dbCTM As Database
Public sFunction As String
Public iFileNum As Integer
Public iErrorFile As Integer
Public msg As String
Public fCTempInFile As String
Public fCTempOutFile As String
Public fFTPInFile As String
Public fFTPOutFile As String
Public ErrorFound As Boolean
Public LogError As Boolean
Public Counter As Integer
Public TotalRecords As Integer
Const fErrorLogFile As String = "c:\temp\error.log"
Const EXTRACT_FUNC As String = "E"
Const UPDATE_FUNC As String = "U"
Const USER As String = "pvcs"
Public sFTPParameter As String

'***********************************************************
'**                        SubMain                        **
'***********************************************************
Private Sub Main()

    'Perform Housekeeping.
    If Not Housekeeping Then
        End
    End If
        
    'Perform Process.
    Process
        
    'Perform WrapUp.
    WrapUp
        
End Sub

'************************************************************
'**                       GetFTPParameters                 **
'************************************************************
Public Function GetFTPParameters()

    Dim strsql As String
    Dim DaoRS As Recordset
  
    On Error GoTo SQLError
    
    'Find out what server the project resides on.
    strsql = "Select Value " _
           & "From tblFTPParameter"
             
    On Error GoTo RecordsetError
    
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    On Error GoTo GetParameterError
    
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
    ErrorFound = True
    msg = "An error occurred while trying to perform SQL query in the GetFTPParameters function." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

RecordsetError:
    GetFTPParameters = False
    ErrorFound = True
    msg = "An error occurred while trying to open the recordset during when getting the FTP parameter." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

GetParameterError:
    GetFTPParameters = False
    ErrorFound = True
    msg = "An error occurred while trying to get the FTP parameter." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
End Function

Private Sub WriteToErrorLog()
    
    On Error GoTo FileOpenError
    
    'Open error log file.
    iErrorFile = FreeFile
    Open fErrorLogFile For Append As iErrorFile
    
    Print #iErrorFile, msg

    'Close error log file.
    Close iErrorFile
Exit Sub
    
FileOpenError:
    ErrorFound = True
    msg = "The output file which would contain the extracted tables could not be opened." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail

End Sub

'************************************************************
'**                          Email                         **
'************************************************************
Private Sub SendEmail()

Dim myemail As New Email

With myemail
    .USER = "DevTools-Codestable Explorer"
    .Subject = "Email from CTM Key Flag Update Process"
    .Body = msg
    .Send
End With
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

'***********************************************************
'**                       ParseArgs                       **
'***********************************************************
Public Function ParseArgs() As Boolean

    Dim CmdStr As String
    Const FUNCTION_VALUE As Integer = 1
    Const DATABASE_PATH As Integer = 2
    Const PROJECT_NAME As Integer = 3
    Const PATH_ARG As Integer = 4
    Const WORKFILE As Integer = 5
    
    'Grab the command line argument string.
    CmdStr = Command
    
    'Get the value of the function for extract or update (E or U).
    sFunction = ParseString(CmdStr, " ", FUNCTION_VALUE)
    
    'Get the name of the access database to update.
    fCTMDatabase = ParseString(CmdStr, " ", DATABASE_PATH)
    
    'Get the project name.
    fProject = ParseString(CmdStr, " ", PROJECT_NAME)
    
    'Get the destination pathname.
    fUNIXPath = ParseString(CmdStr, " ", PATH_ARG)
    
    'Get the workfile name.
    fWorkFile = ParseString(CmdStr, " ", WORKFILE)
    
    'Check to see if arguments are not empty.
    If sFunction <> " " And fCTMDatabase <> " " And fProject <> " " And fUNIXPath <> " " And fWorkFile <> " " Then
        ParseArgs = True
    Else
        ParseArgs = False
    End If
   
End Function

'*************************************************************
'**                      ExportCodesTable                   **
'*************************************************************
Public Function ExportCodesTable() As Boolean
    
    Dim SQLQuery As String, sTableName As String
    Dim EntrySet As Recordset
  
    On Error GoTo SQLError
    
    'Set SQL string to only select tables which have records in tblEntries.
        SQLQuery = "SELECT DISTINCTROW tblTables.TableName" _
                 & " FROM tblTables INNER JOIN tblEntries ON tblTables.TableName = tblEntries.TableName" _
                 & " Where (((tblTables.TableName) Like " & Chr(34) & "CIS*" & Chr(34) & "))" _
                 & " ORDER BY FlagUpdateTS ASC;"
        
        'SQLQuery = "SELECT TableName" _
                  & " FROM tblTables" _
                  & " WHERE TableName Like " & Chr(34) & "CIS*" & Chr(34) _
                  & " ORDER BY FlagUpdateTS ASC;"
         
        On Error GoTo RecordsetError
        
        Set EntrySet = dbCTM.OpenRecordset(SQLQuery)
    
    EntrySet.MoveFirst
    
    On Error GoTo TableNameError
    
    iFileNum = FreeFile
    Open fCTempOutFile For Output As iFileNum
    
    Do Until EntrySet.EOF
        sTableName = EntrySet(0).Value
        Print #iFileNum, sTableName
  
        EntrySet.MoveNext
    Loop

    Close #iFileNum
    
    EntrySet.Close
    
    ExportCodesTable = True
    
    Exit Function
    
SQLError:
    ExportCodesTable = False
    ErrorFound = True
    msg = "An error occurred while trying to perform SQL query in the ExportCodesTable function." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function
    
RecordsetError:
    ExportCodesTable = False
    ErrorFound = True
    msg = "An error occurred while trying to open the recordset during extract." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

TableNameError:
    ExportCodesTable = False
    ErrorFound = True
    msg = "An error occurred while trying to get the extracted table names." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
End Function

'*************************************************************
'**                       ExtractProcess                    **
'*************************************************************
Public Function ExtractProcess() As Boolean

    On Error GoTo FileOpenError
    
    'Open output file.
    
    ExtractProcess = True
    
    'Export the entries for the Codes Table selection.
    If Not ExportCodesTable Then
        ExtractProcess = False
    Else
        ExtractProcess = True
    End If

    'Close output file.
    Close iFileNum
    
    'Put output file to UNIX directory.
    If Not PutTblFile Then
        ExtractProcess = False
    Else
        ExtractProcess = True
    End If
    
    Exit Function
    
FileOpenError:
    ExtractProcess = False
    ErrorFound = True
    msg = "The output file which would contain the extracted tables could not be opened." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
End Function

'*************************************************************
'**                        PutTblFile                       **
'*************************************************************
Public Function PutTblFile() As Boolean

    Dim myftp As New FTP
    Dim sServer As String
    Dim strsql As String
    Dim DaoRS As Recordset
  
    On Error GoTo SQLError
    
    'Find out what server the project resides on.
    strsql = "Select server " _
             & "From tblProjectEnv " _
             & "Where projectenv = " & Chr(39) & fProject & Chr(39)
             
    On Error GoTo RecordsetError
    
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    On Error GoTo GetServerError
    
    If Not DaoRS.EOF Then
        sServer = DaoRS(0).Value
    Else
        Err.Raise 15, PutTblFile, "No more records in recordset."
    End If
    
    DaoRS.Close
    
    On Error GoTo FTPError
    
    'Put the output file to the UNIX directory.
    With myftp
        .ErrorMessageBox = False
        .HostName = sServer
        .UserName = USER
        .Password = sFTPParameter
        .RemoteFile = fFTPOutFile
        .LocalFile = fCTempOutFile
        .PutFile
    End With

    'Check to see if put was successful.
    If myftp.Error Then
        PutTblFile = False
        Err.Raise 23, PutTblFile, "The FTP failed because " & fFTPOutFile & " does not exist."
    Else
        PutTblFile = True
    End If
Exit Function
    
SQLError:
    PutTblFile = False
    ErrorFound = True
    msg = "An error occurred while trying to perform SQL query in PutTblFile." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

RecordsetError:
    PutTblFile = False
    ErrorFound = True
    msg = "An error occurred while trying to open the recordset for selecting the server in PutTblFile." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

GetServerError:
    PutTblFile = False
    ErrorFound = True
    msg = "An error occurred while trying to get server for FTP destination in PutTblFile." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

FTPError:
    msg = "An error occurred while trying to put output file to UNIX." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
   'Send email.
    SendEmail
End Function

'*************************************************************
'**                        GetTblFile                       **
'*************************************************************
Public Function GetTblFile() As Boolean

    Dim myftp As New FTP
    Dim sServer As String
    Dim strsql As String
    Dim DaoRS As Recordset
       
    On Error GoTo SQLError
    
    'Find out what server the project resides on.
    strsql = "Select server " _
             & "From tblProjectEnv " _
             & "Where projectenv = " & Chr(39) & fProject & Chr(39)
    
    On Error GoTo RecordsetError
    
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    On Error GoTo GetServerError
    
    If Not DaoRS.EOF Then
        sServer = DaoRS(0).Value
    Else
        DaoRS.Close
    End If
       
    'Get the input file from the UNIX directory.
    With myftp
        .ErrorMessageBox = False
        .HostName = sServer
        .UserName = USER
        .Password = sFTPParameter
        .RemoteFile = fFTPInFile
        .LocalFile = fCTempInFile
        .GetFile
    End With
    
    On Error GoTo FTPError
    
    'Check to see if get was successful.
    If myftp.Error Then
        GetTblFile = False
        Err.Raise 24, GetTblFile, "The FTP failed because " & fFTPInFile & " does not exist."
    Else
        GetTblFile = True
    End If
Exit Function

SQLError:
    ErrorFound = True
    msg = "An error occurred while trying to perform SQL query in GetTblFile." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

RecordsetError:
    GetTblFile = False
    ErrorFound = True
    msg = "An error occurred while trying to open the recordset for selecting the server in GetTblFile." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

GetServerError:
    GetTblFile = False
    ErrorFound = True
    msg = "An error occurred while trying to get server for FTP destination in GetTblFile." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
   'Send email.
    SendEmail
Exit Function

FTPError:
    GetTblFile = False
    ErrorFound = True
    msg = "An error occurred while trying to get input file from UNIX." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
   'Send email.
    SendEmail
End Function

'*************************************************************
'**                       UpdateProcess                     **
'*************************************************************
Public Function UpdateProcess() As Boolean
    
    'Local variables.
    Dim sTimestamp As String
    Dim iRecordType As Integer
    Dim bKeyBoolean As Boolean
    Dim sOccursColName As String
    Dim sColumnName As String
    Dim sTableName As String
    Dim sTableKey As String
    Dim SQLUpdate As String
    Dim iKeyOccurs  As Integer
    Dim CurLine As String
    Dim Count As Integer
    Dim ErrorCounter As Long
    Dim CurDateTime As String
    Dim sCheckSysUsage As String
    Dim iCheckNum As Integer
    Const RECORD_TYPE_ARG As Integer = 1
    Const TABLE_NAME_ARG As Integer = 2
    Const SYSTEM_CHECK_ARG As Integer = 3
    Const USE_FLAG_ARG As Integer = 4
    Const OCCURS_NUM_ARG As Integer = 5
    Const TABLE_KEY_ARG As Integer = 6
    Const RECORD_TYPE_TABLE As Integer = 1
    Const RECORD_TYPE_KEY As Integer = 2
    Const UPDATE_INPUT_FILE = "c:\temp\dzct03.txt"
    Const HOST_USE = "h"
    
    'Get input file from UNIX directory and place in temp directory.
    If Not GetTblFile Then
        UpdateProcess = False
        Exit Function
    Else
        UpdateProcess = True
    End If
    
    'Get current date and time.
    CurDateTime = Now
    
    'Format current date and time for table.
    sTimestamp = Format(CurDateTime, "yyyy-mm-dd:hh:mm:ss:000000")
    
    On Error GoTo FileOpenError
    
    'Open input file.
    iFileNum = FreeFile
    Open fCTempInFile For Input As iFileNum
    UpdateProcess = True
    
    'Priming read on input file.
    Line Input #iFileNum, CurLine
    
    Do Until EOF(iFileNum)
        
        'Parse out the record type, table name, client system use, client occurs.
        iRecordType = Val(ParseString(CurLine, ",", RECORD_TYPE_ARG))
        sTableName = ParseString(CurLine, ",", TABLE_NAME_ARG)
        sCheckSysUsage = ParseString(CurLine, ",", SYSTEM_CHECK_ARG)
                
        'Check input file to determine host or client system use.
        If sCheckSysUsage = HOST_USE Then
            sColumnName = "HostSystemUse"
            sOccursColName = "HostOccurs"
        Else
            sColumnName = "ClientSystemUse"
            sOccursColName = "ClientOccurs"
        End If
            
        On Error GoTo SQLError
        
        'Perform update according to record type.
        Select Case iRecordType
            
            Case RECORD_TYPE_TABLE
                'Set  SQL string.
                SQLUpdate = "UPDATE tblEntries " _
                          & "SET " _
                          & sColumnName & " = False, " _
                          & sOccursColName & " = 0 " _
                          & "WHERE TableName = " & Chr(34) & sTableName & Chr(34) & ";"
            
            Case RECORD_TYPE_KEY
                'Parse out the remaining arguments.
                bKeyBoolean = ParseString(CurLine, ",", USE_FLAG_ARG)
                iKeyOccurs = Val(ParseString(CurLine, ",", OCCURS_NUM_ARG))
                sTableKey = ParseString(CurLine, ",", TABLE_KEY_ARG)
                'Set SQL string.
                SQLUpdate = "UPDATE tblEntries " _
                          & "SET " _
                          & sColumnName & " = " & bKeyBoolean & ", " _
                          & sOccursColName & " = " & iKeyOccurs _
                          & " WHERE TableName = " & Chr(34) & sTableName & Chr(34) _
                          & " AND Key = " & Chr(34) & sTableKey & Chr(34) & ";"
            Case Else
        End Select
         
        On Error GoTo ProcessingRecordError
        
        'Begin DAO transaction.
        wsCTM.BeginTrans
        'Execute SQL.
        dbCTM.Execute SQLUpdate, dbFailOnError
                 
        'Check to see if records were processed.
        If dbCTM.RecordsAffected = 0 Then
            Err.Raise 3, "UpdateProcess", "The record was not updated."
            wsCTM.Rollback
            Counter = Counter + 1
        Else
            wsCTM.CommitTrans
        End If
            
        'Set SQL string.
        SQLUpdate = "UPDATE tblTables " _
                  & "SET FlagUpdateTS = " & Chr(34) & sTimestamp & Chr(34) & " " _
                  & "WHERE TableName = " & Chr(34) & sTableName & Chr(34) & ";"
        
        'Begin DAO transaction.
        wsCTM.BeginTrans
        'Execute SQL.
        dbCTM.Execute SQLUpdate, dbFailOnError
    
        If dbCTM.RecordsAffected = 0 Then
            Err.Raise 4, "UpdateProcess", "tblTables was not updated for " & sTableName & "."
            wsCTM.Rollback
        Else
            'Commit DAO transaction.
            wsCTM.CommitTrans
        End If
         
        TotalRecords = TotalRecords + 1
        'Get the next line.
        Line Input #iFileNum, CurLine
               
    Loop
    
    'Close input file.
    Close iFileNum
    
    Exit Function
    
FileOpenError:
    UpdateProcess = False
    ErrorFound = True
    msg = "The output file which would contain the extracted tables could not be opened." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

SQLError:
    UpdateProcess = False
    ErrorFound = True
    msg = "An error occurred while trying to perform SQL query in UpdateProcess." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

ProcessingRecordError:
    ErrorCounter = ErrorCounter + 1
    UpdateProcess = False
    LogError = True
    msg = ErrorCounter & ": An error occured while loading " & sTableName & " with " & sTableKey & " on " & CurDateTime & " in UpdateProcess." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Place error message into error log file.
    WriteToErrorLog
    Resume Next

End Function

'*************************************************************
'**                        Housekeeping                     **
'*************************************************************
Public Function Housekeeping() As Boolean

    Dim bDatabaseOpened As Boolean
    
    On Error GoTo ArgumentError
    
    'Initialze Variables
    Counter = 0
    
    'Verify that five parameters passed (parse the arguments).
    If Not ParseArgs Then
        Err.Raise 5, Housekeeping, "The arguments were not correctly passed in. Usage:" & _
        " <Function> <Database path> <Project> <UNIX path> <WorkFile>"
    End If
     
    On Error GoTo DatabaseError
    
    'Validate MDB (open the database).
    Set wsCTM = DBEngine.Workspaces(0)
    Set dbCTM = wsCTM.OpenDatabase(fCTMDatabase, False, False)
        
    Select Case sFunction
        Case EXTRACT_FUNC
            'Get the full path including filename of the temp output file and FTP used in ExtractProcess.
            fFTPOutFile = fUNIXPath & "/" & fWorkFile
            fCTempOutFile = "C:\TEMP\" & fWorkFile
    
        Case UPDATE_FUNC
            'Get the full path including filename of the temp input file and FTP used in UpdateProcess.
            fFTPInFile = fUNIXPath & "/" & fWorkFile
            fCTempInFile = "C:\TEMP\" & fWorkFile
    End Select
   
    'Five arguments have been passed.
    Housekeeping = True

Exit Function

ArgumentError:
    Housekeeping = False
    ErrorFound = True
    msg = "An error occurred while evaluating parameters." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send Email.
    SendEmail
    Exit Function
    
DatabaseError:
    Housekeeping = False
    ErrorFound = True
    msg = "An error occurred while trying to open " & fCTMDatabase & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
End Function

'**************************************************************
'**                          Process                         **
'**************************************************************
Public Function Process() As Boolean
    
    On Error GoTo InvalidFunction
    
    If Not GetFTPParameters Then
        Process = False
    Else
        Process = True
    End If
    
    'Perform either Extract or Update.
    Select Case sFunction
        Case EXTRACT_FUNC
            If Not ExtractProcess Then
                Process = False
            Else
                Process = True
            End If
            
        Case UPDATE_FUNC
            If Not UpdateProcess Then
                Process = False
            Else
                Process = True
            End If
            
        Case Else
            Err.Raise 13, Process, "The function argument is neither E or U."
    
    End Select
Exit Function
    
InvalidFunction:
    Process = False
    ErrorFound = True
    msg = "An error occurred while trying to perform Process." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
          
    'Send email.
    SendEmail
End Function

'**************************************************************
'**                          WrapUp                          **
'**************************************************************
Public Function WrapUp() As Boolean

    Dim myftp As New FTP
    Dim sServer As String
    Dim strsql As String
    Dim DaoRS As Recordset
    
    If LogError = True Then
        msg = Counter & " out of " & TotalRecords & " records were not processed." & _
              " Please refer to c:\temp\error.log for more details."
        SendEmail
    End If
    
    If ErrorFound = False Then
        Select Case sFunction
            Case EXTRACT_FUNC
                Kill fCTempOutFile
                            
          Case UPDATE_FUNC
                Kill fCTempInFile
                                
              On Error GoTo SQLError
        
                'Find out what server the project resides on.
                strsql = "Select server " _
                       & "From tblProjectEnv " _
                       & "Where projectenv = " & Chr(39) & fProject & Chr(39)
            
                On Error GoTo RecordsetError
    
                Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

                On Error GoTo GetServerError
    
                If Not DaoRS.EOF Then
                    sServer = DaoRS(0).Value
                Else
                    Err.Raise 15, PutTblFile, "No more records in recordset."
                End If
    
                DaoRS.Close
            
                On Error GoTo FTPError
                        
                With myftp
                     .ErrorMessageBox = False
                     .HostName = sServer
                     .UserName = USER
                     .Password = sFTPParameter
                     .RemoteDirectory = fUNIXPath
                     .RemoteFile = fWorkFile & "*"
                     .DeleteDirectory
                End With
       
               'Check to see if delete was successful.
               If myftp.Error Then
                     WrapUp = False
                     Err.Raise 33, WrapUp, fFTPInFile & " was not delected successfully."
               Else
                     WrapUp = True
               End If
            
        End Select

    End If
    
    'Close DAO transaction.
    dbCTM.Close
    wsCTM.Close
    
Exit Function

SQLError:
    WrapUp = False
    msg = "An error occurred while trying to perform SQL query in WrapUp." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

RecordsetError:
    WrapUp = False
    msg = "An error occurred while trying to open the recordset." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

GetServerError:
    WrapUp = False
    msg = "An error occurred while trying to get server for FTP destination." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

FTPError:
    msg = "An error occurred while trying to delete input file from UNIX." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
End Function





