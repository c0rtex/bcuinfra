<cfset url_id=url.url_id>

<cfinclude template="urlqueries.cfm">

<cf_urlmenu title="Reactivate URL"><cfoutput>

<form method="post" action="urlreactivate.cfm">
Are you sure you want to reactivate the url <b>#uname#</b>?<br><br>

<input type="hidden" name="url_id" value="#url_id#">
<input type="submit" value="Reactivate">
&nbsp;
<cfinclude template="../cancel.cfm">
</form>

</cfoutput><cfmodule template="../footer.cfm">
