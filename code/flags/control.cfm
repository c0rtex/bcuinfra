<cfparam name="test_id" type="any" default="">

<cfif test_id eq 1>
	<cfset tester='ON'>
<cfelseif test_id eq 0>
	<cfset tester='OFF'>
<cfelseif IsDefined('session.test_id') And session.test_id eq 1>
	<cfset tester='ON'>
<cfelse>
	<cfset tester='OFF'>
</cfif>

<cf_sessionPassVars href="index.cfm" canonical="false" test_id="#test_id#" var="redirectURL">
<html>
<head>
	<title>Control Frame</title>
	<meta http-equiv="Refresh" content="15; url=control.cfm">
</head>
<body>
<cfoutput>

<b>#application.serverPath#</b><br>
Test status: #tester# &nbsp;&nbsp; <a href="frame.cfm?test_id=1" target="_parent">test on</a> &nbsp;&nbsp; <a href="frame.cfm?test_id=0" target="_parent">test off</a> &nbsp;&nbsp; <a href="#application.transferType#://#application.serverPath#/" target="_blank">launch #application.serverPath#</a>

</cfoutput>
</body>
</html>