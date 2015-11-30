<cfsilent>
<cfparam name="pg" type="numeric" default="0">
<cfparam name="badResponseList" type="string" default="">
<cfparam name="zip" type="string" default="" >
<cfparam name="state_id" default="#session.state_id#">
<cfparam name="partner_id" default="0">
<cfif isdefined('session.partner_id') and (SESSION.partner_id EQ 89 OR SESSION.partner_id EQ 90)>
	<cfset partner_width = 840>
<cfelse>
	<cfset partner_width = 720>
</cfif>
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
	<!--- MH: Bug 5037 --->
	<cfif IsDefined("URL.lastname") and URL.lastname neq ''>
		<cfset session.fit_last_name = '#URL.lastname#'>
	</cfif>
	<cfif IsDefined("URL.agency_id") and URL.agency_id neq ''>
		<cfset session.fit_agency_id = '#URL.agency_id#'>
	</cfif>
	<cfif IsDefined("URL.screening_id") and URL.screening_id neq ''>
		<cfset session.prev_id = #URL.screening_id#>
	</cfif>
	<cfif IsDefined("URL.partner_id") and URL.partner_id neq ''>
		<cfset session.partner_id = #URL.partner_id#>
	</cfif>
		<cfif IsDefined("URL.subset_id") and URL.subset_id neq ''>
		<cfset session.subset_id = #URL.subset_id#>
	</cfif>
	<cf_handleScreening mode="full" initvarname="accumAFList">
	<!--- MH: Bug 5037 --->
	<cfif IsDefined("URL.lastname") and URL.lastname neq ''>
		<cf_handleScreeningAnswerfield action="set" code="fit_last_name" val="#URL.lastname#" pre="#URL.lastname#">
	</cfif>
	<cfif IsDefined("URL.agency_id") and URL.agency_id neq ''>
		<cf_handleScreeningAnswerfield action="set" code="fit_agency_id" val="#URL.agency_id#" pre="#URL.agency_id#">
	</cfif>
	<cfif IsDefined("URL.lastname") and IsDefined("URL.agency_id")>
		<cf_handleScreeningAnswerfield action="set" code="dob_year" val="1930" pre="1930">
		<cf_handleScreeningAnswerfield action="set" code="citizen" val="13" pre="13">
	</cfif>
	<!--- END MH Bug 5037 --->
    <!--- MH Bug 5213 --->
    <cfif session.subset_id eq 51 and session.partner_id eq 76>
    	<cf_handleScreeningAnswerfield action="set" code="client" val="1358" pre="1358">
    </cfif>
    <!--- END MH Bug 5213 --->
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
</cfsilent>

<cfif IsDefined('form.pl_agency_list') AND form.pl_agency_list EQ ''>
	<cfset badResponseList = 'chicago_agency_list'>
</cfif>

<!---Bug 6686 - BCU Site Redesign: Agency question has no validation check on SPQ --->
<cfif badResponseList EQ 'chicago_agency_list' AND IsDefined('form.pl_agency_list') AND form.pl_agency_list NEQ ''>
	<cflocation url="proceligibility.cfm" addtoken="yes">
</cfif>

<cfif not initial and not ListLen(badResponseList)>
	<cflocation url="proceligibility.cfm" addtoken="yes">
<cfelse>
	<cf_buildHTML cellpadding="12" cellspacing="2" jsInclude="true" guts="full.cfm">
<cf_displayButton return_oe="true">
<cfif not initial and ListLen(badResponseList)>
<font color="red"><strong>Some answers were filled in incorrectly.  Please see error messages below.</strong></font><br />
</cfif>
<cfoutput>
<cfif session.subset_id IS 19 AND trim(partnerQuery.wrapper_pap_custom_name) IS NOT "">
	<cfoutput>
	<h2>#partnerQuery.wrapper_pap_custom_name# Questionnaire for #stobj.name#</h2>
	</cfoutput>
<cfelseif session.subset_id IS 49 AND (
(trim(partnerQuery.wrapper_custom_title) IS NOT "" AND partnerQuery.wrapper_custom_subset IS 49) OR 
(trim(partnerQuery.wrapper_custom_title2) IS NOT "" AND partnerQuery.wrapper_custom_subset2 IS 49)
)>
	<cfoutput>
	<cfif trim(partnerQuery.wrapper_custom_title) IS NOT "" AND partnerQuery.wrapper_custom_subset IS 49>
		<h2>#partnerQuery.wrapper_custom_title# Questionnaire for #stobj.name#</h2>
	<cfelse>
		<h2>#partnerQuery.wrapper_custom_title2# Questionnaire for #stobj.name#</h2>
	</cfif>
	</cfoutput>
<cfelseif session.subset_id eq 0 and session.partner_id eq 101>
<cfoutput>
	<h2>Comprehensive BenefitsCheckUp Questionnaire for #stobj.name#</h2>
	</cfoutput>
<cfelseif session.subset_id eq 27 and session.partner_id eq 101>
<cfoutput>
	<h2>Extra Help (LIS) Quick Screen BenefitsCheckUp Questionnaire for #stobj.name#</h2>
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

<cfif session.partner_id eq 101>
<p>Welcome to the BenefitsCheckUp Questionnaire!  The following questions are designed to determine your potential eligibility for benefits programs. You will receive the most complete benefits report if you answer all questions.  Click the <font size="2"><u>HELP</u></font> link if you need help answering a question.</p><br>
<cfelse>
<cf_displayText code="site_single_page_qaire_intro" group="site"><br />
</cfif>
<cfif parameterExists(session.transferTypeCanonicalOverride)>
	<cfset urlType = session.transferTypeCanonicalOverride>
<cfelse>
	<cfset urlType = application.transferType>		
</cfif>	
<!---Bug 6686 - BCU Site Redesign: Agency question has no validation check on SPQ --->
<cfif IsDefined('form.pl_agency_list') AND form.pl_agency_list EQ ''>
	<script type="text/javascript">
		$(function() {
			$('DIV##agency_error').css('display','block');
		});
	</script>
</cfif>

<form action="/cf/full.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post" name="qaire">
<cf_buildQuestionnaire name="qaire" aflistvarname="accumAFList" errorlist="#badResponseList#" width="#partner_width#">

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
</cf_buildHTML>
</cfif>