VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CodesTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private sTable As String
Private sObjectColumn As String   ''' Added Steve
Private sObjectValue As String    ''' Added Steve
Private sForm As String
Private bSortDecode As Boolean
Private bSortCode As Boolean
Private sDecodeColumn As String
Private sCodeColumn As String
Private sConnection As String
Private Type objCT
    Decode As String
    Code As String
End Type
Private TableArray() As objCT

Property Let ObjectColumn(L)  '' Added Steve
    sObjectColumn = L
End Property

Property Let ObjectValue(V) '' Added Steve
    sObjectValue = V
End Property

Property Let Table(T)
    sTable = T
End Property
Property Let DecodeColumn(D)
    sDecodeColumn = D
End Property
Property Let CodeColumn(C)
    sCodeColumn = C
End Property
Property Let SortDecode(s)
    bSortDecode = True
    bSortCode = False
End Property

Property Let SortCode(T)
    bSortDecode = False
    bSortCode = True
End Property

Property Let Connection(O)
    sConnection = O
End Property

Public Sub Retrieve()

ReDim TableArray(0)
''''''''''''''''  Begin Steve Test Open database '''''''''''''''''''''''

    Dim sParameter As String, CTMDatabase As String, Msg As String, RC As Integer, sTransfer As String, x As Integer
    'Dim msg As String, RC As Integer, sTransfer As String, x As Integer
    Dim iFileNum As Integer
    Dim strsql As String, DaoRS As Recordset, wsCTM As Workspace
    Dim bBrowseOnly As Boolean
    'Dim strsql As String
      
    
    'Get the passed in argument (the full path and name of the database to go against).
    sParameter = sConnection
    
    'Check to make sure that the proper arguments are passed in.
    If (Len(sParameter) = 0) Then
        Msg = "To Run the Codes Table Explorer, the following argument must be passed:" _
                    & vbCrLf & vbCrLf & "      - Path and name of CTM Database." _
                    & vbCrLf & "        Ex. " & Chr(34) & "C:\DATA\CTMBrowser.exe T:\Codesdat.mdb" & Chr(34) _
                    & vbCrLf & vbCrLf & "Contact " & AUTHOR & " at Solution Works for assistance."
        
        RC = MsgBox(Msg, vbOKOnly + vbInformation + vbApplicationModal, "Codes Table Update")
       ' End
    ElseIf (InStr(LCase(sParameter), ".mdb") <> 0) Then
        CTMDatabase = sParameter
    Else
        If (Len(Dir(sParameter)) = 0) Then
            Msg = "The initialization file (" & sParameter & ") does not exist. " _
                  & vbCrLf & vbCrLf & "Contact " & AUTHOR & " at Solution Works for assistance."
            RC = MsgBox(Msg, vbOKOnly + vbInformation + vbApplicationModal, "Codes Table Update")
          '  End
        Else
            If (FileLen(sParameter) = 0) Then
                Msg = "The initialization file (" & sParameter & ") is empty. " _
                      & vbCrLf & vbCrLf & "Contact " & AUTHOR & " at Solution Works for assistance."
                RC = MsgBox(Msg, vbOKOnly + vbInformation + vbApplicationModal, "Codes Table Update")
             '   End
            Else
                iFileNum = FreeFile
                Open sParameter For Input As #iFileNum
                Line Input #iFileNum, CTMDatabase
                Close #iFileNum
            End If
        End If
    End If
       
    'Open the Jet workspace.
    Set wsCTM = DBEngine.Workspaces(0)

    'Attempt to open the database in shared edit mode. Comment this out to switch to using ODBC.
    Set dbCTM = Workspaces(0).OpenDatabase(CTMDatabase, False, True)
    
    'Set the length of the query timeouts.
    dbCTM.QueryTimeout = 15
    
    'Get the current transfer name of this database.
    'strsql = "select Project from tblProject where ProjectFlag = True

''''''''''''' End Steve Test Database ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
   
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
If sObjectValue = "" Then
  
    If (bSortDecode = True) Then
        strsql = "Select " & sCodeColumn & ", " & sDecodeColumn _
                & " From " & sTable _
                & " Order By " & sDecodeColumn
    Else
        strsql = "Select " & sCodeColumn & ", " & sDecodeColumn _
                & " From " & sTable _
                & " Order By " & sCodeColumn
    End If

Else

    If (bSortDecode = True) Then
        strsql = "Select " & sCodeColumn & ", " & sDecodeColumn _
                & " From " & sTable _
                & " Where (" & sObjectColumn & " = " & Chr(39) & sObjectValue & Chr(39) & ")" _
                & " Order By " & sDecodeColumn
    Else
        strsql = "Select " & sCodeColumn & ", " & sDecodeColumn _
                & " From " & sTable _
                & " Where (" & sObjectColumn & " = " & Chr(39) & sObjectValue & Chr(39) & ")" _
                & " Order By " & sCodeColumn
    End If
    
End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)

    If Not DaoRS.EOF Then

        While Not DaoRS.EOF
            TableArray(UBound(TableArray)).Code = DaoRS(0).Value
            TableArray(UBound(TableArray)).Decode = DaoRS(1).Value
            ReDim Preserve TableArray(UBound(TableArray) + 1)
            DaoRS.MoveNext
        Wend

        DaoRS.Close

    End If

Exit Sub

ODBCError:
    
    'The database cannot be opened in shared mode - someone has it exclusively.
    If (Err.Number = 3051) Then
        RC = MsgBox("Unable to open the database in shared edit mode." & vbCrLf & _
                    "Would you like to open the database in browse mode only?", _
                    vbYesNo + vbQuestion + vbApplicationModal, _
                    "Codes Table Explorer")
        
        If (RC = vbYes) Then
            bBrowseOnly = True
            Set dbCTM = wsCTM.OpenDatabase(CTMDatabase, False, True)
            Resume Next
        Else
         '   End
        End If
    End If
    
    'Display the error information and exit.
    Msg = "An error has occured during Form_Load" & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
   
    RC = MsgBox(Msg, _
                vbOKOnly + vbCritical + vbMsgBoxHelpButton + vbApplicationModal, _
                "Codes Table Explorer", _
                Err.HelpFile, Err.HelpContext)
    Err.Clear
    
    Unload Me

End Sub

Property Get Code(N)
    If N > UBound(TableArray) Or N < 0 Then
        Code = -1
    Else
        Code = TableArray(N).Code
    End If
End Property

Property Get Decode(E)
    If E > UBound(TableArray) Or E < 0 Then
        Decode = vbNullChar
    Else
        Decode = TableArray(E).Decode
    End If
End Property

