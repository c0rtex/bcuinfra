<cf_formmenu title="Deactivate All Eforms"><cfoutput>

Are you sure you want to deactivate all forms of type <b>eform</b>?  This action cannot be undone.

<form action="formeuthanize.cfm" method="post">
	<input type="submit" value="Yes, deactive them all, mwahahahahahaaaaa!">
</form>
<form action="formlist.cfm" method="post">
	<input type="submit" value="No, don't do it!">
</form>

</cfoutput><cfmodule template="../footer.cfm">