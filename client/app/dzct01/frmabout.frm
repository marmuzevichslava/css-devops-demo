VERSION 5.00
Begin VB.Form frmAbout 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   1875
   ClientLeft      =   45
   ClientTop       =   45
   ClientWidth     =   4035
   ControlBox      =   0   'False
   Icon            =   "frmAbout.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1875
   ScaleWidth      =   4035
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Cancel"
      Height          =   375
      Left            =   1440
      TabIndex        =   3
      Top             =   1200
      Width           =   1215
   End
   Begin VB.PictureBox Picture1 
      BorderStyle     =   0  'None
      Height          =   495
      Left            =   240
      Picture         =   "frmAbout.frx":030A
      ScaleHeight     =   495
      ScaleWidth      =   495
      TabIndex        =   1
      Top             =   240
      Width           =   495
   End
   Begin VB.Label lblCopyright 
      Caption         =   "Copyright: 1997, Andersen Consulting"
      Height          =   255
      Left            =   900
      TabIndex        =   4
      Top             =   600
      Width           =   2775
   End
   Begin VB.Label lblAuthor 
      Caption         =   "Author:  SolutionWorks"
      Height          =   255
      Left            =   900
      TabIndex        =   2
      Top             =   840
      Width           =   2850
   End
   Begin VB.Label lblTitle 
      Caption         =   "Codes Table Explorer"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   900
      TabIndex        =   0
      Top             =   240
      Width           =   2940
   End
End
Attribute VB_Name = "frmAbout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    lblTitle.Caption = "Codes Table Explorer v" & App.Major & "." & App.Minor
End Sub
