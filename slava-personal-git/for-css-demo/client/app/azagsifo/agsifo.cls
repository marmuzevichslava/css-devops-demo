VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "AGSIFO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'***************************************************************************
'*
'*                CUSTOMER/1 Cooperative Architecture Module
'*
'*  CLASS NAME       : AZAGSIFO
'*
'*  DESCRIPTION      : AZAGSIFO is an ActiveX object that provides an
'*                     interface into CUSTOMER/1 via the Application Gateway
'*                     Server ( AGS ).
'*
'*                     AZAGSIFO contains several properties and methods that
'*                     provide users with the means to issue requests and
'*                     receive data from CUSTOMER/1.
'*
'*  PROPERTIES       : NumTvPair            ( Get )
'*                     TcpHostName          ( Get )
'*                     TcpHostName          ( Let )
'*                     TcpServiceName       ( Get )
'*                     TcpServiceName       ( Let )
'*                     TcpTimeout           ( Get )
'*                     TcpTimeout           ( Let )
'*
'*  METHODS          : BuildTagByArray      PUBLIC
'*                     BuildTvList          PRIVATE
'*                     BuildTvString        PRIVATE
'*                     FindTvPair           PRIVATE
'*                     GetTvPair            PUBLIC
'*                     GetTvPairAll         PUBLIC
'*                     GetTvPairByIndex     PUBLIC
'*                     InitTcpPipe          PUBLIC
'*                     InitTvList           PUBLIC
'*                     SendMsg              PUBLIC
'*                     SetTvPair            PUBLIC
'*
'*  REVISION HISTORY
'*
'*  DATE        REVISED BY  SIR #    DESCRIPTION OF CHANGE
'*  --------    ----------  ------   ---------------------------------------
'*  01/05/97    B Lucas              original code
'*
'*  02/03/97    B Lucas              added GetTvPairByIndex
'*
'*  03/11/98    B Lucas              added BuildTagByArray
'*
'***************************************************************************

'options
Option Explicit

'constants
Private Const TV_SEP As String = "="
Private Const TV_PAIR_SEP As String = "|"
Private Const DEF_HOST_NAME As String = "c1proxyhost"
Private Const DEF_SERV_NAME As String = "c1proxy"
Private Const DEF_TCP_TIMEOUT As Integer = 0

'global variables
Dim TvList As clsTvList
Dim MsgHeader As MESSAGE_HDR
Dim TcpPipeParms As TCP_PIPE_PARMS


'**************************************************************************
'*
'* PROPERTY:        NumTvPair ( Get )
'*
'* DESCRIPTION:     Returns the number of tag-value nodes contained in
'*                  the tag-value list
'*
'* INPUTS:          none
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    January 13, 1998
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 01/13/98  B Lucas            original code.
'*
'**************************************************************************
Public Property Get NumTvPair() As Integer
    
    NumTvPair = TvList.NumTvPair

End Property


'**************************************************************************
'*
'* PROPERTY:        TcpHostName ( Get )
'*
'* DESCRIPTION:     returns the current tcp hostname.  if the value is not
'*                  set, the default hostname is used.
'*
'* INPUTS:          none
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    January 09, 1998
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 01/09/98  B Lucas            original code.
'*
'**************************************************************************
Public Property Get TcpHostName() As String

    If Len(TcpPipeParms.HostName) = 0 Then _
        TcpPipeParms.HostName = DEF_HOST_NAME
    
    TcpHostName = TcpPipeParms.HostName

End Property


'**************************************************************************
'*
'* PROPERTY:        TcpHostName ( Let )
'*
'* DESCRIPTION:     allows the user to set the tcp hostname
'*
'* INPUTS:          none
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    January 09, 1998
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 01/09/98  B Lucas            original code.
'*
'**************************************************************************
Public Property Let TcpHostName(TcpHostName As String)

    TcpPipeParms.HostName = TcpHostName

End Property


'**************************************************************************
'*
'* PROPERTY:        TcpServiceName ( Get )
'*
'* DESCRIPTION:     returns the current tcp servicename.  if the value is not
'*                  set, the default servicename is used.
'*
'* INPUTS:          none
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    January 09, 1998
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 01/09/98  B Lucas            original code.
'*
'**************************************************************************
Public Property Get TcpServiceName() As String

    If Len(TcpPipeParms.ServiceName) = 0 Then _
        TcpPipeParms.ServiceName = DEF_SERV_NAME
    
    TcpServiceName = TcpPipeParms.ServiceName

End Property


'**************************************************************************
'*
'* PROPERTY:        TcpServiceName ( Let )
'*
'* DESCRIPTION:     allows the user to set the tcp servicename
'*
'* INPUTS:          none
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    January 09, 1998
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 01/09/98  B Lucas            original code.
'*
'**************************************************************************
Public Property Let TcpServiceName(TcpServiceName As String)

    TcpPipeParms.ServiceName = TcpServiceName

End Property


'**************************************************************************
'*
'* PROPERTY:        TcpTimeout ( Get )
'*
'* DESCRIPTION:     returns the current tcp timeout.  if the value is not
'*                  set, the default timeout is used.
'*
'* INPUTS:          none
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    January 09, 1998
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 01/09/98  B Lucas            original code.
'*
'**************************************************************************
Public Property Get TcpTimeout() As Integer

    If TcpPipeParms.Timeout = 0 Then _
        TcpPipeParms.Timeout = DEF_TCP_TIMEOUT
    
    TcpTimeout = TcpPipeParms.Timeout

End Property


'**************************************************************************
'*
'* PROPERTY:        TcpTimeout ( Let )
'*
'* DESCRIPTION:     allows the user to set the tcp timeout
'*
'* INPUTS:          none
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    January 09, 1998
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 01/09/98  B Lucas            original code.
'*
'**************************************************************************
Public Property Let TcpTimeout(TcpTimeout As Integer)

    TcpPipeParms.Timeout = TcpTimeout

End Property


'**************************************************************************
'*
'* FUNCTION:        BuildTagByArray()
'*
'* DESCRIPTION:     string concatenation, especially when it is done by
'*                  interpreted languages ( like vbscript on an .asp web
'*                  page ) is an extremely time consuming operation.  to
'*                  help with performance, and to keep scripting to a
'*                  minimum, BuildTagByArray was created.  The assumption
'*                  is that building the string here ( compiled native
'*                  code ) is quicker that on the .asp page ( interpreted
'*                  code ).
'*
'*                  BuildTagByArray is intended to eliminate the need to
'*                  'build' tags that contain arrays with subscripts.
'*                  instead of building the 'tag' on the client, pass the
'*                  pieces of the 'tag' ( called SubTags ) and this
'*                  function will build it for you.
'*
'*                  when building a 'tag' with this function, there are two
'*                  rules to follow:  one, element names must passed as
'*                  strings ( encompassed by "" ). two, array subscripts
'*                  must be passed as numerics.
'*
'*                  Example:
'*                      BuildTagByArray( "Tag1", 2, "Tag3", "4", "Tag5", 6 )
'*                      will build "Tag1[2].Tag3.4.Tag5[6]"
'*
'* INPUTS:          SubTag()
'*                      array containing multiple subtags
'*
'* OUTPUTS:         complete 'tag' built from the SubTag array
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    March 11, 1998
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 03/11/98  B Lucas            original code.
'*
'**************************************************************************
Public Function BuildTagByArray(ParamArray SubTag()) _
                                As String

    Dim Curr As Integer
    Dim UpperBoundary As Integer
    Dim Tag As String
    
    'check formal parameters.  first member of array can not be numeric
    If Not (IsNumeric(SubTag(Curr))) Then
    
        'build first subtag
        Tag = Tag & SubTag(Curr)
        Curr = Curr + 1
        
        'build remaining subtags
        UpperBoundary = UBound(SubTag)
        While (Curr <= UpperBoundary)
        
            'if SubTag is numeric, assume it is an array subscript
            If IsNumeric(SubTag(Curr)) Then
                Tag = Tag & ".[" & SubTag(Curr) & "]"
            Else
                Tag = Tag & "." & SubTag(Curr)
            End If
        
            'increment counter
            Curr = Curr + 1
        
        Wend
    End If
    
    BuildTagByArray = Tag
        
End Function


'**************************************************************************
'*
'* FUNCTION:        BuildTvList()
'*
'* DESCRIPTION:     this function is used to build a visual basic linked
'*                  list from an input tag-value string.
'*
'*                  for performance reasons, the input string is copied
'*                  into a local byte array.  the array can then be
'*                  accessed via subscripts instead of incurring the
'*                  overhead of copying a potentially long string between
'*                  variables.
'*
'*                  the parsing routine begins by extracting the first
'*                  tag-value pair from the array.  this is done by using
'*                  TV_PAIR_SEP to denote the boundary between tvpairs.
'*
'*                  next, the individual tags and values are extracted from
'*                  a tag-value pair ( see above ).  tags and values are
'*                  separated by TV_SEP.
'*
'*                  once a tag and value have been isolated, SetTvPair() is
'*                  used to add the tag and value to a tag-value list.
'*
'* INPUTS:          TvString ( ByVal )
'*                      tag-value string
'*
'* OUTPUTS:         none
'*
'* FUNCTION CALLS:  SetTvPair()
'*                      adds a node to a tvlist
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    December 30, 1997
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 12/30/97  B Lucas            original code.
'*
'**************************************************************************
Private Function BuildTvList(ByVal TvString As String) As Integer

Dim rc As Integer
Dim Curr As Integer
Dim SubStrLen As Long
Dim StartPosition As Long
Dim SubStr As String
Dim Tag As String
Dim Value As String
Dim InString() As Byte
Dim UpperBoundary As Integer

'init variables
Curr = 1
InString() = TvString
UpperBoundary = UBound(InString)

'loop through array boundry
While (LenB(Left$(InString(), Curr)) < UpperBoundary)

    'get length of next tag-value pair
    SubStrLen = InStr(1, Mid$(InString(), Curr), TV_PAIR_SEP)
        
    'if len is 0, the end of the tvstring has been reached
    If SubStrLen = 0 Then
    
        'last tag value pair
        SubStr = Mid$(InString(), Curr)
        Curr = Curr + Len(SubStr)
    
    Else
        
        'parse next tag value pair
        SubStr = Left$(Mid$(InString(), Curr), SubStrLen - 1)
        
        'move index to next tag value pair
        Curr = Curr + SubStrLen
        
    End If

    'set position of next tvpair
    StartPosition = InStr(1, SubStr, TV_SEP)
    
    'parse tag and value from sub string
    If StartPosition Then
    
        Tag = Left$(SubStr, (StartPosition - 1))
        Value = Mid$(SubStr, StartPosition + 1)
        
        'add tag and value to list
        rc = SetTvPair(Tag, Value)
        
    End If
Wend

End Function


'**************************************************************************
'*
'* FUNCTION:        BuildTvString()
'*
'* DESCRIPTION:     this function builds a tag-value string from the tag-
'*                  value linked list
'*
'* INPUTS:          none
'*
'* OUTPUTS:         InData ( ByRef )
'*                      tag-value string populated from tvlist
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    December 30, 1997
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 12/30/97  B Lucas            original code.
'*
'**************************************************************************
Private Function BuildTvString(ByRef InData As String) As Integer

    Dim pCurr As clsTvPair
    
    'check for list
    If Not (TvList Is Nothing) Then
        
        'start at head of list
        Set pCurr = TvList.pHead
        
        'build tag value string from list
        While Not (pCurr Is Nothing)
        
            If Len(InData) Then InData = InData & TV_PAIR_SEP
            InData = InData & pCurr.Tag & TV_SEP & pCurr.Value
            
            'move to next node
            Set pCurr = pCurr.pNext
        
        Wend
    End If

End Function


'**************************************************************************
'*
'* FUNCTION:        FindTvPair()
'*
'* DESCRIPTION:     this function searches the linked list for the input
'*                  'tag'.  if a node is found that contains 'tag', a
'*                  reference is passed to the calling function via the
'*                  TvPair variable.  if 'tag' was not found, TvPair is
'*                  set to 'nothing'.
'*
'* INPUTS:          Tag    ( ByVal )
'*                      tag to search for
'*
'* OUTPUTS:         TvPair ( ByRef )
'*                      node containing specified tag or 'Nothing' if
'*                      the tag was not found
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    December 30, 1997
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 12/30/97  B Lucas            original code.
'*
'**************************************************************************
Private Function FindTvPair(ByVal Tag As String, _
                            ByRef TvPair As clsTvPair) _
                            As Integer

    Dim Found As Boolean
    Dim Curr As clsTvPair
    
    'init variables
    Found = False
    
    'check for list
    If Not (TvList Is Nothing) Then
    
        'start at head of list
        Set Curr = TvList.pHead
        
        'loop entire list
        While (Not (Curr Is Nothing)) And Found = False
        
            'test of match
            If Curr.Tag = Tag Then
            
                'return reference to current node
                Set TvPair = Curr
                Found = True
            
            Else
            
                'move to next node
                Set Curr = Curr.pNext
            
            End If
        Wend
    End If

End Function


'**************************************************************************
'*
'* FUNCTION:        GetTvPair()
'*
'* DESCRIPTION:     this function returns the value associated with a
'*                  tag found in a tag-value linked list
'*
'* INPUTS:          Tag ( ByVal )
'*                      tag to search nodes in linked list
'*
'* OUTPUTS:         none
'*
'* FUNCTION CALLS:  FindTvPair()
'*                      returns a reference to a node containing a specified
'*                      'tag'
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    December 30, 1997
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 12/30/97  B Lucas            original code.
'*
'**************************************************************************
Public Function GetTvPair(ByVal Tag As String) As Variant

    Dim rc As Integer
    Dim pCurr As clsTvPair
    
    'search list for tag
    rc = FindTvPair(Tag, pCurr)
    
    If Not (pCurr Is Nothing) Then
    
        'return value associated with given tag
        GetTvPair = pCurr.Value
            
    End If

End Function


'**************************************************************************
'*
'* FUNCTION:        GetTvPairAll()
'*
'* DESCRIPTION:     this function will return a tag-value string representing
'*                  all nodes contained in the tag-value linked list
'*
'* INPUTS:          none
'*
'* OUTPUTS:         none
'*
'* FUNCTION CALLS:  BuildTvString()
'*                      builds a tag-value string from a linked list
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    December 30, 1997
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 01/05/97  B Lucas            original code.
'*
'**************************************************************************
Public Function GetTvPairAll() As Variant

    Dim TvString As String
    Dim rc As Integer
    
    'build tvstring
    rc = BuildTvString(TvString)
    
    'return tvstring
    GetTvPairAll = TvString

End Function


'**************************************************************************
'*
'* FUNCTION:        GetTvPairByIndex()
'*
'* DESCRIPTION:     this function returns the tvpair associated with the
'*                  index found in a tag-value linked list
'*
'* INPUTS:          Index ( ByVal )
'*                      index number to search nodes in linked list
'*
'* OUTPUTS:         none
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    February 03, 1998
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 02/03/98  B Lucas            original code.
'*
'**************************************************************************
Public Function GetTvPairByIndex(ByVal Index As Integer) As Variant

    Dim i As Integer
    Dim rc As Integer
    Dim pCurr As clsTvPair
       
    'check for list
    If Not (TvList Is Nothing) Then
       
        'check for tvlist and verify index exists
        If (Not (TvList.pHead Is Nothing)) And _
           (Index <= TvList.NumTvPair) And _
           (Index > 0) Then
        
            'start at head of list and 1st tvpair
            Set pCurr = TvList.pHead
            i = 1
        
            'move to index
            While (i < Index) And (Not (pCurr Is Nothing))
                Set pCurr = pCurr.pNext
                i = i + 1
            Wend
            
            'return tvpair associated with index
            If Not (pCurr Is Nothing) Then
                GetTvPairByIndex = pCurr.Tag & TV_SEP & pCurr.Value
            End If
            
        End If
    End If

End Function


'**************************************************************************
'*
'* FUNCTION:        InitTcpPipe()
'*
'* DESCRIPTION:     this function is used to set the tcp connection
'*                  parameters.  these values can also be set via
'*                  property calls
'*
'* INPUTS:          HostName    ( ByVal )
'*                      hostname of tcp connection
'*                  ServiceName ( ByVal )
'*                      servicename of tcp connection
'*                  Timeout     ( ByVal )
'*                      timeout of tcp connection
'*
'* OUTPUTS:         none
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    December 30, 1997
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 12/30/97  B Lucas            original code.
'*
'**************************************************************************
Public Function InitTcpPipe(ByVal HostName As String, _
                            ByVal ServiceName As String, _
                            ByVal Timeout As Integer) _
                            As Integer
    
    'set tcp parms
    If Len(HostName) Then TcpPipeParms.HostName = HostName
    If Len(ServiceName) Then TcpPipeParms.ServiceName = ServiceName
    If Timeout > 0 Then TcpPipeParms.Timeout = Timeout

End Function


'**************************************************************************
'*
'* FUNCTION:        InitTvList()
'*
'* DESCRIPTION:     this function is used to initialize the tag-value
'*                  linked list
'*
'* INPUTS:          none
'*
'* OUTPUTS:         none
'*
'* FUNCTION CALLS:  none
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    December 30, 1997
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 12/30/97  B Lucas            original code.
'*
'**************************************************************************
Public Function InitTvList() As Integer
    
    'free existing list and create new one
    Set TvList = Nothing
    Set TvList = New clsTvList

End Function


'**************************************************************************
'*
'* FUNCTION:        SendMsg()
'*
'* DESCRIPTION:     this function is used to send and receive transactions
'*                  from the ags.
'*
'*                  SendMsg first calls BuildTvString to build the input
'*                  tag-value string from the linked list.  next,
'*                  AGSSendData and AGSRecvData are used to handle the
'*                  inter-process communication with the AGS.
'*
'*                  there are detailed comments in the code for AGSSendData
'*                  and AGSRecvData that can answer specific question about
'*                  their functionality and parameters.
'*
'* INPUTS:          AgsTxID      ( ByVal )
'*                      ags transaction id
'*                  TxID         ( ByVal )
'*                      transaction id
'*                  TxVer        ( ByVal )
'*                      transaction version
'*                  CacheTimeLen ( ByVal )
'*                      length transactions will be cached
'*                  ForceCall    ( ByVal )
'*                      bypass any cached data
'*                  ForceCache   ( ByVal )
'*                      force the transaction to be cached
'*
'* OUTPUTS:         none
'*
'* FUNCTION CALLS:  BuildTvString()
'*                      builds a tag-value string from the tvlist
'*                  InitTvList()
'*                      initializes the tag-value list
'*                  AGSSendData()
'*                      sends the input data to the ags
'*                  AGSRecvData()
'*                      reads the output data from the ags
'*                  BuildTvList()
'*                      adds nodes to the tag-value linked list
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    December 30, 1997
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 12/30/97  B Lucas            original code.
'*
'**************************************************************************
Public Function SendMsg(ByVal AgsTxID As Long, _
                        ByVal TxID As Long, _
                        ByVal TxVer As Long, _
                        ByVal CacheTimeLen As Long, _
                        ByVal ForceCall As Long, _
                        ByVal ForceCache As Long) _
                        As Integer
    
    Dim rc As Integer
    Dim InData As String
    Dim OutData As String
    Dim hwndOutData As Long
    Dim MsgHeader As MESSAGE_HDR
                
    'build string from list
    rc = BuildTvString(InData)
    InData = InData & Chr$(0)
    
    'clear list
    rc = InitTvList
                
    'set tcppipe parms.  where not set, use defaults
    If Len(TcpPipeParms.HostName) = 0 Then _
        TcpPipeParms.HostName = DEF_HOST_NAME
    If Len(TcpPipeParms.ServiceName) = 0 Then _
        TcpPipeParms.ServiceName = DEF_SERV_NAME
    If TcpPipeParms.Timeout = 0 Then _
        TcpPipeParms.Timeout = DEF_TCP_TIMEOUT
                
    'set msgheader
    With MsgHeader
        .AgsTxID = AgsTxID
        .TxID = TxID
        .TxVersion = TxVer
        .DataLen = Len(InData)
        .CacheTimeLen = CacheTimeLen
        .ForceCall = ForceCall
        .ForceCache = ForceCache
    End With
       
    'send message to gateway server
    SendMsg = AGSSendData(MsgHeader, TcpPipeParms, InData, hwndOutData)

    'check for return data
    If hwndOutData Then
   
        'allocate memory for return data
        OutData = Space(MsgHeader.DataLen - 1)
        
        'get return data
        rc = AGSRecvData(hwndOutData, OutData, (MsgHeader.DataLen - 1))
                           
        'buil new tag value list from return data
        rc = BuildTvList(OutData)
    
    End If

End Function


'**************************************************************************
'*
'* FUNCTION:        SetTvPair()
'*
'* DESCRIPTION:     this function adds a 'tag' and 'value' to the tag-value
'*                  linked list
'*
'* INPUTS:          Tag   ( ByVal )
'*                      string containing a 'tag'
'*                  Value ( ByVal )
'*                      string containing a 'value'
'*
'* OUTPUTS:         none
'*
'* FUNCTION CALLS:  FindTvPair()
'*                      returns a reference to a node containing a specified
'*                      'tag'
'*
'* AUTHOR:          Brian Lucas
'*
'* DATE CREATED:    December 30, 1997
'*
'* REVISION HISTORY
'*
'* DATE      REVISED BY  SIR #  DESCRIPTION OF CHANGE
'* --------  ----------  -----  -------------------------------------------
'* 12/30/97  B Lucas            original code.
'*
'**************************************************************************
Public Function SetTvPair(ByVal Tag As String, _
                          ByVal Value As Variant) _
                          As Integer
                          
    Dim rc As Integer
    Dim pCurr As clsTvPair
    
    If Len(Tag) > 0 Then
    
        ' check if tvlist has been created
        If TvList Is Nothing Then
            rc = InitTvList
        End If
    
        'search for existing tvpair
        rc = FindTvPair(Tag, pCurr)
        
        'existing node not found
        If pCurr Is Nothing Then
            
            'add new node to list
            Set pCurr = New clsTvPair
        
            If TvList.pHead Is Nothing Then
                
                'first in list
                Set TvList.pHead = pCurr
                        
            Else
            
                ' set last node's next pointer to current node
                Set TvList.pTail.pNext = pCurr
                        
            End If
            
            'update tail
            Set TvList.pTail = pCurr
            
            'update count
            TvList.NumTvPair = TvList.NumTvPair + 1
        
        End If
        
        pCurr.Tag = Tag
        pCurr.Value = Value

    End If

End Function
