<cfset arrayExcludeFiles = arrayNew(1)>
<cfset structExcludeTitle = structNew()>
<cfset structExcludeTitle = structNew()>
<cfset arrayLivingSituationFields = arrayNew(1)>

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
	<cfquery name="qryExDrugs" datasource="#application.dbSrc#">
		SELECT      pt.summary, pt.answerfield, pt.rec, pt.actions
		FROM        programtext pt
		WHERE     
		pt.template = 'EXCLUDEDRUG' 
		and answerfield IN (#PreserveSingleQuotes(listExcludedeDrugs)#)  
	</cfquery>
</cfif>
<cfloop QUERY="qryExDrugs" >
<cfif mode eq "Summary">
<li><cfoutput>#summary#</cfoutput></li>
<cfelse>
	<li>
	<cfoutput>#rec#</cfoutput>
	<br><br>
	<cfoutput><a href="#answerfield#.pdf" target="_blank"><img src="images/button_fact-sheet.gif" border="0"></a></cfoutput>
	</li>
</cfif>
</cfloop>




<cfif isdefined('session.ltc_current_nurse_home') and session.ltc_current_nurse_home eq 'y'>
	<cfset success = arrayappend(arrayLivingSituationFields, "ltc_current_nurse_home")>
	
</cfif>
<cfif isdefined('session.ltc_current_assist_live') and session.ltc_current_assist_live eq 'y'>
	<cfset success = arrayappend(arrayLivingSituationFields, "ltc_current_assist_live")>
	
</cfif>
<cfif isdefined('session.ltc_current_group_home') and session.ltc_current_group_home eq 'y'>
	<cfset success = arrayappend(arrayLivingSituationFields, "ltc_current_group_home")>
	
</cfif>
<cfif isdefined('session.ltc_current_home_health') and session.ltc_current_home_health eq 'y'>
	<cfset success = arrayappend(arrayLivingSituationFields, "ltc_current_home_health")>
	
</cfif>

<cfset listLivingSituationFields = #arraytolist(arrayLivingSituationFields, "','")#>
<cfset listLivingSituationFields = "'" &  listLivingSituationFields & "'" >
<cfif #len(listLivingSituationFields)# gt 1>
	<cfquery name="qrylivSit" datasource="#application.dbSrc#">
		SELECT      pt.summary, pt.answerfield, pt.rec, pt.actions
		FROM        programtext pt
		WHERE     
		pt.template = 'EXCLUDEDRUG' 
		and answerfield IN (#PreserveSingleQuotes(listLivingSituationFields)#)  
	</cfquery>
</cfif>
<cfloop QUERY="qrylivSit" >
<cfif mode eq "Summary">
<li><cfoutput>#summary#</cfoutput></li>
<cfelse>
	<li>
	<cfoutput>#rec#</cfoutput>
	
	<cfoutput><a href="#answerfield#.pdf" target="_blank"><img src="images/button_fact-sheet.gif" border="0"></a></cfoutput>
	</li>
</cfif>
</cfloop>