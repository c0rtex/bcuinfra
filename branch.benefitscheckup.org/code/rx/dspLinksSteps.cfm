<cfif not isdefined('request.dontapply')>
	<cfset request.dontapply = "No">
</cfif>

<cfset source="recommendations">

<cfif request.dontapply neq "Yes">
	<cfset formtype_id = "1">
	<cfinclude template="../dsp_appforms.cfm">
	<cfset formtype_id = "2">
	<cfinclude template="../dsp_appforms.cfm">
	<cfset formtype_id = "4">
	<cfinclude template="../dsp_appforms.cfm">
</cfif>

<cfset request.dontapply = "No">