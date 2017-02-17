<!---
Template Name: start.cfm 
Component Purpose: first page of low income subsidy application
Data Tables: NA	
--->
<cf_sessionLoadVars>
<!--- start display of text  --->
<cf_buildHTML cellpadding="12" cellspacing="2">
<cfoutput>
<cfset application.enableLIS = false>
<cfif application.enableLIS >
	<!--- generate site text --->
	<cf_displayText code="site_turboapp_welcome" group="site"><br><br>
	<cf_sessionPassVars action="https://#application.consumerurl#/cf/lisapp/continue.cfm" method="post">
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

