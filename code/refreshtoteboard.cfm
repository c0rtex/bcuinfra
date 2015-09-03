<cfset vsiURL="#application.transferType#://#application.serverPath#/vsi/">

<html>
<head>
	<title>Refresh Toteboard</title>
</head>

<body>

<h3>Refresh Toteboard</h3>

<p>Refreshing the BCU Toteboard Cache is now a function performed from the <strong>Variable Space Inspector</strong> console.  Please bookmark the new page:</p>

<cfoutput>
<p><a href="#vsiURL#">#vsiURL#</a></p>
</cfoutput>

</body>
</html>