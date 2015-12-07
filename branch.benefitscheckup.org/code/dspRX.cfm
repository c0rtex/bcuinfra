
<!-- include default values -->
<!--- Set CMS card drug list --->
<cfset session.OutputtedDrugList = "">
<!-- Initiate Rx Subset Recommended Programs list to be used for eforms  -->
<cfset RxPrgList = "">
<!-- Default Parameters -->
<cfif not isdefined ('session.selectedDrugs')>
	<cfset session.selectedDrugs = "">
</cfif>
<cfif not isdefined ('session.prg_list')>
	<cfset session.session.prg_list = "">
</cfif>
<cfif not isdefined ('session.strClient')>
	<cfset session.session.strClient = "">
</cfif>
<cfif not isdefined ('session.med_receive')>
	<cfset session.session.med_receive = "">
</cfif>
<cfif not isdefined ('session.subset_id')>
	<cfset session.session.subset_id = "">
</cfif>


<cfparam name="userMedications" default="#session.selectedDrugs#">  <!--  session.selectedDrugs -->
<cfparam name="strClient" default="#session.strClient#"> <!-- person  session.strClient -->
<cfparam name="med_receive" default="#session.med_receive#"> <!-- session.med_receive-->
<cfparam name="prg_list" default="#session.prg_list#"> <!--  session.prg_list -->
<cfparam name="subset_id" default="#session.subset_id#"><!-- session.subset_id--> 
<cfset Session.WrapAroundDrugList = ""><!-- medicare card drugs --> 
<!-- check if the user is receiving a state rx program --> 
<cfif session.state_pharm_program neq 'Y'>
	<cfparam name="stateReceive" default="N">
<cfelse>
	<cfparam name="stateReceive" default="Y">
</cfif>
<cfparam name="medicare_receive" default="#session.medicare_receive#"><!-- receiving state program--> 
<cfset FacilitatedEnrollList = "129-333-2605-FD-FD,XXX-319-1879-OH-ST,XXX-311-1588-RI-ST,XXX-311-1588-RI-ST">
<cfset AutoEnrollList = "XXX-311-1266-NY-ST,129-333-2615-FD-FD,117-311-1020-NJ-ST,129-333-2602-FD-FD,118-311-2575-NC-ST,XXX-311-1796-MI-ST,129-333-2620-FD-FD,XXX-311-1223-ME-ST,XXX-311-2261-MA-ST,129-333-2618-FD-FD,XXX-311-1520-CT-ST">
<cfset stateProgramList = "AK,AZ,CA,HI,IA,OH,OR,WV,MN,PA,CT,FL,IL,IN,KS,MA,NV,NH,NJ,NY,RI,MO,MI,WI,WY,SC,ME,MD,NC,DE,VT">
<cfset hasStateProgram = "">
<cfset OtherOptionsCount = 0 >

<cfif #listContains(stateProgramList, session.ST)#>
	<!-- has state program --> 
	<!--- TEST OUTPUT: HAS STATE PROGRAM ---> 
	<cfset hasStateProgram = "Y">
<cfelse>	
	<!-- has state program --> 
	<cfset hasStateProgram = "N">
</cfif>

<!--- eligible for medicaid from one of the prg_ids query medicaid subset --->


<cfinclude template="qryMedicaid.cfm">
<cfif qryMedicaid.recordcount gt 0 >
	<cfset strMedicaidEligible="Y">
<cfelse>
	<cfset strMedicaidEligible="N">
</cfif>



 <table ><tr><td><font face="arial" size="4" color="#000000">
<!-- Begin Recommendation Output -->
<!-- <p> *********** BEGIN BCURX TEST OUTPUT  ************</p> --->
<!-- Begin Summary list -->
<cfinclude template="dspSummary.cfm">

<!-- Begin Recommended Options -->
	<cfset display_level = "1">
	<cfset mode = "FullDescription">
	<cfinclude template="dspRecommendedOptions.cfm">

<!-- Begin Other Options -->
	<cfset display_level = "2">
	<cfinclude template="dspRecommendedOptions.cfm">

<!-- If not recommendations returned, display default text-->
<cfif RxPrgList eq "">
<p><font face="Arial" size="3"><b>Thank you for taking the time to complete BenefitsCheckUpRx. We've compared your answers with the eligibility criteria of many public and private programs that provide substantial savings on the costs of prescription drugs.  Based on the answers you provided, we currently have no programs to recommend to you. We continually update our database with new programs and medications, so please try again soon.</b></font></p>
<p><font face="Arial" size="3"><b>There are other ways you can save money on prescription drugs. Click <a href="">here</a> for additional information on saving money.</b></font></p>
<p><font face="Arial" size="3"><b>Click <a href="">here</a> for important information you should know about prescription medications.</b></font></p>
<cfelse>
<!-- Update Results list and display the form for application guide  page. -->
	

<!-- Remove standard med approved card if others exist for application guide -->
	<cfif findnocase("-333-", RxPrgList) gt 0 or findnocase("-334-", RxPrgList) gt 0 >
		<cfset removeMedApproved = listcontains(RxPrgList, '129-311-2526-FD-FD',",")>
		<cfif removeMedApproved eq 0>
			<cfset removeNonTA = listcontains(RxPrgList, '129-311-2523-FD-FD',",")>
		</cfif>
		<cfif removeMedApproved gt 0 >
			<cfset RxPrgList = #listdeleteat(RxPrgList, removeMedApproved, ",")#>
		</cfif>
	</cfif>

<cfoutput>
<a name="apply"></a>
<br>

<form action="frmAccess.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#">
<input type="submit" name="GetStarted" value="Make Decisions and Enroll Now">
<input type="hidden" name="RxPrgList" value="#RxPrgList#">
</form>

</cfoutput>
</cfif>	
<cfif Not IsDefined('session.partner_id') Or session.partner_id neq 5>
<br>
<b>Comments</b>
<p>
Are these programs helpful to you?  Please take a moment to tell us how you will use this information to access needed benefits by sending us an email to <cfoutput><a href="mailto:#request.comments_address#">#request.comments_address#</a></cfoutput>.
</p>
</cfif>
<cfif not isdefined('session.org_id') or session.org_id eq 0>
<b>Start Over</b>
<p>
If you would like to repeat the questionnaire, click <cf_sessionPassVars href="startover.cfm">here</cf_sessionPassVars>. Please note that if you click this link, you will begin a new questionnaire and the above results will not be saved. 
</p>
<cfelse>
	<cf_displayButton return_oe="true">
</cfif>
<!---
<a name="study"></a>
<b>Sign Up for a Survey</b><br><br>
<cfoutput>
To better serve people like you, The National Council on the Aging is sponsoring a brief telephone survey to see if people ask for and get the benefits for which they might qualify.  To thank you for your time, you will be sent <b>$10</b> after completing the phone survey.  Click the button below to sign up.  Your sign-up form will open in a new window.<br><br>
<form action="printforms.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
   <input type="hidden" name="code" value="NCOA_Research_Study_001_FF">
   <input type="hidden" name="src" value="rec">
   <input type="submit" name="special" value="Sign Up for Research Study">
</form> 
</cfoutput>
--->
<cfif session.citizen neq 'Citizen' and session.subset_id neq 12>
<br>
<b>FOR THOSE WHO ARE NOT US CITIZENS</b>
<p>You indicated that you are not a U.S. citizen. If you are not a U.S. citizen but are otherwise eligible for certain benefit programs, we will include information about these benefits in your report. However, you should also check with the Immigration Forum, <a href="http://www.immigrationforum.org">www.immigrationforum.org</a> to determine if a person of your immigration status is, in fact, eligible for these programs.</p>
</cfif>
<br>
<b>Exit</b>
<br>
<p>
If you would like to exit, click <A href="dspABCExit.cfm">here</A>.
</p>
<!--- <p> *********** END  BCURX TEST OUTPUT  ************</p> --->
</td></tr></table>
