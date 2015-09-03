<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>List of program descriptions</title>
</head>
<cfquery datasource=#application.dbSrc# name="desc" >
SELECT     prg_id, prg_nm, prg_desc
FROM         tbl_prg_all
</cfquery>
<body>
<table width="1200" border="1">
  <tr>
    <th width="109" scope="col">PRGID</th>
    <th width="187" scope="col">PRG NAME </th>
    <th width="900" scope="col">PRG DESC </th>
  </tr>
 <cfoutput query="desc">
  <tr>
    <td>#prg_id#</td>
    <td>#prg_nm#</td>
    <td>#prg_desc#</td>
  </tr>
 </cfoutput>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
