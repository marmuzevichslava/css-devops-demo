Attribute VB_Name = "modMsgBox"
Declare Function MessageBox Lib "user32" Alias "MessageBoxA" (ByVal hwnd As Long, _
                                                              ByVal lpText As String, _
                                                              ByVal lpCaption As String, _
                                                              ByVal wType As Long) As Long

'Message box attributes.
Public Const MB_ABORTRETRYIGNORE = &H2&
Public Const MB_APPLMODAL = &H0&
Public Const MB_COMPOSITE = &H2
Public Const MB_DEFAULT_DESKTOP_ONLY = &H20000
Public Const MB_DEFBUTTON1 = &H0&
Public Const MB_DEFBUTTON2 = &H100&
Public Const MB_DEFBUTTON3 = &H200&
Public Const MB_DEFMASK = &HF00&
Public Const MB_ICONASTERISK = &H40&
Public Const MB_ICONEXCLAMATION = &H30&
Public Const MB_ICONHAND = &H10&
Public Const MB_ICONINFORMATION = MB_ICONASTERISK
Public Const MB_ICONMASK = &HF0&
Public Const MB_ICONQUESTION = &H20&
Public Const MB_ICONSTOP = MB_ICONHAND
Public Const MB_MISCMASK = &HC000&
Public Const MB_MODEMASK = &H3000&
Public Const MB_NOFOCUS = &H8000&
Public Const MB_OK = &H0&
Public Const MB_OKCANCEL = &H1&
Public Const MB_PRECOMPOSED = &H1
Public Const MB_RETRYCANCEL = &H5&
Public Const MB_SETFOREGROUND = &H10000
Public Const MB_SYSTEMMODAL = &H1000&
Public Const MB_TASKMODAL = &H2000&
Public Const MB_TYPEMASK = &HF&
Public Const MB_USEGLYPHCHARS = &H4
Public Const MB_YESNO = &H4&
Public Const MB_YESNOCANCEL = &H3&

'Message box return codes.
Public Const IDNO = 7
Public Const IDOK = 1
Public Const IDRETRY = 4
Public Const IDYES = 6
Public Const IDIGNORE = 5
Public Const IDCANCEL = 2
Public Const IDABORT = 3

