VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "PathtoCodes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Private Type SECURITY_ATTRIBUTES
    nLength As Long
    lpSecurityDescriptor As Long
    bInheritHandle As Integer
End Type

Private Type FILETIME
    dwLowDateTime As Long
    dwHightDateTime As Long
End Type

Private Type VALENTA
    ve_valuename As Long
    ve_valuelen As Long
    ve_valueprtr As Long
    ve_type As Long
End Type

Private Declare Function glr_apiRegCloseKey _
    Lib "ADVAPI32" Alias "RegCloseKey" _
    (ByVal hKey As Long) As Long
    
Private Declare Function glr_apiRegConnectRegistry _
    Lib "ADVAPI32" Alias "RegConnectRegistryA" _
    (ByVal lpszComputerName As String, ByVal hKey As Long, _
    ByRef phkResult As Long) As Long
    
Private Declare Function glr_apiRegCreateKey _
    Lib "ADVAPI32" Alias "RegCreateKeyA" _
    (ByVal hKey As Long, ByVal lpszSubKey As String, _
    ByRef phkResult As Long) As Long
    
Private Declare Function glr_apiRegCreateKeyEx _
    Lib "ADVAPI32" Alias "RegCreateKeyExA" _
    (ByVal hKey As Long, ByVal lpszSubKey As String, _
    ByVal dwReserved As Long, ByVal lpszClass As String, _
    ByVal fdwOptions As Long, ByVal samDesired As Long, _
    ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES, _
    ByRef phkResult As Long, _
    ByRef lpdwDisposition As Long) As Long
    
Private Declare Function glr_apiRegDeleteKey _
    Lib "ADVAPI32" Alias "RegKeyDeleteA" _
    (ByVal hKey As Long, ByVal lpszSubKey As String) As Long
    
Private Declare Function glr_apiRegDeleteValue _
    Lib "ADVAPI32" Alias "RegDeleteValueA" _
    (ByVal hKey As Long, ByVal lpszValue As String) As Long
    
Private Declare Function glr_apiRegEnumKey _
    Lib "ADVAPI32" Alias "RegEnumKeyA" _
    (ByVal hKey As Long, ByVal iSubkey As Long, _
    ByVal lpszName As String, ByVal cchName As Long) As Long
    
Private Declare Function glr_apiRegEnumKeyEx _
    Lib "ADVAPI32" Alias "RegEnumKeyExA" _
    (ByVal hKey As Long, ByVal iSubkey As Long, _
    ByVal lpszName As String, ByRef lpcchName As Long, _
    ByVal lpdwReserved As Long, ByVal lpszClass As String, _
    ByRef lpcchClass As Long, _
    ByRef lpftLastWrite As FILETIME) As Long
    
Private Declare Function glr_apiRegEnumValue _
    Lib "ADVAPI32" Alias "RegEnumValueA" _
    (ByVal hKey As Long, ByVal iValue As Long, _
    ByVal lpszValue As String, ByRef lpcchValue As Long, _
    ByVal lpdwReserved As Long, ByRef lpdwType As Long, _
    lpbData As Any, ByRef lpcbData As Long) As Long
    
Private Declare Function glr_apiRegFlushKey _
    Lib "ADVAPI32" Alias "RegFlushKey" _
    (ByVal hKey As Long) As Long
    
Private Declare Function glr_apiRegGetKeySecurity _
    Lib "ADVAPI32" Alias "RegGetKeySecurity" _
    (ByVal hKey As Long, ByVal SecInf As Long, _
    ByRef pSecDesc() As Byte, ByRef lpcbSecDesc As Long) _
    As Long
    
Private Declare Function glr_apiRegLoadKey _
    Lib "ADVAPI32" Alias "RegLoadKeyA" _
    (ByVal hKey As Long, ByVal lpszSubKey As String, _
    ByVal lpszFile As String) As Long
    
Private Declare Function glr_apiRegNotifyChangeKeyValue _
    Lib "ADVAPI32" Alias "RegNotifyChangeKeyValue" _
    (ByVal hKey As Long, ByVal fWatchSubTree As Integer, _
    ByVal fdwNotifyFilter As Long, ByVal hEvent As Long, _
    ByVal fAsync As Integer) As Long
    
Private Declare Function glr_apiRegOpenKeyEx _
    Lib "ADVAPI32" Alias "RegOpenKeyExA" _
    (ByVal hKey As Long, ByVal lpszSubKey As String, _
    ByVal dwReserved As Long, ByVal samDesired As Long, _
    ByRef hKey As Long) As Long
    
Private Declare Function glr_apiRegQueryInfoKey _
    Lib "ADVAPI32" Alias "RegQueryInfoKeyA" _
    (ByVal hKey As Long, ByVal lpszClass As String, _
    ByRef lpcchClass As Long, ByVal lpdwReserved As Long, _
    ByRef lpcSubKeys As Long, ByRef lpcchMaxSubkey As Long, _
    ByRef lpcchMaxClass As Long, ByRef lpcValeus As Long, _
    ByRef lpcchMaxValueName As Long, _
    ByRef lpcbMaxValueData As Long, _
    ByRef lpcbSecurityDescriptor As Long, _
    ByRef lpftLastWriteTime As FILETIME) As Long
    
Private Declare Function glr_apiRegQueryMultipleValues _
    Lib "ADVAPI32" Alias "RegQueryMultipleValuesA" _
    (ByVal hKey As Long, ByRef val_list As VALENTA, _
    ByVal num_vals As Long, ByRef lpValueBuf() As Byte, _
    ByRef ldwTotsize As Long) As Long
    
Private Declare Function glr_apiRegQueryValue _
    Lib "ADVAPI32" Alias "RegQueryValueA" _
    (ByVal hKey As Long, ByVal lpszSubKey As String, _
    ByVal lpszValue As String, ByRef pcbValue As Long) As Long
    
Private Declare Function glr_apiRegQueryValueEx _
    Lib "ADVAPI32" Alias "RegQueryValueExA" _
    (ByVal hKey As Long, ByVal lpszValueName As String, _
    ByVal lpdwReserved As Long, ByRef lpdwType As Long, _
    lpbData As Any, ByRef lpcbData As Long) As Long
    
Private Declare Function glr_apiRegReplaceKey _
    Lib "ADVAPI32" Alias "RegReplaceKeyA" _
    (ByVal hKey As Long, ByVal lpSubKey As String, _
    ByVal lpNewFile As String, ByVal lpOldFile As String) As Long
    
Private Declare Function glr_apiRegRestoreKey _
    Lib "ADVAPI32" Alias "RegRestoreKeyA" _
    (ByVal hKey As Long, ByVal lpszFile As String, _
    ByVal fdw As Long) As Long
    
Private Declare Function glr_apiRegSaveKey _
    Lib "ADVAPI32" Alias "RegSaveKeyA" _
    (ByVal hKey As Long, ByVal lpszFile As String, _
    ByRef lpsa As SECURITY_ATTRIBUTES) As Long
    
Private Declare Function glr_apiRegSetKeySecurity _
    Lib "ADVAPI32" Alias "RegSetKeySecurity" _
    (ByVal hKey As Long, ByVal si As Long, _
    ByRef psd() As Byte) As Long
    
Private Declare Function glr_apiRegSetValue _
    Lib "ADVAPI32" Alias "RegSetValueA" _
    (ByVal hKey As Long, ByVal lpSubKey As String, _
    ByVal dwType As Long, ByVal lpData As String, _
    ByVal cbData As Long) As Long
    
Private Declare Function glr_apiRegSetValueEx _
    Lib "ADVAPI32" Alias "RegSetValueExA" _
    (ByVal hKey As Long, ByVal lpValueName As String, _
    ByVal Reserved As Long, ByVal dwType As Long, _
    lpData As Any, ByVal cbData As Long) As Long
    
Private Declare Function glr_apiregUnloadKey _
    Lib "ADVAPI32" Alias "RegUnloadKeyA" _
    (ByVal hKey As Long, ByVal lpszSubKey As String) As Long

Const Delete = &H10000
Const READ_CONTROL = &H20000
Const WRITE_DAC = &H40000
Const WRITE_OWNER = &H80000
Const Synchronize = &H100000

Const STANDARD_RIGHTS_READ = READ_CONTROL
Const STANDARD_RIGHTS_WRITE = READ_CONTROL
Const STANDARD_RIGHTS_EXECUTE = READ_CONTROL
Const STANDARD_RIGHTS_ALL = &H1F0000
Const SPECIFIC_RIGHTS_ALL = &HFFFF&

Const APPLICATION_ERROR_MASK = &H20000000
Const ERROR_SEVERITY_SUCCESS = &H0&
Const ERROR_SEVERITY_INFORMATIONAL = &H40000000
Const ERROR_SEVERITY_WARNING = &H80000000
Const ERROR_SEVERITY_ERROR = &HC0000000

Const HKEY_CLASSES_ROOT = &H80000000
Const HKEY_CURRENT_USER = &H80000001
Const HKEY_LOCAL_MACHINE = &H80000002
Const HKEY_USERS = &H80000003
Const HKEY_PERFORMANCE_DATA = &H80000004
Const HKEY_CURRENT_CONFIG = &H80000005
Const HKEY_DYN_DATA = &H80000006

Const KEY_QUERY_VALUE = &H1&
Const KEY_SET_VALUE = &H2&
Const KEY_CREATE_SUB_KEY = &H4&
Const KEY_ENUMERATE_SUB_KEYS = &H8&
Const KEY_NOTIFY = &H10&
Const KEY_CREATE_LINK = &H20&
Const KEY_READ = STANDARD_RIGHTS_READ Or KEY_QUERY_VALUE Or KEY_ENUMERATE_SUB_KEYS Or KEY_NOTIFY And Not Synchronize
Const KEY_WRITE = STANDARD_RIGHTS_WRITE Or KEY_SET_VALUE Or KEY_CREATE_SUB_KEY And Not Synchronize
Const KEY_EXECUTE = KEY_READ And Not Synchronize
Const KEY_ALL_ACCESS = STANDARD_RIGHTS_ALL Or KEY_QUERY_VALUE Or KEY_SET_VALUE Or KEY_CREATE_SUB_KEY Or KEY_ENUMERATE_SUB_KEYS Or KEY_NOTIFY Or KEY_CREATE_LINK And Not Synchronize

Const REG_NONE = 0
Const REG_SZ = 1
Const REG_EXPAND_SZ = 2
Const REG_BINARY = 3
Const REG_DWORD = 4
Const REG_DWORD_LITTLE_ENDIAN = 4
Const REG_DWORD_BIG_ENDIAN = 5
Const REG_LINK = 6
Const REG_MULTI_SZ = 7
Const REG_RESOURCE_LIST = 8
Const REG_FULL_RESOURCE_DESCRIPTOR = 9
Const REG_RESOURCE_REQUIREMENTS_LIST = 10

Private Function glrGetKeyAndValueFromPath _
    (ByVal strPath As String, ByRef hKey As Long, _
    ByRef strValue As String) As Variant
    ' Breaks up the path into a hKey and a strValue
    '
    ' In:
    '   strPath     A Registry path
    '
    ' Out:
    '   hKey        A handle to a key representing the key
    '               portion of the path
    '   strValue    A string representing the value portion of
    '               the path
    '
    ' Warning:
    '   The hKey must be closed with glr_apiRegClose(hKey) after
    '   the call if the function is successful

    Dim lngBegin As Long
    Dim lngEnd As Long
    Dim hKeyNew As Long
    Dim i As Long
    Dim lngRet As Long

    For i = Len(strPath) To 1 Step -1
        If Mid$(strPath, i, 1) = "\" Then
            strValue = Mid$(strPath, i + 1)
            strPath = Left$(strPath, i)
            Exit For
        End If
    Next i

    lngBegin = 2
    lngEnd = InStr(lngBegin, strPath, "\")
    Select Case Mid$(strPath, lngBegin, lngEnd - lngBegin)
    Case "HKEY_CLASSES_ROOT"
        hKey = HKEY_CLASSES_ROOT
    Case "HKEY_CURRENT_USER"
        hKey = HKEY_CURRENT_USER
    Case "HKEY_LOCAL_MACHINE"
        hKey = HKEY_LOCAL_MACHINE
    Case "HKEY_USERS"
        hKey = HKEY_USERS
    Case "HKEY_CURRENT_CONFIG"
        hKey = HKEY_CURRENT_CONFIG
    Case "HKEY_DYN_DATA"
        hKey = HKEY_DYN_DATA
    Case Else
        glrGetKeyAndValueFromPath = CVErr(0)
        GoTo glrGetKeyAndValueFromPathDone
    End Select

    lngBegin = lngEnd + 1
    lngEnd = InStr(lngBegin, strPath, "\")
    Do Until lngEnd = 0
        lngRet = glr_apiRegOpenKeyEx(hKey, Mid$(strPath, _
            lngBegin, lngEnd - lngBegin), 0&, KEY_READ, hKeyNew)
        Select Case lngRet And APPLICATION_ERROR_MASK
        Case ERROR_SEVERITY_SUCCESS
            Call glr_apiRegCloseKey(hKey)
            hKey = hKeyNew
        Case Else
            Stop
        End Select
        lngBegin = lngEnd + 1
        lngEnd = InStr(lngBegin, strPath, "\")
    Loop
glrGetKeyAndValueFromPathDone:

End Function

Public Function glrGetRegistryKeys(ByVal hKey As Long) As String
    ' Returns a semi-colon separated list of all of
    ' the sub-keys of this key
    '
    ' From Microsoft Access 95 Developer's Handbook
    ' by Litwin, Getz, Gilbert, and Reddick. (Sybex)
    ' Copyright 1995. All Rights Reserved.
    '
    ' In:
    '   A Registry Handle to a key
    '
    ' Out:
    '   A semi-colon separated list of all the sub-keys
    '
    ' Example:
    '   varRet = glrGetRegistryKeys(hKey)

    Dim strRet As String
    Dim lngRet As Long
    Dim strClassName As String
    Dim cchClassName As Long
    Dim lngCSubKeys As Long
    Dim cchMaxSubKey As Long
    Dim cchMaxClass As Long
    Dim lngCValues As Long
    Dim cchMaxValueName As Long
    Dim cbMaxValueData As Long
    Dim cbSecurityDescriptor As Long
    Dim ftLastWrite As FILETIME
    Dim i As Long
    Dim strKey As String
    Dim cchKey As Long
    Dim strClass As String
    Dim cchClass As Long
    Dim retCode As Long

    strRet = ""
    strClassName = Space$(256)
    cchClassName = Len(strClassName)
    Call glr_apiRegQueryInfoKey(hKey, strClassName, _
        cchClassName, 0&, lngCSubKeys, cchMaxSubKey, _
        cchMaxClass, lngCValues, cchMaxValueName, _
        cbMaxValueData, cbSecurityDescriptor, ftLastWrite)
    For i = 0 To lngCSubKeys - 1
        strKey = Space$(cchMaxSubKey)
        cchKey = Len(strKey) + 1
        strClass = Space$(cchMaxClass)
        cchClass = Len(strClass) + 1
        retCode = glr_apiRegEnumKeyEx(hKey, i, strKey, _
            cchKey, 0&, strClass, cchClass, ftLastWrite)
        Select Case retCode And APPLICATION_ERROR_MASK
        Case ERROR_SEVERITY_SUCCESS
        Case Else
            Stop
            Exit For
        End Select
        strKey = Left$(strKey, cchKey)
        strRet = strRet & strKey & ";"
    Next i

    glrGetRegistryKeys = strRet
End Function
Public Function glrGetRegistryValue(ByVal hKey As Long, ByVal strValue As String) As Variant
    ' Returns a registry value based on an hKey
    ' and a strValue
    '
    ' From Microsoft Access 95 Developer's Handbook
    ' by Litwin, Getz, Gilbert, and Reddick. (Sybex)
    ' Copyright 1995. All Rights Reserved.
    '
    ' In:
    '   hKey        A Registry Handle to a key
    '   strValue    A registry Value
    '
    ' Out:
    '   The contents of the value
    '
    ' Example:
    '   varRet = glrGetRegistryValue(hKey, strValue)

    Dim retCode As Long
    Dim lngType As Long
    Dim cbData As Long
    Dim strGetValue As String
    Dim lngValue As Long

    glrGetRegistryValue = "<Binary Data>"

    retCode = glr_apiRegQueryValueEx(hKey, strValue, 0&, _
        lngType, ByVal 0&, cbData)
    Select Case retCode And APPLICATION_ERROR_MASK
    Case ERROR_SEVERITY_SUCCESS
        Select Case lngType
        Case REG_NONE
            glrGetRegistryValue = CVErr(0)
        Case REG_SZ, REG_EXPAND_SZ
            strGetValue = Space$(cbData)
            retCode = glr_apiRegQueryValueEx(hKey, strValue, _
                0&, lngType, ByVal strGetValue, cbData)
            glrGetRegistryValue = strGetValue
        Case REG_BINARY
        Case REG_DWORD, REG_DWORD_LITTLE_ENDIAN
            retCode = glr_apiRegQueryValueEx(hKey, strValue, _
                0&, lngType, lngValue, cbData)
            glrGetRegistryValue = lngValue
        Case REG_DWORD_BIG_ENDIAN
        Case REG_LINK
        Case REG_MULTI_SZ
        Case REG_RESOURCE_LIST
        Case REG_FULL_RESOURCE_DESCRIPTOR
        Case REG_RESOURCE_REQUIREMENTS_LIST
        Case Else
            Stop
        End Select
    Case Else
        Stop
    End Select
End Function
Public Function glrGetRegistryValueFromPath(strPath As String) As Variant
    ' Returns the value from a registry path
    '
    ' From Microsoft Access 95 Developer's Handbook
    ' by Litwin, Getz, Gilbert, and Reddick. (Sybex)
    ' Copyright 1995. All Rights Reserved.
    '
    ' In:
    '   strPath     A registry path
    '
    ' Out:
    '   The contents of the value specified
    '
    ' Example:
    '   ? glrGetRegistryValueFromPath ("\HKEY_CURRENT_USER\Control Panel\Desktop\ScreenSaveActive")

    Dim hKey As Long
    Dim strValue As String
    
    If Not IsError _
        (glrGetKeyAndValueFromPath(strPath, hKey, strValue)) Then
        glrGetRegistryValueFromPath = _
            glrGetRegistryValue(hKey, strValue)
        Call glr_apiRegCloseKey(hKey)
    End If
End Function
Public Function glrGetRegistryValues(ByVal hKey As Long) _
    As String
    ' Returns a semi-colon separated list of all of
    ' the values of this key
    '
    ' From Microsoft Access 95 Developer's Handbook
    ' by Litwin, Getz, Gilbert, and Reddick. (Sybex)
    ' Copyright 1995. All Rights Reserved.
    '
    ' In:
    '   A Registry Handle to a key
    '
    ' Out:
    '   A semi-colon separated list of all the values
    '
    ' Example:
    '   varRet = glrGetRegistryValues(hKey)

    Dim strRet As String
    Dim lngRet As Long
    Dim strClassName As String
    Dim cchClassName As Long
    Dim lngCSubKeys As Long
    Dim cchMaxSubKey As Long
    Dim cchMaxClass As Long
    Dim lngCValues As Long
    Dim cchMaxValueName As Long
    Dim cbMaxValueData As Long
    Dim cbSecurityDescriptor As Long
    Dim ftLastWrite As FILETIME
    Dim i As Long
    Dim strValue As String
    Dim cchValue As Long
    Dim retCode As Long
    Dim lngType As Long
    Dim cchLen As Long

    strRet = ""
    strClassName = Space$(256)
    cchClassName = Len(strClassName)
    retCode = glr_apiRegQueryInfoKey(hKey, strClassName, _
        cchClassName, 0&, lngCSubKeys, cchMaxSubKey, _
        cchMaxClass, lngCValues, cchMaxValueName, _
        cbMaxValueData, cbSecurityDescriptor, ftLastWrite)
    Select Case retCode And APPLICATION_ERROR_MASK
    Case ERROR_SEVERITY_SUCCESS
        For i = 0 To lngCValues - 1
            strValue = Space$(cchMaxValueName)
            cchValue = Len(strValue) + 1
            retCode = glr_apiRegEnumValue(hKey, i, strValue, _
                cchValue, ByVal 0&, lngType, ByVal 0&, cchLen)
            Select Case retCode And APPLICATION_ERROR_MASK
            Case ERROR_SEVERITY_SUCCESS
            Case Else
                Stop
                Exit For
            End Select
            strValue = Left$(strValue, cchValue)
            strRet = strRet & strValue & ";"
        Next i
    Case Else
        Stop
    End Select

    glrGetRegistryValues = strRet
End Function
Public Function glrSetRegistryValueFromPath _
    (ByVal strPath As String, ByVal varValue As Variant) _
    As Variant
    ' Sets a value based on a registry path
    '
    ' From Microsoft Access 95 Developer's Handbook
    ' by Litwin, Getz, Gilbert, and Reddick. (Sybex)
    ' Copyright 1995. All Rights Reserved.
    '
    ' In:
    '   strPath     A registry path
    '   varValue    The value to be set
    '               The VarType of the variant determines
    '               What data type in the registry is
    '               used
    '
    ' Out:
    '   If there is an error then IsError on the return
    '   value will return True. Otherwise the return
    '   value has no meaning.
    '
    ' Example:
    '   ? glrSetRegistryValueFromPath("\HKEY_CURRENT_USER\Control Panel\Desktop\ScreenSaveActive", "1")

    Dim hKey As Long
    Dim strValue As String
    Dim retCode As Long

    If Not IsError _
        (glrGetKeyAndValueFromPath(strPath, hKey, strValue)) Then
        Select Case VarType(varValue)
        Case vbEmpty
            Stop
        Case vbNull
            Stop
        Case vbInteger
            Stop
        Case vbLong
            retCode = glr_apiRegSetValueEx(hKey, strValue, _
                0&, REG_DWORD, CLng(varValue), 4)
            Select Case retCode And APPLICATION_ERROR_MASK
            Case ERROR_SEVERITY_SUCCESS
            Case Else
                glrSetRegistryValueFromPath = CVErr(0)
            End Select
        Case vbSingle
            Stop
        Case vbDouble
            Stop
        Case vbCurrency
            Stop
        Case vbDate
            Stop
        Case vbString
            retCode = glr_apiRegSetValueEx(hKey, strValue, _
                0&, REG_SZ, ByVal CStr(varValue), Len(varValue))
            Select Case retCode And APPLICATION_ERROR_MASK
            Case ERROR_SEVERITY_SUCCESS
            Case Else
                glrSetRegistryValueFromPath = CVErr(0)
            End Select
        Case vbObject
            Stop
        Case vbError
            Stop
        Case vbBoolean
            Stop
        Case vbVariant
            Stop
        Case vbDataObject
            Stop
        Case vbByte
            Stop
        Case vbArray
            Stop
        Case Else
            Stop
        End Select
        Call glr_apiRegCloseKey(hKey)
    End If
End Function


