<cfparam name="RxPrgList" type="string" default="">
<cfparam name="src" type="string" default="">
<cfif src eq 'comp'>
	<cfset session.returnFromGuide = 'elig'>
	<cfset session.guideMode = 'comp'>
<cfelse>
	<cfset session.returnFromGuide = 'rec'>
	<cfset session.guideMode = 'rx'>
</cfif>
<cfset framewidth = 1>
<html>
<head>
<title>Your BenefitsCheckUp Report</title>
</head>
<cfoutput>
<frameset frameborder="0" framespacing="0" border="0" cols="#framewidth#,*">
	<frame src="frmAccessMeta.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" name="border" marginwidth="0" marginheight="0" scrolling="no" noresize frameborder="0" framespacing="0">
	<frame src="frmEForms.cfm?src=#src#&cfid=#session.cfid#&cftoken=#session.cftoken#&RxPrgList=#RxPrgList#" name="drugs" marginwidth="0" marginheight="15" scrolling="auto" noresize frameborder="0" framespacing="10">
</frameset>
</cfoutput>
<noframes>
<h3>We're Sorry</h3>

Thank you for using <b>BenefitsCheckUp</b>.
</noframes>
</html>