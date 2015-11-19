<!---
Template Name: continue.cfm 
Component Purpose: 2nd page of low income subsidy application, qualifies users and sends to question template
Data Tables: NA	
--->

<cf_sessionLoadVars>
<!--- Generate HTML Text --->
<cf_buildHTML cellpadding="12" cellspacing="2">
<cfoutput>

<cfif application.enableLIS>
	<cf_displayText code="site_turboapp_howtouse" group="site"><br><br>
	<cf_sessionPassVars action="https://#application.consumerurl#/cf/lisapp/questions.cfm" method="post">
		<input type="submit" value="Next">
	</cf_sessionPassVars>
	<cf_tagPlText column_name="cms_doc_no">
<cfelse>
	<div align="center"><cf_displayText code="site_turboapp_not_available" group="site"></div>
</cfif>
</cfoutput>
<!--- Finish Generate HTML Text --->
</cf_buildHTML>

