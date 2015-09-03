<cfset vsiURL="#application.transferType#://#application.serverPath#/vsi/">

<html>
<head>
	<title>Refresh</title>
</head>

<body>

<h3>Refresh</h3>

<p>Refreshing the BCU Application Data Cache is now a function performed from the <strong>Variable Space Inspector</strong> console.  Please bookmark the new page:</p>

<cfoutput>
<p><a href="#vsiURL#">#vsiURL#</a></p>
</cfoutput>

</body>
</html>