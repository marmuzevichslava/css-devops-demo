VERSION 5.00
Begin VB.Form frmAddModTable 
   Caption         =   "Modify Current Codes Table"
   ClientHeight    =   3645
   ClientLeft      =   3345
   ClientTop       =   2490
   ClientWidth     =   5790
   Icon            =   "frmAddModTable.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3645
   ScaleWidth      =   5790
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
      Left            =   3083
      TabIndex        =   10
      ToolTipText     =   "Return to main"
      Top             =   3165
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
      Left            =   1493
      TabIndex        =   9
      ToolTipText     =   "Modify Codes Table"
      Top             =   3165
      Width           =   1380
   End
   Begin VB.ComboBox cbxTblType 
      Height          =   315
      Left            =   1005
      TabIndex        =   0
      Top             =   135
      Width           =   1905
   End
   Begin VB.Frame Frame1 
      Caption         =   "Codes Table Flags:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1230
      Left            =   270
      TabIndex        =   18
      Top             =   645
      Width           =   2310
      Begin VB.CheckBox chkStaticTable 
         Enabled         =   0   'False
         Height          =   255
         Left            =   150
         TabIndex        =   19
         TabStop         =   0   'False
         Top             =   870
         Width           =   255
      End
      Begin VB.CheckBox chkEffDate 
         Caption         =   "Effective Date"
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
         Left            =   150
         TabIndex        =   1
         Top             =   285
         Width           =   1695
      End
      Begin VB.CheckBox chkResidency 
         Caption         =   "Residency"
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
         Left            =   150
         TabIndex        =   2
         Top             =   585
         Width           =   1695
      End
      Begin VB.Label Label1 
         Caption         =   "Static Tables"
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
         Left            =   435
         TabIndex        =   20
         Top             =   900
         Width           =   1425
      End
   End
   Begin VB.TextBox txtDescription 
      BackColor       =   &H00FFFFFF&
      Height          =   675
      Left            =   210
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   8
      ToolTipText     =   "Description for the table"
      Top             =   2295
      Width           =   5415
   End
   Begin VB.TextBox txtCenturyDelimeter 
      Height          =   315
      Left            =   4830
      TabIndex        =   7
      ToolTipText     =   "Codes Table Century Delimeter"
      Top             =   1770
      Width           =   765
   End
   Begin VB.TextBox txtKeyLength 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   4815
      TabIndex        =   3
      ToolTipText     =   "Codes Table Max Key Length"
      Top             =   120
      Width           =   765
   End
   Begin VB.TextBox txtDecodeLength 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   4830
      TabIndex        =   5
      ToolTipText     =   "Codes Table Max Decode Lenght"
      Top             =   944
      Width           =   765
   End
   Begin VB.TextBox txtDecodeDisplacement 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   4830
      TabIndex        =   6
      ToolTipText     =   "Codes Table Max Decode Displacement"
      Top             =   1356
      Width           =   765
   End
   Begin VB.TextBox txtDataLength 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   4830
      TabIndex        =   4
      ToolTipText     =   "Codes Table Max Data Length"
      Top             =   532
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
      Left            =   195
      TabIndex        =   17
      Top             =   2085
      Width           =   1290
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      Caption         =   "Century Delimeter:"
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
      Left            =   2670
      TabIndex        =   16
      Top             =   1830
      Width           =   2085
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
      Left            =   270
      TabIndex        =   15
      Top             =   165
      Width           =   615
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
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
      Left            =   2670
      TabIndex        =   14
      Top             =   180
      Width           =   2085
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
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
      Left            =   2655
      TabIndex        =   13
      Top             =   1004
      Width           =   2085
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
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
      Left            =   2655
      TabIndex        =   12
      Top             =   1416
      Width           =   2085
   End
   Begin VB.Label Label9 
      Alignment       =   1  'Right Justify
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
      Left            =   2670
      TabIndex        =   11
      Top             =   592
      Width           =   2085
   End
End
Attribute VB_Name = "frmAddModTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub cmdAddTbl_Click()

    If (txtCenturyDelimeter.Text = "") Then txtCenturyDelimeter.Text = " "
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
             "EffDate = " & Chr(34) & chkEffDate.Value & Chr(34) & ", " & _
             "Residency = " & Chr(34) & chkResidency.Value & Chr(34) & ", " & _
             "DataLen = " & Chr(34) & txtDataLength.Text & Chr(34) & ", " & _
             "KeyLen = " & Chr(34) & txtKeyLength.Text & Chr(34) & ", " & _
             "CenturyDelim = " & Chr(34) & txtCenturyDelimeter.Text & Chr(34) & _
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
        frmMain.txtCenturyDelim.Text = Me.txtCenturyDelimeter.Text
        frmMain.chkStatic.Value = Me.chkStaticTable.Value
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

    strsql = "select TableType, DecodeLen, DecodeDisplacement, EffDate,  " & _
             "Residency, DataLen, KeyLen, CenturyDelim, StaticTableUse, Description " & _
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
                If (RTrim(DaoRS(3).Value) = False) Then
                    chkEffDate.Value = False
                Else
                    chkEffDate.Value = 1
                End If
            Else
                chkEffDate.Value = False
            End If
           
            If Len(DaoRS(4).Value) > 0 Then
                If (RTrim(DaoRS(4).Value) = False) Then
                    chkResidency.Value = False
                Else
                    chkResidency.Value = 1
                End If
            Else
                chkResidency.Value = False
            End If
            
            If Len(DaoRS(5).Value) > 0 Then
                txtDataLength.Text = RTrim(DaoRS(5).Value)
            Else
                txtDataLength.Text = " "
            End If
            
            If Len(DaoRS(6).Value) > 0 Then
                txtKeyLength.Text = RTrim(DaoRS(6).Value)
            Else
                txtKeyLength.Text = " "
            End If
            
            If Len(DaoRS(7).Value) > 0 Then
                txtCenturyDelimeter.Text = RTrim(DaoRS(7).Value)
            Else
                txtCenturyDelimeter.Text = " "
            End If

            If Len(DaoRS(8).Value) > 0 Then
                If (RTrim(DaoRS(8).Value) = False) Then
                    chkStaticTable.Value = False
                Else
                    chkStaticTable.Value = 1
                End If
            Else
                chkStaticTable.Value = False
            End If

            If Len(DaoRS(9).Value) > 0 Then
                txtDescription.Text = RTrim(DaoRS(9).Value)
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
