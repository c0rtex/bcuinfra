<cfparam name="debug" default="false">
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

<cfif not initial and not ListLen(badResponseList)>
	<h2>Screening Complete</h2>
<cfelse>




<cfif not initial and ListLen(badResponseList)>
<font color="red"><strong>Some answers were filled in incorrectly.  Please see error messages below.</strong></font><br />
</cfif>

<cfoutput>
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



<cfif parameterExists(session.transferTypeCanonicalOverride)>
	<cfset urlType = session.transferTypeCanonicalOverride>
<cfelse>
	<cfset urlType = application.transferType>		
</cfif>	
<cf_buildQuestionnaire name="qaire" mode="remote" debug="#debug#" aflistvarname="accumAFList" errorlist="#badResponseList#">
<cfif debug ><cfoutput>#questionnaireXML#</cfoutput></cfif>
</cfoutput>
</cfif>