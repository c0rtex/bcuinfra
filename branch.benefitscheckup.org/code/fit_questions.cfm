<cfparam name="page" type="numeric" default="0">
<cfparam name="edit" type="numeric" default="0">
<cfparam name="continue" type="numeric" default="0">
<cfparam name="badResponseList" type="string" default="">
<cfparam name="session.screening.recap" default="0">
<cfparam name="url.repop" default="false">

    <cfif page eq 0>
        <cf_sessionLoadVars>
        
        <cf_handleScreening initvarname="accumAFList">
        <cfset page = 1>
    <cfelseif continue eq 0 or continue eq 2>
        <cf_logScreeningInput initvarname="accumAFList" useOptionCodes="true">
    <cfelse>
        <cfset accumAFList = ''>
    </cfif>
    <!--- Start building page --->
	<cf_buildHTML cellpadding="12" cellspacing="2" allowBack="true">
		<cfoutput>
            <cf_displayText code="site_fit_questionnaire_header" group="site">
            <cfform id="fitForm" name="fitForm" action="fit_questions.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
            	<!--- start building question --->
				<cf_buildQuestionList page="#page#" edit="#edit#" continue="#continue#" errorlist="#badResponseList#">
                <!--- end building questions --->
				<cfif accumAFList neq ''>
					<cf_passScreeningInput varname="accumAFList">
					<cfif edit>
						<input type="submit" value="Submit Changes">
						<input type="hidden" name="page" value="#page#">
						<input type="hidden" name="edit" value="2">
					<cfelse>
						<cfif session.screening.recap gt 0>
							<cf_displayText code="site_turboapp_qaire_submit" group="site"><br><br>
							<input type="button" value="Submit Your Application" onClick="this.disabled = true; this.value= 'Please wait a few moments...'; this.form.submit();">
						<cfelse>
							<input type="submit" value="View Results">
						</cfif>
						<input type="hidden" name="page" value="#page#">
						<cfif isdefined('session.fitpartner') and session.fitpartner neq ''>
						<cfoutput><h1>#session.fitpartner# logged in</h1></cfoutput>
						<input type="hidden" name="client_id" value="#session.fitpartner#">	
						</cfif>
						<!--- <cfif Evaluate("application.pgrecap.pg#page#") eq 1> --->
							<input type="hidden" name="continue" value="2">
						<!--- </cfif> --->
					</cfif>
				</cfif>
			</cfform>
			<br>
		</cfoutput>
	</cf_buildHTML>
    <!--- 5384: be_res_bank_acc_xnd --->