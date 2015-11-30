<!----=======================================
DESCRIPTION: this is the questionnaire.  Pulls questions from 
	the db, puts them in array, then checks to see if they should
	be asked, then stres the answers in session variables.
CALLED BY: frmQuestionsSec.cfm
GOES TO: frmIncomeGrid.cfm
REQUIRED: form fields from frmWelcome
============================================---->
<cf_logScreeningInput initvarname="accumAFList">
<cf_buildHTML show_title="yes" guts="frmquestionssecdep.cfm">
	
<div class="row survey">
<!--- =================================================================== --->
<CFIF ISDEFINED("form.next2")>

	<!--- set a new array to hold the questions --->
	<CFSET Session.QuestionSecDepArray = ArrayNew(2)>
	<CFSET QuestionSecDepArray2 = ArrayNew(2)>
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
			AND q.pri_sec='secdep'
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
			   <CFSET QuestionSecDepArray2[CurrentRow][1] = build_array.question_id[CurrentRow]>
			   <CFSET QuestionSecDepArray2[CurrentRow][2] = build_array_question_text.question>
			   <CFSET QuestionSecDepArray2[CurrentRow][3] = build_array.pri_sec[CurrentRow]>
			   <CFSET QuestionSecDepArray2[CurrentRow][4] = build_array.answerfield[CurrentRow]>
			   <CFSET QuestionSecDepArray2[CurrentRow][5] = build_array.type[CurrentRow]>
			   <CFSET QuestionSecDepArray2[CurrentRow][6] = build_array.textlength[CurrentRow]>
			   <CFSET QuestionSecDepArray2[CurrentRow][7] = build_array.validation[CurrentRow]>
			   <CFSET QuestionSecDepArray2[CurrentRow][8] = build_array.dep_formula[CurrentRow]>
			   <CFSET QuestionSecDepArray2[CurrentRow][9] = build_array.options_flag[CurrentRow]>
	</cfloop>
	
	<CFIF #ArrayLen(QuestionSecDepArray2)# LT 1>
		<cfoutput><CFLOCATION url="frmskipgrid.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" addtoken="No"></cfoutput>
		<cfset session.chips = "now">
	</CFIF>
	
	<CFSET y = 1>
	<CFLOOP index="x" from="1" to="#ArrayLen(QuestionSecDepArray2)#">
			<CFSET test = #QuestionSecDepArray2[x][8]#>
			<CFSET temp=#EVALUATE("#test#")#>
				<CFIF temp IS "Yes">
					<CFSET Session.QuestionSecDepArray[y][1] = QuestionSecDepArray2[x][1]>
					<CFSET Session.QuestionSecDepArray[y][2] = QuestionSecDepArray2[x][2]>
					<CFSET Session.QuestionSecDepArray[y][3] = QuestionSecDepArray2[x][3]>
					<CFSET Session.QuestionSecDepArray[y][4] = QuestionSecDepArray2[x][4]>
					<CFSET Session.QuestionSecDepArray[y][5] = QuestionSecDepArray2[x][5]>
					<CFSET Session.QuestionSecDepArray[y][6] = QuestionSecDepArray2[x][6]>
					<CFSET Session.QuestionSecDepArray[y][7] = QuestionSecDepArray2[x][7]>
					<CFSET Session.QuestionSecDepArray[y][8] = QuestionSecDepArray2[x][8]>
					<CFSET Session.QuestionSecDepArray[y][9] = QuestionSecDepArray2[x][9]>
					<CFSET y = y + 1>
				</CFIF>
	</CFLOOP>
	
		<CFIF NOT IsDefined('Session.QuestionSecDepArray') AND ArrayLen(Session.QuestionSecDepArray) LT 1>
		<cfoutput><cflocation url="frmskipgrid.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" addtoken="No"></cfoutput>
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
<CFIF EndRow GTE ArrayLen(Session.QuestionSecDepArray)>
	<cfoutput><form action="frmskipgrid.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="Post" name="questions"></cfoutput>
<CFELSE>
	<cfoutput><form action="frmquestionssecdep.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="Post" name="questions"></cfoutput>
    
	<CFOUTPUT>
		<CFSET NextStart = StartRow + 6>
		<CFSET NextEnd = EndRow + 6>
		<INPUT type="hidden" name="StartRow" value="#NextStart#">
		<INPUT type="hidden" name="EndRow" value="#NextEnd#">
	</CFOUTPUT>
</CFIF>

<!--- output the initial array values--->
<CFIF Endrow GTE #ArrayLen(Session.QuestionSecDepArray)#>
	<CFSET EndRow = #ArrayLen(Session.QuestionSecDepArray)#>
</cfif>

<!--- End of the numbering code --->
<!---===================================================================--->
<!--- Beginning of the output of the questions --->

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
					<p>
						<cf_displayText code="question_#session.QuestionSecDepArray[i][4]#" group="question">
						<cf_displayHelpLink code="#session.QuestionSecDepArray[i][4]#">
					</p>
					<p>
						<CF_TagYeSetAnswerField answerfield="#Session.QuestionSecDepArray[i][4]#" answerTYPE="#Session.QuestionSecDepArray[i][5]#" textlength="#Session.QuestionSecDepArray[i][6]#" validation="#Session.QuestionSecDepArray[i][7]#" options_flag="#Session.QuestionSecDepArray[i][9]#" listvarname="accumAFList">
					</p>
			</div><!-- questionHolder -->
		</div><!-- question -->	

	</CFLOOP>

	<CFOUTPUT>
		<div id="surveyNav">
			<input type="hidden" name="next2" value="next2">
			<!---<h2>Keep up the good work. You've passed the midway point of the questionnaire.</h2>--->
			<p><div class="left"><input type="submit" value="  Next > " name="next" onClick="document.questions.submit();" /></div></p> 
		</div>	
	</cfoutput>
	<cf_passScreeningInput varname="accumAFList">
	</FORM>
</div>
</cf_buildHTML>