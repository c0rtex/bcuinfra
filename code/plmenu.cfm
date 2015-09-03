<cfparam name="attributes.popupwarning" default="0">

<cfif attributes.popupwarning IS 0>

	<cfif wrapper.wrapper_bcu_text_logo IS 1>
		<h1 class="wrapper_bcu_text_logo">BenefitsCheckUp</h1>
	</cfif>
			

	<cfoutput>
	<ul id="<cfif wrapper.wrapper_left_col_ad IS 1>globalnav2<cfelse>globalnav</cfif>">
		<li<cfif attributes.guts IS "index_pl.cfm" OR attributes.guts IS "index_walmart.cfm" OR attributes.guts IS "index_samsclub.cfm"> id="on"</cfif>><cf_sessionPassVars href="index.cfm?partner_id=#SESSION.partner_id#" extralist="gohome=true" prev_id="0">Home</cf_sessionPassVars></li>
		<cfif session.partner_id IS 77>
        	<li<cfif attributes.guts IS "esi_start.html" OR CGI.SCRIPT_NAME IS "/esi_start.html"> id="on"</cfif>>
            	<cf_sessionPassVars href="esi_start.cfm?partner_id=#SESSION.partner_id#" partner_id="#session.partner_id#" prev_id="0">
                	<cf_displayText group="site" code="site_esi_homepage_title">
                </cf_sessionPassVars>
        </cfif>
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
		OR attributes.guts IS "moreprograms_walmart_cf.cfm"
		OR attributes.guts IS "moreprograms_samsclub_cf.cfm"
		OR cgi.script_name IS "/cf/frmOptionalQuestions.cfm"
		OR attributes.guts IS "full.cfm"> id="on"</cfif>><cf_sessionPassVars href="moreprograms.cfm?partner_id=#SESSION.partner_id#" prev_id="0">
        	<cfif session.partner_id IS 77><cf_displayText group="site" code="site_fit_tab_bcu"><cfelse>Find Benefits</cfif>
        </cf_sessionPassVars></li>

		<cfif wrapper.wrapper_lis_link_direct IS 1>
			<cfif SESSION.partner_id NEQ 89 AND SESSION.partner_id NEQ 90>
				<li class="extra_help"<cfif attributes.guts IS "extrahelp_pl.cfm" OR attributes.guts IS "extrahelp_pl.cfm"> id="on"</cfif>><cf_sessionPassVars href="lisapp/index.cfm?partner_id=#SESSION.partner_id#" partner_id="#session.partner_id#"
org_id="#session.org_id#" user_id="#session.user_id#"
test_id="#session.test_id#" extralist="skipintro=true" prev_id="0">Apply for Extra Help</cf_sessionPassVars></li>
			</cfif>
		
		<cfelse>
			<cfif SESSION.partner_id NEQ 89 AND SESSION.partner_id NEQ 90>
				<li class="extra_help"<cfif attributes.guts IS "extrahelp_pl.cfm" OR attributes.guts IS "extrahelp_pl.cfm"> id="on"</cfif>><cf_sessionPassVars href="extrahelp.cfm?partner_id=#SESSION.partner_id#" prev_id="0">Apply for Extra Help</cf_sessionPassVars></li>
			</cfif>
		</cfif>		
		
		<cfif wrapper.wrapper_afc_popup IS 1> 
			<li<cfif attributes.guts IS "apply_cf.cfm" OR attributes.guts IS "apply_pl.cfm"> id="on"</cfif>><cf_sessionPassVars href="apply.cfm?partner_id=#SESSION.partner_id#" target="_top" prev_id="0">Find Applications</cf_sessionPassVars></li>
		<cfelse>
			<li<cfif attributes.guts IS "apply_cf.cfm" OR attributes.guts IS "apply_pl.cfm"> id="on"</cfif>><cf_sessionPassVars href="apply.cfm?partner_id=#SESSION.partner_id#" prev_id="0">Find Applications</cf_sessionPassVars></li>
		</cfif>
		
		<cfif session.partner_id IS 58>
			<li<cfif attributes.guts IS "grantees_cf.cfm"> id="on"</cfif>><cf_sessionPassVars href="grantees.cfm?partner_id=58" prev_id="0"><cf_displayText code="site_nc_grantees_tab" group="site"></cf_sessionPassVars></li>
		</cfif>
		
		<cfif SESSION.partner_id EQ 89>
			<li<cfif 
		attributes.guts IS "snap_cf.cfm" 
		OR attributes.guts IS "snap_state_cf.cfm" OR session.subset_id IS 3 AND (
		cgi.script_name IS "pdb.cfm" 
		OR cgi.script_name IS "/before_you_start.cfm" 
		OR cgi.script_name IS "/frmwelcome2.cfm" 
		OR cgi.script_name IS "/frmquestions.cfm" 
		OR cgi.script_name IS "/frmquestionssec.cfm" 
		OR cgi.script_name IS "/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/frmskipgrid.cfm" 
		OR cgi.script_name IS "/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/frmRecommend.cfm" 	
		OR cgi.script_name IS "/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/frmDrugList.cfm" 			
		OR cgi.script_name IS "/frmeligibility.cfm" 
		OR cgi.script_name IS "/frmDetails.cfm" 
		OR cgi.script_name IS "/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/redirect.cfm" 	
		OR cgi.script_name IS "/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/printed.cfm" 
		OR cgi.script_name IS "/full.cfm"
		OR cgi.script_name IS "/extrahelp.cfm" 
		OR cgi.script_name IS "/apply.cfm")> id="on"</cfif>>
		<cf_sessionPassVars href="snap.cfm?partner_id=#SESSION.partner_id#" prev_id="0"><cf_displayText group="site" code="site_aarp_tab_food_benefits"></cf_sessionPassVars></li>
		</cfif>
		
		<cfif SESSION.partner_id EQ 90>
			<li<cfif 
		attributes.guts IS "snap_cf.cfm" 
		OR attributes.guts IS "snap_state_cf.cfm" OR session.subset_id IS 3 AND (
		cgi.script_name IS "pdb.cfm" 
		OR cgi.script_name IS "/before_you_start.cfm" 
		OR cgi.script_name IS "/frmwelcome2.cfm" 
		OR cgi.script_name IS "/frmquestions.cfm" 
		OR cgi.script_name IS "/frmquestionssec.cfm" 
		OR cgi.script_name IS "/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/frmskipgrid.cfm" 
		OR cgi.script_name IS "/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/frmRecommend.cfm" 	
		OR cgi.script_name IS "/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/frmDrugList.cfm" 			
		OR cgi.script_name IS "/frmeligibility.cfm" 
		OR cgi.script_name IS "/frmDetails.cfm" 
		OR cgi.script_name IS "/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/redirect.cfm" 	
		OR cgi.script_name IS "/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/printed.cfm" 
		OR cgi.script_name IS "/full.cfm"
		OR cgi.script_name IS "/extrahelp.cfm" 
		OR cgi.script_name IS "/apply.cfm")> id="on"</cfif>>
		<cf_sessionPassVars href="snap.cfm?partner_id=#SESSION.partner_id#" prev_id="0"><cf_displayText group="site" code="site_aarp_tab_food_benefits"></cf_sessionPassVars></li>
		</cfif>
		
		
		
	</ul>
	
	</cfoutput>
	
<cfelse>

	<cfif wrapper.wrapper_bcu_text_logo IS 1>
		<h1 class="wrapper_bcu_text_logo">BenefitsCheckUp</h1>
	</cfif>

	<cf_displayText group="site" code="site_results_click_warning" var="clickText">
	<cfoutput>
	<ul id="<cfif wrapper.wrapper_left_col_ad IS 1>globalnav2<cfelse>globalnav</cfif>">
		
		<li<cfif attributes.guts IS "index_pl.cfm" OR attributes.guts IS "index_walmart.cfm"> id="on"</cfif>><cf_sessionPassVars href="index.cfm?partner_id=#SESSION.partner_id#" prev_id="0" extralist="gohome=true" confirm="#clickText#">Home</cf_sessionPassVars></li>
		<cfif session.partner_id IS 77>
        	<li<cfif attributes.guts IS "esi_start.cfm" OR CGI.SCRIPT_NAME IS "/esi_start.cfm"> id="on"</cfif>>
            	<cf_sessionPassVars href="esi_start.cfm?partner_id=#SESSION.partner_id#" partner_id="#session.partner_id#" prev_id="0">
                	<cf_displayText group="site" code="site_esi_homepage_title">
                </cf_sessionPassVars>
        </cfif>
		<li<cfif 
		attributes.guts IS "frmeligibility.cfm" 
		OR attributes.guts IS "frmDetails.cfm" 
		OR attributes.guts IS "frmRecommend.cfm"
		OR attributes.guts IS "frmOptionalQuestions.cfm"
		OR attributes.guts IS "frmHowBCUWorks.cfm"> id="on"</cfif>><cf_sessionPassVars href="moreprograms.cfm" prev_id="0" confirm="#clickText#"><cfif session.partner_id IS 77><cf_displayText group="site" code="site_fit_tab_bcu"><cfelse>Find Benefits</cfif></cf_sessionPassVars></li>
		
		<cfif wrapper.wrapper_lis_link_direct IS 1>
			<cfif SESSION.partner_id NEQ 89 AND SESSION.partner_id NEQ 90>
				<li<cfif attributes.guts IS "extrahelp_pl.cfm?partner_id=#SESSION.partner_id#" OR attributes.guts IS "extrahelp_pl.cfm"> id="on"</cfif>><cf_sessionPassVars href="lisapp/index.cfm" partner_id="#session.partner_id#"
org_id="#session.org_id#" user_id="#session.user_id#"
test_id="#session.test_id#" extralist="skipintro=true" prev_id="0" confirm="#clickText#">Apply for Extra Help</cf_sessionPassVars></li>
			</cfif>
		
		<cfelse>
			<cfif SESSION.partner_id NEQ 89 AND SESSION.partner_id NEQ 90>
				<li<cfif attributes.guts IS "extrahelp_pl.cfm" OR attributes.guts IS "extrahelp_pl.cfm"> id="on"</cfif>><cf_sessionPassVars href="extrahelp.cfm?partner_id=#SESSION.partner_id#" prev_id="0" confirm="#clickText#">Apply for Extra Help</cf_sessionPassVars></li>
			</cfif>
		</cfif>
		
		
		<li<cfif attributes.guts IS "apply_pl.cfm" OR attributes.guts IS "apply_pl.cfm"> id="on"</cfif>><cf_sessionPassVars href="apply.cfm" prev_id="0" confirm="#clickText#">Find Applications</cf_sessionPassVars></li>
		
		<cfif session.partner_id IS 58>
			<li<cfif attributes.guts IS "grantees_cf.cfm"> id="on"</cfif>><cf_sessionPassVars href="grantees.cfm?partner_id=58" prev_id="0"><cf_displayText code="site_nc_grantees_tab" group="site"></cf_sessionPassVars></li>
		</cfif>
		
			<cfif SESSION.partner_id EQ 89>
			<li<cfif 
		attributes.guts IS "snap_cf.cfm" 
		OR attributes.guts IS "snap_state_cf.cfm" OR session.subset_id IS 3 AND (
		cgi.script_name IS "pdb.cfm" 
		OR cgi.script_name IS "/before_you_start.cfm" 
		OR cgi.script_name IS "/frmwelcome2.cfm" 
		OR cgi.script_name IS "/frmquestions.cfm" 
		OR cgi.script_name IS "/frmquestionssec.cfm" 
		OR cgi.script_name IS "/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/frmskipgrid.cfm" 
		OR cgi.script_name IS "/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/frmRecommend.cfm" 	
		OR cgi.script_name IS "/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/frmDrugList.cfm" 			
		OR cgi.script_name IS "/frmeligibility.cfm" 
		OR cgi.script_name IS "/frmDetails.cfm" 
		OR cgi.script_name IS "/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/redirect.cfm" 	
		OR cgi.script_name IS "/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/printed.cfm" 
		OR cgi.script_name IS "/full.cfm"
		OR cgi.script_name IS "/extrahelp.cfm" 
		OR cgi.script_name IS "/apply.cfm")> id="on"</cfif>>
		<cf_sessionPassVars href="snap.cfm?partner_id=#SESSION.partner_id#" prev_id="0" confirm="#clickText#"><cf_displayText group="site" code="site_aarp_tab_food_benefits"></cf_sessionPassVars></li>
		</cfif>
		
		<cfif SESSION.partner_id EQ 90>
			<li<cfif 
		attributes.guts IS "snap_cf.cfm" 
		OR attributes.guts IS "snap_state_cf.cfm" OR session.subset_id IS 3 AND (
		cgi.script_name IS "pdb.cfm" 
		OR cgi.script_name IS "/before_you_start.cfm" 
		OR cgi.script_name IS "/frmwelcome2.cfm" 
		OR cgi.script_name IS "/frmquestions.cfm" 
		OR cgi.script_name IS "/frmquestionssec.cfm" 
		OR cgi.script_name IS "/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/frmskipgrid.cfm" 
		OR cgi.script_name IS "/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/frmRecommend.cfm" 	
		OR cgi.script_name IS "/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/frmDrugList.cfm" 			
		OR cgi.script_name IS "/frmeligibility.cfm" 
		OR cgi.script_name IS "/frmDetails.cfm" 
		OR cgi.script_name IS "/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/redirect.cfm" 	
		OR cgi.script_name IS "/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/printed.cfm" 
		OR cgi.script_name IS "/full.cfm"
		OR cgi.script_name IS "/extrahelp.cfm" 
		OR cgi.script_name IS "/apply.cfm")> id="on"</cfif>>
		<cf_sessionPassVars href="snap.cfm?partner_id=#SESSION.partner_id#" prev_id="0" confirm="#clickText#"><cf_displayText group="site" code="site_aarp_tab_food_benefits"></cf_sessionPassVars></li>
		</cfif>
		
	</ul>
	</cfoutput>

</cfif>