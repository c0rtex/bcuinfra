<!----=======================================
DESCRIPTION: these are the two optional questions that are 'after' the survery.  IF not 'skipped', any answers are recorded in tbl_user_ans
CALLED BY: procAsset.cfm
GOES TO: proceligibility.cfm
REQUIRED:N/A
============================================---->
<cfif IsDefined('SESSION.partner_id') AND SESSION.partner_id EQ 0 >
	<cf_logScreeningInput initvarname="accumAFList">
	<cfif isdefined('url.debug')>
		<cfoutput>session.ch_income_total_unearned = #session.ch_income_total_unearned#</cfoutput> 
	</cfif>
	
	<cfset noOfQuestions = session.partnerLearnFlag + session.partnerRaceFlag + session.partnerHispanicFlag>
	
	<cf_tagHeader show_title="yes"> 			
	<div class="row survey">
	
		<style>
			#pageTip{ top:0px !important;}
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
	
		<div class="question">
			<div class="questionHolder questionBar">
					<h2>Optional Question<cfif noOfQuestions neq 1>s</cfif></h2>
					<p>
					Please answer <cfif noOfQuestions eq 1>this <strong>OPTIONAL</strong> question<cfelse>these <strong>OPTIONAL</strong> questions</cfif>  
					while your answers are being processed.<br>Your answer will help us 
					understand how best to reach people who can benefit from this service.
					</p>
					
			</div><!-- questionHolder -->
		</div><!-- question -->
	
	
	
	<FORM ACTION="proceligibility.cfm?<cfoutput>CFID=#session.cfid#&CFTOKEN=#session.cftoken#</cfoutput>" METHOD="post" NAME="formThird">
	
			
			<cfset questionOffset = -1>
			<cfif (session.partnerLearnFlag eq 1 
					or session.partner_id eq 6) 
					and ( session.partner_id neq 22 or session.org_id lt 1 ) >
			
				<cfif session.partner_id eq 6 and session.partnerLearnFlag eq 0>
					<input type="hidden" name="Learn" VALUE="1367-WebMD">
					<input type="hidden" name="other_learn" VALUE="">
					<cfset accumAFList = ListAppend(accumAFList, 'o-learn,s-other_learn')>
				<cfelse>
					<cfset questionOffset = questionOffset + 1>
					
					<div class="question">
						<div class="questionHolder questionBar">
							<span class="question_number"><cf_showQuestionNumber>.</span>
							<p>
								How did you learn about <cf_tagBCU>?
							</p>		
								
							<cfif session.screening.prepopulate>
								<cf_handleScreeningAnswerfield action="get" code="learn" element="pre" var="matchVal">
							<cfelse>
								<cfset matchVal = 0>
							</cfif>
							
							<cfif session.screening.prepopulate>
								<cf_handleScreeningAnswerfield action="get" code="other_learn" element="pre" var="matchValOther">
							<cfelse>
								<cfset matchValOther = ''>
							</cfif>
							
				            <cfset learnOptions = application.AnswerfieldPool.getAnswerfield('learn')>
				            
							<select name="learn">
								<option value="">-- Select one --</option>
								<cf_loopPoolStruct struct="learnOptions" index="option">
				                    <cfset learnOption = application.OptionPool.getOption(option)>
									<cf_ifOptionIncluded struct="learnOption">
										<cfoutput><option value="#learnOption.id#-#option#"<cfif matchVal eq learnOption.id> selected</cfif>><cf_displayText group="option" code="option_#option#"></option></cfoutput>
									</cf_ifOptionIncluded>
								</cf_loopPoolStruct>
							</select>
						</div><!-- questionHolder -->
					</div><!-- question -->	
					
					<div class="question">
						<div class="questionHolder questionBar">
							<p>
							If you selected "Other," please specify:<br>
								<input type="text" size="30" 
										name="other_learn" value="<cfoutput>#HTMLEditFormat(matchValOther)#</cfoutput>" 
										maxlength="32">
							</p>
							<cfset accumAFList = ListAppend(accumAFList, 'o-learn,s-other_learn')>
						</div><!-- questionHolder -->
					</div><!-- question -->	
		
				</cfif>
			</cfif><!--- END <cfif (session.partnerLearnFlag eq 1  --->
			
			<cfif session.partnerRaceFlag eq 1>
				<cfset questionOffset = questionOffset + 1>
				
				<div class="question">
					<div class="questionHolder questionBar">
						<span class="question_number"><cf_showQuestionNumber>.</span>
						<p>
							<cfif (not IsDefined("session.strClient")) or session.strClient eq "Self">
								What is your race
							<cfelse>
								What is the race of your <cfoutput>#session.StrClient#</cfoutput>
							</cfif>?
						</p>
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="race" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = 0>
						</cfif>
						
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="other_race" element="pre" var="matchValOther">
						<cfelse>
							<cfset matchValOther = ''>
						</cfif>
						
			            <cfset raceOptions = application.AnswerfieldPool.getAnswerfield('race')>
						<select name="race">
							<option value="">-- Select one --</option>
							<cf_loopPoolStruct struct="raceOptions" index="option">
			                    <cfset raceOption = application.OptionPool.getOption(option)>
								<cf_ifOptionIncluded struct="raceOption">
									<cfoutput><option value="#raceOption.id#-#option#"<cfif matchVal eq raceOption.id> selected</cfif>><cf_displayText group="option" code="option_#option#"></option></cfoutput>
								</cf_ifOptionIncluded>
							</cf_loopPoolStruct>
						</select>
					</div><!-- questionHolder -->
				</div><!-- question -->	
				
				<div class="question">
					<div class="questionHolder questionBar">
						If you selected "Other," please specify:<br>
						<input type="text" size="30" name="other_race" value="<cfoutput>#HTMLEditFormat(matchValOther)#</cfoutput>" maxlength="32">
						<cfset accumAFList = ListAppend(accumAFList, 'o-race,s-other_race')>					
					</div><!-- questionHolder -->
				</div><!-- question -->	
			</cfif>
			
			<cfif session.partnerHispanicFlag eq 1>
				<cfset questionOffset = questionOffset + 1>
	
				<div class="question">
					<div class="questionHolder questionBar">
						<span class="question_number"><cf_showQuestionNumber>.</span>
						<p>
							<cfif (not IsDefined("session.strClient")) or session.strClient eq "Self">
								Are you
							<cfelse>
								Is your <cfoutput>#session.StrClient#</cfoutput></cfif> 
								Spanish, Hispanic, or Latino?  If yes, indicate origin.
						</p>
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="hispanic" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = 0>
						</cfif>
						
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="other_hispanic" element="pre" var="matchValOther">
						<cfelse>
							<cfset matchValOther = ''>
						</cfif>
						<select name="hispanic"><br>
							<option value="">-- Select one --</option>
							<option VALUE="1386-Not_Hispanic"<cfif matchVal eq 1386> selected</cfif>>No, not Hispanic<br>
							<option VALUE="1387-Mexican"<cfif matchVal eq 1387> selected</cfif>>Yes, Mexican, Mexican-American, or Chicano<br>
							<option VALUE="1388-Puerto_Rican"<cfif matchVal eq 1388> selected</cfif>>Yes, Puerto Rican<br>
							<option VALUE="1389-Cuban"<cfif matchVal eq 1389> selected</cfif>>Yes, Cuban<br>
							<option VALUE="1390-Dominican"<cfif matchVal eq 1390> selected</cfif>>Yes, Dominican<br>
							<option VALUE="1391-Central_American"<cfif matchVal eq 1391> selected</cfif>>Yes, Guatemalan, Honduran, Salvadoran, or other Central American<br>
							<option VALUE="1392-Other_Hispanic"<cfif matchVal eq 1392> selected</cfif>>Other
						</select>
					</div><!-- questionHolder -->
				</div><!-- question -->	
			
				<div class="question">
					<div class="questionHolder questionBar">
						<p>
						If you selected "Other," please specify:<br>
						<input type="text" size="30" name="other_hispanic" value="<cfoutput>#HTMLEditFormat(matchValOther)#</cfoutput>" maxlength="32">
				
						<cfset accumAFList = ListAppend(accumAFList, 'o-hispanic,s-other_hispanic')>
						</p>
					</div><!-- questionHolder -->
				</div><!-- question -->	
			
			</cfif>
			
			<cfif False>
				<cfset questionOffset = questionOffset + 1>
	
				<div class="question">
					<div class="questionHolder questionBar">
						<span class="question_number"><cf_showQuestionNumber>.</span>
						<p>Do you know of other Medicare beneficiaries who need 
						help paying for their medicines?  If yes, how many?
						</p>
					</div><!-- questionHolder -->
				</div><!-- question -->	
					
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="med_know" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = ''>
				</cfif>
				
				<div class="question">
					<div class="questionHolder questionBar">
						<p>
						<INPUT TYPE="type" NAME="med_know" value="<cfoutput>#matchVal#</cfoutput>" size="4"> (leave blank for zero)
						</p>
					</div><!-- questionHolder -->
				</div><!-- question -->	
				<cfset accumAFList = ListAppend(accumAFList, 'n-med_know')>
			</cfif>
	
			<div id="surveyNav">
				<!---<h2>Keep up the good work. You've passed the midway point of the questionnaire.</h2>--->
				<p><div class="left"><input class="view_results" type="submit" value="  View Results " name="answeradditional" /></div></p> 
			</div>
	
			<cf_passScreeningInput varname="accumAFList" pagecode="optional">
		</form>
		
		<div class="question results_p">
			<p>
				Your results will now be assembled.  It should just take 
				another moment or two before they are displayed.  
				<cfif session.partner_id eq 7> 
					Thank you for using this service of the Access to Benefits Coalition&trade;.
				<cfelse>
					Thank you for using <cf_tagBCU> 
						<cfif session.subset_id eq 14> 
							for People with Medicare
						</cfif>.
				</cfif>
			</p>
		</div>
		
		<div class="question results_p">
			<p>
				<cfif session.partner_id eq 7 and session.subset_id neq 14>   
					Later on, you will see a link inviting you to send us 
					comments about if and how this service has helped you. 
					Please take a moment to provide us with your feedback 
					so that we can better serve you and others in the future.   
					Also, please think about how you can help the Access to 
					Benefits Coalition&trade; to spread the word about this 
					service to others who need help paying for their medicines.
				<cfelseif session.subset_id eq 14>
					When your results are displayed, you will see a link to 
					send us comments about how <cf_tagBCU> has helped you.  
					Please take a moment to provide us with this information.  
					If you find the service helpful, please tell other people you know about it.
				<cfelse>
					When your results are displayed, you will see a link 
					to send us comments about how <cf_tagBCU> has helped you.  
					Please take a moment to provide us with this information.  
					The more we learn about how <cf_tagBCU> helps you, the better 
					we&rsquo;ll be able to serve you in the future.
					</cfif>
			</p>	
		</div>
	</div>
	</div>
	<cf_tagFooter>
<cfelse>
	<!----=======================================
	DESCRIPTION: these are the two optional questions that are 'after' the survery.  IF not 'skipped', any answers are recorded in tbl_user_ans
	CALLED BY: procAsset.cfm
	GOES TO: proceligibility.cfm
	REQUIRED:N/A
	============================================---->
	<cf_logScreeningInput initvarname="accumAFList">
	<cfif isdefined('url.debug')><cfoutput>session.ch_income_total_unearned = #session.ch_income_total_unearned#</cfoutput> </cfif>
	<cfset noOfQuestions = session.partnerLearnFlag + session.partnerRaceFlag + session.partnerHispanicFlag>
	<cf_tagHeader show_title="yes"> 
	<table width=100% border="0" align="center" cellpadding=12 cellspacing=2 class="text1">
		<TBODY>
		<tr>
		<td bgcolor=#FFFFFF colspan=2 style="padding: 0px 12px 12px 12px;">
	<!--Dynamic Area--><font face="arial" size="4" color="#000000">
	
	<cfoutput><FORM ACTION="proceligibility.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" METHOD="post" NAME="formThird"></cfoutput>
	<font face="arial" size="4" color="#000000">
    <center>
	<table border="0" align="center" width="80%" class="text1"><!--- outer --->
	<tr>
	<td align="center">
			<span class="screeningInstructionText">Please answer <cfif noOfQuestions eq 1>this <b>OPTIONAL</b> question<cfelse>these <b>OPTIONAL</b> questions</cfif>  while your answers are being processed.<br>Your answer will help us understand how best to reach people who can benefit from this service.</span>
	<p class="text1"></p>
		<table width="95%" height="95%" align="center" cellspacing="0" class="text1"><!--- inner --->
		<tr><td  align="center"><!--- bdcfc8; a1ccd0 (light blue) --->
			
			<table align="center" border="0" cellspacing="0" cellpadding="7">
			<tr><td align="center" bgColor=#e0e0e0><span class="screeningInstructionText"><b>OPTIONAL QUESTION<cfif noOfQuestions neq 1>S</cfif></b></span></td></tr>
			<cfset questionOffset = -1>
			<cfif (session.partnerLearnFlag eq 1 or session.partner_id eq 6) and ( session.partner_id neq 22 or session.org_id lt 1 ) >
			<cfif session.partner_id eq 6 and session.partnerLearnFlag eq 0>
				<input type="hidden" name="Learn" VALUE="1367-WebMD">
				<input type="hidden" name="other_learn" VALUE="">
				<cfset accumAFList = ListAppend(accumAFList, 'o-learn,s-other_learn')>
			<cfelse>
				<cfset questionOffset = questionOffset + 1>
			<tr>
				<TD VALIGN="top" bgColor=#f0f0f0>
				<FONT face="Arial"><b><cf_showQuestionNumber>.</b>&nbsp;&nbsp;How did you learn about <cf_tagBCU>?<ul>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="learn" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = 0>
				</cfif>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="other_learn" element="pre" var="matchValOther">
				<cfelse>
					<cfset matchValOther = ''>
				</cfif>
	            <cfset learnOptions = application.AnswerfieldPool.getAnswerfield('learn')>
	            
				<select name="learn">
					<option value="">-- Select one --</option>
					<cf_loopPoolStruct struct="learnOptions" index="option">
	                    <cfset learnOption = application.OptionPool.getOption(option)>
						<cf_ifOptionIncluded struct="learnOption">
							<cfoutput><option value="#learnOption.id#-#option#"<cfif matchVal eq learnOption.id> selected</cfif>><cf_displayText group="option" code="option_#option#"></option></cfoutput>
						</cf_ifOptionIncluded>
					</cf_loopPoolStruct>
				</select><p class="text1"></p>
				If you selected "Other," please specify:<br>
				<img src="images/pixel.gif" width="1" height="6" alt="" title=""><br>
				<cfoutput><input type="text" size="30" name="other_learn" value="#HTMLEditFormat(matchValOther)#" maxlength="32"></cfoutput></font>
				<cfset accumAFList = ListAppend(accumAFList, 'o-learn,s-other_learn')>
				</td>
			</tr>
			</cfif>
			</cfif>
			<cfif session.partnerRaceFlag eq 1>
			<cfset questionOffset = questionOffset + 1>
			<tr>
				<td VALIGN="top" bgColor=#f0f0f0>
				<FONT face="Arial"><b><cf_showQuestionNumber>.</b>&nbsp;&nbsp;<cfif (not IsDefined("session.strClient")) or session.strClient eq "Self">What is your race<cfelse>What is the race of your <cfoutput>#session.StrClient#</cfoutput></cfif>?<ul>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="race" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = 0>
				</cfif>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="other_race" element="pre" var="matchValOther">
				<cfelse>
					<cfset matchValOther = ''>
				</cfif>
	            <cfset raceOptions = application.AnswerfieldPool.getAnswerfield('race')>
				<select name="race">
					<option value="">-- Select one --</option>
					<cf_loopPoolStruct struct="raceOptions" index="option">
	                    <cfset raceOption = application.OptionPool.getOption(option)>
						<cf_ifOptionIncluded struct="raceOption">
							<cfoutput><option value="#raceOption.id#-#option#"<cfif matchVal eq raceOption.id> selected</cfif>><cf_displayText group="option" code="option_#option#"></option></cfoutput>
						</cf_ifOptionIncluded>
					</cf_loopPoolStruct>
				</select><p class="text1"></p>
				If you selected "Other," please specify:<br>
				<img src="images/pixel.gif" width="1" height="6" alt="" title=""><br>
				<cfoutput><input type="text" size="30" name="other_race" value="#HTMLEditFormat(matchValOther)#" maxlength="32"></cfoutput></font>
				<cfset accumAFList = ListAppend(accumAFList, 'o-race,s-other_race')>
				</td>
			</tr>
			</cfif>
			<cfif session.partnerHispanicFlag eq 1>
			<cfset questionOffset = questionOffset + 1>
			<tr>
				<td VALIGN="top" bgColor=#f0f0f0>
				<FONT face="Arial"><b><cf_showQuestionNumber>.</b>&nbsp;&nbsp;<cfif (not IsDefined("session.strClient")) or session.strClient eq "Self">Are you<cfelse>Is your <cfoutput>#session.StrClient#</cfoutput></cfif> Spanish, Hispanic, or Latino?  If yes, indicate origin.<ul>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="hispanic" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = 0>
				</cfif>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="other_hispanic" element="pre" var="matchValOther">
				<cfelse>
					<cfset matchValOther = ''>
				</cfif>
				<select name="hispanic"><br>
					<option value="">-- Select one --</option>
					<option VALUE="1386-Not_Hispanic"<cfif matchVal eq 1386> selected</cfif>>No, not Hispanic<br>
					<option VALUE="1387-Mexican"<cfif matchVal eq 1387> selected</cfif>>Yes, Mexican, Mexican-American, or Chicano<br>
					<option VALUE="1388-Puerto_Rican"<cfif matchVal eq 1388> selected</cfif>>Yes, Puerto Rican<br>
					<option VALUE="1389-Cuban"<cfif matchVal eq 1389> selected</cfif>>Yes, Cuban<br>
					<option VALUE="1390-Dominican"<cfif matchVal eq 1390> selected</cfif>>Yes, Dominican<br>
					<option VALUE="1391-Central_American"<cfif matchVal eq 1391> selected</cfif>>Yes, Guatemalan, Honduran, Salvadoran, or other Central American<br>
					<option VALUE="1392-Other_Hispanic"<cfif matchVal eq 1392> selected</cfif>>Other
				</select><p class="text1"></p>
				If you selected "Other," please specify:<br>
				<img src="images/pixel.gif" width="1" height="6" alt="" title=""><br>
				<cfoutput><input type="text" size="30" name="other_hispanic" value="#HTMLEditFormat(matchValOther)#" maxlength="32"></cfoutput></font>
				<cfset accumAFList = ListAppend(accumAFList, 'o-hispanic,s-other_hispanic')>
				</td>
			</tr>
			</cfif>
			<cfif False>
			<cfset questionOffset = questionOffset + 1>
			<tr>
				<td VALIGN="top" bgColor=#f0f0f0>
				<FONT face="Arial"><b><cf_showQuestionNumber>.</b>&nbsp;&nbsp;Do you know of other Medicare beneficiaries who need help paying for their medicines?  If yes, how many?<ul>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="med_know" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = ''>
				</cfif>
				<cfoutput><INPUT TYPE="type" NAME="med_know" value="#matchVal#" size="4"></cfoutput> (leave blank for zero)<BR>&nbsp;
				<cfset accumAFList = ListAppend(accumAFList, 'n-med_know')>
				<p class="text1"></p>
				</td>
			</tr>
			</cfif>
			</table>
			<!--- depending on income and assets responses from previous page, set output --->
			<br><font face="Arial">
			<b><input type="Submit" name="answeradditional" value="  View Results  "></b>
	        <!--- <b><input type="Submit" name="answeradditional" value="Skip"></b> --->
	        </font>
			<cf_passScreeningInput varname="accumAFList" pagecode="optional">
			</form><br>
			
		</td></tr>
		<tr><td align="center"><p class="screeningInstructionText"><b>Your results will now be assembled.  It should just take another moment or two before they are displayed.  
		<cfif session.partner_id eq 7> 
		Thank you for using this service of the Access to Benefits Coalition&trade;.
		<cfelse>
		Thank you for using <cf_tagBCU><cfif session.subset_id eq 14> for People with Medicare</cfif>.
		</cfif>
		</b></p>
		<p align="left" class="screeningInstructionText">
		<cfif session.partner_id eq 7 and session.subset_id neq 14>   
		Later on, you will see a link inviting you to send us comments about if and how this service has helped you. Please take a moment to provide us with your feedback so that we can better serve you and others in the future.   Also, please think about how you can help the Access to Benefits Coalition&trade; to spread the word about this service to others who need help paying for their medicines.
		<cfelseif session.subset_id eq 14>
		When your results are displayed, you will see a link to send us comments about how <cf_tagBCU> has helped you.  Please take a moment to provide us with this information.  If you find the service helpful, please tell other people you know about it.
		<cfelse>
		When your results are displayed, you will see a link to send us comments about how <cf_tagBCU> has helped you.  Please take a moment to provide us with this information.  The more we learn about how <cf_tagBCU> helps you, the better we'll be able to serve you in the future.
		</cfif>
		</p></font></td></tr>
		</table>	
	</td></tr>	
	</table></center>	<br>
		
		</TD></TR>
		</TBODY></TABLE>
	<cf_tagFooter>
</cfif>