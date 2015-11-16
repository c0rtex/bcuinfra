<cfinclude template="languagequeries.cfm">

<cfif active>
	<cf_displaymenu title="Activate Language">
<cfelse>
	<cf_displaymenu title="Deactivate Language">
</cfif><cfoutput>

Are you sure you want to <cfif not active>de</cfif>activate the language <b>#language_name#</b>?

<form action="languageactivation.cfm?language_id=#language_id#&active=#active#" method="post">
	<input type="submit" value="<cfif active>A<cfelse>Dea</cfif>ctivate">
	&nbsp; &nbsp;
	<input type="button" value="Cancel" onClick="history.go(-1)">
</form>

</cfoutput><cfmodule template="../footer.cfm">