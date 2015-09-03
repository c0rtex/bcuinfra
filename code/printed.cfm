<cf_sessionLoadVars>
<!--- Set guts --->
<cfset guts = "printed_cf.cfm">
<!--- Initialize and load any session variable value passed into this page --->
<cf_tagHeader guts="#guts#" show_left_col="y">
<cfinclude template="#guts#">
<cf_tagFooter>