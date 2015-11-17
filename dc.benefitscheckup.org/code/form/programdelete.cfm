<cfparam name="src" type="string" default="">
<cfset form_id=url.form_id>
<cfset program_id=url.program_id>

<cfinclude template="formqueries.cfm">
<cfinclude template="programqueries.cfm">

<cf_formmenu title="Delete Program from Form"><cfoutput>

Are you sure you want to delete the program <b><a href="../programs/program.cfm?prg_id=#prg_id#&st=#pstate#">#pname#</a></b> from the <b><a href="formview.cfm?id=#form_id#">#fname#</a></b>?  This cannot be undone.

<form action="programkill.cfm?form_id=#form_id#&program_id=#program_id#&src=#src#" method="post">
	<input type="submit" value="Yes, delete it!">
</form>
<cfif src eq 'prg'>
<form action="../programs/program.cfm?prg_id=#prg_id#&st=#pstate#" method="get">
<cfelse>
<form action="formview.cfm?id=#form_id#" method="post">
</cfif>
	<input type="submit" value="No, don't delete it">
</form>

</cfoutput><cfmodule template="../footer.cfm">