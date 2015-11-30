<!----=======================================
DESCRIPTION: this is the questionnaire.  Pulls questions from 
	the db, puts them in array, then checks to see if they should
	be asked, then stres the answers in session variables.
CALLED BY: frmWelcome2.cfm
GOES TO: frmQuestionsSec.cfm
REQUIRED: form fields from frmWelcome
============================================---->

<cf_logScreeningInput initvarname="accumAFList">
<!--- 12/09/2002 BS  Changes to prevent error messages from showing up on JavaScript alert/history(-1) calls.  Now we set a variable for whether or not the alert has been tripped.  If so, we skip display of the HTML portion of the page. --->
<cfset validationError = 0>
<cfset showCookCountyQuestion = false>

<!--- if coming from welcome screen ---->
<CFIF ISDEFINED("welcome")>
	<!--- set a new array to hold the questions --->
	<CFSET Session.QuestionArray = ArrayNew(2)>
	<!---  validation --->
	<cfif Not IsDefined('form.client1') Or form.client1 Eq ''>
		<SCRIPT LANGUAGE="javascript">
		{
			alert("Please indicate who you are filling out this questionnaire for");
			history.go(-1);
		}
		</SCRIPT>
		<cfset validationError = 1>
	<cfelseif form.client1 Eq 'other'>
	<!--- set client to mother, father, etc. --->
		<CFIF form.client_other eq ''>
			<SCRIPT LANGUAGE="javascript">
			{
				alert("Please fill in the box for \"Other\" (grandmother, friend, cousin, etc.)");
				history.go(-1);
			}
			</SCRIPT>
			<cfset validationError = 1>
		</CFIF>
	<cfelseif Not IsDefined('form.gender') Or form.gender Eq ''>
		<SCRIPT LANGUAGE="javascript">
		{
			alert("Please indicate whether the person is male or female");
			history.go(-1);
		}
		</SCRIPT>
		<cfset validationError = 1>
	</CFIF>

	<cfif not validationError>
	
		<!--- =============================================================== --->
		<!--- This section deals with the zip code --->
		<!--- set zip to 0 if not filled in --->
		<cf_handleScreeningAnswerfield action="get" code="county" element="val" var="countyVal">
		<cf_handleScreeningAnswerfield action="get" code="zip" element="val" var="zipVal">
		<CFIF zip IS "">
			<SCRIPT LANGUAGE="javascript">
					{
						alert("Please enter a zip code");
						history.go(-1);
					
					}
			</SCRIPT>
			<cfset validationError = 1>
		<CFELSEIF Len(zip) IS NOT 5>
			<SCRIPT LANGUAGE="javascript">
			{
				alert("Please enter a 5-digit zip code");
				history.go(-1);
			}
			</SCRIPT>
			<cfset validationError = 1>
		<CFELSEIF zip eq '00000'>
			<SCRIPT LANGUAGE="javascript">
			{
				alert("The zip code you entered is invalid");
				history.go(-1);
			}
			</SCRIPT>
			<cfset validationError = 1>
		<CFELSEIF Not IsNumeric(zip)>
			<SCRIPT LANGUAGE="javascript">
			{
				alert("Please enter numbers only for the zip code");
				history.go(-1);
			}
			</SCRIPT>
			<cfset validationError = 1>
		<CFELSEIF zip eq 0>
			<SCRIPT LANGUAGE="javascript">
			{
				alert("Please enter numbers only for the zip code");
				history.go(-1);
			}
			</SCRIPT>
			<cfset validationError = 1>
		<CFELSEIF countyVal eq '' Or zipVal eq '00000'>
			<SCRIPT LANGUAGE="javascript">
			{
				alert("The zip code you entered is invalid<cfif IsDefined('st')> for the state selected</cfif>");
				history.go(-1);
			}
			</SCRIPT>
			<cfset validationError = 1>
		</cfif>
	<!--- This is the end of the IF statement to check for zip code validation --->

	
	<!---=================================================================== --->
   
   <!--- 03/09/2002 REM  If we've made it to here, it's safe to ask the Chicago question
   and pop the ad, because we know we have a good zip: --->
   <!--- 02/12/2002 REM  We set the next values to keep from blowing things up later if they're not set--they're currently only relevant to Chicago, but that will change --->
   <cfset session.strclient='self'>
   <cfif session.st eq 'IL' and StructKeyExists(application.cookvars, session.zip)>
      <cfset showCookCountyQuestion = true>
   </cfif>
   
	<!---=================================================================== --->

	<!--- This query pulls all the questions that are possible for the state entered --->
	<!--- 08/28/2002 BShunn / Added subset_id session variable to pull only questions
	      for a given program category --->
	<!--- 09/01/2002 REM  Modified to add in a new subselect for RX Only --->
	<!--- 11/15/2002 BShunn / Rewrote RX query as two queries, because of funky results
          in Sybase (perhaps Sybase has a bug -- it returns duplicate rows) --->
	<!--- 01/14/2003 BShunn / Rewrote query again, because of stack problems on Production --->
	<!--- 01/26/2004 BS  Rewrote query to use subset_id in pulling questions --->
	<!--- 04/29/2005 BS  Rewrote query to use new subset schema in pulling questions --->
	<!--- 11/20/2006 BS  Rewrote query to replace old af association table with program_answerfield --->
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
			AND q.answerfield not in ('zip')
			AND q.client='self'
			AND q.pri_sec='pri'
			AND q.type is not null
			AND q.question_id=qq.question_id
			AND qq.questioncategory_id=qc.questioncategory_id
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
	   <CFSET Session.QuestionArray[CurrentRow][1] = build_array.question_id[CurrentRow]>
	   <CFSET Session.QuestionArray[CurrentRow][2] = build_array_question_text.question>
	   <CFSET Session.QuestionArray[CurrentRow][3] = build_array.pri_sec[CurrentRow]>
	   <CFSET Session.QuestionArray[CurrentRow][4] = build_array.answerfield[CurrentRow]>
	   <CFSET Session.QuestionArray[CurrentRow][5] = build_array.type[CurrentRow]>
	   <CFSET Session.QuestionArray[CurrentRow][6] = build_array.textlength[CurrentRow]>
	   <CFSET Session.QuestionArray[CurrentRow][7] = build_array.validation[CurrentRow]>
	   <CFSET Session.QuestionArray[CurrentRow][8] = build_array.dep_formula[CurrentRow]>
	   <CFSET Session.QuestionArray[CurrentRow][9] = build_array.options_flag[CurrentRow]>
	</cfloop>
	
	<CFIF #ArrayLen(Session.QuestionArray)# LT 1>
		<cfset session.chips="now">
		<cfset Session.Count = 6>
		<cflocation url="frmskipgrid.cfm" AddToken="Yes">
	</CFIF>
	
	</cfif>

<!--- End of the section for if coming from the welcome page --->
<!--- ===================================================================== --->

<!--- if coming from previous page of questions --->
<CFELSEIF isdefined("next")>
   <!--- 02/16/2002 REM  Pardon me, I'm just inserting the last step in the process of 
   solving for the Chicago/NotChicago session.City var--if I've passed the fields into
   this form, then I set the session vars here: --->
</CFIF>
<!--- the end of the if statement on which page coming from --->
<!--- ===================================================================== --->
<!--- Set the numbering for the page and check to see if it is still in line and if user used the back button --->
<CFIF Not IsDefined('form.StartRow')>
	<CFSET StartRow = 1>
</CFIF>

<CFIF Not IsDefined('form.EndRow')>
	<cfset EndRow = 6>
</CFIF>

<!--- 12/09/2002 BS  If validationError is set, then JavaScript is bouncing us back a page so don't bother rendering anything more. --->

<!--- BIG IF STATEMENT, TO END OF PAGE --->
<cfif not validationError>

<cf_buildHTML show_title="yes" guts="frmquestions.cfm">
<table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">
<!--- =================================================================== --->

<!--- Check to see if anymore questions left and if need to submit to self or to next set of questions --->
<CFIF EndRow GTE ArrayLen(Session.QuestionArray)>
	<cfset showhalfway = 'yes'>
	<cfoutput><FORM action="frmquestionssec.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="Post" name="questions" onsubmit="return false;"></cfoutput>
<CFELSE>
	<cfoutput><FORM action="frmquestions.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="Post" name="questions" onsubmit="return false;"></cfoutput>
   <!--- 02/16/2002 REM  Part of the kludgy solution to the Chicago/NotChicago problem--
if we haven't been able to set the session.City var (because we need user input), we 
insert two hidden fields here, so we can javascript the values and pass them back to ourselves.  
The bool var can only exist the first time frmQuestions is called, so that's the only time these
fields will appear.  Up above, on the second pass of frmQuestions, we check to see if we've
passed the value--if so, we use it to set the session var. --->
   <cfif isDefined("boolGetCity")>
      <input type="Hidden" name="City">
      <input type="Hidden" name="OtherCity">
   </cfif>
	
	<CFOUTPUT>
		<CFSET NextStart = StartRow + 6>
		<CFSET NextEnd = EndRow + 6>
		<INPUT type="hidden" name="StartRow" value="#NextStart#">
		<INPUT type="hidden" name="EndRow" value="#NextEnd#">
	</CFOUTPUT>
</CFIF>

<!--- output the initial array values--->
<CFIF Endrow GTE ArrayLen(Session.QuestionArray)>
	<CFSET EndRow = ArrayLen(Session.QuestionArray)>
</cfif>
<!--- End of the numbering code --->
<!---===================================================================--->
<TABLE valign="top" border="0">
	<cfif showCookCountyQuestion>
		<TR valign="top">
			<TD VALIGN='top' WIDTH='35'></TD>
			<TD VALIGN='top'>
				<FONT FACE='arial'>
					<strong>Because your zip code is on the border between Chicago and suburban Cook County, we need you to identify which city you live in.</strong>
				</FONT>
			</TD>
		</TR>
		<TR valign="top">
			<TD VALIGN='top' WIDTH='35'><FONT FACE='arial'><B><cf_showQuestionNumber>.</B></FONT></TD>
			<TD VALIGN='top'>
				<FONT FACE='arial'>
					Please select your city from the list. If it does not appear on the list, please choose "Other" and enter your city in the box that will appear.
				</FONT>
			</TD>
		</TR>
		<TR>
			<TD></TD>
			<TD><CF_TagYewhitespace>
				<cfif session.screening.prepopulate And StructKeyExists(session.screening.a, 'city_id')>
					<cfset matchCityID = session.screening.a.city_id.pre>
				<cfelse>
					<cfset matchCityID = ''>
				</cfif>
				<cfoutput><input type="hidden" name="city_id" value="#HTMLEditFormat(matchCityID)#" /></cfoutput>
				<cfif session.screening.prepopulate And StructKeyExists(session.screening.a, 'city')>
					<cfset matchVal = session.screening.a.city.pre>
				<cfelse>
					<cfset matchVal = 0>
				</cfif>
				<cfoutput><SELECT NAME="city" onChange="var objrow = document.getElementById('othercity_question'); if (this.options[this.selectedIndex].text == 'OTHER') {objrow.style.display = ''; this.form.city_id.value = '';} else {objrow.style.display = 'none'; this.form.othercity.value = ''; if (this.options[this.selectedIndex].text == 'CHICAGO') this.form.city_id.value = '#StructFind(application.cookcityvars, 'CHICAGO')#';<cfloop list="#StructFind(application.cookvars, session.zip)#" index="x"> else if (this.options[this.selectedIndex].text == '#x#') this.form.city_id.value = '#StructFind(application.cookcityvars, x)#';</cfloop> else this.form.city_id.value = '';}"></cfoutput>
					<option value="">-- Select One --</option>
					<option value="2376-chicago"<cfif matchVal eq 2376> selected</cfif>>CHICAGO</option>
					<cfloop list="#StructFind(application.cookvars, session.zip)#" index="x">
						<option value="2378-notchi"<cfif matchVal eq 2378 and matchCityID eq StructFind(application.cookcityvars, x)> selected</cfif>><cfoutput>#x#</cfoutput></option>
					</cfloop>
					<option value="2378-notchi"<cfif matchVal eq 2378 and matchCityID eq ''> selected</cfif>>OTHER</option>
				</SELECT>
		</td>				
		<tr>				
		<cfif matchVal eq 2378 and matchCityID eq '' and session.screening.prepopulate and StructKeyExists(session.screening.a, 'othercity')>
			<cfset displayOtherCity = ''>
		<cfelse>
			<cfset displayOtherCity = 'none'>
		</cfif>
		<cfif session.screening.prepopulate and StructKeyExists(session.screening.a, 'othercity')>
			<cfset matchVal = session.screening.a.othercity.pre>
		<cfelse>
			<cfset matchVal = ''>
		</cfif>
		<cfoutput><TR VALIGN="top" id="othercity_question" style="display: #displayOtherCity#;">
			<TD></TD>
			<TD>
				<FONT FACE="arial">Please specify:&nbsp;&nbsp;
				<INPUT TYPE="text" NAME="othercity" SIZE="15" maxlength="64" value="#HTMLEditFormat(matchVal)#" onBlur="validatetext(this);"></FONT>
			</TD>
		</TR></cfoutput>
		<cfset accumAFList = ListAppend(accumAFList, 'o-city,s-city_id,s-othercity')>
	</cfif>
	<CFLOOP index="i" from="#StartRow#" to="#EndRow#">
		<!--- send the question for formatting --->
		<TR valign="top">
			<TD VALIGN='top' WIDTH='35'><FONT FACE='arial'><B><cf_showQuestionNumber>.</B></FONT></TD>
			<TD VALIGN='top'>
				<FONT FACE='arial'>
					<cf_displayText code="question_#session.QuestionArray[i][4]#" group="question">
					<cf_displayHelpLink code="#session.QuestionArray[i][4]#">
				</FONT>
			</TD>
		</TR>
		<!--- show answer field --->
		<cfif session.QuestionArray[i][4] eq 'citizen'>
			<cfset afDefault = 13>
		<cfelse>
			<cfset afDefault = ''>
		</cfif>
		<CF_TagYeSetAnswerField answerfield="#Session.QuestionArray[i][4]#" answerTYPE="#Session.QuestionArray[i][5]#" textlength="#Session.QuestionArray[i][6]#" validation="#Session.QuestionArray[i][7]#" options_flag="#Session.QuestionArray[i][9]#" default="#afDefault#" listvarname="accumAFList">
	</CFLOOP>
	
</TABLE>
<!--- end of output of questions, set form numbering variables for next page --->
<CFOUTPUT>
	<BR>
	<input type="hidden" name="next" value="Next">
	<div align="right"><INPUT TYPE="button" NAME="next" VALUE="  Next  " onClick="document.questions.submit();"></div>
	
	<cfif isdefined('showhalfway') AND ((Not IsDefined('session.subset_id')) or session.subset_id eq 0)>
	<h3>Keep up the good work.  You've passed the midway point of the questionnaire.</h3>
	</cfif>
</cfoutput>
<cf_passScreeningInput varname="accumAFList">
</FORM>
</FONT></TD></TR></TBODY></TABLE>
<!--- Call footer tag --->
</cf_buildHTML>
<!--- END BIG IF STATEMENT --->
</cfif>