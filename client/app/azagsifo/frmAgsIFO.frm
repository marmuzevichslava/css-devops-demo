VERSION 5.00
Begin VB.Form frmAgsIFO 
   Caption         =   "AGS Interface Object Stub"
   ClientHeight    =   8190
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   6600
   Icon            =   "frmAgsIFO.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8190
   ScaleWidth      =   6600
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame2 
      Caption         =   "Input"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3255
      Left            =   120
      TabIndex        =   17
      Top             =   120
      Width           =   6375
      Begin VB.CommandButton cmdSubmit 
         Caption         =   "&Submit"
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
         Left            =   2520
         TabIndex        =   0
         Top             =   2760
         Width           =   1215
      End
      Begin VB.Frame Frame4 
         Caption         =   "MsgHeader"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2415
         Left            =   120
         TabIndex        =   19
         Top             =   240
         Width           =   2415
         Begin VB.ComboBox cmbForceCache 
            Height          =   315
            ItemData        =   "frmAgsIFO.frx":0442
            Left            =   1335
            List            =   "frmAgsIFO.frx":044C
            TabIndex        =   5
            Top             =   1950
            Width           =   900
         End
         Begin VB.ComboBox cmbForceCall 
            Height          =   315
            ItemData        =   "frmAgsIFO.frx":045D
            Left            =   1335
            List            =   "frmAgsIFO.frx":0467
            TabIndex        =   4
            Top             =   1560
            Width           =   900
         End
         Begin VB.TextBox txtCacheTimeLen 
            Height          =   315
            Left            =   1335
            TabIndex        =   3
            Top             =   1200
            Width           =   900
         End
         Begin VB.TextBox txtTxVer 
            Height          =   315
            Left            =   1335
            TabIndex        =   2
            Top             =   840
            Width           =   900
         End
         Begin VB.TextBox txtTxID 
            Height          =   315
            Left            =   1335
            TabIndex        =   1
            Top             =   480
            Width           =   900
         End
         Begin VB.Label Label5 
            Caption         =   "TxID:"
            Height          =   255
            Left            =   240
            TabIndex        =   24
            Top             =   525
            Width           =   735
         End
         Begin VB.Label Label4 
            Caption         =   "TxVer:"
            Height          =   255
            Left            =   240
            TabIndex        =   23
            Top             =   870
            Width           =   735
         End
         Begin VB.Label Label3 
            Caption         =   "Cache Time:"
            Height          =   255
            Left            =   240
            TabIndex        =   22
            Top             =   1245
            Width           =   1095
         End
         Begin VB.Label Label2 
            Caption         =   "Force Call:"
            Height          =   255
            Left            =   240
            TabIndex        =   21
            Top             =   1620
            Width           =   855
         End
         Begin VB.Label Label1 
            Caption         =   "Force Cache:"
            Height          =   255
            Left            =   240
            TabIndex        =   20
            Top             =   1995
            Width           =   1095
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Input Data"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2415
         Left            =   2640
         TabIndex        =   18
         Top             =   240
         Width           =   3615
         Begin VB.TextBox TxtValue5 
            Height          =   315
            Left            =   1920
            TabIndex        =   15
            Top             =   1950
            Width           =   1455
         End
         Begin VB.TextBox txtTag5 
            Height          =   315
            Left            =   240
            TabIndex        =   14
            Top             =   1950
            Width           =   1455
         End
         Begin VB.TextBox TxtValue4 
            Height          =   315
            Left            =   1920
            TabIndex        =   13
            Top             =   1560
            Width           =   1455
         End
         Begin VB.TextBox txtTag4 
            Height          =   315
            Left            =   240
            TabIndex        =   12
            Top             =   1560
            Width           =   1455
         End
         Begin VB.TextBox TxtValue3 
            Height          =   315
            Left            =   1920
            TabIndex        =   11
            Top             =   1200
            Width           =   1455
         End
         Begin VB.TextBox txtTag3 
            Height          =   315
            Left            =   240
            TabIndex        =   10
            Top             =   1200
            Width           =   1455
         End
         Begin VB.TextBox TxtValue2 
            Height          =   315
            Left            =   1920
            TabIndex        =   9
            Top             =   840
            Width           =   1455
         End
         Begin VB.TextBox txtTag2 
            Height          =   315
            Left            =   240
            TabIndex        =   8
            Top             =   840
            Width           =   1455
         End
         Begin VB.TextBox TxtValue1 
            Height          =   315
            Left            =   1920
            TabIndex        =   7
            Top             =   480
            Width           =   1455
         End
         Begin VB.TextBox txtTag1 
            Height          =   315
            Left            =   240
            TabIndex        =   6
            Top             =   480
            Width           =   1455
         End
         Begin VB.Label Label7 
            Caption         =   "Value:"
            Height          =   255
            Left            =   1920
            TabIndex        =   26
            Top             =   240
            Width           =   735
         End
         Begin VB.Label Label6 
            Caption         =   "Tag:"
            Height          =   255
            Left            =   240
            TabIndex        =   25
            Top             =   240
            Width           =   495
         End
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Output"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4575
      Left            =   120
      TabIndex        =   16
      Top             =   3480
      Width           =   6375
      Begin VB.TextBox txtRC 
         BackColor       =   &H80000004&
         Height          =   315
         Left            =   600
         TabIndex        =   33
         Top             =   350
         Width           =   615
      End
      Begin VB.ListBox lstOutput 
         BackColor       =   &H80000004&
         Columns         =   2
         Height          =   3570
         Left            =   120
         Sorted          =   -1  'True
         TabIndex        =   31
         Top             =   840
         Width           =   6135
      End
      Begin VB.TextBox TxtNumTvPairs 
         BackColor       =   &H80000004&
         Height          =   315
         Left            =   4320
         TabIndex        =   30
         Top             =   350
         Width           =   615
      End
      Begin VB.TextBox txtElapTime 
         BackColor       =   &H80000004&
         Height          =   315
         Left            =   2520
         TabIndex        =   29
         Top             =   350
         Width           =   615
      End
      Begin VB.Label Label10 
         Caption         =   "RC:"
         Height          =   255
         Left            =   240
         TabIndex        =   32
         Top             =   390
         Width           =   495
      End
      Begin VB.Label Label9 
         Caption         =   "NumTvPairs:"
         Height          =   255
         Left            =   3360
         TabIndex        =   28
         Top             =   390
         Width           =   975
      End
      Begin VB.Label Label8 
         Caption         =   "Elapsed Time:"
         Height          =   255
         Left            =   1440
         TabIndex        =   27
         Top             =   390
         Width           =   1095
      End
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuExit 
         Caption         =   "&Exit"
      End
   End
   Begin VB.Menu mnuRequestType 
      Caption         =   "&Request Type"
      Begin VB.Menu mnuCodesTable 
         Caption         =   "&Codes Table"
      End
      Begin VB.Menu mnuCustomerRetrieval 
         Caption         =   "Customer &Retieval"
      End
   End
End
Attribute VB_Name = "frmAgsIFO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function GetTickCount Lib "kernel32" () As Long

Private Sub cmdSubmit_Click()

    Dim rc As Integer
    Dim ForceCall As Boolean
    Dim ForceCache As Boolean
    Dim StartTime As Long
    Dim i As Integer
    
    StartTime = GetTickCount()
    
    Me.txtRC = ""
    Me.txtElapTime = ""
    Me.cmdSubmit.Enabled = False
    Me.lstOutput.Clear
    
    'rc = InitTvList()
    'rc = InitTcpPipe("c1proxyhost", _
    '                 "c1proxy", 5)
    rc = SetTvPair(Me.txtTag1, _
                   Me.TxtValue1)
    rc = SetTvPair(Me.txtTag2, _
                   Me.TxtValue2)
    rc = SetTvPair(Me.txtTag3, _
                   Me.TxtValue3)
    rc = SetTvPair(Me.txtTag4, _
                   Me.TxtValue4)
    rc = SetTvPair(Me.txtTag5, _
                   Me.TxtValue5)
    
    ForceCall = Me.cmbForceCall
    ForceCache = Me.cmbForceCache
    
    Me.txtRC = SendMsg(0, _
                       Me.txtTxID, _
                       Me.txtTxVer, _
                       Me.txtCacheTimeLen, _
                       ForceCall, _
                       ForceCache)

    Me.txtElapTime = Format((GetTickCount - StartTime) / 1000, "0.000")
    
    For i = 1 To NumTvPair
        Me.lstOutput.AddItem ("   " & GetTvPairByIndex(i))
    Next i
    
    Me.TxtNumTvPairs = NumTvPair
    
    Me.cmdSubmit.Enabled = True
    cmdSubmit.SetFocus
    
End Sub

Private Sub Form_Load()

    Call mnuCustomerRetrieval_Click

End Sub

Private Sub mnuCodesTable_Click()

    Me.txtTxID = "51"
    Me.txtTxVer = "1"
    Me.txtCacheTimeLen = "99999"
    Me.cmbForceCall = "True"
    Me.cmbForceCache = "True"
    
    Me.txtTag1 = "TblName"
    Me.txtTag2 = "NumRecReq"
    Me.txtTag3 = ""
    Me.txtTag4 = ""
    Me.txtTag5 = ""
    
    Me.TxtValue1 = "CIS00059"
    Me.TxtValue2 = "50"
    Me.TxtValue3 = ""
    Me.TxtValue4 = ""
    Me.TxtValue5 = ""
    
    Me.mnuCodesTable.Checked = True
    Me.mnuCustomerRetrieval.Checked = False

End Sub

Private Sub mnuCustomerRetrieval_Click()

    Me.txtTxID = "1"
    Me.txtTxVer = "1"
    Me.txtCacheTimeLen = "10"
    Me.cmbForceCall = "True"
    Me.cmbForceCache = "False"
    
    Me.txtTag1 = "KyBa"
    Me.txtTag2 = ""
    Me.txtTag3 = ""
    Me.txtTag4 = ""
    Me.txtTag5 = ""
    
    Me.TxtValue1 = "42301879"
    Me.TxtValue2 = ""
    Me.TxtValue3 = ""
    Me.TxtValue4 = ""
    Me.TxtValue5 = ""
    
    Me.mnuCodesTable.Checked = False
    Me.mnuCustomerRetrieval.Checked = True

End Sub

Private Sub mnuExit_Click()

    'End
    
End Sub

