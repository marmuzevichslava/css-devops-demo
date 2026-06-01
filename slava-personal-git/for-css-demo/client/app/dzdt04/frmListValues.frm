VERSION 5.00
Begin VB.Form frmListValues 
   Caption         =   "Enter List Values"
   ClientHeight    =   4080
   ClientLeft      =   300
   ClientTop       =   1500
   ClientWidth     =   11265
   ControlBox      =   0   'False
   LinkTopic       =   "Form2"
   ScaleHeight     =   4080
   ScaleWidth      =   11265
   Begin VB.TextBox txtCNm6 
      Height          =   285
      Left            =   4440
      MaxLength       =   18
      TabIndex        =   50
      Top             =   2640
      Width           =   1335
   End
   Begin VB.TextBox txtWidget6 
      Height          =   285
      Left            =   3000
      MaxLength       =   18
      TabIndex        =   49
      Top             =   2640
      Width           =   1335
   End
   Begin VB.TextBox txtCNm5 
      Height          =   285
      Left            =   4440
      MaxLength       =   18
      TabIndex        =   40
      Top             =   2280
      Width           =   1335
   End
   Begin VB.TextBox txtWidget5 
      Height          =   285
      Left            =   3000
      MaxLength       =   18
      TabIndex        =   39
      Top             =   2280
      Width           =   1335
   End
   Begin VB.TextBox txtCNm4 
      Height          =   285
      Left            =   4440
      MaxLength       =   18
      TabIndex        =   31
      Top             =   1920
      Width           =   1335
   End
   Begin VB.TextBox txtWidget4 
      Height          =   285
      Left            =   3000
      MaxLength       =   18
      TabIndex        =   30
      Top             =   1920
      Width           =   1335
   End
   Begin VB.TextBox txtCNm3 
      Height          =   285
      Left            =   4440
      MaxLength       =   18
      TabIndex        =   22
      Top             =   1560
      Width           =   1335
   End
   Begin VB.TextBox txtWidget3 
      Height          =   285
      Left            =   3000
      MaxLength       =   18
      TabIndex        =   21
      Top             =   1560
      Width           =   1335
   End
   Begin VB.TextBox txtCNm2 
      Height          =   285
      Left            =   4440
      MaxLength       =   18
      TabIndex        =   13
      Top             =   1200
      Width           =   1335
   End
   Begin VB.TextBox txtWidget2 
      Height          =   285
      Left            =   3000
      MaxLength       =   18
      TabIndex        =   12
      Top             =   1200
      Width           =   1335
   End
   Begin VB.TextBox txtCNm1 
      Height          =   285
      Left            =   4440
      MaxLength       =   18
      TabIndex        =   4
      Top             =   840
      Width           =   1335
   End
   Begin VB.TextBox txtWidget1 
      Height          =   285
      Left            =   3000
      MaxLength       =   18
      TabIndex        =   3
      Top             =   840
      Width           =   1335
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
      Left            =   6120
      TabIndex        =   57
      Top             =   3240
      Width           =   1575
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
      Left            =   3840
      TabIndex        =   56
      Top             =   3240
      Width           =   1575
   End
   Begin VB.ComboBox cboReport6 
      Height          =   315
      Left            =   10200
      TabIndex        =   55
      Top             =   2640
      Width           =   855
   End
   Begin VB.ComboBox cboInternal6 
      Height          =   315
      Left            =   9240
      TabIndex        =   54
      Top             =   2640
      Width           =   855
   End
   Begin VB.ComboBox cboScreen6 
      Height          =   315
      Left            =   8280
      TabIndex        =   53
      Top             =   2640
      Width           =   855
   End
   Begin VB.ComboBox cboVal6 
      Height          =   315
      Left            =   7200
      TabIndex        =   52
      Top             =   2640
      Width           =   855
   End
   Begin VB.ComboBox cboDA6 
      Height          =   315
      Left            =   6120
      TabIndex        =   51
      Top             =   2640
      Width           =   855
   End
   Begin VB.TextBox txtLiteral6 
      Height          =   285
      Left            =   960
      MaxLength       =   40
      TabIndex        =   48
      Top             =   2640
      Width           =   1935
   End
   Begin VB.TextBox txtValue6 
      Height          =   285
      Left            =   360
      MaxLength       =   2
      TabIndex        =   47
      Top             =   2640
      Width           =   495
   End
   Begin VB.ComboBox cboReport5 
      Height          =   315
      Left            =   10200
      TabIndex        =   46
      Top             =   2280
      Width           =   855
   End
   Begin VB.ComboBox cboInternal5 
      Height          =   315
      Left            =   9240
      TabIndex        =   45
      Top             =   2280
      Width           =   855
   End
   Begin VB.ComboBox cboScreen5 
      Height          =   315
      Left            =   8280
      TabIndex        =   44
      Top             =   2280
      Width           =   855
   End
   Begin VB.ComboBox cboVal5 
      Height          =   315
      Left            =   7200
      TabIndex        =   43
      Top             =   2280
      Width           =   855
   End
   Begin VB.ComboBox cboDA5 
      Height          =   315
      Left            =   6120
      TabIndex        =   41
      Top             =   2280
      Width           =   855
   End
   Begin VB.TextBox txtLiteral5 
      Height          =   285
      Left            =   960
      MaxLength       =   40
      TabIndex        =   38
      Top             =   2280
      Width           =   1935
   End
   Begin VB.TextBox txtValue5 
      Height          =   285
      Left            =   360
      MaxLength       =   2
      TabIndex        =   37
      Top             =   2280
      Width           =   495
   End
   Begin VB.ComboBox cboReport4 
      Height          =   315
      Left            =   10200
      TabIndex        =   36
      Top             =   1920
      Width           =   855
   End
   Begin VB.ComboBox cboInternal4 
      Height          =   315
      Left            =   9240
      TabIndex        =   35
      Top             =   1920
      Width           =   855
   End
   Begin VB.ComboBox cboScreen4 
      Height          =   315
      Left            =   8280
      TabIndex        =   34
      Top             =   1920
      Width           =   855
   End
   Begin VB.ComboBox cboVal4 
      Height          =   315
      Left            =   7200
      TabIndex        =   33
      Top             =   1920
      Width           =   855
   End
   Begin VB.ComboBox cboDA4 
      Height          =   315
      Left            =   6120
      TabIndex        =   32
      Top             =   1920
      Width           =   855
   End
   Begin VB.TextBox txtLiteral4 
      Height          =   285
      Left            =   960
      MaxLength       =   40
      TabIndex        =   29
      Top             =   1920
      Width           =   1935
   End
   Begin VB.TextBox txtValue4 
      Height          =   285
      Left            =   360
      MaxLength       =   2
      TabIndex        =   28
      Top             =   1920
      Width           =   495
   End
   Begin VB.ComboBox cboReport3 
      Height          =   315
      Left            =   10200
      TabIndex        =   27
      Top             =   1560
      Width           =   855
   End
   Begin VB.ComboBox cboInternal3 
      Height          =   315
      Left            =   9240
      TabIndex        =   26
      Top             =   1560
      Width           =   855
   End
   Begin VB.ComboBox cboScreen3 
      Height          =   315
      Left            =   8280
      TabIndex        =   25
      Top             =   1560
      Width           =   855
   End
   Begin VB.ComboBox cboVal3 
      Height          =   315
      Left            =   7200
      TabIndex        =   24
      Top             =   1560
      Width           =   855
   End
   Begin VB.ComboBox cboDA3 
      Height          =   315
      Left            =   6120
      TabIndex        =   23
      Top             =   1560
      Width           =   855
   End
   Begin VB.TextBox txtLiteral3 
      Height          =   285
      Left            =   960
      MaxLength       =   40
      TabIndex        =   20
      Top             =   1560
      Width           =   1935
   End
   Begin VB.TextBox txtValue3 
      Height          =   285
      Left            =   360
      MaxLength       =   2
      TabIndex        =   19
      Top             =   1560
      Width           =   495
   End
   Begin VB.ComboBox cboReport2 
      Height          =   315
      Left            =   10200
      TabIndex        =   18
      Top             =   1200
      Width           =   855
   End
   Begin VB.ComboBox cboInternal2 
      Height          =   315
      Left            =   9240
      TabIndex        =   17
      Top             =   1200
      Width           =   855
   End
   Begin VB.ComboBox cboScreen2 
      Height          =   315
      Left            =   8280
      TabIndex        =   16
      Top             =   1200
      Width           =   855
   End
   Begin VB.ComboBox cboVal2 
      Height          =   315
      Left            =   7200
      TabIndex        =   15
      Top             =   1200
      Width           =   855
   End
   Begin VB.ComboBox cboDA2 
      Height          =   315
      Left            =   6120
      TabIndex        =   14
      Top             =   1200
      Width           =   855
   End
   Begin VB.TextBox txtLiteral2 
      Height          =   285
      Left            =   960
      MaxLength       =   40
      TabIndex        =   11
      Top             =   1200
      Width           =   1935
   End
   Begin VB.TextBox txtValue2 
      Height          =   285
      Left            =   360
      MaxLength       =   2
      TabIndex        =   10
      Top             =   1200
      Width           =   495
   End
   Begin VB.ComboBox cboReport1 
      Height          =   315
      Left            =   10200
      TabIndex        =   9
      Top             =   840
      Width           =   855
   End
   Begin VB.ComboBox cboInternal1 
      Height          =   315
      Left            =   9240
      TabIndex        =   8
      Top             =   840
      Width           =   855
   End
   Begin VB.ComboBox cboScreen1 
      Height          =   315
      Left            =   8280
      TabIndex        =   7
      Top             =   840
      Width           =   855
   End
   Begin VB.ComboBox cboVal1 
      Height          =   315
      Left            =   7200
      TabIndex        =   6
      Top             =   840
      Width           =   855
   End
   Begin VB.ComboBox cboDA1 
      Height          =   315
      Left            =   6120
      TabIndex        =   5
      Top             =   840
      Width           =   855
   End
   Begin VB.TextBox txtLiteral1 
      Height          =   285
      Left            =   960
      MaxLength       =   40
      TabIndex        =   2
      Top             =   840
      Width           =   1935
   End
   Begin VB.TextBox txtValue1 
      Height          =   285
      Left            =   360
      MaxLength       =   2
      TabIndex        =   1
      Top             =   840
      Width           =   495
   End
   Begin VB.Label lblCName 
      Caption         =   "C Name"
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
      Left            =   4440
      TabIndex        =   66
      Top             =   480
      Width           =   735
   End
   Begin VB.Label lblWidgetNm 
      Caption         =   "Widget Name"
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
      Left            =   3000
      TabIndex        =   65
      Top             =   480
      Width           =   1215
   End
   Begin VB.Label lblInternalVal 
      Caption         =   "Initial Value:"
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
      Left            =   8880
      TabIndex        =   64
      Top             =   240
      Width           =   1095
   End
   Begin VB.Label lblReport 
      Caption         =   "Report:"
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
      Left            =   9960
      TabIndex        =   63
      Top             =   480
      Width           =   735
   End
   Begin VB.Label lblInternal 
      Caption         =   "Internal:"
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
      Left            =   9120
      TabIndex        =   62
      Top             =   480
      Width           =   735
   End
   Begin VB.Label lblScreen 
      Caption         =   "Screen:"
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
      Left            =   8280
      TabIndex        =   61
      Top             =   480
      Width           =   735
   End
   Begin VB.Label lblValidation 
      Caption         =   "Validation:"
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
      TabIndex        =   60
      Top             =   480
      Width           =   975
   End
   Begin VB.Label lblDefaultAct 
      Caption         =   "Default Active"
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
      TabIndex        =   59
      Top             =   480
      Width           =   1335
   End
   Begin VB.Label lblUseAs 
      Caption         =   "Use As:"
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
      Left            =   6720
      TabIndex        =   58
      Top             =   240
      Width           =   735
   End
   Begin VB.Label lblLiteral 
      Caption         =   "Literal"
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
      Left            =   1200
      TabIndex        =   42
      Top             =   480
      Width           =   615
   End
   Begin VB.Label lblValue 
      Caption         =   "Value"
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
      TabIndex        =   0
      Top             =   480
      Width           =   495
   End
End
Attribute VB_Name = "frmListValues"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cboDA1_Change()
On Error GoTo Err_cboDA1_Change

    If cboDA1.Text = "" Then
        cboDA1.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboDA1.Text
        cboDA1.BackColor = &HFF&
        cboDA1.Refresh
        
    End If
    
Exit_cboDA1_Change:
    Exit Sub
    
Err_cboDA1_Change:
    MsgBox Error$
    Resume Err_cboDA1_Change
    
End Sub

Private Sub cboDA1_Click()
    
    With cboDA1
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
End Sub

Private Sub cboDA1_LostFocus()
On Error GoTo Err_cboDA1_LostFocus

    If cboDA1.Text = "" Then
        cboDA1.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboDA1.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboDA1.BackColor = &HFF&
        cboDA1.SetFocus
        cboDA1.Refresh
    End If
    
Exit_cboDA1_LostFocus:
    Exit Sub
    
Err_cboDA1_LostFocus:
    MsgBox Error$
    Resume Err_cboDA1_LostFocus
    
End Sub

Private Sub cboDA2_Change()
On Error GoTo Err_cboDA2_Change

    If cboDA2.Text = "" Then
        cboDA2.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboDA2.Text
        cboDA2.BackColor = &HFF&
        cboDA2.Refresh
    End If
    
Exit_cboDA2_Change:
    Exit Sub
    
Err_cboDA2_Change:
    MsgBox Error$
    Resume Err_cboDA2_Change
    
End Sub

Private Sub cboDA2_Click()
On Error GoTo Err_cboDA2_Click

     With cboDA2
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboDA2_Click:
    Exit Sub
    
Err_cboDA2_Click:
    MsgBox Error$
    Resume Err_cboDA2_Click
    
End Sub

Private Sub cboDA2_LostFocus()
On Error GoTo Err_cboDA2_LostFocus

    If cboDA2.Text = "" Then
        cboDA2.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboDA2.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboDA2.BackColor = &HFF&
        cboDA2.SetFocus
        cboDA2.Refresh
    End If
    
Exit_cboDA2_LostFocus:
    Exit Sub
    
Err_cboDA2_LostFocus:
    MsgBox Error$
    Resume Err_cboDA2_LostFocus
    
End Sub

Private Sub cboDA3_Change()
On Error GoTo Err_cboDA3_Change

    If cboDA3.Text = "" Then
        cboDA3.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboDA3.Text
        cboDA3.BackColor = &HFF&
        cboDA3.Refresh
    End If
    
Exit_cboDA3_Change:
    Exit Sub
    
Err_cboDA3_Change:
    MsgBox Error$
    Resume Err_cboDA3_Change
    
End Sub

Private Sub cboDA3_Click()
On Error GoTo Err_cboDA3_Click

    With cboDA3
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboDA3_Click:
    Exit Sub
    
Err_cboDA3_Click:
    MsgBox Error$
    Resume Err_cboDA3_Click
    
End Sub

Private Sub cboDA3_LostFocus()
On Error GoTo Err_cboDA3_LostFocus

    If cboDA3.Text = "" Then
        cboDA3.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboDA3.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboDA3.BackColor = &HFF&
        cboDA3.SetFocus
        cboDA3.Refresh
    End If
    
Exit_cboDA3_LostFocus:
    Exit Sub
    
Err_cboDA3_LostFocus:
    MsgBox Error$
    Resume Err_cboDA3_LostFocus
    
End Sub

Private Sub cboDA4_Change()
On Error GoTo Err_cboDA4_Change

    If cboDA4.Text = "" Then
        cboDA4.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboDA4.Text
        cboDA4.BackColor = &HFF&
        cboDA4.Refresh
    End If
    
Exit_cboDA4_Change:
    Exit Sub
    
Err_cboDA4_Change:
    MsgBox Error$
    Resume Err_cboDA4_Change
    
End Sub

Private Sub cboDA4_Click()
On Error GoTo Err_cboDA4_Click
    With cboDA4
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""

Exit_cboDA4_Click:
    Exit Sub
    
Err_cboDA4_Click:
    MsgBox Error$
    Resume Err_cboDA4_Click
    
End Sub

Private Sub cboDA4_LostFocus()
On Error GoTo Err_cboDA4_LostFocus

    If cboDA4.Text = "" Then
        cboDA4.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboDA4.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboDA4.BackColor = &HFF&
        cboDA4.SetFocus
        cboDA4.Refresh
    End If
    
Exit_cboDA4_LostFocus:
    Exit Sub
    
Err_cboDA4_LostFocus:
    MsgBox Error$
    Resume Err_cboDA4_LostFocus
    
End Sub

Private Sub cboDA5_Change()
On Error GoTo Err_cboDA5_Change

    If cboDA5.Text = "" Then
        cboDA5.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboDA5.Text
        cboDA5.BackColor = &HFF&
        cboDA5.Refresh
    End If
    
Exit_cboDA5_Change:
    Exit Sub
    
Err_cboDA5_Change:
    MsgBox Error$
    Resume Err_cboDA5_Change
    
End Sub

Private Sub cboDA5_Click()
On Error GoTo Err_cboDA5_Click

    With cboDA5
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboDA5_Click:
    Exit Sub
    
Err_cboDA5_Click:
    MsgBox Error$
    Resume Err_cboDA5_Click
    
End Sub

Private Sub cboDA5_LostFocus()
On Error GoTo Err_cboDA5_LostFocus

    If cboDA5.Text = "" Then
        cboDA5.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboDA5.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboDA5.BackColor = &HFF&
        cboDA5.SetFocus
        cboDA5.Refresh
    End If
    
Exit_cboDA5_LostFocus:
    Exit Sub
    
Err_cboDA5_LostFocus:
    MsgBox Error$
    Resume Err_cboDA5_LostFocus
    
End Sub

Private Sub cboDA6_Change()
On Error GoTo Err_cboDA6_Change

    If cboDA6.Text = "" Then
        cboDA6.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboDA6.Text
        cboDA6.BackColor = &HFF&
        cboDA6.Refresh
    End If
    
Exit_cboDA6_Change:
    Exit Sub
    
Err_cboDA6_Change:
    MsgBox Error$
    Resume Err_cboDA6_Change
    
End Sub

Private Sub cboDA6_Click()
On Error GoTo Err_cboDA6_Click

     With cboDA6
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboDA6_Click:
    Exit Sub
    
Err_cboDA6_Click:
    MsgBox Error$
    Resume Err_cboDA6_Click
    
End Sub


Private Sub cboDA6_LostFocus()
On Error GoTo Err_cboDA6_LostFocus

     If cboDA6.Text = "" Then
        cboDA6.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboDA6.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboDA6.BackColor = &HFF&
        cboDA6.SetFocus
        cboDA6.Refresh
    End If
    
Exit_cboDA6_LostFocus:
    Exit Sub
    
Err_cboDA6_LostFocus:
    MsgBox Error$
    Resume Err_cboDA6_LostFocus
    
End Sub

Private Sub cboInternal1_Change()
On Error GoTo Err_cboInternal1_Change

    If cboInternal1.Text = "" Then
        cboInternal1.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboInternal1.Text
        cboInternal1.BackColor = &HFF&
        cboInternal1.Refresh
        
    End If
    
Exit_cboInternal1_Change:
    Exit Sub
    
Err_cboInternal1_Change:
    MsgBox Error$
    Resume Err_cboInternal1_Change
    
End Sub

Private Sub cboInternal1_Click()
On Error GoTo Err_cboInternal1_Click

    With cboInternal1
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboInternal1_Click:
    Exit Sub
    
Err_cboInternal1_Click:
    MsgBox Error$
    Resume Err_cboInternal1_Click
    
End Sub

Private Sub cboInternal1_LostFocus()
On Error GoTo Err_cboInternal1_LostFocus

    If cboInternal1.Text = "" Then
        cboInternal1.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboInternal1.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboInternal1.BackColor = &HFF&
        cboInternal1.SetFocus
        cboInternal1.Refresh
    End If
    
Exit_cboInternal1_LostFocus:
    Exit Sub
    
Err_cboInternal1_LostFocus:
    MsgBox Error$
    Resume Err_cboInternal1_LostFocus
    
End Sub

Private Sub cboInternal2_Change()
On Error GoTo Err_cboInternal2_Change

    If cboInternal2.Text = "" Then
        cboInternal2.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboInternal2.Text
        cboInternal2.BackColor = &HFF&
        cboInternal2.Refresh
        
    End If
    
Exit_cboInternal2_Change:
    Exit Sub
    
Err_cboInternal2_Change:
    MsgBox Error$
    Resume Err_cboInternal2_Change
    
End Sub

Private Sub cboInternal2_Click()
On Error GoTo Err_cboInternal2_Click

    With cboInternal2
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboInternal2_Click:
    Exit Sub
    
Err_cboInternal2_Click:
    MsgBox Error$
    Resume Err_cboInternal2_Click
    
End Sub

Private Sub cboInternal2_LostFocus()
On Error GoTo Err_cboInternal2_LostFocus

    If cboInternal2.Text = "" Then
        cboInternal2.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboInternal2.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboInternal2.BackColor = &HFF&
        cboInternal2.SetFocus
        cboInternal2.Refresh
    End If
    
Exit_cboInternal2_LostFocus:
    Exit Sub
    
Err_cboInternal2_LostFocus:
    MsgBox Error$
    Resume Err_cboInternal2_LostFocus
    
End Sub

Private Sub cboInternal3_Change()
On Error GoTo Err_cboInternal3_Change

    If cboInternal3.Text = "" Then
        cboInternal3.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboInternal3.Text
        cboInternal3.BackColor = &HFF&
        cboInternal3.Refresh
        
    End If
    
Exit_cboInternal3_Change:
    Exit Sub
    
Err_cboInternal3_Change:
    MsgBox Error$
    Resume Err_cboInternal3_Change
    
End Sub

Private Sub cboInternal3_Click()
On Error GoTo Err_cboInternal3_Click

    With cboInternal3
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboInternal3_Click:
    Exit Sub
    
Err_cboInternal3_Click:
    MsgBox Error$
    Resume Err_cboInternal3_Click
    
End Sub

Private Sub cboInternal3_LostFocus()
On Error GoTo Err_cboInternal3_LostFocus
    
    If cboInternal3.Text = "" Then
        cboInternal3.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboInternal3.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboInternal3.BackColor = &HFF&
        cboInternal3.SetFocus
        cboInternal3.Refresh
    End If
    
Exit_cboInternal3_LostFocus:
    Exit Sub
    
Err_cboInternal3_LostFocus:
    MsgBox Error$
    Resume Err_cboInternal3_LostFocus
    
End Sub

Private Sub cboInternal4_Change()
On Error GoTo Err_cboInternal4_Change

    If cboInternal4.Text = "" Then
        cboInternal4.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboInternal4.Text
        cboInternal4.BackColor = &HFF&
        cboInternal4.Refresh
        
    End If

Exit_cboInternal4_Change:
    Exit Sub
    
Err_cboInternal4_Change:
    MsgBox Error$
    Resume Err_cboInternal4_Change
    
End Sub

Private Sub cboInternal4_Click()
On Error GoTo Err_cboInternal4_Click

    With cboInternal4
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboInternal4_Click:
    Exit Sub
    
Err_cboInternal4_Click:
    MsgBox Error$
    Resume Err_cboInternal4_Click
    
End Sub

Private Sub cboInternal4_LostFocus()
On Error GoTo Err_cboInternal4_LostFocus

    If cboInternal4.Text = "" Then
        cboInternal4.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboInternal4.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboInternal4.BackColor = &HFF&
        cboInternal4.SetFocus
        cboInternal4.Refresh
    End If
    
Exit_cboInternal4_LostFocus:
    Exit Sub
    
Err_cboInternal4_LostFocus:
    MsgBox Error$
    Resume Err_cboInternal4_LostFocus
    
End Sub

Private Sub cboInternal5_Change()
On Error GoTo Err_cboInternal5_Change

    If cboInternal5.Text = "" Then
        cboInternal5.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboInternal5.Text
        cboInternal5.BackColor = &HFF&
        cboInternal5.Refresh
        
    End If
    
Exit_cboInternal5_Change:
    Exit Sub
    
Err_cboInternal5_Change:
    MsgBox Error$
    Resume Err_cboInternal5_Change
    
End Sub

Private Sub cboInternal5_Click()
On Error GoTo Err_cboInternal5_Click

    With cboInternal5
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboInternal5_Click:
    Exit Sub
    
Err_cboInternal5_Click:
    MsgBox Error$
    Resume Err_cboInternal5_Click
    
End Sub

Private Sub cboInternal5_LostFocus()
On Error GoTo Err_cboInternal5_LostFocus

    If cboInternal5.Text = "" Then
        cboInternal5.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboInternal5.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboInternal5.BackColor = &HFF&
        cboInternal5.SetFocus
        cboInternal5.Refresh
    End If
    
Exit_cboInternal5_LostFocus:
    Exit Sub
    
Err_cboInternal5_LostFocus:
    MsgBox Error$
    Resume Err_cboInternal5_LostFocus
    
End Sub

Private Sub cboInternal6_Change()
On Error GoTo Err_cboInternal6_Change

    If cboInternal6.Text = "" Then
        cboInternal6.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboInternal6.Text
        cboInternal6.BackColor = &HFF&
        cboInternal6.Refresh
        
    End If
    
Exit_cboInternal6_Change:
    Exit Sub
    
Err_cboInternal6_Change:
    MsgBox Error$
    Resume Err_cboInternal6_Change
    
End Sub

Private Sub cboInternal6_Click()
On Error GoTo Err_cboInternal6_Click

    With cboInternal6
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboInternal6_Click:
    Exit Sub
    
Err_cboInternal6_Click:
    MsgBox Error$
    Resume Err_cboInternal6_Click
    
End Sub

Private Sub cboInternal6_LostFocus()
On Error GoTo Err_cboInternal6_LostFocus

    If cboInternal6.Text = "" Then
        cboInternal6.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboInternal6.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboInternal6.BackColor = &HFF&
        cboInternal6.SetFocus
        cboInternal6.Refresh
    End If
    
Exit_cboInternal6_LostFocus:
    Exit Sub
    
Err_cboInternal6_LostFocus:
    MsgBox Error$
    Resume Err_cboInternal6_LostFocus
    
End Sub

Private Sub cboReport1_Change()
On Error GoTo Err_cboReport1_Change

    If cboReport1.Text = "" Then
        cboReport1.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboReport1.Text
        cboReport1.BackColor = &HFF&
        cboReport1.Refresh
        
    End If
    
Exit_cboReport1_Change:
    Exit Sub
    
Err_cboReport1_Change:
    MsgBox Error$
    Resume Err_cboReport1_Change
    
End Sub

Private Sub cboReport1_Click()
On Error GoTo Err_cboReport1_Click

    With cboReport1
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboReport1_Click:
    Exit Sub
    
Err_cboReport1_Click:
    MsgBox Error$
    Resume Err_cboReport1_Click
    
End Sub

Private Sub cboReport1_LostFocus()
On Error GoTo Err_cboReport1_LostFocus

    If cboReport1.Text = "" Then
        cboReport1.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboReport1.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboReport1.BackColor = &HFF&
        cboReport1.SetFocus
        cboReport1.Refresh
    End If
    
Exit_cboReport1_LostFocus:
    Exit Sub
    
Err_cboReport1_LostFocus:
    MsgBox Error$
    Resume Err_cboReport1_LostFocus
    
End Sub

Private Sub cboReport2_Change()
On Error GoTo Err_cboReport2_Change

    If cboReport2.Text = "" Then
        cboReport2.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboReport2.Text
        cboReport2.BackColor = &HFF&
        cboReport2.Refresh
    End If
    
Exit_cboReport2_Change:
    Exit Sub
    
Err_cboReport2_Change:
    MsgBox Error$
    Resume Err_cboReport2_Change
    
End Sub

Private Sub cboReport2_Click()
On Error GoTo Err_cboReport2_Click

    With cboReport2
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboReport2_Click:
    Exit Sub
    
Err_cboReport2_Click:
    MsgBox Error$
    Resume Err_cboReport2_Click
    
End Sub

Private Sub cboReport2_LostFocus()
On Error GoTo Err_cboReport2_LostFocus

    If cboReport2.Text = "" Then
        cboReport2.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboReport2.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboReport2.BackColor = &HFF&
        cboReport2.SetFocus
        cboReport2.Refresh
    End If
    
Exit_cboReport2_LostFocus:
    Exit Sub
    
Err_cboReport2_LostFocus:
    MsgBox Error$
    Resume Err_cboReport2_LostFocus
    
End Sub

Private Sub cboReport3_Change()
On Error GoTo Err_cboReport3_Change

    If cboReport3.Text = "" Then
        cboReport3.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboReport3.Text
        cboReport3.BackColor = &HFF&
        cboReport3.Refresh
    End If
    
Exit_cboReport3_Change:
    Exit Sub
    
Err_cboReport3_Change:
    MsgBox Error$
    Resume Err_cboReport3_Change
    
End Sub

Private Sub cboReport3_Click()
On Error GoTo Err_cboReport3_Click

     With cboReport3
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboReport3_Click:
    Exit Sub
    
Err_cboReport3_Click:
    MsgBox Error$
    Resume Err_cboReport3_Click
    
End Sub

Private Sub cboReport3_LostFocus()
On Error GoTo Err_cboReport3_LostFocus

    If cboReport3.Text = "" Then
        cboReport3.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboReport3.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboReport3.BackColor = &HFF&
        cboReport3.SetFocus
        cboReport3.Refresh
    End If
    
Exit_cboReport3_LostFocus:
    Exit Sub
    
Err_cboReport3_LostFocus:
    MsgBox Error$
    Resume Err_cboReport3_LostFocus
    
End Sub

Private Sub cboReport4_Change()
On Error GoTo Err_cboReport4_Change
    
    If cboReport4.Text = "" Then
        cboReport4.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboReport4.Text
        cboReport4.BackColor = &HFF&
        cboReport4.Refresh
    End If
    
Exit_cboReport4_Change:
    Exit Sub
    
Err_cboReport4_Change:
    MsgBox Error$
    Resume Err_cboReport4_Change
    
End Sub

Private Sub cboReport4_Click()
On Error GoTo Err_cboReport4_Click

    With cboReport4
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""

Exit_cboReport4_Click:
    Exit Sub
    
Err_cboReport4_Click:
    MsgBox Error$
    Resume Err_cboReport4_Click

End Sub

Private Sub cboReport4_LostFocus()
On Error GoTo Err_cboReport4_LostFocus

    If cboReport4.Text = "" Then
        cboReport4.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboReport4.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboReport4.BackColor = &HFF&
        cboReport4.SetFocus
        cboReport4.Refresh
    End If
    
Exit_cboReport4_LostFocus:
    Exit Sub
    
Err_cboReport4_LostFocus:
    MsgBox Error$
    Resume Err_cboReport4_LostFocus
    
End Sub

Private Sub cboReport5_Change()
On Error GoTo Err_cboReport5_Change

    If cboReport5.Text = "" Then
        cboReport5.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboReport5.Text
        cboReport5.BackColor = &HFF&
        cboReport5.Refresh
    End If
    
Exit_cboReport5_Change:
    Exit Sub
    
Err_cboReport5_Change:
    MsgBox Error$
    Resume Err_cboReport5_Change
    
End Sub

Private Sub cboReport5_Click()
On Error GoTo Err_cboReport5_Click

    With cboReport5
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""

Exit_cboReport5_Click:
    Exit Sub
    
Err_cboReport5_Click:
    MsgBox Error$
    Resume Err_cboReport5_Click

End Sub

Private Sub cboReport5_LostFocus()
On Error GoTo Err_cboReport5_LostFocus

    If cboReport5.Text = "" Then
        cboReport5.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboReport5.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboReport5.BackColor = &HFF&
        cboReport5.SetFocus
        cboReport5.Refresh
    End If
    
Exit_cboReport5_LostFocus:
    Exit Sub
    
Err_cboReport5_LostFocus:
    MsgBox Error$
    Resume Err_cboReport5_LostFocus
    
End Sub

Private Sub cboReport6_Change()
On Error GoTo Err_cboReport6_Change

    If cboReport6.Text = "" Then
        cboReport6.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboReport6.Text
        cboReport6.BackColor = &HFF&
        cboReport6.Refresh
    End If
    
Exit_cboReport6_Change:
    Exit Sub
    
Err_cboReport6_Change:
    MsgBox Error$
    Resume Err_cboReport6_Change
    
End Sub

Private Sub cboReport6_Click()
On Error GoTo Err_cboReport6_Click

    With cboReport6
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboReport6_Click:
    Exit Sub
    
Err_cboReport6_Click:
    MsgBox Error$
    Resume Err_cboReport6_Click
    
End Sub

Private Sub cboReport6_LostFocus()
On Error GoTo Err_cboReport6_LostFocus

    If cboReport6.Text = "" Then
        cboReport6.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboReport6.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboReport6.BackColor = &HFF&
        cboReport6.SetFocus
        cboReport6.Refresh
    End If
    
Exit_cboReport6_LostFocus:
    Exit Sub
    
Err_cboReport6_LostFocus:
    MsgBox Error$
    Resume Err_cboReport6_LostFocus
    
End Sub

Private Sub cboScreen1_Change()
On Error GoTo Err_cboScreen1_Change

    If cboScreen1.Text = "" Then
        cboScreen1.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboScreen1.Text
        cboScreen1.BackColor = &HFF&
        cboScreen1.Refresh
    End If
    
Exit_cboScreen1_Change:
    Exit Sub
    
Err_cboScreen1_Change:
    MsgBox Error$
    Resume Err_cboScreen1_Change
    
End Sub

Private Sub cboScreen1_Click()
On Error GoTo Err_cboScreen1_Click

    With cboScreen1
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboScreen1_Click:
    Exit Sub
    
Err_cboScreen1_Click:
    MsgBox Error$
    Resume Err_cboScreen1_Click
    
End Sub

Private Sub cboScreen1_LostFocus()
On Error GoTo Err_cboScreen1_LostFocus

    If cboScreen1.Text = "" Then
        cboScreen1.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboScreen1.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboScreen1.BackColor = &HFF&
        cboScreen1.SetFocus
        cboScreen1.Refresh
    End If
    
Exit_cboScreen1_LostFocus:
    Exit Sub
    
Err_cboScreen1_LostFocus:
    MsgBox Error$
    Resume Err_cboScreen1_LostFocus
    
End Sub

Private Sub cboScreen2_Change()
On Error GoTo Err_cboScreen2_Change


    If cboScreen2.Text = "" Then
        cboScreen2.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboScreen2.Text
        cboScreen2.BackColor = &HFF&
        cboScreen2.Refresh
    End If
    
Exit_cboScreen2_Change:
    Exit Sub
    
Err_cboScreen2_Change:
    MsgBox Error$
    Resume Err_cboScreen2_Change
    
End Sub

Private Sub cboScreen2_Click()
On Error GoTo Err_cboScreen2_Click

    With cboScreen2
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboScreen2_Click:
    Exit Sub
    
Err_cboScreen2_Click:
    MsgBox Error$
    Resume Err_cboScreen2_Click
    
End Sub

Private Sub cboScreen2_LostFocus()
On Error GoTo Err_cboScreen2_LostFocus

    If cboScreen2.Text = "" Then
        cboScreen2.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboScreen2.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboScreen2.BackColor = &HFF&
        cboScreen2.SetFocus
        cboScreen2.Refresh
    End If
    
Exit_cboScreen2_LostFocus:
    Exit Sub
    
Err_cboScreen2_LostFocus:
    MsgBox Error$
    Resume Err_cboScreen2_LostFocus
    
End Sub

Private Sub cboScreen3_Change()
On Error GoTo Err_cboScreen3_Change

    If cboScreen3.Text = "" Then
        cboScreen3.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboScreen3.Text
        cboScreen3.BackColor = &HFF&
        cboScreen3.Refresh
    End If
    
Exit_cboScreen3_Change:
    Exit Sub
    
Err_cboScreen3_Change:
    MsgBox Error$
    Resume Err_cboScreen3_Change
    
End Sub

Private Sub cboScreen3_Click()
On Error GoTo Err_cboScreen3_Click

    With cboScreen3
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboScreen3_Click:
    Exit Sub
    
Err_cboScreen3_Click:
    MsgBox Error$
    Resume Err_cboScreen3_Click
    
End Sub

Private Sub cboScreen3_LostFocus()
On Error GoTo Err_cboScreen3_LostFocus

    If cboScreen3.Text = "" Then
        cboScreen3.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboScreen3.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboScreen3.BackColor = &HFF&
        cboScreen3.SetFocus
        cboScreen3.Refresh
    End If
    
Exit_cboScreen3_LostFocus:
    Exit Sub
    
Err_cboScreen3_LostFocus:
    MsgBox Error$
    Resume Err_cboScreen3_LostFocus
    
End Sub

Private Sub cboScreen4_Change()
On Error GoTo Err_cboScreen4_Change

    If cboScreen4.Text = "" Then
        cboScreen4.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboScreen4.Text
        cboScreen4.BackColor = &HFF&
        cboScreen4.Refresh
    End If
    
Exit_cboScreen4_Change:
    Exit Sub
    
Err_cboScreen4_Change:
    MsgBox Error$
    Resume Err_cboScreen4_Change
    
End Sub

Private Sub cboScreen4_Click()
On Error GoTo Err_cboScreen4_Click

    With cboScreen4
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboScreen4_Click:
    Exit Sub
    
Err_cboScreen4_Click:
    MsgBox Error$
    Resume Err_cboScreen4_Click
    
End Sub

Private Sub cboScreen4_LostFocus()
On Error GoTo Err_cboScreen4_LostFocus

    If cboScreen4.Text = "" Then
        cboScreen4.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboScreen4.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboScreen4.BackColor = &HFF&
        cboScreen4.SetFocus
        cboScreen4.Refresh
    End If
    
Exit_cboScreen4_LostFocus:
    Exit Sub
    
Err_cboScreen4_LostFocus:
    MsgBox Error$
    Resume Err_cboScreen4_LostFocus
    
End Sub

Private Sub cboScreen5_Change()
On Error GoTo Err_cboScreen5_Change

    If cboScreen5.Text = "" Then
        cboScreen5.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboScreen5.Text
        cboScreen5.BackColor = &HFF&
        cboScreen5.Refresh
    End If
    
Exit_cboScreen5_Change:
    Exit Sub
    
Err_cboScreen5_Change:
    MsgBox Error$
    Resume Err_cboScreen5_Change
    
End Sub

Private Sub cboScreen5_Click()
On Error GoTo Err_cboScreen5_Click

    With cboScreen5
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboScreen5_Click:
    Exit Sub
    
Err_cboScreen5_Click:
    MsgBox Error$
    Resume Err_cboScreen5_Click
    
End Sub

Private Sub cboScreen5_LostFocus()
On Error GoTo Err_cboScreen5_LostFocus

    If cboScreen5.Text = "" Then
        cboScreen5.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboScreen5.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboScreen5.BackColor = &HFF&
        cboScreen5.SetFocus
        cboScreen5.Refresh
    End If
    
Exit_cboScreen5_LostFocus:
    Exit Sub
    
Err_cboScreen5_LostFocus:
    MsgBox Error$
    Resume Err_cboScreen5_LostFocus
    
End Sub

Private Sub cboScreen6_Change()
On Error GoTo Err_cboScreen6_Change

    If cboScreen6.Text = "" Then
        cboScreen6.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboScreen6.Text
        cboScreen6.BackColor = &HFF&
        cboScreen6.Refresh
    End If
    
Exit_cboScreen6_Change:
    Exit Sub
    
Err_cboScreen6_Change:
    MsgBox Error$
    Resume Err_cboScreen6_Change
    
End Sub

Private Sub cboScreen6_Click()
On Error GoTo Err_cboScreen6_Click

    With cboScreen6
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboScreen6_Click:
    Exit Sub
    
Err_cboScreen6_Click:
    MsgBox Error$
    Resume Err_cboScreen6_Click
    
End Sub

Private Sub cboScreen6_LostFocus()
On Error GoTo Err_cboScreen6_LostFocus

    If cboScreen6.Text = "" Then
        cboScreen6.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboScreen6.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboScreen6.BackColor = &HFF&
        cboScreen6.SetFocus
        cboScreen6.Refresh
    End If
    
Exit_cboScreen6_LostFocus:
    Exit Sub
    
Err_cboScreen6_LostFocus:
    MsgBox Error$
    Resume Err_cboScreen6_LostFocus
    
End Sub

Private Sub cboVal1_Change()
On Error GoTo Err_cboVal1_Change

    If cboVal1.Text = "" Then
        cboVal1.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboVal1.Text
        cboVal1.BackColor = &HFF&
        cboVal1.Refresh
    End If
    
Exit_cboVal1_Change:
    Exit Sub
    
Err_cboVal1_Change:
    MsgBox Error$
    Resume Err_cboVal1_Change
    
End Sub

Private Sub cboVal1_Click()
On Error GoTo Err_cboVal1_Click

    With cboVal1
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboVal1_Click:
    Exit Sub
    
Err_cboVal1_Click:
    MsgBox Error$
    Resume Err_cboVal1_Click
    
End Sub

Private Sub cboVal1_LostFocus()
On Error GoTo Err_cboVal1_LostFocus

    If cboVal1.Text = "" Then
        cboVal1.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboVal1.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboVal1.BackColor = &HFF&
        cboVal1.SetFocus
        cboVal1.Refresh
    End If
    
Exit_cboVal1_LostFocus:
    Exit Sub
    
Err_cboVal1_LostFocus:
    MsgBox Error$
    Resume Err_cboVal1_LostFocus
    
End Sub

Private Sub cboVal2_Change()
On Error GoTo Err_cboVal2_Change

    If cboVal2.Text = "" Then
        cboVal2.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboVal2.Text
        cboVal2.BackColor = &HFF&
        cboVal2.Refresh
    End If
  
Exit_cboVal2_Change:
    Exit Sub
    
Err_cboVal2_Change:
    MsgBox Error$
    Resume Err_cboVal2_Change
  
End Sub

Private Sub cboVal2_Click()
On Error GoTo Err_cboVal2_Click

    With cboVal2
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboVal2_Click:
    Exit Sub
    
Err_cboVal2_Click:
    MsgBox Error$
    Resume Err_cboVal2_Click
    
End Sub

Private Sub cboVal2_LostFocus()
On Error GoTo Err_cboVal2_LostFocus

    If cboVal2.Text = "" Then
        cboVal2.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboVal2.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboVal2.BackColor = &HFF&
        cboVal2.SetFocus
        cboVal2.Refresh
    End If
    
Exit_cboVal2_LostFocus:
    Exit Sub
    
Err_cboVal2_LostFocus:
    MsgBox Error$
    Resume Err_cboVal2_LostFocus
    
End Sub

Private Sub cboVal3_Change()
On Error GoTo Err_cboVal3_Change

    If cboVal3.Text = "" Then
        cboVal3.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboVal3.Text
        cboVal3.BackColor = &HFF&
        cboVal3.Refresh
    End If
  
Exit_cboVal3_Change:
    Exit Sub
    
Err_cboVal3_Change:
    MsgBox Error$
    Resume Err_cboVal3_Change
  
End Sub

Private Sub cboVal3_Click()
On Error GoTo Err_cboVal3_Click

    With cboVal3
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboVal3_Click:
    Exit Sub
    
Err_cboVal3_Click:
    MsgBox Error$
    Resume Err_cboVal3_Click
    
End Sub

Private Sub cboVal3_LostFocus()
On Error GoTo Err_cboVal3_LostFocus

    If cboVal3.Text = "" Then
        cboVal3.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboVal3.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboVal3.BackColor = &HFF&
        cboVal3.SetFocus
        cboVal3.Refresh
    End If
    
Exit_cboVal3_LostFocus:
    Exit Sub
    
Err_cboVal3_LostFocus:
    MsgBox Error$
    Resume Err_cboVal3_LostFocus
    
End Sub

Private Sub cboVal4_Change()
On Error GoTo Err_cboVal4_Change

    If cboVal4.Text = "" Then
        cboVal4.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboVal4.Text
        cboVal4.BackColor = &HFF&
        cboVal4.Refresh
    End If
  
Exit_cboVal4_Change:
    Exit Sub
    
Err_cboVal4_Change:
    MsgBox Error$
    Resume Err_cboVal4_Change
  
End Sub

Private Sub cboVal4_Click()
On Error GoTo Err_cboVal4_Click

    With cboVal4
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboVal4_Click:
    Exit Sub
    
Err_cboVal4_Click:
    MsgBox Error$
    Resume Err_cboVal4_Click
    
End Sub

Private Sub cboVal4_LostFocus()
On Error GoTo Err_cboVal4_LostFocus


    If cboVal4.Text = "" Then
        cboVal4.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboVal4.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboVal4.BackColor = &HFF&
        cboVal4.SetFocus
        cboVal4.Refresh
    End If
    
Exit_cboVal4_LostFocus:
    Exit Sub
    
Err_cboVal4_LostFocus:
    MsgBox Error$
    Resume Err_cboVal4_LostFocus
    
End Sub

Private Sub cboVal5_Change()
On Error GoTo Err_cboVal5_Change

    If cboVal5.Text = "" Then
        cboVal5.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboVal5.Text
        cboVal5.BackColor = &HFF&
        cboVal5.Refresh
    End If

Exit_cboVal5_Change:
    Exit Sub
    
Err_cboVal5_Change:
    MsgBox Error$
    Resume Err_cboVal5_Change
  
End Sub

Private Sub cboVal5_Click()
On Error GoTo Err_cboVal5_Click

    With cboVal5
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboVal5_Click:
    Exit Sub
    
Err_cboVal5_Click:
    MsgBox Error$
    Resume Err_cboVal5_Click
    
End Sub

Private Sub cboVal5_LostFocus()
On Error GoTo Err_cboVal5_LostFocus

    If cboVal5.Text = "" Then
        cboVal5.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboVal5.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboVal5.BackColor = &HFF&
        cboVal5.SetFocus
        cboVal5.Refresh
    End If
    
Exit_cboVal5_LostFocus:
    Exit Sub
    
Err_cboVal5_LostFocus:
    MsgBox Error$
    Resume Err_cboVal5_LostFocus
    
End Sub

Private Sub cboVal6_Change()
On Error GoTo Err_cboVal6_Change

    If cboVal6.Text = "" Then
        cboVal6.BackColor = &HFFFFFF
    Else
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        'set global string compare item
        gblsComp = cboVal6.Text
        cboVal6.BackColor = &HFF&
        cboVal6.Refresh
    End If
  
Exit_cboVal6_Change:
    Exit Sub
    
Err_cboVal6_Change:
    MsgBox Error$
    Resume Err_cboVal6_Change
  
End Sub

Private Sub cboVal6_Click()
On Error GoTo Err_cboVal6_Click

    With cboVal6
        .BackColor = &HFFFFFF
       
    End With
    
     'update global string compare item
    gblsComp = ""
    
Exit_cboVal6_Click:
    Exit Sub
    
Err_cboVal6_Click:
    MsgBox Error$
    Resume Err_cboVal6_Click
    
End Sub

Private Sub cboVal6_LostFocus()
On Error GoTo Err_cboVal6_LostFocus

    If cboVal6.Text = "" Then
        cboVal6.BackColor = &HFFFFFF
    ElseIf (gblsComp = cboVal6.Text) Then
        MsgBox "Please choose a value from the list.", vbOKOnly, "Enter List Values"
        cboVal6.BackColor = &HFF&
        cboVal6.SetFocus
        cboVal6.Refresh
    End If
    
Exit_cboVal6_LostFocus:
    Exit Sub
    
Err_cboVal6_LostFocus:
    MsgBox Error$
    Resume Err_cboVal6_LostFocus
    
End Sub

Private Sub cmdCancel_Click()
On Error GoTo Err_cmdCancel_Click


    Dim Response, Style, Response2, sStyle2
    Dim Title As String, msg As String, sMsg2 As String, sTitle2 As String
    Dim myControl As Control
    
    sTitle2 = "Enter List Values"
    sMsg2 = "You did not select anything on this form, do you wish to exit?"
    sStyle2 = vbYesNo
    
    
    'First check - See if anything was done
    If CheckControls(Me) = False Then
        
        Response2 = MsgBox(sMsg2, sStyle2, sTitle2)
        
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
    Title = "Save Changes?"
    
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
        
    End If
    
    
Exit_cmdCancel_Click:
    Exit Sub

Err_cmdCancel_Click:
    GoTo Exit_cmdCancel_Click
    
End Sub

Private Sub cmdOK_Click()
On Error GoTo Err_cmdOK_Click

    Dim Response, Style
    Dim sTitle As String, sMsg As String
    
    sMsg = "You did not select anything on this form, do you wish to exit?"
    Style = vbYesNo
    sTitle = "Enter List Values"
    
    
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

    'retrieve any data from the main form
   
    Call DataLoad
   
End Sub

Private Sub txtCNm1_LostFocus()
On Error GoTo Err_txtCNm1_LostFocus


    Dim tempString As String
    tempString = txtCNm1.Text
    
    'check for any value in field
    If tempString <> "" Then
    
        'found a valid, evaluate it
        If Len(tempString) < 3 Then
    
            MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Enter List Values"
                     
            'set focus back to txtCNm1 and highlight entry
            txtCNm1.SetFocus
            txtCNm1.SelStart = 0
            txtCNm1.SelLength = Len(tempString)
         
        Else
        
            'entry is long enough, check for special characters
             If SpecialCharsChk(tempString) Then
                
                'special character found flag as error
                MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Enter List Values"
                txtCNm1.SetFocus
                txtCNm1.SelStart = 0
                txtCNm1.SelLength = Len(tempString)
                
             End If
             
            
        
        End If
        
    End If
    
   
    
Exit_txtCNm1_LostFocus:
    Exit Sub
    
Err_txtCNm1_LostFocus:
    GoTo Exit_txtCNm1_LostFocus
    
End Sub



Private Sub txtCNm2_LostFocus()
On Error GoTo Err_txtCNm2_LostFocus


    Dim tempString As String
    tempString = txtCNm2.Text
    
    'check for any value in field
    If tempString <> "" Then
    
        'found a valid, evaluate it
        If Len(tempString) < 3 Then
    
             MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Enter List Values"
                     
            'set focus back to txtwidget1 and highlight entry
            txtCNm2.SetFocus
            txtCNm2.SelStart = 0
            txtCNm2.SelLength = Len(tempString)
         
        Else
        
            'entry is long enough, check for special characters
             If SpecialCharsChk(tempString) Then
             
                'special character found flag as error
                MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Enter List Values"
                txtCNm2.SetFocus
                txtCNm2.SelStart = 0
                txtCNm2.SelLength = Len(tempString)
                
             End If
             
            
        
        End If
        
    End If
    
    
Exit_txtCNm2_LostFocus:
    Exit Sub
    
Err_txtCNm2_LostFocus:
    GoTo Exit_txtCNm2_LostFocus
    
End Sub

Private Sub txtCNm3_LostFocus()
On Error GoTo Err_txtCNm3_LostFocus


    Dim tempString As String
    tempString = txtCNm3.Text
    
    'check for any value in field
    If tempString <> "" Then
    
        'found a valid, evaluate it
        If Len(tempString) < 3 Then
    
             MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Enter List Values"
                     
            'set focus back to txtwidget1 and highlight entry
            txtCNm3.SetFocus
            txtCNm3.SelStart = 0
            txtCNm3.SelLength = Len(tempString)
         
        Else
        
            'entry is long enough, check for special characters
             If SpecialCharsChk(tempString) Then
             
                'special character found flag as error
                MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Enter List Values"
                txtCNm3.SetFocus
                txtCNm3.SelStart = 0
                txtCNm3.SelLength = Len(tempString)
                
             End If
             
            
        
        End If
        
    End If
    
    
Exit_txtCNm3_LostFocus:
    Exit Sub
    
Err_txtCNm3_LostFocus:
    GoTo Exit_txtCNm3_LostFocus
    
End Sub

Private Sub txtCNm4_LostFocus()
On Error GoTo Err_txtCNm4_LostFocus


    Dim tempString As String
    tempString = txtCNm4.Text
    
    'check for any value in field
    If tempString <> "" Then
    
        'found a valid, evaluate it
        If Len(tempString) < 3 Then
    
             MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Enter List Values"
            
            'set focus back to txtwidget1 and highlight entry
            txtCNm4.SetFocus
            txtCNm4.SelStart = 0
            txtCNm4.SelLength = Len(tempString)
         
        Else
        
            'entry is long enough, check for special characters
             If SpecialCharsChk(tempString) Then
             
                'special character found flag as error
                MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Enter List Values"
                txtCNm4.SetFocus
                txtCNm4.SelStart = 0
                txtCNm4.SelLength = Len(tempString)
                
             End If
             
            
        
        End If
        
    End If
    
    
Exit_txtCNm4_LostFocus:
    Exit Sub
    
Err_txtCNm4_LostFocus:
    GoTo Exit_txtCNm4_LostFocus
    
End Sub

Private Sub txtCNm5_LostFocus()
On Error GoTo Err_txtCNm5_LostFocus


    Dim tempString As String
    tempString = txtCNm5.Text
    
    'check for any value in field
    If tempString <> "" Then
    
        'found a valid, evaluate it
        If Len(tempString) < 3 Then
    
            MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Enter List Values"
            
            'set focus back to txtwidget1 and highlight entry
            txtCNm5.SetFocus
            txtCNm5.SelStart = 0
            txtCNm5.SelLength = Len(tempString)
         
        Else
        
            'entry is long enough, check for special characters
             If SpecialCharsChk(tempString) Then
             
                'special character found flag as error
                MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Enter List Values"
                txtCNm5.SetFocus
                txtCNm5.SelStart = 0
                txtCNm5.SelLength = Len(tempString)
                
             End If
             
            
        
        End If
        
    End If
    
    
Exit_txtCNm5_LostFocus:
    Exit Sub
    
Err_txtCNm5_LostFocus:
    GoTo Exit_txtCNm5_LostFocus
    
End Sub

Private Sub txtCNm6_LostFocus()
On Error GoTo Err_txtCNm6_LostFocus


    Dim tempString As String
    tempString = txtCNm6.Text
    
    'check for any value in field
    If tempString <> "" Then
    
        'found a valid, evaluate it
        If Len(tempString) < 3 Then
    
             MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Enter List Values"
                     
            'set focus back to txtwidget1 and highlight entry
            txtCNm6.SetFocus
            txtCNm6.SelStart = 0
            txtCNm6.SelLength = Len(tempString)
         
        Else
        
            'entry is long enough, check for special characters
             If SpecialCharsChk(tempString) Then
             
                'special character found flag as error
                MsgBox "Please enter a C name between 3 and 18 characters that does not contain special characters and spaces.", vbOKOnly, "Enter List Values"
                txtCNm6.SetFocus
                txtCNm6.SelStart = 0
                txtCNm6.SelLength = Len(tempString)
                
             End If
             
            
        
        End If
        
    End If
    
    
Exit_txtCNm6_LostFocus:
    Exit Sub
    
Err_txtCNm6_LostFocus:
    GoTo Exit_txtCNm6_LostFocus
    
End Sub

Private Sub txtLiteral1_Change()
On Error GoTo Err_txtLiteral1_Change
   
    If txtLiteral1.Text = "" Then
        txtLiteral1.BackColor = &HFFFFFF
    End If
    
Exit_txtLiteral1_Change:
    Exit Sub

Err_txtLiteral1_Change:
    MsgBox Error$
    Resume Exit_txtLiteral1_Change
    
End Sub

Private Sub txtLiteral1_LostFocus()
On Error GoTo Err_txtLiteral1_LostFocus
    
    If txtLiteral1.Text = "" Then
        txtLiteral1.BackColor = &HFFFFFF
    End If
    
Exit_txtLiteral1_LostFocus:
    Exit Sub

Err_txtLiteral1_LostFocus:
    MsgBox Error$
    Resume Exit_txtLiteral1_LostFocus
    

End Sub

Private Sub txtLiteral2_Change()
On Error GoTo Err_txtLiteral2_Change
    
    If txtLiteral2.Text = "" Then
        txtLiteral2.BackColor = &HFFFFFF
    End If
    
Exit_txtLiteral2_Change:
    Exit Sub

Err_txtLiteral2_Change:
    MsgBox Error$
    Resume Exit_txtLiteral2_Change
    

End Sub

Private Sub txtLiteral2_LostFocus()
On Error GoTo Err_txtLiteral2_LostFocus
    
    If txtLiteral2.Text = "" Then
        txtLiteral2.BackColor = &HFFFFFF
    End If
    
Exit_txtLiteral2_LostFocus:
    Exit Sub

Err_txtLiteral2_LostFocus:
    MsgBox Error$
    Resume Exit_txtLiteral2_LostFocus
    

End Sub

Private Sub txtLiteral3_Change()
On Error GoTo Err_txtLiteral3_Change
    
    If txtLiteral3.Text = "" Then
        txtLiteral3.BackColor = &HFFFFFF
    End If
    
Exit_txtLiteral3_Change:
    Exit Sub

Err_txtLiteral3_Change:
    MsgBox Error$
    Resume Exit_txtLiteral3_Change
    

End Sub

Private Sub txtLiteral3_LostFocus()
On Error GoTo Err_txtLiteral3_LostFocus
    
    If txtLiteral3.Text = "" Then
        txtLiteral3.BackColor = &HFFFFFF
    End If

Exit_txtLiteral3_LostFocus:
    Exit Sub

Err_txtLiteral3_LostFocus:
    MsgBox Error$
    Resume Exit_txtLiteral3_LostFocus

End Sub

Private Sub txtLiteral4_Change()
On Error GoTo Err_txtLiteral4_Change
    
    If txtLiteral4.Text = "" Then
        txtLiteral4.BackColor = &HFFFFFF
    End If
    
Exit_txtLiteral4_Change:
    Exit Sub

Err_txtLiteral4_Change:
    MsgBox Error$
    Resume Exit_txtLiteral4_Change
    

End Sub

Private Sub txtLiteral4_LostFocus()
On Error GoTo Err_txtLiteral4_LostFocus
    
    If txtLiteral4.Text = "" Then
        txtLiteral4.BackColor = &HFFFFFF
    End If
    
Exit_txtLiteral4_LostFocus:
    Exit Sub

Err_txtLiteral4_LostFocus:
    MsgBox Error$
    Resume Exit_txtLiteral4_LostFocus
    

End Sub

Private Sub txtLiteral5_Change()
On Error GoTo Err_txtLiteral5_Change
    
    If txtLiteral5.Text = "" Then
        txtLiteral5.BackColor = &HFFFFFF
    End If
    
Exit_txtLiteral5_Change:
    Exit Sub

Err_txtLiteral5_Change:
    MsgBox Error$
    Resume Exit_txtLiteral5_Change
    

End Sub

Private Sub txtLiteral5_LostFocus()
On Error GoTo Err_txtLiteral5_LostFocus
    
    If txtLiteral5.Text = "" Then
        txtLiteral5.BackColor = &HFFFFFF
    End If
    
Exit_txtLiteral5_LostFocus:
    Exit Sub

Err_txtLiteral5_LostFocus:
    MsgBox Error$
    Resume Exit_txtLiteral5_LostFocus
    

End Sub

Private Sub txtLiteral6_Change()
On Error GoTo Err_txtLiteral6_Change
    
    If txtLiteral6.Text = "" Then
        txtLiteral6.BackColor = &HFFFFFF
    End If
    
Exit_txtLiteral6_Change:
    Exit Sub

Err_txtLiteral6_Change:
    MsgBox Error$
    Resume Exit_txtLiteral6_Change
    

End Sub

Private Sub txtLiteral6_LostFocus()
On Error GoTo Err_txtLiteral6_LostFocus
    
    If txtLiteral6.Text = "" Then
        txtLiteral6.BackColor = &HFFFFFF
    End If
    
Exit_txtLiteral6_LostFocus:
    Exit Sub

Err_txtLiteral6_LostFocus:
    MsgBox Error$
    Resume Exit_txtLiteral6_LostFocus
    

End Sub

Private Sub txtValue1_Change()
On Error GoTo Err_txtValue1_Change
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtValue1.Text
    intZero = 0
    
    If txtValue1.Text = "" Then
        txtValue1.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 2 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtValue1.SetFocus
            txtValue1.SelStart = intZero
            txtValue1.SelLength = Len(strString)
    End If

Exit_txtValue1_Change:
    Exit Sub

Err_txtValue1_Change:
    MsgBox Error$
    Resume Exit_txtValue1_Change
    

End Sub

Private Sub txtValue1_LostFocus()
On Error GoTo Err_txtValue1_LostFocus
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtValue1.Text
    intZero = 0
    
    If txtValue1.Text = "" Then
        txtValue1.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 2 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtValue1.SetFocus
            txtValue1.SelStart = intZero
            txtValue1.SelLength = Len(strString)
    End If

Exit_txtValue1_LostFocus:
    Exit Sub

Err_txtValue1_LostFocus:
    MsgBox Error$
    Resume Exit_txtValue1_LostFocus
    

End Sub

Private Sub txtValue2_Change()
On Error GoTo Err_txtValue2_Change
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtValue2.Text
    intZero = 0
    
    If txtValue2.Text = "" Then
        txtValue2.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 2 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtValue2.SetFocus
            txtValue2.SelStart = intZero
            txtValue2.SelLength = Len(strString)
    End If

Exit_txtValue2_Change:
    Exit Sub

Err_txtValue2_Change:
    MsgBox Error$
    Resume Exit_txtValue2_Change
    

End Sub

Private Sub txtValue2_LostFocus()
On Error GoTo Err_txtValue2_LostFocus
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtValue2.Text
    intZero = 0
    
    If txtValue2.Text = "" Then
        txtValue2.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 2 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtValue2.SetFocus
            txtValue2.SelStart = intZero
            txtValue2.SelLength = Len(strString)
    End If

Exit_txtValue2_LostFocus:
    Exit Sub

Err_txtValue2_LostFocus:
    MsgBox Error$
    Resume Exit_txtValue2_LostFocus
    

End Sub

Private Sub txtValue3_Change()
On Error GoTo Err_txtValue3_Change
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtValue3.Text
    intZero = 0
    
    If txtValue3.Text = "" Then
        txtValue3.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 8 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtValue3.SetFocus
            txtValue3.SelStart = intZero
            txtValue3.SelLength = Len(strString)
    End If

Exit_txtValue3_Change:
    Exit Sub

Err_txtValue3_Change:
    MsgBox Error$
    Resume Exit_txtValue3_Change
    

End Sub

Private Sub txtValue3_LostFocus()
On Error GoTo Err_txtValue3_LostFocus
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtValue3.Text
    intZero = 0
    
    If txtValue3.Text = "" Then
        txtValue3.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 2 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtValue3.SetFocus
            txtValue3.SelStart = intZero
            txtValue3.SelLength = Len(strString)
    End If

Exit_txtValue3_LostFocus:
    Exit Sub

Err_txtValue3_LostFocus:
    MsgBox Error$
    Resume Exit_txtValue3_LostFocus
    

End Sub

Private Sub txtValue4_Change()
On Error GoTo Err_txtValue4_Change
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtValue4.Text
    intZero = 0
    
    If txtValue4.Text = "" Then
        txtValue4.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 2 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtValue4.SetFocus
            txtValue4.SelStart = intZero
            txtValue4.SelLength = Len(strString)
    End If

Exit_txtValue4_Change:
    Exit Sub

Err_txtValue4_Change:
    MsgBox Error$
    Resume Exit_txtValue4_Change
    

End Sub

Private Sub txtValue4_LostFocus()
On Error GoTo Err_txtValue4_LostFocus
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtValue4.Text
    intZero = 0
    
    If txtValue4.Text = "" Then
        txtValue4.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 2 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtValue4.SetFocus
            txtValue4.SelStart = intZero
            txtValue4.SelLength = Len(strString)
    End If

Exit_txtValue4_LostFocus:
    Exit Sub

Err_txtValue4_LostFocus:
    MsgBox Error$
    Resume Exit_txtValue4_LostFocus
    

End Sub

Private Sub txtValue5_Change()
On Error GoTo Err_txtValue5_Change
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtValue5.Text
    intZero = 0
    
    If txtValue5.Text = "" Then
        txtValue5.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 2 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtValue5.SetFocus
            txtValue5.SelStart = intZero
            txtValue5.SelLength = Len(strString)
    End If

Exit_txtValue5_Change:
    Exit Sub

Err_txtValue5_Change:
    MsgBox Error$
    Resume Exit_txtValue5_Change
    

End Sub

Private Sub txtValue5_LostFocus()
On Error GoTo Err_txtValue5_LostFocus
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtValue5.Text
    intZero = 0
    
    If txtValue5.Text = "" Then
        txtValue5.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 2 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtValue1.SetFocus
            txtValue1.SelStart = intZero
            txtValue1.SelLength = Len(strString)
    End If

Exit_txtValue5_LostFocus:
    Exit Sub

Err_txtValue5_LostFocus:
    MsgBox Error$
    Resume Exit_txtValue5_LostFocus
    

End Sub

Private Sub txtValue6_Change()
On Error GoTo Err_txtValue6_Change
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtValue6.Text
    intZero = 0
    
    If txtValue6.Text = "" Then
        txtValue6.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 2 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtValue6.SetFocus
            txtValue6.SelStart = intZero
            txtValue6.SelLength = Len(strString)
    End If

Exit_txtValue6_Change:
    Exit Sub

Err_txtValue6_Change:
    MsgBox Error$
    Resume Exit_txtValue6_Change
    

End Sub

Private Sub txtValue6_LostFocus()
On Error GoTo Err_txtValue6_LostFocus
    
    Dim strString As String
    Dim intZero As Integer
    
    strString = txtValue6.Text
    intZero = 0
    
    If txtValue6.Text = "" Then
        txtValue6.BackColor = &HFFFFFF
    End If
    
    If SpecialCharsChk(strString) Then
            MsgBox "Please enter a value no greater than 2 characters that does not contain special characters.", vbOKOnly, "Data Element Template"
            txtValue6.SetFocus
            txtValue6.SelStart = intZero
            txtValue6.SelLength = Len(strString)
    End If

Exit_txtValue6_LostFocus:
    Exit Sub

Err_txtValue6_LostFocus:
    MsgBox Error$
    Resume Exit_txtValue6_LostFocus
    

End Sub

Private Sub txtWidget1_LostFocus()
On Error GoTo Err_txtWidget1


    Dim sString As String
    sString = txtWidget1.Text
    
    'check for any value in field
    If sString <> "" Then
    
        'found something, evaluate it
        If Len(sString) < 3 Then
    
             MsgBox "Please enter a widget name between 3 and 18 characters that does not contain special characters." & _
            "Widget Name.", vbOKOnly, "Enter List Values"
         
            'set focus back to txtwidget1 and highlight entry
            txtWidget1.SetFocus
            txtWidget1.SelStart = 0
            txtWidget1.SelLength = Len(sString)
         
        Else
        
            'entry is long enough, check for special characters
             If SpecialCharsChk(sString) Or NoSpace(sString) Then
                
                'special character found flag as error
                MsgBox "Please enter a widget name between 3 and 18 characters that does not contain special characters.", vbOKOnly, "Enter List Values"
                txtWidget1.SetFocus
                txtWidget1.SelStart = 0
                txtWidget1.SelLength = Len(sString)
                
             End If
                   
        End If
        
    End If
    
Exit_txtWidget1:
    Exit Sub
    
Err_txtWidget1:
    GoTo Exit_txtWidget1

         
End Sub

Private Sub txtWidget2_LostFocus()
On Error GoTo Err_txtWidget2_LostFocus


    Dim tempString As String
    tempString = txtWidget2.Text
    
    'check for any value in field
    If tempString <> "" Then
    
        'found a valid, evaluate it
        If Len(tempString) < 3 Then
    
             MsgBox "Please enter a widget name between 3 and 18 characters that does not contain special characters.", vbOKOnly, "Enter List Values"
                     
            'set focus back to txtwidget1 and highlight entry
            txtWidget2.SetFocus
            txtWidget2.SelStart = 0
            txtWidget2.SelLength = Len(tempString)
         
        Else
            
            'entry is long enough, check for special characters
             If SpecialCharsChk(tempString) Or NoSpace(tempString) Then
             
                'special character found flag as error
                MsgBox "Please enter a widget name between 3 and 18 characters that does not contain special characters.", vbOKOnly, "Enter List Values"
                txtWidget2.SetFocus
                txtWidget2.SelStart = 0
                txtWidget2.SelLength = Len(tempString)
                
             End If
             
        End If
        
    End If
    
    
Exit_txtWidget2_LostFocus:
    Exit Sub
    
Err_txtWidget2_LostFocus:
    GoTo Exit_txtWidget2_LostFocus
    
End Sub

Private Sub txtWidget3_LostFocus()
On Error GoTo Err_txtWidget3_LostFocus


    Dim tempString As String
    tempString = txtWidget3.Text
    
    'check for any value in field
    If tempString <> "" Then
    
        'found a valid, evaluate it
        If Len(tempString) < 3 Then
    
             MsgBox "Please enter a widget name between 3 and 18 characters that does not contain special characters.", vbOKOnly, "Enter List Values"
         
            'set focus back to txtwidget1 and highlight entry
            txtWidget3.SetFocus
            txtWidget3.SelStart = 0
            txtWidget3.SelLength = Len(tempString)
         
        Else
            
            'entry is long enough, check for special characters
             If SpecialCharsChk(tempString) Or NoSpace(tempString) Then
             
                'special character found flag as error
                MsgBox "Please enter a widget name between 3 and 18 characters that does not contain special characters.", vbOKOnly, "Enter List Values"
                txtWidget3.SetFocus
                txtWidget3.SelStart = 0
                txtWidget3.SelLength = Len(tempString)
                
             End If
        
        End If
        
    End If
    
    
Exit_txtWidget3_LostFocus:
    Exit Sub
    
Err_txtWidget3_LostFocus:
    GoTo Exit_txtWidget3_LostFocus
    
    
End Sub

Private Sub txtWidget4_LostFocus()
On Error GoTo Err_txtWidget4_LostFocus


    Dim tempString As String
    tempString = txtWidget4.Text
    
    'check for any value in field
    If tempString <> "" Then
    
        'found a valid, evaluate it
        If Len(tempString) < 3 Then
    
             MsgBox "Please enter a widget name between 3 and 18 characters that does not contain special characters.", vbOKOnly, "Enter List Values"
                     
            'set focus back to txtwidget1 and highlight entry
            txtWidget4.SetFocus
            txtWidget4.SelStart = 0
            txtWidget4.SelLength = Len(tempString)
         
        Else
            
            'entry is long enough, check for special characters
             If SpecialCharsChk(tempString) Or NoSpace(tempString) Then
             
                'special character found flag as error
                MsgBox "Please enter a widget name between 3 and 18 characters that does not contain special characters.", vbOKOnly, "Enter List Values"
                txtWidget4.SetFocus
                txtWidget4.SelStart = 0
                txtWidget4.SelLength = Len(tempString)
                
             End If
        
        End If
        
    End If
    
    
Exit_txtWidget4_LostFocus:
    Exit Sub
    
Err_txtWidget4_LostFocus:
    GoTo Exit_txtWidget4_LostFocus
End Sub

Private Sub txtWidget5_LostFocus()
On Error GoTo Err_txtWidget5_LostFocus


    Dim tempString As String
    tempString = txtWidget5.Text
    
    'check for any value in field
    If tempString <> "" Then
    
        'found a valid, evaluate it
        If Len(tempString) < 3 Then
    
             MsgBox "Please enter a widget name between 3 and 18 characters that does not contain special characters.", vbOKOnly, "Enter List Values"
            
            'set focus back to txtwidget1 and highlight entry
            txtWidget5.SetFocus
            txtWidget5.SelStart = 0
            txtWidget5.SelLength = Len(tempString)
         
        Else
            
            'entry is long enough, check for special characters
             If SpecialCharsChk(tempString) Or NoSpace(tempString) Then
             
                'special character found flag as error
                MsgBox "Please enter a widget name between 3 and 18 characters that does not contain special characters.", vbOKOnly, "Enter List Values"
                txtWidget5.SetFocus
                txtWidget5.SelStart = 0
                txtWidget5.SelLength = Len(tempString)
                
             End If
        
        End If
        
    End If
    
    
Exit_txtWidget5_LostFocus:
    Exit Sub
    
Err_txtWidget5_LostFocus:
    GoTo Exit_txtWidget5_LostFocus
    
End Sub

Private Sub txtWidget6_LostFocus()
On Error GoTo Err_txtWidget6_LostFocus


    Dim tempString As String
    tempString = txtWidget6.Text
    
    'check for any value in field
    If tempString <> "" Then
    
        'found a valid, evaluate it
        If Len(tempString) < 3 Then
    
             MsgBox "Please enter a widget name between 3 and 18 characters that does not contain special characters.", vbOKOnly, "Enter List Values"
                     
            'set focus back to txtwidget1 and highlight entry
            txtWidget6.SetFocus
            txtWidget6.SelStart = 0
            txtWidget6.SelLength = Len(tempString)
         
        Else
            
            'entry is long enough, check for special characters
             If SpecialCharsChk(tempString) Or NoSpace(tempString) Then
             
                'special character found flag as error
                MsgBox "Please enter a widget name between 3 and 18 characters that does not contain special characters.", vbOKOnly, "Enter List Values"
                txtWidget6.SetFocus
                txtWidget6.SelStart = 0
                txtWidget6.SelLength = Len(tempString)
                
             End If
        
        End If
        
    End If
    
    
Exit_txtWidget6_LostFocus:
    Exit Sub
    
Err_txtWidget6_LostFocus:
    GoTo Exit_txtWidget6_LostFocus
End Sub

Public Sub DataLoad()
On Error GoTo Err_DataLoad

    Dim myControl As Control
    Dim dllFindPath As New DataTeamToolDLL.PathtoCodes    'added 10/30/97 CMitchell
    Dim myCodestable As New CodesTable
    Dim myDatabase As String
    Dim strPathToCodes
        
    'myDatabase = "o:\tools\DataTeamTool\codestbl\DataTeam.mdb"
    
    'Finds the path to where the database DataTeam.mdb is located on users machine
    'which contains the info for the combo boxes.   Added 10/30/97 by Christina Mitchell
    myDatabase = dllFindPath.glrGetRegistryValueFromPath(PATH_TO_DATATEAM_MDB)

    On Error Resume Next
    
    'load all the combo boxes with data from the tblYesNo
    For Each myControl In frmListValues.Controls

        Call LoadProc(myDatabase, myControl, "tblYesNo", "YesNoCd", "YesNoDcd", "", , True)

    Next myControl
    
Exit_DataLoad:
    Exit Sub
    
Err_DataLoad:
    MsgBox Error$
    Resume Err_DataLoad
    
End Sub
