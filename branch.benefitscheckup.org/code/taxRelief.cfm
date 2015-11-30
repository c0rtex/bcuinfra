<!--- Set guts --->
<cfif url.partner_id eq 77>
	<cfset session.partner_id = 77>
    </cfif>
<cfset guts = "taxRelief_cf.cfm">
<cf_tagHeader guts="#guts#" show_left_col="y">
<cfinclude template="#guts#">
<cf_tagFooter>
