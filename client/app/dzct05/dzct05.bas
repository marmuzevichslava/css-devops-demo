Attribute VB_Name = "mdldzct05"
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
Public DaoRS As Recordset
Public sRelationType As String
Public iFileNum As Integer
Public iErrorFile As Integer
Public msg As String
Public fCTempInFile As String
Public fCTempOutFile As String
Public fFTPInFile As String
Public fFTPOutFile As String
Public ErrorFound As Boolean
Public LogError As Boolean
Public sFTPParameter As String
Const fErrorLogFile As String = "c:\temp\static_error.log"
Const EXTRACT_TABLES As String = "E"
Const CODES_ENTRIES As String = "C"
Const BFA_ENTRIES As String = "B"
Const RELATIONAL_ENTRIES = "R"
Const USER As String = "pvcs"
Const TABLE_TYPE = 4

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

'*************************************************************
'**                     WriteToErrorLog                     **
'*************************************************************
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
   


'************************************************************
'**                          Email                         **
'************************************************************
Private Sub SendEmail()

Dim myemail As New Email

With myemail
    .USER = "edeutsch"
    .Subject = "Email from Static Update Process"
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
    Const RELATION_TYPE As Integer = 1
    Const DATABASE_PATH As Integer = 2
    Const PROJECT_NAME As Integer = 3
    Const PATH_ARG As Integer = 4
    Const WORKFILE As Integer = 5
    
    'Grab the command line argument string.
    CmdStr = Command
    
    'Get the value of the function for extract or update (C or B).
    sRelationType = ParseString(CmdStr, " ", RELATION_TYPE)
    
    'Get the name of the access database to update.
    fCTMDatabase = ParseString(CmdStr, " ", DATABASE_PATH)
    
    'Get the project name.
    fProject = ParseString(CmdStr, " ", PROJECT_NAME)
    
    'Get the destination pathname.
    fUNIXPath = ParseString(CmdStr, " ", PATH_ARG)
    
    'Get the workfile name.
    fWorkFile = ParseString(CmdStr, " ", WORKFILE)
    
    'Check to see if arguments are not empty.
    If sRelationType <> " " And fCTMDatabase <> " " And fProject <> " " And fUNIXPath <> " " And fWorkFile <> " " Then
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
    
    'Set SQL string.
        SQLQuery = "SELECT TableName" _
                 & " FROM tblTables" _
                 & " WHERE TableType = 4;"
         
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
'**                   DeleteRelationalTables                **
'*************************************************************
Public Function DeleteRelationalTables() As Boolean
     
    Dim SQLDelete As String
    Dim SQLQuery As String
    
    On Error GoTo SQLQueryError
        
    'Query to see if static tables exist in tblRelTables.
    SQLQuery = "SELECT TableName " _
             & "FROM tblRelTables;"
                      
    On Error GoTo RecordsetError1
    
    Set DaoRS = dbCTM.OpenRecordset(SQLQuery, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then
        On Error GoTo SQLDeleteError
    
        'Delete static tables from tblRelTables.
        SQLDelete = "DELETE * " _
                  & "FROM tblRelTables;"
                  
        On Error GoTo ProcessingRelationalTableDeleteError
                           
        'Begin DAO transaction.
        wsCTM.BeginTrans
        'Execute SQL.
        dbCTM.Execute SQLDelete, dbFailOnError
    
        If dbCTM.RecordsAffected = 0 Then
            Err.Raise 4, "UpdateProcess", "The static tables were not deleted from tblRelTables."
            wsCTM.Rollback
        Else
            'Commit DAO transaction.
            wsCTM.CommitTrans
        End If
    Else
        DaoRS.Close
    End If
       
    DeleteRelationalTables = True
    
    Exit Function

SQLDeleteError:
    DeleteRelationalTables = False
    ErrorFound = True
    msg = "An error occurred while trying to perform SQLDelete in DeleteCodesRelations." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

ProcessingRelationalTableDeleteError:
    DeleteRelationalTables = False
    LogError = True
    msg = "An error occured while to delete the static tables from tblRelTables." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Place error message into error log file.
    WriteToErrorLog
    Resume Next

RecordsetError1:
    DeleteRelationalTables = False
    ErrorFound = True
    msg = "An error occurred while trying to open the recordset in DeleteCodesRelations which checks to see if any static tables exists in tblRelTables before deleting them." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

SQLQueryError:
    DeleteRelationalTables = False
    ErrorFound = True
    msg = "An error occurred while trying to perform SQL query in DeleteCodesRelations." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

End Function

'*************************************************************
'**                   RelationalTablesUpdate                **
'*************************************************************
Public Function RelationalTablesUpdate() As Boolean

    'Local variables.
    Dim sTimestamp As String
    Dim sRelTabName As String
    Dim sRelTabDecode As String
    Dim SQLInsert As String
    Dim SQLQuery As String
    Dim CurLine As String
    Dim CurDateTime As String
    Const REL_TABLE_ARG As Integer = 1
    Const REL_DECODE_ARG As Integer = 2
    Const UPDATE_INPUT_FILE = "c:\temp\dzct03.txt"
        
    'Get input file from UNIX directory and place in temp directory.
    If Not GetTblFile Then
        RelationalTablesUpdate = False
        Exit Function
    Else
        RelationalTablesUpdate = True
    End If
    
    'Delete existing static information.
    If Not DeleteRelationalTables Then
        RelationalTablesUpdate = False
        Exit Function
    Else
        RelationalTablesUpdate = True
    End If
    
    'Get current date and time.
    CurDateTime = Now
    
    'Format current date and time for table.
    sTimestamp = Format(CurDateTime, "yyyy-mm-dd:hh:mm:ss:000000")
    
    On Error GoTo FileOpenError
    
    'Open input file.
    iFileNum = FreeFile
    Open fCTempInFile For Input As iFileNum
    RelationalTablesUpdate = True
    
    'Priming read on input file.
    Line Input #iFileNum, CurLine
    
    Do Until EOF(iFileNum)
        
        'Parse out the relational table name.
        sRelTabName = ParseString(CurLine, ",", REL_TABLE_ARG)
        sRelTabDecode = ParseString(CurLine, ",", REL_DECODE_ARG)
                            
        On Error GoTo SQLQueryError
        
        'Query to see if static table exists in tblRelTables.
        SQLQuery = "SELECT TableName " _
                 & "FROM tblRelTables " _
                 & "WHERE TableName = " & Chr(34) & sRelTabName & Chr(34)
                      
        On Error GoTo RecordsetError1
    
        Set DaoRS = dbCTM.OpenRecordset(SQLQuery, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

        On Error GoTo RelationalTablesSQLInsertError
    
        If DaoRS.EOF Then
            'Set SQL string.
            SQLInsert = "INSERT INTO tblRelTables " _
                      & "SELECT " & Chr(34) & sRelTabName & Chr(34) & " As TableName," _
                      & Chr(34) & sRelTabDecode & Chr(34) & " AS TableDecode;"
                      
            On Error GoTo ProcessingRelationalTablesError
        
            'Begin DAO transaction.
            wsCTM.BeginTrans
            'Execute SQL.
            dbCTM.Execute SQLInsert, dbFailOnError
    
            If dbCTM.RecordsAffected = 0 Then
                Err.Raise 4, "UpdateProcess", "tblRelTables was not updated for " & sRelTabName & "."
                wsCTM.Rollback
            Else
                'Commit DAO transaction.
                wsCTM.CommitTrans
            End If
        Else
            DaoRS.Close
        End If
                
        'Get the next line.
        Line Input #iFileNum, CurLine
               
    Loop
    
    'Close input file.
    Close iFileNum
    
    Exit Function
    
FileOpenError:
    RelationalTablesUpdate = False
    ErrorFound = True
    msg = "The output file which would contain the list of tables could not be opened." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

ProcessingRelationalTablesError:
    RelationalTablesUpdate = False
    LogError = True
    msg = "An error occured while trying to insert the relational table " & sRelTabName & " into tblRelTables." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Place error message into error log file.
    WriteToErrorLog
    Resume Next

RecordsetError1:
    RelationalTablesUpdate = False
    ErrorFound = True
    msg = "An error occurred while trying to open the recordset in RelationalTablesUpdate which checks to see if the relational table exists in tblRelTables." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

SQLQueryError:
    RelationalTablesUpdate = False
    ErrorFound = True
    msg = "An error occurred while trying to perform SQL query in RelationalTablesUpdate." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

RelationalTablesSQLInsertError:
    RelationalTablesUpdate = False
    ErrorFound = True
    msg = "An error occurred while performing SQLInsert for relational table names in RelationalTablesUpdate." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
   'Send email.
    SendEmail
Exit Function

End Function

'*************************************************************
'**                    DeleteCodesRelations                 **
'*************************************************************
Public Function DeleteCodesRelations() As Boolean
         
    Dim SQLDelete As String
    Dim SQLQuery As String
    
    On Error GoTo SQLQueryError
        
    'Query to see if codes table relationships exist in tblStaticCodesEntries.
    SQLQuery = "SELECT * " _
             & "FROM tblStaticCodesEntries;"
                      
    On Error GoTo RecordsetError2
    
    Set DaoRS = dbCTM.OpenRecordset(SQLQuery, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then
        On Error GoTo SQLDeleteError
    
        'Delete all rows from tblStaticCodesEntries.
        SQLDelete = "DELETE * " _
                  & "FROM tblStaticCodesEntries;"
                      
        On Error GoTo ProcessingRelationshipDeleteError
                           
        'Begin DAO transaction.
        wsCTM.BeginTrans
        'Execute SQL.
        dbCTM.Execute SQLDelete, dbFailOnError
    
        If dbCTM.RecordsAffected = 0 Then
            Err.Raise 4, "UpdateProcess", "A row was not deleted from tblStaticCodesEntries."
            wsCTM.Rollback
        Else
            'Commit DAO transaction.
            wsCTM.CommitTrans
        End If
    Else
        DaoRS.Close
    End If
        
    On Error GoTo SQLQueryError
        
    'Query to see if codes table exists in tblCodesLookup.
    SQLQuery = "SELECT * " _
             & "FROM tblCodesLookup;"
                      
    On Error GoTo RecordsetError3
    
    Set DaoRS = dbCTM.OpenRecordset(SQLQuery, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then
        On Error GoTo SQLDeleteError
    
        'Delete all rows from tblCodesLookup.
        SQLDelete = "DELETE * " _
                  & "FROM tblCodesLookup;"
                      
        On Error GoTo ProcessingCodesLookupDeleteError
                           
        'Begin DAO transaction.
        wsCTM.BeginTrans
        'Execute SQL.
        dbCTM.Execute SQLDelete, dbFailOnError
    
        If dbCTM.RecordsAffected = 0 Then
            Err.Raise 4, "UpdateProcess", "A row was not deleted from tblStaticCodesEntries."
            wsCTM.Rollback
        Else
            'Commit DAO transaction.
            wsCTM.CommitTrans
        End If
    Else
        DaoRS.Close
    End If
    
    DeleteCodesRelations = True
    
    Exit Function

SQLDeleteError:
    DeleteCodesRelations = False
    ErrorFound = True
    msg = "An error occurred while trying to perform SQLDelete in DeleteCodesRelations." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

ProcessingRelationshipDeleteError:
    DeleteCodesRelations = False
    LogError = True
    msg = "An error occured while to delete the static/codes relationships from tblStaticCodesEntries." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Place error message into error log file.
    WriteToErrorLog
    Resume Next

ProcessingCodesLookupDeleteError:
    DeleteCodesRelations = False
    LogError = True
    msg = "An error occured while to delete the codes table decodes from tblCodesLookup." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Place error message into error log file.
    WriteToErrorLog
    Resume Next

RecordsetError2:
    DeleteCodesRelations = False
    ErrorFound = True
    msg = "An error occurred while trying to open the recordset in DeleteCodesRelations which checks to see if any static/codes relatrionships exist in tblStaticCodesEntries before deleting them." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

RecordsetError3:
    DeleteCodesRelations = False
    ErrorFound = True
    msg = "An error occurred while trying to open the recordset in DeleteCodesRelations which checks to see if any code lookups exist in tblCodesLookup before deleting them." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

SQLQueryError:
    DeleteCodesRelations = False
    ErrorFound = True
    msg = "An error occurred while trying to perform SQL query in DeleteCodesRelations." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

End Function

'*************************************************************
'**                   CodesUpdateProcess                    **
'*************************************************************
Public Function CodesUpdateProcess() As Boolean

'Local variables.
    Dim sTimestamp As String
    Dim sCodesTableDecode As String
    Dim sStaticTabNum As String
    Dim sCodesTableName As String
    Dim SQLInsert As String
    Dim SQLQuery As String
    Dim CurLine As String
    Dim CurDateTime As String
    Const STAT_NUM_ARG As Integer = 1
    Const CODES_TAB_NAME_ARG As Integer = 2
    Const CODES_TAB_DECODE_ARG As Integer = 3
    Const UPDATE_INPUT_FILE = "c:\temp\dzct03.txt"
        
    'Get input file from UNIX directory and place in temp directory.
    If Not GetTblFile Then
        CodesUpdateProcess = False
        Exit Function
    Else
        CodesUpdateProcess = True
    End If
    
    'Delete existing static information.
    If Not DeleteCodesRelations Then
        CodesUpdateProcess = False
        Exit Function
    Else
        CodesUpdateProcess = True
    End If
    
    'Get current date and time.
    CurDateTime = Now
    
    'Format current date and time for table.
    sTimestamp = Format(CurDateTime, "yyyy-mm-dd:hh:mm:ss:000000")
    
    On Error GoTo FileOpenError
    
    'Open input file.
    iFileNum = FreeFile
    Open fCTempInFile For Input As iFileNum
    CodesUpdateProcess = True
    
    'Priming read on input file.
    Line Input #iFileNum, CurLine
    
    Do Until EOF(iFileNum)
        
        'Parse out the Static Table #, Static Table Name, Copybook Name, and BFA.
        sStaticTabNum = ParseString(CurLine, ",", STAT_NUM_ARG)
        sCodesTableName = ParseString(CurLine, ",", CODES_TAB_NAME_ARG)
        sCodesTableDecode = ParseString(CurLine, ",", CODES_TAB_DECODE_ARG)
                
        On Error GoTo RelationshipSQLInsertError
        
        'Perform update for static/codes relationships..
                      
        'Set SQL string.
        SQLInsert = "INSERT INTO tblStaticCodesEntries " _
                  & " SELECT " & Chr(34) & sStaticTabNum & Chr(34) & " AS TableName," _
                  & Chr(34) & sCodesTableName & Chr(34) & " AS CISName;"
                
        On Error GoTo ProcessingRelationshipError
        
        'Begin DAO transaction.
        wsCTM.BeginTrans
        'Execute SQL.
        dbCTM.Execute SQLInsert, dbFailOnError
                 
        'Check to see if records were processed.
        If dbCTM.RecordsAffected = 0 Then
             Err.Raise 3, "UpdateProcess", "The relationship was not inserted."
             wsCTM.Rollback
        Else
             wsCTM.CommitTrans
        End If
                                
        On Error GoTo SQLQueryError
        
        'Query to see if codes table exists in tblCodesLookup.
        SQLQuery = "SELECT CISName " _
                 & "FROM tblCodesLookup " _
                 & "WHERE CISName = " & Chr(34) & sCodesTableName & Chr(34)
                      
        On Error GoTo RecordsetError2
               
        Set DaoRS = dbCTM.OpenRecordset(SQLQuery, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

        On Error GoTo CodesLookupSQLInsertError
    
        If DaoRS.EOF Then
            'Set SQL string.
            SQLInsert = "INSERT INTO tblCodesLookup " _
                      & "SELECT " & Chr(34) & sCodesTableName & Chr(34) & " As CISName," _
                      & Chr(34) & sCodesTableDecode & Chr(34) & " AS CISCOBOLName;"
                          
        On Error GoTo ProcessingCodesLookupError
        
            'Begin DAO transaction.
            wsCTM.BeginTrans
            'Execute SQL.
            dbCTM.Execute SQLInsert, dbFailOnError
    
            If dbCTM.RecordsAffected = 0 Then
                Err.Raise 10, "UpdateProcess", "tblCodesLookup was not updated for " & sCodesTableName & "."
                wsCTM.Rollback
            Else
                'Commit DAO transaction.
                wsCTM.CommitTrans
            End If
        Else
            DaoRS.Close
        End If
            
        'Get the next line.
        Line Input #iFileNum, CurLine
               
    Loop
    
    'Close input file.
    Close iFileNum
    
    Exit Function
    
FileOpenError:
    CodesUpdateProcess = False
    ErrorFound = True
    msg = "The output file which would contain the list of tables could not be opened." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

SQLQueryError:
    CodesUpdateProcess = False
    ErrorFound = True
    msg = "An error occurred while trying to perform SQL query in CodesUpdateProcess." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

ProcessingRelationshipError:
    CodesUpdateProcess = False
    LogError = True
    msg = "An error occured while inserting the relationship between " & sStaticTabNum & " and " & sCodesTableName & " on " & CurDateTime & " in UpdateProcess." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Place error message into error log file.
    WriteToErrorLog
    Resume Next
    
ProcessingCodesLookupError:
    CodesUpdateProcess = False
    LogError = True
    msg = "An error occured while trying to insert the codes lookup name for " & sCodesTableName & " into tblCodesLookup." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Place error message into error log file.
    WriteToErrorLog
    Resume Next

RecordsetError2:
    CodesUpdateProcess = False
    ErrorFound = True
    msg = "An error occurred while trying to open the recordset in CodesUpdateProcess which checks to see if the codes table exists in tblCodesLookup." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

RelationshipSQLInsertError:
    CodesUpdateProcess = False
    ErrorFound = True
    msg = "An error occurred while performing SQLInsert for static/codes relationships in CodesUpdateProcess." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
   'Send email.
    SendEmail
Exit Function

CodesLookupSQLInsertError:
    CodesUpdateProcess = False
    ErrorFound = True
    msg = "An error occurred while performing SQLInsert for codes lookup in CodesUpdateProcess." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
   'Send email.
    SendEmail
Exit Function

End Function

'*************************************************************
'**                        GetTblFile                       **
'*************************************************************
Public Function GetTblFile() As Boolean

    Dim myftp As New FTP
    Dim sServer As String
    Dim strsql As String
           
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
'**                    DeleteBFARelations                   **
'*************************************************************
Public Function DeleteBFARelations() As Boolean

    Dim SQLDelete As String
    Dim SQLQuery As String
    
    On Error GoTo SQLQueryError
        
    'Query to see if static/bfa entries exist in tblStaticBFAEntries.
    SQLQuery = "SELECT * " _
             & "FROM tblStaticBFAEntries;"
                      
    On Error GoTo RecordsetError2
    
    Set DaoRS = dbCTM.OpenRecordset(SQLQuery, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then
        On Error GoTo SQLDeleteError
    
        'Delete all rows from tblStaticCodesEntries.
        SQLDelete = "DELETE * " _
                  & "FROM tblStaticBFAEntries;"
                      
        On Error GoTo ProcessingRelationshipDeleteError
                           
        'Begin DAO transaction.
        wsCTM.BeginTrans
        'Execute SQL.
        dbCTM.Execute SQLDelete, dbFailOnError
    
        If dbCTM.RecordsAffected = 0 Then
            Err.Raise 4, "UpdateProcess", "A row was not deleted from tblStaticCodesEntries."
            wsCTM.Rollback
        Else
            'Commit DAO transaction.
            wsCTM.CommitTrans
        End If
    Else
        DaoRS.Close
    End If
        
    On Error GoTo SQLQueryError
        
    'Query to see if entries exist in tblBFALookup.
    SQLQuery = "SELECT * " _
             & "FROM tblBFALookup;"
                      
    On Error GoTo RecordsetError3
    
    Set DaoRS = dbCTM.OpenRecordset(SQLQuery, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then
        On Error GoTo SQLDeleteError
    
        'Delete all rows from tblCodesLookup.
        SQLDelete = "DELETE * " _
                  & "FROM tblBFALookup;"
                      
        On Error GoTo ProcessingBFALookupDeleteError
                           
        'Begin DAO transaction.
        wsCTM.BeginTrans
        'Execute SQL.
        dbCTM.Execute SQLDelete, dbFailOnError
    
        If dbCTM.RecordsAffected = 0 Then
            Err.Raise 4, "UpdateProcess", "A row was not deleted from tblStaticCodesEntries."
            wsCTM.Rollback
        Else
            'Commit DAO transaction.
            wsCTM.CommitTrans
        End If
    Else
        DaoRS.Close
    End If
    
    DeleteBFARelations = True
    
    Exit Function

SQLDeleteError:
    DeleteBFARelations = False
    ErrorFound = True
    msg = "An error occurred while trying to perform SQLDelete in DeleteBFARelations." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

ProcessingRelationshipDeleteError:
    DeleteBFARelations = False
    LogError = True
    msg = "An error occured while to delete the static/bfa relationships from tblStaticBFAEntries." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Place error message into error log file.
    WriteToErrorLog
    Resume Next

ProcessingBFALookupDeleteError:
    DeleteBFARelations = False
    LogError = True
    msg = "An error occured while to delete the bfas from tblBFALookup." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Place error message into error log file.
    WriteToErrorLog
    Resume Next

RecordsetError2:
    DeleteBFARelations = False
    ErrorFound = True
    msg = "An error occurred while trying to open the recordset in DeleteBFARelations which checks to see if any static/codes relatrionships exist in tblStaticBFAEntries before deleting them." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

RecordsetError3:
    DeleteBFARelations = False
    ErrorFound = True
    msg = "An error occurred while trying to open the recordset in DeleteBFARelations which checks to see if any code lookups exist in tblBFALookup before deleting them." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

SQLQueryError:
    DeleteBFARelations = False
    ErrorFound = True
    msg = "An error occurred while trying to perform SQL query in DeleteBFARelations." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function
 
End Function

'*************************************************************
'**                    BFAUpdateProcess                     **
'*************************************************************
Public Function BFAUpdateProcess() As Boolean
    
    'Local variables.
    Dim sTimestamp As String
    Dim sCopybookName As String
    Dim sStaticTabNum As String
    Dim sBFAName As String
    Dim SQLInsert As String
    Dim SQLQuery As String
    Dim CurLine As String
    Dim CurDateTime As String
    Const STAT_NUM_ARG As Integer = 1
    Const COPYBOOK_ARG As Integer = 2
    Const BFA_NAME_ARG As Integer = 3
    Const UPDATE_INPUT_FILE = "c:\temp\dzct03.txt"
        
    'Get input file from UNIX directory and place in temp directory.
    If Not GetTblFile Then
        BFAUpdateProcess = False
        Exit Function
    Else
        BFAUpdateProcess = True
    End If
    
    'Delete existing static information.
    If Not DeleteBFARelations Then
        BFAUpdateProcess = False
        Exit Function
    Else
        BFAUpdateProcess = True
    End If
    
    'Get current date and time.
    CurDateTime = Now
    
    'Format current date and time for table.
    sTimestamp = Format(CurDateTime, "yyyy-mm-dd:hh:mm:ss:000000")
    
    On Error GoTo FileOpenError
    
    'Open input file.
    iFileNum = FreeFile
    Open fCTempInFile For Input As iFileNum
    BFAUpdateProcess = True
    
    'Priming read on input file.
    Line Input #iFileNum, CurLine
    
    Do Until EOF(iFileNum)
        
        'Parse out the Static Table #, Static Table Name, Copybook Name, and BFA.
        sStaticTabNum = ParseString(CurLine, ",", STAT_NUM_ARG)
        sCopybookName = ParseString(CurLine, ",", COPYBOOK_ARG)
        sBFAName = ParseString(CurLine, ",", BFA_NAME_ARG)
                
        On Error GoTo RelationshipSQLInsertError
        
        'Perform update for static/bfa relationships..
                        
        'Set  SQL string.
        SQLInsert = "INSERT INTO tblStaticBFAEntries " _
                  & " SELECT " & Chr(34) & sStaticTabNum & Chr(34) & " AS TableName," _
                  & Chr(34) & sCopybookName & Chr(34) & " AS CopybookName;"
                
        On Error GoTo ProcessingRelationshipError
        
        'Begin DAO transaction.
        wsCTM.BeginTrans
        'Execute SQL.
        dbCTM.Execute SQLInsert, dbFailOnError
                 
        'Check to see if records were processed.
        If dbCTM.RecordsAffected = 0 Then
            Err.Raise 3, "UpdateProcess", "The record was not updated."
            wsCTM.Rollback
        Else
            wsCTM.CommitTrans
        End If
            
        On Error GoTo SQLQueryError
        
        'Query to see if codes table exists in tblCodesLookup.
        SQLQuery = "SELECT CopybookName " _
                 & "FROM tblBFALookup " _
                 & "WHERE CopybookName = " & Chr(34) & sCopybookName & Chr(34)
                      
        On Error GoTo RecordsetError2
               
        Set DaoRS = dbCTM.OpenRecordset(SQLQuery, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

        On Error GoTo BFALookupSQLInsertError
    
        If DaoRS.EOF Then
            'Set SQL string.
            SQLInsert = "INSERT INTO tblBFALookup " _
                      & "SELECT " & Chr(34) & sCopybookName & Chr(34) & " As CopybookName," _
                      & Chr(34) & sBFAName & Chr(34) & " AS BFAName;"
                  
            On Error GoTo ProcessingBFALookupError
            
            'Begin DAO transaction.
            wsCTM.BeginTrans
            'Execute SQL.
            dbCTM.Execute SQLInsert, dbFailOnError
    
            If dbCTM.RecordsAffected = 0 Then
                Err.Raise 10, "UpdateProcess", "tblBFALookup was not updated for " & sCopybookName & "."
                wsCTM.Rollback
            Else
                'Commit DAO transaction.
                wsCTM.CommitTrans
            End If
        Else
            DaoRS.Close
        End If
        
        'Get the next line.
        Line Input #iFileNum, CurLine
               
    Loop
    
    'Close input file.
    Close iFileNum
    
    Exit Function
    
FileOpenError:
    BFAUpdateProcess = False
    ErrorFound = True
    msg = "The output file which would contain the list of tables could not be opened." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

RelationshipSQLInsertError:
    BFAUpdateProcess = False
    ErrorFound = True
    msg = "An error occurred while performing SQLInsert for static/BFA relationships in BFAUpdateProcess." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
   'Send email.
    SendEmail
Exit Function

ProcessingBFALookupError:
    BFAUpdateProcess = False
    LogError = True
    msg = "An error occured while trying to insert the codes lookup name for " & sCopybookName & " into tblBFALookup." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Place error message into error log file.
    WriteToErrorLog
    Resume Next

ProcessingRelationshipError:
    BFAUpdateProcess = False
    LogError = True
    msg = "An error occured while inserting the relationship between " & sStaticTabNum & " and " & sCopybookName & " on " & CurDateTime & " in BFAUpdateProcess." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Place error message into error log file.
    WriteToErrorLog
    Resume Next

SQLQueryError:
    BFAUpdateProcess = False
    ErrorFound = True
    msg = "An error occurred while trying to perform SQL query in BFAUpdateProcess." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

BFALookupSQLInsertError:
    BFAUpdateProcess = False
    ErrorFound = True
    msg = "An error occurred while performing SQLInsert for BFA lookup in BFAUpdateProcess." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
   'Send email.
    SendEmail
Exit Function

RecordsetError2:
    BFAUpdateProcess = False
    ErrorFound = True
    msg = "An error occurred while trying to open the recordset in BFAUpdateProcess which checks to see if the codes table exists in tblBFALookup." & _
          " Error number is " & Err.Number & _
          " Error source is " & Err.Source & _
          " Error description is " & Err.Description
    'Send email.
    SendEmail
Exit Function

End Function

'*************************************************************
'**                        Housekeeping                     **
'*************************************************************
Public Function Housekeeping() As Boolean

    Dim bDatabaseOpened As Boolean
    
    On Error GoTo ArgumentError
    
    'Verify that five parameters passed (parse the arguments).
    If Not ParseArgs Then
        Err.Raise 5, Housekeeping, "The arguments were not correctly passed in. Usage:" & _
        " <E, C or B> <Database path> <Project> <UNIX path> <WorkFile>"
    End If
     
    On Error GoTo DatabaseError
    
    'Validate MDB (open the database).
    Set wsCTM = DBEngine.Workspaces(0)
    Set dbCTM = wsCTM.OpenDatabase(fCTMDatabase, False, False)
        
    Select Case sRelationType
        Case EXTRACT_TABLES
            'Get the full path including filename of the temp output file and FTP used in ExtractProcess.
            fFTPOutFile = fUNIXPath & "/" & fWorkFile
            fCTempOutFile = "C:\TEMP\" & fWorkFile
            
        Case CODES_ENTRIES
            'Get the full path including filename of the temp input file and FTP used in CodesUpdateProcess.
            fFTPInFile = fUNIXPath & "/" & fWorkFile
            fCTempInFile = "C:\TEMP\" & fWorkFile
    
        Case BFA_ENTRIES
            'Get the full path including filename of the temp input file and FTP used in BFAUpdateProcess.
            fFTPInFile = fUNIXPath & "/" & fWorkFile
            fCTempInFile = "C:\TEMP\" & fWorkFile
            
        Case RELATIONAL_ENTRIES
            'Get the full path including filename of the temp input file and FTP used in CodesUpdateProcess.
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
        
    'Perform either Codes Entries or BFA Entries.
    Select Case sRelationType
        Case EXTRACT_TABLES
            If Not ExtractProcess Then
                Process = False
            Else
                Process = True
            End If
            
        Case CODES_ENTRIES
            If Not CodesUpdateProcess Then
                Process = False
            Else
                Process = True
            End If
            
        Case BFA_ENTRIES
            If Not BFAUpdateProcess Then
                Process = False
            Else
                Process = True
            End If
            
        Case RELATIONAL_ENTRIES
            If Not RelationalTablesUpdate Then
                Process = False
            Else
                Process = True
            End If
            
        Case Else
            Err.Raise 13, Process, "The function argument is neither E, C or B."
    
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
        
    If LogError = True Then
        msg = " Please refer to c:\temp\static_error.log for more details."
        SendEmail
    End If
    
    If ErrorFound = False Then
        Select Case sRelationType
            Case EXTRACT_TABLES
                Kill fCTempOutFile
                
            Case CODES_ENTRIES
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
                    Err.Raise 15, WrapUp, "No more records in recordset."
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
                                            
            Case BFA_ENTRIES
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
                    Err.Raise 15, WrapUp, "No more records in recordset."
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
            
            Case RELATIONAL_ENTRIES
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
                    Err.Raise 15, WrapUp, "No more records in recordset."
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


