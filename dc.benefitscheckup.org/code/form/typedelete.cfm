<cfset form_id=url.form_id>
<cfset type_id=url.type_id>

<cfinclude template="formqueries.cfm">
<cfinclude template="typequeries.cfm">

<cf_formmenu title="Delete Instance from Form"><cfoutput>

Are you sure you want to delete the <b>#tname#</b> instance from the <b><a href="formview.cfm?id=#form_id#">#fname#</a></b>?  This cannot be undone.

<form action="typekill.cfm?form_id=#form_id#&type_id=#type_id#" method="post">
	<input type="submit" value="Yes, delete it!">
</form>
<form action="formview.cfm?id=#form_id#" method="post">
	<input type="submit" value="No, don't delete it">
</form>

</cfoutput><cfmodule template="../footer.cfm">