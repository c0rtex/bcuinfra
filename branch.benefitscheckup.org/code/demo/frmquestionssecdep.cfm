<!----=======================================
DESCRIPTION: this is the questionnaire.  Pulls questions from 
	the db, puts them in array, then checks to see if they should
	be asked, then stres the answers in session variables.
CALLED BY: frmQuestionsSec.cfm
GOES TO: frmIncomeGrid.cfm
REQUIRED: form fields from frmWelcome
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
<CFIF ISDEFINED("Next2")>

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
		    AND q.pri_sec = 'secdep'
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
		    AND q.pri_sec = 'secdep'
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
	
		<CFIF #ArrayLen(Session.QuestionSecDepArray)# LT 1>
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
<CFIF EndRow GTE #ArrayLen(Session.QuestionSecDepArray)#>
	<cfoutput><FORM action="frmskipgrid.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="Post" name="questions"></cfoutput>
<CFELSE>
	<cfoutput><FORM action="frmquestionssecdep.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="Post" name="questions"></cfoutput>
	
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
<TABLE>
	<CFLOOP index="i" from="#StartRow#" to="#EndRow#">

				<!--- send the question for formatting --->
				<TR>
					<TD VALIGN='top' WIDTH='35'><FONT FACE='arial'><B><cf_showQuestionNumber>.</B></FONT></TD>
					<TD VALIGN='top'>
						<FONT FACE='arial'>
							<cf_displayText code="question_#session.QuestionSecDepArray[i][4]#" group="question">
							<!--- set the correct link for the help graphic --->
							<CF_TagYeHelpGraphic KEYWORD=#Session.QuestionSecDepArray[i][1]#>
						</FONT>
					</TD>
				</TR>
				<!--- show answer field --->
				<CF_TagYeSetAnswerField answerfield="#Session.QuestionSecDepArray[i][4]#" answerTYPE="#Session.QuestionSecDepArray[i][5]#" textlength="#Session.QuestionSecDepArray[i][6]#" validation="#Session.QuestionSecDepArray[i][7]#" options_flag="#Session.QuestionSecDepArray[i][9]#" listvarname="accumAFList">
	</CFLOOP>
</TABLE>

<CFOUTPUT>
  	<input type="hidden" name="next2" value="Next">
	<BR>
	<font face="Arial" size="3">
    <div align="right"><INPUT TYPE="button" NAME="next2" VALUE="  Next  " onClick="document.questions.submit();"></div>
    </font>
</cfoutput>
<cf_passScreeningInput varname="accumAFList">
</FORM></FONT></TD></TR></TBODY></TABLE>
<cf_tagFooter>