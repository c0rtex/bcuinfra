<cfparam name="eflist" type="string" default="">
<cfparam name="efindex" type="numeric" default="1">
<cfparam name="efnums" type="string" default="">
<cfparam name="src" type="string" default="">
<cfset frameheight = 35>
<cfif eflist eq ''>
	<cfloop index="efcount" from="1" to="#efindex#">
		<cfif IsDefined("form.ef#efcount#") And Evaluate("form.ef#efcount#") neq ''>
			<cfset eflist = ListAppend(eflist, Evaluate("form.ef#efcount#"))>
			<cfset efnums = ListAppend(efnums, efcount)>
		</cfif>
	</cfloop>
	<cfset efindex = 1>
</cfif>
<cfif efindex gt ListLen(eflist)>
	<cfset efindex = ListLen(eflist)>
<cfelseif efindex lt 1>
	<cfset efindex = 1>
</cfif>
<html>
<head>
<title>BenefitsCheckUp</title>
</head>

<cfoutput>
<frameset frameborder="0" framespacing="0" border="0" rows="#frameheight#,*">
	<frame src="eformcontrol.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#&eflist=#eflist#&efindex=#efindex#&efnums=#efnums#&src=#src#" name="menu" marginwidth="0" marginheight="0" scrolling="no" noresize frameborder="0" framespacing="0">
	<frame src="eformsubmit.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#&efitem=#ListGetAt(eflist, efindex)#" name="application" marginwidth="0" marginheight="0" scrolling="auto" noresize frameborder="0" framespacing="0">
</frameset>
</cfoutput>
<noframes>
<h3>We're sorry</h3>
</noframes>
</html>
