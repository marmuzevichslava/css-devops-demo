VERSION 5.00
Begin VB.Form frmRecord 
   Caption         =   "Request Record Template"
   ClientHeight    =   3735
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   6840
   LinkTopic       =   "Form7"
   ScaleHeight     =   3735
   ScaleWidth      =   6840
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtAlias 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   240
      MaxLength       =   50
      TabIndex        =   7
      Top             =   3240
      Width           =   2775
   End
   Begin VB.TextBox txtCName 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   3840
      MaxLength       =   18
      TabIndex        =   6
      Top             =   2520
      Width           =   2775
   End
   Begin VB.TextBox txtCOBOLNm 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   240
      MaxLength       =   18
      TabIndex        =   5
      Top             =   2520
      Width           =   2895
   End
   Begin VB.ComboBox cboOriging 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   1920
      TabIndex        =   0
      Top             =   4560
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.ComboBox cboDestination 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   5040
      TabIndex        =   2
      Top             =   4560
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.TextBox txtSirNo 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   3720
      MaxLength       =   5
      TabIndex        =   1
      Top             =   4560
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.TextBox txtShortDesc 
      BackColor       =   &H0000FFFF&
      Height          =   375
      Left            =   240
      MaxLength       =   25
      TabIndex        =   4
      Top             =   1680
      Width           =   3735
   End
   Begin VB.TextBox txtLongDesc 
      BackColor       =   &H0000FFFF&
      Height          =   735
      Left            =   240
      MaxLength       =   300
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   480
      Width           =   6375
   End
   Begin VB.Label Label2 
      Caption         =   "5. Alias of Record:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   15
      Top             =   3000
      Width           =   1695
   End
   Begin VB.Line Line1 
      Visible         =   0   'False
      X1              =   -120
      X2              =   6720
      Y1              =   5040
      Y2              =   5040
   End
   Begin VB.Label lblSIRNo 
      Caption         =   "Add to SIR Number:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   14
      Top             =   4560
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblDash1 
      Caption         =   "--"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   135
      Left            =   3480
      TabIndex        =   13
      Top             =   4560
      Visible         =   0   'False
      Width           =   135
   End
   Begin VB.Label lblDash2 
      Caption         =   "--"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   135
      Left            =   4800
      TabIndex        =   12
      Top             =   4560
      Visible         =   0   'False
      Width           =   135
   End
   Begin VB.Label Label1 
      Caption         =   "4. C Name:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   3840
      TabIndex        =   11
      Top             =   2280
      Width           =   975
   End
   Begin VB.Label lblUser 
      Caption         =   "3. COBOL Name:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   10
      Top             =   2280
      Width           =   1575
   End
   Begin VB.Label Label7 
      Caption         =   "2. Short Description (Foundation Name and Number):"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   9
      Top             =   1440
      Width           =   4575
   End
   Begin VB.Label Label5 
      Caption         =   "1. Long Description:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   8
      Top             =   240
      Width           =   1815
   End
   Begin VB.Menu mnuRequestRecGrp 
      Caption         =   "&Request Record"
      Begin VB.Menu mnuAddRequestRecGrp 
         Caption         =   "&Add Request Record "
      End
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuInstructions 
         Caption         =   "&Instructions"
      End
   End
End
Attribute VB_Name = "frmRecord"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'****************************************************************************
' Name: cboDestination_Change
' Purpose: Changes the background color of the field yellow if the field is
'           blank and red if the user tries to enter in a value instead of
'           slecting it from the combo box list
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboDestination_Change()
''''''''''''' Christina Mitchell TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboDestination_Change
'
'    If cboDestination.Text = "" Then
'        cboDestination.BackColor = &HFFFF& 'Sets the color of the field to yellow.
'
'    Else
'        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Record Template"
'
'        'set global string compare item
'        gblsComp = cboDestination.Text
'        cboDestination.BackColor = &HFF&
'        cboDestination.Refresh
'
'    End If
'
'Exit_cboDestination_Change:
'    Exit Sub
'Err_cboDestination_Change:
'    MsgBox Error$
'    Resume Exit_cboDestination_Change
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub

'****************************************************************************
' Name: cboDestination_Click
' Purpose: Changes the background color of the field to white when the user
'           clicks on the combo box.  The x part of the SIR is created.
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboDestination_Click()
''''''''''''' Christina Mitchell TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboDestination_Click
'
'    Dim strTemp As String
'
'    'set background color
'    With cboDestination
'            .BackColor = &HFFFFFF
'    End With
'
'    strTemp = cboDestination.Text
'    strTemp = Mid(strTemp, 2, 2)
'
'    'create z part of SIR text file
'    zSir = strTemp
'
'    'update global string compare item
'    gblsComp = ""
'
'Exit_cboDestination_Click:
'    Exit Sub
'Err_cboDestination_Click:
'    MsgBox Error$
'    Resume Exit_cboDestination_Click
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub
'****************************************************************************
' Name: cboDestination_LostFocus
' Purpose: Changes the background color of the field to red and will not let
'           the user continue on unless a value has been selected from the
'           list
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboDestination_LostFocus()
''''''''''''' Christina Mitchell TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboDestination_LostFocus
'
'
'    If cboDestination.Text = "" Then
'        cboDestination.BackColor = &HFFFF&   'sets the field background to yellow
'    Else
'
'        If gblsComp = cboDestination.Text Then
'            MsgBox "Please choose a value from the list.", vbOKOnly, "Request Record Template"
'            cboDestination.BackColor = &HFF&
'            cboDestination.SetFocus
'            cboDestination.Refresh
'        End If
'
'    End If
'
'Exit_cboDestination_LostFocus:
'    Exit Sub
'Err_cboDestination_LostFocus:
'    MsgBox Error$
'    Resume Exit_cboDestination_LostFocus
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub
'****************************************************************************
' Name: cboOriging_Change
' Purpose: Changes the background color of the field yellow if the field is
'           blank and red if the user tries to enter in a value instead of
'           slecting it from the combo box list
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboOriging_Change()
''''''''''''' Christina Mitchell TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboOriging_Change
'
'    If cboOriging.Text = "" Then
'        cboOriging.BackColor = &HFFFF&
'
'    Else
'        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Record Template"
'        gblsComp = cboOriging.Text
'        cboOriging.BackColor = &HFF&
'        cboOriging.SetFocus
'        cboOriging.Refresh
'    End If
'
'Exit_cboOriging_Change:
'    Exit Sub
'Err_cboOriging_Change:
'    MsgBox Error$
'    Resume Exit_cboOriging_Change
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub

'****************************************************************************
' Name: cboOriging_Click
' Purpose: Changes the background color of the field to white when the user
'           clicks on the combo box.  The x part of the SIR is created.
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboOriging_Click()
''''''''''''' Christina Mitchell TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboOriging_Click
'    Dim strTemp As String
'
'    'set background color upon click event
'    With cboOriging
'        .BackColor = &HFFFFFF
'    End With
'
'    strTemp = cboOriging.Text
'    strTemp = Left(strTemp, 3)
'
'    'create x part of SIR text file name
'    xSir = strTemp
'
'    'update global string compare item
'    gblsComp = ""
'
'
'Exit_cboOriging_Click:
'    Exit Sub
'Err_cboOriging_Click:
'    MsgBox Error$
'    Resume Exit_cboOriging_Click
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub

'****************************************************************************
' Name: cboOriging_LostFocus
' Purpose: Changes the background color of the field to red and will not let
'           the user continue on unless a value has been selected from the
'           list
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboOriging_LostFocus()
''''''''''''' Christina Mitchell TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboOriging_LostFocus
'
'    If cboOriging.Text = "" Then
'        cboOriging.BackColor = &HFFFF&      'sets the background to yellow
'
'    Else
'        If gblsComp = cboOriging.Text Then
'            MsgBox "Please choose a value from the list.", vbOKOnly, "Request Record Template"
'            cboOriging.BackColor = &HFF&    'sets the background to red
'            cboOriging.SetFocus
'            cboOriging.Refresh
'        End If
'
'    End If
'
'Exit_cboOriging_LostFocus:
'    Exit Sub
'
'Err_cboOriging_LostFocus:
'    MsgBox Error$
'    Resume Exit_cboOriging_LostFocus
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub

'****************************************************************************
' Name: Form_Load
' Purpose: Sets required and added variables and calls the program to load
'           the data
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub Form_Load()
On Error GoTo Err_Form_Load

    'Set variables
    bRequired = False
    bAdded = False
    
    'Load required data
''    Call DataLoad
    
Exit_Form_Load:
    Exit Sub

Err_Form_Load:
    MsgBox Error$
    Resume Exit_Form_Load
    
End Sub

'****************************************************************************
' Name: mnuAddRequestRecGrp_Click
' Purpose: Checks that all required fields have been entered then calls the
'           sub to write the sir info
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub mnuAddRequestRecGrp_Click()
On Error GoTo Err_mnuAddRequestRecGrp_Click

    Dim strTemp As String, strFileNotFndMsg As String, strMsgTitle As String
    Dim intI As Integer
    Dim strTempFile As String, strTempPath As String
    Dim intFive As Integer, intZero As Integer, intOne As Integer
    
    strTempPath = "C:\Data\Template.tmp"
    strTempFile = "TEMPLATE.TMP"
    strFileNotFndMsg = "Unable to locate SIR text file."
    strMsgTitle = "Request Record Template"
    intFive = 5
    intZero = 0
    intOne = 1

'''''''''''''''''''''Christina Mitchell TOSIRWB '''''''''''''''''''''''''''
'    strTemp = txtSirNo.Text
'
'    If Len(txtSirNo.Text) <= intFive And Len(txtSirNo.Text) > intZero And IsNumeric(strTemp) Then
'
'        For intI = Len(strTemp) + intOne To intFive
'            strTemp = intZero & strTemp
'        Next intI
'
'        'display 5 digit number
'        txtSirNo.Text = strTemp
'
'        'assign the YYYYY portion of the SIR number
'        ySir = txtSirNo.Text
'
'    End If
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
     
    CheckFields

    If CheckFields = True Then
    
        If UCase(Dir(strTempPath)) = strTempFile Then
            SirTemplate = strTempPath
            Call WriteSirInfo
        Else
            MsgBox strFileNotFndMsg, vbInformation, strMsgTitle
        End If
        
        'SirTemplate = "K:\T4\TechnologyManagement\Tools\SirDocuments\S" & zSir & ySir & ".txt"
        'SirTemplate = "V:\SIRWKBCH\FNDREPOS\DOCUMENT\S" & zSir & ySir & ".txt"
        'Call WriteSirInfo
        
    Else
    
        Beep
        MsgBox "Please complete all required field before adding this template.", vbOKOnly, "Request CopyBook Template"
        
   End If

Exit_mnuAddRequestRecGrp_Click:
    Exit Sub
Err_mnuAddRequestRecGrp_Click:
    MsgBox Error$
    Resume Exit_mnuAddRequestRecGrp_Click
    
End Sub

'****************************************************************************
' Name: mnuExit_Click
' Purpose: Verifies that all required fields have been entered then it gives
'           the user the option of saving the template and exiting or returning
'           to the form
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub mnuExit_Click()
On Error GoTo Err_mnuExit_Click
 
    Dim strMsg As String, strTitle As String
    Dim intStyle, intResponse As Integer
        
    intStyle = vbYesNo
    strTitle = "Request Copybook Template"
    strMsg = "Unable to save changes, return to form?"
    
    If CheckFields Then
        intResponse = MsgBox(strMsg, intStyle, strTitle)
        
        If intResponse = vbNo Then
            Unload Me
            
        Else
            'do nothing
        End If
        
    Else
         intResponse = MsgBox(strMsg, intStyle, strTitle)

         If intResponse = vbNo Then
            'user choose to exit. close current form - exit application
            Unload Me

        End If

    End If
 
Exit_mnuExit_Click:
    Exit Sub
    
Err_mnuExit_Click:
    MsgBox Error$
    Resume Exit_mnuExit_Click
    
End Sub

'****************************************************************************
' Name: DataLoad
' Purpose: Calls the procedures to load the information into the originating
'           and destination combo boxes
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Public Sub DataLoad()
On Error GoTo Err_DataLoad

    Dim myDatabase As String
         
'    'load data
'    myDatabase = "o:\tools\DataTeamTool\codestbl\Codesdat.mdb"
'    Call LoadProc(myDatabase, cboOriging, "tblEntries", "Key", "Decode", "DEV00701", "TableName")
'    Call LoadProc(myDatabase, cboDestination, "tblEntries", "Key", "Decode", "DEV00701", "TableName")
   
Exit_DataLoad:
    Exit Sub
Err_DataLoad:
    MsgBox Error$
    Resume Exit_DataLoad

End Sub

'****************************************************************************
' Name: CheckFields
' Purpose: Checks that no required fields are blank.
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Public Function CheckFields()
On Error GoTo Err_CheckFields

''''''''''''' Christina Mitchell TOSIRWB ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'     If (cboOriging.Text = "") Or (cboDestination.Text = "") Or (txtSirNo.Text = "") _
'   This needs to be added into the if stmt when sir wb is taken out
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    'check for blank required fields
    If (txtLongDesc.Text = "") Or (txtShortDesc.Text = "") Or (txtCOBOLNm.Text = "") _
        Or (txtCName.Text = "") Then
              CheckFields = False
    Else
    
              CheckFields = True
    End If

Exit_CheckFields:
    Exit Function

Err_CheckFields:
    MsgBox Error$
    Resume Exit_CheckFields
    
End Function


'****************************************************************************
' Name: WriteSirInfo
' Purpose: Writes the Record Group Template to the file.
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Public Sub WriteSirInfo()
On Error GoTo Err_WriteSirInfo

  Dim strMsg As String, strTitle As String
  Dim style
  Dim Response
  
  If FileExists(SirTemplate) Then
  
    Open SirTemplate For Append As #1


    Print #1, "                             Record Template"
    Print #1, ""
    Print #1, ""
    Print #1, ""
    Print #1, "     1. Long Description:"
    Print #1, ""
    Print #1, "     ________________________________________________________________________"
    Print #1, ""
    Print #1, "     "; txtLongDesc.Text
    Print #1, ""
    Print #1, "     ________________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     2. Short Description:"
    Print #1, ""
    Print #1, "     _________________________________________"
    Print #1, ""
    Print #1, "     "; txtShortDesc.Text
    Print #1, ""
    Print #1, "     _________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     3. COBOL Name:"
    Print #1, ""
    Print #1, "     _________________________________________"
    Print #1, ""
    Print #1, "     "; txtCOBOLNm.Text
    Print #1, ""
    Print #1, "     _________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     4. C Name:"
    Print #1, ""
    Print #1, "     _________________________________________"
    Print #1, ""
    Print #1, "     "; txtCName.Text
    Print #1, ""
    Print #1, "     _________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     6. Alias of Records:"
    Print #1, ""
    Print #1, "     _________________________________________"
    Print #1, ""
    Print #1, "     "; txtAlias.Text
    Print #1, ""
    Print #1, "     _________________________________________"
    Print #1, ""
    Print #1, ""
    
    Close #1

    strMsg = "Request Record Template successfully written. Do you want to create " & _
        "another Template?"
    strTitle = "Request Record Template"
    style = vbYesNo
    
    Response = MsgBox(strMsg, style, strTitle)
        
    If Response = vbYes Then
    
        'user wants to enter another template
        Call ResetProperties
        txtLongDesc.SetFocus
        
    Else
        'user is done, exit application
        Unload Me
        
    End If
    
  Else
  
    'file not found
    MsgBox SirTemplate & " does not exist! Please check SIR number and try again.", vbOKOnly, "File Not Found"

  End If
  
    
Exit_WriteSirInfo:
    'exit procedure
    Exit Sub
        
Err_WriteSirInfo:
    'Display error message to user
    MsgBox Error$
    GoTo Exit_WriteSirInfo
        

End Sub



Private Sub mnuInstructions_Click()
On Error GoTo Err_mnuInstructions_Click

' Specifying 1 as the second argument opens the application in
' normal size and gives it the focus.

    Dim strFilePath As String
    Dim strPath As String
    Dim intRetVal As Integer
    Dim dllFindPath As New DataTeamToolDLL.PathtoCodes
    
    'strPath = "K:\T4\TechnologyManagement\Tools\Documentation\DTTool\WebReqRecord.doc"
    'strFilePath = "C:\Apps\Msoffice\Winword\Winword.exe" & " " & strPath
    
    'strPath = "K:\T4\TechnologyManagement\Tools\Documentation\DTTool\WebReqRecord.txt"
    strPath = dllFindPath.glrGetRegistryValueFromPath(PATH_TO_HELP_FILE)
    strFilePath = "C:\WINNT\NOTEPAD.EXE" & " " & strPath
    
    intRetVal = Shell(strFilePath, 1)    ' Run Instructions.

Exit_mnuInstructions_Click:
    Exit Sub

Err_mnuInstructions_Click:
    MsgBox Error$
    Resume Exit_mnuInstructions_Click
    
End Sub

'****************************************************************************
' Name: txtCName_Change
' Purpose: Sets the background to white when the user types in the field and
'           sets the background to yellow if the info is deleted.
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub txtCName_Change()
On Error GoTo Err_txtCName_Change

    If Len(txtCName.Text) > 0 Then
        txtCName.BackColor = &HFFFFFF 'Sets the color of the field to white.
    Else
        txtCName.BackColor = &HFFFF&   'Sets the color of the field to Yellow.
    End If

Exit_txtCName_Change:
    Exit Sub

Err_txtCName_Change:
    MsgBox Error$
    Resume Exit_txtCName_Change
    
End Sub

'****************************************************************************
' Name: txtCName_LostFocus
' Purpose: Checks to see that the user has entered a C name without special
'           characters with a length between 3 and 18.
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub txtCName_LostFocus()
On Error GoTo Err_txtCName_LostFocus

    Dim strTemp As String
    Dim intI As Integer
    Dim intAscNumber As Integer
    Dim strLetter As String
        
    strTemp = txtCName.Text
    
    'check for blank field
    If txtCName.Text = "" Then
        txtCName.BackColor = &HFFFF&
        
    Else
        If Len(strTemp) < 3 Then
            
            'Check for special characters
            intI = 1
    
            Do While intI <= Len(strTemp)
                'get character to check
                strLetter = Mid(strTemp, intI, 1)
            
                'assign ascii number of character
                intAscNumber = Asc(strLetter)
            
                If (intAscNumber >= 32 And intAscNumber <= 47) Or (intAscNumber >= 58 And intAscNumber <= 64) Or (intAscNumber >= 91 And intAscNumber <= 96) Or (intAscNumber > 123 And intAscNumber < 127) Then
                    MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Request Record Template"
                
                    'return focus to txtCName and highlight entry
                    txtCName.SetFocus
                    txtCName.SelStart = 0
                    txtCName.SelLength = Len(strTemp)
                    Exit Sub
        
                End If
            
                'increment i to get next character
                intI = intI + 1
            Loop
            
            MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Request Record Template"
                
            'return focus to txtCName and highlight entry
            txtCName.SetFocus
            txtCName.SelStart = 0
            txtCName.SelLength = Len(strTemp)
           
        End If
    
    End If
            
    'Check for special characters
    intI = 1
    
    Do While intI <= Len(strTemp)
        'get character to check
        strLetter = Mid(strTemp, intI, 1)
            
        'assign ascii number of character
        intAscNumber = Asc(strLetter)
            
        If (intAscNumber >= 32 And intAscNumber <= 47) Or (intAscNumber >= 58 And intAscNumber <= 64) Or (intAscNumber >= 91 And intAscNumber <= 96) Or (intAscNumber >= 123 And intAscNumber <= 127) Then
            MsgBox "Please enter a C name that does not contain special characters and spaces.", vbOKOnly, "Request Record Template"
                
            'return focus to txtCName and highlight entry
            txtCName.SetFocus
            txtCName.SelStart = 0
            txtCName.SelLength = Len(strTemp)
            Exit Sub
        
        End If
            
        'increment i to get next character
        intI = intI + 1
        
    Loop

Exit_txtCName_LostFocus:
    Exit Sub

Err_txtCName_LostFocus:
    MsgBox Error$
    Resume Exit_txtCName_LostFocus
    
End Sub
'****************************************************************************
' Name: txtCOBOLNm_Change
' Purpose: Sets the background to white when the user types in the field and
'           sets the background to yellow if the info is deleted.
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub txtCOBOLNm_Change()
On Error GoTo Err_txtCOBOLNm_Change

    If Len(txtCOBOLNm.Text) > 0 Then
        txtCOBOLNm.BackColor = &HFFFFFF 'Sets the color of the field to white.
    Else
        txtCOBOLNm.BackColor = &HFFFF&   'Sets the color of the field to Yellow.
    End If
    
Exit_txtCOBOLNm_Change:
    Exit Sub
Err_txtCOBOLNm_Change:
    MsgBox Error$
    Resume Exit_txtCOBOLNm_Change
    
End Sub
'****************************************************************************
' Name: txtCOBOLNm_LostFocus
' Purpose: Checks to see that the user has entered a COBOL name
'           between 4 and 18 characters.
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub txtCOBOLNm_LostFocus()
On Error GoTo Err_txtCOBOLNm_LostFocus

    Dim strTemp As String
    Dim intI As Integer
    Dim intAscNumber As Integer
    Dim strLetter As String
           
    strTemp = txtCOBOLNm.Text
    txtCOBOLNm.Text = UCase(strTemp)
    
    If Len(txtCOBOLNm.Text) = 0 Then
        txtCOBOLNm.BackColor = &HFFFF&
    
    Else
        If Len(strTemp) < 4 Then
            
            'Check for special characters
            intI = 1
    
            Do While intI <= Len(strTemp)
                'get character to check
                strLetter = Mid(strTemp, intI, 1)
            
                'assign ascii number of character
                intAscNumber = Asc(strLetter)
            
                If (intAscNumber >= 32 And intAscNumber < 45) Or (intAscNumber > 45 And intAscNumber <= 47) Or (intAscNumber >= 58 And intAscNumber <= 64) Or (intAscNumber >= 91 And intAscNumber <= 96) Or (intAscNumber > 123 And intAscNumber < 127) Then
                    MsgBox "Please enter a COBOL name between 4 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Request Record Template"
                
                    'return focus to txtCOBOLNm and highlight entry
                    txtCOBOLNm.SetFocus
                    txtCOBOLNm.SelStart = 0
                    txtCOBOLNm.SelLength = Len(strTemp)
                    Exit Sub
        
                End If
            
                'increment i to get next character
                intI = intI + 1
            Loop
            
            MsgBox "Please enter a COBOL name between 4 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Request Record Template"
                
            'return focus to txtCOBOLNm and highlight entry
            txtCOBOLNm.SetFocus
            txtCOBOLNm.SelStart = 0
            txtCOBOLNm.SelLength = Len(strTemp)
           
        End If
    
    End If
            
    'Check for special characters
    intI = 1
    
    Do While intI <= Len(strTemp)
        'get character to check
        strLetter = Mid(strTemp, intI, 1)
            
        'assign ascii number of character
        intAscNumber = Asc(strLetter)
            
        If (intAscNumber >= 32 And intAscNumber < 45) Or (intAscNumber > 45 And intAscNumber <= 47) Or (intAscNumber >= 58 And intAscNumber <= 64) Or (intAscNumber >= 91 And intAscNumber <= 96) Or (intAscNumber >= 123 And intAscNumber <= 127) Then
            MsgBox "Please enter a COBOL name that does not contain special characters and spaces.", vbOKOnly, "Request Record Template"
                
            'return focus to txtCOBOLNm and highlight entry
            txtCOBOLNm.SetFocus
            txtCOBOLNm.SelStart = 0
            txtCOBOLNm.SelLength = Len(strTemp)
            Exit Sub
        
        End If
            
        'increment i to get next character
        intI = intI + 1
        
    Loop

Exit_txtCOBOLNm_LostFocus:
    Exit Sub
Err_txtCOBOLNm_LostFocus:
    MsgBox Error$
    Resume Exit_txtCOBOLNm_LostFocus
    
End Sub

'****************************************************************************
' Name: txtLongDesc_Change
' Purpose: Changes the background color of the field to yellow if the field is
'           blank and white if the field contains text.
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub txtLongDesc_Change()
On Error GoTo Err_txtLongDesc_Change

    If Len(txtLongDesc.Text) > 0 Then
        txtLongDesc.BackColor = &HFFFFFF 'Sets the color of the field to white.
    Else
        txtLongDesc.BackColor = &HFFFF&   'Sets the color of the field to Yellow.
    End If

Exit_txtLongDesc_Change:
    Exit Sub
Err_txtLongDesc_Change:
    MsgBox Error$
    Resume Exit_txtLongDesc_Change

End Sub

'****************************************************************************
' Name: txtShortDesc_Change
' Purpose: Changes the background color of the field to yellow if the field is
'           blank and white if the field contains text.
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub txtShortDesc_Change()
On Error GoTo Err_txtShortDesc_Change

    If Len(txtShortDesc.Text) > 0 Then
        txtShortDesc.BackColor = &HFFFFFF 'Sets the color of the field to white.
    Else
        txtShortDesc.BackColor = &HFFFF&   'Sets the color of the field to Yellow.
    End If

Exit_txtShortDesc_Change:
    Exit Sub

Err_txtShortDesc_Change:
    MsgBox Error$
    Resume Exit_txtShortDesc_Change
    
End Sub


'****************************************************************************
' Name: txtSirNo_Change
' Purpose: Changes the background color of the field to yellow if the field is
'           blank and white if the field contains text.  Will display a warning
'           if user enters a non numeric value.
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub txtSirNo_Change()
On Error GoTo Err_txtSirNo_Change

    Dim strTemp As String
    
    strTemp = txtSirNo.Text
           
    If Len(txtSirNo.Text) > 0 Then
        txtSirNo.BackColor = &HFFFFFF 'Sets the color of the field to white.
        
        If Not IsNumeric(strTemp) Then
            MsgBox "Please enter a five digit numeric value.", vbOKOnly, "Request Record Template"
            'set focus to txtSirNo and highlight field
            txtSirNo.BackColor = &HFF&
            txtSirNo.SetFocus
            txtSirNo.SelStart = 0
            txtSirNo.SelLength = Len(strTemp)
        End If
    
    Else
        txtSirNo.BackColor = &HFFFF&   'Sets the color of the field to Yellow.
    End If
            
Exit_txtSirNo_Change:
    Exit Sub

Err_txtSirNo_Change:
    MsgBox Error$
    Resume Exit_txtSirNo_Change
    
End Sub

'****************************************************************************
' Name: txtSirNo_LostFocus
' Purpose: If the Sir number is between 0 and 5 digits the number will be padded
'           on the left side with zeros.
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub txtSirNo_LostFocus()
On Error GoTo Err_txtSirNo_LostFocus
    
    Dim strTemp As String
    Dim intI As Integer

    strTemp = txtSirNo.Text
           
    If Len(txtSirNo.Text) > 0 Then
        txtSirNo.BackColor = &HFFFFFF 'Sets the color of the field to white.
        
        If Not IsNumeric(strTemp) Then
            MsgBox "Please enter a five digit numeric value.", vbOKOnly, "Request Record Template"
            'set focus to txtSirNo and highlight field
            txtSirNo.BackColor = &HFF&
            txtSirNo.SetFocus
            txtSirNo.SelStart = 0
            txtSirNo.SelLength = Len(strTemp)
        End If
    
    Else
        txtSirNo.BackColor = &HFFFF&   'Sets the color of the field to Yellow.
    End If
    
    If Len(txtSirNo.Text) <= 5 And Len(txtSirNo.Text) > 0 And IsNumeric(strTemp) Then
        
        For intI = Len(strTemp) + 1 To 5
            strTemp = "0" & strTemp
        Next intI
                    
        'display 5 digit number
        txtSirNo.Text = strTemp
            
        'assign the YYYYY portion of the SIR number
        ySir = txtSirNo.Text
    
    End If

Exit_txtSirNo_LostFocus:
    Exit Sub

Err_txtSirNo_LostFocus:
    MsgBox Error$
    Resume Exit_txtSirNo_LostFocus
    
End Sub
