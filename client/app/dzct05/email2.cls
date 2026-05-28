VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Email"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private sUser As String
Private sSubject As String
Private sBody As String
Private mOutlookApp As Application
Private mNameSpace As NameSpace
Private mFolder As MAPIFolder
Private mItem As MailItem

Property Let USER(u)
    sUser = u
End Property

Property Let Subject(s)
    sSubject = s
End Property

Property Let Body(b)
    sBody = b
End Property

'******************************************
'**              Get Outlook             **
'******************************************
Public Sub Send()
    Dim pRecip As Recipient
       
    Set mOutlookApp = _
        CreateObject("Outlook.Application")
        
    Set mNameSpace = _
        mOutlookApp.GetNamespace("MAPI")
        
'    Set mFolder = mNameSpace.GetDefaultFolder(olFolderOutbox)
'
'    mFolder.Display
       
    Set mItem = mOutlookApp.CreateItem(olMailItem)
    Set pRecip = mItem.Recipients.Add(sUser)
    mItem.Subject = sSubject
    mItem.Body = sBody
    mItem.Save

    mItem.Send
    
    Exit Sub

'*****************************************
'**           Closing Outlook            **
'******************************************
'   Private Sub CloseOutlook()
'        mOutlookApp.Quit
'        Set mNameSpace = Nothing
'        Set mFolder = Nothing
'        Set mItem = Nothing
'        Set mOutlookApp = Nothing
'        Dim mOutlookApp As Application
'    End Sub

End Sub


