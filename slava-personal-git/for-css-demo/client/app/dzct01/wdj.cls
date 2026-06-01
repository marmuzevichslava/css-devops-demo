VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "wdj"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private strCommand As String
Private bError As Boolean

'**********************************************************************
'WDJ Specific Declarations.
'**********************************************************************
Private Type SECURITY_ATTRIBUTES
        nLength As Long
        lpSecurityDescriptor As Long
        bInheritHandle As Long
End Type

Private Type STARTUpi
        cb As Long
        lpReserved As String
        lpDesktop As String
        lpTitle As String
        dwX As Long
        dwY As Long
        dwXSize As Long
        dwYSize As Long
        dwXCountChars As Long
        dwYCountChars As Long
        dwFillAttribute As Long
        dwFlags As Long
        wShowWindow As Integer
        cbReserved2 As Integer
        lpReserved2 As Byte
        hStdInput As Long
        hStdOutput As Long
        hStdError As Long
End Type

Private Type PROCESS_INFORMATION
        hProcess As Long
        hThread As Long
        dwProcessId As Long
        dwThreadId As Long
End Type

'**********************************************************************
'Constants
'**********************************************************************
Private Const INFINITE = &HFFFF
Private Const SW_SHOWMINNOACTIVE = 7
Private Const NORMAL_PRIORITY_CLASS = &H20
Private Const STARTF_USESHOWWINDOW = &H1

'**********************************************************************
' API Declarations
'**********************************************************************
Private Declare Function CreateProcess Lib "kernel32" Alias "CreateProcessA" _
               (ByVal lpApplicationName As String, _
                ByVal lpCommandLine As String, _
                lpProcessAttributes As SECURITY_ATTRIBUTES, _
                lpThreadAttributes As SECURITY_ATTRIBUTES, _
                ByVal bInheritHandles As Long, _
                ByVal dwCreationFlags As Long, _
                lpEnvironment As Any, _
                ByVal lpCurrentDriectory As String, _
                lpStartupi As STARTUpi, _
                lpProcessirmation As PROCESS_INFORMATION) As Long
                
Private Declare Function WaitForSingleObject Lib "kernel32" _
                (ByVal hHandle As Long, _
                 ByVal dwMilliseconds As Long) As Long
                 
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Declare Function GetLastError& Lib "kernel32" ()
Property Let Command(C)
    strCommand = C
End Property
Property Get Error()
    Error = bError
End Property
'**********************************************************************
Sub Execute()
'**********************************************************************
    Dim si As STARTUpi
    Dim pi As PROCESS_INFORMATION
    Dim sa As SECURITY_ATTRIBUTES
    Dim RC&
    
    sa.nLength = Len(sa)
    sa.bInheritHandle = True
    si.cb = Len(si)
    si.lpReserved = vbNullString
    si.lpDesktop = vbNullString
    si.lpTitle = vbNullString
    si.dwFlags = STARTF_USESHOWWINDOW
    si.wShowWindow = SW_SHOWMINNOACTIVE
    
    RC = CreateProcess(vbNullString, _
                        strCommand, _
                        sa, _
                        sa, _
                        True, _
                        NORMAL_PRIORITY_CLASS, _
                        ByVal 0&, _
                        vbNullString, _
                        si, _
                        pi)
                        
    If (RC) Then
        RC = WaitForSingleObject(pi.hProcess, INFINITE)
        RC = CloseHandle(pi.hProcess)
        RC = CloseHandle(pi.hThread)
        bError = False
    Else
        RC = GetLastError()
        bError = True
    End If

End Sub
