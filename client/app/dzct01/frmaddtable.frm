VERSION 5.00
Begin VB.Form frmAddTable 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Add New Codes Table"
   ClientHeight    =   4365
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5340
   Icon            =   "frmAddTable.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4365
   ScaleWidth      =   5340
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtDataLength 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   1350
      TabIndex        =   9
      ToolTipText     =   "Codes Table Class"
      Top             =   3075
      Width           =   765
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Cancel"
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
      Height          =   465
      Left            =   2813
      TabIndex        =   12
      ToolTipText     =   "Create New Table"
      Top             =   3750
      Width           =   1215
   End
   Begin VB.CommandButton cmdAddTbl 
      Caption         =   "&Add Table"
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
      TabIndex        =   11
      ToolTipText     =   "Create New Table"
      Top             =   3750
      Width           =   1215
   End
   Begin VB.TextBox txtDecodeDisplacement 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   4350
      TabIndex        =   8
      ToolTipText     =   "Codes Table Class"
      Top             =   2625
      Width           =   765
   End
   Begin VB.TextBox txtDecodeLength 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   4350
      TabIndex        =   10
      ToolTipText     =   "Codes Table Class"
      Top             =   3075
      Width           =   765
   End
   Begin VB.TextBox txtKeyLength 
      BackColor       =   &H0000FFFF&
      Height          =   315
      Left            =   1350
      TabIndex        =   7
      ToolTipText     =   "Codes Table Class"
      Top             =   2625
      Width           =   765
   End
   Begin VB.Frame Frame2 
      Caption         =   "Table:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2190
      Left            =   150
      TabIndex        =   13
      Top             =   150
      Width           =   5040
      Begin VB.TextBox txtCenturyDelimeter 
         Height          =   315
         Left            =   1500
         TabIndex        =   4
         ToolTipText     =   "Codes Table Class"
         Top             =   1725
         Width           =   615
      End
      Begin VB.CheckBox chkResidency 
         Alignment       =   1  'Right Justify
         Caption         =   "Residency:"
         Height          =   195
         Left            =   3750
         TabIndex        =   6
         Top             =   1800
         Width           =   1140
      End
      Begin VB.CheckBox chkEffDate 
         Alignment       =   1  'Right Justify
         Caption         =   "Effective Date:"
         Height          =   195
         Left            =   2250
         TabIndex        =   5
         Top             =   1800
         Width           =   1365
      End
      Begin VB.TextBox txtClass 
         Height          =   315
         Left            =   3600
         TabIndex        =   2
         ToolTipText     =   "Codes Table Class"
         Top             =   525
         Width           =   615
      End
      Begin VB.TextBox txtDescription 
         BackColor       =   &H0000FFFF&
         Height          =   315
         Left            =   150
         TabIndex        =   3
         ToolTipText     =   "Description for the table"
         Top             =   1200
         Width           =   4740
      End
      Begin VB.ComboBox cbxTblType 
         Height          =   315
         Left            =   1800
         Style           =   2  'Dropdown List
         TabIndex        =   1
         ToolTipText     =   "Table Type"
         Top             =   525
         Width           =   1515
      End
      Begin VB.TextBox txtTblName 
         Height          =   315
         Left            =   150
         TabIndex        =   0
         Text            =   "CIS"
         ToolTipText     =   "Codes Table Name"
         Top             =   525
         Width           =   1365
      End
      Begin VB.Label Label5 
         Caption         =   "Century Delimeter:"
         Height          =   195
         Left            =   150
         TabIndex        =   18
         Top             =   1800
         Width           =   1365
      End
      Begin VB.Label Label4 
         Caption         =   "Class:"
         Height          =   195
         Left            =   3600
         TabIndex        =   17
         Top             =   300
         Width           =   840
      End
      Begin VB.Label Label3 
         Caption         =   "Description:"
         Height          =   240
         Left            =   150
         TabIndex        =   16
         Top             =   975
         Width           =   1290
      End
      Begin VB.Label Label2 
         Caption         =   "Type:"
         Height          =   195
         Left            =   1800
         TabIndex        =   15
         Top             =   300
         Width           =   615
      End
      Begin VB.Label Label1 
         Caption         =   "Name:"
         Height          =   165
         Left            =   150
         TabIndex        =   14
         Top             =   300
         Width           =   690
      End
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
      Left            =   150
      TabIndex        =   22
      Top             =   3075
      Width           =   1215
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
      Left            =   2325
      TabIndex        =   21
      Top             =   2700
      Width           =   1965
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
      Left            =   2325
      TabIndex        =   20
      Top             =   3075
      Width           =   1440
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
      Left            =   150
      TabIndex        =   19
      Top             =   2700
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
    strSQL = "Select 1 From tblTables where TableName = " & Chr(39) & txtTblName.Text & Chr(39)
    
    Set DaoRS = dbCTM.OpenRecordset(strSQL, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
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
    
    strSQL = "INSERT INTO tblTables (TableName, " & _
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
    Debug.Print strSQL
    
    'Begin a new transaction.
     wsCTM.BeginTrans

    'Execute the insert.
    dbCTM.Execute strSQL
            
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
