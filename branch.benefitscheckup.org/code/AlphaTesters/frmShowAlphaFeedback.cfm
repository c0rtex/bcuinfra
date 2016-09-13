<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery datasource="#session.datasrc#" name="GetRecs">
   SELECT *
   FROM Feedback
</cfquery>

<cfset arrFields = ListToArray(GetRecs.ColumnList)>
<table border="1">
<cfoutput query="GetRecs">
<tr>
   <td>
   <font face="Arial">
   <cfloop index="ii" from="1" to=#ArrayLen(arrFields)#>
   <b>#arrFields[ii]#: </b>#Evaluate(arrFields[ii])#<br>
   </cfloop>
   </font>
   </td>
</tr>
</cfoutput>
</table>


</body>
</html>
