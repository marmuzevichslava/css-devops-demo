<html>

<head>
<title>AGS Interface Object Stub</title>
</head>

<body>

<h3><strong>Output:</strong></h3>

<% 
TxID = request.querystring( "TxID" )

if TxID > 0 then

i = 1

'create instance of activex control
Set AZAGSIFO = Server.CreateObject("AZAGSIFO.AGSIFO")

'send tag-value pair to object
rc = AzAgsIFO.SetTvPair( request.querystring( "Tag1" ), _
                         request.querystring( "Value1" ))

rc = AzAgsIFO.SetTvPair( request.querystring( "Tag2" ), _
                         request.querystring( "Value2" ))

rc = AzAgsIFO.SetTvPair( request.querystring( "Tag3" ), _
                         request.querystring( "Value3" ))

rc = AzAgsIFO.SetTvPair( request.querystring( "Tag4" ), _
                         request.querystring( "Value4" ))

rc = AzAgsIFO.SetTvPair( request.querystring( "Tag5" ), _
                         request.querystring( "Value5" ))

'send transaction to ags
rc = AzAgsIFO.SendMsg( request.querystring( "AGSTxID" ), _
                       request.querystring( "TxID" ), _
                       request.querystring( "TxVer" ), _
                       request.querystring( "CacheTime" ), _
                       request.querystring( "ForceCall" ), _
                       request.querystring( "ForceCache" ))
%>

<BR>

<strong>Return Code:</strong> <% if rc > 0 then %>
                                  <% =rc %>
                              <% else %>
                                  <% =AzAgsIFO.GetTvPair( "rc" ) %>
                              <% end if %>

<strong>NumTvPairs:</strong> <% =AzAgsIFO.NumTvPair %>
<BR><BR>

<div align="center"><center>
<table border="1">

    <% while i <= AzAgsIFO.NumTvPair %>

    <tr>
        <td><% =Mid( AzAgsIFO.GetTvPairByIndex( i ),   1, 32 ) %></td>
        <td><% =Mid( AzAgsIFO.GetTvPairByIndex( i+1 ), 1, 32 ) %></td>
        <td><% =Mid( AzAgsIFO.GetTvPairByIndex( i+2 ), 1, 32 ) %></td>
    </tr>

    <% i=i+3 %>
    <% wend %>

</table>
</center></div>

<% end if %>

</body>
</html>
