VERSION 5.00
Begin VB.Form frmAddModTable 
   Caption         =   "Modify Current Codes Table"
   ClientHeight    =   4545
   ClientLeft      =   3345
   ClientTop       =   2490
   ClientWidth     =   5520
   Icon            =   "frmAddModTable.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4545
   ScaleWidth      =   5520
   Begin VB.ComboBox cbxTblType 
      Height          =   315
      Left            =   1320
      TabIndex        =   0
      Top             =   120
      Width           =   1455
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
      Height          =   735
      Left            =   120
      TabIndex        =   22
      Top             =   2160
      Width           =   3255
      Begin VB.CheckBox chkEffDate 
         Caption         =   "Effective Date:"
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Top             =   360
         Width           =   1455
      End
      Begin VB.CheckBox chkResidency 
         Caption         =   "Residency:"
         Height          =   255
         Left            =   1920
         TabIndex        =   10
         Top             =   360
         Width           =   1215
      End
   End
   Begin VB.TextBox txtDescription 
      BackColor       =   &H00FFFFFF&
      Height          =   615
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   11
      ToolTipText     =   "Description for the table"
      Top             =   3240
      Width           =   5220
   End
   Begin VB.TextBox txtCenturyDelimeter 
      Height          =   315
      Left            =   4440
      TabIndex        =   3
      ToolTipText     =   "Codes Table Century Delimeter"
      Top             =   480
      Width           =   765
   End
   Begin VB.Frame Frame2 
      Caption         =   "Table Usage:"
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
      Left            =   120
      TabIndex        =   14
      Top             =   1320
      Width           =   5280
      Begin VB.CheckBox chkSysUsage 
         Caption         =   "System Usage"
         Height          =   375
         Left            =   3720
         TabIndex        =   8
         Top             =   240
         Width           =   1335
      End
      Begin VB.CheckBox chkCodesTable 
         Caption         =   "Codes Table"
         Height          =   375
         Left            =   1920
         TabIndex        =   7
         Top             =   240
         Width           =   1215
      End
      Begin VB.CheckBox chkStaticTable 
         Caption         =   "Static Tables"
         Height          =   375
         Left            =   120
         TabIndex        =   6
         Top             =   240
         Width           =   1335
      End
   End
   Begin VB.TextBox txtKeyLength 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1320
      TabIndex        =   2
      ToolTipText     =   "Codes Table Max Key Length"
      Top             =   480
      Width           =   765
   End
   Begin VB.TextBox txtDecodeLength 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   4440
      TabIndex        =   1
      ToolTipText     =   "Codes Table Max Decode Lenght"
      Top             =   120
      Width           =   765
   End
   Begin VB.TextBox txtDecodeDisplacement 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   4440
      TabIndex        =   5
      ToolTipText     =   "Codes Table Max Decode Displacement"
      Top             =   840
      Width           =   765
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
      TabIndex        =   12
      ToolTipText     =   "Modify Codes Table"
      Top             =   4080
      Width           =   1380
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
      Height          =   330
      Left            =   3000
      TabIndex        =   13
      ToolTipText     =   "Return to main"
      Top             =   4080
      Width           =   1215
   End
   Begin VB.TextBox txtDataLength 
      BackColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   1320
      TabIndex        =   4
      ToolTipText     =   "Codes Table Max Data Length"
      Top             =   840
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
      Left            =   120
      TabIndex        =   21
      Top             =   3000
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
      Left            =   2640
      TabIndex        =   20
      Top             =   510
      Width           =   1725
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
      Left            =   600
      TabIndex        =   19
      Top             =   120
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
      Left            =   120
      TabIndex        =   18
      Top             =   510
      Width           =   1065
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
      Left            =   2895
      TabIndex        =   17
      Top             =   165
      Width           =   1440
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
      Left            =   2295
      TabIndex        =   16
      Top             =   885
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
      Left            =   -120
      TabIndex        =   15
      Top             =   885
      Width           =   1335
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
             "TableType = " & Chr(39) & CurrentTblType & Chr(39) & ", " & _
             "DecodeLen = " & Chr(39) & txtDecodeLength.Text & Chr(39) & ", " & _
             "DecodeDisplacement = " & txtDecodeDisplacement.Text & ", " & _
             "Description = " & Chr(39) & txtDescription.Text & Chr(39) & ", " & _
             "EffDate = " & Chr(39) & chkEffDate.Value & Chr(39) & ", " & _
             "Residency = " & Chr(39) & chkResidency.Value & Chr(39) & ", " & _
             "DataLen = " & Chr(39) & txtDataLength.Text & Chr(39) & ", " & _
             "KeyLen = " & Chr(39) & txtKeyLength.Text & Chr(39) & ", " & _
             "CenturyDelim = " & Chr(39) & txtCenturyDelimeter.Text & Chr(39) & ", "
    
    'Add the System Usage Flags.
    If (chkSysUsage.Value = 1) Then
        strsql = strsql & "SystemUse = " & True & ", "
    Else
        strsql = strsql & "SystemUse = " & False & ", "
    End If
    
    'Add the Static Table Usage Flags.
    If (chkStaticTable.Value = 1) Then
        strsql = strsql & "StaticTableUse = " & True & ", "
    Else
        strsql = strsql & "StaticTableUse = " & False & ", "
    End If
    
    'Add the Codes Table Usage Flags.
    If (chkCodesTable.Value = 1) Then
        strsql = strsql & "CodesTableUse = " & True
    Else
        strsql = strsql & "CodesTableUse = " & False
    End If
    
    'Finish the SQL string
    strsql = strsql & " WHERE TableName = " & Chr(39) & CurTable & Chr(39)

    Debug.Print strsql
    
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
        frmMain.chkCodes.Value = Me.chkCodesTable.Value
        frmMain.chkSystem.Value = Me.chkSysUsage.Value
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
    
    Debug.Print Err.Number
    Debug.Print Err.Description
    
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
             "Residency, DataLen, KeyLen, CenturyDelim, SystemUse, StaticTableUse, CodesTableUse, Description " & _
             "from tblTables where TableName = " & Chr(39) & CurTable & Chr(39)
        
    Debug.Print strsql
        
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
                    chkSysUsage.Value = False
                Else
                    chkSysUsage.Value = 1
                End If
            Else
                chkSysUsage.Value = False
            End If

            If Len(DaoRS(9).Value) > 0 Then
                If (RTrim(DaoRS(9).Value) = False) Then
                    chkStaticTable.Value = False
                Else
                    chkStaticTable.Value = 1
                End If
            Else
                chkStaticTable.Value = False
            End If

            If Len(DaoRS(10).Value) > 0 Then
                If (RTrim(DaoRS(10).Value) = False) Then
                    chkCodesTable.Value = False
                Else
                    chkCodesTable.Value = 1
                End If
            Else
                chkCodesTable.Value = False
            End If

            If Len(DaoRS(11).Value) > 0 Then
                txtDescription.Text = RTrim(DaoRS(11).Value)
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
