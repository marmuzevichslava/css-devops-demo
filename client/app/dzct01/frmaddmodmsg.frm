VERSION 5.00
Begin VB.Form frmAddModMsg 
   ClientHeight    =   4740
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9135
   Icon            =   "frmAddModMsg.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4740
   ScaleWidth      =   9135
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox cbxRelease 
      Height          =   315
      Left            =   6600
      TabIndex        =   21
      Top             =   2520
      Width           =   2295
   End
   Begin VB.ComboBox cbxApplication 
      Height          =   315
      ItemData        =   "frmAddModMsg.frx":030A
      Left            =   6600
      List            =   "frmAddModMsg.frx":030C
      TabIndex        =   20
      Top             =   1560
      Width           =   2295
   End
   Begin VB.ComboBox cbxPlatform 
      Height          =   315
      Left            =   6600
      TabIndex        =   16
      Top             =   2040
      Width           =   2295
   End
   Begin VB.ComboBox cbxClients 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1680
      TabIndex        =   15
      Top             =   3000
      Width           =   2895
   End
   Begin VB.ComboBox cbxDefaultButton 
      Height          =   315
      Left            =   1680
      TabIndex        =   14
      Top             =   2520
      Width           =   2895
   End
   Begin VB.ComboBox cbxIcon 
      Height          =   315
      Left            =   1680
      TabIndex        =   13
      Top             =   2040
      Width           =   2895
   End
   Begin VB.ComboBox cbxButtons 
      Height          =   315
      Left            =   1680
      TabIndex        =   12
      Top             =   1560
      Width           =   2895
   End
   Begin VB.TextBox txtCode 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1680
      TabIndex        =   4
      ToolTipText     =   "Key Code to Add/Modify"
      Top             =   240
      Width           =   1290
   End
   Begin VB.TextBox txtMsgBox 
      BackColor       =   &H00FFFFFF&
      Height          =   675
      Left            =   1680
      TabIndex        =   3
      ToolTipText     =   "Decode for the current Key"
      Top             =   720
      Width           =   7245
   End
   Begin VB.TextBox txtComments 
      Height          =   315
      Left            =   1680
      TabIndex        =   2
      ToolTipText     =   "Comments for current Key"
      Top             =   3540
      Width           =   7245
   End
   Begin VB.CommandButton cmdProcess 
      Caption         =   "&Add"
      Enabled         =   0   'False
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
      Left            =   3090
      TabIndex        =   1
      ToolTipText     =   "Add the current user id"
      Top             =   4110
      Width           =   1215
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Close"
      Default         =   -1  'True
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
      Left            =   4740
      TabIndex        =   0
      ToolTipText     =   "Add the current user id"
      Top             =   4110
      Width           =   1215
   End
   Begin VB.Label Label10 
      Caption         =   "Release:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   5400
      TabIndex        =   19
      Top             =   2550
      Width           =   780
   End
   Begin VB.Label Label9 
      Caption         =   "Platform:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   5400
      TabIndex        =   18
      Top             =   2070
      Width           =   840
   End
   Begin VB.Label Label8 
      Caption         =   "Application:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   5400
      TabIndex        =   17
      Top             =   1590
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "Code:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   120
      TabIndex        =   11
      Top             =   277
      Width           =   615
   End
   Begin VB.Label Label1 
      Caption         =   "Message Box Text:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   465
      Left            =   120
      TabIndex        =   10
      Top             =   825
      Width           =   840
   End
   Begin VB.Label Label3 
      Caption         =   "Client:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   120
      TabIndex        =   9
      Top             =   3037
      Width           =   615
   End
   Begin VB.Label Label4 
      Caption         =   "Buttons:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   120
      TabIndex        =   8
      Top             =   1597
      Width           =   735
   End
   Begin VB.Label Label5 
      Caption         =   "Icons:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   120
      TabIndex        =   7
      Top             =   2100
      Width           =   480
   End
   Begin VB.Label Label6 
      Caption         =   "Default Buttons:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   120
      TabIndex        =   6
      Top             =   2550
      Width           =   1500
   End
   Begin VB.Label Label7 
      Caption         =   "Comments:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   120
      TabIndex        =   5
      Top             =   3570
      Width           =   840
   End
End
Attribute VB_Name = "frmAddModMsg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public bFormLoaded As Boolean
Public bModified As Boolean
'Public CurClient As Integer
Public bDecodeOK As Boolean
Public bKeyOK As Boolean
Public bChangeKey As Boolean


'***************************************************************************************************************
Private Sub cmdCancel_Click()
'***************************************************************************************************************
    Unload Me
End Sub

'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    Dim RC As Integer, x As Integer
    
    bFormLoaded = False
    bChangeKey = False
   
    'Build Combo Boxes
    BuildComboBoxes
   
    'If we are adding a new Key...
'    If (bAddNewKey) Then
'
'        Me.Caption = CurTable & " - Add New Key"
'        cmdProcess.Caption = "&Add"
''        txtKey.Text = "E"
''        txtKey.SelStart = Len(txtKey.Text) + 1
'
'
'    'We are modifying a current Key.
'    Else
'
'        Me.Caption = CurTable & " - Modify Existing Key"
'        cmdProcess.Caption = "&Modify"
'        txtKey.Text = CurKey
'
''        strsql = "select Decode, Client, Description, CName, CobolName, Comments " & _
'                 "from tblEntries where TableName = " & Chr(39) & CurTable & Chr(39) & _
'                 " and Key = " & Chr(39) & CurKey & Chr(39)
''        Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
'
'        If Not DaoRS.EOF Then
'
'            'Get the current decode.
'            If Len(DaoRS(0).Value) > 0 Then
''                txtDecode.Text = RTrim(DaoRS(0).Value)
'            Else
''                txtDecode.Text = " "
'            End If
'
'
'            'Get the description.
'            If Len(DaoRS(2).Value) > 0 Then
''                txtDesc.Text = RTrim(DaoRS(2).Value)
'            Else
''                txtDesc.Text = " "
'            End If
'
'            'Get the comments.
'            If (Len(DaoRS(5).Value) > 0) Then
'                txtComments.Text = RTrim(DaoRS(5).Value)
'            Else
'                txtComments.Text = " "
'            End If
'
'            'Set up the client combo box.
'            For x = 0 To UBound(ClientArray)
'                If (DaoRS(1).Value = ClientArray(x).Code) Then
'                    cbxClients.ListIndex = x
'                    CurClient = DaoRS(1).Value
'                    Exit For
'                End If
'            Next
'
'            DaoRS.Close
'
'        End If
'
'    End If
    
    bModified = False
    bFormLoaded = True
    
End Sub

'***************************************************************************************************************
Private Sub BuildComboBoxes()
'***************************************************************************************************************
       
    'Build Buttons combo box
    GetButtonCBox Me.cbxButtons
    
    'Build Icon combo box
    GetIconCBox Me.cbxIcon
    
    'Build DefaultButton combo box
    GetDefaultButtonCBox Me.cbxDefaultButton
    
    'Build Client combo box
    GetClientCBox Me.cbxClients
    
    'Build Application combo box
    GetApplicationCBox Me.cbxApplication
        
    'Build Platform combo box
    GetPlatformCBox Me.cbxPlatform
    
    'Build Release combo box
    GetReleaseCBox Me.cbxRelease
    
End Sub
