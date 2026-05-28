Attribute VB_Name = "basAGSIFO"
'***************************************************************************
'*
'*                CUSTOMER/1 Cooperative Architecture Module
'*
'*  MODULE NAME      : basAZAGSIFO
'*
'*  DESCRIPTION      :
'*
'*  REVISION HISTORY
'*
'*  DATE        REVISED BY  SIR #    DESCRIPTION OF CHANGE
'*  --------    ----------  ------   ---------------------------------------
'*  01/05/97    B Lucas              original code
'*
'***************************************************************************

'options
Option Explicit
                                                    
'custom types
Type TCP_PIPE_PARMS
    HostName As String
    ServiceName As String
    Timeout As Integer
End Type

Type MESSAGE_HDR
    AgsTxID       As Long
    TxID          As Long
    TxVersion     As Long
    DataLen       As Long
    CacheTimeLen  As Long
    ForceCall     As Long
    ForceCache    As Long
    rc            As Long
End Type

'external function prototypes
Public Declare Function AGSSendData Lib "azaxfunc" _
                            (ByRef MsgHeader As MESSAGE_HDR, _
                             ByRef TcpPipeParms As TCP_PIPE_PARMS, _
                             ByVal InData As String, _
                             ByRef hwndOutData As Long) _
                             As Integer
                                                        
Public Declare Function AGSRecvData Lib "azaxfunc" _
                            (ByRef hwndOutData As Long, _
                             ByRef OutData As String, _
                             ByVal OutDataLen As Long) _
                             As Integer
