VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.2#0"; "comctl32.ocx"
Begin VB.Form frmAddStaticTable 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Add/Delete Static Tables"
   ClientHeight    =   4065
   ClientLeft      =   150
   ClientTop       =   435
   ClientWidth     =   5265
   Icon            =   "frmaddstatictable.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4065
   ScaleWidth      =   5265
   StartUpPosition =   1  'CenterOwner
   Begin ComctlLib.StatusBar sbStatusBar 
      Align           =   2  'Align Bottom
      Height          =   300
      Left            =   0
      TabIndex        =   6
      Top             =   3765
      Width           =   5265
      _ExtentX        =   9287
      _ExtentY        =   529
      SimpleText      =   ""
      _Version        =   327680
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Object.Width           =   9410
            MinWidth        =   9410
            TextSave        =   ""
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
      EndProperty
      MouseIcon       =   "frmaddstatictable.frx":030A
   End
   Begin VB.CommandButton Command2 
      BackColor       =   &H8000000D&
      Caption         =   "<---"
      Height          =   495
      Left            =   2400
      TabIndex        =   5
      ToolTipText     =   "Delete static table..."
      Top             =   2160
      Width           =   475
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H8000000D&
      Caption         =   "--->"
      Height          =   495
      Left            =   2400
      TabIndex        =   4
      ToolTipText     =   "Add static table..."
      Top             =   1080
      Width           =   475
   End
   Begin VB.Frame Frame1 
      Caption         =   "Current Static Tables"
      Height          =   3735
      Left            =   3090
      TabIndex        =   2
      Top             =   0
      Width           =   2060
      Begin VB.ListBox StaticTables 
         Height          =   3375
         Left            =   120
         MultiSelect     =   2  'Extended
         Sorted          =   -1  'True
         TabIndex        =   3
         ToolTipText     =   "Listing of current static tables..."
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Relational Table List "
      Height          =   3735
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   2060
      Begin VB.ListBox SelectTable 
         Height          =   3375
         Left            =   120
         MultiSelect     =   2  'Extended
         Sorted          =   -1  'True
         TabIndex        =   1
         ToolTipText     =   "Listing of relational tables..."
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuProcess 
         Caption         =   "&Process"
         Shortcut        =   ^P
      End
      Begin VB.Menu mnuBreak 
         Caption         =   "-"
      End
      Begin VB.Menu mnuClose 
         Caption         =   "&Close"
      End
   End
   Begin VB.Menu mnuTable 
      Caption         =   "&Table"
      Begin VB.Menu mnuPrint 
         Caption         =   "Print &Static Table List"
         Shortcut        =   ^S
      End
      Begin VB.Menu mnuSpaces 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFind 
         Caption         =   "&Find"
         Shortcut        =   ^F
      End
   End
End
Attribute VB_Name = "frmAddStaticTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'*************************************************************************************************************
Private Sub Command1_Click()
'*************************************************************************************************************

    Dim TableIsSelected As Boolean
    Dim RelTabArray(1000) As String
    Dim NumListItems As Integer
    
    For X = 0 To frmAddStaticTable.StaticTables.ListCount - 1
        frmAddStaticTable.StaticTables.Selected(X) = False
    Next
    
    'Check to see if a relational table is selected.
    For X = 0 To frmAddStaticTable.SelectTable.ListCount - 1
        If (frmAddStaticTable.SelectTable.Selected(X) = True) Then
            TableIsSelected = True
        End If
    Next
            
    If Not TableIsSelected Then
        msg = "No table from the relational table list has been selected." & vbCrLf
        RC = MsgBox(msg, vbOKOnly + vbCritical, "Codes Table Explorer")
        Screen.MousePointer = vbNormal
        Exit Sub
    End If
    
    For X = 0 To frmAddStaticTable.SelectTable.ListCount - 1
        If (frmAddStaticTable.SelectTable.Selected(X) = True) Then
            sbStatusBar.Panels(1).Text = "Added static table(s) to static list..."
            sbStatusBar.Refresh
            
           frmAddStaticTable.StaticTables.AddItem Me.SelectTable.List(X)
        End If
    Next
    
    frmAddStaticTable.StaticTables.Refresh
            
    For X = 0 To frmAddStaticTable.SelectTable.ListCount - 1
        If (frmAddStaticTable.SelectTable.Selected(X) = False) Then
            RelTabArray(X) = frmAddStaticTable.SelectTable.List(X)
        End If
    Next
        
    frmAddStaticTable.SelectTable.Clear
    
    For X = 0 To 1000
        If RelTabArray(X) <> "" Then
            frmAddStaticTable.SelectTable.AddItem RelTabArray(X)
        End If
    Next
    
    frmAddStaticTable.SelectTable.Refresh
    
End Sub

'*************************************************************************************************************
Private Sub Command2_Click()
'*************************************************************************************************************

    Dim TableIsSelected As Boolean
    Dim RelTabArray(1000) As String
    Dim NumListItems As Integer
    
    For X = 0 To frmAddStaticTable.SelectTable.ListCount - 1
        frmAddStaticTable.SelectTable.Selected(X) = False
    Next
    
    'Check to see if a static table is selected.
    For X = 0 To frmAddStaticTable.StaticTables.ListCount - 1
        If (frmAddStaticTable.StaticTables.Selected(X) = True) Then
            TableIsSelected = True
        End If
    Next
            
    If Not TableIsSelected Then
        msg = "No table from the static table list has been selected." & vbCrLf
        RC = MsgBox(msg, vbOKOnly + vbCritical, "Codes Table Explorer")
        Screen.MousePointer = vbNormal
        Exit Sub
    End If
    
    For X = 0 To frmAddStaticTable.StaticTables.ListCount - 1
        If (frmAddStaticTable.StaticTables.Selected(X) = True) Then
            sbStatusBar.Panels(1).Text = "Deleted static table(s) from static list..."
            sbStatusBar.Refresh
            
            frmAddStaticTable.SelectTable.AddItem Me.StaticTables.List(X)
        End If
    Next
    
    frmAddStaticTable.SelectTable.Refresh
            
    For X = 0 To frmAddStaticTable.StaticTables.ListCount - 1
        If (frmAddStaticTable.StaticTables.Selected(X) = False) Then
            RelTabArray(X) = frmAddStaticTable.StaticTables.List(X)
        End If
    Next
        
    frmAddStaticTable.StaticTables.Clear
    
    For X = 0 To 1000
        If RelTabArray(X) <> "" Then
            frmAddStaticTable.StaticTables.AddItem RelTabArray(X)
        End If
    Next
    
    frmAddStaticTable.StaticTables.Refresh

End Sub

'***************************************************************************************************************
Private Sub Form_Load()
'***************************************************************************************************************
    'Get the list of valid relational tables and add them to the combo box.
    Screen.MousePointer = vbHourglass
    
    strsql = "SELECT DISTINCT tblRelTables.TableName " _
           & "FROM tblRelTables LEFT JOIN tblTables ON tblRelTables.TableName = tblTables.TableName " _
           & "WHERE tblTables.TableName IS NULL;"

    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            SelectTable.AddItem DaoRS(0).Value
            DaoRS.MoveNext
        Wend
        DaoRS.Close
    End If
    
    strsql = "SELECT TableName" _
           & " FROM tblTables" _
           & " WHERE TableType = 4;"
           
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            StaticTables.AddItem DaoRS(0).Value
            DaoRS.MoveNext
        Wend
        DaoRS.Close
    End If
        
    sbStatusBar.Panels(1).Text = "Ready."
       
    Screen.MousePointer = vbNormal
    
End Sub

'***************************************************************************************************************
Private Sub mnuClose_Click()
'***************************************************************************************************************
    Unload Me
End Sub
'***************************************************************************************************************
Private Sub mnuFind_Click()
'***************************************************************************************************************
    frmFindRelTable.Show vbModal
End Sub

'****************************************************************************************************************
Private Sub mnuPrint_Click()
'****************************************************************************************************************

    Dim iStr As Integer, iPg As Integer
    Dim strsql3 As String
    Dim sTransfer As String
    
    On Error GoTo PrinterError
    
    Screen.MousePointer = vbHourglass
    iPg = 1
    
    strsql3 = "select Project from tblProject where ProjectFlag = True"
    Set DaoRS3 = dbCTM.OpenRecordset(strsql3, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS3.EOF Then
        sTransfer = DaoRS3(0).Value
        Me.Caption = "Codes Table Explorer - " & sTransfer
        DaoRS3.Close
    End If
    
    Printer.Orientation = vbPRORPortrait
    Printer.PrintQuality = vbPRPQHigh
    Printer.CurrentX = 0
    Printer.Line Step(5, 5)-Step(15000, 50), , BF
    Printer.FontName = "Times New Roman"
    Printer.FontBold = True
    Printer.FontSize = 15
    Printer.Print vbLf & "Current Static Table Listing for " & sTransfer & vbLf
    Printer.FontBold = False
    Printer.FontSize = 10
    Printer.Line Step(5, 5)-Step(15000, 10), , BF
    Printer.CurrentY = Printer.CurrentY + 10
    
    Printer.FontBold = True
    Printer.CurrentX = 0
    Printer.Print "Static Table"
    Printer.CurrentX = 1750
    Printer.CurrentY = Printer.CurrentY - 234
    Printer.Print "Static Table Name"
    Printer.FontBold = False
    
    Printer.CurrentY = Printer.CurrentY + 10
    
    Printer.Line Step(5, 5)-Step(15000, 10), , BF
    
    Printer.CurrentY = Printer.CurrentY + 10
    
    strsql = "SELECT TableName" _
           & " FROM tblTables" _
           & " WHERE TableType = 4" _
           & " ORDER BY tblTables.TableName;"
           
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
        
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            If (Printer.CurrentY > 13600) Then
                Printer.CurrentY = 13900
                Printer.CurrentX = 0
                Printer.Line Step(5, 5)-Step(15000, 50), , BF
            
                Printer.CurrentX = 0
                Printer.Print Date & " - " & Time
            
                Printer.CurrentY = Printer.CurrentY - 234
                Printer.CurrentX = 10000
                Printer.Print "Page " & iPg
                iPg = iPg + 1
            
                Printer.NewPage
                                           
                Printer.CurrentX = 0
                Printer.Line Step(5, 5)-Step(15000, 50), , BF
                Printer.FontName = "Times New Roman"
                Printer.FontBold = True
                Printer.FontSize = 15
                Printer.Print vbLf & "Current Static Table Listing for " & sTransfer & vbLf
                Printer.FontBold = False
                Printer.FontSize = 10
                Printer.Line Step(5, 5)-Step(15000, 10), , BF
                Printer.CurrentY = Printer.CurrentY + 10
            
                Printer.FontBold = True
                Printer.CurrentX = 0
                Printer.Print "Static Table"
                Printer.CurrentX = 1750
                Printer.CurrentY = Printer.CurrentY - 234
                Printer.Print "Static Table Name"
                       
                Printer.FontBold = False
                Printer.CurrentY = Printer.CurrentY + 10
                Printer.Line Step(5, 5)-Step(15000, 10), , BF
                Printer.CurrentY = Printer.CurrentY + 10
                Printer.CurrentX = 0
                Printer.Print DaoRS(0).Value
                Printer.CurrentX = 1750
                Printer.CurrentY = Printer.CurrentY - 234
                
                strsql2 = "SELECT DISTINCTROW tblRelTables.TableName, tblRelTables.TableDecode" _
                       & " FROM tblRelTables INNER JOIN tblTables ON tblRelTables.TableName = tblTables.TableName;"
                       
                Set DaoRS2 = dbCTM.OpenRecordset(strsql2, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
                    If Not DaoRS2.EOF Then
                        While Not DaoRS2.EOF
                            If Not IsNull(DaoRS2(0).Value) Then
                                If DaoRS(0).Value = DaoRS2(0).Value Then
                                    Printer.Print DaoRS2(1).Value
                                End If
                            Else
                                itmX.SubItems(1) = " "
                            End If
                            DaoRS2.MoveNext
                        Wend
                    End If
                    
                    DaoRS2.Close
                        
            Else
                Printer.CurrentX = 0
                Printer.Print DaoRS(0).Value
                Printer.CurrentX = 1750
                Printer.CurrentY = Printer.CurrentY - 234
                
                strsql2 = "SELECT DISTINCTROW tblRelTables.TableName, tblRelTables.TableDecode" _
                       & " FROM tblRelTables INNER JOIN tblTables ON tblRelTables.TableName = tblTables.TableName;"
                       
                Set DaoRS2 = dbCTM.OpenRecordset(strsql2, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
                    If Not DaoRS2.EOF Then
                        While Not DaoRS2.EOF
                            If Not IsNull(DaoRS2(0).Value) Then
                                If DaoRS(0).Value = DaoRS2(0).Value Then
                                    Printer.Print DaoRS2(1).Value
                                End If
                            Else
                                itmX.SubItems(1) = " "
                            End If
                            DaoRS2.MoveNext
                        Wend
                    End If
                    
                    DaoRS2.Close
                
            End If
            DaoRS.MoveNext
        Wend
        DaoRS.Close
    End If
        
    Printer.CurrentY = 13900
    Printer.CurrentX = 0
    Printer.Line Step(5, 5)-Step(15000, 50), , BF
            
    Printer.CurrentX = 0
    Printer.Print Date & " - " & Time
            
    Printer.CurrentY = Printer.CurrentY - 234
    Printer.CurrentX = 10000
    Printer.Print "Page " & iPg
        
    Printer.EndDoc
    
    Screen.MousePointer = vbNormal
Exit Sub

PrinterError:
    Dim RC As Integer
    Screen.MousePointer = vbNormal
    RC = MsgBox("Unable to print to " & Printer.DeviceName & "." & vbCrLf & _
                "Please check your print settings and the printer.", _
                vbOKOnly + vbExclamation, "Codes Table Explorer")
            
End Sub

'***************************************************************************************************************
Public Sub mnuProcess_Click()
'***************************************************************************************************************

    Screen.MousePointer = vbHourglass
    
    Dim SQLDelete As String
    Dim SQLquery As String
    Dim sTimestamp As String
    Dim CurDateTime As String
    Const TABLE_TYPE = 4
        
    'Get current date and time.
    CurDateTime = Now
    
    'Format current date and time for table.
    sTimestamp = Format(CurDateTime, "yyyy-mm-dd:hh:mm:ss:000000")
    
    'Query to see if static tables exist in tblTables.
    SQLquery = "SELECT TableName " _
             & "FROM tblTables " _
             & "WHERE TableType = 4;"
                      
    Set DaoRS = dbCTM.OpenRecordset(SQLquery, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        'Delete static tables from tblTables.
        SQLDelete = "DELETE * " _
                  & "FROM tblTables " _
                  & "WHERE TableType = 4;"
                                   
        sbStatusBar.Panels(1).Text = "Updating the static table additons/deletions..."
                                   
        'Begin DAO transaction.
        wsCTM.BeginTrans
        'Execute SQL.
        dbCTM.Execute SQLDelete, dbFailOnError
    
        If dbCTM.RecordsAffected = 0 Then
            Err.Raise 4, "UpdateProcess", "The static tables were not deleted from tblTables."
            wsCTM.Rollback
        Else
            'Commit DAO transaction.
            wsCTM.CommitTrans
        End If
    Else
        DaoRS.Close
    End If

    For X = 0 To frmAddStaticTable.StaticTables.ListCount - 1
        'Set SQL string.
        SQLInsert = "INSERT INTO tblTables " _
                  & "SELECT " & Chr(34) & frmAddStaticTable.StaticTables.List(X) & Chr(34) & " As TableName," _
                  & Chr(34) & TABLE_TYPE & Chr(34) & " AS TableType," _
                  & Chr(34) & sTimestamp & Chr(34) & " AS FlagUpdateTS;"
        
        On Error GoTo InsertError
        
        'Begin DAO transaction.
        wsCTM.BeginTrans
        'Execute SQL.
        dbCTM.Execute SQLInsert, dbFailOnError
    
        If dbCTM.RecordsAffected = 0 Then
            wsCTM.Rollback
        Else
            'Commit DAO transaction.
            wsCTM.CommitTrans
        End If
    Next
    
    frmAddStaticTable.SelectTable.Clear
    
    strsql = "SELECT DISTINCT tblRelTables.TableName " _
           & "FROM tblRelTables LEFT JOIN tblTables ON tblRelTables.TableName = tblTables.TableName " _
           & "WHERE tblTables.TableName IS NULL;"
    
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            SelectTable.AddItem DaoRS(0).Value
            DaoRS.MoveNext
        Wend
        DaoRS.Close
    End If
    
    frmAddStaticTable.SelectTable.Refresh
    
    frmAddStaticTable.StaticTables.Clear
    
    strsql = "SELECT TableName" _
           & " FROM tblTables" _
           & " WHERE TableType = 4;"
           
    Set DaoRS = dbCTM.OpenRecordset(strsql, dbOpenForwardOnly, dbReadOnly, dbReadOnly)
    
    If Not DaoRS.EOF Then
        While Not DaoRS.EOF
            StaticTables.AddItem DaoRS(0).Value
            DaoRS.MoveNext
        Wend
        DaoRS.Close
    End If
    
    frmAddStaticTable.StaticTables.Refresh
    
    msg = "The static table list has been successfully updated." & vbCrLf
    RC = MsgBox(msg, vbOKOnly + vbExclamation, "Codes Table Explorer")
    Screen.MousePointer = vbNormal
        
    sbStatusBar.Panels(1).Text = "Ready."
    sbStatusBar.Refresh

    'Clear the control.
    frmMain.tvTreeView.Nodes.Clear
    frmMain.lvListView.ListItems.Clear
    frmMain.lvListView1.ListItems.Clear
    
    'Rebuild the table list.
    Call BuildTableList
    frmMain.tvTreeView.Nodes(1).Selected = True
       
    Screen.MousePointer = vbNormal
    
    Exit Sub

InsertError:
    Screen.MousePointer = vbNormal
    msg = "An error has occured within Process of frmAddStatictable" & vbCrLf & _
          "Error number = " & Err.Number & vbCrLf & _
          "Error Description = " & Err.Description & vbCrLf & vbCrLf & _
          "Contact " & AUTHOR & " for assistance."
    Exit Sub
    
    End Sub


