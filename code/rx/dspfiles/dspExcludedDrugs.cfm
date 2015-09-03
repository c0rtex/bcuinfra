<CFIF session.subset_id neq 27 and session.subset_id neq 39 >
<cfset arrayExcludeFiles = arrayNew(1)>
<cfset structExcludeTitle = structNew()>
<cfset structExcludeTitle = structNew()>
<cfset arrayLivingSituationFields = arrayNew(1)>
<cfset livingSitApplyInc = "N">
<cfset request.doNewScreening = "N">
<cfset request.doScreening = "N">
<!-- Living Conditions --->
<cfif isdefined('session.ltc_current_nurse_home') and session.ltc_current_nurse_home eq 'y'>
	<cfset success = arrayappend(arrayLivingSituationFields, "ltc_current_nurse_home")>
	<cfset livingSitApplyInc = "Y">
</cfif>
<cfif isdefined('session.ltc_current_assist_live') and session.ltc_current_assist_live eq 'y'>
	<cfset success = arrayappend(arrayLivingSituationFields, "ltc_current_assist_live")>
	<cfset livingSitApplyInc = "Y">
</cfif>
<cfif isdefined('session.ltc_current_group_home') and session.ltc_current_group_home eq 'y'>
	<cfset success = arrayappend(arrayLivingSituationFields, "ltc_current_group_home")>
	<cfset livingSitApplyInc = "Y">
</cfif>
<cfif isdefined('session.ltc_current_home_health') and session.ltc_current_home_health eq 'y'>
	<cfset success = arrayappend(arrayLivingSituationFields, "ltc_current_home_health")>
	<cfset livingSitApplyInc = "Y">
</cfif>

<cfset listLivingSituationFields = #arraytolist(arrayLivingSituationFields, "','")#>
<cfset listLivingSituationFields = "'" &  listLivingSituationFields & "'" >
<cfif #len(listLivingSituationFields)# gt 1>
	<cfquery name="qrylivSit" datasource="#session.datasrc#">
		SELECT      pt.programtext_id, pt.summary, pt.answerfield, pt.rec, pt.actions
		FROM        programtext pt
		WHERE     
		pt.template = 'LIVSITUATION' 
		and answerfield IN (#PreserveSingleQuotes(listLivingSituationFields)#)  
	</cfquery>
</cfif>
<cfloop QUERY="qrylivSit" >
<cfif mode eq "Summary">
<cfif #len(Summary)# gt 1 ><li><cfoutput>#summary#</cfoutput></li></cfif>
<cfelse>
<cfif #len(actions)# gt 1 ><cfset result = #arrayAppend(arrayActions, qrylivSit.Programtext_id)#></cfif>
	<li>
	<cfoutput>#rec#</cfoutput>
	<table><tr><td width="180" valign=center>
		<cfoutput><a href="#answerfield#.pdf" target="_blank"><img src="images/button_fact-sheet.gif" alt="View Fact Sheet" border="0"></a></cfoutput>
			</td><td  valign=center><font size=+1>Read more </font><br><em>(Clicking the button to the left will open a new window.)</em>
		</td>
		</tr>
	</table><br>
	</li>
</cfif>
</cfloop>

<!-- show links to excluded file templates -->
<!--  exclude_drug_anxiety	Anxiety or nervousness -->
<cfif isdefined('session.exclude_drug_anxiety') and session.exclude_drug_anxiety eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_anxiety")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_anxiety", "Anxiety or Nervousness")# >
</cfif>
<!--  exclude_drug_panic	Panic attacks -->
<cfif isdefined('session.exclude_drug_panic') and session.exclude_drug_panic eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_panic")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_panic", "Panic Attacks")# >
</cfif>
<a href="../../forms/#excludetemplate.pdf#"></a>
<!--  exclude_drug_mania	Mania -->
<cfif isdefined('session.exclude_drug_mania') and session.exclude_drug_mania eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_mania")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_mania", "Mania")# >
</cfif>
<!--  exclude_drug_seizure	Seizures or epilepsy -->
<cfif isdefined('session.exclude_drug_seizure') and session.exclude_drug_seizure eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_seizure")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_seizure", "Seizures or Epilepsy")# >
</cfif>
<!--  exclude_drug_pain	Pain -->
<cfif isdefined('session.exclude_drug_pain') and session.exclude_drug_pain eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_pain")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_pain", "Pain")# >
</cfif>

<!--  exclude_drug_sleep	Trouble falling asleep -->
<cfif isdefined('session.exclude_drug_sleep') and session.exclude_drug_sleep eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_sleep")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_sleep", "Trouble falling asleep")# >
</cfif>
<!-- exclude_drug_spasm	Muscle spasms  -->
<cfif isdefined('session.exclude_drug_spasm') and session.exclude_drug_spasm eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_spasm")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_spasm", "Muscle spasms")# >
</cfif>
<!-- exclude_drug_weight_gain	Weight gain (except for AIDS, cancer, heart failure, and other long-term conditions such as severe lung, kidney, and liver disease)  -->
<cfif isdefined('session.exclude_drug_weight_gain') and session.exclude_drug_weight_gain eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_weight_gain")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_weight_gain", "Weight Gain")# >
</cfif>
<!-- exclude_drug_weight_loss	Weight loss  -->
<cfif isdefined('session.exclude_drug_weight_loss') and session.exclude_drug_weight_loss eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_weight_loss")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_weight_loss", "Weight Loss")# >
</cfif>
<!-- exclude_drug_infertility	Infertility  -->
<cfif isdefined('session.exclude_drug_infertility') and session.exclude_drug_infertility eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_infertility")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_infertility", "Infertility")# >
</cfif>
<!--  exclude_drug_cosmetic	Wrinkles, hair growth, and other cosmetic purposes -->
<cfif isdefined('session.exclude_drug_cosmetic') and session.exclude_drug_cosmetic eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_cosmetic")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_cosmetic", "Wrinkles, hair growth, and other cosmetic purposes")# >
</cfif>
<!--  exclude_drug_vitamin	Prescription vitamins (not over the counter vitamins) -->
<cfif isdefined('session.exclude_drug_vitamin') and session.exclude_drug_vitamin eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_vitamin")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_vitamin", "Prescription vitamins (not over the counter vitamins)")# >
</cfif>
<!-- exclude_drug_cold	Prescription medication to relieve the symptoms of a cough or cold  -->
<cfif isdefined('session.exclude_drug_cold') and session.exclude_drug_cold eq 'y'>
	<cfset success = arrayappend(arrayExcludeFiles, "exclude_drug_cold")>
	<cfset success = #structInsert(structExcludeTitle,"exclude_drug_cold", "Prescription medication to relieve the symptoms of a cough or cold")# >
</cfif>
<cfset listExcludedeDrugs = #arraytolist(arrayExcludeFiles, "','")#>
<cfset listExcludedeDrugs = "'" &  listExcludedeDrugs & "'" >
<cfif #len(listExcludedeDrugs)# gt 1>
	<cfquery name="qryExDrugs" datasource="#session.datasrc#">
		SELECT      pt.programtext_id,pt.summary, pt.answerfield, pt.rec, pt.actions
		FROM        programtext pt
		WHERE     
		pt.template = 'EXCLUDEDRUG' 
		and answerfield IN (#PreserveSingleQuotes(listExcludedeDrugs)#)  
	</cfquery>
</cfif>
<cfloop QUERY="qryExDrugs" >
<cfif mode eq "Summary">
<cfif #len(summary)# gt 1><li><cfoutput>#summary#</cfoutput></li></cfif>
<cfelse>
<cfif len('actions') gt 1 ><cfset result = #arrayAppend(arrayActions, qryExDrugs.Programtext_id)#></cfif>
	<li>
	<cfoutput>#rec#</cfoutput>
	<table><tr><td width="180" valign=center>
		<cfoutput><a href="#answerfield#.pdf" target="_blank"><img src="images/button_fact-sheet.gif" border="0" alt="View Fact Sheet"></a></cfoutput>
			</td><td  valign=center><font size=+1>Read more </font><br><em>(Clicking the button to the left will open a new window.)</em>
		</td>
		</tr>
	</table><br>
	</li>
</cfif>
</cfloop>


<!--- OFF LABLE DRUGS --->
<cfif structKeyExists(session.screening.afval, 'rx_off_label') and (StructFind(session.screening.afval, 'rx_off_label') eq 1 or StructFind(session.screening.afval, 'rx_off_label') eq 1474)>
<cfif mode eq "Summary">
<li><cfoutput>You indicated that you may be taking one or more medications for an "off label" use.  Click on the Fact Sheet below to find out how you may be able to save money on these medications. </cfoutput></li>
<cfelse>
	<li>
	<cfoutput>You indicated that you may be taking one or more medications for an "off label" use.  Click on the Fact Sheet below to find out how you may be able to save money on these medications. </cfoutput>
	<table><tr><td width="180" valign=center>
		<cfoutput><a href="offlabel.pdf" target="_blank"><img src="images/button_fact-sheet.gif" border="0" alt="View Fact Sheet"></a></cfoutput>
			</td><td  valign=center><font size=+1>Read more </font><br><em>(Clicking the button to the left will open a new window.)</em>
		</td>
		</tr>
	</table><br>
	</li>
</cfif>
</cfif>

<cfif session.med_receive neq 'y' AND session.ssi_receive neq 'y' >
   <cfif (( livingSitApplyInc eq 'Y' ) OR ((   (session.marital_stat eq 'Single'  and session.hh_income_total_complete lt 1633 ) or ( session.marital_stat neq 'Single'  and session.hh_income_total_complete lt 2200 ) ) ))>
   	<cfset request.doScreening = "both">
	<cfif mode eq "Summary">
	<li><cfoutput>Learn whether you should apply for Medicaid and Supplemental Security Income (SSI).</cfoutput></li>
	<cfelse>
	    <cfset request.doNewScreening = "Y">
		<li>
		<cfoutput>Based on the information you have provided so far, we think there is a possibility that you are eligible for Medicaid and Supplemental Security Income (SSI).   If you qualify, these programs will help you with many of your medical expenses as well as provide you with cash assistance on a monthly basis.  We encourage you to click on the SSI/Medicaid Screening Service at the end of this report.   By answering a few more questions, we will be able to make better recommendation about whether we think you should apply for Medicaid or Supplemental Security Income.</cfoutput>
		</li>
	</cfif>
 </cfif>
<cfelseif session.med_receive neq 'y' AND	session.ssi_receive eq 'y' >
    <cfif (( livingSitApplyInc eq 'Y' ) OR ((   (session.marital_stat eq 'Single'  and session.hh_income_total_complete lt 1633 ) or ( session.marital_stat neq 'Single'  and session.hh_income_total_complete lt 2200 ) )  ))>
	<cfset request.doScreening = "m">
	<cfif mode eq "Summary">
	<li><cfoutput>Learn whether you should apply for Medicaid. </cfoutput></li>
	<cfelse>
		<cfset request.doNewScreening = "Y">
		<p><li>
		<cfoutput>Based on the information you have provided so far, we think there is a possibility that you are eligible for Medicaid.   If you qualify for Medicaid, it will help you with many of your medical expenses.  We encourage you to click on the SSI/Medicaid Screening Service at the end of this report.   By answering a few more questions, we will be able to make a better recommendation about whether we think you should apply for Medicaid. </cfoutput>
		</li></p>
	</cfif>
  </cfif>
<cfelseif session.ssi_receive neq 'y' AND	session.med_receive eq 'y' >
  <cfif (( livingSitApplyInc eq 'Y' ) OR (   (session.marital_stat eq 'Single'  and session.hh_income_total_complete lt 1633 ) or ( session.marital_stat neq 'Single'  and session.hh_income_total_complete lt 2200 ) )  )>
  <cfset request.doScreening = "s">
	<cfif mode eq "Summary">
	<li><cfoutput>Learn whether you should apply for Supplemental Security Income (SSI).</cfoutput></li>
	<cfelse>
		<cfset request.doNewScreening = "Y">
		<p><li>
		<cfoutput>Based on the information you have provide us so far, there is a possibility that you are eligible for Supplemental Security Income (SSI), a program which provides monthly cash assistance.    We encourage you to click on the SSI/Medicaid Screening Service at the end of this report.   By answering a few more questions, we will be able to make a better recommendation about whether we think you should apply for SSI. </cfoutput>
		</li></p>
	</cfif>
  </cfif>
</cfif>
<cfset request.FoodStampsScreening  = ""> 
  <cfif (   (session.marital_stat eq 'Single' and session.hh_income_total_complete lt 1633 ) or ( session.marital_stat neq 'Single'  and session.hh_income_total_complete lt 2200 ) ) >
	<cfif mode eq "Summary">
	<li><cfoutput>Learn whether you should apply for Food Stamps, Housing and Energy Assistance Programs.</cfoutput></li>
	<cfelse>
		<cfset request.FoodStampsScreening  = "Y">
		<p><li>
		<cfoutput>Based on the information you have provided so far, we think there is a possibility that you are eligible for Food Stamps, Housing and Energy Assistance Programs, which can provide you with valuable help throughout the year.  We encourage you to click on the link to screen for these programs under the "What to do Next" section of this report. By answering a few more questions, we will be able to make better recommendations about whether we think you should apply for Food Stamps, Housing and/or Energy Assistance Programs.</cfoutput>
		</li></p>
	</cfif>
  </cfif>
 </cfif>