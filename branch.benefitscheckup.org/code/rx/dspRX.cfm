<cfif parameterExists(session.transferTypeCanonicalOverride)>
	<cfset urlType = session.transferTypeCanonicalOverride>
<cfelse>
	<cfset urlType = application.transferType>             
</cfif>

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

<cfset request.lisanswerfield = "">
<cfset request.SHOWCOMPAREAFTER = "">
<cfparam name="userMedications" default="#session.selectedDrugs#">  <!--  session.selectedDrugs -->
<cfparam name="strClient" default="#session.strClient#"> <!-- person  session.strClient -->
<cfparam name="med_receive" default="#session.med_receive#"> <!-- session.med_receive-->
<cfparam name="prg_list" default="#session.prg_list#"> <!--  session.prg_list -->
<cfparam name="subset_id" default="#session.subset_id#"><!-- session.subset_id-->
<cfset Session.WrapAroundDrugList = ""><!-- medicare card drugs -->

<!-- check if the user is receiving a state rx program -->
<cfif session.subset_id eq 27 or session.subset_id eq 39  >
    <cfif (isdefined('session.receive_partd') and session.receive_partd eq 'y') 
    	or ( isdefined('session.receive_lis') and session.receive_lis eq 'y' ) 
    	or ( isdefined('session.lis_apply') and session.lis_apply eq 'y' )>
    	<cfset session.medicare_receive = 'Y'>
	</cfif>
</cfif>

<cfif session.state_pharm_program neq 'Y'>
	<cfparam name="stateReceive" default="N">
<cfelse>
	<cfparam name="stateReceive" default="Y">
</cfif>

<cfparam name="medicare_receive" default="#session.medicare_receive#"><!-- receiving state program-->
<cfset FacilitatedEnrollList = "129-333-2605-FD-FD,XXX-319-1879-OH-ST,XXX-311-1588-RI-ST,XXX-311-1588-RI-ST">
<cfset AutoEnrollList = "XXX-311-1266-NY-ST,129-333-2615-FD-FD,117-311-1020-NJ-ST,129-333-2602-FD-FD,118-311-2575-NC-ST,XXX-311-1796-MI-ST,129-333-2620-FD-FD,XXX-311-1223-ME-ST,XXX-311-2261-MA-ST,129-333-2618-FD-FD,XXX-311-1520-CT-ST">
<cfif session.subset_id eq 18>
	<cfset stateProgramList = "">
<cfelse>
	<cfset stateProgramList = "AK,AZ,CA,HI,IA,OH,OR,WV,MN,PA,CT,FL,IL,IN,KS,MA,NV,NH,NJ,NY,RI,MO,MI,WI,WY,SC,ME,MD,NC,DE,VT">
</cfif>

<cfset hasStateProgram = "">
<cfset OtherOptionsCount = 0 >
<cfif listContains(stateProgramList, session.ST)>
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

<!-- Begin Recommendation Output -->
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
<cfif RxPrgList eq "" and ( #listcontains(session.prg_list,"XXX-331",",")# or #listcontains(session.prg_list,"132-332",",")# ) >
	<h2>Patient Assistance Program Recommendations</h2>
	<p>
		Apply for patient assistance programs offered by private pharmaceutical 
		companies to help you pay for your medicines. To find out which programs 
		you may qualify for and get the forms you will need to apply, click 
		<a href="frmeligibility.cfm?adj=1&src=rec&ReportType=PAP&cfid=#session.cfid#&cftoken=#session.cftoken#">here</a>.
	</p>

<cfelseif RxPrgList eq "" and session.prg_list eq "" and (session.subset_id eq 28)>
	<p>
		Thank you for taking the time to complete a BenefitsCheckUp screening 
		for Medicaid and Supplemental Security Income (SSI).  We've compared 
		your answers with the eligibility criteria for the Medicaid and Supplemental 
		Security Income (SSI) programs in your state.  Based on the answers you 
		provided, we currently have no programs to recommend to you.
	</p>
	
<cfelseif RxPrgList eq ""  and (session.subset_id eq 27  or session.subset_id eq 14  or session.subset_id eq 34 ) and not #listcontains(session.prg_list,"XXX-311",",")#  and not #listcontains(session.prg_list,"103-311-2593-FD-FD",",")# and not #listcontains(session.prg_list,"103-311-2588-FD-FD",",")#>

	<p>
		Thank you for taking the time to complete BenefitsCheckUpRx. We've compared 
		your answers with the eligibility criteria of many government programs that 
		provide substantial savings on the costs of health care and prescription drugs. 
		Based on the answers you provided, we currently have no programs to recommend 
		to you. We continually update our database with new programs and medications, 
		so please try again soon.
	</p>
	<p>
		For additional information, please contact the Eldercare Locator. This valuable 
		resource can provide you with assistance in finding state and local area agencies 
		on aging and community-based organizations that serve older adults and their 
		caregivers. You may find the information resources you need by visiting the 
		Eldercare Locator Web site at <a href="http://www.eldercare.gov/"  target="_blank">http://www.eldercare.gov/</a>, 
		or you may speak to an Eldercare Locator information specialist by calling 1-800-677-1116.
	</p>
	<p>
		There are other ways you can save money on prescription drugs. 
		Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.
	</p>
	<p>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information 
		you should know about prescription medications.
	</p>

<cfelseif RxPrgList eq "" and not #listcontains(session.prg_list,"XXX-311",",")#  and not #listcontains(session.prg_list,"103-311-2593-FD-FD",",")# and not #listcontains(session.prg_list,"103-311-2588-FD-FD",",")# >
	<p><strong>
		Thank you for taking the time to complete BenefitsCheckUpRx. We've compared your answers 
		with the eligibility criteria of many public and private programs that provide substantial 
		savings on the costs of prescription drugs.  Based on the answers you provided, we currently 
		have no programs to recommend to you. We continually update our database with new programs 
		and medications, so please try again soon.</strong>
	</p>
	<p><strong>
		For additional information, please contact the Eldercare Locator.  This valuable resource 
		can provide you with assistance in finding state and local area agencies on aging and 
		community-based organizations that serve older adults and their caregivers.  You may find 
		the information resources you need by visiting the Eldercare Locator Web site at 
		<a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a>, 
		or you may speak to an Eldercare Locator information specialist by calling 1-800-677-1116.</strong>
	</p>
	<p><strong>
		There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> 
		for additional information on saving money.</strong>
	</p>
	<p><strong>
		Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information 
		you should know about prescription medications.</strong>
	</p>
	
    <cfif (session.source_id eq 2 or session.source_id eq 3 or session.org_id gt 0) and session.partner_id neq 26>
        <cfparam name="attributes.fontFace" type="string" default="Arial, Helvetica, Verdana, sans-serif">
        <cfparam name="attributes.fontSize" type="numeric" default="8">
        <cfset fontStyle="font-family: #attributes.fontFace#; font-size: #attributes.fontSize#pt;">
        <cf_displayButton return_oe="true" name="print" style="#fontStyle#">
    </cfif>
    
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
	<a name="apply"></a><br>
	
	<cfif 1 eq 0>
		<form action="frmAccess.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#">
			<input type="submit" name="GetStarted" value="Make Decisions and Enroll Now">
			<input type="hidden" name="RxPrgList" value="#RxPrgList#">
		</form>
	</cfif>
	</cfoutput>
</cfif>

<cfif ((IsDefined('session.subset_id') and session.subset_id eq 22) 
	or url.ReportType eq 'All') and (( url.ReportType neq 'card') 
	and ( url.ReportType neq 'pap'))>

	<cfif listcontains(session.prg_list,"129-311-2526-FD-FD",",") 
		and session.subset_id neq 12 and session.subset_id neq 14 >

		<cfoutput>
			<h2>Medicare-Approved Drug Discount Card Recommendations</h2>
			<p>
				It is likely that you can save $150 or more on prescription drugs in 
				2005 by enrolling in a Medicare-approved discount card.  Click on this 
				link to get help choosing and enrolling in a Medicare-approved drug 
				discount card that will save you the most money.  By clicking the 
				recommendations link, you can apply online or get application forms. 
				To get your recommendations, click 
				<a href="frmRecommend.cfm?adj=1&src=rec&ReportType=Card&cfid=#session.cfid#&cftoken=#session.cftoken#">here</a>.
			</p>
		</cfoutput>
	</cfif>

	<cfif (#listcontains(session.prg_list,"XXX-331",",")# or #listcontains(session.prg_list,"132-332",",")# 
		or #listcontains(session.prg_list,"XXX-XXX-",",")#) and (#len(session.selecteddrugs)# gt 0) 
		and RxPrgList neq "" and session.subset_id neq 19 and session.subset_id neq 14  >

		<cfoutput>
			<h2>Patient Assistance Program Recommendations</h2>
			<p>
				Click on this link to find out about patient assistance programs 
				offered by private pharmaceutical companies to help you pay for your 
				medicines.  You will find out which programs you may qualify for and 
				get the forms you will need to apply.  To get your recommendations, 
				<a href="frmRecommend.cfm?adj=1&src=rec&ReportType=PAP&cfid=#session.cfid#&cftoken=#session.cftoken#">click here</a>.
			</p>
			<cfif session.subset_id eq 39>
				<ul>
					<cfif userMedications neq "null" >
						<cf_tagGetDrugListBullets strClient="#strClient#" selectedDrugs="#UserMedications#" >
					<cfelse>
						<li>
							<p>
								<cfoutput>Not taking any medications. 
									<cfif IsDefined('session.drugnumber')> 
										<em>(<a href="frmDrugList.cfm?shownumber=#session.drugnumber#&cfid=#session.cfid#&cftoken=#session.cftoken#">click here</a> to make corrections)</em>
									</cfif>
								</cfoutput>
							</p>
						</li>
					</cfif>
				</ul>
			</cfif>
		</cfoutput>
	</cfif>
</cfif>

<cfif session.subset_id eq 40>
	<cfset src = "turbo">
</cfif>

<cfif Not IsDefined('session.partner_id') Or session.partner_id neq 5>
	<cfif session.partner_id NEQ 22>
		<h2 id="recommendations_h2">Why did I get these recommendations?</h2>
		<p>
			To learn how BenefitsCheckUp works, 
			<cfoutput><a href="frmHowBCUWorks.cfm?ReportType=#url.ReportType#&CFID=#session.cfid#&CFTOKEN=#session.cftoken#&src=#src#">
			click here</a></cfoutput>.
	
		</p>
	</cfif>
	
	<cfif (not isdefined('session.org_id') or session.org_id eq 0) 
		and (isdefined('application.remotesurvey') and application.remotesurvey eq "y") 
		and session.partner_id neq 14 and session.partner_id neq 15 
		and (session.subset_id eq 14 or session.subset_id eq 39)>

			<h2>We need your help!</h2>
			<p>
				Please take a couple minutes to let us know if you found 
				BenefitsCheckUpRx helpful.  Click <a href="https://www.surveymonkey.com/s.asp?u=89851967273" target="_blank">here</a> 
				to complete a short Customer Satisfaction Survey. Thank you! 
			</p>
	</cfif>
	
	<h2>Comments</h2>
	<p>
		How has this service been helpful to you? How can we make it better? 
		Please take a moment to send your comments and suggestions to 
		<cfoutput><a href="mailto:#request.comments_address#">#request.comments_address#</a></cfoutput>.
	</p>
</cfif>

<cfif session.subset_id eq 27 and (session.partner_id eq 14 or session.partner_id eq 15)>
        <form action="http://mymedicarematters.org/People/Costs/extra_help_paying.asp" method="get" target="_top">
                <input type="submit" value="Return to My Medicare Matters">
        </form>
<cfelseif session.partner_id eq 14 or session.partner_id eq 15>
        <form action="http://www.mymedicarematters.org/" method="get" target="_top">
                <input type="submit" value="Return to My Medicare Matters">
        </form>
</cfif>

<cfif (session.source_id eq 2 or session.source_id eq 3 or session.org_id gt 0) and session.partner_id neq 26>
        <cf_buttons go="false" printText="Print This Page Now For Your Records">
        <cfparam name="attributes.fontFace" type="string" default="Arial, Helvetica, Verdana, sans-serif">
        <cfparam name="attributes.fontSize" type="numeric" default="8">
        <cfset fontStyle="font-family: #attributes.fontFace#; font-size: #attributes.fontSize#pt;">
        <cf_displayButton return_oe="true" name="print" style="#fontStyle#">
</cfif>

<cfif isdefined('session.client_id') and session.client_id neq 'null'>
    <cfoutput>
    <form action="#application.transferType#://#application.serverPathOE#/clientDetail.do?id=#session.client_id#" 
    	method="post" target="_top">
    	<input type="submit" value="Return to Client Detail">
    </form>
    </cfoutput>
</cfif>

<cfif session.citizen neq 'Citizen' and session.subset_id neq 12 and session.subset_id neq 14 >
        <cf_tagNonCitizen>
</cfif>

