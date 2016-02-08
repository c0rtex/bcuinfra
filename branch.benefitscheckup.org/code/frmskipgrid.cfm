<cf_logScreeningInput initvarname="accumAFList">
<!--- BShunn 5/3/2005
	grid_flag = 0 : display full grid
	grid_flag = 1 : display specified rows from grid
	grid_flag = 2 : display condensed questions
	grid_flag = 3 : skip grids

	In first two cases, get list of matching income table options.
	In third case, get matching question options.
	In last case, skip page.
---><cfif session.subset_id eq 70><cfset session.subsetGridFlag = 2></cfif>

<cfif  isdefined('url.debug')><cfoutput>session.subsetGridFlag = #session.subsetGridFlag# | session.ch_income_total_unearned = #session.ch_income_total_unearned#</cfoutput> </cfif>
<cfif session.subsetGridFlag eq 0 Or session.subsetGridFlag eq 1>
	<cfquery name="getincome" datasource="#application.dbSrc#">
		SELECT i.incometype_name, i.incometype_varname, i.definition
		FROM <cfif session.subsetGridFlag eq 1>xsubset_xincometype si, </cfif>xincometype i
		WHERE <cfif session.subsetGridFlag eq 1>si.subset_id=#session.subset_id#
			AND si.incometype_id=i.incometype_id<cfelse>i.exclude_flag=0</cfif>
		ORDER BY i.sort
	</cfquery>
	<cfquery name="getasset" datasource="#application.dbSrc#">
		SELECT a.assettype_name, a.assettype_varname, a.definition
		FROM <cfif session.subsetGridFlag eq 1>xsubset_xassettype sa, </cfif>xassettype a
		WHERE <cfif session.subsetGridFlag eq 1>sa.subset_id=#session.subset_id#
			AND sa.assettype_id=a.assettype_id<cfelse>a.exclude_flag=0</cfif>
		ORDER BY a.sort
	</cfquery>
<cfelseif session.subsetGridFlag eq 2>
	<cfif session.marital_stat eq 'Married'>
		<cfset incassColName = 'self_married'>
	<cfelse>
		<cfset incassColName = 'self_single'>
	</cfif>
	<cfquery name="getincass" datasource="#application.dbSrc#">
		SELECT i.incass_varname, i.#incassColName#_text AS incass_text, i.work_flag
		FROM xsubset_xincass AS si, xincass AS i
		WHERE si.subset_id=#session.subset_id#
			AND si.incass_id=i.incass_id
		ORDER BY i.sort
	</cfquery><cfdump var="##">
</cfif>

<cfif (session.subsetGridFlag eq 1 And getincome.RecordCount eq 0) Or (session.subsetGridFlag eq 2 And getincass.RecordCount eq 0) Or session.subsetGridFlag eq 3> <!--- START BIGGER IF --->

	<cfquery name="getincomevar" datasource="#application.dbSrc#">
		SELECT i.incometype_varname
		FROM xincometype i
		ORDER BY i.sort
	</cfquery>
	<cfloop query="getincomevar">
		<cfset "session.s_income_#incometype_varname#" = ''>
		<cfset "session.sp_income_#incometype_varname#" = ''>
		<cfset "session.s_sp_income_#incometype_varname#" = ''>
		<cfset "session.hh_income_#incometype_varname#" = ''>
	</cfloop>
	<cfif session.subsetGridFlag eq 2>
		<cfquery name="getassetvar" datasource="#application.dbSrc#">
			SELECT a.assettype_varname
			FROM xassettype a
			ORDER BY a.sort
		</cfquery>
		<cfloop query="getassetvar">
			<cfset "session.s_asset_#assettype_varname#" = ''>
			<cfset "session.sp_asset_#assettype_varname#" = ''>
			<cfset "session.s_sp_asset_#assettype_varname#" = ''>
			<cfset "session.hh_asset_#assettype_varname#" = ''>
		</cfloop>
	</cfif>
	<cfset session.wantchips = 'N'>
	<cflocation url="procgrid.cfm" addtoken="Yes">

<cfelse> <!--- ELSE BIGGER IF --->

<cfif session.subset_id eq 14  or session.subset_id eq 28 or session.subset_id eq 34 or session.subset_id eq 35>
<!--- call header tag --->
	<cf_tagjsinc>
	<cfif session.marital_stat eq 'Married'>
		<cfset presetSSpIES = -1>
		<cfset presetSSpIONWS = -1>
		<cfset presetSSpAOAS = -1>
		<cfif session.screening.prepopulate>
			<cf_handleScreeningAnswerfield action="get" code="s_sp_income_earned_simple" element="pre" var="presetSSpIES">
			<cfif Not IsNumeric(presetSSpIES)>
				<cfset presetSSpIES = -1>
			</cfif>
		</cfif>
		<cfif session.screening.prepopulate>
			<cf_handleScreeningAnswerfield action="get" code="s_sp_income_other_nw_simple" element="pre" var="presetSSpIONWS">
			<cfif Not IsNumeric(presetSSpIONWS)>
				<cfset presetSSpIONWS = -1>
			</cfif>
		</cfif>
		<cfif session.screening.prepopulate>
			<cf_handleScreeningAnswerfield action="get" code="s_sp_asset_other_a_simple" element="pre" var="presetSSpAOAS">
			<cfif Not IsNumeric(presetSSpAOAS)>
				<cfset presetSSpAOAS = -1>
			</cfif>
		</cfif>
		<cfset onLoad="init(#presetSSpIES#, #presetSSpIONWS#, #presetSSpAOAS#)">
	<cfelse>
		<cfset presetSIE = -1>
		<cfset presetSIONW = -1>
		<cfset presetSAOA = -1>
		<cfif session.screening.prepopulate>
			<cf_handleScreeningAnswerfield action="get" code="s_income_earned" element="pre" var="presetSIE">
			<cfif Not IsNumeric(presetSIE)>
				<cfset presetSIE = -1>
			</cfif>
		</cfif>
		<cfif session.screening.prepopulate>
			<cf_handleScreeningAnswerfield action="get" code="s_income_other_nw" element="pre" var="presetSIONW">
			<cfif Not IsNumeric(presetSIONW)>
				<cfset presetSIONW = -1>
			</cfif>
		</cfif>
		<cfif session.screening.prepopulate>
			<cf_handleScreeningAnswerfield action="get" code="s_asset_other_a" element="pre" var="presetSAOA">
			<cfif Not IsNumeric(presetSAOA)>
				<cfset presetSAOA = -1>
			</cfif>
		</cfif>
		<cfset onLoad="init(#presetSIE#, #presetSIONW#, #presetSAOA#)">
	</cfif>
<cfelse>
	<cfset onLoad=''>
</cfif>

	<cfif IsDefined('SESSION.partner_id') AND (SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77 )>
		<cf_buildHTML onLoad="#onLoad#" show_title="yes" guts="frmskipgrid.cfm">
		
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
		
		<cfif session.subsetGridFlag eq 2> <!--- START BIG IF --->
			
			<cfif session.marital_stat eq 'Married'>
				<cfset incassPrefix = 's_sp_'>
				<cfset incassSuffix = '_simple'>
			<cfelse>
				<cfset incassPrefix = 's_'>
				<cfset incassSuffix = ''>
			</cfif>
		
			<cfoutput>
			
			<cfif session.subset_id gt 0>
				<div class="question">
					<div class="questionHolder questionBar">
						<p>
							<span class="strong">It is important that you answer these questions to the best 
							of your ability.  If you are not sure of any answers, it is much better 
							to provide your best estimate instead of leaving it blank.  By answering 
							these questions, you will get more accurate results and recommendations.</span>
						</p>
					</div><!-- questionHolder -->
				</div><!-- question -->
			</cfif>
		
			<FORM name="formThird" id="formThird" ACTION="procgrid.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" METHOD="post">
		
			<cfloop query="getincass">
				<cfset incassRealVarName = incassPrefix & Right(incass_varname, Len(incass_varname) - 2) & incassSuffix>
				<cf_expandTextCodes text="#incass_text#" var="questionText">
				<cfif FindNoCase('_income_', incassRealVarName)>
					<cfset incassType = 'i'>
				<cfelse>
					<cfset incassType = 'a'>
				</cfif>
				<!--- 2005-08-20 BShunn  Don't display work income question if both (valid) spouses are known to be not working --->
				<cfif work_flag neq 1 Or Not IsDefined('session.work_status') OR session.work_status eq '0' OR Trim(session.work_status) eq '' OR session.work_status eq 'Employed' OR (session.marital_stat eq 'Married' AND (Not IsDefined('session.sp_work_status') OR session.sp_work_status eq '0' OR Trim(session.sp_work_status) eq '' OR session.sp_work_status eq 'Employed'))>
											
					<cfif (session.subset_id eq 14  or session.subset_id eq 28 or session.subset_id eq 34 or session.subset_id eq 35)  and  (incassRealVarName eq 's_income_other_nw' or incassRealVarName eq 's_income_earned' or incassRealVarName eq 's_asset_other_a' or incassRealVarName eq 's_sp_income_other_nw_simple' or incassRealVarName eq 's_sp_income_earned_simple' or incassRealVarName eq 's_sp_asset_other_a_simple') >
						<!-- Display Dynamic Select Boxes-->
						<cf_tagDynSelect incassRealVarName="#incassRealVarName#" incassType="#incassType#" questionText="#questionText#" listvarname="accumAFList">
					<cfelse>
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="#incassRealVarName#" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = ''>
						</cfif>
						
							<div class="question">
								<div class="questionHolder questionBar">
									<span class="question_number"><cf_showQuestionNumber>.</span>
                                    	<cfif incass_varname EQ 's_asset_other_a'>
											<cfset strippedQuestionText1 = #Replace(questionText, '<p>', '')#>
                                        	<cfset strippedQuestionText2 = #Replace(strippedQuestionText1, '</p>', '')#>
                                       		#strippedQuestionText2#
                                      	<cfelse>
											<p>
												#questionText#
											</p>
                                        </cfif>
										<p>
											<div style="float:left; padding-right:5px;">$</div> <input type="text" name="#incassRealVarName#" value="#matchVal#" onBlur="chkDollar(this,value);" size="7" maxlength="12">
										</p>
								</div><!-- questionHolder -->
							</div><!-- question -->	
		
						<cfset accumAFList = ListAppend(accumAFList, "#incassType#-#incassRealVarName#")>
					</cfif>
				</cfif> <!--- END IF Employed exclusion --->
			</cfloop>
		
			<cfif session.subsetSCHIPFlag eq 1>
				<cfset session.wantchips = 'N'>
			<cfelse>
				<div class="question">
					<div class="questionHolder questionBar">
							<p>
								If you are a grandparent, or know a grandparent, raising grandchildren you are not alone. Six percent of US children under 18 (3.9 million) live in grandparent-headed households. Additionally, over ten million children age 18 or under have no health insurance. Many families don't know their children are eligible for health insurance.
							</p>
					</div><!-- questionHolder -->
				</div><!-- question -->	
				
				<div class="question">
					<div class="questionHolder questionBar">
						<span class="question_number"><cf_showQuestionNumber>.</span> 
							<p>
								We want to make sure that every child has adequate health insurance. Do you know of any children, age 18 or younger, who do not have health insurance coverage?
							</p>
							<cfif session.screening.prepopulate>
								<cf_handleScreeningAnswerfield action="get" code="wantchips" element="pre" var="matchVal">
							<cfelse>
								<cfset matchVal = -1>
							</cfif>
							<p>
								<INPUT TYPE="radio" NAME="wantchips" VALUE="Y"<cfif matchVal Neq 0> CHECKED</cfif>>Yes &nbsp;&nbsp;
								<INPUT TYPE="radio" NAME="wantchips" VALUE="N"<cfif matchVal Eq 0> CHECKED</cfif>>No
							</p>
					</div><!-- questionHolder -->
				</div><!-- question -->	
				
				<cfset accumAFList = ListAppend(accumAFList, 'y-wantchips')>
			</cfif>
			
			<cfif session.subsetDrugFlag eq 1 
				And session.subsetOptionalFlag eq 1 
				And Not session.subset_id eq 14 
				And Not session.subset_id eq 27 
				And Not session.subset_id eq 39 And Not session.subset_id eq 70>
					<div id="surveyNav">
						<h2>Congratulations! You have just completed the last page of your <cf_tagBCU> screening.</h2>
						<p><div class="left"><input class="view_results" type="submit" value="  View Results " name="Submit" /></div></p> 
					</div>
			<cfelse>
				<div id="surveyNav">
						<p><div class="left"><input type="submit" value="  Next > " name="Submit" /></div></p> 
					</div>	

			</cfif>
			
			</cfoutput>
			
		<cfelse> <!--- ELSE BIG IF --->
		
			<cfif IsDefined('SKIPPEDPAGE')>
		<SCRIPT LANGUAGE="javascript">
		{
			alert("Please answer both questions on this page to continue!");
			history.go(-1);
		}
		</SCRIPT>
               <cfset validationError = 1>

<!---
				<div class="question">
					<div class="questionHolder questionBar">
							<p id="error_message">
								Please answer both questions on this page to continue!
							</p>
					</div><!-- questionHolder -->
				</div><!-- question -->	
--->
			</cfif>
			
			<div class="question">
				<div class="questionHolder questionBar">
						<p>
							<cfif Not IsDefined('session.partner_id') Or session.partner_id neq 5>
								<cf_displayText group="site" code="site_incass_explanation">
							<cfelse>
								<cf_displayText group="site" code="site_incass_explanation_public_only">
							</cfif>
						</p>
				</div><!-- questionHolder -->
			</div><!-- question -->	
			
			<!--- using this to do error trapping of any type --->
			<!---  finding out who the client is, so we will only pull the questions necessary --->
			<cfif #session.StrClient# IS "self">
				<cfset quesclient = "self">
			<cfelse>
				<cfset quesclient = "other">
			</cfif>
				
			<cfoutput>
				<form action="frmquestionsthird.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" name="formThird" id="formThird">
			</cfoutput>
			
			<cfif session.screening.prepopulate>
				<cf_handleScreeningAnswerfield action="get" code="skipinc" element="pre" var="matchVal1">
			<cfelse>
				<cfset matchVal1 = -1>
			</cfif>
			
			<div class="question">
				<div class="questionHolder questionBar">
					<span class="question_number"><cf_showQuestionNumber>.</span> 
						<p>
							What is your monthly income, before taxes and other deductions are taken out? Include income from you and your spouse (if married and living together) from all sources such as: Social Security, pensions, employment, and cash assistance programs. <a class="helpButton" href="javascript:void(0);" onclick="$('#showHelpAssets').hide();$('#showHelpIncome').toggle();$('#showHelpIncome').toggleClass('active');$('#pageTip').hide();$('#showHelpIncome').parents('DIV.questionBar').toggleClass('questionHighlight');$('#showHelpAssets').parents('DIV.questionBar').removeClass('questionHighlight');">HELP</a><div style="display: none;" class="helpTip" id="showHelpIncome"  onclick="$('#showHelpIncome').toggle();$('#showHelpIncome').toggleClass('active');$('#pageTip').toggle();$(this).parents('DIV.questionBar').toggleClass('questionHighlight');"><h2>Help</h2>Answering this question helps determine if we need to ask additional questions about your income. If your income is below $4,500 per month, we will ask you to provide the types of income you receive. Please estimate if you do not have your exact monthly income. </div>
						</p>
						<ul class="striping">
							<li class="questionBar">
								<input type="radio" name="skipinc" value="Y"<cfif matchVal1 Eq 1> checked='checked'</cfif>><span  style="padding-left:5px;">Income is <b>less than </b> $4,500 per month</span> 
							</li>
							<li class="questionBar">
								<input type="radio" name="skipinc" value="N"<cfif matchVal1 Eq 0> checked='checked'</cfif>><span  style="padding-left:5px;">Income is <b>more than</b> $4,500 per month</span>
							</li>
						</ul>
				</div><!-- questionHolder -->
			</div><!-- question -->	
			
			<cfset accumAFList = ListAppend(accumAFList, 'y-skipinc')>
			<cfif session.screening.prepopulate>
				<cf_handleScreeningAnswerfield action="get" code="skipassets" element="pre" var="matchVal2">
			<cfelse>
				<cfset matchVal2 = -1>
			</cfif>
			
			<div class="question">
				<div class="questionHolder questionBar">
					<span class="question_number"><cf_showQuestionNumber>.</span> 
						<p>
							What is the total value of your assets?  <b>DO NOT include the value of your home and cars.</b>  Include assets that you and your spouse (if married and living together) own such as: cash, bank accounts, stocks, bonds, CDs, and other real estate. <a class="helpButton" href="javascript:void(0);" onclick="$('#showHelpIncome').hide();$('#showHelpIncome').toggleClass('active');$('#showHelpAssets').toggle();$('#showHelpAssets').toggleClass('active');$('#pageTip').hide();$('#showHelpAssets').parents('DIV.questionBar').toggleClass('questionHighlight');$('#showHelpIncome').parents('DIV.questionBar').removeClass('questionHighlight');">HELP</a><div style="display: none;" class="helpTip" id="showHelpAssets"  onclick="$('#showHelpAssets').toggle();$('#showHelpAssets').toggleClass('active');$('#pageTip').toggle();$(this).parents('DIV.questionBar').toggleClass('questionHighlight');"><h2>Help</h2>Answering this question helps determine if we need to ask additional questions about your assets. If your assets are below $100,000, we will ask you to provide the types of assets you have. Please estimate if you do not have your exact amount for your total assets.</div>
						</p>
						<ul class="striping">
							<li class="questionBar">
								<input type="radio" name="skipassets" id="skipassets" value="Y"<cfif matchVal2 Eq 1> checked='checked'</cfif>><span  style="padding-left:5px;">Assets  are <b>less than</b> $100,000</span>
							</li>
							<li class="questionBar">
								<input type="radio" name="skipassets" id="skipassets" value="N"<cfif matchVal2 Eq 0> checked='checked'</cfif>><span style="padding-left:5px;">Assets are <b>more than</b> $100,000</span>
							</li>
						</ul>
				</div><!-- questionHolder -->
			</div><!-- question -->	
			
			<cfset accumAFList = ListAppend(accumAFList, 'y-skipassets')>
		
			<!--- start status.url --->
			<cfif session.subset_id eq 0>
			 	<div id="surveyNav">
					<h2>Keep going!  You have nearly completed the questionnaire.</h2>
					<p><div class="left"><input type="submit" value="  Next > " name="welcome" /></div></p> 
				</div>	
			<cfelse>
				<div id="surveyNav">
					<p><div class="left"><input type="submit" value="  Next > " name="skipassetssubmit" /></div></p> 
				</div>
			</cfif>
		</cfif> <!--- END BIG IF --->
		<!--- end status.url --->
		<cf_passScreeningInput varname="accumAFList" pagecode="gridscreen">
		</FORM>
		
		</div>
		
		<!--- Call footer tag --->
		</cf_buildHTML>
	<cfelse>
		<!--- PL Begins HERE --->
		<cf_buildHTML onLoad="#onLoad#" show_title="yes" guts="frmskipgrid.cfm">
		
		<table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
			<TBODY>
			<tr>
			<td bgcolor=#FFFFFF colspan=2 style="padding: 0px 12px 12px 12px;">
		<!--Dynamic Area--><font face="arial" size="4" color="#000000">
		
		
		<cfif session.subsetGridFlag eq 2> <!--- START BIG IF --->
			
			<cfif session.marital_stat eq 'Married'>
				<cfset incassPrefix = 's_sp_'>
				<cfset incassSuffix = '_simple'>
			<cfelse>
				<cfset incassPrefix = 's_'>
				<cfset incassSuffix = ''>
			</cfif>
		
		<cfoutput>
		<cfif session.subset_id gt 0>
			<span class="screeningInstructionText">It is important that you answer these questions to the best of your ability.  If you are not sure of any answers, it is much better to provide your best estimate instead of leaving it blank.  By answering these questions, you will get more accurate results and recommendations.</span>
          	<p class="text1"></p>
		</cfif>
		
		
		<FORM name="formThird" id="formThird" ACTION="procgrid.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" METHOD="post">
		<font face="arial" size="3" color="##000000">
		
		<TABLE valign="top" border="0" class="text1" style="font-size:14px;font-famly:arial;">
		
		<cfloop query="getincass">
			<cfset incassRealVarName = incassPrefix & Right(incass_varname, Len(incass_varname) - 2) & incassSuffix>
			<cf_expandTextCodes text="#incass_text#" var="questionText">
			<cfif FindNoCase('_income_', incassRealVarName)>
				<cfset incassType = 'i'>
			<cfelse>
				<cfset incassType = 'a'>
			</cfif>
			<!--- 2005-08-20 BShunn  Don't display work income question if both (valid) spouses are known to be not working --->
			<cfif work_flag neq 1 Or Not IsDefined('session.work_status') OR session.work_status eq '0' OR Trim(session.work_status) eq '' OR session.work_status eq 'Employed' OR (session.marital_stat eq 'Married' AND (Not IsDefined('session.sp_work_status') OR session.sp_work_status eq '0' OR Trim(session.sp_work_status) eq '' OR session.sp_work_status eq 'Employed'))>
										
				<cfif (session.subset_id eq 14  or session.subset_id eq 28 or session.subset_id eq 34 or session.subset_id eq 35)  and  (incassRealVarName eq 's_income_other_nw' or incassRealVarName eq 's_income_earned' or incassRealVarName eq 's_asset_other_a' or incassRealVarName eq 's_sp_income_other_nw_simple' or incassRealVarName eq 's_sp_income_earned_simple' or incassRealVarName eq 's_sp_asset_other_a_simple') >
					<!-- Display Dynamic Select Boxes-->
					<cf_tagDynSelect incassRealVarName="#incassRealVarName#" incassType="#incassType#" questionText="#questionText#" listvarname="accumAFList">
				<cfelse>
					<cfif session.screening.prepopulate>
						<cf_handleScreeningAnswerfield action="get" code="#incassRealVarName#" element="pre" var="matchVal">
					<cfelse>
						<cfset matchVal = ''>
					</cfif>
					<!--- Display Standard Input --->
					<TR valign="top">
						<TD VALIGN='top' WIDTH='35'><FONT FACE='arial'><B><cf_showQuestionNumber>.</B></FONT></TD>
						<td><font face="arial">#questionText#</font></td>
					</tr>
					<TR>
						<TD></TD>
						<TD><font face="arial"><CF_TagYeWhiteSpace>
		$ <input type="text" name="#incassRealVarName#" value="#matchVal#" onBlur="chkDollar(this,value);" size="7" maxlength="12">
							</font></td>
					</tr>
					<cfset accumAFList = ListAppend(accumAFList, "#incassType#-#incassRealVarName#")>
				</cfif>
			</cfif> <!--- END IF Employed exclusion --->
		</cfloop>
		
		
		
		<cfif session.subsetSCHIPFlag eq 1>
			<cfset session.wantchips = 'N'>
		<cfelse>
		
		<tr>
				<TD colspan="2">
					<span class="screeningInstructionText">If you are a grandparent, or know a grandparent, raising grandchildren you are not alone. Six percent of US children under 18 (3.9 million) live in grandparent-headed households. Additionally, over ten million children age 18 or under have no health insurance. Many families don't know their children are eligible for health insurance.</SPAN>
                    <p class="text1"></p>
				</td>
		</tr>
		<tr>
				<TD VALIGN='top' WIDTH='35'><FONT FACE='arial'><B><cf_showQuestionNumber>.</B></FONT></TD>
				<TD VALIGN="top">
		 <FONT face="Arial">We want to make sure that every child has adequate health insurance.  Do you know of any children, age 18 or younger, who do not have health insurance coverage?
							</font></td>
						</tr>
						<TR>
							<TD>
							</TD>
							<TD><font face="arial">
					<CF_TagYeWhiteSpace>
					<cfif session.screening.prepopulate>
						<cf_handleScreeningAnswerfield action="get" code="wantchips" element="pre" var="matchVal">
					<cfelse>
						<cfset matchVal = -1>
					</cfif>
					<INPUT TYPE="radio" NAME="wantchips" VALUE="Y"<cfif matchVal Neq 0> CHECKED</cfif>>Yes &nbsp;&nbsp;
					<INPUT TYPE="radio" NAME="wantchips" VALUE="N"<cfif matchVal Eq 0> CHECKED</cfif>>No</font>
							</td>
						</tr>
					<cfset accumAFList = ListAppend(accumAFList, 'y-wantchips')>
		</cfif>
		</table>
		
		<br>
			<font face="Arial">
			<cfif session.subsetDrugFlag eq 1 And session.subsetOptionalFlag eq 1 And Not session.subset_id eq 14 And Not session.subset_id eq 27 And Not session.subset_id eq 39 And Not session.subset_id eq 70>
			<span class="screeningInstructionText"><b>Congratulations!<b></span><br>
            <span class="screeningInstructionText"><b>You have just completed the last page of <cfif session.partner_id eq 22 and session.subset_id eq 70>the SNAP &amp; SCSEP Benefits Screening.<cfelse>NCOA's <cf_tagBCU>.</cfif></b></span>
			<p class="text1"></p>
			<b><input type="submit" name="Submit" value=" View Results "></b>
			<cfelse>
		    <div align="right"><b><input type="submit" name="Submit" value="Next"></b></div>
			</cfif>
			</cfoutput>
		<cfelse> <!--- ELSE BIG IF --->
		<CFIF ISDEFINED('SKIPPEDPAGE')>
		<FONT class="text1" COLOR="RED" Face="arial"><i>Please answer both questions on this page to continue!</FONT></i>
		<br>
		</cfif>
        <span class="screeningInstructionText">
            <cfif Not IsDefined('session.partner_id') Or session.partner_id neq 5>
                <cf_displayText group="site" code="site_incass_explanation">
            <cfelse>
                <cf_displayText group="site" code="site_incass_explanation_public_only">
            </cfif>
        </span>
		<p class="text1"></p>
        		
		<!--- useing this to do error trapping of any type --->
		<!---  finding out who the client is, so we will only pull the questions necessary --->
			<CFIF #session.StrClient# IS "self">
				<CFSET quesclient = "self">
			<CFELSE>
				<CFSET quesclient = "other">
			</CFIF>
		<cfoutput><form action="frmquestionsthird.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" name="formThird" id="formThird"></cfoutput>
		<TABLE valign="top" border="0" class="text1" style="font-size:14px;font-famly:arial;">
					<cfif session.screening.prepopulate>
						<cf_handleScreeningAnswerfield action="get" code="skipinc" element="pre" var="matchVal1">
					<cfelse>
						<cfset matchVal1 = -1>
					</cfif>
						<TR valign="top">
							<TD VALIGN='top' WIDTH='35'><FONT FACE='arial'><B><cf_showQuestionNumber>.</B></FONT></TD>
							<TD VALIGN='top'>
								<FONT FACE='arial'>
									Do you estimate that your monthly income, before taxes and other deductions are taken out, is less than or equal to $4,500? (Include income from all sources such as: Social Security, pensions, employment, cash assistance programs, etc.)  Include spouse income, if spouse is living with you. <cf_displayHelpLink code="skipincome"><BR />
				<p>
				 <ul><input type="radio" name="skipinc" value="Y"<cfif matchVal1 Eq 1> checked='checked'</cfif>> Income <b>less than or equal to </b>$4,500 per month <br>
			
		         <input type="radio" name="skipinc" value="N"<cfif matchVal1 Eq 0> checked='checked'</cfif>> Income <b>greater than</b> $4,500 per month</ul></td></tr><tr><td>
								</FONT>
							</TD>
						</TR>
					<cfset accumAFList = ListAppend(accumAFList, 'y-skipinc')>
					<cfif session.screening.prepopulate>
						<cf_handleScreeningAnswerfield action="get" code="skipassets" element="pre" var="matchVal2">
					<cfelse>
						<cfset matchVal2 = -1>
					</cfif>
						<TR valign="top">
							<TD VALIGN='top' WIDTH='35'><FONT FACE='arial'><B><cf_showQuestionNumber>.</B></FONT></TD>
							<TD VALIGN='top'>
								<FONT FACE='arial'>
									Do you estimate that the value of your assets, <b>NOT including your home and car</b>, is less than or equal to $100,000?  (Include assets such as: cash, bank accounts, stocks, bonds, CDs, other real estate, etc. If you have more than one car, do not include the most valuable car.) Include spouse assets, if spouse is living with you. <cf_displayHelpLink code="skipassets"><br>
			<p>				
		<ul><input type="radio" name="skipassets" id="skipassets" value="Y"<cfif matchVal2 Eq 1> checked='checked'</cfif>> Assets <b>less than or equal to</b> $100,000 <br>
		<input type="radio" name="skipassets" id="skipassets" value="N"<cfif matchVal2 Eq 0> checked='checked'</cfif>> Assets <b>greater than</b> $100,000</ul></td></tr><tr><td colspan="2" align="right">
		<FONT FACE="arial"><b><input type="submit" value="  Next  " name="skipassetssubmit"></b></FONT>
								</FONT>
							</TD>
							<TD valign="bottom"></TD>
						</TR>
					<cfset accumAFList = ListAppend(accumAFList, 'y-skipassets')>
		</TABLE>
		</cfif> <!--- END BIG IF --->
		
		<!--- start status.url --->
		<cfif session.subset_id eq 0>
		 <span class="screeningInstructionText"><b>Keep going!  You have nearly completed the questionnaire.</b></span>
		</cfif>
		<!--- end status.url --->
		<cf_passScreeningInput varname="accumAFList" pagecode="gridscreen">
		</FORM>
		</FONT></TD></TR></TBODY></TABLE>
		
		<!--- Call footer tag --->
		</cf_buildHTML>
	</cfif>

</cfif> <!--- END BIGGER IF --->
