<cfset url_id=url.id>

<cfinclude template="urlqueries.cfm">

<cf_urlmenu title="Deactivate URL"><cfoutput>

<form method="post" action="urlkill.cfm">
Are you sure you want to deactivate the URL <b>#uname#</b>?<br><br>

<input type="hidden" name="url_id" value="#url_id#">
<input type="submit" value="Deactivate">
&nbsp;
<cfinclude template="../cancel.cfm">
</form>

</cfoutput><cfmodule template="../footer.cfm">
