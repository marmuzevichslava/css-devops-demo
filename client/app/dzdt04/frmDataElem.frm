VERSION 5.00
Begin VB.Form frmDataElem 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Data Element Template"
   ClientHeight    =   6720
   ClientLeft      =   990
   ClientTop       =   1080
   ClientWidth     =   10095
   LinkTopic       =   "Form8"
   ScaleHeight     =   6720
   ScaleWidth      =   10095
   Begin VB.TextBox txtPointsToCOBOLNm 
      Height          =   315
      Left            =   8040
      MaxLength       =   18
      TabIndex        =   23
      Top             =   5880
      Width           =   1575
   End
   Begin VB.TextBox txtPointsToRecIDNo 
      Height          =   315
      Left            =   4560
      MaxLength       =   8
      TabIndex        =   22
      Top             =   5880
      Width           =   1575
   End
   Begin VB.ComboBox cboUsage 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   1200
      TabIndex        =   21
      Top             =   5880
      Width           =   1620
   End
   Begin VB.TextBox txtRptStructure 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   6480
      MaxLength       =   2
      TabIndex        =   15
      Top             =   3600
      Width           =   1575
   End
   Begin VB.TextBox txtIntStructure 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   6480
      MaxLength       =   2
      TabIndex        =   12
      Top             =   3240
      Width           =   1575
   End
   Begin VB.TextBox txtWsStructure 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   6480
      MaxLength       =   2
      TabIndex        =   9
      Top             =   2880
      Width           =   1575
   End
   Begin VB.TextBox txtRptPrecision 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   4800
      MaxLength       =   5
      TabIndex        =   14
      Top             =   3600
      Width           =   1575
   End
   Begin VB.TextBox txtIntPrecision 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   4800
      MaxLength       =   3
      TabIndex        =   11
      Top             =   3240
      Width           =   1575
   End
   Begin VB.TextBox txtWsPrecision 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   4800
      MaxLength       =   3
      TabIndex        =   8
      Top             =   2880
      Width           =   1575
   End
   Begin VB.TextBox txtRptLength 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   3120
      MaxLength       =   3
      TabIndex        =   13
      Top             =   3600
      Width           =   1575
   End
   Begin VB.TextBox txtIntLength 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   3120
      MaxLength       =   5
      TabIndex        =   10
      Top             =   3240
      Width           =   1575
   End
   Begin VB.TextBox txtWsLength 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   3120
      MaxLength       =   3
      TabIndex        =   7
      Top             =   2880
      Width           =   1575
   End
   Begin VB.TextBox txtLongDesc 
      BackColor       =   &H0000FFFF&
      Height          =   795
      Left            =   360
      MaxLength       =   300
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   480
      Width           =   9375
   End
   Begin VB.TextBox txtShortDesc 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   2280
      MaxLength       =   25
      TabIndex        =   4
      Top             =   1440
      Width           =   4575
   End
   Begin VB.TextBox txtLiteral 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   1320
      MaxLength       =   18
      TabIndex        =   5
      Top             =   1920
      Width           =   2655
   End
   Begin VB.TextBox txtColumnNam 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   7080
      MaxLength       =   18
      TabIndex        =   19
      Top             =   4560
      Width           =   2655
   End
   Begin VB.TextBox txtWidgetNam 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   7080
      MaxLength       =   18
      TabIndex        =   17
      Top             =   4200
      Width           =   2655
   End
   Begin VB.TextBox txtCName 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   2160
      MaxLength       =   18
      TabIndex        =   16
      Top             =   4200
      Width           =   2775
   End
   Begin VB.TextBox txtCOBOLNam 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   2160
      MaxLength       =   18
      TabIndex        =   18
      Top             =   4560
      Width           =   2775
   End
   Begin VB.TextBox txtSirNo 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   4680
      MaxLength       =   5
      TabIndex        =   1
      Top             =   7080
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.ComboBox cboDestination 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   6720
      TabIndex        =   2
      Top             =   7080
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.ComboBox cboOriging 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   2400
      TabIndex        =   0
      Top             =   7080
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.CommandButton cmdCOBOLVal 
      Caption         =   "CO&BOL Values"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   8760
      TabIndex        =   25
      Top             =   3360
      Width           =   975
   End
   Begin VB.CommandButton cmdListValues 
      Caption         =   "&List Values"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   8760
      TabIndex        =   24
      Top             =   2520
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Submit"
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
      Left            =   2760
      TabIndex        =   43
      Top             =   8880
      Width           =   1575
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Exit"
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
      Left            =   5040
      TabIndex        =   42
      Top             =   8880
      Width           =   1575
   End
   Begin VB.ComboBox cboWidgetType 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2160
      TabIndex        =   20
      Text            =   "Single Line Entry Field"
      Top             =   4920
      Width           =   2820
   End
   Begin VB.ComboBox cboDataType 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   6960
      TabIndex        =   6
      Top             =   1920
      Width           =   2820
   End
   Begin VB.Image Image2 
      BorderStyle     =   1  'Fixed Single
      Height          =   735
      Left            =   240
      Top             =   5640
      Width           =   9615
   End
   Begin VB.Label lblPRecord 
      Caption         =   "Points to COBOL Name:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6480
      TabIndex        =   50
      Top             =   5880
      Width           =   1575
   End
   Begin VB.Label lblPoints 
      Caption         =   "Points to Record ID No:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   3120
      TabIndex        =   49
      Top             =   5880
      Width           =   1335
   End
   Begin VB.Label lblUsage 
      Caption         =   "Usage:"
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
      TabIndex        =   48
      Top             =   5880
      Width           =   615
   End
   Begin VB.Label Label10 
      Caption         =   "Formats"
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
      TabIndex        =   47
      Top             =   5400
      Width           =   735
   End
   Begin VB.Line Line1 
      Visible         =   0   'False
      X1              =   -840
      X2              =   9240
      Y1              =   7560
      Y2              =   7560
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
      Left            =   6240
      TabIndex        =   46
      Top             =   7080
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
      Left            =   4200
      TabIndex        =   45
      Top             =   7080
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
      Left            =   240
      TabIndex        =   44
      Top             =   7080
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblUser 
      Caption         =   "5. Window/Screen, Internal, Report:"
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
      Index           =   8
      Left            =   1440
      TabIndex        =   41
      Top             =   2400
      Width           =   3135
   End
   Begin VB.Image Image1 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Left            =   1200
      Top             =   2520
      Width           =   7095
   End
   Begin VB.Label lblUser 
      Caption         =   "Internal"
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
      Index           =   7
      Left            =   1440
      TabIndex        =   40
      Top             =   3240
      Width           =   735
   End
   Begin VB.Label lblUser 
      Caption         =   "Window/Screen"
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
      Index           =   6
      Left            =   1440
      TabIndex        =   39
      Top             =   2880
      Width           =   1455
   End
   Begin VB.Label lblUser 
      Caption         =   "Report"
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
      Index           =   5
      Left            =   1440
      TabIndex        =   38
      Top             =   3600
      Width           =   735
   End
   Begin VB.Label lblUser 
      Caption         =   "Structure"
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
      Index           =   3
      Left            =   6480
      TabIndex        =   37
      Top             =   2640
      Width           =   855
   End
   Begin VB.Label lblUser 
      Caption         =   "Precision"
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
      Index           =   2
      Left            =   4800
      TabIndex        =   36
      Top             =   2640
      Width           =   855
   End
   Begin VB.Label lblUser 
      Caption         =   "Length"
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
      Index           =   1
      Left            =   3120
      TabIndex        =   35
      Top             =   2640
      Width           =   735
   End
   Begin VB.Label Label9 
      Caption         =   "10. Widget Type:"
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
      Left            =   360
      TabIndex        =   34
      Top             =   4920
      Width           =   1575
   End
   Begin VB.Label Label6 
      Caption         =   "8. COBOL Name:"
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
      Left            =   360
      TabIndex        =   33
      Top             =   4560
      Width           =   1695
   End
   Begin VB.Label Label4 
      Caption         =   "9. Column Name:"
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
      TabIndex        =   32
      Top             =   4560
      Width           =   1575
   End
   Begin VB.Label Label3 
      Caption         =   "6. C Name:"
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
      Left            =   360
      TabIndex        =   31
      Top             =   4200
      Width           =   975
   End
   Begin VB.Label Label2 
      Caption         =   "7. Widget Name:"
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
      TabIndex        =   30
      Top             =   4200
      Width           =   1575
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
      Left            =   360
      TabIndex        =   29
      Top             =   240
      Width           =   1815
   End
   Begin VB.Label lblShortDescription 
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
      Left            =   360
      TabIndex        =   28
      Top             =   1440
      Width           =   1815
   End
   Begin VB.Label lblUser 
      Caption         =   "3. Literal:"
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
      Index           =   0
      Left            =   360
      TabIndex        =   27
      Top             =   1920
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "4. Data Type:"
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
      TabIndex        =   26
      Top             =   1920
      Width           =   1215
   End
   Begin VB.Menu mnDataElement 
      Caption         =   "&Data Element"
      Begin VB.Menu mnProcess 
         Caption         =   "&Process Data Element"
      End
      Begin VB.Menu mnExit 
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
Attribute VB_Name = "frmDataElem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim sSpace1 As String, sSpace2 As String, sSpace3 As String, sSpace4 As String, sSpace5 As String, sSpace6 As String
Dim sSixspc As String
Dim sSpaceB1 As String, sSpaceB2 As String, sSpaceB3 As String, sSpaceB4 As String, sSpaceB5 As String, sSpaceB6 As String
Dim sSpaceC1 As String, sSpaceC2 As String, sSpaceC3 As String, sSpaceC4 As String, sSpaceC5 As String, sSpaceC6 As String
Dim sSpaceD1 As String, sSpaceD2 As String, sSpaceD3 As String, sSpaceD4 As String, sSpaceD5 As String, sSpaceD6 As String
Dim sSpaceE1 As String, sSpaceE2 As String, sSpaceE3 As String, sSpaceE4 As String, sSpaceE5 As String, sSpaceE6 As String
Dim sSixspc1 As String, sSixspc2 As String, sSixspc3 As String, sSixspc4 As String, sSixspc5 As String, sSixspc6 As String
Dim sWsLength As String, sWsPrecision As String, sRptLength As String
Dim sIntLength As String, sIntPrecision As String, sRptPrecision As String

Private Sub cboDataType_Change()
On Error GoTo Err_cboDataType_Change

    If cboDataType.Text = "" Then
        cboDataType.BackColor = &HFFFF&
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Data Element Template"
        'set global string compare item
        gblsComp = cboDataType.Text
        cboDataType.BackColor = &HFF&
        cboDataType.Refresh
    End If
    
Exit_cboDataType_Change:
    Exit Sub

Err_cboDataType_Change:
    MsgBox Error$
    Resume Exit_cboDataType_Change
    
End Sub

Private Sub cboDataType_Click()
On Error GoTo Err_cboDataType_Click

    With cboDataType
        .BackColor = &HFFFFFF
    End With
    
    'set gblsComp
    gblsComp = ""
    
Exit_cboDataType_Click:
    Exit Sub
    
Err_cboDataType_Click:
    MsgBox Error$
    Resume Err_cboDataType_Click
    
End Sub

Private Sub cboDataType_LostFocus()
On Error GoTo Err_cboDataType_LostFocus

    If cboDataType.Text = "" Then
        cboDataType.BackColor = &HFFFF&
    
    ElseIf (gblsComp = cboDataType.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Data Element Template"
        cboDataType.SetFocus
        cboDataType.BackColor = &HFF&
        cboDataType.Refresh
    
    End If
    
Exit_cboDataType_LostFocus:
    Exit Sub
    
Err_cboDataType_LostFocus:
    MsgBox Error$
    Resume Err_cboDataType_LostFocus
    
End Sub

Private Sub cboOriging_Change()
''''''''''''' Christina Mitchell TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboOriging_Change
'
'    If cboOriging.Text = "" Then
'        cboOriging.BackColor = &HFFFF&
'
'    Else
'        cboOriging.BackColor = &HFF&
'        MsgBox "Please choose a value from the list.", vbOKOnly, "Data Element Template"
'        'set global string compare item
'        gblsComp = cboOriging.Text
'        cboOriging.Refresh
'
'    End If
'
'Exit_cboOriging_Change:
'    Exit Sub
'
'Err_cboOriging_Change:
'    MsgBox Error$
'    Resume Err_cboOriging_Change
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub

Private Sub cboOriging_Click()
''''''''''''' Christina Mitchell TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboOriging_Click
'
'   'update global string compare item
'    gblsComp = ""
'
'    'set background color upon click event
'    With cboOriging
'        .BackColor = &HFFFFFF
'    End With
'
'Exit_cboOriging_Click:
'    Exit Sub
'
'Err_cboOriging_Click:
'    MsgBox Error$
'    Resume Err_cboOriging_Click
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub

Private Sub cboOriging_LostFocus()
''''''''''''' Christina Mitchell TOSIRWB ''''''''''''''''''''''''''
'On Error GoTo Err_cboOriging_LostFocus
'
'   If cboOriging.Text = "" Then
'        cboOriging.BackColor = &HFFFF&
'
'   ElseIf (gblsComp = cboOriging.Text) Then
'        cboOriging.BackColor = &HFF&
'        MsgBox "Please choose a value from the list.", vbOKOnly, "Data Element Template"
'        cboOriging.SetFocus
'        cboOriging.Refresh
'
'   End If
'
'Exit_cboOriging_LostFocus:
'    Exit Sub
'
'Err_cboOriging_LostFocus:
'    MsgBox Error$
'    Resume Err_cboOriging_LostFocus
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub

Private Sub cboUsage_Change()
On Error GoTo Err_cboUsage_Change

     If cboUsage.Text = "" Then
        cboUsage.BackColor = &HFFFF&
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Data Element Template"
        'set global string compare item
        gblsComp = cboUsage.Text
        cboUsage.BackColor = &HFF&
        cboUsage.Refresh
        
    End If
    
Exit_cboUsage_Change:
    Exit Sub
    
Err_cboUsage_Change:
    MsgBox Error$
    Resume Err_cboUsage_Change
    
End Sub

Private Sub cboUsage_Click()
On Error GoTo Err_cboUsage_Click

    With cboUsage
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboUsage_Click:
    Exit Sub
    
Err_cboUsage_Click:
    MsgBox Error$
    Resume Err_cboUsage_Click
    
End Sub

Private Sub cboUsage_LostFocus()
On Error GoTo Err_cboUsage_LostFocus

    If cboUsage.Text = "" Then
        cboUsage.BackColor = &HFFFF&
    ElseIf (gblsComp = cboUsage.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Data Element Template"
        cboUsage.BackColor = &HFF&
        cboUsage.SetFocus
        cboUsage.Refresh
    End If
    
Exit_cboUsage_LostFocus:
    Exit Sub
    
Err_cboUsage_LostFocus:
    MsgBox Error$
    Resume Err_cboUsage_LostFocus
    
End Sub

Private Sub cboWidgetType_Change()
On Error GoTo Err_cboWidgetType_Change

    If cboWidgetType.Text = "" Or cboWidgetType.Text = "Single Line Entry Field" Then
        cboWidgetType.BackColor = &HFFFFFF
        cboWidgetType.Text = "Single Line Entry Field"
    
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Data Element Template"
        cboWidgetType.BackColor = &HFF&
        'set global string compare item
        gblsComp = cboWidgetType.Text
        cboWidgetType.Refresh
        
    End If
    
Exit_cboWidgetType_Change:
    Exit Sub
    
Err_cboWidgetType_Change:
    MsgBox Error$
    Resume Err_cboWidgetType_Change
    
End Sub

Private Sub cboWidgetType_Click()
On Error GoTo Err_cboWidgetType_Click

    'update global string compare item
    gblsComp = ""
    
    cboWidgetType.BackColor = &HFFFFFF
    
Exit_cboWidgetType_Click:
    Exit Sub
    
Err_cboWidgetType_Click:
    MsgBox Error$
    Resume Err_cboWidgetType_Click
    
End Sub

Private Sub cboWidgetType_LostFocus()
On Error GoTo Err_cboWidgetType_LostFocus

    If cboWidgetType.Text = "" Then
        cboWidgetType.BackColor = &HFFFF&
        cboWidgetType.Text = "Single Line Entry Field"
    ElseIf (gblsComp = cboWidgetType.Text) Then
        cboWidgetType.BackColor = &HFF&
        MsgBox "Please choose a value from the list.", vbOKOnly, "Data Element Template"
        cboWidgetType.SetFocus
        cboWidgetType.Refresh
    End If
   
Exit_cboWidgetType_LostFocus:
    Exit Sub
    
Err_cboWidgetType_LostFocus:
    MsgBox Error$
    Resume Err_cboWidgetType_LostFocus
   
End Sub

Private Sub cmdCOBOLVal_Click()
On Error GoTo Err_cmdCOBOLVal_Click

    Screen.MousePointer = vbHourglass
    
    'hide current form and show cobol form
    frmDataElem.Hide
    frmCOBOLVal.Show
        
    Screen.MousePointer = vbNormal
    
Exit_cmdCOBOLVal_Click:
    Exit Sub
    
Err_cmdCOBOLVal_Click:
    MsgBox Error$
    Resume Err_cmdCOBOLVal_Click
    
End Sub

Private Sub cmdListValues_Click()
On Error GoTo Err_cmdListValues_Click

    Screen.MousePointer = vbHourglass
    
    'hide current form and show ListValues
    frmDataElem.Hide
    frmListValues.Show
    
    Screen.MousePointer = vbNormal

Exit_cmdListValues_Click:
    Exit Sub
    
Err_cmdListValues_Click:
    MsgBox Error$
    Resume Err_cmdListValues_Click

End Sub
Private Sub cboDestination_Change()
On Error GoTo Err_cboDestination_Change

    If cboDestination.Text = "" Then
        cboDestination.BackColor = &HFFFF&
    Else
        cboDestination.BackColor = &HFF&
        MsgBox "Please choose a value from the list.", vbOKOnly, "Data Element Template"
        'set global string compare item
        gblsComp = cboDestination.Text
        cboDestination.Refresh
    End If
    
Exit_cboDestination_Change:
    Exit Sub
    
Err_cboDestination_Change:
    MsgBox Error$
    Resume Err_cboDestination_Change
    
End Sub

Private Sub cboDestination_Click()
On Error GoTo Err_cboDestination_Click
    
    Dim strTemp As String
       
    strTemp = cboDestination.Text
    strTemp = Mid(strTemp, 2, 2)
    
    zSir = strTemp
    
    With cboDestination
        .BackColor = &HFFFFFF
    End With
    
    
    
    'update global string compare item
    gblsComp = ""
    
    strTemp = Left(strTemp, 3)
    
    zSir = strTemp
    
        
Exit_cboDestination_Click:
    Exit Sub
    
Err_cboDestination_Click:
    MsgBox Error$
    Resume Err_cboDestination_Click
    
End Sub

Private Sub cboDestination_LostFocus()
On Error GoTo Err_cboDestination_LostFocus

    If cboDestination.Text = "" Then
        cboDestination.BackColor = &HFFFF&
    
    ElseIf (gblsComp = cboDestination.Text) Then
        cboDestination.BackColor = &HFF&
        MsgBox "Please choose a value from the list.", vbOKOnly, "Data Element Template"
        cboDestination.SetFocus
        cboDestination.Refresh
    
    End If
    
Exit_cboDestination_LostFocus:
    Exit Sub
    
Err_cboDestination_LostFocus:
    MsgBox Error$
    Resume Err_cboDestination_LostFocus
    
End Sub

Public Sub DataLoad()
On Error GoTo Err_DataLoad

    Dim strDatabase As String
    
    strDatabase = "o:\Tools\DataTeamTool\codestbl\Codesdat.mdb"
    Call LoadProc(strDatabase, cboOriging, "tblEntries", "Key", "Decode", "DEV00701", "TableName")
    
    Call LoadProc(strDatabase, cboDestination, "tblEntries", "Key", "Decode", "DEV00701", "TableName")
   
    strDatabase = "o:\tools\DataTeamTool\codestbl\DataTeam.mdb"
    Call LoadProc(strDatabase, cboDataType, "tblDataType", "DataTypeCd", "DataTypeDcd", "", , True)
    Call LoadProc(strDatabase, cboWidgetType, "tblWidgetType", "WidgetTypeCd", "WidgetTypeDcd", "", , True)
    
    strDatabase = "O:\tools\DataTeamTool\codestbl\DataTeam.mdb"
    Call LoadProc(strDatabase, cboUsage, "tblFormats", "FormatsCd", "FormatsDcd", "", , True)
    
Exit_DataLoad:
    Exit Sub
    
Err_DataLoad:
    MsgBox Error$
    Resume Err_DataLoad

End Sub

Private Sub Form_Load()
On Error GoTo Err_Form_Load

    Call DataLoad
    
Exit_Form_Load:
    Exit Sub
    
Err_Form_Load:
    MsgBox Error$
    Resume Err_Form_Load
    
End Sub



Private Sub mnExit_Click()
On Error GoTo Err_mnExit_Click
 
    Dim strMsg As String, strTitle As String
    Dim intStyle, intResponse As Integer
        
    intStyle = vbYesNo
    strTitle = "Request Copybook Template"
    strMsg = "Unable to save changes, return to form?"
    
    If CheckFields Then
        intResponse = MsgBox(strMsg, intStyle, strTitle)
        
        If intResponse = vbNo Then
            Unload Me
            Unload frmListValues
            Unload frmCOBOLVal
            
        Else
            'do nothing
        End If
        
    Else
         intResponse = MsgBox(strMsg, intStyle, strTitle)

         If intResponse = vbNo Then
            'user choose to exit. close current form - exit application
            Unload Me
            Unload frmListValues
            Unload frmCOBOLVal

        End If

    End If
 
Exit_mnExit_Click:
    Exit Sub
    
Err_mnExit_Click:
    MsgBox Error$
    Resume Err_mnExit_Click
        
End Sub

Private Sub mnProcess_Click()
On Error GoTo Err_mnProcess_Click

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

Exit_mnProcess_Click:
    Exit Sub
    
Err_mnProcess_Click:
    MsgBox Error$
    Resume Err_mnProcess_Click
   
End Sub

Private Sub mnuInstructions_Click()
On Error GoTo Err_mnuInstructions_Click

' Specifying 1 as the second argument opens the application in
' normal size and gives it the focus.

    Dim strFilePath As String
    Dim strPath As String
    Dim intRetVal As Integer

    'strPath = "K:\T4\TechnologyManagement\Tools\Documentation\DTTool\WebReqDE.doc"
    'strFilePath = "C:\Apps\Msoffice\Winword\Winword.exe" & " " & strPath
    
    strPath = "K:\T4\TechnologyManagement\Tools\Documentation\DTTool\WebReqDE.txt"
    strFilePath = "C:\WINNT\NOTEPAD.EXE" & " " & strPath
    
    intRetVal = Shell(strFilePath, 1)    ' Run Instructions.

Exit_mnuInstructions_Click:
    Exit Sub

Err_mnuInstructions_Click:
    MsgBox Error$
    Resume Exit_mnuInstructions_Click
End Sub

Private Sub txtCName_Change()
On Error GoTo Err_txtCName_Change

    If txtCName.Text = "" Then
        txtCName.BackColor = &HFFFF&
    Else
        txtCName.BackColor = &HFFFFFF
    End If
    
Exit_txtCName_Change:
    Exit Sub
    
Err_txtCName_Change:
    MsgBox Error$
    Resume Err_txtCName_Change
    
End Sub

Private Sub txtCName_LostFocus()
On Error GoTo Err_txtCName

    Dim strTemp As String
    Dim intThree As Integer, intTwo As Integer, intZero As Integer
    
    strTemp = txtCName.Text
    intThree = 3
    intTwo = 2
    intZero = 0
    
    'check for anything in tempString - if nothing user is moving on to different field
    If strTemp = "" Then
        'nothing has been entered, make sure background is yellow
        txtCName.BackColor = &HFFFF&
        GoTo Err_txtCName
    End If
    
    
    If Len(strTemp) < intThree And SpecialCharsChk(strTemp) Then
    
        'length does not meet requirements display error message
        MsgBox "Please enter a C Name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Data Element Template"
        txtCName.SetFocus
        txtCName.SelStart = intZero
        txtCName.SelLength = Len(strTemp)
        
    ElseIf Len(strTemp) > intTwo And SpecialCharsChk(strTemp) = True Then
    
        MsgBox "Please enter a C Name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Data Element Template"
        'set focus and highlight text
        txtCName.SetFocus
        txtCName.SelStart = intZero
        txtCName.SelLength = Len(strTemp)
        
    ElseIf Len(strTemp) < intThree And SpecialCharsChk(strTemp) = False Then
                 
         MsgBox "Please enter a C Name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Data Element Template"
         'set focus and highlight text
         txtCName.SetFocus
         txtCName.SelStart = intZero
         txtCName.SelLength = Len(strTemp)
        
    End If
    
Exit_txtCName:
    Exit Sub
       
Err_txtCName:
    GoTo Exit_txtCName
       
End Sub



Private Sub txtCobolNam_Change()
On Error GoTo Err_txtCOBOLNam_Change

    If txtCobolNam.Text = "" Then
        txtCobolNam.BackColor = &HFFFF& ' set color to yellow
    Else
        txtCobolNam.BackColor = &HFFFFFF 'set color to white
    End If
    
Exit_txtCOBOLNam_Change:
    Exit Sub
    
Err_txtCOBOLNam_Change:
    MsgBox Error$
    Resume Err_txtCOBOLNam_Change
    
End Sub

Private Sub txtCobolNam_LostFocus()
On Error GoTo Err_txtCOBOLNam

    
    Dim strTemp As String
    Dim intDash As Integer, intFour As Integer, intFive As Integer
    
    'set iDash to ascii value of character that is ok to be found in the String
    intDash = 45
    intFour = 4
        
    strTemp = txtCobolNam.Text
    
    
    If strTemp = "" Then
        txtCobolNam.BackColor = &HFFFF&
        Exit Sub
    End If
    
    
    If Len(strTemp) < intFour Then
         MsgBox "Please enter a COBOL Name between 4 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Data Element Template"
         txtCobolNam.SetFocus
         txtCobolNam.SelStart = 0
         txtCobolNam.SelLength = Len(strTemp)
         Exit Sub
         
    ElseIf Len(strTemp) >= intFour And SpecialCharsChk(strTemp, intDash, True) Then
    
         MsgBox "Please enter a COBOL Name between 4 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Data Element Template"
         txtCobolNam.SetFocus
         txtCobolNam.SelStart = 0
         txtCobolNam.SelLength = Len(strTemp)
         Exit Sub
       
   End If
        
   txtCobolNam.Text = UCase(strTemp)
        
               
Exit_txtCOBOLNam:
    Exit Sub

Err_txtCOBOLNam:
    GoTo Exit_txtCOBOLNam
    
End Sub

Private Sub txtColumnNam_Change()
On Error GoTo Err_txtColumnNam_Change

    If txtColumnNam.Text = "" Then
        txtColumnNam.BackColor = &HFFFF&
    Else
        txtColumnNam.BackColor = &HFFFFFF
    End If
    
Exit_txtColumnNam_Change:
    Exit Sub
    
Err_txtColumnNam_Change:
    MsgBox Error$
    Resume Err_txtColumnNam_Change
    
End Sub

Private Sub txtColumnNam_LostFocus()
On Error GoTo Err_txtColumnnam
    
    Dim strTemp As String
    Dim intThree As Integer
    Dim iTwo As Integer
    
    strTemp = txtColumnNam.Text
    intThree = 3
    iTwo = 2
    
    'check tempString for nothing
    If strTemp = "" Then
        'make sure background is yellow
        txtColumnNam.BackColor = &HFFFF&
        GoTo Err_txtColumnnam
    End If
    
    
    If Len(strTemp) < intThree Then
    
        'length does not meet requirements display error message
        MsgBox "Please enter a Column Name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Data Element Template"
        txtColumnNam.SetFocus
        txtColumnNam.SelStart = 0
        txtColumnNam.SelLength = Len(strTemp)
        
    ElseIf Len(strTemp) > iTwo And SpecialCharsChk(strTemp) Then
        
        MsgBox "Please enter a Column Name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Data Element Template"
        txtColumnNam.SetFocus
        txtColumnNam.SelStart = 0
        txtColumnNam.SelLength = Len(strTemp)
         
    End If
    
Exit_txtColumnNam:
    Exit Sub
    
Err_txtColumnnam:
    GoTo Exit_txtColumnNam
End Sub

Private Sub txtIntLength_Change()
On Error GoTo Err_txtIntLength_Change

    Dim strTemp As String
    
    strTemp = txtIntLength.Text
    
    'set background to white
    txtIntLength.BackColor = &HFFFFFF
        
    'check first for any data
    If txtIntLength.Text = "" Then
    
        'Nothing here set back to required color
        txtIntLength.BackColor = &HFFFF&
        
    Else
        'check for numeric value while entering
        If Not IsNumeric(strTemp) Then
            txtIntLength.BackColor = &HFF&
            MsgBox "Please enter a numeric value no greater than five digits.", vbOKOnly, "Data Element Template"
            txtIntLength.SetFocus
            txtIntLength.SelStart = 0
            txtIntLength.SelLength = Len(strTemp)
        End If
        
    End If
    
Exit_txtIntLength_Change:
    Exit Sub
    
Err_txtIntLength_Change:
    MsgBox Error$
    Resume Err_txtIntLength_Change
    
End Sub

Private Sub txtIntLength_LostFocus()
On Error GoTo Err_txtIntLength_LostFocus

    Dim strTemp As String
         
    strTemp = txtIntLength.Text
    
    If strTemp = "" Then
        
        'length is 0 set color to required
        txtIntLength.BackColor = &HFFFF&
        txtIntLength.Text = ""
        
    Else
        'check for numeric value while entering
        If Not IsNumeric(strTemp) Then
            txtIntLength.BackColor = &HFF&
            MsgBox "Please enter a numeric value no greater than five digits.", vbOKOnly, "Data Element Template"
            txtIntLength.SetFocus
            txtIntLength.SelStart = 0
            txtIntLength.SelLength = Len(strTemp)
        End If
        
    End If
    
Exit_txtIntLength_LostFocus:
    Exit Sub
    
Err_txtIntLength_LostFocus:
    MsgBox Error$
    Resume Err_txtIntLength_LostFocus
    
End Sub

Private Sub txtIntPrecision_Change()
On Error GoTo Err_txtIntPrecision_Change

    Dim strString As String
    Dim intZero As Integer
    
    strString = txtIntPrecision.Text
    
    If txtIntPrecision.Text = "" Then
    
        txtIntPrecision.BackColor = &HFFFF&
        
    Else
    
         If Not IsNumeric(strString) Then
            txtIntPrecision.BackColor = &HFF&
            MsgBox "Please enter a numeric value no greater than three digits.", vbOKOnly, "Data Element Template"
            txtIntPrecision.SetFocus
            txtIntPrecision.SelStart = intZero
            txtIntPrecision.SelLength = Len(strString)
        End If
        
        txtIntPrecision.BackColor = &HFFFFFF
    End If
    
Exit_txtIntPrecision_Change:
    Exit Sub
    
Err_txtIntPrecision_Change:
    MsgBox Error$
    Resume Err_txtIntPrecision_Change
    
End Sub

Private Sub txtIntPrecision_LostFocus()
On Error GoTo Err_txtIntPrecision_LostFocus

    Dim strTemp As String
         
    strTemp = txtIntPrecision.Text
    
    If strTemp = "" Then
        
        'length is 0 set color to required
        txtIntPrecision.BackColor = &HFFFF&
        txtIntPrecision.Text = ""
        
    Else
        'check for numeric value while entering
        If Not IsNumeric(strTemp) Then
            txtIntPrecision.BackColor = &HFF&
            MsgBox "Please enter a numeric value no greater than three digits.", vbOKOnly, "Data Element Template"
            txtIntPrecision.SetFocus
            txtIntPrecision.SelStart = 0
            txtIntPrecision.SelLength = Len(strTemp)
        End If
        
    End If
    
Exit_txtIntPrecision_LostFocus:
    Exit Sub
    
Err_txtIntPrecision_LostFocus:
    MsgBox Error$
    Resume Err_txtIntPrecision_LostFocus

End Sub

Private Sub txtIntStructure_Change()
On Error GoTo Err_txtIntStructure_Change

    Dim strString As String

    strString = txtIntStructure.Text
        
    If txtIntStructure.Text = "" Then
    
        txtIntStructure.BackColor = &HFFFF&
        
    Else
    
        txtIntStructure.BackColor = &HFFFFFF
        If SpecialCharsChk(strString) Then
            MsgBox "Please enter an alphanumeric value no greater than two characters.", vbOKOnly, "Data Element Template"
            txtIntStructure.SetFocus
            txtIntStructure.SelStart = 0
            txtIntStructure.SelLength = Len(strString)
        End If
        
        
    End If
    
Exit_txtIntStructure_Change:
    Exit Sub
    
Err_txtIntStructure_Change:
    MsgBox Error$
    Resume Err_txtIntStructure_Change
    
End Sub

Private Sub txtIntStructure_LostFocus()
On Error GoTo Err_txtIntStructure_LostFocus

    Dim strString As String
    
    strString = txtIntStructure.Text
        
    If txtIntStructure.Text = "" Then
    
        txtIntStructure.BackColor = &HFFFF&
        
    Else
    
        txtIntStructure.BackColor = &HFFFFFF
        If SpecialCharsChk(strString) Then
            MsgBox "Please enter an alphanumeric value no greater than two characters.", vbOKOnly, "Data Element Template"
            txtIntStructure.SetFocus
            txtIntStructure.SelStart = 0
            txtIntStructure.SelLength = Len(strString)
        End If
        
        
    End If

Exit_txtIntStructure_LostFocus:
    Exit Sub
    
Err_txtIntStructure_LostFocus:
    MsgBox Error$
    Resume Err_txtIntStructure_LostFocus

End Sub

Private Sub txtLiteral_Change()
On Error GoTo Err_txtLiteral_Change
    
    Dim strTemp As String
    Dim intZero As Integer
    
    strTemp = txtLiteral.Text
    intZero = 0
    
    If txtLiteral.Text = "" Then
         txtLiteral.BackColor = &HFFFF&
    Else
        txtLiteral.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strTemp) = True Then
         MsgBox "Please enter a literal that does not contain special characters.", vbOKOnly, "Data Element Template"
         'set focus and highlight text
         txtLiteral.SetFocus
         txtLiteral.SelStart = intZero
         txtLiteral.SelLength = Len(strTemp)
        
    End If
    
Exit_txtLiteral_Change:
    Exit Sub
    
Err_txtLiteral_Change:
    MsgBox Error$
    Resume Err_txtLiteral_Change
    
End Sub

Private Sub txtLiteral_LostFocus()
On Error GoTo Err_txtLiteral_LostFocus

    Dim strTemp As String
    Dim intZero As Integer
    
    strTemp = txtLiteral.Text
    intZero = 0
    
    If SpecialCharsChk(strTemp) = True Then
         MsgBox "Please enter a literal that does not contain special characters.", vbOKOnly, "Data Element Template"
         'set focus and highlight text
         txtLiteral.SetFocus
         txtLiteral.SelStart = intZero
         txtLiteral.SelLength = Len(strTemp)
        
    End If

Exit_txtLiteral_LostFocus:
    Exit Sub

Err_txtLiteral_LostFocus:
    MsgBox Error$
    Resume Exit_txtLiteral_LostFocus
    
End Sub

Private Sub txtPointsToCOBOLNm_Change()
On Error GoTo Err_txtCOBOLNam_Change

    If txtCobolNam.Text = "" Then
        txtCobolNam.BackColor = &HFFFFFF 'set color to white
    End If
    
Exit_txtCOBOLNam_Change:
    Exit Sub
    
Err_txtCOBOLNam_Change:
    MsgBox Error$
    Resume Err_txtCOBOLNam_Change
    
End Sub

Private Sub txtPointsToCOBOLNm_LostFocus()
On Error GoTo Err_txtPointsToCOBOLNm_LostFocus

    
    Dim strTemp As String
    Dim intDash As Integer, intFour As Integer, intFive As Integer
    
    'set iDash to ascii value of character that is ok to be found in the String
    intDash = 45
    intFour = 4
    intFive = 5
    
    strTemp = txtPointsToCOBOLNm.Text
    
    
    If strTemp = "" Then
        txtPointsToCOBOLNm.BackColor = &HFFFFFF
        Exit Sub
    End If
    
    
    If Len(strTemp) < intFour Then
         MsgBox "Please enter a COBOL Name between 4 and 18 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
         txtPointsToCOBOLNm.SetFocus
         txtPointsToCOBOLNm.SelStart = 0
         txtPointsToCOBOLNm.SelLength = Len(strTemp)
         Exit Sub
         
    ElseIf Len(strTemp) >= intFour And SpecialCharsChk(strTemp, intDash, True) Then
    
         MsgBox "Please enter a COBOL Name between 4 and 18 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
         txtPointsToCOBOLNm.SetFocus
         txtPointsToCOBOLNm.SelStart = 0
         txtPointsToCOBOLNm.SelLength = Len(strTemp)
         Exit Sub
       
    End If
        
    txtPointsToCOBOLNm.Text = UCase(strTemp)
        
Exit_txtPointsToCOBOLNm_LostFocus:
    Exit Sub

Err_txtPointsToCOBOLNm_LostFocus:
    MsgBox Error$
    Resume Exit_txtPointsToCOBOLNm_LostFocus
    
               
End Sub

Private Sub txtPointsToRecIDNo_Change()
On Error GoTo Err_txtPointsToRecIDNo_Change
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtPointsToRecIDNo.Text
    intZero = 0
    
    If txtPointsToRecIDNo.Text = "" Then
        txtPointsToRecIDNo.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 8 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtPointsToRecIDNo.SetFocus
            txtPointsToRecIDNo.SelStart = intZero
            txtPointsToRecIDNo.SelLength = Len(strString)
    End If

Exit_txtPointsToRecIDNo_Change:
    Exit Sub

Err_txtPointsToRecIDNo_Change:
    MsgBox Error$
    Resume Exit_txtPointsToRecIDNo_Change
    
End Sub

Private Sub txtPointsToRecIDNo_LostFocus()
On Error GoTo Err_txtPointsToRecIDNo_LostFocus
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtPointsToRecIDNo.Text
    intZero = 0
    
    If txtPointsToRecIDNo.Text = "" Then
        txtPointsToRecIDNo.BackColor = &HFFFFFF
    End If
        
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 8 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtPointsToRecIDNo.SetFocus
            txtPointsToRecIDNo.SelStart = intZero
            txtPointsToRecIDNo.SelLength = Len(strString)
    End If

Exit_txtPointsToRecIDNo_LostFocus:
    Exit Sub

Err_txtPointsToRecIDNo_LostFocus:
    MsgBox Error$
    Resume Exit_txtPointsToRecIDNo_LostFocus
    
End Sub

Private Sub txtRptLength_Change()
On Error GoTo Err_txtRptLength_Change

    Dim strTemp As String
    Dim intZero As Integer
    
    strTemp = txtRptLength.Text
    
    'set background to white
    txtRptLength.BackColor = &HFFFFFF
        
    'check first for any data
    If txtRptLength.Text = "" Then
    
        'Nothing here set back to required color
        txtRptLength.BackColor = &HFFFF&
        
    Else
        'check for numeric value while entering
        If Not IsNumeric(strTemp) Then
            MsgBox "Please enter a numeric value no greater than three digits.", vbOKOnly, "Data Element Template"
            txtRptLength.SetFocus
            txtRptLength.SelStart = intZero
            txtRptLength.SelLength = Len(strTemp)
        End If
        
    End If
    
Exit_txtRptLength_Change:
    Exit Sub
    
Err_txtRptLength_Change:
    MsgBox Error$
    Resume Err_txtRptLength_Change
    
End Sub

Private Sub txtRptLength_LostFocus()
On Error GoTo Err_txtRptLength_LostFocus
   
    Dim strTemp As String
    Dim intZero As Integer
    
    intZero = 0
    strTemp = txtRptLength.Text
   
    If strTemp = "" Then
        'length is 0 set color to required
        txtRptLength.BackColor = &HFFFF&
        txtRptLength.Text = ""
    
    Else
        
        'check for numeric value while entering
        If Not IsNumeric(strTemp) Then
            MsgBox "Please enter a numeric value no greater than three digits.", vbOKOnly, "Data Element Template"
            txtRptLength.SetFocus
            txtRptLength.SelStart = intZero
            txtRptLength.SelLength = Len(strTemp)
        End If
        
    
    End If
    
Exit_txtRptLength_LostFocus:
    Exit Sub
    
Err_txtRptLength_LostFocus:
    MsgBox Error$
    Resume Err_txtRptLength_LostFocus
    
End Sub

Private Sub txtRptPrecision_Change()
On Error GoTo Err_txtRptPrecision_Change

    Dim strString As String
    
    strString = txtRptPrecision.Text
        
    If txtRptPrecision.Text = "" Then
        txtRptPrecision.BackColor = &HFFFF&
    Else
    
        If Not IsNumeric(strString) Then
            MsgBox "Please enter a numeric value no greater than five digits.", vbOKOnly, "Data Element Template"
            txtRptPrecision.SetFocus
            txtRptPrecision.SelStart = 0
            txtRptPrecision.SelLength = Len(strString)
        End If
        
        txtRptPrecision.BackColor = &HFFFFFF ' set background to white
        
    End If
    
Exit_txtRptPrecision_Change:
    Exit Sub
    
Err_txtRptPrecision_Change:
    MsgBox Error$
    Resume Err_txtRptPrecision_Change
    
End Sub

Private Sub txtRptPrecision_LostFocus()
On Error GoTo Err_txtRptPrecision_LostFocus

    Dim strTemp As String
    Dim intZero As Integer

    strTemp = txtRptPrecision.Text
    intZero = 0
    
    If strTemp = "" Then
        'length is 0 set color to required
        txtRptPrecision.BackColor = &HFFFF&
        txtRptPrecision.Text = ""
    
    Else
        
        'check for numeric value while entering
        If Not IsNumeric(strTemp) Then
            MsgBox "Please enter a numeric value no greater than five digits.", vbOKOnly, "Data Element Template"
            txtRptPrecision.SetFocus
            txtRptPrecision.SelStart = intZero
            txtRptPrecision.SelLength = Len(strTemp)
        End If
        
    
    End If

Exit_txtRptPrecision_LostFocus:
    Exit Sub
    
Err_txtRptPrecision_LostFocus:
    MsgBox Error$
    Resume Err_txtRptPrecision_LostFocus
    
End Sub

Private Sub txtRptStructure_Change()
On Error GoTo Err_txtRptStructure_Change

    Dim strString As String
    
    strString = txtRptStructure.Text
    
    If txtRptStructure.Text = "" Then
    
        txtRptStructure.BackColor = &HFFFF&
        
    Else
        
        If SpecialCharsChk(strString) Then
            MsgBox "Please enter an alphanumeric value no greater than two characters.", vbOKOnly, "Data Element Template"
            txtRptStructure.SetFocus
            txtRptStructure.SelStart = 0
            txtRptStructure.SelLength = Len(strString)
        End If
        
        txtRptStructure.BackColor = &HFFFFFF
    End If
    
Exit_txtRptStructure_Change:
    Exit Sub
    
Err_txtRptStructure_Change:
    MsgBox Error$
    Resume Err_txtRptStructure_Change
    
End Sub

Private Sub txtRptStructure_LostFocus()
On Error GoTo Err_txtRptStructure_LostFocus

    Dim strString As String
    
    strString = txtRptStructure.Text
    
    If txtRptStructure.Text = "" Then
    
        txtRptStructure.BackColor = &HFFFF&
        
    Else
        
        If SpecialCharsChk(strString) Then
            MsgBox "Please enter an alphanumeric value no greater than two characters.", vbOKOnly, "Data Element Template"
            txtRptStructure.SetFocus
            txtRptStructure.SelStart = 0
            txtRptStructure.SelLength = Len(strString)
        End If
        
        txtRptStructure.BackColor = &HFFFFFF
    End If
    
Exit_txtRptStructure_LostFocus:
    Exit Sub
    
Err_txtRptStructure_LostFocus:
    MsgBox Error$
    Resume Err_txtRptStructure_LostFocus
    
End Sub

Private Sub txtSirNo_Change()
On Error GoTo Err_txtSirNo_Change

    Dim strString As String
    
    strString = txtSirNo.Text
    
    txtSirNo.BackColor = &HFFFFFF ' set background to white
    
    If txtSirNo.Text = "" Then
    
        'Change color to yellow
        txtSirNo.BackColor = &HFFFF&
        'do nothing let losefocus handle the rest of the validation
        
    Else
        If Not IsNumeric(strString) Then
            txtSirNo.BackColor = &HFF&
            MsgBox "Please enter a five digit numeric value.", vbOKOnly, "Data Element Template"
            txtSirNo.SelStart = 0
            txtSirNo.SelLength = Len(strString)
        End If
    End If
    
Exit_txtSirNo_Change:
    Exit Sub
    
Err_txtSirNo_Change:
    MsgBox Error$
    Resume Err_txtSirNo_Change
    
End Sub

Private Sub txtSirNo_LostFocus()
On Error GoTo Err_txtSirNo_LostFocus

    Dim strString As String
    Dim intI As Integer
    Dim intFive As Integer, intZero As Integer
    
    intFive = 5
    
    txtSirNo.BackColor = &HFFFFFF 'set the background color to white
    
    strString = txtSirNo.Text
    
    'First check to see if anything is there.
    
    If strString = "" Then
        txtSirNo.BackColor = &HFFFF&
        Exit Sub
    End If
    
        
    
    'First check to make sure there are only numbers in this field
    If Not IsNumeric(strString) Then
    
        txtSirNo.BackColor = &HFF&
        MsgBox "Please enter a five digit numeric value.", vbOKOnly, "Data Element Template"
        txtSirNo.SetFocus
        txtSirNo.SelStart = intZero
        txtSirNo.SelLength = Len(strString)
        Exit Sub
        
    End If
    
        
    If Len(strString) > intFive Then
        MsgBox "This number cannot be greater than five characters", vbOKOnly, "Data Element Template"
        'return focus to txtSirNo and highlight entry
        txtSirNo.SetFocus
        txtSirNo.SelStart = intZero
        txtSirNo.SelLength = Len(strString)
        
    Else
        'if txtSirNo is empty then set field back to yellow
        If txtSirNo.Text = "" Then
            txtSirNo.BackColor = &HFFFF&
        Else
            If Len(strString) < intFive Then
                For intI = Len(strString) + 1 To intFive
                    strString = intZero & strString
                Next intI
            
                'assign the YYYYY portion of the SIR number
                ySir = strString
            
            Else
            
                ySir = strString
                
            End If
        
           'redisplay txtSirNo to reflect correct number
            txtSirNo.Text = ySir
        
        End If
                        
    End If
    
Exit_txtSirNo_LostFocus:
    Exit Sub
    
Err_txtSirNo_LostFocus:
    MsgBox Error$
    Resume Err_txtSirNo_LostFocus
    
End Sub
Private Sub txtLongDesc_Change()
On Error GoTo Err_txtLongDesc_Change

    If txtLongDesc.Text = "" Then
        txtLongDesc.BackColor = &HFFFF&  'set background to yellow
    Else
        txtLongDesc.BackColor = &HFFFFFF 'set background to white when user enters text
    End If
    
Exit_txtLongDesc_Change:
    Exit Sub
    
Err_txtLongDesc_Change:
    MsgBox Error$
    Resume Err_txtLongDesc_Change
     
End Sub

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
    Resume Err_txtLongDesc_LostFocus
    
End Sub

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
    Resume Err_txtShortDesc_Change
    
End Sub

Private Sub txtShortDesc_LostFocus()
On Error GoTo Err_txtShortDesc_LostFocus

    If txtShortDesc = "" Then
        txtShortDesc.BackColor = &HFFFF&
    End If
    
Exit_txtShortDesc_LostFocus:
    Exit Sub
    
Err_txtShortDesc_LostFocus:
    MsgBox Error$
    Resume Err_txtShortDesc_LostFocus
    
End Sub

Private Sub txtWidgetNam_Change()
On Error GoTo Err_txtWidgetNam_Change

    If txtWidgetNam.Text = "" Then
        txtWidgetNam.BackColor = &HFFFF&
    Else
        txtWidgetNam.BackColor = &HFFFFFF
    End If

Exit_txtWidgetNam_Change:
    Exit Sub
    
Err_txtWidgetNam_Change:
    MsgBox Error$
    Resume Err_txtWidgetNam_Change
    
End Sub

Private Sub txtWsLength_Change()
On Error GoTo Err_txtWsLength_Change

    Dim strTemp As String
    
    strTemp = txtWsLength.Text
    
    'set background to white
    txtWsLength.BackColor = &HFFFFFF
        
    'check first for any data
    If txtWsLength.Text = "" Then
    
        'Nothing here set back to required color
        txtWsLength.BackColor = &HFFFF&
        
    Else
        'check for numeric value while entering
        If Not IsNumeric(strTemp) Then
            MsgBox "Please enter a numeric value no greater than three digits.", vbOKOnly, "Data Element Template"
            txtWsLength.SetFocus
            txtWsLength.SelStart = 0
            txtWsLength.SelLength = Len(strTemp)
        End If
        
    End If
    
Exit_txtWsLength_Change:
    Exit Sub
    
Err_txtWsLength_Change:
    MsgBox Error$
    Resume Err_txtWsLength_Change
    
    
End Sub

Private Sub txtWsLength_LostFocus()
On Error GoTo Err_txtWsLength_LostFocus

    Dim strTemp As String
          
    strTemp = txtWsLength.Text
    
    If txtWsLength.Text = "" Then
        'length is 0 set color to required
         txtWsLength.BackColor = &HFFFF&
         txtWsLength.Text = ""
    Else
        'check for numeric value while entering
        If Not IsNumeric(strTemp) Then
            MsgBox "Please enter a numeric value no greater than three digits.", vbOKOnly, "Data Element Template"
            txtWsLength.SetFocus
            txtWsLength.SelStart = 0
            txtWsLength.SelLength = Len(strTemp)
        End If
       
    End If
            
Exit_txtWsLength_LostFocus:
    Exit Sub
    
Err_txtWsLength_LostFocus:
    MsgBox Error$
    Resume Err_txtWsLength_LostFocus
            
End Sub

Private Sub txtWsPrecision_Change()
On Error GoTo Err_txtWsPrecision_Change

    Dim strString As String
    Dim intZero As Integer
    
    strString = txtWsPrecision.Text
    intZero = 0
    
    If txtWsPrecision.Text = "" Then
    
        txtWsPrecision.BackColor = &HFFFF&
        
    Else
        
        txtWsPrecision.BackColor = &HFFFFFF
        
        If Not IsNumeric(strString) Then
            MsgBox "Please enter a numeric value no greater than three digits.", vbOKOnly, "Data Element Template"
            txtWsPrecision.SetFocus
            txtWsPrecision.SelStart = intZero
            txtWsPrecision.SelLength = Len(strString)
        End If
        
    End If
    
Exit_txtWsPrecision_Change:
    Exit Sub
    
Err_txtWsPrecision_Change:
    MsgBox Error$
    Resume Err_txtWsPrecision_Change
    
End Sub

Private Sub txtWsPrecision_LostFocus()
On Error GoTo Err_txtWsPrecision_LostFocus

    Dim strTemp As String
          
    strTemp = txtWsPrecision.Text
    
    If txtWsPrecision.Text = "" Then
        'length is 0 set color to required
         txtWsPrecision.BackColor = &HFFFF&
         txtWsPrecision.Text = ""
    Else
        'check for numeric value while entering
        If Not IsNumeric(strTemp) Then
            MsgBox "Please enter a numeric value no greater than three digits.", vbOKOnly, "Data Element Template"
            txtWsPrecision.SetFocus
            txtWsPrecision.SelStart = 0
            txtWsPrecision.SelLength = Len(strTemp)
        End If
       
    End If
            
Exit_txtWsPrecision_LostFocus:
    Exit Sub
    
Err_txtWsPrecision_LostFocus:
    MsgBox Error$
    Resume Err_txtWsPrecision_LostFocus

End Sub

Private Sub txtWsStructure_Change()
On Error GoTo Err_txtWsStructure_Change
    Dim strString As String
    
    strString = txtWsStructure.Text
    
    If txtWsStructure.Text = "" Then
    
        txtWsStructure.BackColor = &HFFFF&
        
    Else
        
        txtWsStructure.BackColor = &HFFFFFF
         
        If SpecialCharsChk(strString) Then
            MsgBox "Please enter an alphanumeric value no greater than two characters.", vbOKOnly, "Data Element Template"
            txtWsStructure.SetFocus
            txtWsStructure.SelStart = 0
            txtWsStructure.SelLength = Len(strString)
        End If
        
       
    End If
    
Exit_txtWsStructure_Change:
    Exit Sub
    
Err_txtWsStructure_Change:
    MsgBox Error$
    Resume Err_txtWsStructure_Change
    
End Sub

'***********************************************************************************
'Function/Procedure: CheckFields
'
'Date Written: 09/22/97
'
'Author: David Zimmer
'
'Purpose: this procedure validates that all required fields have been entered.
'         and returns a boolean value to indicate success or failure.
'
'***********************************************************************************
Public Function CheckFields() As Boolean
On Error GoTo Err_checkfields
    
''''''''''''' Christina Mitchell TOSIRWB '''''''''''''''''''''''''''''''''''''''''''''''''''
'     If (cboOriging.Text = "") Or (cboDestination.Text = "") Or (txtSirNo.Text = "") _
'   This needs to be added into the if stmt when sir wb is taken out
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    
    If (txtLongDesc.Text = "") Or (txtShortDesc.Text = "") Or (cboDataType.Text = "") _
        Or (cboWidgetType.Text = "") Or (txtCName.Text = "") Or (txtCobolNam.Text = "") _
        Or (txtColumnNam.Text = "") Or (txtIntLength.Text = "") Or (txtIntPrecision.Text = "") _
        Or (txtIntStructure.Text = "") Or (txtLiteral.Text = "") Or (txtRptLength.Text = "") _
        Or (txtRptPrecision.Text = "") Or (txtRptStructure.Text = "") Or (txtWidgetNam.Text = "") _
        Or (txtWsLength.Text = "") Or (txtWsPrecision.Text = "") Or (txtWsStructure.Text = "") Or (cboUsage.Text = "") Then
            
            'not all fields were filled in
            CheckFields = False
            
    Else
        'required fields were filled in
        CheckFields = True
        
    End If

Exit_CheckFields:
    Exit Function
    
Err_checkfields:
    GoTo Exit_CheckFields
    
      
End Function

'***********************************************************************************
'Function/Procedure: WriteSirInfo
'
'Date Written: 09/21/97
'
'Author: David Zimmer
'
'Purpose: this procedure writes the information obtained from the forms to a flat
'         text file. If the file exists then this information is appended to it,
'         if the file does not exist an errormessage is displayed to the user.
'         Also the user is given the option to make another template or to exit
'         the application.
'
'***********************************************************************************

Public Sub WriteSirInfo()
On Error GoTo Err_WriteSirInfo

    Dim strMsg As String, strTitle As String
    Dim cControl As Control
    Dim intResponse, intStyle As Integer
    
    intStyle = vbYesNo
        
        
    'The following space declarations are used to help in the formatting of the file
    'must investigate to see if there is a better way to do this.
    
    sSixspc1 = "      "
    sSixspc2 = "      "
    sSixspc3 = "      "
    sSixspc4 = "      "
    sSixspc5 = "      "
    sSixspc6 = "      "
            
    sSpace1 = "                                          "
    sSpace2 = "                                          "
    sSpace3 = "                                          "
    sSpace4 = "                                          "
    sSpace5 = "                                          "
    sSpace6 = "                                          "
    
    sSpaceB1 = "         "
    sSpaceB2 = "         "
    sSpaceB3 = "         "
    sSpaceB4 = "         "
    sSpaceB5 = "         "
    sSpaceB6 = "         "
    
    sSpaceC1 = "            "
    sSpaceC2 = "            "
    sSpaceC3 = "            "
    sSpaceC4 = "            "
    sSpaceC5 = "            "
    sSpaceC6 = "            "
    
    sSpaceD1 = "        "
    sSpaceD2 = "        "
    sSpaceD3 = "        "
    sSpaceD4 = "        "
    sSpaceD5 = "        "
    sSpaceD6 = "        "
    
    sSpaceE1 = "          "
    sSpaceE2 = "          "
    sSpaceE3 = "          "
    sSpaceE4 = "          "
    sSpaceE5 = "          "
    sSpaceE6 = "          "
    
    sWsLength = "           " '11 spaces
    sIntLength = "           " '11 spaces
    sRptLength = "           " ' ''
    sWsPrecision = "              "   '14 spaces
    sIntPrecision = "              "
    sRptPrecision = "              "
    
    
    
    sSpace1 = Mid(sSpace1, 1, Len(sSpace1) - Len(frmListValues.txtLiteral1.Text))
    sSpace2 = Mid(sSpace2, 1, Len(sSpace2) - Len(frmListValues.txtLiteral2.Text))
    sSpace3 = Mid(sSpace3, 1, Len(sSpace3) - Len(frmListValues.txtLiteral3.Text))
    sSpace4 = Mid(sSpace4, 1, Len(sSpace4) - Len(frmListValues.txtLiteral4.Text))
    sSpace5 = Mid(sSpace5, 1, Len(sSpace5) - Len(frmListValues.txtLiteral5.Text))
    sSpace6 = Mid(sSpace6, 1, Len(sSpace6) - Len(frmListValues.txtLiteral6.Text))
    
    sSixspc1 = Mid(sSixspc1, 1, Len(sSixspc1) - Len(frmListValues.txtValue1.Text))
    sSixspc2 = Mid(sSixspc2, 1, Len(sSixspc2) - Len(frmListValues.txtValue2.Text))
    sSixspc3 = Mid(sSixspc3, 1, Len(sSixspc3) - Len(frmListValues.txtValue3.Text))
    sSixspc4 = Mid(sSixspc4, 1, Len(sSixspc4) - Len(frmListValues.txtValue4.Text))
    sSixspc5 = Mid(sSixspc5, 1, Len(sSixspc5) - Len(frmListValues.txtValue5.Text))
    sSixspc6 = Mid(sSixspc6, 1, Len(sSixspc6) - Len(frmListValues.txtValue6.Text))
    
    sSpaceB1 = Mid(sSpaceB1, 1, Len(sSpaceB1) - Len(frmListValues.cboDA1.Text))
    sSpaceB2 = Mid(sSpaceB2, 1, Len(sSpaceB2) - Len(frmListValues.cboDA2.Text))
    sSpaceB3 = Mid(sSpaceB3, 1, Len(sSpaceB3) - Len(frmListValues.cboDA3.Text))
    sSpaceB4 = Mid(sSpaceB4, 1, Len(sSpaceB4) - Len(frmListValues.cboDA4.Text))
    sSpaceB5 = Mid(sSpaceB5, 1, Len(sSpaceB5) - Len(frmListValues.cboDA5.Text))
    sSpaceB6 = Mid(sSpaceB6, 1, Len(sSpaceB6) - Len(frmListValues.cboDA6.Text))
    
    sSpaceC1 = Mid(sSpaceC1, 1, Len(sSpaceC1) - Len(frmListValues.cboVal1.Text))
    sSpaceC2 = Mid(sSpaceC2, 1, Len(sSpaceC2) - Len(frmListValues.cboVal2.Text))
    sSpaceC3 = Mid(sSpaceC3, 1, Len(sSpaceC3) - Len(frmListValues.cboVal3.Text))
    sSpaceC4 = Mid(sSpaceC4, 1, Len(sSpaceC4) - Len(frmListValues.cboVal4.Text))
    sSpaceC5 = Mid(sSpaceC5, 1, Len(sSpaceC5) - Len(frmListValues.cboVal5.Text))
    sSpaceC6 = Mid(sSpaceC6, 1, Len(sSpaceC6) - Len(frmListValues.cboVal6.Text))
    
    sSpaceD1 = Mid(sSpaceD1, 1, Len(sSpaceD1) - Len(frmListValues.cboScreen1.Text))
    sSpaceD2 = Mid(sSpaceD2, 1, Len(sSpaceD2) - Len(frmListValues.cboScreen2.Text))
    sSpaceD3 = Mid(sSpaceD3, 1, Len(sSpaceD3) - Len(frmListValues.cboScreen3.Text))
    sSpaceD4 = Mid(sSpaceD4, 1, Len(sSpaceD4) - Len(frmListValues.cboScreen4.Text))
    sSpaceD5 = Mid(sSpaceD5, 1, Len(sSpaceD5) - Len(frmListValues.cboScreen5.Text))
    sSpaceD6 = Mid(sSpaceD6, 1, Len(sSpaceD6) - Len(frmListValues.cboScreen6.Text))
    
    sSpaceE1 = Mid(sSpaceE1, 1, Len(sSpaceE1) - Len(frmListValues.cboReport1.Text))
    sSpaceE2 = Mid(sSpaceE2, 1, Len(sSpaceE2) - Len(frmListValues.cboReport2.Text))
    sSpaceE3 = Mid(sSpaceE3, 1, Len(sSpaceE3) - Len(frmListValues.cboReport3.Text))
    sSpaceE4 = Mid(sSpaceE4, 1, Len(sSpaceE4) - Len(frmListValues.cboReport4.Text))
    sSpaceE5 = Mid(sSpaceE5, 1, Len(sSpaceE5) - Len(frmListValues.cboReport5.Text))
    sSpaceE6 = Mid(sSpaceE6, 1, Len(sSpaceE6) - Len(frmListValues.cboReport6.Text))
    
    sWsLength = Mid(sWsLength, 1, Len(sWsLength) - Len(Me.txtWsLength.Text))
    sWsPrecision = Mid(sWsPrecision, 1, Len(sWsPrecision) - Len(Me.txtWsPrecision.Text))
    
    sIntLength = Mid(sIntLength, 1, Len(sIntLength) - Len(Me.txtIntLength.Text))
    sIntPrecision = Mid(sIntPrecision, 1, Len(sIntPrecision) - Len(Me.txtIntPrecision.Text))
    
    sRptLength = Mid(sRptLength, 1, Len(sRptLength) - Len(Me.txtRptLength.Text))
    sRptPrecision = Mid(sRptPrecision, 1, Len(sRptPrecision) - Len(Me.txtRptPrecision.Text))
    

    'End of space declarations and manipulations
    
    
  If FileExists(SirTemplate) Then

    Open SirTemplate For Append As #1


    Print #1, "                              Data Element Template"
    Print #1, ""
    Print #1, ""
    Print #1, ""
    Print #1, "1. Long Description:"
    Print #1, ""
    Print #1, "________________________________________________________________________"
    Print #1, ""
    Print #1, txtLongDesc.Text
    Print #1, ""
    Print #1, "________________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "2. Short Description:"
    Print #1, ""
    Print #1, "________________________________________________________________________"
    Print #1, ""
    Print #1, txtShortDesc.Text
    Print #1, ""
    Print #1, "________________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "3. Literal:"
    Print #1, ""
    Print #1, "________________________________________________________________________"
    Print #1, ""
    Print #1, txtLiteral.Text
    Print #1, ""
    Print #1, "________________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "4. Data Type:"
    Print #1, ""
    Print #1, "________________________________________________________________________"
    Print #1, ""
    Print #1, cboDataType.Text
    Print #1, ""
    Print #1, "________________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "5. Window/Screen, Internal, Report:"
    Print #1, ""
    Print #1, "________________________________________________________________________"
    Print #1, ""
    Print #1, "                   Length     Precision     Structure"
    Print #1, "Window/Screen      " & txtWsLength & sWsLength & txtWsPrecision & sWsPrecision & txtWsStructure
    Print #1, "Internal           " & txtIntLength & sIntLength & txtIntPrecision & sIntPrecision & txtIntStructure
    Print #1, "Report             " & txtRptLength & sRptLength & txtRptPrecision & sRptPrecision & txtRptStructure
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "6. C Name:"
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, txtCName.Text
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "7. Widget Name:"
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, txtWidgetNam.Text
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "8. COBOL Name:"
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, txtCobolNam.Text
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "9. Column Name:"
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, txtColumnNam.Text
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "10. Widget Type:"
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, cboWidgetType.Text
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "11. List Values:"
    Print #1, ""
    Print #1, "                                                     Use As:               Intial Value"
    Print #1, "Value Literal                                   Default  Validation  Screen  Internal  Report"
    Print #1, "                                                Active"
    Print #1, "                                                (Y/N)    (Y/N)       (Y/N)   (Y/N)     (Y/N)"
    Print #1, ""
    Print #1, frmListValues.txtValue1 & sSixspc1 & frmListValues.txtLiteral1.Text & sSpace1 & frmListValues.cboDA1.Text & sSpaceB1 & frmListValues.cboVal1.Text & sSpaceC1 & frmListValues.cboScreen1 & sSpaceD1 & frmListValues.cboInternal1 & sSpaceE1 & frmListValues.cboReport1; ""
    Print #1, frmListValues.txtValue2 & sSixspc2 & frmListValues.txtLiteral2.Text & sSpace2 & frmListValues.cboDA2.Text & sSpaceB2 & frmListValues.cboVal2.Text & sSpaceC2 & frmListValues.cboScreen2 & sSpaceD2 & frmListValues.cboInternal2 & sSpaceE2 & frmListValues.cboReport2; ""
    Print #1, frmListValues.txtValue3 & sSixspc3 & frmListValues.txtLiteral3.Text & sSpace3 & frmListValues.cboDA3.Text & sSpaceB3 & frmListValues.cboVal3.Text & sSpaceC3 & frmListValues.cboScreen3 & sSpaceD3 & frmListValues.cboInternal3 & sSpaceE3 & frmListValues.cboReport3; ""
    Print #1, frmListValues.txtValue4 & sSixspc4 & frmListValues.txtLiteral4.Text & sSpace4 & frmListValues.cboDA4.Text & sSpaceB4 & frmListValues.cboVal4.Text & sSpaceC4 & frmListValues.cboScreen4 & sSpaceD4 & frmListValues.cboInternal4 & sSpaceE4 & frmListValues.cboReport4; ""
    Print #1, frmListValues.txtValue5 & sSixspc5 & frmListValues.txtLiteral5.Text & sSpace5 & frmListValues.cboDA5.Text & sSpaceB5 & frmListValues.cboVal5.Text & sSpaceC5 & frmListValues.cboScreen5 & sSpaceD5 & frmListValues.cboInternal5 & sSpaceE5 & frmListValues.cboReport5; ""
    Print #1, frmListValues.txtValue6 & sSixspc6 & frmListValues.txtLiteral6.Text & sSpace6 & frmListValues.cboDA6.Text & sSpaceB6 & frmListValues.cboVal6.Text & sSpaceC6 & frmListValues.cboScreen6 & sSpaceD6 & frmListValues.cboInternal6 & sSpaceE6 & frmListValues.cboReport6
    Print #1, ""
    Print #1, ""
    Print #1, "12. Level 88-Values:"
    Print #1, "    COBOL Name                   Text"
    Print #1, ""
    Print #1, ""
    Print #1, "              " & frmCOBOLVal.txtCobolNam.Text & "                         " & frmCOBOLVal.txtAliasDE.Text
    Print #1, ""
    Print #1, ""
    Print #1, ""
    Print #1, "13. Formats: (Reference your Design 1 standards.)"
    Print #1, "A)Usage "
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, " " & frmDataElem.cboUsage.Text
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, "B)Points to a Data Element:"
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, " " & frmDataElem.txtPointsToRecIDNo.Text
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, "C)Points to a Record:"
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, " " & frmDataElem.txtPointsToCOBOLNm.Text
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "14. Range:"
    Print #1, "COBOL Name        Lower Bound        Operand 1        Operand 2        Upper Bound"
    Print #1, ""
    Print #1, ""
    Print #1, frmCOBOLVal.txtCobolNam.Text & "          " & frmCOBOLVal.txtLB.Text & "          " & frmCOBOLVal.txtOper1.Text & "          " & frmCOBOLVal.txtOper2.Text & "          " & frmCOBOLVal.txtUB.Text
    Print #1, ""
    Print #1, ""
    Print #1, ""
    Print #1, "15. Alias of the Data Element:"
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, "  " & frmCOBOLVal.txtAliasDE.Text
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, ""
    Print #1, "16. Decodes Table:"
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
    Print #1, "  " & frmCOBOLVal.txtDecodesTbl.Text
    Print #1, ""
    Print #1, "________________________________________________________________"
    Print #1, ""
        
    Close #1

    strMsg = "Request CopyBook Template successfully written. Do you want to create " & _
    "another Template?"
    strTitle = "Data Element Template"
    
    intResponse = MsgBox(strMsg, intStyle, strTitle)
    
    
    If intResponse = vbYes Then
    
        'user wants to enter another template
        Call ResetProperties
        txtLongDesc.SetFocus
        
    Else
        'user is done, exit application
        Unload Me
        Unload frmListValues
        Unload frmCOBOLVal
        
    End If
 
  Else

    'file not found
    MsgBox SirTemplate & " does not exist! Please check the SIR number and try again.", vbOKOnly, "File Not Found"

  End If
  
    
Exit_WriteSirInfo:
    'exit procedure
    Exit Sub
        
Err_WriteSirInfo:
    'Display error message to user
    MsgBox Error$
    GoTo Exit_WriteSirInfo
        
End Sub

