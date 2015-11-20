<!---
Template Name: questions.cfm 
Component Purpose: question page template for low income subsidy application
Data Tables: calls custom tags 
--->
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

	
	<cfform action="questions.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
	
	<cf_buildQuestionList page="#page#" edit="#edit#" continue="#continue#" errorlist="#badResponseList#">
	
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
		<!--- moneil 2/11/2011 - Bug 5976 - LIS App - Issues with wages & earnings page answerfields --->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/0.5/jquery.min.js"></script>
	<script>
	$(document).ready(function(){
		$('#tr_be_clnt_oth_incm_amt').hide();
		$('#tr_be_clnt_oth_incm_typ').hide();
		$('#tr_be_clnt_earn_amt').hide();
		$('#tr_be_clnt_stop_wrk_month').hide();
		$('#tr_be_noncl_oth_incm_amt').hide();
		$('#tr_be_noncl_earn_amt').hide();
		$('#tr_be_noncl_stop_wrk_month').hide();
		$("#tr_be_noncl_oth_incm_typ").hide();
		
		//show boxes if textboxes contain a value
		if($('#be_clnt_earn_wgs_amt').val() != '') {
            $('#tr_be_clnt_earn_wgs_amt').show();
        }
		
		if($('#be_noncl_earn_wgs_amt').val() != '') {
            $('#tr_be_noncl_earn_wgs_amt').show();
        }
		
		if($('#be_noncl_earn_wgs_amt').val() != '') {
            $('#tr_be_noncl_earn_wgs_amt').show();
        }
		
		if($('#be_clnt_earn_amt').val() != '') {
            $('#tr_be_clnt_earn_amt').show();
        }
		
		if($('#be_noncl_earn_amt').val() != '') {
            $('#tr_be_noncl_earn_amt').show();
        }
		if($('#radio_yes_be_clnt_stop_wrk_xnd').is(':checked') == true) {
            $('#tr_be_clnt_stop_wrk_month').show();
        }
		if($('#radio_yes_be_noncl_stop_wrk_xnd').is(':checked') == true) {
            $('#tr_be_noncl_stop_wrk_month').show();
        }
		if($('#radio_yes_be_clnt_oth_incm_xnd').is(':checked') == true) {
            $('#tr_be_clnt_oth_incm_amt').show();
			$('#tr_be_clnt_oth_incm_typ').show();	
        }
		if($('#radio_yes_be_noncl_oth_incm_xnd').is(':checked') == true) {
            $('#tr_be_noncl_oth_incm_amt').show();
			$('#tr_be_noncl_oth_incm_typ').show();	
        }
		
		$('#radio_0_be_clnt_earn_loss_xnd').click(function() {
		  $('#tr_be_clnt_earn_amt').hide();
		});
		$('#radio_1_be_clnt_earn_loss_xnd').click(function() {
		  $('#tr_be_clnt_earn_amt').show();
		});
		$('#radio_2_be_clnt_earn_loss_xnd').click(function() {
		  $('#tr_be_clnt_earn_amt').hide();
		});
		
		
		$('#radio_0_be_noncl_earn_loss_xnd').click(function() {
		  $('#tr_be_noncl_earn_amt').hide();
		});
		$('#radio_1_be_noncl_earn_loss_xnd').click(function() {
		  $('#tr_be_noncl_earn_amt').show();
		});
		$('#radio_2_be_noncl_earn_loss_xnd').click(function() {
		  $('#tr_be_noncl_earn_amt').hide();
		});
	});
	</script>
	</cf_buildHTML>
<cfelse>
	<cf_sessionLoadVars>
	<cf_buildHTML cellpadding="12" cellspacing="2">
	<div align="center"><cf_displayText code="site_turboapp_not_available" group="site"></div>
	</cf_buildHTML>
</cfif>
