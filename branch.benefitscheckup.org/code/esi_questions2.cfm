<cfparam name="page" type="numeric" default="0">
<cfparam name="edit" type="numeric" default="0">
<cfparam name="continue" type="numeric" default="0">
<cfparam name="badResponseList" type="string" default="">
<cfparam name="session.screening.recap" default="0">
<cfparam name="url.repop" default="false">
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
		<div id="radio_yes_esi_estimatedvalue" style="display:none"></div>
	
		<cfoutput>
			<h1>EconomicCheckUp</h1>
            <div class="row survey">
                <div class="question">
                    <div class="questionHolder questionBar">
                        <div id="pageTip" class="helpTip">
                            <h2><cf_displayText group="site" code="site_questionnaire_instructions_title"></h2>
                            <p><cf_displayText group="site" code="site_questionnaire_instructions_body"></p>
                        </div><!-- pageTip -->
                    </div><!-- questionHolder -->
                </div><!-- question -->	
                <cfform id="esiForm" name="esiForm" action="esi_questions2.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
                    <!--- start building question --->
                    <cf_buildQuestionListESI2 page="#page#" edit="#edit#" continue="#continue#" errorlist="#badResponseList#">
                    <!--- end building questions --->
                    
                    <cfif accumAFList neq ''>
                        <cfloop list = "o-esi_ethnicity,o-esi_mobility,o-esi_meals,o-esi_housingtype,o-esi_housingsituation" index="var">
                        <cfset valuecount = ListValueCount(accumAFList, var)>
                        <cfif valuecount gt 1>
                            <cfset pos = ListContainsNoCase(accumAFList,var)>
                            <cfset accumAFList= ListDeleteAt(accumAFList, pos)>
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
	 	
		<cfif isdefined('SESSION.esi_housingtype') and esi_housingtype eq 'esi_housingtype_own'>
			//hide rent questions and show homeowner questions
			$('#tr_esi_rent').hide();
			//$('#tr_esi_estimatedvalue').show();
			$('#tr_esi_totaldebthouse').prev().show();
			$('#tr_esi_totaldebthouse').show();
			$('#tr_esi_housingsituation').show();
			$('#tr_esi_homeinsurance').show();
		<cfelseif isdefined('SESSION.esi_housingtype') and session.esi_housingtype eq 'esi_housingtype_rent'>
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