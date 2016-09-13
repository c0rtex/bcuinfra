<cfparam name="attributes.popupwarning" default="0">

<cfif attributes.popupwarning IS 0>

	<cfif wrapper.wrapper_bcu_text_logo IS 1>
		<h1 class="wrapper_bcu_text_logo">BenefitsCheckUp</h1>
	</cfif>
			

	<cfoutput>
	<ul id="<cfif wrapper.wrapper_left_col_ad IS 1>globalnav2<cfelse>globalnav</cfif>">
		<li<cfif attributes.guts IS "index_fit.cfm"> id="on"</cfif>><cf_sessionPassVars href="index.cfm?partner_id=#SESSION.partner_id#" extralist="gohome=true" prev_id="0">Home</cf_sessionPassVars></li>
		<li<cfif CGI.SCRIPT_NAME IS "/cf/fit_start.cfm" OR CGI.SCRIPT_NAME IS "/cf/fit_questions.cfm" OR CGI.SCRIPT_NAME IS "/cf/fit_actionplan.cfm"> id="on"</cfif>><cf_sessionPassVars href="fitapp/index.cfm" prev_id="0"><cf_displayText code="site_fit_tab_fit" group="site"></cf_sessionPassVars></li>
        <li<cfif 
		attributes.guts IS "moreprograms_pl_cf.cfm" 
		OR attributes.guts IS "moreprograms_pl_cf.cfm" 
		OR attributes.guts IS "frmwelcome2.cfm" 
		OR attributes.guts IS "frmquestions.cfm" 
		OR attributes.guts IS "frmquestionssec.cfm" 
		OR attributes.guts IS "frmquestionssecdep.cfm" 	
		OR attributes.guts IS "frmskipgrid.cfm" 
		OR attributes.guts IS "frmquestionsthird.cfm" 
		OR attributes.guts IS "frmRecommend.cfm" 	
		OR attributes.guts IS "frmincomegrid.cfm" 	
		OR attributes.guts IS "frmassetgrid.cfm" 		
		OR attributes.guts IS "frmDrugList.cfm" 			
		OR attributes.guts IS "frmeligibility.cfm" 
		OR attributes.guts IS "frmDetails.cfm" 
		OR attributes.guts IS "redirect.cfm" 	
		OR attributes.guts IS "genericdruginfo.cfm" 	
		OR attributes.guts IS "printed_cf.cfm" 
		OR attributes.guts IS "full.cfm"
		OR attributes.guts IS "fullprint.cfm"
		OR attributes.guts is "frmreportview.cfm" OR cgi.script_name is "/frmreportview.cfm"> id="on"</cfif>><cf_sessionPassVars href="moreprograms.cfm" prev_id="0"><cf_displayText code="site_fit_tab_bcu" group="site"></cf_sessionPassVars></li>
		<li<cfif CGI.SCRIPT_NAME IS "/cf/extrahelp.cfm" OR CGI.SCRIPT_NAME IS "/cf/fit_taxrelief.cfm" OR CGI.SCRIPT_NAME IS "/cf/taxRelief.cfm"  OR CGI.SCRIPT_NAME IS "/cf/apply.cfm"> id="on"</cfif>><cf_sessionPassVars href="fit_taxrelief.cfm?partner_id=76" prev_id="0" partner_id="76"><cf_displayText code="site_fit_tab_tax_insurance" group="site"></cf_sessionPassVars></li>
		<li style="width:150px;"<cfif CGI.SCRIPT_NAME IS "/cf/fit_resources.cfm"> id="on"</cfif>><cf_sessionPassVars href="fit_resources.cfm?subset_id=61&partner_id=76" subset_id="61" partner_id="76" prev_id="0"><cf_displayText code="site_fit_tab_resources" group="site"></cf_sessionPassVars></li>
			
	</ul>
	
	</cfoutput>
	
<cfelse>
	<cfif wrapper.wrapper_bcu_text_logo IS 1>
		<h1 class="wrapper_bcu_text_logo">BenefitsCheckUp</h1>
	</cfif>

	<cf_displayText group="site" code="site_results_click_warning" var="clickText">
	<cfoutput>
	<ul id="<cfif wrapper.wrapper_left_col_ad IS 1>globalnav2<cfelse>globalnav</cfif>">
		<li<cfif attributes.guts IS "index_fit.cfm"> id="on"</cfif>>
        	<cf_sessionPassVars href="index.cfm" prev_id="0" extralist="gohome=true" confirm="#clickText#">Home</cf_sessionPassVars>
        </li>
		<li<cfif CGI.SCRIPT_NAME IS "/fit_start.cfm" OR CGI.SCRIPT_NAME IS "/fit_questions.cfm" OR CGI.SCRIPT_NAME IS "/fit_actionplan.cfm"> id="on"</cfif>><cf_sessionPassVars href="fitapp/index.cfm" prev_id="0" confirm="#clickText#"><cf_displayText code="site_fit_tab_fit" group="site"></cf_sessionPassVars></li>
		<li<cfif 
		attributes.guts IS "frmeligibility.cfm" 
		OR attributes.guts IS "frmDetails.cfm" 
		OR attributes.guts IS "frmRecommend.cfm"
		OR attributes.guts IS "frmHowBCUWorks.cfm"> id="on"</cfif>><cf_sessionPassVars href="moreprograms.cfm" prev_id="0" confirm="#clickText#"><cf_displayText code="site_fit_tab_bcu" group="site"></cf_sessionPassVars></li>
		<li<cfif CGI.SCRIPT_NAME IS "/cf/extrahelp.cfm" OR CGI.SCRIPT_NAME IS "/cf/fit_taxrelief.cfm" OR CGI.SCRIPT_NAME IS "/cf/taxRelief.cfm"  OR CGI.SCRIPT_NAME IS "/cf/apply.cfm"> id="on"</cfif>><cf_sessionPassVars href="fit_taxrelief.cfm?partner_id=76" prev_id="0" partner_id="76" confirm="#clickText#"><cf_displayText code="site_fit_tab_tax_insurance" group="site"></cf_sessionPassVars></li>
		<li<cfif CGI.SCRIPT_NAME IS "/fit_resources.cfm"> id="on"</cfif>><cf_sessionPassVars href="fit_resources.cfm" prev_id="0" confirm="#clickText#"><cf_displayText code="site_fit_tab_resources" group="site"></cf_sessionPassVars></li>		
		</ul>
	</cfoutput>

</cfif>