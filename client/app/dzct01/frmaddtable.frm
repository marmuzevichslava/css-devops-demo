VERSION 5.00
Begin VB.Form frmAddTable 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Add New Codes Table"
   ClientHeight    =   5100
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5670
   Icon            =   "frmAddTable.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5100
   ScaleWidth      =   5670
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtClass 
      Height          =   285
      Left            =   4080
      TabIndex        =   25
      TabStop         =   0   'False
      Text            =   "Text1"
      Top             =   2760
      Visible         =   0   'False
      Width           =   495
   End
   Begin VB.Frame Frame1 
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
      Left            =   240
      TabIndex        =   24
      Top             =   1800
      Width           =   5175
      Begin VB.CheckBox Check2 
         Caption         =   "Codes Table"
         Height          =   255
         Left            =   1800
         TabIndex        =   8
         Top             =   360
         Width           =   1215
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Static Tables"
         Height          =   255
         Left            =   240
         TabIndex        =   7
         Top             =   360
         Width           =   1695
      End
      Begin VB.CheckBox Check3 
         Caption         =   "System Usage"
         Height          =   255
         Left            =   3360
         TabIndex        =   9
         Top             =   360
         Width           =   1575
      End
   End
   Begin VB.Frame Frame2 
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
      Left            =   240
      TabIndex        =   23
      Top             =   2640
      Width           =   3360
      Begin VB.CheckBox chkEffDate 
         Caption         =   "Effective Date"
         Height          =   195
         Left            =   240
         TabIndex        =   10
         Top             =   360
         Width           =   1365
      End
      Begin VB.CheckBox chkResidency 
         Caption         =   "Residency"
         Height          =   195
         Left            =   1800
         TabIndex        =   11
         Top             =   360
         Width           =   1140
      End
   End
   Begin VB.TextBox txtDescription 
      BackColor       =   &H0000FFFF&
      Height          =   555
      Left            =   240
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   12
      ToolTipText     =   "Description for the table"
      Top             =   3720
      Width           =   5220
   End
   Begin VB.TextBox txtTblName 
      Height          =   315
      Left            =   1440
      TabIndex        =   0
      Text            =   "CIS"
      ToolTipText     =   "Codes Table Name"
      Top             =   225
      Width           =   1515
   End
   Begin VB.TextBox txtCenturyDelimeter 
      Height          =   315
      Left            =   4590
      TabIndex        =   4
      ToolTipText     =   "Codes Table Century Delimeter"
      Top             =   937
      Width           =   765
   End
   Begin VB.ComboBox cbxTblType 
      Height          =   315
      Left            =   1440
      Style           =   2  'Dropdown List
      TabIndex        =   1
      ToolTipText     =   "Table Type"
      Top             =   590
      Width           =   1515
   End
   Begin VB.TextBox txtDataLength 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   1440
      TabIndex        =   5
      ToolTipText     =   "Codes Table Max Data Length"
      Top             =   1320
      Width           =   765
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
      Height          =   465
      Left            =   2813
      TabIndex        =   15
      ToolTipText     =   "Create New Table"
      Top             =   4440
      Width           =   1215
   End
   Begin VB.CommandButton cmdAddTbl 
      Caption         =   "&Add Table"
      Default         =   -1  'True
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
      Height          =   465
      Left            =   1313
      TabIndex        =   13
      ToolTipText     =   "Create New Table"
      Top             =   4440
      Width           =   1215
   End
   Begin VB.TextBox txtDecodeDisplacement 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   4590
      TabIndex        =   6
      ToolTipText     =   "Codes Table Max Decode Displacement"
      Top             =   1320
      Width           =   765
   End
   Begin VB.TextBox txtDecodeLength 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   4590
      TabIndex        =   2
      ToolTipText     =   "Codes Table Max Decode Lenght"
      Top             =   555
      Width           =   765
   End
   Begin VB.TextBox txtKeyLength 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   1440
      TabIndex        =   3
      ToolTipText     =   "Codes Table Max Key Length"
      Top             =   955
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
      TabIndex        =   22
      Top             =   3480
      Width           =   1290
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "Name:"
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
      Left            =   600
      TabIndex        =   21
      Top             =   240
      Width           =   690
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
      Left            =   2760
      TabIndex        =   20
      Top             =   1035
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
      Left            =   720
      TabIndex        =   19
      Top             =   600
      Width           =   615
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
      Left            =   120
      TabIndex        =   18
      Top             =   1380
      Width           =   1215
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
      Left            =   2565
      TabIndex        =   17
      Top             =   1380
      Width           =   1965
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
      Left            =   3120
      TabIndex        =   16
      Top             =   600
      Width           =   1440
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
      Left            =   270
      TabIndex        =   14
      Top             =   1035
      Width           =   1065
   End
End
Attribute VB_Name = "frmAddTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public CurrentTblType As Integer
Public bEffDate As Boolean
Public bResidency As Boolean

'***************************************************************************************************************
Private Sub chkEffDate_Click()
'***************************************************************************************************************
    If (chkEffDate.Value = 0) Then bEffDate = False
    If (chkEffDate.Value = 1) Then bEffDate = True
End Sub

'***************************************************************************************************************
Private Sub chkResidency_Click()
'***************************************************************************************************************
    If (chkResidency.Value = 0) Then bResidency = False
    If (chkResidency.Value = 1) Then bResidency = True
End Sub

'***************************************************************************************************************
Private Sub cmdAddTbl_Click()
'***************************************************************************************************************

    Dim nodx As Node, RC As Integer, x As Integer
    
    'First find out if this table already exists.
    strsql = "Select 1 From tblTables where TableName = " & Chr(39) & txtTblName.Text & Chr(39)
    
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        RC = MessageBox(Me.hwnd, _
                        "This table already exists!" & vbCrLf, _
                        "Codes Table Explorer", _
                        MB_OK Or MB_ICONEXCLAMATION)
        DaoRS.Close
        Exit Sub
    End If
    

    'Get the current table type code.
    For x = 0 To UBound(TableTypes)
        If (cbxTblType.Text = TableTypes(x).TableTypeName) Then
            CurrentTblType = TableTypes(x).TableTypeCode
        End If
    Next


    'If we made it here then the table does not exist.
    'Put together the SQL to insert the new table.
    
    strsql = "INSERT INTO tblTables (TableName, " & _
                                    "TableType, " & _
                                    "DecodeLen, " & _
                                    "DecodeDisplacement, " & _
                                    "EffDate, " & _
                                    "Residency, " & _
                                    "DataLen, " & _
                                    "KeyLen, " & _
                                    "CenturyDelim, " & _
                                    "Class, " & _
                                    "Description, " & _
                                    "SystemUse, StaticTableUse, CodesTableUse) " & _
             "VALUES (" & Chr(39) & txtTblName.Text & Chr(39) & ", " & _
                          CurrentTblType & ", " & _
                          txtDecodeLength.Text & ", " & _
                          txtDecodeDisplacement.Text & ", " & _
                          bEffDate & ", " & _
                          bResidency & ", " & _
                          txtDataLength.Text & ", " & _
                          txtKeyLength.Text & ", " & _
                          txtCenturyDelimeter.Text & ", " & _
                          Chr(39) & txtClass.Text & Chr(39) & ", " & _
                          Chr(39) & txtDescription.Text & Chr(39) & ", " & _
                          "False, False, False);"
    Debug.Print strsql
    
    'Begin a new transaction.
     wsCTM.BeginTrans

    'Execute the insert.
    dbCTM.Execute strsql
            
    'Check the results of the insert.
    If (dbCTM.RecordsAffected = 1) Then
        RC = MessageBox(Me.hwnd, _
                        "Table created successfully!", _
                        "Codes Table Explorer", _
                        MB_OK Or MB_ICONINFORMATION)
        wsCTM.CommitTrans
        
        'Add this new table to the appropriate tree view node.
        Set nodx = frmMain.tvTreeView.Nodes.Add(cbxTblType.Text, 4, _
                                        txtTblName.Text, _
                                        txtTblName.Text)

        
    Else
        RC = MessageBox(Me.hwnd, _
                        "Unable to create table " & txtTblName.Text & "." & _
                        vbCrLf & "Contact Development Tools for assistance.", _
                        "Codes Table Explorer", _
                        MB_OK Or MB_ICONEXCLAMATION)
        wsCTM.Rollback
    End If

    Unload Me
End Sub


'***************************************************************************************************************
Private Sub cmdCancel_Click()
'***************************************************************************************************************
    Unload Me
End Sub

'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    Dim x As Integer
    
    txtClass.Text = "A"
    txtCenturyDelimeter.Text = 0
    
    For x = 0 To UBound(TableTypes)
        cbxTblType.AddItem (TableTypes(x).TableTypeName)
    Next
    
    CurrentTblType = TableTypes(0).TableTypeCode
    
    cbxTblType.ListIndex = 0
    
    txtTblName.SelStart = Len(txtTblName.Text) + 1
    
    bResidency = False
    bEffDate = False

End Sub

'***************************************************************************************************************
Public Sub WindowRefresh()
'***************************************************************************************************************
    Dim TableMaxLen As Integer
    Dim RC As Integer
    
    If (Len(txtTblName.Text) > 0) Then
        txtTblName.BackColor = &H80000005
        txtTblName.Text = UCase(txtTblName.Text)
    Else
        txtTblName.BackColor = &HFFFF&
    End If

    If (Len(txtKeyLength.Text) > 0) Then
        txtKeyLength.BackColor = &H80000005
    Else
        txtKeyLength.BackColor = &HFFFF&
    End If
    
    If (Len(txtDecodeLength.Text) > 0) Then
        txtDecodeLength.BackColor = &H80000005
    Else
        txtDecodeLength.BackColor = &HFFFF&
    End If
    
    If (Len(txtDescription.Text) > 0) Then
        txtDescription.BackColor = &H80000005
    Else
        txtDescription.BackColor = &HFFFF&
    End If
    
    If (Len(txtDataLength.Text) > 0) Then
        txtDataLength.BackColor = &H80000005
    Else
        txtDataLength.BackColor = &HFFFF&
    End If
    
    If (Len(txtCenturyDelimeter.Text) > 0) Then
        txtCenturyDelimeter.BackColor = &H80000005
    Else
        txtCenturyDelimeter.BackColor = &HFFFF&
    End If
    
    If (Len(txtDecodeDisplacement.Text) > 0) Then
        txtDecodeDisplacement.BackColor = &H80000005
    Else
        txtDecodeDisplacement.BackColor = &HFFFF&
    End If

    'Set the state of the Add button.
    If ((Len(txtTblName.Text) > 0) And (Len(txtDecodeDisplacement.Text) > 0) _
        And (Len(txtDescription.Text) > 0) _
        And (Len(txtDecodeLength.Text) > 0) _
        And (Len(txtKeyLength.Text) > 0) _
        And (Len(txtTblName.Text) > 0) _
        And (Len(txtDataLength.Text) > 0) _
        And (Len(txtCenturyDelimeter.Text) > 0)) Then
            cmdAddTbl.Enabled = True
    Else
            cmdAddTbl.Enabled = False
    End If
End Sub


'***************************************************************************************************************
Private Sub txtDataLength_Change()
'***************************************************************************************************************
    WindowRefresh
End Sub

'***************************************************************************************************************
Private Sub txtDecodeDisplacement_Change()
'***************************************************************************************************************
    WindowRefresh
End Sub

'***************************************************************************************************************
Private Sub txtDecodeLength_Change()
'***************************************************************************************************************
    WindowRefresh
End Sub

'***************************************************************************************************************
Private Sub txtDescription_Change()
'***************************************************************************************************************
    WindowRefresh
End Sub

'***************************************************************************************************************
Private Sub txtKeyLength_Change()
'***************************************************************************************************************
    WindowRefresh
End Sub

'***************************************************************************************************************
Private Sub txtTblName_Change()
'***************************************************************************************************************
    WindowRefresh
    txtTblName.SelStart = Len(txtTblName.Text) + 1
End Sub
