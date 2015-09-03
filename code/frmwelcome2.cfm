<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>
<cfif IsDefined('URL.subset_id') AND URL.subset_id NEQ ''>
	<cfset SESSION.subset_id = URL.subset_id>
</cfif>
<cfif IsDefined('URL.partner_id') AND URL.partner_id NEQ ''>
	<cfset SESSION.partner_id = URL.partner_id>
</cfif>
<cfif IsDefined('URL.sc_partner_id') AND URL.sc_partner_id NEQ ''>
	<cfset SESSION.sc_partner_id = URL.sc_partner_id>
<cfelseif IsDefined ('SESSION.sc_partner_id')>
<!--- do nothing --->
<cfelse>
	<cfset SESSION.sc_partner_id = 0>
</cfif>

<!--- trying new CFC to load session vars... 
<cfset loadSessionVars = CreateObject("component","com.bcu.sessionLoadVars").init()>--->
<cf_handleScreening action="start" basics="true">
<cfparam name="session.cellpadding" default="">
<cfparam name="session.cellspacing" default="">
<!--- ###### TESTING THE NEW CFC FOR handleScreening ###### 
<cfset session.handledScr = createObject("component","com.bcu.screening.handleScreening").init(basics=true).startScreening()>
<cfset session.handleScreening.init(basics=true)>
<cfset session.handleScreening.startScreening()>--->

<!--- focus: bring window to front on open, if already open --->
<cfsavecontent variable="winFoc">
<script language="JavaScript1.1">
	<!--
		window.focus();
	// -->
</script>
</cfsavecontent>
<cfhtmlhead text="#winFoc#">
<!--- end focus --->
<cfset session.strongpath = CGI.SERVER_NAME>

<!--- Call header tag --->
<cfif session.subsetStateFlag eq 1>
	<cfset extraAF = ''>
<cfelse>
	<cfset extraAF = 's-st,y-pri_resident,'>
</cfif>
<cfif session.partner_id eq 81 or session.partner_id eq 61 or session.partner_id eq 63 or session.partner_id eq 102 or session.partner_id eq 115 or session.partner_id eq 68 or session.partner_id eq 85 or session.partner_id eq 75>
	<cfset extraAF = "o-pl_agency_list," & extraAF >
</cfif>
<cfif session.partner_id eq 47>
	<cfset extraAF = 'o-lisapp_org_humanarc,' & extraAF >
</cfif>
<cfif session.partner_id EQ 76>
	<cfset extraAF = 's-fit_last_name,s-fit_agency_id,' & extraAF>
</cfif>
<cfif SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77 >
	<cf_buildHTML onLoad="" show_title="yes" guts="frmwelcome2.cfm">
		
	<cfsavecontent variable="frmWel">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script> 
	<script type="text/javascript">
	$(document).ready(function() {
		var objrow = document.getElementById('client_other_question'); 
		if (document.formwelcome.client1.options[document.formwelcome.client1.selectedIndex].text == 'Other') {
			objrow.style.display = '';
			//document.formwelcome.aflist.value = 'o-client1-client,s-client_other,g-gender,<cfoutput>#extraAF#</cfoutput>s-zip';
		}
		//alert(document.formwelcome.aflist.value);
	});
	</script>
	</cfsavecontent>


	<cfhtmlhead text="#frmWel#">
	
	
	
	<cfoutput>
		<style>
			##pageTip{ top:0px !important;}
		</style>
		<div class="row survey">
			<div class="question">
				<div class="questionHolder questionBar">
					<div id="pageTip" class="helpTip">
                    	<h2><cf_displayText group="site" code="site_questionnaire_instructions_title"></h2>
                      	<p><cf_displayText group="site" code="site_questionnaire_instructions_body"></p>
						<cfif IsDefined('session.partner_id') And session.partner_id eq 6>
							<br /><br />
							<a href="javascript:help2('neededinfo-rx.cfm')">Click here</a> 
							to see if you need to gather any information before you begin.<br />
						</cfif>
					</div><!-- pageTip -->
				</div><!-- questionHolder -->
			</div><!-- question -->	
	
	
		<cfif SESSION.subset_id eq 39>
	        <h1>Find programs that can help pay for prescriptions!</h1>

		<cfelseif SESSION.subset_id eq 62>
	        <h1>Find programs that can help pay for food!</h1>
	    <cfelse>
			<h1>Find a full range of benefits that can help!</h1>
		</cfif>
		
		<cfif parameterExists(session.transferTypeCanonicalOverride)>
			<cfset urlType = session.transferTypeCanonicalOverride>
		<cfelse>
			<cfset urlType = application.transferType>		
		</cfif>
		
		<form action="frmquestions.cfm?partner_id=#session.partner_id#" 
			method="post" name="formwelcome" id="formwelcome" onsubmit="return validateWelcome()">
			<input type="hidden" name="cfid" value="#session.cfid#" />
			<input type="hidden" name="cftoken" value="#session.cftoken#" />
			
		<!---<cfif IsDefined('session.partner_id') And session.partner_id eq 5>
			<div class="question">
				<div class="questionHolder questionBar">
					<div id="pageTip" class="helpTip">
						<h2>Introduction to Public Programs</h2>
						<p>
							The public program section of the Long-Term Care Counselor (LTCC) 
							will help you to learn about your eligibility for public programs 
							that will help pay for long-term care services based on your financial 
							resources and the programs available in your state.
							<a href="javascript:help2('ltccinfo.cfm','')" class="helpTrigger helpButton">?</a> 
						</p>
						<p class="introRed">
				        	All responses are totally confidential. Your information is not saved 
				        	and you are not identified in any way. The questions are based on information
				        	experts in this area would need to know in order to advise you.
				        </p>
					</div><!-- pageTip -->
				</div><!-- questionHolder -->
			</div><!-- question -->
	
			
		<cfelseif session.subset_id eq 14>
			<div class="question">
				<div class="questionHolder questionBar">
					<div id="pageTip" class="helpTip">
						<h2>Instructions</h2>
						<p>
							The following questions are designed to help you assess your current situation, 
							and to figure out what benefits, rights and options you have, related to the new 
							Medicare Prescription Drug Coverage.  You will receive the most complete analysis
							and report if you answer all questions. Click the 
							<a href="##" class="helpTrigger helpButton">?</a> link if you need help 
							answering a question. Please do not click your browser&rsquo;s
							&quot;Back&quot; button while completing a screening, as your answers may not be saved. 
						</p>
					</div><!-- pageTip -->
				</div><!-- questionHolder -->
			</div><!-- question -->
		<cfelse>--->
			
			<div class="question">
				<div class="questionHolder questionBar">
					<p>
						We need to ask you some questions to help find programs that can save you money.
						When you are done you will get a report, fact sheets and applications for benefits 
						programs that may help pay some of your expenses.
					</p>
                    <cfparam name="preserve" type="boolean" default="false">
                    <cfif session.subset_id eq 1>
						<cfset neededURL = "neededinfo-rx.cfm">
                    <cfelseif session.subset_id eq 3>
                        <cfset neededURL = "neededinfo-3.cfm">	
                    <cfelseif session.subset_id eq 12>
                        <cfset neededURL = "neededinfo-card.cfm">
                    <cfelseif session.subset_id eq 14>
                        <cfset neededURL = "neededinfo-lis.cfm">
                    <cfelseif session.subset_id eq 18 or session.subset_id eq 22 Or (Not Preserve And session.subset_id eq 19)>
                        <cfset neededURL = "neededinfo-aoa.cfm">
                    <cfelseif session.subset_id eq 21>
                        <cfset neededURL = "neededinfo-il.cfm">
                    <cfelseif session.subset_id eq 27>
                        <cfset neededURL = "neededinfo-27.cfm">
                    <cfelseif session.subset_id eq 34>
                        <cfset neededURL = "neededinfo-wom.cfm">
                    <cfelseif session.subset_id eq 35>
                        <cfset neededURL = "neededinfo-35.cfm">
                    <cfelseif session.subset_id eq 36>
                        <cfset neededURL = "neededinfo-36.cfm">
                    <cfelseif session.subset_id eq 37>
                        <cfset neededURL = "neededinfo-37.cfm">
                    <cfelseif session.subset_id eq 38>
                        <cfset neededURL = "neededinfo-38.cfm">
                    <cfelseif session.subset_id eq 39>
                        <cfset neededURL = "neededinfo-39.cfm">
                    <cfelseif session.subset_id eq 44>
                        <cfset neededURL = "neededinfo-44.cfm">
                    <cfelseif session.subset_id eq 49>
                        <cfset neededURL = "neededinfo-49.cfm">
                    <cfelseif session.subset_id eq 49>
                        <cfset neededURL = "neededinfo-49.cfm">
                    <cfelseif session.subset_id eq 51>
                        <cfset neededURL = "neededinfo-51.cfm">
                    <cfelseif session.subset_id eq 57>
                        <cfset neededURL = "neededinfo-57.cfm">		
                    <cfelseif session.subset_id eq 59>
                        <cfset neededURL = "neededinfo-59.cfm">	
                    <!--- MH: 6/28/10 Bug 5476 --->
                    <cfelseif session.subset_id eq 62>
                        <cfset neededURL = "neededinfo-62.cfm">	
                    <cfelse>
                        <cfset neededURL = "neededinfo.cfm">
                    </cfif>
					<p>
						<cfoutput><a href="javascript:help2('#neededURL#')">See if you need to gather any information before you begin.</a></cfoutput>
					</p>
					<!---<p>
						You will receive the most complete report if you answer all questions.  
						It will take about 20 minutes.  Please do not click your &quot;Back&quot; button while 
						you are answering the questions, as your answers may not be saved. 
					</p>--->
					<h3>
						Let&rsquo;s get started.
					</h3>
				</div><!-- questionHolder -->
			</div><!-- question -->	
			
		<!---</cfif>--->
						
	</cfoutput>		
	
	
	
		<div class="question">
			<div class="questionHolder questionBar">
				<span class="question_number"><cf_showQuestionNumber>.</span> 
					<cf_displayText code="question_client" group="question"> 
					<cf_displayHelpLink code="client" textonly="TRUE">
					<p><cf_TagYeSetAnswerField answerfield="client" answerTYPE="opt" textlength="" validation=""></p>
					<p>
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="client_other" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = ''>
						</cfif>
					</p>
					<p id="client_other_question" style="display: none;">
						Please specify:&nbsp;&nbsp;
							<cfoutput>
								<input type="text" 
										name="client_other" size="15" maxlength="64" 
										value="#HTMLEditFormat(matchVal)#" onBlur="validatetext(this);">
							</cfoutput>
					</p>		
			</div><!-- questionHolder -->
		</div><!-- question -->	
		
		<div class="question">
			<div class="questionHolder questionBar">
				<p>
					<strong>Please note:</strong> If you are completing this for someone else, please answer all questions as if you are that person.
				</p>		
			</div><!-- questionHolder -->
		</div><!-- question -->	
		


				

		
		<div class="question">
			<div class="questionHolder questionBar">
				<span class="question_number"><cf_showQuestionNumber>.</span> 
				<p>Are you male or female?</p>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="gender" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = 0>
				</cfif>
					<p>
						<input bgcolor="white" type="radio" name="gender" value="m"<cfif matchVal eq 2> checked</cfif>> Male&nbsp;
						<input type="radio" name="gender" value="f"<cfif matchVal eq 3> checked</cfif>> Female
					</p>
			</div><!-- questionHolder -->
		</div><!-- question -->	
	
		<cfif session.subsetStateFlag neq 1>
			 <div class="question">
				<div class="questionHolder questionBar">
					<span class="question_number"><cf_showQuestionNumber>.</span> 
						<p>
							<cf_displayText code="question_st" group="question"> <cf_displayHelpLink code="st" textonly="TRUE">
						</p>
		
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="st" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = session.state_id>
						</cfif>
						<p>
							<cf_buildStateSelect name="st" required="true" showName="false" default="#matchVal#" style="">
						</p>
				</div><!-- questionHolder -->
			</div><!-- question -->	
	
			<div class="question">
				<div class="questionHolder questionBar">
					<span class="question_number"><cf_showQuestionNumber>.</span> 
						<p>
							<cf_displayText code="question_pri_resident" group="question"> <cf_displayHelpLink code="pri_resident" textonly="TRUE">
						</p>
						
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="pri_resident" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = -1>
						</cfif>	
						
						<p>
							<input type="radio" name="pri_resident" value="Y"<cfif matchVal Neq 0> checked</cfif> />Yes &nbsp;&nbsp;
							<input type="radio" name="pri_resident" value="N"<cfif matchVal Eq 0> checked</cfif> />No
						</p>
				</div><!-- questionHolder -->
			</div><!-- question -->	
		</cfif>
		
		<div class="question">
			<div class="questionHolder questionBar">
				<span class="question_number"><cf_showQuestionNumber>.</span>  
					<p><cf_displayText code="question_zip" group="question"></p>
			 
			   <cfif session.screening.prepopulate>
                            <cf_handleScreeningAnswerfield action="get" code="zip" element="pre" var="matchVal">
                        <cfelseif IsDefined('URL.preview_zip_62')>
                            <!--- Allow prepop for zip when origin is preview.bcu.org-->home subset 62--->
                            <cfset matchVal = '#URL.preview_zip_62#'>
                      	<cfelseif IsDefined('URL.preview_zip_39')>
                            <!--- Allow prepop for zip when origin is preview.bcu.org-->home subset 39--->
                            <cfset matchVal = '#URL.preview_zip_39#'>
                        <cfelse>
                            <cfset matchVal = ''>
                        </cfif>
			
					<p>
						<script language="javascript">
						<!-- //
							<cfoutput>var saveThisZip = '#matchVal#';</cfoutput>
							function zipValidJR(el){
								if (saveThisZip != el.value) {
									<!---alert('values have changed');--->
									if (!validatezip(el)) {
										<!---alert('zip was found invalid');--->
										saveThisZip = el.value;
										el.focus();
										el.select();
									}
								}
							}
						// -->
						</script>
						<cfoutput>
						    <input class="zip_code_input" type="text" name="zip" 
						    		size="5" maxlength="5" value="#matchVal#" onBlur="javascript:zipValidJR(this);" />
						</cfoutput>					
					</p>
			</div><!-- questionHolder -->
		</div><!-- question -->	
	
		<div id="surveyNav">
			<!---<h2>Keep up the good work. You've passed the midway point of the questionnaire.</h2>--->
			<p><div class="left"><input type="submit" value="  Next > " name="welcome" /></div></p> 
		</div>	
	<cfif session.partner_id eq 61 or session.partner_id eq 63 or session.partner_id eq 81 or session.partner_id eq 102 or session.partner_id eq 115 or session.partner_id eq 68 or session.partner_id eq 85 or session.partner_id eq 75>
            <cf_passScreeningInput aflist="o-client1-client,o-pl_agency_list,g-gender,s-zip">
        <cfelse>
            <cf_passScreeningInput aflist="o-client1-client,#extraAF#g-gender,s-zip">
        </cfif>
		</form>
	</div><!-- END <div class="row survey"> -->
	<!--- Call footer tag --->
	</cf_buildHTML>
<cfelse>

	<!--- PL Begins HERE --->
	<cf_buildHTML onLoad="" show_title="yes" guts="frmwelcome2.cfm">
<cfif session.subsetStateFlag eq 1>
	<cfset extraAF = ''>
<cfelse>
	<cfset extraAF = 's-st,y-pri_resident,'>
</cfif>
<cfif session.partner_id eq 81 or session.partner_id eq 61 or session.partner_id eq 63 or session.partner_id eq 102 or session.partner_id eq 115 or session.partner_id eq 63 or session.partner_id eq 85 or session.partner_id eq 75>
	<cfset extraAF = "o-pl_agency_list," & extraAF >
</cfif>
<cfif session.partner_id eq 47>
	<cfset extraAF = 'o-lisapp_org_humanarc,' & extraAF >
</cfif>
<cfif session.partner_id EQ 76>
	<cfset extraAF = 's-fit_last_name,s-fit_agency_id,' & extraAF>
</cfif>
	<cfsavecontent variable="frmWel">
	<script type="text/javascript">
	jQuery(document).ready(function(){
		var objrow = document.getElementById('client_other_question'); 
		if (document.formwelcome.client1.options[document.formwelcome.client1.selectedIndex].text == 'Other') {
			objrow.style.display = '';
			//document.formwelcome.aflist.value = 'o-client1-client,s-client_other,g-gender,<cfoutput>#extraAF#</cfoutput>s-zip';
		}
		//alert(document.formwelcome.aflist.value);
	});
	</script>
	</cfsavecontent>
	<cfhtmlhead text="#frmWel#">
	
	<cfoutput>
		<table width="100%" border="0" align="center" cellpadding="#session.cellpadding#" cellspacing="#session.cellspacing#">
	    <tbody>
			<tr>
				<td bgcolor="##FFFFFF" colspan="2" style="padding: 0px 12px 12px 12px;">
					<!--Dynamic Area-->
	                <font face="arial" size="4" color="##000000">
					<cfif parameterExists(session.transferTypeCanonicalOverride)>
						<cfset urlType = session.transferTypeCanonicalOverride>
					<cfelse>
						<cfset urlType = application.transferType>		
					</cfif>
					<form action="frmquestions.cfm" method="post" name="formwelcome" id="formwelcome" onsubmit="return validateWelcome()">
						<input type="hidden" name="cfid" value="#session.cfid#" />
						<input type="hidden" name="cftoken" value="#session.cftoken#" />
						<span class="screeningInstructionText"><b>INSTRUCTIONS</b><br />
                            The following questions are designed to determine your potential eligibility for benefits programs.  You will receive 
                            the most complete benefits report if you answer all questions.  Click the <font size="2"><u>HELP</u></font> link if you 
                            need help answering a question. Please do not click your browser's "Back" button while completing a screening, as your 
                            answers may not be saved.</span>
                            <p class="text1"></p>
                        <cfif IsDefined('session.partner_id') AND session.partner_id EQ 22 AND (IsDefined('session.subset_id') AND (SESSION.subset_id EQ 49 OR SESSION.subset_id EQ 19 OR SESSION.subset_id EQ 68 OR SESSION.subset_id EQ 70))>
                            <cfoutput>
                                <cfset neededURL = "neededinfo-#Trim(SESSION.subset_id)#.cfm">
                                <cfset whatithelpsURL = "whatithelps.cfm?id=#Trim(SESSION.subset_id)#">
                            </cfoutput>	
                            <cfoutput>
                                <a class="text1" href="javascript:help2('#neededURL#')">See if you need to gather any information before you begin.</a><BR />
                                <a class="text1" href="javascript:help2('#whatithelpsURL#')">See what benefit programs are included in this questionnaire.</a>										 								</cfoutput>
                            <p class="text1"></p>
                    	</cfif>
						<table align="center" border="0" cellpadding="2" cellspacing="2" width="100%" class="text1">
	</cfoutput>
							<tr>
								<td WIDTH="35" valign="top">
									<font face="arial"><b><cf_showQuestionNumber>.</b></font>
								</td>
								<td valign="top">
									<font face="arial"><cf_displayText code="question_client" group="question"> <cf_displayHelpLink code="client"></font>
								</td>
							</tr>
							<cf_TagYeSetAnswerField answerfield="client" answerTYPE="opt" textlength="" validation="">
							<tr valign="top" id="client_other_question" style="display: none;">
								<td></td>
								<td>
									<cfif session.screening.prepopulate>
										<cf_handleScreeningAnswerfield action="get" code="client_other" element="pre" var="matchVal">
									<cfelse>
										<cfset matchVal = ''>
									</cfif>
									<font face="arial">Please specify:&nbsp;&nbsp;
										<cfoutput>
	                                    	<input type="text" name="client_other" size="15" maxlength="64" value="#HTMLEditFormat(matchVal)#" onBlur="validatetext(this);">
										</cfoutput>
	                                </font>
								</td>
							</tr>
<cfif session.partner_id neq 14>

							<tr><td>&nbsp;</td></tr>
</cfif>
                            <tr>
								<td></td>
								<td valign="top">
									<font face="arial">
	                                	<b>Please note:</b>&nbsp; If you are completing this for someone else, please answer all questions as if you are that person.
	                                </font>
								</td>
							</tr>
							<tr><td></td></tr>
                            <cfif session.partner_id IS 76>
								<tr>
									<td width="35" valign="top">
										<font face="arial"><b><cf_showQuestionNumber>.</b></font>
									</td>
									<td valign="top">
										<font face="arial"><cf_displayText code="question_fit_last_name_2" group="question"></font>
									</td>
								</tr>
								<tr>
									<td></td>
									<td>
										<font face="arial"><cf_buildAnswerfield name="fit_last_name" format="text_hide" type="text"></font>
	                                </td>
	                            </tr>
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td width="35" valign="top">
										<font face="arial"><b><cf_showQuestionNumber>.</b></font>
									</td>
									<td valign="top">
										<font face="arial"><cf_displayText code="question_fit_agency_id_2" group="question"></font>
									</td>
								</tr>
                                <cfif session.screening.prepopulate>
                                    <cf_handleScreeningAnswerfield action="get" code="fit_agency_id" element="pre" var="matchVal">
                                <cfelse>
                                    <cfset matchVal = "">
                                </cfif>
								<tr>
									<td></td>
									<td>
										<cfoutput><font face="arial"><cf_buildAnswerfield name="fit_agency_id" format="text_hide" type="text" maxlength="4" matchval="#matchVal#"></font></cfoutput>
	                                </td>
	                            </tr>
								<tr><td>&nbsp;</td></tr>
                               <tr>
									<td width="35" valign="top">
										<font face="arial"><b><cf_showQuestionNumber>.</b></font>
									</td>
									<td valign="top">
										<font face="arial">What type of Reverse Mortgage Counseling session are you conducting?</font>
									</td>
								</tr>
                                <cfif session.screening.prepopulate>
                                    <cf_handleScreeningAnswerfield action="get" code="fit_counseling_session_type" element="pre" var="matchVal">
                                <cfelse>
                                    <cfset matchVal = "">
                                </cfif>
								<tr>
									<td></td>
									<td>
										<font face="arial"><select name="fit_counseling_session_type">
                                        <option value="" >-- Select one --</option>
                                        <option value="2555-fit_traditional" <cfif matchVal eq 2555>selected</cfif>> Traditional (clients seeking a new reverse mortgage) </option>
                                        <option value="2556-fit_default" <cfif matchVal eq 2556>selected</cfif>> Default (borrowers who are behind in property taxes/insurance)</option>
                                        </select></font>
	                                </td>
	                            </tr>
								<tr><td>&nbsp;</td></tr>
                               	 
							</cfif>	
		
							<!-- Human ARC health plan enrollment question -->
							<cfif session.partner_id eq 47>
								<tr>
									<td width="35" valign="top">
										<font face="arial"><b><cf_showQuestionNumber>.</b></font>
									</td>
									<td valign="top">
										<font face="arial">Please select the health plan the applicant is currently enrolled in?</font>
									</td>
								</tr>
								<tr>
									<td></td>
									<td>
										<font face="arial">				
											<cfif session.screening.prepopulate>
												<cf_handleScreeningAnswerfield action="get" code="lisapp_org_humanarc" element="pre" var="matchVal">
											<cfelse>
												<cfset matchVal = 0>
											</cfif>
											<cf_TagYeWhiteSpace>	
	                                        <select name="lisapp_org_humanarc">
	                                            <option value="" >-- Select one --</option>
	                                            <option value="2433-hc_healthplan_anthem" <cfif matchVal eq 2433>selected</cfif> > Anthem </option>
	                                            <option value="2434-hc_healthplan_bluecrossofca" <cfif matchVal eq 2434>selected</cfif>> Blue Cross of CA </option>
							  <option value="3485-hc_healthplan_bravo" <cfif matchVal eq 3485>selected</cfif>> BRAVO </option>
	                                            <option value="2405-hc_healthplan_cdphp" <cfif matchVal eq 2405>selected</cfif>> CDPHP </option>
	                                            <option value="2406-hc_healthplan_cigna" <cfif matchVal eq 2436>selected</cfif>> CIGNA </option>
			           <option value="2500-hc_health_plan_community_ccrx" <cfif matchVal eq 2500>selected</cfif>> Community CCRX </option>
			           <option value="2474-hc_healthplan_elderplan" <cfif matchVal eq 2474>selected</cfif>>Elderplan </option>
	                                            <option value="2407-hc_healthplan_flhealthcareplan" <cfif matchVal eq 2407>selected</cfif>> Florida Health Care Plan </option>
	                                            <option value="2408-hc_healthplan_gateway" <cfif matchVal eq 2408>selected</cfif>> Gateway </option>
	                                            <option value="2409-hc_healthplan_globalhealth" <cfif matchVal eq 2409>selected</cfif>> Global Health </option>
	                                            <option value="2410-hc_healthplan_healthallianceplan" <cfif matchVal eq 2410>selected</cfif>> Health Alliance Plan of MI </option>
			           <option value="2473-hc_healthplan_healthspring" <cfif matchVal eq 2473>selected</cfif>> HealthSpring </option>
	                                            <option value="2411-hc_healthplan_heritagehealth" <cfif matchVal eq 2411>selected</cfif>> Heritage Health </option>
	                                            <option value="2412-hc_healthplan_highmark" <cfif matchVal eq 2412>selected</cfif>> Highmark </option>
	                                            <option value="2431-hc_healthplan_hometown_nv" <cfif matchVal eq 2431>selected</cfif>> Hometown NV </option>
	                                            <option value="2430-hc_healthplan_hometown_oh" <cfif matchVal eq 2430>selected</cfif>> Hometown OH </option>
	                                            <option value="2414-hc_healthplan_horizonbcbsnj" <cfif matchVal eq 2414>selected</cfif>> Horizon BCBS of NJ </option>
	                                            <option value="2401-lisapp_org_humanarc"        <cfif matchVal eq 2401>selected</cfif>>  Human Arc </option>
	                                            <option value="2415-hc_healthplan_intervalley" <cfif matchVal eq 2415>selected</cfif>> Inter Valley </option>
			           <option value="2472-hc_healthplan_kelseycare" <cfif matchVal eq 2472>selected</cfif>> KelseyCare</option>
	                                            <option value="2416-hc_healthplan_memberhealth" <cfif matchVal eq 2416>selected</cfif>> MemberHealth </option>
	                                            <option value="2417-hc_healthplan_mercyhealthplan" <cfif matchVal eq 2417>selected</cfif>> Mercy Health Plan </option>
	                                            <option value="2419-hc_healthplan_mtcarmel" <cfif matchVal eq 2419>selected</cfif>> Mt. Carmel </option>
	                                            <option value="2418-hc_healthplan_mtnstbcbshighmark" <cfif matchVal eq 2418>selected</cfif>> Mountain St. BCBS, (Highmark) </option>
	                                            <option value="2421-hc_healthplan_prefcarepartners" <cfif matchVal eq 2421>selected</cfif>> Preferred Care Partners </option>
	                                            <option value="2420-hc_healthplan_preferredcaremvphc" <cfif matchVal eq 2420>selected</cfif>> Preferred Care/MVP Healthcare </option>
			           <option value="2422-hc_healthplan_prescrippathways" <cfif matchVal eq 2422>selected</cfif>> Prescription Pathways </option>
	                                            <option value="2501-hc_healthplan_prescribarx" <cfif matchVal eq 2501>selected</cfif>>PrescribaRx </option>
	                                            <option value="2423-hc_healthplan_primetime" <cfif matchVal eq 2423>selected</cfif>> PrimeTime </option>
	                                            <option value="2424-hc_healthplan_scan" <cfif matchVal eq 2424>selected</cfif>> SCAN </option>
	                                            <option value="2425-hc_healthplan_selectcareheritage" <cfif matchVal eq 2425>selected</cfif>> SelectCare (Heritage Health) </option>
	                                            <option value="2426-hc_healthplan_summacare" <cfif matchVal eq 2426>selected</cfif>> SummaCare </option>
				    <option value="2471-hc_healthplan_todaysoptions" <cfif matchVal eq 2471>selected</cfif>> Today's Options </option>
				    		            <option value="2557-hc_healthplan_united_healthcare" <cfif matchVal eq 2557>selected</cfif>> United Health Group </option>
	                                            <option value="2427-hc_healthplan_thehealthplan" <cfif matchVal eq 2427>selected</cfif>> The Health Plan </option>
	                                            <option value="2428-hc_healthplan_upmc" <cfif matchVal eq 2428>selected</cfif>> UPMC </option>
	                                            <option value="2432-hc_healthplan_vangent" <cfif matchVal eq 2432>selected</cfif>> Vangent </option>
	                                            <option value="2429-hc_healthplan_viva" <cfif matchVal eq 2429>selected</cfif>> VIVA </option>
			       			     <option value="2476-none_of_the_above" <cfif matchVal eq 2476>selected</cfif>> None of the above </option>
	                                        </select>
	                                    </font>
	                                </td>
	                            </tr>
								<tr><td></td></tr>
							</cfif>
		         <!-- Chicago agency question -->
							<cfif session.partner_id eq 81 and (1 eq 0)>
								<tr>
									<td width="35" valign="top">
										<font face="arial"><b><cf_showQuestionNumber>.</b></font>
									</td>
									<td valign="top">
										<font face="arial">If you are working with an agency, please select the agency from the list.  If your agency is not listed or you are completing the questionnaire on your own, choose <b>none of the above.</b> 
								</font>
									</td>
								</tr>
								<tr>
									<td></td>
									<td>
										<font face="arial">				
											<cfif session.screening.prepopulate >
												<cf_handleScreeningAnswerfield action="get" code="pl_agency_list" element="pre" var="matchVal">
											<cfelse>
												<cfset matchVal = 0>
											</cfif>
											<cf_TagYeWhiteSpace>	
	                                        <select name="pl_agency_list">
	                                            <option value="" >-- Select one --</option>
	                                            <option value="2545-chicago_agency_alivio" <cfif matchVal eq 2545>selected</cfif>> Alivio Medical Center </option>
			           <option value="2546-chicago_agency_asian_comm_agency" <cfif matchVal eq 2546>selected</cfif>> Asian Community Agencies</option>
			            <option value="2547-chicago_agency_central_west" <cfif matchVal eq 2547>selected</cfif>> Central West Senior Center </option>
			            <option value="2548-chicago_agency_chicago_com_trust" <cfif matchVal eq 2548>selected</cfif>> Chicago Community Trust </option>
			            <option value="2549-chicago_agency_cdfss" <cfif matchVal eq 2549>selected</cfif>> Chicago Department Of Family & Support Service </option>
			            <option value="2550-chicago_agency_ne_levy" <cfif matchVal eq 2550>selected</cfif>> Northeast (Levy) Senior Center </option>
			            <option value="2551-chicago_agency_nw_copernicus" <cfif matchVal eq 2551>selected</cfif>> Northwest (Copernicus) Senior Center </option>
			            <option value="2552-chicago_agency_rsc_cha" <cfif matchVal eq 2552>selected</cfif>> Resident Service Coordinators (Chicago Housing Authority) </option>
			            <option value="2553-go_agency_se_atlas" <cfif matchVal eq 2553>selected</cfif>> Southeast (Atlas) Senior Center </option>
			            <option value="2554-chicago_agency_sw" <cfif matchVal eq 2554>selected</cfif>> Southwest Senior Center </option>
		                            <option value="2476-none_of_the_above" <cfif matchVal eq 2476>selected</cfif>> None of the above </option>
	                                        </select>
	                                    </font>
	                                </td>
	                            </tr>
								<tr><td></td></tr>
							</cfif>
	<!-- pl_agency_list agency question -->
							<cfif session.partner_id eq 61 or session.partner_id eq 63 or session.partner_id eq 81 or session.partner_id eq 102 or session.partner_id eq 115 or session.partner_id eq 68 or session.partner_id eq 85 or session.partner_id eq 75>
								<tr>
									<td width="35" valign="top">
										<font face="arial"><b><cf_showQuestionNumber>.</b></font>
									</td>
									<td valign="top">
										<font face="arial">If you are working with an agency, please select the agency from the list. If your agency is not listed or you are completing the questionnaire on your own, choose <b>none of the above.</b> 
								</font>
									</td>
								</tr>
								<tr>
									<td></td>
									<td>
										<font face="arial">				
											<cfif session.screening.prepopulate >
												<cf_handleScreeningAnswerfield action="get" code="pl_agency_list" element="pre" var="matchVal">
											<cfelse>
												<cfset matchVal = 0>
											</cfif>
                                            <cf_TagYeWhiteSpace>	
	                                        <select name="pl_agency_list">
	                                            <option value="" >-- Select one --</option>
	<cfif session.partner_id eq 61>
	<option value="2571-ageoptions_agency_ageoptions" <cfif matchVal eq 2571>selected</cfif>> AgeOptions </option> 
	<option value="2572-ageoptions_agency_aging_care_con" <cfif matchVal eq 2572>selected</cfif>> Aging Care Connections </option> 
	<option value="2573-ageoptions_agency_catholic_chari" <cfif matchVal eq 2573>selected</cfif>> Catholic Charities Northwest </option> 
	<option value="2574-ageoptions_agency_kenneth_young" <cfif matchVal eq 2574>selected</cfif>> Kenneth Young Center </option> 
	<option value="2575-ageoptions_agency_nssc" <cfif matchVal eq 2575>selected</cfif>> North Shore Senior Center </option> 
	<option value="2576-ageoptions_agency_oak_park_tss" <cfif matchVal eq 2576>selected</cfif>> Oak Park Township Senior Services </option> 
	<option value="2577-ageoptions_agency_plows" <cfif matchVal eq 2577>selected</cfif>> PLOWS Council on Aging </option> 
	<option value="2578-ageoptions_agency_solutions_care" <cfif matchVal eq 2578>selected</cfif>> Solutions for Care </option> 
	<option value="2579-ageoptions_agency_sssscc" <cfif matchVal eq 2579>selected</cfif>> South Suburban Senior Services of Catholic Charities </option> 
	<option value="2580-ageoptions_agency_stickney" <cfif matchVal eq 2580>selected</cfif>> Stickney Township Office on Aging </option> 
	<option value="2581-ageoptions_agency_west_suburban" <cfif matchVal eq 2581>selected</cfif>> West Suburban Senior Services </option> 
        	<option value="2582-pl_agency_none_of_the_above" <cfif matchVal eq 2582>selected</cfif>> None of the above </option>
	<cfelseif session.partner_id eq 81>
	<option value="2545-chicago_agency_alivio" <cfif matchVal eq 2545>selected</cfif>> Alivio Medical Center </option> 
	<option value="2546-chicago_agency_asian_comm_agency" <cfif matchVal eq 2546>selected</cfif>> Asian Community Agencies </option> 
	<option value="2549-chicago_agency_cdfss" <cfif matchVal eq 2549>selected</cfif>> Department Of Family & Support Service </option> 
	<option value="2547-chicago_agency_central_west" <cfif matchVal eq 2547>selected</cfif>> Central West Senior Center </option> 
	<option value="2548-chicago_agency_chicago_com_trust" <cfif matchVal eq 2548>selected</cfif>> Chicago Community Trust </option> 
	<option value="2550-chicago_agency_ne_levy" <cfif matchVal eq 2550>selected</cfif>> Northeast (Levy) Senior Center </option> 
	<option value="2551-chicago_agency_nw_copernicus" <cfif matchVal eq 2551>selected</cfif>> Northwest (Copernicus) Senior Center </option> 
	<option value="2552-chicago_agency_rsc_cha" <cfif matchVal eq 2552>selected</cfif>> Resident Service Coordinators (Chicago Housing Authority) </option> 
	<option value="2553-chicago_agency_se_atlas" <cfif matchVal eq 2553>selected</cfif>> Southeast (Atlas) Senior Center </option> 
	<option value="2554-chicago_agency_sw" <cfif matchVal eq 2554>selected</cfif>> Southwest Senior Center </option> 
	<option value="2582-pl_agency_none_of_the_above" <cfif matchVal eq 2582>selected</cfif>> None of the above </option>
	<cfelseif session.partner_id eq 63>
	<option value="2559-western_reserve_agency_asia" <cfif matchVal eq 2559>selected</cfif>> Asian Services in Action (ASIA) </option> 
	<option value="2560-western_reserve_agency_bria" <cfif matchVal eq 2560>selected</cfif>> Benjamin Rose Institute on Aging (BRIA) </option> 
	<option value="2561-western_reserve_agency_cleveland" <cfif matchVal eq 2561>selected</cfif>> Cleveland Department of Aging </option> 
	<option value="2562-western_reserve_agency_dsas" <cfif matchVal eq 2562>selected</cfif>> Cuyahoga County Department of Senior and Adult Services (DSAS) </option> 
	<option value="2563-western_reserve_agency_fairhill" <cfif matchVal eq 2563>selected</cfif>> Fairhill Partners </option> 
	<option value="2564-western_reserve_agency_geauga" <cfif matchVal eq 2564>selected</cfif>> Geauga County Department on Aging </option> 
	<option value="2565-western_reserve_agency_lake" <cfif matchVal eq 2565>selected</cfif>> Lake County Council on Aging </option> 
	<option value="2567-western_reserve_agency_leap" <cfif matchVal eq 2567>selected</cfif>> LEAP </option> 
	<option value="2566-western_reserve_agency_lorain" <cfif matchVal eq 2566>selected</cfif>> Lorain County Office on Aging </option> 
	<option value="2568-western_reserve_agency_medina" <cfif matchVal eq 2568>selected</cfif>> Medina County Office of Older Adults </option> 
	<option value="2569-western_reserve_agency_metro" <cfif matchVal eq 2569>selected</cfif>> MetroHealth Advantage </option> 
		<option value="2582-pl_agency_none_of_the_above" <cfif matchVal eq 2582>selected</cfif>> None of the above </option>
	<cfelseif session.partner_id eq 68>
	<option value="3510-adrc_agency_adss" <cfif matchVal eq 3510>selected</cfif>> Alabama Department of Senior Services </option> 
	<option value="3511-adrc_agency_al_tombigbee_regiona" <cfif matchVal eq 3511>selected</cfif>> Alabama-Tombigbee  Regional Commission </option> 
	<option value="3512-adrc_agency_central_al_aging_co" <cfif matchVal eq 3512>selected</cfif>> Central Alabama Aging Consortium </option> 
	<option value="3513-adrc_agency_east_al_regional_com" <cfif matchVal eq 3513>selected</cfif>> East Alabama Regional Planning and Development Commission </option> 
	<option value="3514-adrc_agency_jefferson_co_sen_cit" <cfif matchVal eq 3514>selected</cfif>> Jefferson County Office of Senior Citizens </option> 
	<option value="3515-adrc_agency_lee_russel_council" <cfif matchVal eq 3515>selected</cfif>> Lee-Russell Council of Governments </option> 
	<option value="3516-adrc_agency_middle_al_aaa" <cfif matchVal eq 3516>selected</cfif>> Middle Alabama Area Agency on Aging </option> 
	<option value="3517-adrc_agency_nc_al_regional_counc" <cfif matchVal eq 3517>selected</cfif>> North Central Alabama Regional Councils of Governments </option> 
	<option value="3518-adrc_agency_nw_al_council_govt" <cfif matchVal eq 3518>selected</cfif>> Northwest Alabama Council of Governments </option> 
	<option value="3519-adrc_agency_south_al_region_comm" <cfif matchVal eq 3519>selected</cfif>> South Alabama Regional Planning Commission </option> 
	<option value="3520-adrc_agency_sc_al_dev_commission" <cfif matchVal eq 3520>selected</cfif>> South Central Alabama Development Commission </option> 
	<option value="3521-adrc_agency_southern_al_council" <cfif matchVal eq 3521>selected</cfif>> Southern Alabama Regional Council on Aging </option> 
	<option value="3522-adrc_agency_tarcog" <cfif matchVal eq 3522>selected</cfif>> Top of Alabama Regional Council on Governments </option> 
	<option value="3523-adrc_agency_west_al_region_comm" <cfif matchVal eq 3523>selected</cfif>> West Alabama Regional Commission </option> 
	<option value="2582-pl_agency_none_of_the_above" <cfif matchVal eq 2582>selected</cfif>> None of the above </option> 
	<cfelseif session.partner_id eq 75>
	<option value="3529-oklahoma_ability_resources" <cfif matchVal eq 3529>selected</cfif>> 	Ability Resources	 </option> 
<option value="3527-oklahoma_areawide_aaa" <cfif matchVal eq 3527>selected</cfif>> 	Areawide Agency on Aging	 </option> 
<option value="3528-oklahoma_assoc_south_central" <cfif matchVal eq 3528>selected</cfif>> 	Association of South Central Oklahoma Governments	 </option> 
<option value="3531-oklahoma_central_ok_econ_dev" <cfif matchVal eq 3531>selected</cfif>> 	Central Oklahoma Economic Development District	 </option> 
<option value="3535-oklahoma_eastern_ok_dev" <cfif matchVal eq 3535>selected</cfif>> 	Eastern Oklahoma Development District	 </option> 
<option value="3537-oklahoma_grand_gateway_aaa" <cfif matchVal eq 3537>selected</cfif>> 	Grand Gateway AAA	 </option> 
<option value="3538-oklahoma_great_plains_improve" <cfif matchVal eq 3538>selected</cfif>> 	Great Plains Improvement Foundation	 </option> 
<option value="3591-oklahoma_heartline" <cfif matchVal eq 3591>selected</cfif>>  Heartline	 </option> 
<option value="3539-oklahoma_inca_community" <cfif matchVal eq 3539>selected</cfif>> 	INCA Community Services	 </option> 
<option value="3540-oklahoma_indian_health" <cfif matchVal eq 3540>selected</cfif>> 	Indian Health Services	 </option> 
<option value="3541-oklahoma_indian_nation_council" <cfif matchVal eq 3541>selected</cfif>> 	Indian Nation Council of Governments	 </option> 
<option value="3542-oklahoma_kiamichi_econ_dev" <cfif matchVal eq 3542>selected</cfif>> 	Kiamichi Economic Development District of Oklahoma	 </option> 
<option value="3543-oklahoma_ki_bois_caa" <cfif matchVal eq 3543>selected</cfif>> 	KI BOIS Community Action Foundation, Inc.	 </option> 
<option value="3544-oklahoma_life_senior" <cfif matchVal eq 3544>selected</cfif>> 	LIFE Senior Services	 </option> 
<option value="3559-oklahoma_ltc_authority_enid" <cfif matchVal eq 3559>selected</cfif>> 	Long Term Care Authority of Enid	 </option> 
<option value="3545-oklahoma_north_rock" <cfif matchVal eq 3535>selected</cfif>> 	North Rock	 </option> 
<option value="3548-oklahoma_ok_economic_dev" <cfif matchVal eq 3548>selected</cfif>> 	Oklahoma Economic Development Authority	 </option> 
<option value="3549-oklahoma_ok_medicare_assist" <cfif matchVal eq 3549>selected</cfif>> 	Oklahoma Medicare Assistance Program	 </option> 
<option value="3551-oklahoma_opportunities_inc" <cfif matchVal eq 3551>selected</cfif>> 	Opportunities, Inc.	 </option> 
<option value="3554-oklahoma_southern_ok_dev" <cfif matchVal eq 3554>selected</cfif>> 	Southern Oklahoma Development Association	 </option> 
<option value="3555-oklahoma_southwest_ok_caa" <cfif matchVal eq 3555>selected</cfif>> 	Southwest Oklahoma Community Action Group	 </option> 
<option value="3556-oklahoma_southwest_ok_dev" <cfif matchVal eq 3556>selected</cfif>> 	Southwest Oklahoma Development Authority	 </option> 
<option value="3558-oklahoma_woodward_senior_cntr" <cfif matchVal eq 3558>selected</cfif>> 	Woodward Senior Center </option> 
	
	<option value="2582-pl_agency_none_of_the_above" <cfif matchVal eq 2582>selected</cfif>> None of the above </option>
	<cfelseif session.partner_id eq 85>
	<option value="3494-ccses_agency_alpine_aaa" <cfif matchVal eq 3494>selected</cfif>> Alpine Area Agency on Aging </option> 
	<option value="3495-ccses_agency_assoc_govt_nw_co" <cfif matchVal eq 3495>selected</cfif>> Associated Governments of Northwest Colorado </option> 
	<option value="3496-ccses_agency_boulder_aging_svcs" <cfif matchVal eq 3496>selected</cfif>> Boulder County Aging Services Division </option> 
	<option value="3497-ccses_agency_denver_council_aaa" <cfif matchVal eq 3497>selected</cfif>> Denver Regional Council of Governments Area Agency on Aging </option> 
	<option value="3498-ccses_agency_east_central_govt" <cfif matchVal eq 3498>selected</cfif>> East Central Council of Governments </option> 
	<option value="3499-ccses_agency_huerfano_las_animas" <cfif matchVal eq 3499>selected</cfif>> Huerfano/Las Animas Area Council of Governments </option> 
	<option value="3500-ccses_agency_larimer_aging" <cfif matchVal eq 3500>selected</cfif>> Larimer County Office on Aging </option> 
	<option value="3501-ccses_agency_lower_ar_valley_aaa" <cfif matchVal eq 3501>selected</cfif>> Lower Arkansas Valley Area Agency on Aging </option> 
	<option value="3502-ccses_agency_ne_co_assoc_govt" <cfif matchVal eq 3502>selected</cfif>> Northeastern Colorado Association of Local Government </option> 
	<option value="3503-ccses_agency_pikes_peak_aaa" <cfif matchVal eq 3503>selected</cfif>> Pikes Peak Area Agency on Aging </option> 
	<option value="3504-ccses_agency_pueblo_aaa" <cfif matchVal eq 3504>selected</cfif>> Pueblo Area Agency on Aging </option> 
	<option value="3505-ccses_agency_region_10_aaa" <cfif matchVal eq 3505>selected</cfif>>  Region 10 Area Agency on Aging </option> 
	<option value="3506-ccses_agency_san_juan_basin_aaa" <cfif matchVal eq 3506>selected</cfif>> San Juan Basin Area Agency on Aging </option> 
	<option value="3507-ccses_agency_sc_co_seniors_inc" <cfif matchVal eq 3507>selected</cfif>> South Central Colorado Seniors, Inc. </option> 
	<option value="3508-ccses_agency_upper_ar_aaa" <cfif matchVal eq 3508>selected</cfif>> Upper Arkansas Area Agency on Aging </option> 
	<option value="3509-ccses_agency_weld_county_aaa" <cfif matchVal eq 3509>selected</cfif>> Weld County Area Agency on Aging </option> 
	<option value="2582-pl_agency_none_of_the_above" <cfif matchVal eq 2582>selected</cfif>> None of the above </option>
	<cfelseif session.partner_id eq 102>
<option value="3560-nisc_agency_aging_partners" <cfif matchVal eq 3560>selected</cfif>> Aging Partners	</option> 
<option value="3493-nisc_agency_alicia_trevino" <cfif matchVal eq 3493>selected</cfif>> Alicia Trevino Senior One-Stop Center	</option> 
<option value="3561-nisc_agency_care_connection" <cfif matchVal eq 3561>selected</cfif>> Care Connection for Aging Services	</option> 
<option value="3562-nisc_agency_catholic_healthcare" <cfif matchVal eq 3562>selected</cfif>> Catholic Health Care Services	</option> 
<option value="3563-nisc_agency_center_in_park" <cfif matchVal eq 3563>selected</cfif>> Center in the Park	</option> 
<option value="3564-nisc_agency_chinese_info_svcs" <cfif matchVal eq 3564>selected</cfif>> Chinese Information and Service Center	</option> 
<option value="3486-nisc_agency_clinton_senior_cent" <cfif matchVal eq 3486>selected</cfif>> Clinton Senior Center	</option> 
<option value="3565-nisc_agency_davidson_co_senior" <cfif matchVal eq 3565>selected</cfif>> Davidson County Senior Services	</option> 
<option value="3566-nisc_agency_east_valley_resource" <cfif matchVal eq 3566>selected</cfif>> East Valley Adult Resources	</option> 
<option value="3487-nisc_agency_gem_county" <cfif matchVal eq 3487>selected</cfif>> Gem County Senior/Community Center	</option> 
<option value="3567-nisc_agency_grafton_co_senior" <cfif matchVal eq 3567>selected</cfif>> Grafton County Senior Citizens Council, Inc.	</option> 
<option value="3488-nisc_agency_groton_senior_center" <cfif matchVal eq 3488>selected</cfif>> Groton Senior Center	</option> 
<option value="3568-nisc_agency_hanover_senior_svcs" <cfif matchVal eq 3568>selected</cfif>> Hanover Township Senior Services	</option> 
<option value="3489-nisc_agency_harlingen_wellmed" <cfif matchVal eq 3489>selected</cfif>> Harlingen Senior Center	</option> 
<option value="3569-nisc_agency_institute_workforce" <cfif matchVal eq 3569>selected</cfif>> Institute for Workforce Innovation	</option> 
<option value="3570-nisc_agency_korean_womens_assoc" <cfif matchVal eq 3570>selected</cfif>> Korean Women's Association	</option> 
<option value="3571-nisc_agency_medina_co_office" <cfif matchVal eq 3571>selected</cfif>> Medina County Office for Older Adults	</option> 
<option value="3572-nisc_agency_missoula_food_bank" <cfif matchVal eq 3572>selected</cfif>> Missoula Food Bank	</option> 
<option value="3573-nisc_agency_mizell_sr_center" <cfif matchVal eq 3573>selected</cfif>> Mizell Senior Center of Palm Springs	</option> 
<option value="3574-nisc_agency_palatine_sr_council" <cfif matchVal eq 3574>selected</cfif>> Palatine Township Senior Citizens Council	</option> 
<option value="3575-nisc_agency_queens_community" <cfif matchVal eq 3575>selected</cfif>> Queens Community House, Inc.	</option> 
<option value="3490-nisc_agency_rochester_senior" <cfif matchVal eq 3490>selected</cfif>> Rochester Senior Center	</option> 
<option value="3576-nisc_agency_senior_citizens_inc" <cfif matchVal eq 3576>selected</cfif>> Senior Citizens, Inc.	</option> 
<option value="3577-nisc_agency_st_johns_co_council" <cfif matchVal eq 3577>selected</cfif>> St. Johns County Council on Aging	</option> 
<option value="3578-nisc_agency_templeton_council" <cfif matchVal eq 3578>selected</cfif>> Templeton Council on Aging	</option> 
<option value="3579-nisc_agency_amherst_senior_svcs" <cfif matchVal eq 3579>selected</cfif>> Town of Amherst Center for Senior Services	</option> 
<option value="3580-nisc_agency_valley_aging_svcs" <cfif matchVal eq 3580>selected</cfif>> Valley Program for Aging Services	</option> 
<option value="3581-nisc_agency_action_center_nepa" <cfif matchVal eq 3581>selected</cfif>> Voluntary Action Center of NEPA	</option> 
<option value="3491-nisc_agency_wellmed_charitable" <cfif matchVal eq 3491>selected</cfif>> WellMed Charitable Foundation Senior Center </option> 
<option value="3492-nisc_agency_wilmington_senior" <cfif matchVal eq 3492>selected</cfif>> Wilmington Senior Center </option> 	
<option value="2582-pl_agency_none_of_the_above" <cfif matchVal eq 2582>selected</cfif>> None of the above </option> 
	<cfelseif session.partner_id eq 115>

<option value="3592-srhunger_agency_aaa_southcent_ct" <cfif matchVal eq 3592>selected</cfif>> Agency on Aging of South Central CT</option> 
<option value="3593-srhunger_agency_aaa_northwest_ar" <cfif matchVal eq 3593>selected</cfif>> Area Agency on Aging of Northwest Arkansas
</option> 
<option value="3594-srhunger_agency_bay_food_bank" <cfif matchVal eq 3594>selected</cfif>>Bay Area Food Bank </option> 
<option value="3595-srhunger_agency_catawba_aaa" <cfif matchVal eq 3595>selected</cfif>>Catawba Area Agency on Aging </option> 
<option value="3596-srhunger_agency_pan_asian_comm" <cfif matchVal eq 3596>selected</cfif>> Center for Pan Asian Community Services, Inc. </option> 
<option value="3597-srhunger_agency_coastline_elder" <cfif matchVal eq 3597>selected</cfif>> Coastline Elderly Services, Inc. </option> 
<option value="3584-srhunger_agency_dc_hunger_solu" <cfif matchVal eq 3584>selected</cfif>> D.C. Hunger Solutions</option>
<option value="3598-srhunger_agency_empower_sys" <cfif matchVal eq 3598>selected</cfif>> Empowerment Systems, Inc. </option> 
<option value="3599-srhunger_agency_end_hunger_ct" <cfif matchVal eq 3599>selected</cfif>> End Hunger Connecticut! </option> 
<option value="3600-srhunger_agency_food_bank_nc" <cfif matchVal eq 3600>selected</cfif>> Food Bank of Central & Eastern North Carolina</option> 
<option value="3601-srhunger_agency_food_in_need" <cfif matchVal eq 3601>selected</cfif>> Food In Need of Distribution, Inc.</option> 
<option value="3602-srhunger_agency_hillsborough_cnt" <cfif matchVal eq 3602>selected</cfif>> Hillsborough County Board of County Commissioners</option> 
<option value="3603-srhunger_agency_houston_gal_aaa" <cfif matchVal eq 3603>selected</cfif>> Houston-Galveston AAA</option> 
<option value="3604-srhunger_agency_hr_dev_council" <cfif matchVal eq 3604>selected</cfif>> Human Resource Development Council, IX</option> 
<option value="3605-srhunger_agency_knoxville_cac" <cfif matchVal eq 3605>selected</cfif>> Knoxville Knox County Community Action Committee  </option> 
<option value="3606-srhunger_agency_mahoning_cap" <cfif matchVal eq 3606>selected</cfif>> Mahoning Youngstown Community Action Partnership </option> 
<option value="3607-srhunger_agency_met_council" <cfif matchVal eq 3607>selected</cfif>> Met Council</option> 
<option value="3587-srhunger_agency_mexican_american" <cfif matchVal eq 3587>selected</cfif>> Mexican American Opportunity Foundation</option>
<option value="3585-srhunger_agency_pathstone" <cfif matchVal eq 3585>selected</cfif>> PathStone</option>
<option value="3608-srhunger_agency_saftely_net_proj" <cfif matchVal eq 3608>selected</cfif>> Safety Net Project at the Urban Justice Center</option> 
<option value="3609-srhunger_agency_concilio" <cfif matchVal eq 3609>selected</cfif>> The Concilio</option> 
<option value="3610-srhunger_agency_three_square" <cfif matchVal eq 3610>selected</cfif>> Three Square </option> 
<option value="3611-srhunger_agency_tri_city_health" <cfif matchVal eq 3611>selected</cfif>> Tri-City Health Center</option> 
<option value="3612-srhunger_agency_win_salem_league" <cfif matchVal eq 3612>selected</cfif>> Winston-Salem Urban League</option> 

<option value="2582-pl_agency_none_of_the_above" <cfif matchVal eq 2582>selected</cfif>> None of the above </option> 
	</cfif>



	                                        </select>
	                                    </font>
	                                </td>
	                            </tr>
								<tr><td></td></tr>
							</cfif>
	
							<tr>
								<td width="35" valign="top">
									<font face="arial"><b><cf_showQuestionNumber>.</b></font>
								</td>
								<td valign="top">
									<font face="arial"><cf_displayText code="question_gender" group="question"></font>
								</td>
							</tr>
							<tr>
								<td></td>
								<td>
									<font face="arial">
										<cf_TagYeWhiteSpace>
										<cfif session.screening.prepopulate>
											<cf_handleScreeningAnswerfield action="get" code="gender" element="pre" var="matchVal">
										<cfelse>
											<cfset matchVal = 0>
										</cfif>
										<input bgcolor="white" type="radio" name="gender" value="m"<cfif matchVal eq 2> checked</cfif>> Male&nbsp;
										<input type="radio" name="gender" value="f"<cfif matchVal eq 3> checked</cfif>> Female
	                                </font>
								</td>
							</tr>
							<tr><td></td></tr>
							<cfif session.subsetStateFlag neq 1>
								<tr>
									<td width="35" valign="top">
										<font face="arial"><b><cf_showQuestionNumber>.</b></font>
									</td>
									<td valign="top">
										<font face="arial"><cf_displayText code="question_st" group="question"> <cf_displayHelpLink code="st"></font>
									</td>
								</tr>
								<tr>
									<td></td>
									<td>
										<font face="arial">
											<cf_TagYeWhiteSpace>
											<cfif session.screening.prepopulate>
												<cf_handleScreeningAnswerfield action="get" code="st" element="pre" var="matchVal">
											<cfelse>
												<cfset matchVal = session.state_id>
											</cfif>
											<cf_buildStateSelect name="st" required="true" showName="false" default="#matchVal#" style="">
										</font>
									</td>
								</tr>
								<tr><td></td></tr>
								<tr>
									<td width="35" valign="top">
										<font face="arial"><b><cf_showQuestionNumber>.</b></font>
									</td>
									<td valign="top">
										<font face="arial"><cf_displayText code="question_pri_resident" group="question"> <cf_displayHelpLink code="pri_resident"></font>
									</td>
								</tr>
								<tr>
									<td></td>
									<td>
										<font face="arial">
											<cf_TagYeWhiteSpace>
											<cfif session.screening.prepopulate>
												<cf_handleScreeningAnswerfield action="get" code="pri_resident" element="pre" var="matchVal">
											<cfelse>
												<cfset matchVal = -1>
											</cfif>
											<input type="radio" name="pri_resident" value="Y"<cfif matchVal Neq 0> checked</cfif> />Yes &nbsp;&nbsp;
											<input type="radio" name="pri_resident" value="N"<cfif matchVal Eq 0> checked</cfif> />No
										</font>
									</td>
								</tr>
								<tr><td></td></tr>
							</cfif>
							<tr>
								<td width="35" valign="top">
									<font face="arial"><b><cf_showQuestionNumber>.</b></font>
								</td>
								<td valign="top">
									<!--- changed wording of zip code question  01/27/00-JL --->
									<font face="arial"><cf_displayText code="question_zip" group="question"></font>
								</td>
							</tr>
							<tr>
								<td></td>
								<td>
									<font face="arial">
										<cf_TagYeWhiteSpace>
										<cfif session.screening.prepopulate>
											<cf_handleScreeningAnswerfield action="get" code="zip" element="pre" var="matchVal">
										<cfelse>
											<cfset matchVal = ''>
										</cfif>
										<script language="javascript">
										<!-- //
											<cfoutput>var saveThisZip = '#matchVal#';</cfoutput>
											function zipValidJR(el){
												if (saveThisZip != el.value) {
													<!---alert('values have changed');--->
													if (!validatezip(el)) {
														<!---alert('zip was found invalid');--->
														saveThisZip = el.value;
														el.focus();
														el.select();
													}
												}
											}
										// -->
										</script>
										<cfoutput>
	                                    	<!--- OLD INPUT CODE
											<input type="text" name="zip" size="5" maxlength="5" value="#matchVal#" onBlur="
												<!---alert('Blur ' + saveThisZip + ' : ' + this.value);--->
												if (saveThisZip != this.value) {
													<!---alert('values have changed');--->
													if (!validatezip(this)) {
														<!---alert('zip was found invalid');--->
														saveThisZip = this.value;
														this.focus();
														this.select();
													}
											}"> --->
	                                        <input type="text" style="width: 50px" name="zip" size="5" maxlength="5" value="#matchVal#" onBlur="javascript:zipValidJR(this);" />
										</cfoutput>
									</font>
								</td>
							</tr>
	            
				
						</table>

<cfif session.partner_id neq 14>
						<div align="right"><font size="+2"><input type="submit" value="  Next  " name="welcome" /></font></div>

<cfelse>

						<div align="right"><input type="submit" class="buttonMMM" value="  Next  " name="welcome" /></div>
</cfif>
						<br />
                        <cfif session.partner_id eq 61 or session.partner_id eq 63 or session.partner_id eq 81 or session.partner_id eq 102>
	                    	<cf_passScreeningInput aflist="o-client1-client,o-pl_agency_list,g-gender,s-zip">
                       	<cfelse>
	                    	<cf_passScreeningInput aflist="o-client1-client,#extraAF#g-gender,s-zip"><br />
						</cfif>
					</form>
                    </font>
				</td>
			</tr>
		</tbody>
		</table>
	<!--- Call footer tag --->
	</cf_buildHTML>
</cfif>
