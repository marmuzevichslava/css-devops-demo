VERSION 5.00
Begin VB.Form frmAddModTable 
   Caption         =   "Modify Current Codes Table"
   ClientHeight    =   3840
   ClientLeft      =   3345
   ClientTop       =   2490
   ClientWidth     =   5700
   Icon            =   "frmaddmodtable.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3840
   ScaleWidth      =   5700
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
      Height          =   330
      Left            =   3120
      TabIndex        =   7
      ToolTipText     =   "Return to main"
      Top             =   3240
      Width           =   1215
   End
   Begin VB.CommandButton cmdAddTbl 
      Caption         =   "&Modify Table"
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
      Height          =   330
      Left            =   1440
      TabIndex        =   6
      ToolTipText     =   "Modify Codes Table"
      Top             =   3240
      Width           =   1380
   End
   Begin VB.ComboBox cbxTblType 
      Height          =   315
      Left            =   1440
      TabIndex        =   0
      Top             =   135
      Width           =   1905
   End
   Begin VB.TextBox txtDescription 
      BackColor       =   &H00FFFFFF&
      Height          =   675
      Left            =   240
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   5
      ToolTipText     =   "Description for the table"
      Top             =   2400
      Width           =   5415
   End
   Begin VB.TextBox txtKeyLength 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2520
      TabIndex        =   1
      ToolTipText     =   "Codes Table Max Key Length"
      Top             =   600
      Width           =   765
   End
   Begin VB.TextBox txtDecodeLength 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2520
      TabIndex        =   3
      ToolTipText     =   "Codes Table Max Decode Lenght"
      Top             =   1320
      Width           =   765
   End
   Begin VB.TextBox txtDecodeDisplacement 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2520
      TabIndex        =   4
      ToolTipText     =   "Codes Table Max Decode Displacement"
      Top             =   1680
      Width           =   765
   End
   Begin VB.TextBox txtDataLength 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2520
      TabIndex        =   2
      ToolTipText     =   "Codes Table Max Data Length"
      Top             =   960
      Width           =   765
   End
   Begin VB.Label Label3 
      Caption         =   "Description:"
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
      Left            =   240
      TabIndex        =   13
      Top             =   2160
      Width           =   1290
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "Type:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   120
      TabIndex        =   12
      Top             =   165
      Width           =   615
   End
   Begin VB.Label Label6 
      Caption         =   "Key Length:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   240
      TabIndex        =   11
      Top             =   720
      Width           =   1125
   End
   Begin VB.Label Label7 
      Caption         =   "Decode Length:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   240
      TabIndex        =   10
      Top             =   1440
      Width           =   1485
   End
   Begin VB.Label Label8 
      Caption         =   "Decode Displacement:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   240
      TabIndex        =   9
      Top             =   1800
      Width           =   1965
   End
   Begin VB.Label Label9 
      Caption         =   "Data Length:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   240
      TabIndex        =   8
      Top             =   1080
      Width           =   1125
   End
End
Attribute VB_Name = "frmAddModTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdAddTbl_Click()

    'If (txtCenturyDelimeter.Text = "") Then txtCenturyDelimeter.Text = " "
    If (txtDataLength.Text = "") Then txtDataLength.Text = " "
    If (txtDecodeDisplacement.Text = "") Then txtDecodeDisplacement.Text = " "
    If (txtDecodeLength.Text = "") Then txtDecodeLength.Text = " "
    If (txtDescription.Text = "") Then txtDescription.Text = " "
    If (txtKeyLength.Text = "") Then txtKeyLength.Text = " "
    
    For x = 0 To UBound(TableTypes)
        If (cbxTblType.Text = TableTypes(x).TableTypeName) Then
            CurrentTblType = TableTypes(x).TableTypeCode
        End If
    Next
        
    'Put together the base update SQL
    strsql = "UPDATE tblTables SET " & _
             "TableType = " & Chr(34) & CurrentTblType & Chr(34) & ", " & _
             "DecodeLen = " & Chr(34) & txtDecodeLength.Text & Chr(34) & ", " & _
             "DecodeDisplacement = " & txtDecodeDisplacement.Text & ", " & _
             "Description = " & Chr(34) & txtDescription.Text & Chr(34) & ", " & _
             "DataLen = " & Chr(34) & txtDataLength.Text & Chr(34) & ", " & _
             "KeyLen = " & Chr(34) & txtKeyLength.Text & Chr(34) & _
             " WHERE TableName = " & Chr(34) & CurTable & Chr(34)
        
    'Set up the error handling.
    On Error GoTo UpdateError
    
    'Begin a new transaction.
     wsCTM.BeginTrans

    'Execute the update.
    dbCTM.Execute strsql
            
    'Check the results of the insert.
    If (dbCTM.RecordsAffected = 1) Then
        wsCTM.CommitTrans
        ModifyRecord = True
        frmMain.txtDataLength.Text = Me.txtDataLength.Text
        frmMain.txtKeyLength.Text = Me.txtKeyLength.Text
        frmMain.txtDecodeDisplacement.Text = Me.txtDecodeDisplacement.Text
        frmMain.txtDecodeLength.Text = Me.txtDecodeLength.Text
        'frmMain.txtCenturyDelim.Text = Me.txtCenturyDelimeter.Text
        'frmMain.chkStatic.Value = Me.chkStaticTable.Value
        If (Len(Me.txtDescription.Text) = 0) Then
            frmMain.sbStatusBar.Panels(1).Text = "No Description Available"
        Else
            frmMain.sbStatusBar.Panels(1).Text = Me.txtDescription.Text
        End If
    Else
        wsCTM.Rollback
        ModifyRecord = False
    End If

If (ModifyRecord = False) Then

UpdateError:
    Dim msg As String, RC As Integer
    msg = "An error has occured within ModifyRecord of frmAddModKey" & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    
    RC = MsgBox(msg, vbOKOnly + vbCritical + vbMsgBoxHelpButton + vbApplicationModal, "Codes Table Explorer", Err.HelpFile, Err.HelpContext)
    Resume Next
End If

Unload Me

End Sub

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub Form_Load()

    For x = 0 To UBound(TableTypes)
        cbxTblType.AddItem (TableTypes(x).TableTypeName)
    Next

    strsql = "select TableType, DecodeLen, DecodeDisplacement, " & _
             "DataLen, KeyLen, Description " & _
             "from tblTables where TableName = " & Chr(34) & CurTable & Chr(34)
        
         Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
         If Not DaoRS.EOF Then
            
            Me.Caption = "Modify " & CurTable & " Codes Table"
            
            'Get the current table entries
            If Len(DaoRS(0).Value) > 0 Then
                For x = 0 To UBound(TableTypes)
                    If (RTrim(DaoRS(0).Value) = TableTypes(x).TableTypeCode) Then
                        cbxTblType.Text = TableTypes(x).TableTypeName
                    End If
                Next
                'cbxTblType.Text = RTrim(DaoRS(0).Value)
            Else
                cbxTblType.Text = " "
            End If
            
            If Len(DaoRS(1).Value) > 0 Then
                txtDecodeLength.Text = RTrim(DaoRS(1).Value)
            Else
                txtDecodeLength.Text = " "
            End If
            
            If Len(DaoRS(2).Value) > 0 Then
                txtDecodeDisplacement.Text = RTrim(DaoRS(2).Value)
            Else
                txtDecodeDisplacement.Text = " "
            End If
            
                                   
            If Len(DaoRS(3).Value) > 0 Then
                txtDataLength.Text = RTrim(DaoRS(3).Value)
            Else
                txtDataLength.Text = " "
            End If
            
            If Len(DaoRS(4).Value) > 0 Then
                txtKeyLength.Text = RTrim(DaoRS(4).Value)
            Else
                txtKeyLength.Text = " "
            End If
                             
            If Len(DaoRS(5).Value) > 0 Then
                txtDescription.Text = RTrim(DaoRS(5).Value)
            Else
                txtDescription.Text = " "
            End If

            DaoRS.Close
            
        End If
End Sub
Sub WindowRefresh()
    Dim bSatus As Boolean
    
    bStatus = False
    
    If (Len(txtKeyLength.Text) <> 0) Then
        txtKeyLength.BackColor = &H80000005
    Else
        txtKeyLength.BackColor = &HFFFF&
        bStatus = True
    End If
    
    If (Len(txtDecodeLength.Text) <> 0) Then
        txtDecodeLength.BackColor = &H80000005
    Else
        txtDecodeLength.BackColor = &HFFFF&
        bStatus = True
    End If
    
    If (Len(txtDataLength.Text) <> 0) Then
        txtDataLength.BackColor = &H80000005
    Else
        txtDataLength.BackColor = &HFFFF&
        bStatus = True
    End If
    
    If (Len(txtDescription.Text) <> 0) Then
        txtDescription.BackColor = &H80000005
    Else
        txtDescription.BackColor = &HFFFF&
        bStatus = True
    End If

    If (Len(Me.txtDecodeDisplacement.Text) <> 0) Then
        txtDecodeDisplacement.BackColor = &H80000005
    Else
        txtDecodeDisplacement.BackColor = &HFFFF&
        bStatus = True
    End If

    If (bStatus = True) Then
        cmdAddTbl.Enabled = False
    Else
        cmdAddTbl.Enabled = True
    End If
    
End Sub

Private Sub txtDataLength_Change()
    WindowRefresh
End Sub

Private Sub txtDecodeDisplacement_Change()
    WindowRefresh
End Sub

Private Sub txtDecodeLength_Change()
    WindowRefresh
End Sub

Private Sub txtDescription_Change()
    WindowRefresh
End Sub

Private Sub txtKeyLength_Change()
    WindowRefresh
End Sub
