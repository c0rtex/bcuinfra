<cfquery name="spiders" datasource="#application.dbSrc#">
	SELECT * FROM spider 
	ORDER BY spider_path
</cfquery>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<style type="text/css">
.code {
	border: 1px solid #000033;
	background-color:#FFFFCC;
	max-width: 800px;
}

thead {
	font-weight:bold;
}

</style>


<title>BCU Template Spider</title>
</head>

<body>

<h1>BCU Template Spider</h1>

<table border="1" cellpadding="2">
<thead>
<tr>
<td>Path</td>
<td>Template</td>
<td>Queries</td>
<td>Assigned To</td>
<td>Status</td>
<td></td>
</tr>
</thead>

<cfoutput query="spiders">

<tr>
<td>#spider_path#</td>
<td>#spider_path#</td>
<td>#spider_queries#</td>
<td>#spider_assigned_to#</td>
<td>

<cfswitch expression="#spider_status#">
<cfcase value="0">Unassigned</cfcase>
<cfcase value="1">Assigned - Pending</cfcase>
<cfcase value="2">Problem</cfcase>
<cfcase value="3">Complete</cfcase>
</cfswitch>

</td>
<td><a href="template.cfm?spider_id=#spider_id#" target="#spider_id#">View</a></td>
</tr>

</cfoutput>
</table>
</body>
</html>
