<cfquery name="formdeactivate" datasource="#application.dbSrc#">
	update form_formtype
	set active=0
	where formtype_id=2
</cfquery>

<cf_formmenu title="Eforms Deactivated!">
<cfoutput>

<h3>Congratulations!</h3>

You have now deactivated every eform on the site.  I hope you feel better now!<br><br>

</cfoutput><cfmodule template="../footer.cfm">