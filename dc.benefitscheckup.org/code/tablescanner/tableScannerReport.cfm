<cfset datasource = application.dbSrc>

<cfquery datasource="#datasource#" name="report">
    SELECT * FROM tablecleaner 
	WHERE tablecleaner_virus > 0
</cfquery>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<style type="text/css">
body, td {
	font-family:Calibri, Arial, Helvetica, sans-serif;
	font-size:12px;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>TableScanner Report</title>
</head>

<body>

<h1>TableScanner Report</h1>

<p><a href="tablescanner.cfm?init=1">Initialize TablesScanner</a></p>

<table cellpadding="0" border="1">
<tr>
<td>Table</td>
<td>Virus Count</td>
<td>Viruses</td>
<td>Infected Columns</td>
<td>Status</td>
</tr>

<cfoutput query="report">
<tr>
<td>#TABLECLEANER_TABLE_NAME#</td>
<td>#TABLECLEANER_VIRUS#</td>

<td><cfloop list="#TABLECLEANER_VIRUSES#" index="i" delimiters="|">#htmleditformat(i)#<br /></cfloop></td>
<td><cfloop list="#tablecleaner_virus_cols#" index="i2">
#i2#<br />
</cfloop></td>
<td>Status</td>
</tr>
</cfoutput>
</table>


</body>
</html>

