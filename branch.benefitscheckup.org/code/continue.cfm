<cf_sessionLoadVars>
<cf_buildHTML cellpadding="12" cellspacing="2">
<cfoutput>

<cfif application.enableLIS>
	<cf_displayText code="site_turboapp_howtouse" group="site"><br><br>
	<cf_sessionPassVars action="https://#application.consumerurl#/cf/questions.cfm" method="post">
		<input type="submit" value="Next">
	</cf_sessionPassVars>
	<cf_tagPlText column_name="cms_doc_no">
<cfelse>
	<div align="center"><cf_displayText code="site_turboapp_not_available" group="site"></div>
</cfif>
</cfoutput>

</cf_buildHTML>

