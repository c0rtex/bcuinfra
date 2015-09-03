<cfparam name="attributes.popupwarning" default="0">
<cfif attributes.guts IS '/cf/frmeligibility.cfm'>
	<cfset attributes.popupwarning = 1>
</cfif>

<cfif NOT IsDefined('session.user_id')>
	<cfset SESSION.user_id = 0>
</cfif>

<cfif NOT IsDefined('session.test_id')>
	<cfset SESSION.test_id = 0>
</cfif>

<cfif attributes.popupwarning IS 0>

	<cfif wrapper.wrapper_bcu_text_logo IS 1>
		<h1 class="wrapper_bcu_text_logo">BenefitsCheckUp</h1>
	</cfif>

	<cfoutput>
	<ul id="<cfif wrapper.wrapper_left_col_ad IS 1>globalnav2<cfelse>globalnav</cfif>">
		<li<cfif attributes.guts IS "index_aarp.cfm"> id="on"</cfif>><cf_sessionPassVars href="index.cfm" extralist="gohome=true" prev_id="0"><cf_displayText group="site" code="site_aarp_tab_home"></cf_sessionPassVars></li>
		<li<cfif (session.subset_id IS 49 AND (
		cgi.script_name IS "/cf/frmwelcome2.cfm" 
		OR cgi.script_name IS "/cf/frmquestions.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssec.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/cf/frmskipgrid.cfm" 
		OR cgi.script_name IS "/cf/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/cf/frmRecommend.cfm" 	
		OR cgi.script_name IS "/cf/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/cf/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/cf/frmDrugList.cfm" 			
		OR cgi.script_name IS "/cf/frmeligibility.cfm" 
		OR cgi.script_name IS "/cf/proceligibility.cfm"
		OR cgi.script_name IS "/cf/frmDetails.cfm" 
		OR cgi.script_name IS "/cf/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/cf/redirect.cfm" 	
		OR cgi.script_name IS "/cf/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/cf/printed.cfm" 
		OR cgi.script_name IS "/cf/full.cfm"))> id="on"</cfif>><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=22&subset_id=49" subset_id="49" partner_id="22" prev_id="0"><cf_displayText group="site" code="site_aarp_tab_qualify_benefits"></cf_sessionPassVars></li>
		
		<li<cfif 
		attributes.guts IS "snap_cf.cfm" 
		OR attributes.guts IS "snap_state_cf.cfm" OR (session.subset_id IS 62 AND (
		cgi.script_name IS "/cf/frmwelcome2.cfm" 
		OR cgi.script_name IS "/cf/frmquestions.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssec.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/cf/frmskipgrid.cfm" 
		OR cgi.script_name IS "/cf/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/cf/frmRecommend.cfm" 	
		OR cgi.script_name IS "/cf/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/cf/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/cf/frmDrugList.cfm" 			
		OR cgi.script_name IS "/cf/frmeligibility.cfm" 
		OR cgi.script_name IS "/cf/proceligibility.cfm" 
		OR cgi.script_name IS "/cf/frmDetails.cfm" 
		OR cgi.script_name IS "/cf/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/cf/redirect.cfm" 	
		OR cgi.script_name IS "/cf/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/cf/printed.cfm" 
		OR cgi.script_name IS "/cf/full.cfm"))> id="on"</cfif>><cf_sessionPassVars href="snap.cfm?partner_id=22" partner_id="22" subset_id="62" prev_id="0"><cf_displayText group="site" code="site_aarp_tab_food_benefits"></cf_sessionPassVars></li>		

		<li<cfif cgi.script_name IS "/cf/pdb.cfm" OR cgi.script_name IS "/cf/extrahelp.cfm" OR cgi.script_name IS "/cf/apply.cfm" OR ((SESSION.subset_id IS 0 OR SESSION.subset_id IS 19 OR SESSION.subset_id IS 41 OR SESSION.subset_id IS 27) AND (cgi.script_name IS "/cf/frmwelcome2.cfm" 
		OR cgi.script_name IS "/cf/frmquestions.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssec.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/cf/frmskipgrid.cfm" 
		OR cgi.script_name IS "/cf/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/cf/frmRecommend.cfm" 	
		OR cgi.script_name IS "/cf/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/cf/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/cf/frmDrugList.cfm" 			
		OR cgi.script_name IS "/cf/frmeligibility.cfm" 
		OR cgi.script_name IS "/cf/proceligibility.cfm" 
		OR cgi.script_name IS "/cf/frmDetails.cfm" 
		OR cgi.script_name IS "/cf/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/cf/redirect.cfm" 	
		OR cgi.script_name IS "/cf/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/cf/printed.cfm" 
		OR cgi.script_name IS "/cf/full.cfm"))> id="on"</cfif>><cf_sessionPassVars href="pdb.cfm?partner_id=22" partner_id="22" subset_id="0"
org_id="#session.org_id#" user_id="#session.user_id#" test_id="#session.test_id#" extralist="skipintro=true" prev_id="0"><cf_displayText group="site" code="site_aarp_tab_prescription_drug_benefits"></cf_sessionPassVars></li>
		
		<li<cfif session.subset_id IS 68 AND (
		cgi.script_name IS "/cf/frmwelcome2.cfm" 
		OR cgi.script_name IS "/cf/frmquestions.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssec.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/cf/frmskipgrid.cfm" 
		OR cgi.script_name IS "/cf/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/cf/frmRecommend.cfm" 	
		OR cgi.script_name IS "/cf/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/cf/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/cf/frmDrugList.cfm" 			
		OR cgi.script_name IS "/cf/frmeligibility.cfm" 
		OR cgi.script_name IS "/cf/proceligibility.cfm" 
		OR cgi.script_name IS "/cf/frmDetails.cfm" 
		OR cgi.script_name IS "/cf/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/cf/redirect.cfm" 	
		OR cgi.script_name IS "/cf/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/cf/printed.cfm" 
		OR cgi.script_name IS "/cf/full.cfm")> id="on"</cfif>><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=22&subset_id=68" subset_id="68" partner_id="22" prev_id="0"><cf_displayText group="site" code="site_aarp_tab_benefits_state"></cf_sessionPassVars></li>
		
	</ul>
	
	</cfoutput>
	
<cfelse>

	<cfif wrapper.wrapper_bcu_text_logo IS 1>
		<h1 class="wrapper_bcu_text_logo">BenefitsCheckUp</h1>
	</cfif>

	<cf_displayText group="site" code="site_results_click_warning" var="clickText">
	<cfoutput>
	<ul id="<cfif wrapper.wrapper_left_col_ad IS 1>globalnav2<cfelse>globalnav</cfif>">
		
		<li<cfif attributes.guts IS "index_aarp.cfm"> id="on"</cfif>><cf_sessionPassVars href="index.cfm" prev_id="0" extralist="gohome=true" confirm="#clickText#"><cf_displayText group="site" code="site_aarp_tab_home"></cf_sessionPassVars></li>
		
		<li<cfif (session.subset_id IS 49 AND (
		cgi.script_name IS "/cf/frmwelcome2.cfm" 
		OR cgi.script_name IS "/cf/frmquestions.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssec.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/cf/frmskipgrid.cfm" 
		OR cgi.script_name IS "/cf/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/cf/frmRecommend.cfm" 	
		OR cgi.script_name IS "/cf/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/cf/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/cf/frmDrugList.cfm" 			
		OR cgi.script_name IS "/cf/frmeligibility.cfm" 
		OR cgi.script_name IS "/cf/proceligibility.cfm"
		OR cgi.script_name IS "/cf/frmDetails.cfm" 
		OR cgi.script_name IS "/cf/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/cf/redirect.cfm" 	
		OR cgi.script_name IS "/cf/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/cf/printed.cfm" 
		OR cgi.script_name IS "/cf/full.cfm"))> id="on"</cfif>><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=22&subset_id=49" subset_id="49" partner_id="22" prev_id="0" confirm="#clickText#"><cf_displayText group="site" code="site_aarp_tab_qualify_benefits"></cf_sessionPassVars></li>
		
		<li<cfif 
		attributes.guts IS "snap_cf.cfm" 
		OR attributes.guts IS "snap_state_cf.cfm" OR (session.subset_id IS 62 AND (
		cgi.script_name IS "/cf/frmwelcome2.cfm" 
		OR cgi.script_name IS "/cf/frmquestions.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssec.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/cf/frmskipgrid.cfm" 
		OR cgi.script_name IS "/cf/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/cf/frmRecommend.cfm" 	
		OR cgi.script_name IS "/cf/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/cf/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/cf/frmDrugList.cfm" 			
		OR cgi.script_name IS "/cf/frmeligibility.cfm" 
		OR cgi.script_name IS "/cf/proceligibility.cfm" 
		OR cgi.script_name IS "/cf/frmDetails.cfm" 
		OR cgi.script_name IS "/cf/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/cf/redirect.cfm" 	
		OR cgi.script_name IS "/cf/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/cf/printed.cfm" 
		OR cgi.script_name IS "/cf/full.cfm"))> id="on"</cfif>><cf_sessionPassVars href="snap.cfm?partner_id=22" partner_id="22" subset_id="62" prev_id="0" confirm="#clickText#"><cf_displayText group="site" code="site_aarp_tab_food_benefits"></cf_sessionPassVars></li>		

		<li<cfif cgi.script_name IS "/cf/pdb.cfm" OR cgi.script_name IS "/cf/extrahelp.cfm" OR cgi.script_name IS "/cf/apply.cfm" OR ((SESSION.subset_id IS 0 OR SESSION.subset_id IS 19 OR SESSION.subset_id IS 41 OR SESSION.subset_id IS 27) AND (cgi.script_name IS "/cf/frmwelcome2.cfm" 
		OR cgi.script_name IS "/cf/frmquestions.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssec.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/cf/frmskipgrid.cfm" 
		OR cgi.script_name IS "/cf/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/cf/frmRecommend.cfm" 	
		OR cgi.script_name IS "/cf/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/cf/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/cf/frmDrugList.cfm" 			
		OR cgi.script_name IS "/cf/frmeligibility.cfm" 
		OR cgi.script_name IS "/cf/proceligibility.cfm" 
		OR cgi.script_name IS "/cf/frmDetails.cfm" 
		OR cgi.script_name IS "/cf/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/cf/redirect.cfm" 	
		OR cgi.script_name IS "/cf/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/cf/printed.cfm" 
		OR cgi.script_name IS "/cf/full.cfm"))> id="on"</cfif>><cf_sessionPassVars href="pdb.cfm?partner_id=22" partner_id="22" subset_id="0"
org_id="#session.org_id#" user_id="#session.user_id#" test_id="#session.test_id#" extralist="skipintro=true" prev_id="0" confirm="#clickText#"><cf_displayText group="site" code="site_aarp_tab_prescription_drug_benefits"></cf_sessionPassVars></li>
		
		<li<cfif session.subset_id IS 68 AND (
		cgi.script_name IS "/cf/frmwelcome2.cfm" 
		OR cgi.script_name IS "/cf/frmquestions.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssec.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/cf/frmskipgrid.cfm" 
		OR cgi.script_name IS "/cf/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/cf/frmRecommend.cfm" 	
		OR cgi.script_name IS "/cf/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/cf/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/cf/frmDrugList.cfm" 			
		OR cgi.script_name IS "/cf/frmeligibility.cfm" 
		OR cgi.script_name IS "/cf/proceligibility.cfm" 
		OR cgi.script_name IS "/cf/frmDetails.cfm" 
		OR cgi.script_name IS "/cf/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/cf/redirect.cfm" 	
		OR cgi.script_name IS "/cf/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/cf/printed.cfm" 
		OR cgi.script_name IS "/cf/full.cfm")> id="on"</cfif>><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=22&subset_id=68" subset_id="68" partner_id="22" prev_id="0" confirm="#clickText#"><cf_displayText group="site" code="site_aarp_tab_benefits_state"></cf_sessionPassVars></li>		
		
	</ul>
	</cfoutput>

</cfif>