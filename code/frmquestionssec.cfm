<!----=======================================
DESCRIPTION: this is the questionnaire.  Pulls questions from 
	the db, puts them in array, then checks to see if they should
	be asked, then stres the answers in session variables.
CALLED BY: frmQuestions.cfm
GOES TO: frmQuestionsSecDep.cfm
REQUIRED:N/A
============================================---->
<cf_logScreeningInput initvarname="accumAFList">
<cfif IsDefined('SESSION.partner_id') AND (SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77 )>

	<cf_buildHTML show_title="yes" guts="frmquestionssec.cfm"> 
	<style>
		#pageTip{ top:0px !important;}
	</style>
		
	<div class="row survey">
	
	<CFIF ISDEFINED("form.next2")>
		<!--- set a new array to hold the questions --->
		<CFSET Session.QuestionSecArray = ArrayNew(2)>
		<CFSET QuestionSecArray2 = ArrayNew(2)>
		<!---=================================================================== --->
		
		<!--- This query pulls all the questions that are possible for the state entered --->
	
		<!--- 09/01/2002 REM  Modified to add in a new subselect for RX Only --->
		<!--- 01/14/2003 BShunn / Rewrote as a single query, because of stack problems on Production --->
		<!--- 01/26/2004 BS  Rewrote query to use subset_id in pulling questions --->
		<!--- 04/29/2005 BS  Rewrote query to use new subset schema in pulling questions --->
		<cf_populateTableFromView table="subset_program_base" subset_id="#session.subset_id#">
		<cf_populateTableFromView table="program_parent">
		<cfquery name="build_array" datasource="#application.dbSrc#">
			SELECT q.question_id, q.pri_sec, q.answerfield, q.type, q.textlength, q.validation, q.dep_formula, q.category, q.order_num, 0 AS options_flag
			FROM (
				SELECT q.question_id, q.question_code, qc.questioncategory_code, a.page_id
				FROM (
					SELECT q.question_id, NULL AS page_id
					FROM (
						SELECT pa.answerfield_id
						FROM subset_program_base sp, program p, program_answerfield pa, answerfield a
						WHERE sp.subset_id=#session.subset_id#
	
							AND sp.program_id=p.program_id
							AND (p.state_id IS NULL or p.state_id='#session.st#')
							AND p.active_flag=1
							AND p.program_id=pa.program_id
							AND pa.answerfield_id NOT IN (
								SELECT answerfield_id
								FROM answerfield_subset_partner
								WHERE subset_id=#session.subset_id#
									AND (partner_id is null or partner_id=#session.partner_id#)
									AND background_flag=1
							)
	
							AND pa.answerfield_id=a.answerfield_id
	
							AND (a.state_id IS NULL or a.state_id='#session.st#')
	
						UNION
						SELECT ar.right_answerfield_id as answerfield_id
						FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
						WHERE sp.subset_id=#session.subset_id#
							AND sp.program_id=p.program_id
							AND (p.state_id IS NULL or p.state_id='#session.st#')
							AND p.active_flag=1
							AND p.program_id=pa.program_id
							AND pa.answerfield_id NOT IN (
								SELECT answerfield_id
								FROM answerfield_subset_partner
								WHERE subset_id=#session.subset_id#
									AND (partner_id is null or partner_id=#session.partner_id#)
									AND background_flag=1
							)
							AND pa.answerfield_id=ar.left_answerfield_id
							AND ar.relationship_id=2
							AND ar.right_answerfield_id=a.answerfield_id
							AND (a.state_id IS NULL or a.state_id='#session.st#')
						
						UNION
						SELECT pa.answerfield_id
						FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
						WHERE sp.subset_id=#session.subset_id#
							AND sp.program_id=p.program_id
							AND (p.state_id IS NULL or p.state_id='#session.st#')
							AND p.active_flag=1
							AND p.program_id=pa.program_id
							AND pa.answerfield_id NOT IN (
								SELECT answerfield_id
								FROM answerfield_subset_partner
								WHERE subset_id=#session.subset_id#
									AND (partner_id is null or partner_id=#session.partner_id#)
									AND background_flag=1
							)
	
							AND pa.answerfield_id=a.answerfield_id
	
							AND (a.state_id IS NULL or a.state_id='#session.st#')
							AND pa.program_id in
							(	select  pp.parent_program_id
								from program_parent pp, program p, subset_program_base spb
								where 
								spb.program_id = pp.program_id
								and pp.program_id = p.program_id
								and spb.subset_id = #session.subset_id#
								and ( p.state_id = '#session.st#' or p.state_id is NULL )
							)
	
						UNION
						SELECT ar.right_answerfield_id as answerfield_id
						FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
						WHERE sp.subset_id=#session.subset_id#
							AND sp.program_id=p.program_id
							AND (p.state_id IS NULL or p.state_id='#session.st#')
							AND p.active_flag=1
							AND p.program_id=pa.program_id
							AND pa.answerfield_id NOT IN (
								SELECT answerfield_id
								FROM answerfield_subset_partner
								WHERE subset_id=#session.subset_id#
									AND (partner_id is null or partner_id=#session.partner_id#)
									AND background_flag=1
							)
							AND pa.answerfield_id=ar.left_answerfield_id
							AND ar.relationship_id=2
							AND ar.right_answerfield_id=a.answerfield_id
							AND (a.state_id IS NULL or a.state_id='#session.st#')
							and pa.program_id in
							(	select  pp.parent_program_id
								from program_parent pp, program p, subset_program_base spb
								where 
								spb.program_id = pp.program_id
								and pp.program_id = p.program_id
								and spb.subset_id = #session.subset_id#
								and ( p.state_id = '#session.st#' or p.state_id is NULL )
							)
	
					) AS a, question_answerfield qa, question q
					WHERE a.answerfield_id=qa.answerfield_id
							AND <cfif session.subset_id neq 27 Or session.partner_id neq 8>qa.question_id NOT IN (
								SELECT question_id
								FROM subset_question
								WHERE subset_id=#session.subset_id#
									AND exclude_flag=1
							)
							AND </cfif>qa.question_id=q.question_id
							AND q.exclude_flag=0
					<cfif session.subset_id neq 27 Or session.partner_id neq 8>UNION
					SELECT q.question_id, sq.page_id
					FROM subset_question sq, question q
					WHERE sq.subset_id=#session.subset_id#
						AND sq.exclude_flag=0
						AND sq.question_id=q.question_id
					</cfif>UNION
					SELECT q.question_id, NULL AS page_id
					FROM question q
					WHERE q.include_flag=1
						AND q.question_id NOT IN (
							SELECT question_id
							FROM subset_question
							WHERE subset_id=#session.subset_id#
								AND exclude_flag=1
						)
				) AS a, question q, questioncategory qc
				WHERE a.question_id=q.question_id
					AND q.questioncategory_id=qc.questioncategory_id
			) sq, tbl_questions_new q, question qq, questioncategory qc
			WHERE sq.question_id=q.question_id
				AND q.client='self'
				AND q.pri_sec='sec'
				AND q.type is not null
				AND q.question_id=qq.question_id
				AND qq.questioncategory_id=qc.questioncategory_id
				<cfif session.partner_id neq 0 or session.org_id gt 0>
				AND q.question_id <> 645
				AND q.question_id <> 646
				</cfif>
	
			ORDER BY qc.sort, qq.sort
		</cfquery>
		<cfif isdefined('session.int_caregiver_obligations') ><h2>in home care is <cfoutput>#session.int_caregiver_obligations#</cfoutput></h2></cfif>
		<!--- Now we want to put the query into an session array, so we dont have to re-query the DB --->
		<!--- Populate the array row by row --->
		<cfloop query="build_array">
			<cfquery name="build_array_question_text" datasource="#application.dbSrc#">
				select question
				from tbl_questions_new
				where question_id = #build_array.question_id[CurrentRow]#
			</cfquery>
				   <CFSET QuestionSecArray2[CurrentRow][1] = build_array.question_id[CurrentRow]>
				   <CFSET QuestionSecArray2[CurrentRow][2] = build_array_question_text.question>
				   <CFSET QuestionSecArray2[CurrentRow][3] = build_array.pri_sec[CurrentRow]>
				   <CFSET QuestionSecArray2[CurrentRow][4] = build_array.answerfield[CurrentRow]>
				   <CFSET QuestionSecArray2[CurrentRow][5] = build_array.type[CurrentRow]>
				   <CFSET QuestionSecArray2[CurrentRow][6] = build_array.textlength[CurrentRow]>
				   <CFSET QuestionSecArray2[CurrentRow][7] = build_array.validation[CurrentRow]>
				   <CFSET QuestionSecArray2[CurrentRow][8] = build_array.dep_formula[CurrentRow]>
				   <CFSET QuestionSecArray2[CurrentRow][9] = build_array.options_flag[CurrentRow]>
		</cfloop>
		
		<CFIF ArrayLen(QuestionSecArray2) LT 1 And Not (session.subset_id eq 14 And ((StructKeyExists(session.screening.afval, 'receive_employ_retiree') And StructFind(session.screening.afval, 'receive_employ_retiree') eq 1) OR (StructKeyExists(session.screening.afval, 'receive_medigap') And StructFind(session.screening.afval, 'receive_medigap') eq 1)))>
			<CFLOCATION url="frmskipgrid.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" addtoken="No">
			<cfset session.chips = "now">
		</CFIF>
		
		<CFSET y = 1>
		<CFLOOP index="x" from="1" to="#ArrayLen(QuestionSecArray2)#">
				<CFSET test = #QuestionSecArray2[x][8]#>
				<CFSET temp=#EVALUATE("#test#")#>
					<CFIF temp IS "Yes">
						<CFSET Session.QuestionSecArray[y][1] = QuestionSecArray2[x][1]>
						<CFSET Session.QuestionSecArray[y][2] = QuestionSecArray2[x][2]>
						<CFSET Session.QuestionSecArray[y][3] = QuestionSecArray2[x][3]>
						<CFSET Session.QuestionSecArray[y][4] = QuestionSecArray2[x][4]>
						<CFSET Session.QuestionSecArray[y][5] = QuestionSecArray2[x][5]>
						<CFSET Session.QuestionSecArray[y][6] = QuestionSecArray2[x][6]>
						<CFSET Session.QuestionSecArray[y][7] = QuestionSecArray2[x][7]>
						<CFSET Session.QuestionSecArray[y][8] = QuestionSecArray2[x][8]>
						<CFSET Session.QuestionSecArray[y][9] = QuestionSecArray2[x][9]>
						<CFSET y = y + 1>
					</CFIF>
		</CFLOOP>
		
		<CFIF ArrayLen(Session.QuestionSecArray) LT 1 And Not (session.subset_id eq 14 And ((StructKeyExists(session.screening.afval, 'receive_employ_retiree') And StructFind(session.screening.afval, 'receive_employ_retiree') eq 1) OR (StructKeyExists(session.screening.afval, 'receive_medigap') And StructFind(session.screening.afval, 'receive_medigap') eq 1)))>
				<CFLOCATION url="frmskipgrid.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" addtoken="No">
			<cfset session.chips = "now">
		</CFIF>
	
	</CFIF>
	<!--- End of the section for if coming from the Primary page --->
	<!--- ===================================================================== --->
	
	
	<!--- the end of the if statement on which page coming from --->
	<!--- ===================================================================== --->
	<!--- Set the numbering for the page and check to see if it is still in line and if user used the back button --->
	<CFIF Not IsDefined('form.StartRow')>
		<CFSET StartRow = 1>
	</CFIF>
	
	<CFIF Not IsDefined('form.EndRow')>
		<CFSET EndRow = 6>
	</CFIF>
	
	<!--- Check to see if anymore questions left and if need to submit to self or to next set of questions --->
	<CFIF EndRow GTE #ArrayLen(Session.QuestionSecArray)#>
		<cfoutput><FORM action="frmquestionssecdep.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="Post" name="questions" onsubmit="return false;"></cfoutput>
	<CFELSE>
		<cfoutput><FORM action="frmquestionssec.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="Post" name="questions"></cfoutput>
		
		<CFOUTPUT>
			<CFSET NextStart = StartRow + 6>
			<CFSET NextEnd = EndRow + 6>
			<INPUT type="hidden" name="StartRow" value="#NextStart#">
			<INPUT type="hidden" name="EndRow" value="#NextEnd#">
		</CFOUTPUT>
	</CFIF>
	
	<!--- output the initial array values--->
	<CFIF Endrow GTE #ArrayLen(Session.QuestionSecArray)#>
		<CFSET EndRow = #ArrayLen(Session.QuestionSecArray)#>
	</cfif>
	
	<!--- End of the numbering code --->
	<!---===================================================================--->
	<!--- Beginning of the output of the questions --->
	
	
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
						<p class="strong">
							Please note that these questions are being asked due 
					to your answers to previous questions. If you need help answering a 
					question, click the <u>HELP</u> link next to some questions.  
						</p>
				</div><!-- questionHolder -->
			</div><!-- question -->	

		<CFLOOP index="i" from="#StartRow#" to="#EndRow#">
		
			<div class="question">
				<div class="questionHolder questionBar">
					<span class="question_number"><cf_showQuestionNumber>.</span> 
						<!---p--->
							<!---Bug 6888 - 'extra help' Definition not showing in 'lis_undeemed' question --->
							<!---cfif SESSION.QuestionSecArray[i][4] EQ 'lis_apply'>
								Have you recently (in the last three months) applied for the <script>$(function() { $("#show_extra_help_def").click(function() { $("#extra_help_def").toggle(); return false; }); $("#extra_help_def").click(function() { $("#extra_help_def").toggle();$(".questionHolder").removeClass("questionHighlight"); return false; }); });</script><a class="helpTrigger" id="show_extra_help_def" href="javascript:void(0);" style="font-size:14px; clear:right;">Extra Help</a> available through the Medicare Prescription Drug Coverage? <div style="display: none;" id="extra_help_def" class="helpTip"><h2>Extra Help</h2>People with Medicare who have limited incomes and resources will be eligible to receive Extra Help through the Medicare Prescription Drug Coverage which will cover between 85 percent and 100 percent of prescription drug costs.</div>
							<cfelseif SESSION.QuestionSecArray[i][4] EQ 'lis_undeemed'>
								Have you received a letter from Medicare saying that you will no longer automatically qualify for the <script>$(function() { $("#show_extra_help").click(function() { $("#extra_help").toggle(); return false; }); $("#extra_help").click(function() { $("#extra_help").toggle();$(".questionHolder").removeClass("questionHighlight"); return false; }); });</script><a class="helpTrigger" id="show_extra_help" href="javascript:void(0);" style="font-size:14px;">Extra Help</a> available through the Medicare Prescription Drug Coverage in 2013? <div style="display: none;" id="extra_help" class="helpTip"><h2>Extra Help</h2>People with Medicare who have limited incomes and resources will be eligible to receive Extra Help through the Medicare Prescription Drug Coverage which will cover between 85 percent and 100 percent of prescription drug costs.</div>
							<cfelse--->
                            	<cf_displayText code="question_#session.QuestionSecArray[i][4]#" group="question">
								<cfset hcode=session.QuestionSecArray[i][4]><cf_displayHelpLink code="#hcode#">
							<!---/cfif--->
						
							
						<!---/p--->
                        <cfset preaccumAFList = #ListLen(accumAFList)#>
						<p>
							<CF_TagYeSetAnswerField answerfield="#Session.QuestionSecArray[i][4]#" answerTYPE="#Session.QuestionSecArray[i][5]#" textlength="#Session.QuestionSecArray[i][6]#" validation="#Session.QuestionSecArray[i][7]#" options_flag="#Session.QuestionSecArray[i][9]#" listvarname="accumAFList">
						</p>
                        <cfquery name="getQType" datasource="#application.dbSrc#">
                            select questiontype_id
                            from question
                            where question_id = #SESSION.QuestionSecArray[i][1]#
                        </cfquery>
                        <cfif getQType.questiontype_id EQ 4><cfset isMultiSelect = 1><cfelse><cfset isMultiSelect = 0></cfif>
                        <cfif isMultiSelect EQ 1>
                        	<cfset numCheckBoxes = #ListLen(accumAFList)# - #preaccumAFList#>
                            <cfif numCheckBoxes GT 1><p><strong>(check all that apply)</strong></p></cfif>
                        </cfif>
				</div><!-- questionHolder -->
			</div><!-- question -->	
					
		</CFLOOP>
		
		<div id="surveyNav">
			<input type="hidden" name="next2" value="next2">
			<!---<h2>Keep up the good work. You've passed the midway point of the questionnaire.</h2>--->
			<p><div class="left"><input type="submit" value="  Next > " name="next" onClick="document.questions.submit();" /></div></p> 
		</div>	
	
		<cf_passScreeningInput varname="accumAFList">
	
		</FORM>
	</div>
	</cf_buildHTML>
<cfelse>

	<!--- PL Begins HERE --->
		<cf_buildHTML show_title="yes" guts="frmquestionssec.cfm"> 
		<table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
			<TBODY>
			<tr>
			<td bgcolor=#FFFFFF colspan=2 style="padding: 0px 12px 12px 12px;">
		<!--Dynamic Area--><font face="arial" size="4" color="#000000">
		<!--- =================================================================== --->
		
		<!--- if coming from welcome screen ---->
		<span class="screeningInstructionText">Please note that these questions are being asked due to your answers to previous questions. If you need help answering a question, click the <font size="2"><u>HELP</u></font> link next to some questions.</span>
		
		<CFIF ISDEFINED("Next")>
			<!--- set a new array to hold the questions --->
			<CFSET Session.QuestionSecArray = ArrayNew(2)>
			<CFSET QuestionSecArray2 = ArrayNew(2)>
			<!---=================================================================== --->
			
			<!--- This query pulls all the questions that are possible for the state entered --->
		
			<!--- 09/01/2002 REM  Modified to add in a new subselect for RX Only --->
			<!--- 01/14/2003 BShunn / Rewrote as a single query, because of stack problems on Production --->
			<!--- 01/26/2004 BS  Rewrote query to use subset_id in pulling questions --->
			<!--- 04/29/2005 BS  Rewrote query to use new subset schema in pulling questions --->
			<cf_populateTableFromView table="subset_program_base" subset_id="#session.subset_id#">
		<cf_populateTableFromView table="program_parent">
		<cfquery name="build_array" datasource="#application.dbSrc#">
			SELECT q.question_id, q.pri_sec, q.answerfield, q.type, q.textlength, q.validation, q.dep_formula, q.category, q.order_num, 0 AS options_flag
			FROM (
				SELECT q.question_id, q.question_code, qc.questioncategory_code, a.page_id
				FROM (
					SELECT q.question_id, NULL AS page_id
					FROM (
						SELECT pa.answerfield_id
						FROM subset_program_base sp, program p, program_answerfield pa, answerfield a
						WHERE sp.subset_id=#session.subset_id#
	
							AND sp.program_id=p.program_id
							AND (p.state_id IS NULL or p.state_id='#session.st#')
							AND p.active_flag=1
							AND p.program_id=pa.program_id
							AND pa.answerfield_id NOT IN (
								SELECT answerfield_id
								FROM answerfield_subset_partner
								WHERE subset_id=#session.subset_id#
									AND (partner_id is null or partner_id=#session.partner_id#)
									AND background_flag=1
							)
	
							AND pa.answerfield_id=a.answerfield_id
	
							AND (a.state_id IS NULL or a.state_id='#session.st#')
	
						UNION
						SELECT ar.right_answerfield_id as answerfield_id
						FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
						WHERE sp.subset_id=#session.subset_id#
							AND sp.program_id=p.program_id
							AND (p.state_id IS NULL or p.state_id='#session.st#')
							AND p.active_flag=1
							AND p.program_id=pa.program_id
							AND pa.answerfield_id NOT IN (
								SELECT answerfield_id
								FROM answerfield_subset_partner
								WHERE subset_id=#session.subset_id#
									AND (partner_id is null or partner_id=#session.partner_id#)
									AND background_flag=1
							)
							AND pa.answerfield_id=ar.left_answerfield_id
							AND ar.relationship_id=2
							AND ar.right_answerfield_id=a.answerfield_id
							AND (a.state_id IS NULL or a.state_id='#session.st#')
						
						UNION
						SELECT pa.answerfield_id
						FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
						WHERE sp.subset_id=#session.subset_id#
							AND sp.program_id=p.program_id
							AND (p.state_id IS NULL or p.state_id='#session.st#')
							AND p.active_flag=1
							AND p.program_id=pa.program_id
							AND pa.answerfield_id NOT IN (
								SELECT answerfield_id
								FROM answerfield_subset_partner
								WHERE subset_id=#session.subset_id#
									AND (partner_id is null or partner_id=#session.partner_id#)
									AND background_flag=1
							)
	
							AND pa.answerfield_id=a.answerfield_id
	
							AND (a.state_id IS NULL or a.state_id='#session.st#')
							AND pa.program_id in
							(	select  pp.parent_program_id
								from program_parent pp, program p, subset_program_base spb
								where 
								spb.program_id = pp.program_id
								and pp.program_id = p.program_id
								and spb.subset_id = #session.subset_id#
								and ( p.state_id = '#session.st#' or p.state_id is NULL )
							)
	
						UNION
						SELECT ar.right_answerfield_id as answerfield_id
						FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
						WHERE sp.subset_id=#session.subset_id#
							AND sp.program_id=p.program_id
							AND (p.state_id IS NULL or p.state_id='#session.st#')
							AND p.active_flag=1
							AND p.program_id=pa.program_id
							AND pa.answerfield_id NOT IN (
								SELECT answerfield_id
								FROM answerfield_subset_partner
								WHERE subset_id=#session.subset_id#
									AND (partner_id is null or partner_id=#session.partner_id#)
									AND background_flag=1
							)
							AND pa.answerfield_id=ar.left_answerfield_id
							AND ar.relationship_id=2
							AND ar.right_answerfield_id=a.answerfield_id
							AND (a.state_id IS NULL or a.state_id='#session.st#')
							and pa.program_id in
							(	select  pp.parent_program_id
								from program_parent pp, program p, subset_program_base spb
								where 
								spb.program_id = pp.program_id
								and pp.program_id = p.program_id
								and spb.subset_id = #session.subset_id#
								and ( p.state_id = '#session.st#' or p.state_id is NULL )
							)
	
					) AS a, question_answerfield qa, question q
					WHERE a.answerfield_id=qa.answerfield_id
							AND <cfif session.subset_id neq 27 Or session.partner_id neq 8>qa.question_id NOT IN (
								SELECT question_id
								FROM subset_question
								WHERE subset_id=#session.subset_id#
									AND exclude_flag=1
							)
							AND </cfif>qa.question_id=q.question_id
							AND q.exclude_flag=0
					<cfif session.subset_id neq 27 Or session.partner_id neq 8>UNION
					SELECT q.question_id, sq.page_id
					FROM subset_question sq, question q
					WHERE sq.subset_id=#session.subset_id#
						AND sq.exclude_flag=0
						AND sq.question_id=q.question_id
					</cfif>UNION
					SELECT q.question_id, NULL AS page_id
					FROM question q
					WHERE q.include_flag=1
						AND q.question_id NOT IN (
							SELECT question_id
							FROM subset_question
							WHERE subset_id=#session.subset_id#
								AND exclude_flag=1
						)
				) AS a, question q, questioncategory qc
				WHERE a.question_id=q.question_id
					AND q.questioncategory_id=qc.questioncategory_id
			) sq, tbl_questions_new q, question qq, questioncategory qc
			WHERE sq.question_id=q.question_id
				AND q.client='self'
				AND q.pri_sec='sec'
				AND q.type is not null
				AND q.question_id=qq.question_id
				AND qq.questioncategory_id=qc.questioncategory_id
				<cfif session.partner_id neq 0 or session.org_id gt 0>
				AND q.question_id <> 645
				AND q.question_id <> 646
				</cfif>
	
			ORDER BY qc.sort, qq.sort
		</cfquery>
			
			<!--- Now we want to put the query into an session array, so we dont have to re-query the DB --->
			<!--- Populate the array row by row --->
			<cfloop query="build_array">
				<cfquery name="build_array_question_text" datasource="#application.dbSrc#">
					select question
					from tbl_questions_new
					where question_id = #build_array.question_id[CurrentRow]#
				</cfquery>
					   <CFSET QuestionSecArray2[CurrentRow][1] = build_array.question_id[CurrentRow]>
					   <CFSET QuestionSecArray2[CurrentRow][2] = build_array_question_text.question>
					   <CFSET QuestionSecArray2[CurrentRow][3] = build_array.pri_sec[CurrentRow]>
					   <CFSET QuestionSecArray2[CurrentRow][4] = build_array.answerfield[CurrentRow]>
					   <CFSET QuestionSecArray2[CurrentRow][5] = build_array.type[CurrentRow]>
					   <CFSET QuestionSecArray2[CurrentRow][6] = build_array.textlength[CurrentRow]>
					   <CFSET QuestionSecArray2[CurrentRow][7] = build_array.validation[CurrentRow]>
					   <CFSET QuestionSecArray2[CurrentRow][8] = build_array.dep_formula[CurrentRow]>
					   <CFSET QuestionSecArray2[CurrentRow][9] = build_array.options_flag[CurrentRow]>
			</cfloop>
			
			<CFIF ArrayLen(QuestionSecArray2) LT 1 And Not (session.subset_id eq 14 And ((StructKeyExists(session.screening.afval, 'receive_employ_retiree') And StructFind(session.screening.afval, 'receive_employ_retiree') eq 1) OR (StructKeyExists(session.screening.afval, 'receive_medigap') And StructFind(session.screening.afval, 'receive_medigap') eq 1)))>
				<CFLOCATION url="frmskipgrid.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" addtoken="No">
				<cfset session.chips = "now">
			</CFIF>
			
			<CFSET y = 1>
			<CFLOOP index="x" from="1" to="#ArrayLen(QuestionSecArray2)#">
					<CFSET test = #QuestionSecArray2[x][8]#>
					<CFSET temp=#EVALUATE("#test#")#>
						<CFIF temp IS "Yes">
							<CFSET Session.QuestionSecArray[y][1] = QuestionSecArray2[x][1]>
							<CFSET Session.QuestionSecArray[y][2] = QuestionSecArray2[x][2]>
							<CFSET Session.QuestionSecArray[y][3] = QuestionSecArray2[x][3]>
							<CFSET Session.QuestionSecArray[y][4] = QuestionSecArray2[x][4]>
							<CFSET Session.QuestionSecArray[y][5] = QuestionSecArray2[x][5]>
							<CFSET Session.QuestionSecArray[y][6] = QuestionSecArray2[x][6]>
							<CFSET Session.QuestionSecArray[y][7] = QuestionSecArray2[x][7]>
							<CFSET Session.QuestionSecArray[y][8] = QuestionSecArray2[x][8]>
							<CFSET Session.QuestionSecArray[y][9] = QuestionSecArray2[x][9]>
							<CFSET y = y + 1>
						</CFIF>
			</CFLOOP>
			
			<CFIF ArrayLen(Session.QuestionSecArray) LT 1 And Not (session.subset_id eq 14 And ((StructKeyExists(session.screening.afval, 'receive_employ_retiree') And StructFind(session.screening.afval, 'receive_employ_retiree') eq 1) OR (StructKeyExists(session.screening.afval, 'receive_medigap') And StructFind(session.screening.afval, 'receive_medigap') eq 1)))>
					<CFLOCATION url="frmskipgrid.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" addtoken="No">
				<cfset session.chips = "now">
			</CFIF>
			
		</CFIF>
		<!--- End of the section for if coming from the Primary page --->
		<!--- ===================================================================== --->
		
		
		<!--- the end of the if statement on which page coming from --->
		<!--- ===================================================================== --->
		<!--- Set the numbering for the page and check to see if it is still in line and if user used the back button --->
		<CFIF Not IsDefined('form.StartRow')>
			<CFSET StartRow = 1>
		</CFIF>
		
		<CFIF Not IsDefined('form.EndRow')>
			<CFSET EndRow = 6>
		</CFIF>
		
		<!--- Check to see if anymore questions left and if need to submit to self or to next set of questions --->
		<CFIF EndRow GTE #ArrayLen(Session.QuestionSecArray)#>
			<cfoutput><FORM action="frmquestionssecdep.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="Post" name="questions" onsubmit="return false;"></cfoutput>
		<CFELSE>
			<cfoutput><FORM action="frmquestionssec.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="Post" name="questions"></cfoutput>
			
			<CFOUTPUT>
				<CFSET NextStart = StartRow + 6>
				<CFSET NextEnd = EndRow + 6>
				<INPUT type="hidden" name="StartRow" value="#NextStart#">
				<INPUT type="hidden" name="EndRow" value="#NextEnd#">
			</CFOUTPUT>
		</CFIF>
		
		<!--- output the initial array values--->
		<CFIF Endrow GTE #ArrayLen(Session.QuestionSecArray)#>
			<CFSET EndRow = #ArrayLen(Session.QuestionSecArray)#>
		</cfif>
		
		<!--- End of the numbering code --->
		<!---===================================================================--->
		<!--- Beginning of the output of the questions --->
		<TABLE class="text1" style="font-size:14px;font-famly:arial;" valign="top" border="0">
			<CFLOOP index="i" from="#StartRow#" to="#EndRow#">
		
						<!--- send the question for formatting --->
						<TR>
							<TD VALIGN='top' WIDTH='35'><FONT FACE='arial'><B><cfif SESSION.partner_id EQ 80><div class="question_number"></cfif><cf_showQuestionNumber>.<cfif SESSION.partner_id EQ 80></div></cfif></B></FONT></TD>
							<TD VALIGN='top'>
								<FONT FACE='arial'>
									<cf_displayText code="question_#session.QuestionSecArray[i][4]#" group="question">
									<cfset hcode=session.QuestionSecArray[i][4]><cf_displayHelpLink code="#hcode#">
								</FONT>
							</TD>
						</TR>
						<!--- show answer field --->
						<CF_TagYeSetAnswerField answerfield="#Session.QuestionSecArray[i][4]#" answerTYPE="#Session.QuestionSecArray[i][5]#" textlength="#Session.QuestionSecArray[i][6]#" validation="#Session.QuestionSecArray[i][7]#" options_flag="#Session.QuestionSecArray[i][9]#" listvarname="accumAFList">
			</CFLOOP>
		</TABLE><br>
		<table cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td valign="top" colspan="2" align="right"><CFOUTPUT>
			<input type="hidden" name="next2" value="Next">
			<cfif SESSION.partner_id EQ 80><div align="right" id="submit_button"></cfif>
			<font face="Arial" size="3">
		    <INPUT TYPE="button" NAME="next2" VALUE="  Next  " onClick="document.questions.submit();">
		    </font>
			<cfif SESSION.partner_id EQ 80></div></cfif>
		</cfoutput></td>
		</tr>
		</table>
		<cf_passScreeningInput varname="accumAFList">
		</FORM></FONT></TD></TR></TBODY></TABLE>
		</cf_buildHTML>
		
</cfif>