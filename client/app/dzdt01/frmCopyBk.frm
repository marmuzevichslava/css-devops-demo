VERSION 5.00
Begin VB.Form frmCopyBk 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Request Copy Book Template"
   ClientHeight    =   5280
   ClientLeft      =   150
   ClientTop       =   720
   ClientWidth     =   9240
   LinkTopic       =   "Form5"
   ScaleHeight     =   5280
   ScaleWidth      =   9240
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtImage 
      BackColor       =   &H00C0C0C0&
      Height          =   315
      Left            =   2040
      Locked          =   -1  'True
      TabIndex        =   14
      Text            =   "Internal"
      Top             =   3480
      Width           =   2175
   End
   Begin VB.TextBox txtSuffix 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2040
      MaxLength       =   4
      TabIndex        =   9
      Top             =   2760
      Width           =   2175
   End
   Begin VB.CheckBox chkImplied 
      Alignment       =   1  'Right Justify
      Caption         =   "12. Implied &Redefinition"
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
      Left            =   4635
      TabIndex        =   15
      Top             =   3480
      Width           =   2415
   End
   Begin VB.CheckBox chkPrefix88 
      Alignment       =   1  'Right Justify
      Caption         =   "6. &Prefix 88-Level Items"
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
      Left            =   4650
      TabIndex        =   8
      Top             =   2400
      Width           =   2415
   End
   Begin VB.TextBox txtCpyBkNam 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   6795
      MaxLength       =   8
      TabIndex        =   6
      Top             =   2040
      Width           =   2175
   End
   Begin VB.TextBox txtSirNo 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   4680
      MaxLength       =   5
      TabIndex        =   1
      Top             =   5400
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.ComboBox cboDestination 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   6360
      TabIndex        =   2
      Top             =   5400
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.ComboBox cboOriging 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   2520
      TabIndex        =   0
      Top             =   5400
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.TextBox txtShortDesc 
      BackColor       =   &H0000FFFF&
      Height          =   375
      Left            =   2040
      MaxLength       =   25
      TabIndex        =   4
      Top             =   1440
      Width           =   3975
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
      Width           =   8535
   End
   Begin VB.ComboBox cboPrefix 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2040
      TabIndex        =   7
      Top             =   2400
      Width           =   2220
   End
   Begin VB.ComboBox cboInitial 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2400
      TabIndex        =   16
      Text            =   "3"
      Top             =   4440
      Width           =   1500
   End
   Begin VB.ComboBox cboIncrement 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   6120
      TabIndex        =   17
      Text            =   "2"
      Top             =   4440
      Width           =   1500
   End
   Begin VB.ComboBox cboCpyBkType 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   2040
      TabIndex        =   5
      Top             =   2040
      Width           =   2220
   End
   Begin VB.ComboBox cboEntity 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   6810
      TabIndex        =   10
      Top             =   2760
      Width           =   2220
   End
   Begin VB.ComboBox cboValues 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   2040
      TabIndex        =   11
      Top             =   3120
      Width           =   2220
   End
   Begin VB.ComboBox cboLanguage 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   6810
      TabIndex        =   13
      Top             =   3120
      Width           =   2220
   End
   Begin VB.Line Line1 
      Visible         =   0   'False
      X1              =   360
      X2              =   9000
      Y1              =   5880
      Y2              =   5880
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
      Left            =   6000
      TabIndex        =   32
      Top             =   5400
      Visible         =   0   'False
      Width           =   135
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
      Left            =   4320
      TabIndex        =   31
      Top             =   5400
      Visible         =   0   'False
      Width           =   135
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
      Left            =   720
      TabIndex        =   30
      Top             =   5400
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label Label14 
      Caption         =   "5. Prefix:"
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
      TabIndex        =   29
      Top             =   2400
      Width           =   855
   End
   Begin VB.Label Label13 
      Caption         =   "7. Suffix:"
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
      TabIndex        =   28
      Top             =   2760
      Width           =   855
   End
   Begin VB.Image Image1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Left            =   1560
      Top             =   4320
      Width           =   6375
   End
   Begin VB.Label Label12 
      Caption         =   "Increment:"
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
      Left            =   5160
      TabIndex        =   27
      Top             =   4440
      Width           =   975
   End
   Begin VB.Label Label11 
      Caption         =   "Initial:"
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
      Left            =   1800
      TabIndex        =   26
      Top             =   4440
      Width           =   615
   End
   Begin VB.Label Label10 
      Caption         =   "13 Level Numbers:"
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
      Left            =   1560
      TabIndex        =   25
      Top             =   4080
      Width           =   1935
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
      TabIndex        =   24
      Top             =   240
      Width           =   1815
   End
   Begin VB.Label lblShortDesc 
      Caption         =   "2. Short Description:"
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
      TabIndex        =   23
      Top             =   1440
      Width           =   1815
   End
   Begin VB.Label lblUser 
      Caption         =   "4. Copybook ID:"
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
      Left            =   4680
      TabIndex        =   22
      Top             =   2055
      Width           =   1695
   End
   Begin VB.Label Label1 
      Caption         =   "3. Copybook Type:"
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
      TabIndex        =   21
      Top             =   2040
      Width           =   1695
   End
   Begin VB.Label Label2 
      Caption         =   "8. Entity Process Type:"
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
      Left            =   4680
      TabIndex        =   20
      Top             =   2760
      Width           =   2055
   End
   Begin VB.Label Label3 
      Caption         =   "9. Values:"
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
      TabIndex        =   19
      Top             =   3120
      Width           =   975
   End
   Begin VB.Label Label4 
      Caption         =   "10. Language:"
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
      Left            =   4650
      TabIndex        =   18
      Top             =   3120
      Width           =   1695
   End
   Begin VB.Label Label6 
      Caption         =   "10. Image:"
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
      TabIndex        =   12
      Top             =   3480
      Width           =   975
   End
   Begin VB.Menu mnuCopyBook 
      Caption         =   "&CopyBook"
      Begin VB.Menu mnuAddCpyBk 
         Caption         =   "&Add CopyBook Template"
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
Attribute VB_Name = "frmCopyBk"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cboCpyBkType_Change()
'****************************************************************************
' Name: cboCpyBkType_Change
' Purpose: If the field is blank the field background turns yellow.  However
'           if the user tries to type in a value a message is displayed and
'           the field background turns red.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

On Error GoTo Err_cboCpyBkType_Change

    If cboCpyBkType.Text = "" Then
        cboCpyBkType.BackColor = &HFFFF&
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
        'set global string compare item
        gblsComp = cboCpyBkType.Text
        cboCpyBkType.BackColor = &HFF&
        cboCpyBkType.Refresh
    End If
    
Exit_cboCpyBkType_Change:
    Exit Sub
    
Err_cboCpyBkType_Change:
    MsgBox Error$
    GoTo Exit_cboCpyBkType_Change

    
End Sub

Private Sub cboCpyBkType_Click()
'****************************************************************************
' Name: cboCpyBkType_Click
' Purpose: When the user clicks on this field the background turns white.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

On Error GoTo Err_cboCpyBkType_Click

    With cboCpyBkType
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""

Exit_cboCpyBkType_Click:
    Exit Sub

Err_cboCpyBkType_Click:
    MsgBox Error$
    GoTo Exit_cboCpyBkType_Click
    
End Sub

Private Sub cboCpyBkType_LostFocus()
'****************************************************************************
' Name: cboCpyBkType_LostFocus
' Purpose: If the field is blank the field background turns yellow.  However
'           if the user tries to type in a value a message is displayed and
'           the field background turns red.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

On Error GoTo Err_cboCpyBkType_LostFocus
    
    If cboCpyBkType.Text = "" Then
        cboCpyBkType.BackColor = &HFFFF&
    ElseIf (gblsComp = cboCpyBkType.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
        cboCpyBkType.BackColor = &HFF&
        cboCpyBkType.SetFocus
        cboCpyBkType.Refresh
    End If
    
Exit_cboCpyBkType_LostFocus:
    Exit Sub
    
Err_cboCpyBkType_LostFocus:
    MsgBox Error$
    GoTo Exit_cboCpyBkType_LostFocus
    
End Sub

Private Sub cboDestination_Change()
'****************************************************************************
' Name: cboDestination_Change
' Purpose: Changes the background color of the field yellow if the field is
'           blank and red if the user tries to enter in a value instead of
'           slecting it from the combo box list
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************

''''''''''''' Sbricker TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboDestination_Change
'
'
'    If cboDestination.Text = "" Then
'        cboDestination.BackColor = &HFFFF&
'    Else
'        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
'        'set global string compare item
'        gblsComp = cboDestination.Text
'        cboDestination.BackColor = &HFF&
'        cboDestination.Refresh
'    End If
'
'Exit_cboDestination_Change:
'    Exit Sub
'
'Err_cboDestination_Change:
'    MsgBox Error$
'    GoTo Exit_cboDestination_Change
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

End Sub

Private Sub cboDestination_Click()
'****************************************************************************
' Name: cboDestination_Click
' Purpose: Changes the background color of the field to white when the user
'           clicks on the combo box.  The x part of the SIR is created.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************
''''''''''''' Sbricker TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboDestination_Click
'
'    Dim tempString As String
'
'    tempString = cboDestination.Text
'    tempString = Mid(tempString, 2, 2)
'
'    zSir = tempString
'
'    'update global string compare item
'    gblsComp = ""
'
'    'set background color upon click event
'    With cboDestination
'        .BackColor = &HFFFFFF
'    End With
'
'Exit_cboDestination_Click:
'    Exit Sub
'
'
'Err_cboDestination_Click:
'    MsgBox Error$
'    GoTo Exit_cboDestination_Click
'''''''''''''''''''''''''''''''''''''''''''''''''''
    
End Sub

'****************************************************************************
' Name: cboDestination_LostFocus
' Purpose: Changes the background color of the field to red and will not let
'           the user continue on unless a value has been selected from the
'           list
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboDestination_LostFocus()

''''''''''''' Sbricker TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboDestination_LostFocus
'
'    If cboDestination.Text = "" Then
'        cboDestination.BackColor = &HFFFF&
'
'    ElseIf (gblsComp = cboDestination.Text) Then
'        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
'        cboDestination.BackColor = &HFF&
'        cboDestination.SetFocus
'        cboDestination.Refresh
'
'    End If
'
'Exit_cboDestination_LostFocus:
'    Exit Sub
'
'Err_cboDestination_LostFocus:
'    MsgBox Error$
'    GoTo Exit_cboDestination_LostFocus
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    
End Sub

'****************************************************************************
' Name: cboEntity_Change
' Purpose: Changes the background color of the field to red and will not let
'           the user continue on unless a value has been selected from the
'           list
'
' Created by: Christina Mitchell
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboEntity_Change()
On Error GoTo Err_cboEntity_Change
    
    If cboEntity.Text = "" Then
        cboEntity.BackColor = &HFFFF&
    
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
        'set global string compare item
        gblsComp = cboEntity.Text
        cboEntity.BackColor = &HFF&
        cboEntity.Refresh
    
    End If
    
Exit_cboEntity_Change:
    Exit Sub
    
Err_cboEntity_Change:
    MsgBox Error$
    GoTo Exit_cboEntity_Change
    
    
End Sub

Private Sub cboEntity_Click()
On Error GoTo Err_cboEntity_Click
    
    With cboEntity
        .BackColor = &HFFFFFF
      
    End With
    
    'set gblsComp value
    gblsComp = ""

Exit_cboEntity_Click:
    Exit Sub
    
Err_cboEntity_Click:
    MsgBox Error$
    GoTo Exit_cboEntity_Click
    
End Sub

'****************************************************************************
' Name: cboEntity_LostFocus
' Purpose: Changes the background color of the field to red and will not let
'           the user continue on unless a value has been selected from the
'           list
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboEntity_LostFocus()

On Error GoTo Err_cboEntity_LostFocus
    
    If cboEntity.Text = "" Then
        cboEntity.BackColor = &HFFFF&
    
    ElseIf (gblsComp = cboEntity.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
        cboEntity.BackColor = &HFF&
        cboEntity.SetFocus
        cboEntity.Refresh
    
    End If
    
Exit_cboEntity_LostFocus:
    Exit Sub
    
Err_cboEntity_LostFocus:
    MsgBox Error$
    GoTo Exit_cboEntity_LostFocus
    
    
End Sub

'****************************************************************************
' Name: cboIncrement_Change
' Purpose: Changes the background color of the field to red and will not let
'           the user continue on unless a value has been selected from the
'           list
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboIncrement_Change()
On Error GoTo Err_cboIncrement_Change

        
    If cboIncrement.Text = "" Or cboIncrement.Text = "2" Then
       'user has modified choices, set back to default
        cboIncrement.BackColor = &HFFFFFF
        cboIncrement.Text = "2"
        
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
        
        'set global string compare item
        gblsComp = cboIncrement.Text
        cboIncrement.BackColor = &HFF&
        
    End If
    
    
Exit_cboIncrement_Change:
    Exit Sub

Err_cboIncrement_Change:
    GoTo Exit_cboIncrement_Change


End Sub

'****************************************************************************
' Name: cboIncrement_Click
' Purpose: Sets the background color to white.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboIncrement_Click()
On Error GoTo Err_cboIncrement_Click
    
    'set gblsComp to nothing
    gblsComp = ""
    gblBClick = True
    
    cboIncrement.BackColor = &HFFFFFF   'set background to white

Exit_cboIncrement_Click:
    Exit Sub

Err_cboIncrement_Click:
    MsgBox Error$
    GoTo Exit_cboIncrement_Click
    
End Sub

'****************************************************************************
' Name: cboIncrement_LostFocus
' Purpose: Sets the Increment to 2 if its blank.  If the user tries to enter
'           a value a message is displayed and the background turns red.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboIncrement_LostFocus()
On Error GoTo Err_cboIncrement_LostFocus

    'First see if nothing exists in the combo box
    If cboIncrement.Text = "" Then
    
        'user has deleted the value, supply the default - and exit Sub
        'FYI - the "Exit Sub" will not execute until after the Change() event
        'has happened.
        cboIncrement.Text = "2"
        Exit Sub
        
    End If

    
    If gblBClick = True Then
        
        'If flag is true then compare text value to gblsComp, if they are equal
        'then the user simply clicked on the combo box and then moved/clicked
        'somewhere else - flag this
        If cboIncrement.Text = gblsComp Then
        
            MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
            cboIncrement.BackColor = &HFF&
            cboIncrement.SetFocus
            gblBClick = False
            
        Else
        
            'user selected a value from the combo box.
            cboIncrement.BackColor = &HFFFFFF
            
        End If
        
    ElseIf (gblsComp = cboIncrement.Text) Then
    
        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
        cboIncrement.BackColor = &HFF&
        cboIncrement.SetFocus
        gblBClick = False
    
    End If
    
Exit_cboIncrement_LostFocus:
    Exit Sub

Err_cboIncrement_LostFocus:
    GoTo Exit_cboIncrement_LostFocus
    
End Sub

'****************************************************************************
' Name: cboInitial_Change
' Purpose: If the combo box is empty it is filled in with a 3 and the background
'           turns white.  If the user tries to type in a value a message is
'           displayed and the background turns red.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboInitial_Change()
On Error GoTo Err_cboInitial_Change

        
    If cboInitial.Text = "" Or cboInitial.Text = "3" Then
    
        'user has modified choices, set back to default
        cboInitial.BackColor = &HFFFFFF
        cboInitial.Text = "3"
       
    Else
    
        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
        'set global string compare item
        gblsComp = cboInitial.Text
        cboInitial.BackColor = &HFF&
        
    End If
    
    
Exit_cboInitial_Change:
    Exit Sub

Err_cboInitial_Change:
    GoTo Exit_cboInitial_Change
    
End Sub

Private Sub cboInitial_Click()
On Error GoTo Err_cboInitial_Click

'set gblsComp to nothing
    gblsComp = ""
    gblBClick = True
    
    cboInitial.BackColor = &HFFFFFF   'set background to white
    
Exit_cboInitial_Click:
    Exit Sub
    
Err_cboInitial_Click:
    GoTo Exit_cboInitial_Click
    
End Sub

'****************************************************************************
' Name: cboInitial_LostFocus
' Purpose: Sets the Initial to 3 if its blank.  If the user tries to enter
'           a value a message is displayed and the background turns red.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub cboInitial_LostFocus()
On Error GoTo Err_cboInitial_LostFocus

    
    'First see if nothing exists in the combo box
    If cboInitial.Text = "" Then
    
        'user has deleted the value, supply the default - and exit Sub
        'FYI - the "Exit Sub" will not execute until after the Change() event
        'has happened.
        cboInitial.Text = "3"
        Exit Sub
        
    End If
       
    
    If gblBClick = True Then
        
        'If flag is true then compare text value to gblsComp, if they are equal
        'then the user simply clicked on the combo box and then moved/clicked
        'somewhere else - flag this
        If cboInitial.Text = gblsComp Then
            
            MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
            cboInitial.BackColor = &HFF&
            cboInitial.SetFocus
            gblBClick = False
            
        Else
        
            'user made a valid selection from the combo box.
            cboInitial.BackColor = &HFFFFFF
            
        End If
        
    ElseIf (gblsComp = cboInitial.Text) Then
    
        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
        cboInitial.BackColor = &HFF&
        cboInitial.SetFocus
        gblBClick = False
    
    End If
    
Exit_cboInitial_LostFocus:
    Exit Sub

Err_cboInitial_LostFocus:
    GoTo Exit_cboInitial_LostFocus
    
End Sub

'****************************************************************************
' Name: cboLanguage_Change
' Purpose: A message will be displayed and the field background will turn
'           red if the user tries to enter in a value.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub cboLanguage_Change()
On Error GoTo Err_cboLanguage_Change
    
    If cboLanguage.Text = "" Then
        cboLanguage.BackColor = &HFFFF&
    
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
        'set global string compare item
        gblsComp = cboLanguage.Text
        cboLanguage.BackColor = &HFF&
        cboLanguage.Refresh
    
    End If
    
Exit_cboLanguage_Change:
    Exit Sub

Err_cboLanguage_Change:
    MsgBox Error$
    GoTo Exit_cboLanguage_Change
    
    
End Sub

Private Sub cboLanguage_Click()
On Error GoTo Err_cboLanguage_Click
    
    With cboLanguage
        .BackColor = &HFFFFFF
        
    End With
    
    'set gblsComp to nothing
    gblsComp = ""

Exit_cboLanguage_Click:
    Exit Sub
    
Err_cboLanguage_Click:
    MsgBox Error$
    GoTo Exit_cboLanguage_Click
    
    
    
End Sub

'****************************************************************************
' Name: cboLanguage_LostFocus
' Purpose: A message is displayed and the field background turns red if the
'           user tries to enter in a value.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub cboLanguage_LostFocus()
On Error GoTo Err_cboLanguage_LostFocus
    
    If cboLanguage.Text = "" Then
        cboLanguage.BackColor = &HFFFF&
    
    ElseIf (gblsComp = cboLanguage.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
        cboLanguage.BackColor = &HFF&
        cboLanguage.SetFocus
        cboLanguage.Refresh
    
    End If

Exit_cboLanguage_LostFocus:
    Exit Sub

Err_cboLanguage_LostFocus:
    MsgBox Error$
    GoTo Exit_cboLanguage_LostFocus
    
End Sub

'****************************************************************************
' Name: cboOriging_Change
' Purpose: Changes the background color of the field yellow if the field is
'           blank and red if the user tries to enter in a value instead of
'           slecting it from the combo box list
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboOriging_Change()

'''''''''''''''''''  Sbricker TOSIRWB '''''''''''''''''''
'On Error GoTo Err_cboOriging_Change
'
'    If cboOriging.Text = "" Then
'        cboOriging.BackColor = &HFFFF&
'
'    Else
'        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
'
'        'set global string compare item
'        gblsComp = cboOriging.Text
'        cboOriging.BackColor = &HFF&
'        cboOriging.Refresh
'
'    End If
'
'Exit_cboOriging_Change:
'    Exit Sub
'
'Err_cboOriging_Change:
'    MsgBox Error$
'    GoTo Exit_cboOriging_Change
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        
End Sub

'****************************************************************************
' Name: cboOriging_Click
' Purpose: Changes the background color of the field to white when the user
'           clicks on the combo box.  The x part of the SIR is created.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub cboOriging_Click()

''''''''''''' Sbricker TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboOriging_Click
'
'
'    With cboOriging
'        .BackColor = &HFFFFFF
'    End With
'
'
'    'update global string compare item
'    gblsComp = ""
'
'
'Exit_cboOriging_Click:
'    Exit Sub
'
'Err_cboOriging_Click:
'    MsgBox Error$
'    GoTo Exit_cboOriging_Click
''''''''''''''''''''''''''''''''''''''''''''''''
    
           
End Sub

'****************************************************************************
' Name: cboOriging_LostFocus
' Purpose: Changes the background color of the field to red and will not let
'           the user continue on unless a value has been selected from the
'           list
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub cboOriging_LostFocus()

''''''''''''''''''' Sbricker TOSIRWB ''''''''''''''''''''''''''''
'On Error GoTo Err_cboOriging_LostFocus
'
'    If cboOriging.Text = "" Then
'        cboOriging.BackColor = &HFFFF&
'
'    ElseIf (gblsComp = cboOriging.Text) Then
'        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
'        cboOriging.BackColor = &HFF&
'        cboOriging.SetFocus
'        cboOriging.Refresh
'
'    End If
'
'Exit_cboOriging_LostFocus:
'    Exit Sub
'
'Err_cboOriging_LostFocus:
'    MsgBox Error$
'    GoTo Exit_cboOriging_LostFocus
'''''''''''''''''''''''''''''''''''''''''''''''''
   
End Sub

'****************************************************************************
' Name: cboPrefix_Change
' Purpose: Validates that the prefix enterd is not greater than four characters
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboPrefix_Change()
On Error GoTo Err_cboPrefix_Change
        
    Dim intFour As Integer
    Dim intZero As Integer
    
    intFour = 4
    intZero = 0
    
    cboPrefix.BackColor = &HFFFFFF 'set the background color to white
    
    'test for an entry greater than 4 characters - there is no maxlength property
    'you can set at design time - must be done at runtime
    If Len(cboPrefix.Text) > intFour Then
        MsgBox "Please enter a prefix that is not greater than " & intFour & " characters.", vbOKOnly, "Request Copybook Template"
        cboPrefix.SetFocus
        cboPrefix.SelStart = intZero
        cboPrefix.SelLength = Len(cboPrefix.Text)
    End If
    
Exit_cboPrefix_Change:
    Exit Sub

Err_cboPrefix_Change:
    MsgBox Error$
    GoTo Exit_cboPrefix_Change
    
End Sub

Private Sub cboPrefix_Click()
On Error GoTo Err_cboPrefix_Click
        
    With cboPrefix
        .BackColor = &HFFFFFF
        
    End With

Exit_cboPrefix_Click:
    Exit Sub

Err_cboPrefix_Click:
    MsgBox Error$
    GoTo Exit_cboPrefix_Click
    
    
End Sub

'****************************************************************************
' Name: cboPrefix_LostFocus
' Purpose: Validates that the value entered is not greater than four characters.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboPrefix_LostFocus()
On Error GoTo Err_cboPrefix_LostFocus

    Dim intFour As Integer
    Dim intZero As Integer
    
    intFour = 4
    intZero = 0
    
    'check for value - if value exists make sure value is not greater than 5 characters
    If Len(cboPrefix.Text) > intFour Then
        MsgBox "Please enter a prefix that is not greater than " & intFour & " characters.", vbOKOnly, "Request Copybook Template"
        cboPrefix.SetFocus
        cboPrefix.SelStart = intZero
        cboPrefix.SelLength = Len(cboPrefix.Text)
    End If

Exit_cboPrefix_LostFocus:
    Exit Sub
    
Err_cboPrefix_LostFocus:
    MsgBox Error$
    GoTo Exit_cboPrefix_LostFocus
    
End Sub

'****************************************************************************
' Name: cboValues_Change
' Purpose: A message is displayed and the background turns red if the user
'           tries to enter in a value.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************
Private Sub cboValues_Change()
On Error GoTo Err_cboValues_Change
    
    If cboValues.Text = "" Then
        cboValues.BackColor = &HFFFF&
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
        'set global string compare item
        gblsComp = cboValues.Text
        cboValues.BackColor = &HFF&
        cboValues.Refresh
    End If

Exit_cboValues_Change:
    Exit Sub

Err_cboValues_Change:
    MsgBox Error$
    GoTo Exit_cboValues_Change
    
End Sub

'****************************************************************************
' Name: cboValues_Click
' Purpose: A message is displayed and the background turns red if the user
'           tries to enter in a value.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub cboValues_Click()
On Error GoTo Err_cboValues_Click

    
    With cboValues
        .BackColor = &HFFFFFF
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboValues_Click:
    Exit Sub
    
Err_cboValues_Click:
    MsgBox Error$
    GoTo Exit_cboValues_Click
    
    
End Sub

'****************************************************************************
' Name: cboValues_LostFocus
' Purpose: A message is displayed and the background turns red if the user
'           tries to enter in a value.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub cboValues_LostFocus()
On Error GoTo Err_cboValues_LostFocus
    
    If cboValues.Text = "" Then
        cboValues.BackColor = &HFFFF&
    ElseIf (gblsComp = cboValues.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Request Copybook Template"
        cboValues.BackColor = &HFF&
        cboValues.SetFocus
        cboValues.Refresh
    End If
    
Exit_cboValues_LostFocus:
    Exit Sub

Err_cboValues_LostFocus:
    MsgBox Error$
    GoTo Exit_cboValues_LostFocus
    
    
End Sub

'****************************************************************************
' Name: chkImplied_Click
' Purpose: Sets the value of strImplied equal to yes or no depending on if
'           the box is checked.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub chkImplied_Click()
On Error GoTo Err_chkImplied_Click
    
    If chkImplied.Value = 1 Then
        strImplied = "Yes"
    Else
        strImplied = "No"
    End If
    
Exit_chkImplied_Click:
    Exit Sub

Err_chkImplied_Click:
    MsgBox Error$
    GoTo Exit_chkImplied_Click
    
    
End Sub

'****************************************************************************
' Name: chkPrefix88_Click
' Purpose: Sets the value of strImplied equal to yes or no depending on if
'           the box is checked.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub chkPrefix88_Click()
On Error GoTo Err_chkPrefix88_Click
    
    If chkPrefix88.Value = 1 Then
        strPrefix88 = "Yes"
    Else
        strPrefix88 = "No"
    End If
    
Exit_chkPrefix88_Click:
    Exit Sub

Err_chkPrefix88_Click:
    MsgBox Error$
    GoTo Exit_chkPrefix88_Click
    
   
End Sub

'****************************************************************************
' Name: Form_Load
' Purpose: Loads the form with the appropriate beginning information
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub Form_Load()
On Error GoTo Err_Form_Load
    
    
    'set variables
     gblBClick = False
     bRequired = False
     bAdded = False     'this will be used to indicate whether SIR has been saved or not
     strPrefix88 = "No"
     strImplied = "No"
     cboIncrement.Text = "2"
     cboInitial.Text = "3"
     
     'Load required data into appropriate combo boxes
     Call DataLoad
     
Exit_Form_Load:
    Exit Sub

Err_Form_Load:
    MsgBox Error$
    GoTo Exit_Form_Load
    
 
End Sub

Private Sub lblUser_Click()

End Sub

Private Sub mnuAddCpyBk_Click()
On Error GoTo Err_mnuAddCpyBk_Click

    Dim strTemp As String, strFileNotFndMsg As String, strMsgTitle As String
    Dim intI As Integer
    Dim strTempFile As String, strTempPath As String
    Dim intFive As Integer, intZero As Integer, intOne As Integer
    
    strTempPath = "C:\Data\Template.tmp"
    strTempFile = "TEMPLATE.TMP"
    strFileNotFndMsg = "Unable to locate SIR text file."
    strMsgTitle = "Request Copybook Template"
    intFive = 5
    intZero = 0
    intOne = 1

    strTemp = txtSirNo.Text
    
''''''''''''' Christina Mitchell TOSIRWB ''''''''''''''''''''''''''
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
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
     
    CheckFields

    If CheckFields = True Then
        
        'Returns a String representing the name of a file that matches a specified pattern or file attribute, or the volume label of a drive.
        If UCase(Dir(strTempPath)) = strTempFile Then
            'writes information to the temporary file
            SirTemplate = strTempPath
            Call WriteSirInfo
        Else
            MsgBox strFileNotFndMsg, vbInformation, strMsgTitle
        End If
                
    Else
    
        Beep
        MsgBox "Please complete all required field before adding this template.", vbOKOnly, "Request CopyBook Template"
        
   End If

Exit_mnuAddCpyBk_Click:
    Exit Sub
    
Err_mnuAddCpyBk_Click:
    MsgBox Error$
    GoTo Exit_mnuAddCpyBk_Click
    
   
   
End Sub

'****************************************************************************
' Name: mnuExit_Click
' Purpose: Displays a message allowing the user to decide if they would like to
'           exit the form or not.
'
' Created by: Dave Zimmer
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
    GoTo Exit_mnuExit_Click
    
        
End Sub

Private Sub mnuHelp_Click()

End Sub

'****************************************************************************
' Name: mnuInstructions_Click
' Purpose: Displays a notepad text file that contains the instructions on how
'           to complete a template.
'
' Created by: Dave Zimmer
' Date Created: 10/08/97
'****************************************************************************

Private Sub mnuInstructions_Click()
On Error GoTo Err_mnuInstructions_Click

' Specifying 1 as the second argument opens the application in
' normal size and gives it the focus.

    Dim strFilePath As String
    Dim strPath As String
    Dim intRetVal As Integer

    'strPath = "K:\T4\TechnologyManagement\Tools\Documentation\DTTool\WebReqCpyBk.doc"
    'strFilePath = "C:\Apps\Msoffice\Winword\Winword.exe" & " " & strPath
    
    strPath = "K:\T4\TechnologyManagement\Tools\Documentation\DTTool\WebReqCpyBk.txt"
    strFilePath = "C:\WINNT\NOTEPAD.EXE" & " " & strPath
    
    intRetVal = Shell(strFilePath, 1)    ' Run Instructions.

Exit_mnuInstructions_Click:
    Exit Sub

Err_mnuInstructions_Click:
    MsgBox Error$
    Resume Exit_mnuInstructions_Click
End Sub

'****************************************************************************
' Name: txtCpyBkNam_Change
' Purpose: Sets the background to the appropriate color depending on its contents.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************
Private Sub txtCpyBkNam_Change()
On Error GoTo Err_txtCpyBkNam_Change

        
    If txtCpyBkNam.Text = "" Then
        txtCpyBkNam.BackColor = &HFFFF&
    Else
        txtCpyBkNam.BackColor = &HFFFFFF
    End If
    
Exit_txtCpyBkNam_Change:
    Exit Sub
    
Err_txtCpyBkNam_Change:
    MsgBox Error$
    GoTo Exit_txtCpyBkNam_Change
    
    
End Sub

'****************************************************************************
' Name: txtCpyBkName_LostFocus
' Purpose: Checks to see if the first character is numeric.  If it is then a
'           message is displayed to the user and focus returns to the Copybook
'           name text field.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub txtCpyBkNam_LostFocus()
On Error GoTo Err_txtCpyBkNam_LostFocus

    Dim vHolder As Variant
    Dim Response, style
    Dim sMsg As String, sTitle As String
    
    sMsg = "The first character of a copybook name must be a letter."
    style = vbOKOnly
    sTitle = "Request Copybook Template"
    
    If txtCpyBkNam.Text = "" Then
        txtCpyBkNam.BackColor = &HFFFF&
    Else
    
       vHolder = Left(txtCpyBkNam.Text, 1)
       
       If IsNumeric(vHolder) Then
         Response = MsgBox(sMsg, style, sTitle)
         txtCpyBkNam.SetFocus
         txtCpyBkNam.SelStart = 0
         txtCpyBkNam.SelLength = 1
       End If
       
    End If
    
Exit_txtCpyBkNam_LostFocus:
    Exit Sub
    
Err_txtCpyBkNam_LostFocus:
    MsgBox Error$
    GoTo Exit_txtCpyBkNam_LostFocus
        
End Sub

Private Sub txtImage_Click()
On Error GoTo Err_txtImage_Click

    Beep

Exit_txtImage_Click:
    Exit Sub
    
Err_txtImage_Click:
    MsgBox Error$
    GoTo Exit_txtImage_Click
    
End Sub

'****************************************************************************
' Name: txtLongDesc_Change
' Purpose: Sets the background of the field to the appropriate color depending
'           on its contents.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub txtLongDesc_Change()
On Error GoTo Err_txtLongDesc_Change

    If txtLongDesc.Text = "" Then
        txtLongDesc.BackColor = &HFFFF&
    Else
        txtLongDesc.BackColor = &HFFFFFF 'set background to white when user enters text
    End If
    
Exit_txtLongDesc_Change:
    Exit Sub
    
Err_txtLongDesc_Change:
    MsgBox Error$
    GoTo Exit_txtLongDesc_Change
    
    
     
End Sub

'****************************************************************************
' Name: txtLongDesc_LostFocus
' Purpose: Sets the background of the field to yellow if it is blank.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub txtLongDesc_LostFocus()
On Error GoTo Err_txtLongDesc_LostFocus
    
    'make sure that the user has entered a value, set it to yellow if nothing there
    If txtLongDesc = "" Then
        txtLongDesc.BackColor = &HFFFF&
    End If
    
Exit_txtLongDesc_LostFocus:
    Exit Sub

Err_txtLongDesc_LostFocus:
    MsgBox Error$
    GoTo Err_txtLongDesc_LostFocus
    
    
End Sub

'****************************************************************************
' Name: txtShortDesc_Change
' Purpose: Sets the background of the field to the appropriate color depending
'           on its contents.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub txtShortDesc_Change()
On Error GoTo Err_txtShortDesc_Change

    
    If txtShortDesc.Text = "" Then
        txtShortDesc.BackColor = &HFFFF&
    Else
        txtShortDesc.BackColor = &HFFFFFF ' set background to white
    End If
    
Exit_txtShortDesc_Change:
    Exit Sub
    
Err_txtShortDesc_Change:
    MsgBox Error$
    GoTo Exit_txtShortDesc_Change
    
    
End Sub

'****************************************************************************
' Name: txtShortDesc_LostFocus
' Purpose: Sets the background of the field to the appropriate color depending
'           on its contents.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub txtShortDesc_LostFocus()
On Error GoTo Err_txtShortDesc_LostFocus

    
    If txtShortDesc = "" Then
        txtShortDesc.BackColor = &HFFFF&
    End If
    
Exit_txtShortDesc_LostFocus:
    Exit Sub

Err_txtShortDesc_LostFocus:
    MsgBox Error$
    GoTo Exit_txtShortDesc_LostFocus
    
    
End Sub

Private Sub txtSirNo_Change()

'''''''''''''' Sbricker TOSIRWB '''''''''''''''''''''''''''
'On Error GoTo Err_txtSirNo_Change
'
'
'    Dim tempString As String
'
'    tempString = txtSirNo.Text
'
'    txtSirNo.BackColor = &HFFFFFF ' set background to white
'
'    If txtSirNo.Text = "" Then
'
'        'set background to required
'        txtSirNo.BackColor = &HFFFF&
'        'do nothing else let losefocus handle that
'
'    Else
'        If Not IsNumeric(tempString) Then
'            Beep
'            MsgBox "Please enter a five digit numeric value.", vbOKOnly, "Request Copybook Template"
'            txtSirNo.SetFocus
'            txtSirNo.BackColor = &HFF&
'            txtSirNo.SelStart = 0
'            txtSirNo.SelLength = Len(tempString)
'        End If
'    End If
'
'Exit_txtSirNo_Change:
'    Exit Sub
'
'Err_txtSirNo_Change:
'    MsgBox Error$
'    GoTo Exit_txtSirNo_Change
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        
End Sub

Private Sub txtSirNo_LostFocus()

'''  Sbricker TOSIRWB  '''''''''''''''''''''''''''''''''
'On Error GoTo Err_txtSirNo_LostFocus
'
'
'    Dim tempString As String
'    Dim i As Integer
'    Dim index As Integer
'
'    index = 0
'
'    txtSirNo.BackColor = &HFFFFFF 'set the background color to white
'
'    tempString = txtSirNo.Text
'
'    'if there is nothing in the string then let them tab on or move focus elsewhere
'    If txtSirNo.Text = "" Then
'        txtSirNo.BackColor = &HFFFF&
'        Exit Sub
'    End If
'
'
'    'if the value is not numeric then make them change it
'    If Not IsNumeric(tempString) Then
'
'        txtSirNo.SetFocus
'        txtSirNo.BackColor = &HFF&
'        txtSirNo.SelStart = 0
'        txtSirNo.SelLength = Len(tempString)
'        MsgBox "Please enter a five digit numeric value.", vbOKOnly, "Request Copybook Template"
'        Exit Sub
'
'    End If
'
'
'    If Len(tempString) > 5 Then
'        MsgBox "This number cannot be greater than five characters", vbOKOnly, "Data Length Error"
'        'return focus to txtSirNo and highlight entry
'        txtSirNo.SetFocus
'        txtSirNo.SelStart = 0
'        txtSirNo.SelLength = Len(tempString)
'
'    Else
'        'if txtSirNo is empty then set field back to yellow
'        If txtSirNo.Text = "" Then
'            txtSirNo.BackColor = &HFFFF&
'        Else
'            If Len(tempString) < 5 Then
'                For i = Len(tempString) + 1 To 5
'                    tempString = "0" & tempString
'                Next i
'
'                'assign the YYYYY portion of the SIR number
'                ySir = tempString
'
'            Else
'                ySir = tempString
'            End If
'
'           'redisplay txtSirNo to reflect correct number
'            txtSirNo.Text = ySir
'
'        End If
'
'    End If
'
'Exit_txtSirNo_LostFocus:
'    Exit Sub
'
'Err_txtSirNo_LostFocus:
'    MsgBox Error$
'    GoTo Exit_txtSirNo_LostFocus
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        
End Sub

'****************************************************************************
' Name: DataLoad
' Purpose: Loads the data into the combo boxes.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Public Sub DataLoad()
On Error GoTo Err_DataLoad

    
    Dim counter As Integer
    Dim myCodestable As New CodesTable
    Dim tempString As String
    Dim myStr
    Dim length As Integer
    Dim myDatabase As String
        
    myDatabase = "o:\tools\datateamtool\codestbl\Codesdat.mdb"
    
'''''''''''sbricker TOSIRWB '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'    Call LoadProc(myDatabase, cboOriging, "tblEntries", "Key", "Decode", "DEV00701", "TableName")
'    Call LoadProc(myDatabase, cboDestination, "tblEntries", "Key", "Decode", "DEV00701", "TableName")
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    myDatabase = "o:\tools\DataTeamTool\codestbl\DataTeam.mdb"
  
    Call LoadProc(myDatabase, cboCpyBkType, "tblCopyBkType", "CopyBkTypeCd", "CopyBookTypeDcd", "", , True)
    Call LoadProc(myDatabase, cboPrefix, "tblPrefix", "PrefixCd", "PrefixDcd", "", , True)
    Call LoadProc(myDatabase, cboEntity, "tblProcessType", "ProcessTypeCd", "ProcessTypeDcd", "", , True)
    Call LoadProc(myDatabase, cboValues, "tblValues", "ValuesCd", "ValuesDcd", "", , True)
    Call LoadProc(myDatabase, cboLanguage, "tblLanguage", "LanguageCd", "LanguageDcd", "", , True)
    Call LoadProc(myDatabase, cboInitial, "tblInitial", "InitialCd", "InitialDcd", "")
    Call LoadProc(myDatabase, cboIncrement, "tblIncrement", "IncrementCd", "IncrementDcd", "")
    
Exit_DataLoad:
    Exit Sub
    
Err_DataLoad:
    MsgBox Error$
    GoTo Exit_DataLoad
    
    
    
End Sub

'****************************************************************************
' Name: CheckFields
' Purpose: Checks to see if the appropriate fields have been entered with
'           information.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Public Function CheckFields() As Boolean
On Error GoTo Err_CheckFields
    
''''''''''''' Sbricker TOSIRWB ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'     If (cboOriging.Text = "") Or (cboDestination.Text = "") Or (txtSirNo.Text = "") _
'         Or (txtLongDesc.Text = "") Or (txtShortDesc.Text = "") Or (txtCpyBkNam.Text = "") _
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

     If (txtLongDesc.Text = "") Or (txtShortDesc.Text = "") Or (txtCpyBkNam.Text = "") _
        Or (cboCpyBkType.Text = "") Or (cboEntity.Text = "") Or (cboValues.Text = "") _
        Or (cboLanguage.Text = "") Or (cboInitial.Text = "") Or (cboIncrement.Text = "") Then
              CheckFields = False
    Else
    
              CheckFields = True
    End If

Exit_CheckFields:
    Exit Function

Err_CheckFields:
    MsgBox Error$
    GoTo Exit_CheckFields
    
      
End Function

'****************************************************************************
' Name: WriteSirInfo
' Purpose: Writes the information entered to the Sir Template.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Public Sub WriteSirInfo()
On Error GoTo Err_WriteSirInfo
    
  Dim Msg As String, Title As String
  Dim intStyle As Integer
  Dim Response
  
  intStyle = vbYesNo

  If FileExists(SirTemplate) Then
  
    Open SirTemplate For Append As #1


    Print #1, "                              Request Copybook Template"
    Print #1, ""
    Print #1, ""
    Print #1, ""
    Print #1, "     1. Long Description:"
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, "     "; txtLongDesc.Text
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     2. Short Description:"
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, "     "; txtShortDesc.Text
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     3. Copybook Type:"
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, "     "; cboCpyBkType.Text
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     4. Copybook Name:"
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, "     "; txtCpyBkNam.Text
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     5. Prefix:"
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, "     "; cboPrefix.Text
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     6. Suffix:"
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, "     "; txtSuffix.Text
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     7. Entity Process Type:"
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, "     "; cboEntity.Text
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     8. Values:"
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, "     "; cboValues.Text
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     9. Language:"
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, "     "; cboLanguage.Text
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     10. Image:"
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, "     "; txtImage.Text
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     11. Prefix 88-Level Items(Y/N):"
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, "     "; strPrefix88
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     12. Implied Redefinition(Y/N):"
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, "     "; strImplied
    Print #1, ""
    Print #1, "     _______________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "     13. Level Numbers:"
    Print #1, ""
    Print #1, "          Initial         Increment"
    Print #1, ""
    Print #1, "           " & cboInitial.Text & "               " & cboIncrement.Text
    Print #1, ""
    Print #1, ""
    Print #1, ""
    
    
    Close #1

    Msg = "Request CopyBook Template successfully written. Do you want to create " & _
    "another Template?"
    Title = "Request Copybook Template"
    
    Beep
    Response = MsgBox(Msg, intStyle, Title)
    
    
    If Response = vbYes Then
    
        'user wants to enter another template
        Call ResetProperties
        txtLongDesc.SetFocus
        
    Else
        'user is done, exit application
        Unload Me
        
    End If
    
        
  Else
  
    'file not found condition
    Beep
    MsgBox SirTemplate & " does not exist! Please check the Sir number and try again.", vbOKOnly, "Request Copybook Template: File Not Found"

  End If
  
    
Exit_WriteSirInfo:
    'exit procedure
    Exit Sub
        
Err_WriteSirInfo:
    'Display error message to user
    MsgBox Error$
    GoTo Exit_WriteSirInfo
        
End Sub

'****************************************************************************
' Name: txtSuffix_Change
' Purpose: Displays a message to the user if the value entered is over 4
'           characters long.
'
' Created by: Dave Zimmer
' Date Created: 09/22/97
'****************************************************************************

Private Sub txtSuffix_Change()
On Error GoTo Err_txtSuffix_Change
    
    Dim tempString As String
       
    tempString = txtSuffix.Text
         
    If Len(tempString) > 4 Then
        MsgBox ("You cannot have a suffix greater than Four characters")
        txtSuffix.SelStart = 0
        txtSuffix.SelLength = Len(tempString)
    End If
    
Exit_txtSuffix_Change:
    Exit Sub
    
Err_txtSuffix_Change:
    MsgBox Error$
    GoTo Exit_txtSuffix_Change
    
    
    
End Sub

