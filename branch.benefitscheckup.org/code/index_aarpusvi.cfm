<cfparam name="gohome" default="true">
<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars redirect="#evaluate("not #gohome#")#">
<cf_cacheWrapperQuery query="wrapper" partner_id="#session.partner_id#">
<!--- Set guts --->
<cfparam name="link" default="">
<cfset showmenu = 0>

<cfset guts = "index_aarpusvi_cf.cfm">

<cfif Not IsDefined('session.org_id')>
	<cfset session.org_id = 0>
</cfif>

<cfif session.org_id GT 0>
	<cf_tagHeader log="false" randomimage="y" showmenu="0">
	<cfinclude template="#guts#">
	<cf_tagFooter>
<cfelse>
	<cf_tagHeader log="false" guts="#guts#" show_left_col="y" rightcol="rightcol_partners.cfm" randomimage="y" showmenu="0">
	<cfinclude template="#guts#">
	<cf_tagFooter rightcol="rightcol_partners.cfm">
</cfif>
