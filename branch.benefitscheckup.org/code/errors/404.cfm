<!--- Set guts --->
<cfset guts = "404_cf.cfm">
<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>
<cf_tagHeader guts="#guts#" show_left_col="y">
<cfinclude template="#guts#">
<cf_tagFooter>
