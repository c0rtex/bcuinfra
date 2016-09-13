<cfparam name="page" type="numeric" default="0">
<cfparam name="edit" type="numeric" default="0">
<cfparam name="continue" type="numeric" default="0">
<cfparam name="badResponseList" type="string" default="">

<cfif application.enableLIS>
	<cfif page eq 0>
		<cf_sessionLoadVars>
		<cf_handleScreening initvarname="accumAFList">
		<cfset page = 1>
	<cfelseif continue eq 0 or continue eq 2>
		<cf_logScreeningInput initvarname="accumAFList" useOptionCodes="true">
	<cfelse>
		<cfset accumAFList = ''>
	</cfif>
	<cf_buildHTML cellpadding="12" cellspacing="2" allowBack="true">
	<cfoutput>
	
	<cfform action="testapp_questions.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
	
	<cf_buildQuestionListESI page="#page#" edit="#edit#" continue="#continue#" errorlist="#badResponseList#">
	
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
				<input type="submit" value="Next">
			</cfif>
				<input type="hidden" name="page" value="#page#">
				<cfif Evaluate("application.pgrecap.pg#page#") eq 1>
					<input type="hidden" name="continue" value="2">
				</cfif>
		</cfif>
	</cfif>
	
	</cfform>
	
	<br>

	</cfoutput>
	<script>
	 $(document).ready(function() {
	   //hide questions first
			// Own home
			//$('#ùtr_esi_estimatedvalue').hide();
			$('#tr_esi_totaldebthouse').prev().hide();
			$('#tr_esi_totaldebthouse').hide();
			$('#tr_esi_housingsituation').hide();
			$('#tr_esi_homeinsurance').hide();
			// Rent
			$('#tr_esi_rent').hide();
	 });



	$("#select_esi_housingtype").change(function(){
		if(this.value == '2488-esi_housingtype_rent')
			{
				//show rent questions and hide homeowner questions
				$('#tr_esi_rent').show();
				//$('#ùtr_esi_estimatedvalue').hide();
				$('#tr_esi_totaldebthouse').prev().hide();
				$('#tr_esi_totaldebthouse').hide();
				$('#tr_esi_housingsituation').hide();
				$('#tr_esi_homeinsurance').hide();
			}
		else if(this.value == '2487-esi_housingtype_own')
			{
				//hide rent questions and show homeowner questions
				$('#tr_esi_rent').hide();
				//$('#ùtr_esi_estimatedvalue').show();
				$('#tr_esi_totaldebthouse').prev().show();
				$('#tr_esi_totaldebthouse').show();
				$('#tr_esi_housingsituation').show();
				$('#tr_esi_homeinsurance').show();
			}
		else 
			{
				//hide rent questions and hide homeowner questions
				$('#tr_esi_rent').hide();
				$('#ùtr_esi_estimatedvalue').hide();
				$('#tr_esi_totaldebthouse').hide();
				$('#tr_esi_housingsituation').hide();
				$('#tr_esi_homeinsurance').hide();
			}
	});
</script>
	</cf_buildHTML>
<cfelse>
	<cf_sessionLoadVars>
	<cf_buildHTML cellpadding="12" cellspacing="2">
	<div align="center"><cf_displayText code="site_turboapp_not_available" group="site"></div>
	</cf_buildHTML>
</cfif>