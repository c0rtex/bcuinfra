<cf_sessionLoadVars>
<cf_buildHTML cellpadding="12" cellspacing="2">
<cfoutput>
<cfset application.enableLIS = true>
<cfif application.enableLIS >
	<cf_displayText code="site_turboapp_welcome" group="site"><br><br>
	<cf_sessionPassVars action="https://#application.consumerurl#/cf/continue.cfm" method="post">
		<input type="submit" value="Apply Now">
	</cf_sessionPassVars>
	<p>
	<cf_displayButton return_oe="true">
	</p>
	<cf_tagPlText column_name="cms_doc_no">
<cfelse>
	<div align="center"><cf_displayText code="site_turboapp_not_available" group="site"></div>
</cfif>
</cfoutput>

</cf_buildHTML>

