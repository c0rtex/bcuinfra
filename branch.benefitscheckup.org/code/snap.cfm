<!--- Set guts --->
<cfset guts = "snap_cf.cfm">
<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>

<cfset showmenu = 1>

<cf_tagHeader guts="#guts#" show_left_col="y" showmenu="#showmenu#">
<cfinclude template="#guts#">
<cf_tagFooter>
