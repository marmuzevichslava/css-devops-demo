<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<html>

<head>
<meta http-equiv="Content-Type"
content="text/html; charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 2.0">
<title>AGS IFO Input page</title>
<base target="footnotes">
</head>

<body>

<form action="agsifoout.asp" method="GET" name="frmInput"
target="footnotes">
    <input type="hidden" name="AGSTxID" value="0"><p align="left"><font
    size="4"><strong>Input:</strong></font></p>
    <div align="center"><center><table border="0">
        <tr>
            <td><strong>Request Type</strong></td>
            <td>&nbsp;</td>
            <td colspan="2"><strong>MsgHeader</strong></td>
            <td>&nbsp;</td>
            <td colspan="2"><strong>Data</strong></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>Tag</td>
            <td>Value</td>
        </tr>
        <tr>
            <td><input type="radio" checked name="RequestType"
            value="CodesTable" language="VBScript"
            onclick="frmInput.Value1.value = 'CIS00059'
frmInput.Value2.value = '50'
frmInput.Tag2.value = 'NumRecReq'
frmInput.TxID.value = '51'
frmInput.TxVer.value = '1'
frmInput.CacheTime.value = '99999'
frmInput.ForceCache.selectedIndex = 0
frmInput.ForceCall.selectedIndex = 0
frmInput.Tag3.value = ''
frmInput.Value3.value = ''
frmInput.Value4.value = ''
frmInput.Value5.value = ''
frmInput.Tag4.value = ''
frmInput.Tag5.value = ''
frmInput.Tag1.value = 'TblName'">
            Codes Table </td>
            <td>&nbsp;</td>
            <td>TxID:</td>
            <td><input type="text" size="11" name="TxID"
            value="51"> </td>
            <td>&nbsp;</td>
            <td><input type="text" size="15" name="Tag1"
            value="TblName"> </td>
            <td><input type="text" size="15" name="Value1"
            value="CIS00059"> </td>
        </tr>
        <tr>
            <td><input type="radio" name="RequestType"
            value="CustRetr" language="VBScript"
            onclick="frmInput.CacheTime.value = '10'
frmInput.TxID.value = '1'
frmInput.TxVer.value = '1'
frmInput.Value1.value = '42301879'
frmInput.Value2.value = ''
frmInput.Value3.value = ''
frmInput.Value4.value = ''
frmInput.Value5.value = ''
frmInput.Tag1.value = 'KyBa'
frmInput.Tag2.value = ''
frmInput.Tag3.value = ''
frmInput.Tag4.value = ''
frmInput.Tag5.value = ''
frmInput.ForceCache.selectedIndex = 1
frmInput.ForceCall.selectedIndex = 0">
            Cust Retr </td>
            <td>&nbsp;</td>
            <td>TxVer:</td>
            <td><input type="text" size="11" name="TxVer"
            value="1"> </td>
            <td>&nbsp;</td>
            <td><input type="text" size="15" name="Tag2"
            value="NumRecReq"> </td>
            <td><input type="text" size="15" name="Value2"
            value="50"> </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>Cache Time:</td>
            <td><input type="text" size="11" name="CacheTime"
            value="99999"> </td>
            <td>&nbsp;</td>
            <td><input type="text" size="15" name="Tag3"> </td>
            <td><input type="text" size="15" name="Value3"> </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>Force Call:</td>
            <td><select name="ForceCall" size="1">
                <option selected value="1"> True </option>
                <option value="0"> False </option>
            </select> </td>
            <td>&nbsp;</td>
            <td><input type="text" size="15" name="Tag4"> </td>
            <td><input type="text" size="15" name="Value4"> </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>Force Cache:</td>
            <td><select name="ForceCache" size="1">
                <option selected value="1"> True </option>
                <option value="0"> False </option>
            </select> </td>
            <td>&nbsp;</td>
            <td><input type="text" size="15" name="Tag5"> </td>
            <td><input type="text" size="15" name="Value5"> </td>
        </tr>
    </table>
    </center></div><p align="center"><input type="submit"
    name="cmdSubmit" value="Submit"> </p>
</form>
</body>
</html>
