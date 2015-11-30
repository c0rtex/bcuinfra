<cfsilent>
<cfparam name="pg" type="numeric" default="0">
<cfparam name="badResponseList" type="string" default="">
<cfparam name="zip" type="string" default="" >

<cfparam name="state_id" default="">
<cfparam name="partner_id" default="0">

<cf_cachePartnerQuery query="partnerQuery" partner_id="#partner_id#">
<cf_cacheStatePool action="get" state_id="#state_id#" var="stobj">

<cfset initial = false>
<cfif pg eq 0>
	<cf_sessionLoadVars>
	<cfif zip neq ''>
		<cfquery name="zipstate" datasource="#application.dbSrc#">
			select state_id
			from zip
			where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#zip#" maxlength="5">
				and valid=1
		</cfquery>
		<cfif zipstate.RecordCount>
			<cfset session.state_id = zipstate.state_id>
			<cfset session.st = zipstate.state_id>
			<cfset session.zip = zip>
		<cfelse>
			<cfset zip = ''>
		</cfif>
	</cfif>
	<cf_handleScreening mode="full" initvarname="accumAFList">
	<cfif zip neq ''>
		<cf_handleScreeningAnswerfield action="set" code="zip" val="#zip#" pre="#zip#">
	</cfif>
	<cfset pg = 1>
	<cfset initial = true>
<cfelseif pg eq 1>
	<cf_logScreeningInput initvarname="accumAFList" prepopulateWithInput="true">
	<cfif IsDefined('form.zyxzip_state_change') and form.zyxzip_state_change neq ''>
		<cf_handleScreening action="reload" mode="full" state_id="#Evaluate("form.#form.zyxzip_state_change#")#" initvarname="accumAFList">
		<cfset pg = 1>
		<cfset badResponseList = ''>
		<cfset initial = true>
	</cfif>
<cfelse>
	<cfset accumAFList = ''>
</cfif>

</cfsilent><cfif not initial and not ListLen(badResponseList)>
	<cflocation url="proceligibility.cfm" addtoken="yes">
<cfelse><cf_buildHTML cellpadding="12" cellspacing="2" jsInclude="true">

<cf_displayButton return_oe="true">

<cfif not initial and ListLen(badResponseList)>
<font color="red"><strong>Some answers were filled in incorrectly.  Please see error messages below.</strong></font><br />
</cfif>

<cfoutput>


<cfif session.subset_id IS 19 AND trim(partnerQuery.wrapper_pap_custom_name) IS NOT "">
	<cfoutput>
	<h2>#partnerQuery.wrapper_pap_custom_name# Questionnaire for #stobj.name#</h2>
	</cfoutput>
<cfelseif session.subset_id IS 49 AND trim(partnerQuery.wrapper_custom_title) IS NOT "">
	<cfoutput>
	<h2>#partnerQuery.wrapper_custom_title# Questionnaire for #stobj.name#</h2>
	</cfoutput>
<cfelse>
	<h2><cf_displayText code="site_single_page_qaire_title" group="site"></h2>
</cfif>


<cfset ecid = ''>
<cfif IsDefined('ext_client_id') and ext_client_id neq '' and ext_client_id neq '0' and ext_client_id neq 'NULL'>
	<cfset ecid = ext_client_id>
<cfelseif IsDefined('session.client_id') and session.client_id neq '' and IsNumeric(session.client_id)>
	<cfquery name="getClient" datasource="#application.dbSrcOE#">
		SELECT ext_client_id
		FROM CLIENT
		WHERE client_id=#session.client_id#
	</cfquery>
	<cfif getClient.RecordCount>
		<cfset ecid = getClient.ext_client_id>
	</cfif>
</cfif>
<cfif ecid neq ''>
	<h3><cf_displayText code="site_single_page_for_client_id" group="site"> <em style="color: red;">#ecid#</em></h3>
</cfif>

<cf_displayText code="site_single_page_qaire_intro" group="site"><br />

<form action="#application.transferType#://#application.serverPath#/full.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post" name="qaire">
<cf_buildQuestionnaire name="qaire" aflistvarname="accumAFList" errorlist="#badResponseList#">

<cfif accumAFList neq ''>
	<br />
	<cf_passScreeningInput varname="accumAFList">
	<input type="hidden" name="pg" value="#pg#">
	<div align="right">
	<input type="submit" value=" View Results ">
	</div>
</cfif>

</form>
</cfoutput>

</cf_buildHTML></cfif>