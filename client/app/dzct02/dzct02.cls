VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "FTP"
Attribute VB_GlobalNameSpace = True
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Private bError As Boolean
Private bErrMsgBox As Boolean
Private strHost As String
Private strRemoteFile As String
Private strLocalFile As String
Private strRemoteDir As String
Private strLocalDir As String
Private strUserID As String
Private strPassword As String
Private sErrorDescription As String
Private lErrorNumber As Long

'**********************************************************************
'FTP Specific Declarations.
'**********************************************************************
Dim hInet As Long
Dim hFtp As Long

Private Const FTP_TRANSFER_TYPE_BINARY As Long = 2
Private Const FTP_SUCCESS = 1
Private Const FTP_ERROR = 0
Private Const INTERNET_DEFAULT_FTP_PORT As Long = 21
Private Const INTERNET_FLAG_PASSIVE As Long = &H8000000
Private Const INTERNET_OPEN_TYPE_PRECONFIG As Long = 0
Private Const INTERNET_SERVICE_FTP As Long = 1
Private Const FILE_ATTRIBUTE_NORMAL = &H80
Private Const MAX_PATH = 260
Private Const ERROR_NO_MORE_FILES = 18&

'**********************************************************************
'Type declarations
'**********************************************************************
Private Type FILETIME
        dwLowDateTime As Long
        dwHighDateTime As Long
End Type

Private Type WIN32_FIND_DATA
        dwFileAttributes As Long
        ftCreationTime As FILETIME
        ftLastAccessTime As FILETIME
        ftLastWriteTime As FILETIME
        nFileSizeHigh As Long
        nFileSizeLow As Long
        dwReserved0 As Long
        dwReserved1 As Long
        cFileName As String * MAX_PATH
        cAlternate As String * 14
End Type

'**********************************************************************
' API Declarations
'**********************************************************************
Private Declare Function FtpGetFile Lib "wininet" Alias "FtpGetFileA" _
                 (ByVal hFtp As Long, _
                  ByVal lpszRemoteFile As String, _
                  ByVal lpszNewFile As String, _
                  ByVal fFailIfExists As Long, _
                  ByVal dwFlagsAndAttributes As Long, _
                  ByVal dwFlags As Long, _
                  ByVal dwContext As Long) As Long

Private Declare Function FtpFindFirstFile Lib "wininet" Alias "FtpFindFirstFileA" _
                 (ByVal hFtpSession As Long, _
                  ByVal lpszSearchFile As String, _
                  lpFindFileData As WIN32_FIND_DATA, _
                  ByVal dwFlags As Long, _
                  ByVal dwContext As Long) As Long

Private Declare Function InternetFindNextFile Lib "wininet" Alias "InternetFindNextFileA" _
                 (ByVal hfind As Long, _
                  lpFindFileData As WIN32_FIND_DATA) As Long

Private Declare Function FtpPutFile Lib "wininet" Alias "FtpPutFileA" _
                 (ByVal hFtp As Long, _
                  ByVal lpszLocalFile As String, _
                  ByVal lpszNewRemoteFile As String, _
                  ByVal dwFlags As Long, _
                  ByVal dwContext As Long) As Long
                
Private Declare Function FtpDeleteFile Lib "wininet" Alias "FtpDeleteFileA" _
                 (ByVal hFtp As Long, _
                  ByVal lpszFileName As String) As Long
                
Private Declare Function InternetCloseHandle Lib "wininet" (ByVal hInet As Long) As Long

Private Declare Function InternetConnect Lib "wininet" Alias "InternetConnectA" _
                  (ByVal hInet As Long, _
                   ByVal lpszServerName As String, _
                   ByVal nServerPort As Long, _
                   ByVal lpszUserName As String, _
                   ByVal lpszPassword As String, _
                   ByVal dwService As Long, _
                   ByVal dwFlags As Long, _
                   ByVal dwContext As Long) As Long

Private Declare Function InternetOpen Lib "wininet" Alias "InternetOpenA" _
                  (ByVal lpszAgent As String, _
                   ByVal dwAccessType As Long, _
                   ByVal lpszProxyName As String, _
                   ByVal lpszProxyBypass As String, _
                   ByVal dwFlags As Long) As Long
                   
Private Declare Function GetLastError Lib "kernel32" () As Long

Dim fdata As WIN32_FIND_DATA
Property Let UserName(U)
    strUserID = U
End Property
Property Let Password(P)
    strPassword = P
End Property
Property Let HostName(H)
    strHost = H
End Property
Property Get Error()
    Error = bError
End Property
Property Let RemoteFile(R)
    strRemoteFile = R
End Property
Property Let LocalFile(L)
    strLocalFile = L
End Property
Property Let LocalDirectory(C)
    strLocalDir = C
End Property
Property Let RemoteDirectory(D)
    strRemoteDir = D
End Property
Property Let ErrorMessageBox(M)
    bErrMsgBox = M
End Property

'***************************************************************************************************************
Private Function Connect()
'***************************************************************************************************************
'Connect to correct server. (currently the 225 or 223 server)
    
    Dim RC As Long
    Dim msg As String
      
    On Error GoTo ErrorHandler
    
    'Initialize a internet connection
    hInet = InternetOpen(App.EXEName, _
                         INTERNET_OPEN_TYPE_PRECONFIG, _
                         vbNullString, _
                         vbNullString, _
                         0)
                        
    'If the internet handle was returned successfully, try to connect to the host
    'using the passed in server name, user id, and password.
    If hInet Then

        hFtp = InternetConnect(hInet, _
                               strHost, _
                               INTERNET_DEFAULT_FTP_PORT, _
                               strUserID, _
                               strPassword, _
                               INTERNET_SERVICE_FTP, _
                               INTERNET_FLAG_PASSIVE, _
                               0)

        'If the host was successfully open, then we are now logged into the server.
        'Otherwise, return a null to indicate failure.
        If hFtp Then
            Connect = True
        Else
            RC = InternetCloseHandle(hInet)
            Connect = False
        End If
    
    Else
        Connect = False
    End If

    Exit Function
    
ErrorHandler:
        
    RC = InternetCloseHandle(hInet)
    Connect = False
    
End Function
'***************************************************************************************************************
Sub GetFile()
'***************************************************************************************************************
    Dim lResult As Long
    Dim RC As Long
    Dim msg As String
       
    On Error GoTo ErrorHandler
    
    bError = False

    If Connect Then
        'Get the file from the remote server

        lResult = FtpGetFile(hFtp, _
                             strRemoteFile, _
                             strLocalFile, _
                             False, _
                             FILE_ATTRIBUTE_NORMAL, _
                             FTP_TRANSFER_TYPE_BINARY, _
                             0)

        'Check the return code and pass back the an appropriate condition.
        If lResult <> FTP_SUCCESS Then
            Err.Raise Err.LastDllError, "FtpGetFile", "FTP ERROR - Could not get " & strRemoteFile & vbCrLf & "Check to make sure that file exists and permissions are set."
        End If
        
        RC = InternetCloseHandle(hInet)
    Else
        Err.Raise Err.LastDllError, "Connect", "FTP ERROR - Could not connect to " & strHost
    End If
       
    Exit Sub
    
ErrorHandler:
        
    msg = "An error occured while getting file. " & vbCrLf _
                & "ERROR NUMBER = " & Err.Number & vbCrLf _
                & "ERROR SOURCE = " & Err.Source & vbCrLf _
                & "ERROR MESSAGE = " & Err.Description & vbCrLf
                
    If bErrMsgBox Then
        Screen.MousePointer = vbNormal
        RC = MsgBox(msg, vbOKOnly + vbCritical, "FTP ERROR " & App.Title)
    End If
    
    RC = InternetCloseHandle(hInet)
    bError = True
    
End Sub
'***************************************************************************************************************
Sub PutFile()
'***************************************************************************************************************
    Dim lResult As Long
    Dim msg As String
    Dim RC As Long
       
    On Error GoTo ErrorHandler

    bError = False
    
    If Connect Then
        'Put the file on the remote server
        lResult = FtpPutFile(hFtp, _
                             strLocalFile, _
                             strRemoteFile, _
                             FTP_TRANSFER_TYPE_BINARY, _
                             0)

        'Check the return code and pass back the an appropriate condition.
        If lResult <> FTP_SUCCESS Then
            Err.Raise Err.LastDllError, "FtpPutFile", "FTP ERROR - Could not put " & strRemoteFile
        End If

        RC = InternetCloseHandle(hInet)
    Else
        Err.Raise Err.LastDllError, "Connect", "FTP ERROR - Could not connect to " & strHost
    End If
    
    Exit Sub
    
ErrorHandler:
        
    msg = "An error occured while putting file. " & vbCrLf _
                & "ERROR NUMBER = " & Err.Number & vbCrLf _
                & "ERROR SOURCE = " & Err.Source & vbCrLf _
                & "ERROR MESSAGE = " & Err.Description & vbCrLf
                
    If bErrMsgBox Then
        Screen.MousePointer = vbNormal
        RC = MsgBox(msg, vbOKOnly + vbCritical, "FTP ERROR " & App.Title)
    End If
    
    RC = InternetCloseHandle(hInet)
    bError = True

End Sub
'***************************************************************************************************************
Sub DeleteDirectory()
'***************************************************************************************************************
    Dim lResult As Long
    Dim hfind As Long
    Dim next_rc As Long
    Dim strFindFile As String
    Dim RC As Long
    Dim msg As String
    
    On Error GoTo ErrorHandler

    bError = False
    
    If Connect Then
        strFindFile = strRemoteDir & "/" & strRemoteFile

        'find the first file that mathes remote file name
        hfind = FtpFindFirstFile(hFtp, _
                                strFindFile, _
                                fdata, _
                                0, _
                                0)

        'Check the return code and pass back the an appropriate condition.
        If hfind = FTP_ERROR Then
            Err.Raise Err.LastDllError, "FtpFindFirstFile", "FTP ERROR - Could not find " & strFindFile
        Else
            Do
                'Set remote/local file names
                strRemoteFile = strRemoteDir & "/" & Trim(fdata.cFileName)

                'Delete the remote file
                lResult = FtpDeleteFile(hFtp, strRemoteFile)
            
                If lResult <> FTP_SUCCESS Then
                    Err.Raise Err.LastDllError, "FtpDeleteFile", "FTP ERROR - Could not delete " & fdata.cFileName & " in " & strRemoteDir
                End If

                'Find the next valid file
                next_rc = InternetFindNextFile(hfind, fdata)

                If next_rc <> FTP_SUCCESS Then
                    If Not Err.LastDllError = ERROR_NO_MORE_FILES Then
                        Err.Raise Err.LastDllError, "InternetFindNextFile", "FTP ERROR - Could not find next file in " & strRemoteDir
                    Else
                        Exit Do
                    End If
                End If
            Loop

        End If
        
        RC = InternetCloseHandle(hInet)
        
    End If
        Err.Raise Err.LastDllError, "Connect", "FTP ERROR - Could not connect to " & strHost
        bError = True
    Exit Sub
    
ErrorHandler:
            
    msg = "An error occured while deleting directory. " & vbCrLf _
                & "ERROR NUMBER = " & Err.Number & vbCrLf _
                & "ERROR SOURCE = " & Err.Source & vbCrLf _
                & "ERROR MESSAGE = " & Err.Description & vbCrLf
                
    If bErrMsgBox Then
        Screen.MousePointer = vbNormal
        RC = MsgBox(msg, vbOKOnly + vbCritical, "FTP ERROR " & App.Title)
    End If
    
    RC = InternetCloseHandle(hInet)
    bError = True

End Sub
'***************************************************************************************************************
Sub GetDirectory()
'***************************************************************************************************************
    Dim lResult As Long
    Dim hfind As Long
    Dim next_rc As Long
    Dim strFindFile As String
    Dim RC As Long
    Dim msg As String
    
    On Error GoTo ErrorHandler
        
    bError = False
        
    If Connect Then
        strFindFile = strRemoteDir & "/" & strRemoteFile

        'find the first file that mathes remote file name
        hfind = FtpFindFirstFile(hFtp, _
                                strFindFile, _
                                fdata, _
                                0, _
                                0)
        
        'Check the return code and pass back the an appropriate condition.
        If hfind = FTP_ERROR Then
            Err.Raise Err.LastDllError, "FtpFindFirstFile", "FTP ERROR - Could not find " & strFindFile
        Else
            Do
                'Set remote/local file names
                strRemoteFile = strRemoteDir & "/" & Trim(fdata.cFileName)
                strLocalFile = strLocalDir & "\" & Trim(fdata.cFileName)

                'Retrive the remote file
                lResult = FtpGetFile(hFtp, _
                                 strRemoteFile, _
                                 strLocalFile, _
                                 False, _
                                 FILE_ATTRIBUTE_NORMAL, _
                                 FTP_TRANSFER_TYPE_BINARY, _
                                 0)

                If lResult <> FTP_SUCCESS Then
                    Err.Raise Err.LastDllError, "FtpGetFile", "FTP ERROR - Could not get " & fdata.cFileName & " in " & strRemoteDir
                End If

                'Find the next valid file
                next_rc = InternetFindNextFile(hfind, fdata)

                If next_rc <> FTP_SUCCESS Then
                    If Not Err.LastDllError = ERROR_NO_MORE_FILES Then
                        Err.Raise Err.LastDllError, "InternetFindNextFile", "FTP ERROR - Could not find next file in " & strRemoteDir
                    Else
                        Exit Do
                    End If
                End If
            Loop
        End If
        
        RC = InternetCloseHandle(hInet)

    Else
        Err.Raise Err.LastDllError, "Connect", "FTP ERROR - Could not connect to " & strHost
    End If

    Exit Sub
    
ErrorHandler:
    msg = "An error occured while deleting directory. " & vbCrLf _
                & "ERROR NUMBER = " & Err.Number & vbCrLf _
                & "ERROR SOURCE = " & Err.Source & vbCrLf _
                & "ERROR MESSAGE = " & Err.Description & vbCrLf
                
    If bErrMsgBox Then
        Screen.MousePointer = vbNormal
        RC = MsgBox(msg, vbOKOnly + vbCritical, "FTP ERROR " & App.Title)
    End If
    
    RC = InternetCloseHandle(hInet)
    bError = True
End Sub


