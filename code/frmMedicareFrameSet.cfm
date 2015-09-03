
<cfset frameheight = 35>
<html>
<head>
<cfif isdefined('url.startpace') and url.startpace eq 'Y' >
<title>PACE Online Enrollment</title>
<cfelse>
<title>Medicare-Approved Drug Discount Card Online Enrollment</title>
</cfif>
</head>

<cfoutput>
<frameset frameborder="0" framespacing="0" border="0" rows="#frameheight#,*">
	<frame src="frmMedicareFrame.cfm?#session.URLToken#" name="border" marginwidth="0" marginheight="0" scrolling="no" noresize frameborder="0" framespacing="0">
<cfif isdefined('url.startpace') and url.startpace eq 'Y' >
	<cfset session.startpace = 'Y'>
    <frame src="https://pacecares.fhsc.com/PaceEnrollmentWizard.asp" name="report" marginwidth="0" marginheight="0" scrolling="Yes" noresize frameborder="0" framespacing="0">
<cfelseif isdefined('url.startSSA') and url.startSSA eq 'Y' >
	<cfset session.startpace = 'Y'>
    <frame src="http://www.ssa.gov/i1020apply" name="report" marginwidth="0" marginheight="0" scrolling="Yes" noresize frameborder="0" framespacing="0">

<cfelse>
    <cfset session.startpace = 'N'>
	<frame src="#session.MedicareEnrollmentURL#" name="report" marginwidth="0" marginheight="0" scrolling="Yes" noresize frameborder="0" framespacing="0">
</cfif>
</frameset>
</cfoutput>
<noframes>
Your Browser does not support frames.
</noframes>
</html>
