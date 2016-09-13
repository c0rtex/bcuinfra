<!----=======================================
DESCRIPTION: this is the questionnaire.  Pulls questions from 
	the db, puts them in array, then checks to see if they should
	be asked, then stres the answers in session variables.
CALLED BY: frmQuestions.cfm
GOES TO: frmQuestionsSecDep.cfm
REQUIRED:N/A
============================================---->
<cf_logScreeningInput initvarname="accumAFList">
<cf_tagHeader> 
<table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
	<TBODY>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">
<!--- =================================================================== --->

<!--- if coming from welcome screen ---->
<font face="arial" size="4">Please note that these questions are being asked due to your answers to previous questions. If you need help answering a question, click the <font size="2"><u>HELP</u></font> link next to some questions.</font>
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
	<cfquery name="build_array" datasource="#session.datasrc#">
		SELECT DISTINCT q.question_id, q.pri_sec qsec, q.answerfield,
		    q.type, q.textlength, q.validation, q.dep_formula,
		    q.category qcat, q.order_num qordnum, 0 AS options_flag
		FROM tbl_questions_new q, tbl_answerfield_list a,
		    program_answerfield pa, tbl_prg_all p, (
		        SELECT sp.program_id
		        FROM subset_program_base sp, tbl_prg_all p
		        WHERE sp.subset_id=#session.subset_id#
		            AND sp.program_id=p.RecID
		            AND p.st IN ('FD', '#session.st#')
		        UNION
		        SELECT pp.parent_program_id as program_id
		        FROM subset_program_base sp, tbl_prg_all p, program_parent pp
		        WHERE sp.subset_id=#session.subset_id#
		            AND sp.program_id=p.RecID
		            AND p.st IN ('FD', '#session.st#')
		            AND p.RecID=pp.program_id
		    ) AS r
		WHERE q.question_id NOT IN (
		        SELECT question_id
		        FROM subset_question
		        WHERE subset_id=#session.subset_id#
		            AND exclude_flag=1
		    )
		    AND q.client='self'
		    AND q.pri_sec = 'sec'
		    AND q.answerfield=a.answerfield
		    AND a.RecID NOT IN (
		        SELECT answerfield_id
		        FROM xsubset_answerfield
		        WHERE subset_id=#session.subset_id#
		    )
		    AND a.RecID=pa.answerfield_id
		    AND pa.program_id=p.RecID
		    AND (p.inactive_flag=0 OR p.inactive_flag IS NULL)
		    AND p.RecID=r.program_id
		UNION
		SELECT q.question_id, q.pri_sec qsec, q.answerfield,
		    q.type, q.textlength, q.validation, q.dep_formula,
		    q.category qcat, q.order_num qordnum, sq.options_flag
		FROM subset_question sq, tbl_questions_new q
		WHERE sq.subset_id=#session.subset_id#
		    AND sq.exclude_flag=0
		    AND sq.question_id=q.question_id
		    AND q.client='self'     
		    AND q.pri_sec = 'sec'
		ORDER BY qsec, qcat, qordnum
	</cfquery>

	<!--- Now we want to put the query into an session array, so we dont have to re-query the DB --->
	<!--- Populate the array row by row --->
	<cfloop query="build_array">
		<cfquery name="build_array_question_text" datasource="#session.datasrc#">
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
<TABLE>
	<CFLOOP index="i" from="#StartRow#" to="#EndRow#">

				<!--- send the question for formatting --->
				<TR>
					<TD VALIGN='top' WIDTH='35'><FONT FACE='arial'><B><cf_showQuestionNumber>.</B></FONT></TD>
					<TD VALIGN='top'>
						<FONT FACE='arial'>
							<cf_displayText code="question_#session.QuestionSecArray[i][4]#" group="question">
							<!--- set the correct link for the help graphic --->
							<CF_TagYeHelpGraphic KEYWORD=#Session.QuestionSecArray[i][1]#>
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
	<font face="Arial" size="3">
    <INPUT TYPE="button" NAME="next2" VALUE="  Next  " onClick="document.questions.submit();">
    </font>
</cfoutput></td>
</tr>
</table>
<cf_passScreeningInput varname="accumAFList">
</FORM></FONT></TD></TR></TBODY></TABLE>
<cf_tagFooter>