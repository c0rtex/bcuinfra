<!--- Set guts --->
<cfset guts = "medicaid_locator_cf.cfm">
<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>
<cfset session.maskURL = "true">
<cf_tagHeader guts="#guts#" show_left_col="n" showmenu="0">
<cfinclude template="#guts#">
<cf_tagFooter show_left_col="n" showmenu="0">
