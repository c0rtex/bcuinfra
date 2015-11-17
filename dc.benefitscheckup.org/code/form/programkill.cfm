<cfset form_id=url.form_id>
<cfset program_id=url.program_id>
<cfset src=url.src>

<cfinclude template="programdissociate.cfm">

<cfif src eq 'prg'>
	<cfinclude template="programqueries.cfm">
	<cflocation url="../programs/program.cfm?prg_id=#prg_id#&st=#pstate#">
<cfelse>
	<cflocation url="formview.cfm?id=#form_id#">
</cfif>