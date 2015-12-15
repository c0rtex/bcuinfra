<cfif parameterExists(session.transferTypeCanonicalOverride)>
	<cfset urlType = session.transferTypeCanonicalOverride>
<cfelse>
	<cfset urlType = application.transferType>		
</cfif>	


<CFSET TEMPLATE = 'LIS'>
<CFSET TYPE="">	
<CFSET request.Compare = "Y">	
<CFSET request.ApplyNow = "N">	
<CFSET request.ExtraHelp = "N">	
<CFSET request.GetRetireeFS = "">	
<cfset request.lisanswerfield = "">	
<cfset getNotes = "">	
<cfset request.GeneralText = "N">	
<cfset request.ShowCostCalculator = "Y">	
<cfset request.ShowCompareAfter = "N">	
<cfset request.enrollnow = "Y">	
<cfif (isdefined('session.lis_undeemed') and session.lis_undeemed eq 'y') and ( isdefined('session.receive_partd') and session.receive_partd eq 'y' ) and (isdefined('session.lis_apply') and session.lis_apply eq 'y')  >
	<CFSET answerfield = 'lis_undeemed'>	
	<cfset getNotes = "Y">	
	<CFSET request.Compare = "N">	
	<CFSET request.ApplyNow = "Y">
	<cfset request.ShowCostCalculator = "N">	
	<CFSET benefit = 3 >	
	<CFSET TYPE = "receiving" >	
<cfelseif  ( isdefined('session.receive_partd') and session.receive_partd eq 'y' ) and (isdefined('session.lis_apply') and session.lis_apply eq 'y')  >
	<CFSET answerfield = 'receive_partd'>	
	<cfset getNotes = "Y">	
	<CFSET request.Compare = "Y">	
	<CFSET request.ApplyNow = "N">
	<cfset request.ShowCostCalculator = "N">	
	<CFSET benefit = 3 >	
	<CFSET TYPE = "receiving" >			
<cfelseif isdefined('session.receive_partd') and session.receive_partd eq 'y' and isdefined('session.receive_lis') and session.receive_lis eq 'y' >
	<cfif  isdefined('session.lis_undeemed') and session.lis_undeemed eq 'y' >
		<cfset answerfield = 'lis_undeemed' >
		<CFSET request.ApplyNow = "Y">
	<cfelse >
		<cfset answerfield = 'receive_partd_lis'>
	</cfif>	
	<cfset request.ShowCostCalculator = "N">	
	<CFSET benefit = 9 >	
	<CFSET TYPE = "receiving" >	
<!-- partD  -->	
<cfelseif isdefined('session.receive_partd') and session.receive_partd eq 'y' >
	<CFSET benefit = 7 >
	<cfif isdefined('session.lis_undeemed') and session.lis_undeemed eq 'y'>
		<CFSET answerfield = 'lis_undeemed'>
		<CFSET request.ApplyNow = "Y">
	<cfelse>
		<CFSET answerfield = 'receive_partd'>	
	</cfif>
	<CFSET request.ShowCostCalculator = "N">		
	<CFSET TYPE='receiving'>	
	<CFSET request.Compare = "Y">
	<cfif isdefined('session.receive_msp') and isdefined('session.ssi_receive') and  session.ssi_receive eq 'y' and session.receive_msp eq 'y' and session.med_receive eq 'y' >	
	  <CFSET answerfield  = 'receive_msp_med_ssi'>	
	  <cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and isdefined('session.ssi_receive') and  session.ssi_receive eq 'y' and session.receive_msp eq 'y' >	
	  <CFSET answerfield = 'receive_msp_ssi'>	
	  <cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and isdefined('session.med_receive') and  session.med_receive eq 'y' and session.receive_msp eq 'y' >	
	  <CFSET answerfield = 'receive_msp_med'>	
	  <cfset getNotes = "Y">	
	<cfelseif isdefined('session.med_receive') and isdefined('session.ssi_receive') and  session.med_receive eq 'y' and session.ssi_receive eq 'y' >	
	 <CFSET answerfield = 'receive_med_ssi'>	
	 <cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and session.receive_msp eq 'y'  >	
	 <CFSET answerfield = 'receive_msp'>	
	 <cfset getNotes = "Y">	
	<cfelseif isdefined('session.ssi_receive') and session.ssi_receive eq 'y' >	
	  <CFSET answerfield = 'ssi_receive'>	
	  <cfset getNotes = "Y">	
	<!--- These Next --->	
	<cfelseif isdefined('session.med_receive') and session.med_receive eq 'y' >	
	  <CFSET answerfield = 'med_receive'>	
	  <CFSET request.Compare = "Y">	
	  <cfset getNotes = "Y">	
	<!--- receive part d and lis eligible --->
	<cfelseif findnocase( "103-311-2593-FD-FD", #prg_list#) gt 0   >	
	  <cfset request.ShowCostCalculator = "N">	
	  <cfset benefit = 2 >
	  <cfset request.ShowCompareAfter = "Y">	
	  <CFSET request.Compare = "Y">	
	  <CFSET request.ApplyNow = "Y">
	<!--- receive part d and 103-311-2588-FD-FD eligible --->	
	<cfelse   >	
	  <cfset benefit = 1 >	
	  <cfset request.enrollnow = "N">	
	  <CFSET request.Compare = "Y">	
	</cfif>	
<!-- receive lis benefit  -->	
<cfelseif isdefined('session.receive_lis') and session.receive_lis eq 'y' >	
	<cfif isdefined('session.lis_undeemed') and session.lis_undeemed eq 'y'>
		<CFSET answerfield = 'lis_undeemed'>
		<CFSET request.ApplyNow = "Y">
	<cfelse>
		<CFSET answerfield = 'receive_lis'>	
	</cfif>
	<cfset request.ShowCostCalculator = "N">	
	<CFSET benefit = 8 >	
	<CFSET TYPE='receiving'>
<!-- applied for lis benefit  -->	
<cfelseif isdefined('session.lis_apply') and session.lis_apply eq 'y' >	
	<cfset request.ShowCostCalculator = "N">	
	<CFSET benefit = 3 >	
	<CFSET TYPE='receiving'>	
	<cfinclude template="../qrySubmission.cfm">	
		<cfif submission_status neq 1 and submission_status neq 17 and submission_status neq "" >	
			<cfset temp_submission_status = benefit >	
			<CFSET benefit = 33 >		
		</cfif>	
	<cfif isdefined('session.lis_undeemed') and session.lis_undeemed eq 'y'>
	<CFSET answerfield = 'lis_undeemed'>	
	<cfset getNotes = "Y">	
	<CFSET request.Compare = "N">	
	<CFSET request.ApplyNow = "Y">		
	<cfelseif  ( (isdefined('session.med_receive') and session.med_receive eq 'y') OR (isdefined('session.receive_msp') and session.receive_msp eq 'y') OR (isdefined('session.ssi_receive') and  session.ssi_receive eq 'y')) AND ( isdefined('session.creditable_coverage') and session.creditable_coverage eq 'Y') >
	<CFSET answerfield = 'creditable_deemed'>	
	<cfset getNotes = "Y">	
	<!-- return programtext_id=5656 -->
	<!--- These First --->	
	<cfelseif isdefined('session.receive_creditable_coverage') and session.receive_creditable_coverage eq 'y' >	
	<CFSET answerfield = 'receive_creditable_coverage'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and isdefined('session.ssi_receive') and  session.ssi_receive eq 'y' and session.receive_msp eq 'y' and session.med_receive eq 'y' >	
	<CFSET answerfield  = 'receive_msp_med_ssi'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and isdefined('session.ssi_receive') and  session.ssi_receive eq 'y' and session.receive_msp eq 'y' >	
	<CFSET answerfield = 'receive_msp_ssi'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and isdefined('session.med_receive') and  session.med_receive eq 'y' and session.receive_msp eq 'y' >	
	<CFSET answerfield = 'receive_msp_med'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.med_receive') and isdefined('session.ssi_receive') and  session.med_receive eq 'y' and session.ssi_receive eq 'y' >	
	<CFSET answerfield = 'receive_med_ssi'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and session.receive_msp eq 'y'  >	
	<CFSET answerfield = 'receive_msp'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.ssi_receive') and session.ssi_receive eq 'y' >	
	<CFSET answerfield = 'ssi_receive'>	
	<cfset getNotes = "Y">	
	<!--- These Next --->	
	<cfelseif isdefined('session.rec_tricare') and   session.rec_tricare eq 'y' >	
	<CFSET answerfield = 'rec_tricare'>	
	<CFSET request.Compare = "N">	
	<cfif isdefined('session.med_receive') and isdefined('session.medicare_receive') and session.med_receive eq 'y' and session.medicare_receive eq 'y' >	
	<cfset tricareplus = "y">	
	<cfset tricareplustext = " However, since you indicated you are also receiving Medicaid, you will be automatically enrolled in a Medicare Prescription Drug Plan with the Extra Help unless you call Medicare to disenroll in this program.  It is important to check with TRICARE and Medicare to find out which prescription coverage will work best for you.">	
	</CFIF>	
	<CFSET request.Compare = "N">	
	<cfelseif isdefined('session.med_receive') and session.med_receive eq 'y' >	
	<CFSET answerfield = 'med_receive'>	
	<CFSET request.Compare = "Y">	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_champva') and  session.receive_champva eq 'y' >	
	<CFSET answerfield = 'receive_champva'>	
	<CFSET request.Compare = "N">			
	<cfelseif isdefined('session.receive_fehbp') and  session.receive_fehbp eq 'y' >	
	<CFSET answerfield = 'receive_fehbp'>	
	<CFSET request.Compare = "N">		
	<cfelseif isdefined('session.receive_va') and   session.receive_va eq 'y' >	
	<CFSET answerfield = 'receive_va'>	
	<CFSET request.Compare = "N">	
	<cfelseif isdefined('session.receive_employ_retiree') and session.receive_employ_retiree eq 'y' and StructFind(session.screening.afval, 'receive_employ_retiree_credit_2') eq 1 >	
	<CFSET answerfield = 'rec_employ_retiree_credit_1'>	
	<CFSET request.GetRetireeFS = "Y">	
	<CFSET request.Compare = "N">	
	<cfelseif isdefined('session.receive_medadv_plan_presc_y') and session.receive_medadv_plan_presc_y eq 'y' >	
	<CFSET answerfield = 'receive_medadv_plan_presc_y'>	
	<cfelseif isdefined('session.receive_medadv_plan_presc_n') and session.receive_medadv_plan_presc_n eq 'y' >	
	<CFSET answerfield = 'receive_medadv_plan_presc_n'>	
	<CFSET request.Compare = "Y">	
	<cfelse>	
	<cfset request.compare = "Y">	
	<CFSET answerfield = 'none'>	
	<cfset request.enrollnow = "N">	
	</cfif>	
<!-- eligible for lis benefit -->	
<cfelseif findnocase( "103-311-2593-FD-FD", #prg_list#) gt 0 >	
	<cfset request.ShowCostCalculator = "N">	
	<cfset benefit = 2 >
	<cfset PRG_ID = "103-311-2593-FD-FD">	
	<cfset success = #arrayAppend(arraylinks, PRG_ID)#>	
	<CFSET TYPE='eligible'>	
	<cfif mode eq "Summary">	
		<cfset RxPrgList = #ListAppend(RxPrgList, "129-309-2591-FD-FD", ",")# >	
	</cfif>	
<!--- These First --->	
	<cfif isdefined('session.lis_undeemed') and session.lis_undeemed eq 'y'>
	<CFSET answerfield = 'lis_undeemed'>	
	<cfset getNotes = "Y">
	<CFSET request.Compare = "N">	
	<CFSET request.ApplyNow = "Y">		
	<cfelseif  ( (isdefined('session.med_receive') and session.med_receive eq 'y') OR (isdefined('session.receive_msp') and session.receive_msp eq 'y') OR (isdefined('session.ssi_receive') and  session.ssi_receive eq 'y')) AND ( isdefined('session.creditable_coverage') and session.creditable_coverage eq 'Y') >
	<CFSET answerfield = 'creditable_deemed'>	
	<cfset request.ShowCompareAfter = "n">	
	<CFSET request.ApplyNow = "Y">	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_creditable_coverage') and session.receive_creditable_coverage eq 'y' >	
	<CFSET answerfield = 'receive_creditable_coverage'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and isdefined('session.ssi_receive') and  session.ssi_receive eq 'y' and session.receive_msp eq 'y' and session.med_receive eq 'y' >	
	<CFSET answerfield  = 'receive_msp_med_ssi'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and isdefined('session.ssi_receive') and  session.ssi_receive eq 'y' and session.receive_msp eq 'y' >	
	<CFSET answerfield = 'receive_msp_ssi'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and isdefined('session.med_receive') and  session.med_receive eq 'y' and session.receive_msp eq 'y' >	
	<CFSET answerfield = 'receive_msp_med'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.med_receive') and isdefined('session.ssi_receive') and  session.med_receive eq 'y' and session.ssi_receive eq 'y' >	
	<CFSET answerfield = 'receive_med_ssi'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and session.receive_msp eq 'y'  >	
	<CFSET answerfield = 'receive_msp'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.ssi_receive') and session.ssi_receive eq 'y' >	
	<CFSET answerfield = 'ssi_receive'>	
	<cfset getNotes = "Y">	
	<!--- Next These --->		
	<cfelseif isdefined('session.rec_tricare') and   session.rec_tricare eq 'y' >	
	<CFSET answerfield = 'rec_tricare'>	
	<CFSET request.Compare = "N">	
	<CFIF isdefined('session.med_receive') and isdefined('session.medicare_receive') and session.med_receive eq 'y' and session.medicare_receive eq 'y' >	
	<cfset tricareplus = "y">	
	<cfset tricareplustext = "However, since you indicated you are also receiving Medicaid, you will be automatically enrolled in a Medicare Prescription Drug Plan with the Extra Help unless you call Medicare to disenroll in this program.  It is important to check with TRICARE and Medicare to find out which prescription coverage will work best for you.">	
	</CFIF>	
	<cfelseif isdefined('session.med_receive') and session.med_receive eq 'y' >	
	<CFSET answerfield = 'med_receive'>	
	<cfset getNotes = "Y">	
	<CFSET request.Compare = "Y">	
	<cfelseif isdefined('session.receive_champva') and  session.receive_champva eq 'y' >	
	<CFSET answerfield = 'receive_champva'>	
	<CFSET request.Compare = "N">	
	<cfelseif isdefined('session.receive_fehbp') and  session.receive_fehbp eq 'y' >	
	<CFSET answerfield = 'receive_fehbp'>	
	<CFSET request.Compare = "Y">	
	<cfelseif isdefined('session.receive_va') and   session.receive_va eq 'y' >	
	<CFSET answerfield = 'receive_va'>	
	<CFSET request.Compare = "Y">	
	<cfelseif isdefined('session.receive_employ_retiree') and session.receive_employ_retiree eq 'y' and StructFind(session.screening.afval, 'receive_employ_retiree_credit_2') eq 1 >	
	<CFSET answerfield = 'rec_employ_retiree_credit_1'>	
	<CFSET request.GetRetireeFS = "Y">	
	<CFSET request.Compare = "N">	
	<!--- Removing PACE Scenario - cfelseif isdefined('session.rec_pa_pace') and session.rec_pa_pace eq 'y'>	
	<CFSET answerfield = 'rec_pa_pace'>	
	<cfset request.ShowCompareAfter = "Y">	
	<CFSET request.ApplyNow = "Y">	
	<cfelseif isdefined('session.rec_pa_pacenet') and session.rec_pa_pacenet eq 'y'>	
	<CFSET answerfield = 'rec_pa_pacenet'>	
	<cfset request.ShowCompareAfter = "Y">	
	<CFSET request.ApplyNow = "Y"--->	
	<cfelseif isdefined('session.receive_medadv_plan_presc_y') and session.receive_medadv_plan_presc_y eq 'y' >	
	<CFSET answerfield = 'receive_medadv_plan_presc_y'>	
	<cfelseif isdefined('session.receive_medadv_plan_presc_n') and session.receive_medadv_plan_presc_n eq 'y' >	
	<CFSET answerfield = 'receive_medadv_plan_presc_n'>	
	<CFSET request.Compare = "Y">		
	<cfelse>	
	<CFSET answerfield = 'none'>	
	<cfset request.ShowCompareAfter = "Y">	
	<CFSET request.ApplyNow = "Y">	
	<cfset applynow = 'y'>	
	<CFSET request.Compare = "Y">	
	</cfif>	
<!-- eligible for non lis benefit -->	
<cfelseif findnocase( "103-311-2588-FD-FD", #prg_list#)  gt 0  >	
	<cfset benefit = 1 >	
	<CFSET request.Compare = "Y">	
	<CFSET TYPE='eligible'>
	<cfset PRG_ID = "103-311-2588-FD-FD">	
	<cfset success  = #arrayAppend(arraylinks, PRG_ID)#>	
	<cfif mode eq "Summary">	
		<cfset RxPrgList = #ListAppend(RxPrgList, "129-309-2588-FD-FD", ",")# >	
	</cfif>	
	<CFSET answerfield = 'none'>	
	<!--- These First --->	
	<!-- applied for lis benefit  -->	
	<cfif isdefined('session.lis_undeemed') and session.lis_undeemed eq 'y'>
	<CFSET answerfield = 'lis_undeemed'>	
	<cfelseif  ( (isdefined('session.med_receive') and session.med_receive eq 'y') OR (isdefined('session.receive_msp') and session.receive_msp eq 'y') OR (isdefined('session.ssi_receive') and  session.ssi_receive eq 'y')) AND ( isdefined('session.creditable_coverage') and session.creditable_coverage eq 'Y') >
	<CFSET answerfield = 'creditable_deemed'>	
	<cfelseif (session.dob_month gt 0) and (session.dob_year gt 0) and (DateDiff('m', CreateDate(session.dob_year, session.dob_month, 1), CreateDate(DatePart('yyyy', Now()), DatePart('m', Now()), 1)) gte 777 ) and (DateDiff('m', CreateDate(session.dob_year, session.dob_month, 1), CreateDate(DatePart('yyyy', Now()), DatePart('m', Now()), 1)) lte 783) >	
	<CFSET answerfield = 'dob_65'>	
	<cfset request.ShowCostCalculator = "Y">	
	<CFSET TYPE = "eligible" >	
	<cfelseif isdefined('session.receive_creditable_coverage') and session.receive_creditable_coverage eq 'y' >	
	<CFSET answerfield = 'receive_creditable_coverage'>	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and isdefined('session.ssi_receive') and  session.ssi_receive eq 'y' and session.receive_msp eq 'y' and session.med_receive eq 'y' >	
	<CFSET answerfield  = 'receive_msp_med_ssi'>	
	<cfset request.ShowCostCalculator = "N">	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and isdefined('session.ssi_receive') and  session.ssi_receive eq 'y' and session.receive_msp eq 'y' >	
	<CFSET answerfield = 'receive_msp_ssi'>	
	<cfset request.ShowCostCalculator = "N">	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and isdefined('session.med_receive') and  session.med_receive eq 'y' and session.receive_msp eq 'y' >	
	<CFSET answerfield = 'receive_msp_med'>	
	<cfset request.ShowCostCalculator = "N">	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.med_receive') and isdefined('session.ssi_receive') and  session.med_receive eq 'y' and session.ssi_receive eq 'y' >	
	<CFSET answerfield = 'receive_med_ssi'>	
	<cfset request.ShowCostCalculator = "N">	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.receive_msp') and session.receive_msp eq 'y'  >	
	<CFSET answerfield = 'receive_msp'>	
	<cfset request.ShowCostCalculator = "N">	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.ssi_receive') and session.ssi_receive eq 'y' >	
	<CFSET answerfield = 'ssi_receive'>	
	<cfset request.ShowCostCalculator = "N">	
	<cfset getNotes = "Y">	
	<cfelseif isdefined('session.rec_tricare') and   session.rec_tricare eq 'y' >	
	<CFSET answerfield = 'rec_tricare'>	
	<CFSET request.Compare = "N">	
	<cfif isdefined('session.med_receive') and isdefined('session.medicare_receive') and session.med_receive eq 'y' and session.medicare_receive eq 'y' >	
	<cfset tricareplus = "y">	
	<cfset tricareplustext = " However, since you indicated you are also receiving Medicaid, you will be automatically enrolled in a Medicare Prescription Drug Plan with the Extra Help unless you call Medicare to disenroll in this program.  It is important to check with TRICARE and Medicare to find out which prescription coverage will work best for you.">	
	</CFIF>	
	<cfelseif isdefined('session.med_receive') and session.med_receive eq 'y' >	
	<CFSET answerfield = 'med_receive'>	
	<cfset request.ShowCostCalculator = "N">	
	<cfset getNotes = "Y">	
	<CFSET request.Compare = "N">	
	<cfset request.ShowCostCalculator = "N">	
	<cfelseif isdefined('session.receive_champva') and  session.receive_champva eq 'y' >	
	<CFSET answerfield = 'receive_champva'>	
	<CFSET request.Compare = "N">	
	<cfset request.ShowCostCalculator = "N">	
	<cfelseif isdefined('session.receive_fehbp') and  session.receive_fehbp eq 'y' >	
	<CFSET answerfield = 'receive_fehbp'>	
	<cfset request.ShowCostCalculator = "N">	
	<CFSET request.Compare = "N">	
	<cfelseif isdefined('session.receive_va') and   session.receive_va eq 'y' >	
	<CFSET answerfield = 'receive_va'>	
	<cfset request.ShowCostCalculator = "N">	
	<CFSET request.Compare = "N">	
	<cfelseif isdefined('session.receive_employ_retiree') and session.receive_employ_retiree eq 'y' and StructFind(session.screening.afval, 'receive_employ_retiree_credit_2') eq 1 >	
	<CFSET answerfield = 'rec_employ_retiree_credit_1'>	
	<CFSET request.Compare = "N">	
	<cfset request.ShowCostCalculator = "Y">	
	<cfelseif isdefined('session.receive_medadv_plan_presc_y') and session.receive_medadv_plan_presc_y eq 'y' >	
	<CFSET answerfield = 'receive_medadv_plan_presc_y'>	
	<cfset request.ShowCostCalculator = "N">	
	<cfelseif isdefined('session.receive_medadv_plan_presc_n') and session.receive_medadv_plan_presc_n eq 'y' >	
	<CFSET answerfield = 'receive_medadv_plan_presc_n'>	
	<CFSET request.Compare = "Y">	
	<cfelseif  isdefined('session.receive_employ_retiree') and session.receive_employ_retiree eq 'y' and StructFind(session.screening.afval, 'receive_employ_retiree_credit_2') eq 0 >	
	<CFSET answerfield = 'rec_employ_retiree_credit_0'>	
	<cfset request.ShowCostCalculator = "N">	
	<cfelseif isdefined('session.receive_employ_retiree') and session.receive_employ_retiree eq 'y' and StructFind(session.screening.afval, 'receive_employ_retiree_credit_2') eq 1462 >	
	<cfset request.ShowCostCalculator = "N">	
	<CFSET request.Compare = "Y">	
	<cfelseif isdefined('session.receive_adap') and session.receive_adap eq 'y' >	
		<cfset request.ShowCostCalculator = "N">	
	<!--- Removing PACE PACENET 11-2007 cfelseif isdefined('session.session.rec_pa_pace') and session.rec_pa_pace eq 'y' >	
		<cfset request.ShowCostCalculator = "N">	
	<cfelseif isdefined('session.rec_pa_pacenet') and session.rec_pa_pacenet eq 'y' >	
		<cfset request.ShowCostCalculator = "N" --->	
	<cfelseif isdefined('session.rec_ny_epic') and session.rec_ny_epic eq 'y' >	
		<cfset request.ShowCostCalculator = "N">	
	<cfelse>	
		<cfset request.enrollnow = "N">	
		<CFSET answerfield = 'none'>	
	</cfif>	
<cfelse>	
	<CFSET answerfield = 'none'>	
	<cfset request.enrollnow = "N">	
	<CFSET benefit = 0>	
	<cfset request.compare = "N">	
	<cfif isdefined('session.med_receive') and session.med_receive eq 'y' >	
		<CFSET answerfield = 'med_receive'>	
	<cfelseif isdefined('session.rec_tricare') and   session.rec_tricare eq 'y' >	
		<CFSET answerfield = 'receive_tricare'>	
	<cfif isdefined('session.med_receive') and isdefined('session.medicare_receive') and session.med_receive eq 'y' and session.medicare_receive eq 'y' >	
		<cfset tricareplus = "y">	
		<cfset tricareplustext = " However, since you indicated you are also receiving Medicaid, you will be automatically enrolled in a Medicare Prescription Drug Plan with the Extra Help unless you call Medicare to disenroll in this program.  It is important to check with TRICARE and Medicare to find out which prescription coverage will work best for you.">	
	</CFIF>	
	<CFSET request.Compare = "N">	
<cfelseif isdefined('session.receive_va') and   session.receive_va eq 'y' >	
<CFSET answerfield = 'receive_va'>	
<cfelse>	
<cfset type = "NA">	
</cfif>	
</cfif>	
<cfinclude template="../qrySubmission.cfm">	
<cfif isdefined('url.debug')><cfoutput>LIS status ID: #submission_status#</cfoutput></cfif>
<cfif session.subset_id eq 40>
	<cfquery name="getvar" datasource="#application.dbSrc#">
			SELECT a.answerfield, sa.responsetype, sa.response, sa.option_id, o.option_code, sa.encryption_flag, sa.encrypted_response
         	FROM answerfield a 
         	INNER JOIN screening_answerfield sa ON a.answerfield_id = sa.answerfield_id 
          	LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id
          	WHERE     sa.screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.screening_id#">
            and a.answerfield_id = 6259
          	ORDER BY a.answerfield 
	</cfquery>
	<cfset request.be_send_mspinfo_cd = "">
	<cfif getvar.recordcount gt 0>
	<cfset request.be_send_mspinfo_cd = getvar.option_code>
	  <cfif request.be_send_mspinfo_cd eq 'Y'>
          		<cfset answerfield = "be_send_mspinfo_cd_optout">
      	<cfelse>
      	 	 <cfset answerfield = "be_send_mspinfo_cd_optin">
      	</cfif>
	</cfif>
	<cfset benefit = 20 >
    			<cfif (listcontains( #prg_list#, "103-309-1031-FD-FD") 
					or  listcontains( #prg_list#, "103-309-1071-FD-FD")
					or listcontains( #prg_list#, "103-309-2681-AZ-ST")
					or listcontains( #prg_list#, "103-309-2683-AZ-ST")
					or listcontains( #prg_list#, "103-309-2940-NY-ST")
					or listcontains( #prg_list#, "103-309-2939-CT-ST")
					or listcontains( #prg_list#, "103-309-1032-FD-FD")
					or listcontains( #prg_list#, "103-309-2682-AZ-ST" ) )
					>
        			<cfset benefit = 21>
   			</cfif>
	<cfif submission_status neq 1 >
		<cfset benefit = 33>
		<cfset answerfield = 'none'>
	</cfif>
    
</cfif>
<!-- Dont Show LIS info if  NY, CT and AZ or fed msp  for special situations -->
	<cfif (listcontains( #prg_list#, "103-309-1031-FD-FD") 
	or  listcontains( #prg_list#, "103-309-1071-FD-FD")
	or listcontains( #prg_list#, "103-309-2681-AZ-ST")
	or listcontains( #prg_list#, "103-309-2683-AZ-ST")
	or listcontains( #prg_list#, "103-309-2940-NY-ST")
	or listcontains( #prg_list#, "103-309-2939-CT-ST")
	or listcontains( #prg_list#, "103-309-1032-FD-FD")
	or listcontains( #prg_list#, "103-309-2682-AZ-ST" ) )
	and
	 ( 
	 listcontains( #prg_list#, "103-311-2588-FD-FD") 
	)
	>
      
		<cfif Not (
	( isdefined('session.receive_msp') and session.receive_msp eq 'y') 
	or 
	(isdefined('session.ssi_receive') and  session.ssi_receive eq 'y' ) 
	or 
	( isdefined('session.med_receive') and session.med_receive eq 'y')
	or 
	( isdefined('session.receive_lis') and session.receive_lis eq 'y')

	) >
		<cfset type = 'NA'>
		<cfset request.showcompareafter = "y">

		</cfif>
	</cfif>
<cfset request.lisanswerfield = answerfield >	
<cfif type neq 'NA'  >	
<!-- Get content from db-->	
<cfquery name="qryLIS" datasource="#application.dbSrc#">
SELECT      pt.programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions, pt.answerfield
FROM        programtext pt
WHERE     	pt.template = 'LIS' 
and pt.benefit = <cfqueryparam 
                        value="#benefit#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="2">
and Active=1
and answerfield = <cfqueryparam 
                        value="#answerfield#"
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="50">
</cfquery>
<cfif isdefined('url.debug')><cfdump var="#qryLIS#"></cfif>
<cfif isdefined('temp_submission_status')>	
	<cfset benefit =  temp_submission_status >	
</cfif>	
<cfif isdefined('TYPE')>	
<!-- OUTPUT RESULTS-->	
<cfloop  query="qryLIS" startrow="1" endrow="1" >	
	<cfif mode eq "Summary">	
	<cfif #len(summary)# gt 1>	
	<cfif answerfield eq "med_receive" or answerfield eq "receive_msp_med" or answerfield eq "receive_med_ssi" or answerfield eq "receive_msp_med_ssi">	
	<cfif session.st eq "ME">	
		<cfset replacestring = "Medicaid/MaineCare">	
	<cfelseif session.st eq "MA">	
		<cfset replacestring = "Medicaid/MassHealth">	
	<cfelseif  session.st eq "CA">	
		<cfset replacestring = "Medicaid/Medi-Cal">	
	<cfelseif session.st eq "TN">	
		<cfset replacestring = "Medicaid/TennCare">	
	<cfelseif  session.st eq "AZ">	
		<cfset replacestring = "AHCCCS (Medicaid)">	
	<cfelse>	
	<cfset replacestring = "Medicaid">	
	</cfif>	
	</cfif>	
<cfif isdefined('replacestring')>	
	<cfset Summary1 = #replace(Summary,'{prg_nm}',replacestring,"all")# >	
<cfelse>	
	<cfset Summary1 = Summary >	
</cfif>	
<cfoutput>	
<li>#Summary1#</li>	
</cfoutput>	
</cfif>	
<cfelse>	
<cfinclude template="../dspOtherOptions.cfm">	
<cfset rec = "#qryLIS.rec#">	
<cfset actions = "#qryLIS.actions#">	
<cfif len('actions') gt 0 and request.applynow neq "y" and request.compare neq "Y">	
<cfset result = #arrayAppend(arrayActions, qryLIS.Programtext_id)#>	
</cfif>	
<li>	
<p>	
<!---Output Recommendation ---->	
	<cfif answerfield eq "med_receive" or answerfield eq "receive_msp_med" or answerfield eq "receive_med_ssi" or answerfield eq "receive_msp_med_ssi">	
	<cfif session.st eq "ME">	
		<cfset replacestring = "Medicaid/MaineCare">	
	<cfelseif session.st eq "MA">	
		<cfset replacestring = "Medicaid/MassHealth">	
	<cfelseif  session.st eq "CA">	
		<cfset replacestring = "Medicaid/Medi-Cal">	
	<cfelseif session.st eq "TN">	
		<cfset replacestring = "Medicaid/TennCare">	
	<cfelseif  session.st eq "AZ">	
		<cfset replacestring = "AHCCCS (Medicaid)">	
	<cfelse>	
		<cfset replacestring = "Medicaid">	
	</cfif>	
	</cfif>	
	<cfif isdefined('replacestring')>	
		<cfset rec1 = #replace(rec,'{prg_nm}',replacestring,"all")# >	
	<cfelse>	
		<cfset rec1 = rec >	
	</cfif>	
<cfif isdefined('tricareplus') and tricareplus eq 'y'>	
<cfset rec1 = rec1 & tricareplustext >	
</cfif>	
<cfoutput>#rec1# <cfif isdefined('session.rx_oop_costs') and request.ShowCostCalculator eq "Y" >	
<cfif session.rx_oop_costs gt 0 and ( session.receive_pap eq 'y' or session.receive_drug_discount_card eq 'y' or session.receive_trx eq 'y' or session.receive_medicare_discount_credit  eq 'y' )>	
<br>	
<br>You may save money by joining a Medicare Prescription Drug Plan.  However, the actual savings you will receive will depend on the specific drugs you are taking and the plan you choose.  Since there are a variety of plans offered in your state, we recommend using the Medicare Prescription Drug Plan Finder (see link to Web site under the "What to do Next" section) to compare plans and find the one that will best meet your needs based on the costs of the plans, the drugs you are taking, and a convenient pharmacy and/or mail order options.<cfelseif session.rx_oop_costs gt 0 and session.rx_oop_costs lt 40 >	
<br>	
<br>Although you are not currently spending a lot of money out-of-pocket on prescription drugs, you should still consider joining a Medicare Prescription Drug Plan to get the insurance benefit, to have more peace of mind and to avoid paying higher premiums later on.  You may want to consider joining a plan with zero or low monthly premiums.  You will have an opportunity to switch plans at least once per year during the open enrollment period.</p>	
<cfelseif  session.rx_oop_costs  gte 40 and session.rx_oop_costs lte 250>	
<br>	
<br>You may save money by joining a Medicare Prescription Drug Plan.  However, the actual savings you will receive will depend on the specific drugs you are taking and the plan you choose.  Since there are a variety of plans offered in your state, we recommend using the Medicare Prescription Drug Plan Finder (see link to Web site under the "What to do Next" section) to compare plans and find the one that will best meet your needs based on the costs of the plans, the drugs you are taking, and a convenient pharmacy and/or mail order options.<cfelseif session.rx_oop_costs gt 250 >	
<br>	
<br>It is likely that you will save money by joining a Medicare Prescription Drug Plan.  We recommend you enroll in a plan, and can find one that best meets your needs by using the Medicare Prescription Drug Plan Finder (see link to Web site under the "What to do Next" section).   Since there are a variety of plans offered in your state, the Medicare Prescription Drug Plan Finder will help you compare plans and find one that will meet your needs based on the costs of the plans, the drugs you are taking, and a convenient pharmacy and/or mail order options. </cfif>	
</cfif>	
</cfoutput>	
<!-- OTHER NOTES -->	
<cfif ( session.fdstmp_receive eq 'y') and(session.receive_section_8 eq 'y' or session.receive_pub_housing eq 'y' or session.receive_hopwa eq 'y' ) >	
	<CFSET request.answerfieldnotes = 'receive_both' >	
<cfelseif  session.receive_section_8 eq 'y' >	
	<CFSET request.answerfieldnotes = 'receive_section_8'>		
<cfelseif  session.receive_pub_housing eq 'y' >	
	<CFSET request.answerfieldnotes = 'receive_pub_housing'>		
<cfelseif  session.fdstmp_receive eq 'y' >	
	<CFSET request.answerfieldnotes = 'fdstmp_receive'>	
<cfelseif  session.receive_hopwa eq 'y' >	
	<CFSET request.answerfieldnotes = 'receive_hopwa'>	
<cfelseif  session.med_receive eq 'y' >	
	<CFSET request.answerfieldnotes = 'med_receive'>	
<cfelseif  session.ssi_receive eq 'y' >	
	<CFSET request.answerfieldnotes = 'ssi_receive'>	
<cfelseif  session.receive_msp eq 'y' >	
	<CFSET request.answerfieldnotes = 'receive_msp'>	
<cfelse>	
	<CFSET request.answerfieldnotes = ''>	
</cfif>	
<cfif answerfield eq 'none' or getNotes eq 'y'>	
<cfset request.notesbenefit = benefit >	
<cfinclude template="dspNotes.cfm">	
</li>	
</cfif>	
<br>	
<br>
<cfif request.compare eq "Y"  and  request.ShowCompareAfter eq "N" >	
<cfinclude template="dspComparePlans.cfm">	
</cfif>	
<cfif (benefit eq 2 and listcontains(session.prg_list,'103-311-2593-FD-FD') ) or (isdefined('session.lis_undeemed') and session.lis_undeemed eq 'y' and (benefit eq 2 or benefit eq 3))>
		<cfset prg_id = "103-311-2593-FD-FD">
		<cfinclude template="../dspLinks.cfm">
</cfif>
<cfif isdefined('request.ApplyNow') and request.ApplyNow eq "Y">	
<table>	
<tr>	
<td width="140" valign=top>	
<cfoutput>
<cfif isdefined('session.partner_id') and (session.partner_id eq 14 or session.partner_id eq 15)>
	<cf_displayText var="lisappPopupText" group="site" code="site_lis_apply_popup" jsEscape="true"><cf_sessionPassVars var="lisappURL" href="extrahelp.cfm" partner_id="#session.partner_id#" org_id="#session.org_id#" user_id="#session.user_id#" test_id="#session.test_id#"><a href="##" onClick="if (confirm(#lisappPopupText#)) window.location = '#lisappURL#';"><img src="#urlType#://#session.servername#/images/button_apply-now.gif" width="130" height="28" border="0" alt="Apply Now" title="Apply Now"></a>
<cfelse>
	<cf_displayLISPopup hspace="0" vspace="0" align="left">
</cfif>
</cfoutput>
</td>	
<td  valign=top>	
<div id="prescription_drug">Apply for Extra Help available through Medicare's Prescription Drug Coverage</div>	
<br>	

</td>	
</tr>	
</table>	
<table>	
<tr>	
<td width="140" valign=top>	
<a href="/cf/NCOA_LIS_Application_Worksheet.pdf" target="new">	
<img alt="View Worksheet" src="images/button_work_sheet.gif" border=0>	
</a>	
</td>	
<td  valign=top>	
<strong>Click here to get a Worksheet (Fill it out by hand and use it as a guide to help you apply for the Extra Help)</strong>	
<br>	
<i>(Clicking the button to the left will open a new window.)</i>	
</td>	
</tr>	
</table>	
</li>	
<br/>	
</cfif>	
<!--- Display other factsheets --->	
<cfif request.GetRetireeFS eq "Y" >	
	<cfoutput>	
	<a href="RetireeCoverage.pdf" target="_blank">	
	<img src="images/button_fact-sheet.gif" border="0">	
	</a>	
	</cfoutput>	
</cfif>	
<cfif request.ApplyNow eq "Y" and subset_id eq 14 >	
	<cfinclude template="../dspLISLinks.cfm">	
</cfif>	
</p>	
</cfif>
</cfloop>
</cfif>	
</cfif>
