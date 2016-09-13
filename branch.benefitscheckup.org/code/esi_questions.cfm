<cfparam name="page" type="numeric" default="0">
<cfparam name="edit" type="numeric" default="0">
<cfparam name="continue" type="numeric" default="0">
<cfparam name="badResponseList" type="string" default="">
<cfparam name="session.screening.recap" default="0">
<cfparam name="url.repop" default="false">
<cfset session.reloadpage = "false">
<cfif IsDefined("url.org_id")><cfset session.org_id = #url.org_id#></cfif>
<cfif IsDefined("url.partner_id")><cfset session.partner_id = #url.partner_id#></cfif>
<cfif IsDefined("url.subset_id")><cfset session.subset_id = #url.subset_id#></cfif>
<cfif IsDefined("url.language_id")><cfset session.language_id = #url.language_id#></cfif>
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
	<cf_buildHTML allowBack="true">
	
		<style>
			#pageTip{ top:0px !important;}
			
			.q-text-center {
				page-break-inside: avoid;
				text-align:center;
				vertical-align:top;
			}
			.question { 0 200px 0 0;}
		</style>
		<div id="radio_yes_esi_housingtype" style="display:none"></div>
		<div id="radio_no_esi_housingtype" style="display:none"></div>
		<!---div id="radio_yes_esi_estimatedvalue" style="display:none"></div--->
	
		<cfoutput>
			<h1>EconomicCheckUp</h1><span style="float:right; margin-top:-25px;"><a style="font-size:16px;" href="ESI_printable_version.pdf" target="_blank">Get Printable EconomicCheckUp</a></span>
            <div class="row survey">
                <div class="question">
                    <div class="questionHolder questionBar">
                        <div id="pageTip" class="helpTip">
                            <h2><cf_displayText group="site" code="site_questionnaire_instructions_title"></h2>
                            <p><cf_displayText group="site" code="site_questionnaire_instructions_body"></p>
                        </div><!-- pageTip -->
                    </div><!-- questionHolder -->
                </div><!-- question -->	
                <cfform id="esiForm" name="esiForm" action="esi_questions.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
                    <!--- start building question --->
                    <cf_buildQuestionList page="#page#" edit="#edit#" continue="#continue#" errorlist="#badResponseList#">
                    <!--- end building questions --->
                    
                    <cfif accumAFList neq ''>
                        <cfloop list = "o-esi_ethnicity,o-esi_mobility,o-esi_meals,o-esi_housingtype,o-esi_housingsituation" index="var">
                        <cfset valuecount = ListValueCount(accumAFList, var)>
                        <cfif valuecount gt 1>
                            <cfset pos = ListContainsNoCase(accumAFList,var)>
                            <cfset accumAFList= ListDeleteAt(accumAFList, pos)>
                        </cfif>
                        </cfloop>
			   <cfloop list = "i-s_income_pri_retire,i-sp_income_pri_retire,i-s_sp_income_pri_retire_simple,i-hh_income_pri_retire_simple,i-s_income_dividends,i-sp_income_dividends,i-s_sp_income_dividends_simple,i-hh_income_dividends_simple,i-s_income_ssi,i-sp_income_ssi,i-s_sp_income_ssi_simple,i-hh_income_ssi_simple,i-s_income_ss_disable,i-sp_income_ss_disable,i-s_sp_income_ss_disable_simple,i-hh_income_ss_disable_simple,i-s_income_ss_retire,i-sp_income_ss_retire,i-s_sp_income_ss_retire_simple,i-hh_income_ss_retire_simple,i-s_income_rr_ben,i-sp_income_rr_ben,i-s_sp_income_rr_ben_simple,i-hh_income_rr_ben_simple,i-s_income_vet_ben,i-sp_income_vet_ben,i-s_sp_income_vet_ben_simple,i-hh_income_vet_ben_simple,i-s_income_unemploy,i-sp_income_unemploy,i-s_sp_income_unemploy_simple,i-hh_income_unemploy_simple,i-s_income_tanf,i-sp_income_tanf,i-s_sp_income_tanf_simple,i-hh_income_tanf_simple,i-s_income_cash_assist,i-sp_income_cash_assist,i-s_sp_income_cash_assist_simple,i-hh_income_cash_assist_simple,i-s_income_other_nw,i-sp_income_other_nw,i-s_sp_income_other_nw_simple,i-hh_income_other_nw_simple,i-s_income_earned,i-sp_income_earned,i-s_sp_income_earned_simple,i-hh_income_earned_simple,a-s_asset_cash,a-sp_asset_cash,a-s_sp_asset_cash_simple,a-hh_asset_cash_simple,a-s_asset_auto1,a-sp_asset_auto1,a-s_sp_asset_auto1_simple,a-hh_asset_auto1_simple,a-s_asset_auto2,a-sp_asset_auto2,a-s_sp_asset_auto2_simple,a-hh_asset_auto2_simple,a-s_asset_home,a-sp_asset_home,a-s_sp_asset_home_simple,a-hh_asset_home_simple,a-s_asset_retirement,a-sp_asset_retirement,a-s_sp_asset_retirement_simple,a-hh_asset_retirement_simple,a-s_asset_stocks,a-sp_asset_stocks,a-s_sp_asset_stocks_simple,a-hh_asset_stocks_simple,a-s_asset_life_cash,a-sp_asset_life_cash,a-s_sp_asset_life_cash_simple,a-hh_asset_life_cash_simple,a-s_asset_life_face,a-sp_asset_life_face,a-s_sp_asset_life_face_simple,a-hh_asset_life_face_simple,a-s_asset_revocable,a-sp_asset_revocable,a-s_sp_asset_revocable_simple,a-hh_asset_revocable_simple,a-s_asset_irrevocable,a-sp_asset_irrevocable,a-s_sp_asset_irrevocable_simple,a-hh_asset_irrevocable_simple,a-s_asset_other_a,a-sp_asset_other_a,a-s_sp_asset_other_a_simple,a-hh_asset_other_a_simple" index="field">
			     <cfset valuecount = ListValueCount(accumAFList, field)>
                        <cfif valuecount eq 0>
                            <cfset accumAFList= ListAppend(accumAFList,field)>
                        </cfif>
                        </cfloop>
                        <cf_passScreeningInput varname="accumAFList">
                        <cfif edit>
                            <input type="submit" value="Submit Changes">
                            <input type="hidden" name="page" value="#page#">
                            <input type="hidden" name="edit" value="2">
                        <cfelse>
                            <cfif session.screening.recap gt 0>
                                
                                <input type="button" value="Submit Your Application" onClick="this.disabled = true; this.value= 'Please wait a few moments...'; this.form.submit();">
                            <cfelse>
                            <tr >
                            <td colspan="5" align=right><input id="view_results" type="submit" value="View Results" style="float:right; width:150px;"></td>
                            </tr>							
                            </cfif>
                            <input type="hidden" name="page" value="#page#">
                            
                            <!--- <cfif Evaluate("application.pgrecap.pg#page#") eq 1> --->
                                <input type="hidden" name="continue" value="2">
                            <!--- </cfif> --->
                        </cfif>
                    </cfif>
                </cfform>
				<br>
           	</div><!--- end div row survey --->
		</cfoutput>
	<script>
	 $(document).ready(function() {
	 	
		<cfif (isdefined('SESSION.esi_housingtype') and esi_housingtype eq 'esi_housingtype_own') OR (isdefined('URL.ht') and URL.ht eq 'esi_housingtype_own')>
			//hide rent questions and show homeowner questions
			$('#tr_esi_rent').hide();
			//$('#tr_esi_estimatedvalue').show();
			$('#tr_esi_totaldebthouse').prev().show();
			$('#tr_esi_totaldebthouse').show();
			$('#tr_esi_housingsituation').show();
			$('#tr_esi_homeinsurance').show();
		<cfelseif (isdefined('SESSION.esi_housingtype') and session.esi_housingtype eq 'esi_housingtype_rent') OR (isdefined('URL.ht') and URL.ht eq 'esi_housingtype_rent')>
			//show rent questions and hide homeowner questions
			$('#tr_esi_rent').show();
			//$('#tr_esi_estimatedvalue').hide();
			$('#tr_esi_totaldebthouse').prev().hide();
			$('#tr_esi_totaldebthouse').hide();
			$('#tr_esi_housingsituation').hide();
			$('#tr_esi_homeinsurance').hide();
		<cfelse>
		   //hide questions first
			// Own home
			//$('#tr_esi_estimatedvalue').hide();
			$('#tr_esi_totaldebthouse').prev().hide();
			$('#tr_esi_totaldebthouse').hide();
			$('#tr_esi_housingsituation').hide();
			$('#tr_esi_homeinsurance').hide();
			// Rent
			$('#tr_esi_rent').hide();	
		</cfif>

	 });



	$("#select_esi_housingtype").change(function(){
		if(this.value == '2488-esi_housingtype_rent')
			{
				//show rent questions and hide homeowner questions
				$('#tr_esi_rent').show();
				//$('#tr_esi_estimatedvalue').hide();
				$('#tr_esi_totaldebthouse').prev().hide();
				$('#tr_esi_totaldebthouse').hide();
				$('#tr_esi_housingsituation').hide();
				$('#tr_esi_homeinsurance').hide();
			}
		else if(this.value == '2487-esi_housingtype_own')
			{
				//hide rent questions and show homeowner questions
				$('#tr_esi_rent').hide();
				//$('#tr_esi_estimatedvalue').show();
				$('#tr_esi_totaldebthouse').prev().show();
				$('#tr_esi_totaldebthouse').show();
				$('#tr_esi_housingsituation').show();
				$('#tr_esi_homeinsurance').show();
			}
		else 
			{
				//hide rent questions and hide homeowner questions
				$('#tr_esi_rent').hide();
				$('#tr_esi_totaldebthouse').prev().hide();
				//$('#tr_esi_estimatedvalue').hide();
				$('#tr_esi_totaldebthouse').hide();
				$('#tr_esi_housingsituation').hide();
				$('#tr_esi_homeinsurance').hide();
			}
	});
</script>
	</cf_buildHTML>
    <!--- 5384: be_res_bank_acc_xnd --->