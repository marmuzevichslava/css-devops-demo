VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.2#0"; "Comctl32.ocx"
Begin VB.Form frmImportStatus 
   Caption         =   "Import Status"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6375
   Icon            =   "frmimportstatus.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   3195
   ScaleWidth      =   6375
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdPrint 
      Caption         =   "&Print"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   1155
      TabIndex        =   0
      Top             =   2820
      Width           =   1215
   End
   Begin VB.CommandButton cmdCommit 
      Caption         =   "&Commit"
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
      Height          =   315
      Left            =   4020
      TabIndex        =   2
      Top             =   2820
      Width           =   1215
   End
   Begin VB.CommandButton cmdRollback 
      Caption         =   "&Rollback"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   2580
      TabIndex        =   1
      Top             =   2820
      Width           =   1215
   End
   Begin ComctlLib.ListView lvErrorList 
      Height          =   1995
      Left            =   150
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   720
      Width           =   6015
      _ExtentX        =   10610
      _ExtentY        =   3519
      View            =   3
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      _Version        =   327680
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      MouseIcon       =   "frmimportstatus.frx":030A
      NumItems        =   0
   End
   Begin VB.Label txtFinalStatus 
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
      Left            =   150
      TabIndex        =   4
      Top             =   75
      Width           =   5940
   End
End
Attribute VB_Name = "frmImportStatus"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'***************************************************************************************************************
Private Sub cmdCommit_Click()
'***************************************************************************************************************
    wsCTM.CommitTrans
    Call MainTreeViewNodeClick(frmMain.tvTreeView.SelectedItem)
    Unload Me
End Sub


'***************************************************************************************************************
Private Sub cmdPrint_Click()
'***************************************************************************************************************
    Dim x As Integer, iStr As Integer, iPg As Integer
    
    Screen.MousePointer = vbHourglass
    iPg = 1
    
    Printer.Orientation = vbPRORLandscape
    Printer.PrintQuality = vbPRPQHigh
    Printer.CurrentX = 0
    Printer.Line Step(5, 5)-Step(15000, 50), , BF
    Printer.FontName = "System"
    Printer.FontBold = True
    Printer.FontSize = 15
    Printer.Print vbLf & "Codes Table Import Error Report" & vbLf
    Printer.FontBold = False
    Printer.FontSize = 10
    Printer.Line Step(5, 5)-Step(15000, 10), , BF
    Printer.CurrentY = Printer.CurrentY + 10
    
    Printer.FontBold = True
    Printer.CurrentX = 0
    Printer.Print "Table"
    Printer.CurrentX = 1000
    Printer.CurrentY = Printer.CurrentY - 234
    Printer.Print "Key"
    Printer.CurrentX = 6000
    Printer.CurrentY = Printer.CurrentY - 234
    Printer.Print "Decode"
    Printer.FontBold = False
    
    Printer.CurrentY = Printer.CurrentY + 10
    
    Printer.Line Step(5, 5)-Step(15000, 10), , BF
    
    Printer.CurrentY = Printer.CurrentY + 10
    
    For x = 1 To lvErrorList.ListItems.Count
        
        If (Printer.CurrentY > 10500) Then
            Printer.CurrentY = 10800
            Printer.CurrentX = 0
            Printer.Line Step(5, 5)-Step(15000, 50), , BF
            
            Printer.CurrentX = 0
            Printer.Print Date & " - " & Time
            
            Printer.CurrentY = Printer.CurrentY - 234
            Printer.CurrentX = 14000
            Printer.Print "Page " & iPg
            iPg = iPg + 1
            
            Printer.NewPage
            
            Printer.CurrentX = 0
            Printer.Line Step(5, 5)-Step(15000, 50), , BF
            Printer.FontName = "System"
            Printer.FontBold = True
            Printer.FontSize = 15
            Printer.Print vbLf & "Codes Table Import Error Report" & vbLf
            Printer.FontBold = False
            Printer.FontSize = 10
            Printer.Line Step(5, 5)-Step(15000, 10), , BF
            Printer.CurrentY = Printer.CurrentY + 10
            
            Printer.FontBold = True
            Printer.CurrentX = 0
            Printer.Print "Table"
            Printer.CurrentX = 1000
            Printer.CurrentY = Printer.CurrentY - 234
            Printer.Print "Key"
            Printer.CurrentX = 6000
            Printer.CurrentY = Printer.CurrentY - 234
            Printer.Print "Decode"
            
            
            Printer.FontBold = False
            Printer.CurrentY = Printer.CurrentY + 10
            Printer.Line Step(5, 5)-Step(15000, 10), , BF
            Printer.CurrentY = Printer.CurrentY + 10
            
        
        Else
            Printer.CurrentX = 0
            Printer.Print lvErrorList.ListItems(x).Text
            Printer.CurrentX = 1000
            Printer.CurrentY = Printer.CurrentY - 234
            Printer.Print lvErrorList.ListItems(x).SubItems(1)
            Printer.CurrentX = 6000
            Printer.CurrentY = Printer.CurrentY - 234
            Printer.Print lvErrorList.ListItems(x).SubItems(2)
        End If
    Next
    
    
    Printer.CurrentY = 10800
    Printer.CurrentX = 0
    Printer.Line Step(5, 5)-Step(15000, 50), , BF
            
    Printer.CurrentX = 0
    Printer.Print Date & " - " & Time
            
    Printer.CurrentY = Printer.CurrentY - 234
    Printer.CurrentX = 14000
    Printer.Print "Page " & iPg
        
    Printer.EndDoc
    
    Screen.MousePointer = vbNormal

End Sub

'***************************************************************************************************************
Private Sub cmdRollback_Click()
'***************************************************************************************************************
    wsCTM.Rollback
    Unload Me
End Sub


'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    Dim itmX As ListItem, x As Integer
    
    Me.Caption = "Import Status"
    txtFinalStatus.Caption = "A total of " & ImportCntr & " records were successfully modified. " & _
                             "The following " & UBound(ImportErrArray) & " record(s) failed during processing:"
    
    If UBound(ImportErrArray) = 0 Then cmdPrint.Enabled = False
    
    lvErrorList.ColumnHeaders.Add , , "Table", 800, 0
    lvErrorList.ColumnHeaders.Add , , "Key", 800, 0
    lvErrorList.ColumnHeaders.Add , , "Decode", 1400, 0
    lvErrorList.ColumnHeaders.Add , , "Client", 800, 0
    lvErrorList.ColumnHeaders.Add , , "Action", 800, 0
    
    For x = 0 To UBound(ImportErrArray)
        Set itmX = lvErrorList.ListItems.Add(, , ImportErrArray(x).Table)
            itmX.SubItems(1) = ImportErrArray(x).Key
            itmX.SubItems(2) = ImportErrArray(x).Decode
            itmX.SubItems(3) = ImportErrArray(x).Client
            itmX.SubItems(4) = ImportErrArray(x).Action
    Next
    
    ReDim ImportErrArray(0)
    
End Sub
