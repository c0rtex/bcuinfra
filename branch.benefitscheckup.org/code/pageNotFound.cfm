<cfif IsDefined('URL.partner_id')>
	<cfset SESSION.partner_id = URL.partner_id>
</cfif>

<!--- Set guts --->
<cfset guts = "pageNotFound_cf.cfm">

<cf_tagHeader guts="#guts#" show_left_col="y">
<cfinclude template="#guts#">
<cf_tagFooter>