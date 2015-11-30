<cfif session.org_id gt 0>
	<cfset partner_id=session.partner_id>
	<cfinclude template="tagCobrandValues.cfm">
<cfelse>
	<cfset page_background = 'bgcolor="##ffffff"'>
</cfif>
<cfoutput><body #page_background#></cfoutput>