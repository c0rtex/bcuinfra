<cfparam name="isauthorized" type="integer" default="0">
<cfparam name="form.username" default="">
<cfparam name="form.password" default="">

<cfif form.username eq "test" and form.password eq "test">
	<cfset isauthorized  = "true">
</cfif>

<cfif isauthorized >
	<cfset session.autologin = true>
	<cfset session.autouser = form.username>
	<cfset session.autpassword = form.password>
	<cflocation url="/fit/">
<cfelse>

<h2>Invalid Site login</h2>
<cfoutput>#form.username#:#form.password#</cfoutput>

</cfif>