VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.2#0"; "COMCTL32.OCX"
Begin VB.Form frmStatus 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   1395
   ClientLeft      =   45
   ClientTop       =   45
   ClientWidth     =   4065
   ControlBox      =   0   'False
   Icon            =   "frmStatus.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1395
   ScaleWidth      =   4065
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Cancel"
      Default         =   -1  'True
      Height          =   390
      Left            =   1425
      TabIndex        =   2
      Top             =   900
      Width           =   1215
   End
   Begin ComctlLib.ProgressBar pgbStatus 
      Height          =   240
      Left            =   150
      TabIndex        =   1
      Top             =   525
      Width           =   3765
      _ExtentX        =   6641
      _ExtentY        =   423
      _Version        =   327680
      Appearance      =   1
   End
   Begin VB.Label lblStatus 
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   165
      Left            =   150
      TabIndex        =   0
      Top             =   150
      Width           =   3765
   End
End
Attribute VB_Name = "frmStatus"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdCancel_Click()
    modGenerateCopybook.bCancel = True
    Call CancelCmd
End Sub

Public Sub CancelCmd()
    Unload Me

End Sub
