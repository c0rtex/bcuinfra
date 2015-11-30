<!----=======================================
DESCRIPTION: this is the questionnaire.  Pulls questions from 
	the db, puts them in array, then checks to see if they should
	be asked, then stres the answers in session variables.
CALLED BY: frmQuestions.cfm or other
GOES TO: proc_income or frmincome.cfm dependingn on user selection
REQUIRED:N/A
============================================---->
<cfif Not IsDefined('form.skipassets') OR Not IsDefined('form.skipinc')>
	<cflocation url="frmskipgrid.cfm?SKIPPEDPAGE='YES'" addtoken="Yes">
<cfelse>

	<cf_logScreeningInput>
	
	<cfif IsDefined('session.subset_id') And session.subset_id gt 0>
		<cfset session.wantchips = 'N'>
		<cflocation url="frmincomegrid.cfm" addtoken="Yes">
	<cfelse>
		<cfif IsDefined('SESSION.partner_id') AND (SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77 )>
				<cf_tagHeader show_title="yes" guts="frmquestionsthird.cfm"> 
				<style>
					#pageTip{ top:0px !important;}
				</style>
					
				<div class="row survey">
				<!--Dynamic Area-->
				
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
				
				<cfoutput>
					<FORM ACTION="frmincomegrid.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" METHOD="post" NAME="formThird">			
				</cfoutput>
		
				
				<!--- 09/01/2002 REM  Modified the text in the following two paragraphs--no functional 
				mods --->
				
				<div class="question">
				<div class="questionHolder questionBar">
						<p>
							If you are a grandparent (or know a grandparent) who is helping raise a grandchild, you are not alone. 7.5 million children in the United States (about 10 percent), live with a grandparent. Additionally, millions of children age 18 or under do not have health insurance and are unaware they may be able to get help paying their health coverage. 
						</p>
					</div><!-- questionHolder -->
				</div><!-- question -->	
				
				<div class="question">
					<div class="questionHolder questionBar">
						<span class="question_number"><cf_showQuestionNumber>.</span> 
							<p>
								We are also making sure that every child has access to basic health insurance.
Do you know of any children, 18 years of age or younger, who do not have health
insurance coverage?
							</p>
							<cfif session.screening.prepopulate>
								<cf_handleScreeningAnswerfield action="get" code="wantchips" element="pre" var="matchVal">
							<cfelse>
								<cfset matchVal = -1>
							</cfif>
							<ul class="striping">
								<li class="questionBar">
									<INPUT TYPE="radio" NAME="wantchips" VALUE="Y"<cfif matchVal Eq 1> CHECKED</cfif>>Yes &nbsp;&nbsp;
								</li>
								<li class="questionBar">
									<INPUT TYPE="radio" NAME="wantchips" VALUE="N"<cfif matchVal Neq 1> CHECKED</cfif>>No
								</li>
							</ul>
					</div><!-- questionHolder -->
				</div><!-- question -->	
		
				<!--- depending on income and assets responses from previous page, set output --->
				<!--- 09/01/2002 REM  Added RX Only check to keep the language correct --->	
				<cfif session.skipassets EQ "N" 
					AND session.skipinc EQ "N" 
					AND (Not IsDefined('session.subset_id') 
					Or session.subset_id neq 1) AND session.subsetDrugFlag eq 1>
					
						<div id="surveyNav">
							<h2>Congratulations!</h2>
							<p>
								You have just completed the last page of NCOA&rsquo;s <cf_tagBCU>. 
								Click on the Submit Questionnaire button below to submit your responses 
								to determine potential eligibility to benefits programs in 
								<cfif #session.StrClient# neq 'self'>
									<cfoutput>your #session.StrClient#'s</cfoutput>
								<cfelse>
									your
								</cfif> area.
							</p>
							<p>
								<div class="left"><input class="view_results" type="submit" value="  View Results " name="submit" onClick="document.questions.submit();" /></div>
							</p>
							<p>
								It may take a couple of minutes to process your answers 
								against our national database of benefits programs. Please be patient.
							</p> 
						</div>
		
				    </FORM>
				
				<!--- 09/30/2002 REM  Rewrote this to loop the lists, to make it easier to work with the code --->	
						<cfset lstFieldTypes="s_,sp_,s_sp_,hh_">
						
						<cfset lstAssetFields="cash, auto1, auto2, home, retirement, stocks, life_cash, life_face, irrevocable, other_a">
						<cfloop list="#lstAssetFields#" index="fieldName">
							<cfloop list="#lstFieldTypes#" index="fieldType">
								<cfset "session.#TRIM(fieldType)#asset_#TRIM(fieldName)#" = "10000000">
							</cfloop>
						</cfloop>
						
						<cfset lstIncomeFields = "pri_retire,dividends,ssi,ss_disable,ss_retire,rr_ben,vet_ben,unemploy,tanf,cash_assist,other_nw,earned">
						<cfloop list="#lstIncomeFields#" index="fieldName">
							<cfloop list="#lstFieldTypes#" index="fieldType">
								<cfset "session.#TRIM(fieldType)#income_#TRIM(fieldName)#" = "10000000">
							</cfloop>
						</cfloop>
							
				<cfelseif session.skipassets is 'n' and session.skipinc is 'y'>
				
						<cfset lstFieldTypes="s_, sp_, s_sp_, hh_">
						
						<cfset lstAssetFields="cash, auto1, auto2, home, retirement, stocks, life_cash, life_face, irrevocable, other_a">
						<cfloop list="#lstAssetFields#" index="fieldName">
							<cfloop list="#lstFieldTypes#" index="fieldType">
								<cfset "session.#TRIM(fieldType)#asset_#TRIM(fieldName)#" = "10000000">
							</cfloop>
						</cfloop>
						
						<div id="surveyNav">
							<p>
								<div class="left"><input type="submit" value="  Next > " name="Submit" onClick="document.questions.submit();" /></div>
							</p>
						</div>
				
				<cfelse>
				
					<cfset lstFieldTypes="s_,sp_,s_sp_,hh_">
				<cfset lstIncomeFields="pri_retire,dividends,ssi,ss_disable,ss_retire,rr_ben,vet_ben,unemploy,tanf,cash_assist,other_nw,earned">
				<cfloop list="#lstIncomeFields#" index="fieldName">
					<cfloop list="#lstFieldTypes#" index="fieldType">
						<cfset "session.#fieldType#income_#fieldName#" = 10000000>
					</cfloop>
				</cfloop>
				
						<div id="surveyNav">
							<p>
								<div class="left"><input type="submit" value="  Next > " name="Submit" onClick="document.questions.submit();" /></div>
							</p>
						</div>
				
		    <cfif session.skipassets eq 'n' and session.skipinc eq 'n'>
			<cfif session.partner_id eq 89 OR session.partner_id eq 90>
			<h3 style="width:840px; margin: 0 auto; padding:20px;"><strong>Your results will now be assembled. It should just take another moment or two
			before they are displayed. Thank you for using BenefitsCheckUp.</strong></h3>
			</cfif>
			</cfif>
				</cfif><!--- <cfif session.skipassets eq 'n' and session.skipinc eq 'n'> --->
				
				<cf_passScreeningInput aflist="y-wantchips" pagecode="chips">
				</FORM>
				</div>
				
				<cf_tagFooter>
		<cfelse>
		<!--- PL Begins HERE --->
				<cf_tagHeader show_title="yes" guts="frmquestionsthird.cfm"> 
					<table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
						<TBODY>
						<tr>
					    <td bgcolor=#FFFFFF colspan=2" style="padding: 0px 12px 12px 12px;">
					    
					<!--Dynamic Area-->
					
					<cfoutput><FORM ACTION="frmincomegrid.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" METHOD="post" NAME="formThird"></cfoutput>
					
					<!--- 09/01/2002 REM  Modified the text in the following two paragraphs--no functional 
					mods --->
					<cfoutput>
						<font face="arial" size="4" color="##000000">
						<span class="screeningInstructionText" style="font-family:arial;">If you are a grandparent, or know a grandparent, raising grandchildren you are not alone. Six percent of US children under 18 (3.9 million) live in grandparent-headed households. Additionally, over ten million children age 18 or under have no health insurance. Many families don't know their children are eligible for health insurance.</span>
					<p class="text1"></p>
                    
					<table align="center" width="100%" class="text1">
					<tr>
						<TD WIDTH="35" valign="top">
								
							<cfif SESSION.partner_id NEQ 80>
                                <FONT FACE="arial"><B><cf_showQuestionNumber>.</b>
                            <cfelse>
                                <strong class="question_number"><cf_showQuestionNumber>.</strong>
                            </cfif>	
						</td>
                        <TD VALIGN="top" style="font-family:arial;">
					</cfoutput> 
							We are also making sure that every child has access to basic health insurance.
Do you know of any children, 18 years of age or younger, who do not have health
insurance coverage?
						
						</td>
					</tr>
					<tr>
					<td></td>
					<td>
					<CF_TagYeWhiteSpace>
								<cfif session.screening.prepopulate>
									<cf_handleScreeningAnswerfield action="get" code="wantchips" element="pre" var="matchVal">
								<cfelse>
									<cfset matchVal = -1>
								</cfif>
					<INPUT TYPE="radio" NAME="wantchips" VALUE="Y"<cfif matchVal Eq 1> CHECKED</cfif>>Yes &nbsp;&nbsp;
					<INPUT TYPE="radio" NAME="wantchips" VALUE="N"<cfif matchVal Neq 1> CHECKED</cfif>>No</font></td></tr><tr><td>
					
					</td></tr></table>
					<!--- depending on income and assets responses from previous page, set output --->
					<!--- 09/01/2002 REM  Added RX Only check to keep the language correct --->	
					<cfif session.skipassets EQ "N" AND session.skipinc EQ "N" AND (Not IsDefined('session.subset_id') Or session.subset_id neq 1) AND session.subsetDrugFlag eq 1>
						<br>
						<span class="screeningInstructionText" style="font-family:arial;"><b>Congratulations!</b><br />
						You have just completed the last page of <cfif session.partner_id eq 22 and session.subset_id eq 70>the SNAP &amp; SCSEP Benefits Screening.<cfelse>NCOA's <cf_tagBCU>.</cfif> Click on the Submit Questionnaire button below to submit your responses to determine  potential eligibility to benefits programs in <cfif #session.StrClient# neq 'self'><cfoutput>your #session.StrClient#'s</cfoutput><cfelse>your</cfif> area.</span>
						<p class="text1"></p>
						<table  border="0" cellpadding=0 cellspacing=0><tr>
						<td align="left" valign="top"> 
						<font face="Arial">
					    <b><input type="submit" name="Submit" value="  View Results  "></b>
					    </font></td>
					    </FORM>
						<td valign="bottom">
					</td>
					</tr></table>
					<br><br>
					<span class="screeningInstructionText" style="font-family:arial;"><b>It may take a couple of minutes to process your answers against our national database of benefits programs. Please be patient.</b></span>
					
					<!--- 09/30/2002 REM  Rewrote this to loop the lists, to make it easier to work with the code --->	
							<cfset lstFieldTypes="s_,sp_,s_sp_,hh_">
							
							<cfset lstAssetFields="cash, auto1, auto2, home, retirement, stocks, life_cash, life_face, irrevocable, other_a">
							<cfloop list="#lstAssetFields#" index="fieldName">
								<cfloop list="#lstFieldTypes#" index="fieldType">
									<cfset "session.#TRIM(fieldType)#asset_#TRIM(fieldName)#" = "10000000">
								</cfloop>
							</cfloop>
							
							<cfset lstIncomeFields="pri_retire, dividends, ssi, ss_disable, ss_retire, rr_ben, vet_ben, unemploy, tanf, cash_assist, other_nw, earned">
							<cfloop list="#lstIncomeFields#" index="fieldName">
								<cfloop list="#lstFieldTypes#" index="fieldType">
									<cfset "session.#TRIM(fieldType)#income_#TRIM(fieldName)#" = "10000000">
								</cfloop>
							</cfloop>
							
							
					<cfelseif session.skipassets is 'n' and session.skipinc is 'y'>
					
							<cfset lstFieldTypes="s_, sp_, s_sp_, hh_">
							
							<cfset lstAssetFields="cash, auto1, auto2, home, retirement, stocks, life_cash, life_face, irrevocable, other_a">
							<cfloop list="#lstAssetFields#" index="fieldName">
								<cfloop list="#lstFieldTypes#" index="fieldType">
									<cfset "session.#TRIM(fieldType)#asset_#TRIM(fieldName)#" = "10000000">
								</cfloop>
							</cfloop>
							
					<br>
					<font face="Arial"><b><input type="submit" name="Submit" value="  Next  "></b></font>
					
					<cfelse>
					
							<cfset lstFieldTypes="s_,sp_,s_sp_,hh_">
							<cfset lstIncomeFields="pri_retire,dividends,ssi,ss_disable,ss_retire,rr_ben,vet_ben,unemploy,tanf,cash_assist,other_nw,earned">
							<cfloop list="#lstIncomeFields#" index="fieldName">
								<cfloop list="#lstFieldTypes#" index="fieldType">
									<cfset "session.#fieldType#income_#fieldName#" = 10000000>
								</cfloop>
							</cfloop>
								
						<br>
						<table border="0" cellpadding="0" cellspacing="0" width="100%"><tr><td valign="top" align="right">
						<font face="Arial">
					    <b><input type="submit" name="Submit" value="  Next  "></b>
					    </font>
					    &nbsp;&nbsp;&nbsp;</td></tr></table>
					    <cfif session.skipassets eq 'n' and session.skipinc eq 'n'>
						<cfif session.partner_id eq 89 OR session.partner_id eq 90>
						<span class="screeningInstructionText" style="width:840px; margin: 0 auto; padding:20px; font-family:arial;"><strong>Your results will now be assembled. It should just take another moment or two before they are displayed. Thank you for using BenefitsCheckUp.</strong></span>
						</cfif>
						</cfif>
					</cfif><!--- <cfif session.skipassets eq 'n' and session.skipinc eq 'n'> --->
					<cf_passScreeningInput aflist="y-wantchips" pagecode="chips">
					</FORM></FONT></TD></TR></TBODY></TABLE>
					
					<cf_tagFooter>
		</cfif><!--- END <cfif IsDefined('SESSION.partner_id') AND SESSION.partner_id EQ 0> --->
	</cfif>
	
</cfif>