VERSION 5.00
Begin VB.Form frmCOBOLVal 
   Caption         =   "Enter COBOL Values"
   ClientHeight    =   4695
   ClientLeft      =   1005
   ClientTop       =   1965
   ClientWidth     =   10095
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   ScaleHeight     =   4695
   ScaleWidth      =   10095
   Begin VB.TextBox txtDEName2 
      Height          =   315
      Left            =   7320
      MaxLength       =   30
      TabIndex        =   3
      Top             =   1560
      Width           =   2055
   End
   Begin VB.TextBox txtDecodesTbl 
      Height          =   315
      Left            =   2040
      MaxLength       =   8
      TabIndex        =   2
      Text            =   "CISnnnnn"
      ToolTipText     =   "Type in the nnnnn portion"
      Top             =   1560
      Width           =   2055
   End
   Begin VB.TextBox txtDEName1 
      Height          =   315
      Left            =   7320
      MaxLength       =   30
      TabIndex        =   1
      Top             =   480
      Width           =   2055
   End
   Begin VB.TextBox txtAliasDE 
      Height          =   315
      Left            =   2040
      MaxLength       =   8
      TabIndex        =   0
      Text            =   "CISnnnnn"
      ToolTipText     =   "Type in the nnnnn portion only"
      Top             =   480
      Width           =   2055
   End
   Begin VB.TextBox txtOper2 
      Height          =   315
      Left            =   5880
      MaxLength       =   5
      TabIndex        =   7
      Top             =   2880
      Width           =   1215
   End
   Begin VB.TextBox txtUB 
      Height          =   315
      Left            =   7200
      MaxLength       =   5
      TabIndex        =   9
      Top             =   2880
      Width           =   1215
   End
   Begin VB.TextBox txtOper1 
      Height          =   315
      Left            =   4560
      MaxLength       =   5
      TabIndex        =   6
      Top             =   2880
      Width           =   1215
   End
   Begin VB.TextBox txtLB 
      Height          =   315
      Left            =   3240
      MaxLength       =   5
      TabIndex        =   5
      Top             =   2880
      Width           =   1215
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "&OK"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   3360
      TabIndex        =   11
      Top             =   3720
      Width           =   1575
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Cancel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   5520
      TabIndex        =   13
      Top             =   3720
      Width           =   1575
   End
   Begin VB.TextBox txtCobolNam 
      Height          =   315
      Left            =   1080
      MaxLength       =   18
      TabIndex        =   4
      Top             =   2880
      Width           =   2055
   End
   Begin VB.Label lblRange 
      Caption         =   "Range"
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
      Left            =   480
      TabIndex        =   20
      Top             =   2400
      Width           =   615
   End
   Begin VB.Image Image5 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Left            =   240
      Top             =   1440
      Width           =   9495
   End
   Begin VB.Image Image4 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Left            =   240
      Top             =   360
      Width           =   9495
   End
   Begin VB.Label lblDEN2 
      Caption         =   "Data Element Name:"
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
      Left            =   5280
      TabIndex        =   19
      Top             =   1560
      Width           =   1815
   End
   Begin VB.Label lblDEN1 
      Caption         =   "Data Element Name:"
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
      Left            =   5280
      TabIndex        =   18
      Top             =   480
      Width           =   1815
   End
   Begin VB.Image Image2 
      BorderStyle     =   1  'Fixed Single
      Height          =   855
      Left            =   240
      Top             =   2520
      Width           =   9495
   End
   Begin VB.Label lblUB 
      Caption         =   "Upper Bound"
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
      Left            =   7200
      TabIndex        =   17
      Top             =   2640
      Width           =   1215
   End
   Begin VB.Label lblOper2 
      Caption         =   "Oper 2"
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
      Left            =   5880
      TabIndex        =   16
      Top             =   2640
      Width           =   735
   End
   Begin VB.Label lblOper1 
      Caption         =   "Oper 1"
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
      Left            =   4560
      TabIndex        =   15
      Top             =   2640
      Width           =   735
   End
   Begin VB.Label lblLB 
      Caption         =   "Lower Bound"
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
      Left            =   3240
      TabIndex        =   14
      Top             =   2640
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Decodes Table:"
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
      Left            =   480
      TabIndex        =   12
      Top             =   1560
      Width           =   1455
   End
   Begin VB.Label Label3 
      Caption         =   "Alias of DE:"
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
      Left            =   480
      TabIndex        =   10
      Top             =   480
      Width           =   1095
   End
   Begin VB.Label lblCobolNm 
      Caption         =   "COBOL Name"
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
      Left            =   1080
      TabIndex        =   8
      Top             =   2640
      Width           =   1215
   End
End
Attribute VB_Name = "frmCOBOLVal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCancel_Click()
On Error GoTo Err_cmdCancel_Click

    Dim Response, Style, Response2, Style2
    Dim Title As String, msg As String, sTitle2 As String, sMsg2 As String
    Dim myControl As Control
    
    sTitle2 = "Enter COBOL Values"
    sMsg2 = "You did not select anything on this form, do you wish to exit?"
    Style2 = vbYesNo
    
    'First check - See if anything was done
    If CheckControls(Me) = False Then
        
        Response2 = MsgBox(sMsg2, Style2, sTitle2)
        
        If Response2 = vbYes Then
            Unload Me
            frmDataElem.Show
        End If
        
        'exit the sub - we don't want anymore checks to be done
        Exit Sub
        
    End If
    
    
    On Error Resume Next    'temporary until type of control code is implemented
    
    msg = "Would you like to save your changes to the Template?"
    Style = vbYesNoCancel
    Title = "Enter COBOL Values"
    
    Response = MsgBox(msg, Style, Title)
    
    If Response = vbNo Then
        
        Screen.MousePointer = vbHourglass
        
        'user does not wish to save changes to the template
        For Each myControl In frmListValues.Controls
            
            'this will blank out any values they have selected
            'should use code to evaluate what type of control it is
            'then you can blank it out if that control has a text property else do nothing
            myControl.Text = ""
        
        Next myControl
        
        'unload current form and show frmDataElem
        Unload Me
        frmDataElem.Show
        
        Screen.MousePointer = vbNormal
        
    ElseIf Response = vbYes Then
        
        Screen.MousePointer = vbHourglass
        
        'hide the current form and show frmDataElem
        Me.Hide
        frmDataElem.Show
        
        Screen.MousePointer = vbNormal
        
    Else
        'do nothing cancel was selected, keep user on current form - frmListValues
    End If
      
Exit_cmdCancel_Click:
    Exit Sub
    
Err_cmdCancel_Click:
    MsgBox Error$
    GoTo Exit_cmdCancel_Click
    
End Sub

Private Sub cmdOK_Click()
On Error GoTo Err_cmdOK_Click

    Dim Response, Style
    Dim sTitle As String, sMsg As String
    
    sMsg = "You did not select anything on this form, do you wish to exit?"
    Style = vbYesNo
    sTitle = "Enter COBOL Values"
    
    
    Screen.MousePointer = vbHourglass
      
    If CheckControls(Me) = False Then
        
        Response = MsgBox(sMsg, Style, sTitle)
        
        If Response = vbYes Then
            Unload Me
            frmDataElem.Show
        End If
        
    Else
        'hide this form
        Me.Hide
        'redisplay data element form
        frmDataElem.Show
    End If
    
    Screen.MousePointer = vbNormal
    
Exit_cmdOK_Click:
    Exit Sub
    
Err_cmdOK_Click:
    MsgBox Error$
    Resume Err_cmdOK_Click
    
End Sub

Private Sub Form_Load()
    
    Call DataLoad
    
End Sub

Private Sub txtAliasDE_Change()
On Error GoTo Err_txtAliasDE_Change

    If Len(txtAliasDE.Text) > 8 Then
        MsgBox "Alias of DE: nnnnn value is only 5 characters. Please re-enter.", vbOKOnly, "Enter COBOL Values"
        txtAliasDE.SetFocus
        txtAliasDE.SelStart = 0
        txtAliasDE.SelLength = Len(txtAliasDE.Text)
    ElseIf txtAliasDE.Text = "" Then
        txtAliasDE.Text = "CISnnnnn"
    End If
    
Exit_txtAliasDE_Change:
    Exit Sub

Err_txtAliasDE_Change:
    GoTo Exit_txtAliasDE_Change
    
End Sub

Private Sub txtAliasDE_Click()
On Error GoTo Err_txtAliasDE_Click

    Dim sString As String
    
    sString = txtAliasDE.Text
    sString = Mid(sString, 4, 5)
   
    If Len(txtAliasDE.Text) = 8 And (sString <> "nnnnn") Then
        'do nothing
    Else
        txtAliasDE.Text = "CIS"
        'put cursor at end of text
        SendKeys "{END}", False
        
    End If
    
Exit_txtAliasDE_Click:
    Exit Sub
    
Err_txtAliasDE_Click:
    MsgBox Error$
    Resume Err_txtAliasDE_Click
    
End Sub

Private Sub txtAliasDE_GotFocus()
On Error GoTo Err_txtAliasDE_LostFocus
    Dim sString As String
    
    sString = txtAliasDE.Text
    sString = Mid(sString, 4, 5)
   
    If (sString = "nnnnn") Then
        txtAliasDE.Text = "CIS"
        'put cursor at end of text
        SendKeys "{END}", False
    End If
        
Exit_txtAliasDE_LostFocus:
    Exit Sub
    
Err_txtAliasDE_LostFocus:
    MsgBox Error$
    Resume Err_txtAliasDE_LostFocus
        
End Sub

'*************************************************************************************
'Sub/Function: txtAliasDE_LostFocus
'
'Date Written: 09/23/97
'
'Author: David Zimmer
'
'Purpose: This will valid date the nnnnn portion of the CISnnnnn
'
'*************************************************************************************
Private Sub txtAliasDE_LostFocus()
On Error GoTo Err_txtAliasDE_LostFocus
    
    Dim sString As String, sTemp As String, sNNNNN
    
    sString = "CIS"
    sTemp = txtAliasDE.Text
    
    sNNNNN = Mid(sTemp, 4, 5)       'nnnnn portion of the CISnnnnn - various checks are
                                    'done below on this part
    
    
    If sTemp = "" Or sTemp = "CIS" Or sTemp = "CISnnnnn" Then
    
        'user has selected to move on
        txtAliasDE.Text = "CISnnnnn"
        
    ElseIf Not IsNumeric(sNNNNN) Then
    
        MsgBox "Alias of DE: nnnnn value must be numeric. Please re-enter.", vbOKOnly, "Enter COBOL Values"
        txtAliasDE.SetFocus
        txtAliasDE.SelStart = 3
        txtAliasDE.SelLength = Len(sTemp)
        
    ElseIf Len(sNNNNN) < 5 Then
        
        MsgBox "Alias of DE: nnnnn must be 5 characters in length. Please re-enter.", vbOKOnly, "Enter COBOL Values"
        txtAliasDE.SetFocus
        txtAliasDE.SelStart = 3
        txtAliasDE.SelLength = Len(sTemp)
        
    
    Else
        
        txtAliasDE.Text = sString & sNNNNN
        
    End If
    
Exit_txtAliasDE_LostFocus:
    Exit Sub
    
Err_txtAliasDE_LostFocus:
    MsgBox Error$
    GoTo Exit_txtAliasDE_LostFocus
    
End Sub


'*************************************************************************************
'Sub/Function: txtCobolNam_LostFocus
'
'Date Written: 09/24/97
'
'Author: David Zimmer
'
'Purpose: This will ensure that an entry is not less than 4 characters
'
'*************************************************************************************
Private Sub txtCobolNam_LostFocus()
On Error GoTo Err_txtCobolNam_LostFocus


    Dim sString As String
    Dim iDash As Integer
    
    iDash = 45
    
    sString = txtCOBOLNam.Text
    
    If sString = "" Then
        'do nothing
        Exit Sub
    End If
    
        
    If Len(txtCOBOLNam.Text) < 4 Then
    
        MsgBox "Please enter a COBOL Name between 4 and 18 characters that does not contain special characters.", vbOKOnly, "Enter COBOL Values"
        txtCOBOLNam.SetFocus
        txtCOBOLNam.SelStart = 0
        txtCOBOLNam.SelLength = Len(sString)
        
    ElseIf Len(sString) > 3 And SpecialCharsChk(sString, iDash, True) Then
        
        MsgBox "Please enter a COBOL Name between 4 and 18 characters with no special characters.", vbOKOnly, "Enter COBOL Values"
        txtCOBOLNam.SetFocus
        txtCOBOLNam.SelStart = 0
        txtCOBOLNam.SelLength = Len(sString)
        
    Else
        txtCOBOLNam.Text = UCase(sString)

    End If
    
Exit_txtCobolNam_LostFocus:
    Exit Sub

Err_txtCobolNam_LostFocus:
    MsgBox Error$
    GoTo Exit_txtCobolNam_LostFocus
    
           
    
End Sub

Public Sub DataLoad()
On Error GoTo Err_DataLoad
    
    
    'Load combo boxes
    Dim myDatabase As String
    
    
    
    
Exit_DataLoad:
    Exit Sub

Err_DataLoad:
    MsgBox Error$
    GoTo Exit_DataLoad
       
End Sub

Private Sub txtDecodesTbl_Change()
On Error GoTo Err_txtDecodesTbl_Change
    
    'make sure user does not exceed 8 characters
    If Len(txtDecodesTbl.Text) > 8 Then
        MsgBox "Decodes Table: nnnnn value is only 5 characters. Please re-enter.", vbOKOnly, "Enter COBOL Values"
        txtDecodesTbl.SetFocus
        txtDecodesTbl.SelStart = 0
        txtDecodesTbl.SelLength = Len(txtDecodesTbl.Text)
    ElseIf txtDecodesTbl.Text = "" Then
        txtDecodesTbl.Text = "CISnnnnn"
    End If
    
    
    
Exit_txtDecodesTbl_Change:
    Exit Sub

Err_txtDecodesTbl_Change:
    MsgBox Error$
    GoTo Exit_txtDecodesTbl_Change
    
End Sub

Private Sub txtDecodesTbl_Click()
On Error GoTo Err_txtDecodesTbl_Click

    Dim sString As String
    
    sString = txtDecodesTbl.Text
    sString = Mid(sString, 4, 5)
   
    If Len(txtDecodesTbl.Text) = 8 And (sString <> "nnnnn") Then
        'do nothing
    Else
        txtDecodesTbl.Text = "CIS"
        'place cursor at end of text
        SendKeys "{END}", False
    End If
    
Exit_txtDecodesTbl_Click:
    Exit Sub
    
Err_txtDecodesTbl_Click:
    MsgBox Error$
    Resume Err_txtDecodesTbl_Click
    
    
End Sub

Private Sub txtDecodesTbl_GotFocus()
On Error GoTo Err_txtDecodesTbl_GotFocus

    Dim sString As String
    
    sString = txtDecodesTbl.Text
    sString = Mid(sString, 4, 5)
   
    If Len(txtDecodesTbl.Text) = 8 And (sString <> "nnnnn") Then
        'do nothing
    Else
        txtDecodesTbl.Text = "CIS"
        'place cursor at end of text
        SendKeys "{END}", False
    End If
    
Exit_txtDecodesTbl_GotFocus:
    Exit Sub
    
Err_txtDecodesTbl_GotFocus:
    MsgBox Error$
    Resume Err_txtDecodesTbl_GotFocus
    
End Sub

'*************************************************************************************
'Sub/Function: txtDecodesTbl_LostFocus
'
'Date Written: 09/23/97
'
'Author: David Zimmer
'
'Purpose: This will valid date the nnnnn portion of the CISnnnnn
'
'*************************************************************************************
Private Sub txtDecodesTbl_LostFocus()
On Error GoTo Err_txtDecodesTbl_LostFocus

    Dim sString As String, sTemp As String, sNNNNN
    
    sString = "CIS"
    sTemp = txtDecodesTbl.Text
    
    sNNNNN = Mid(sTemp, 4, 5)
    
    
    If sTemp = "" Or sTemp = "CIS" Or sTemp = "CISnnnnn" Then
    
        txtDecodesTbl.Text = "CISnnnnn"
        
    ElseIf Not IsNumeric(sNNNNN) Then
    
        MsgBox "Decodes Table: nnnnn value must be numeric. Please re-enter.", vbOKOnly, "Enter COBOL Values"
        txtDecodesTbl.SetFocus
        txtDecodesTbl.SelStart = 3
        txtDecodesTbl.SelLength = Len(sTemp)
        
    ElseIf Len(sNNNNN) < 5 Then
        
        MsgBox "Decodes Table: nnnnn must be 5 characters in length. Please re-enter.", vbOKOnly, "Enter COBOL Values"
        txtDecodesTbl.SetFocus
        txtDecodesTbl.SelStart = 3
        txtDecodesTbl.SelLength = Len(sTemp)
        
    
    Else
        
        txtDecodesTbl.Text = sString & sNNNNN
        
    End If
    
Exit_txtDecodesTbl_LostFocus:
    Exit Sub
    
Err_txtDecodesTbl_LostFocus:
    MsgBox Error$
    GoTo Exit_txtDecodesTbl_LostFocus
    
    
End Sub
