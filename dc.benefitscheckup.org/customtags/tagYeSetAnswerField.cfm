<!--- ======================================== 
AUTHOR: JLuhmann
DESCRIPTION: sets text box, option buttons, etc. for frmQuestions
CALLED BY: frmQuestions.cfm
GOES TO: frmQuestions.cfm
REQUIRED:	answertype = txt,opt,cmbo
			answerfield = field name where answer should go
			textlength = length of text field
			validation = type of answer required
			quesnum = number of question	
==============================================--->
<cfparam name="attributes.default" type="any" default="">
<cfparam name="attributes.options_flag" type="numeric" default="0">
<cfparam name="attributes.listvarname" type="string" default="">
<cfparam name="attributes.suppress_js" type="boolean" default="false">
<cfparam name="attributes.answertype" type="string" >
<cfparam name="attributes.answerfield" type="string" >
<cfparam name="attributes.textlength" type="string"   >
<cfparam name="attributes.validation" type="string" >
<CFSET answertype = attributes.answertype>
<CFSET answerfield = attributes.answerfield>
<CFSET textlength = attributes.textlength>
<CFSET validation = attributes.validation>
<cfset safList = ''>
<TR>
	<TD>
	</TD>
	<TD>
		<cfif answerfield eq 'receive' or answerfield eq 'interests'>
			<cfquery name="opts" datasource="#application.dbSrc#">
				select qa.sort as qasort, a.answerfield as option_code
				from question q, question_answerfield qa, answerfield a, program_answerfield pa,
					program p, (
						select sp.program_id
						from subset_program_base sp, program p
						where sp.subset_id=#session.subset_id#
							and sp.program_id=p.program_id
							and (p.state_id IS NULL or p.state_id='#session.st#')
						union
						select pp.parent_program_id as program_id
						from subset_program_base sp, program p, program_parent pp
						where sp.subset_id=#session.subset_id#
							and sp.program_id=p.program_id
							and (p.state_id IS NULL or p.state_id='#session.st#')
							and p.program_id=pp.program_id
					) AS r
				where q.question_code=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="32" value="#answerfield#">
					and q.question_id=qa.question_id
					and qa.answerfield_id=a.answerfield_id
					and (a.state_id is null or a.state_id='#session.st#')
					and a.answerfield_id not in (
						select answerfield_id
						from answerfield_subset_partner
						where subset_id=#session.subset_id#
							and (partner_id IS NULL or partner_id=#session.partner_id#)
							and background_flag=1
					)
					and a.answerfield_id=pa.answerfield_id
					and pa.program_id=p.program_id
					and p.active_flag=1
					and p.program_id=r.program_id
				UNION
				select qa.sort as qasort, a.answerfield as option_code
				from (
					select question_id
					from subset_question sq
					where subset_id=#session.subset_id#
						and exclude_flag=0
					union
					select question_id
					from question q
					where include_flag=1
						and question_id not in (
							select question_id
							from subset_question sq
							where subset_id=#session.subset_id#
								and exclude_flag=1
			            )
					) sq, question q, question_answerfield qa, answerfield a
				where sq.question_id=q.question_id
					and q.question_code=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="32" value="#answerfield#">
					and q.question_id=qa.question_id
					and qa.answerfield_id=a.answerfield_id
					and (a.state_id IS NULL or a.state_id='#session.st#')
				order by qasort, option_code
			</cfquery>
			<table cellpadding="0" cellspacing="0" border="0">
			<cfoutput query="opts">
				<cf_displayText code="answerfield_#option_code#" group="answerfield" var="option_nm">
				<CFSET "session.#answerfield#" = 0>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="#option_code#" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = 0>
				</cfif>
				<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<!---- These are the check boxes, and there variations to make sure we get the javascript for the none of the above --->
				<td valign="top" align="right" width="20">
					<INPUT TYPE="checkbox" NAME="#option_code#" VALUE="Y"<cfif matchVal Eq 1 or (not session.screening.prepopulate and (session.subset_id eq 27 or session.subset_id eq 36) and option_code eq 'medicare_receive')> checked</cfif>>
				</td>
				<td>&nbsp;</td>
				<cfset safList = ListAppend(safList, "c-#option_code#")>
				<td valign="middle" align="left">
					<cfif SESSION.partner_id EQ 80><div class="frmquestions_checkboxes"></cfif>
						<font face="Arial">#option_nm#</font>
					<cfif SESSION.partner_id EQ 80></div></cfif>
				</td>
				</tr>
			</cfoutput>
			</table>
		<cfelseif #answertype# is "txt">	
        	<!--- if txt, set text box --->
			<CFSET "session.#answerfield#"="0">
			<CF_TagYeWhiteSpace>
			<!--- 05/19/2002 REM  Modified this code to plug in a dropdown approach to dob--
			rather than write a whole new routine, I'm leveraging the fact that dob is already
			being trapped here.  Note that we're no longer actually using any validation on the
			field here . . . --->
<!--- 01/14/2004 BS  Modified this code so that "_month" and "_year" get appended to the answerfield names of the respective parts of the birthdate.  The code that calculates the actual age and puts that answer into the session is elsewhere.  This is done primarily so that automatic testing software will work better, but also because it's just cleaner not to use the same name for two form fields that return different types of data.--->
			<CFIF validation is "date">
				<CFIF answerfield CONTAINS "dob">
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="#answerfield#_month" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = 0>
				</cfif>
				<CFOUTPUT>
				<select name="#answerfield#_month">
					<option value="1">--select month--</option>
					<cfloop from="1" to="12" index="m">
						<option value="#m#"<cfif matchVal eq m> SELECTED</cfif>>#MonthAsString(m)#</option>
					</cfloop>
				</select>
				<cfset safList = ListAppend(safList, "n-#answerfield#_month")>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="#answerfield#_year" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = 0>
				</cfif>
				<select name="#answerfield#_year">
					<option value="#DateFormat(Now(), "yyyy")#">--select year--</option>
					<option value="1899">before 1900</option>
					<cfloop from="1900" to="#DateFormat(Now(), "yyyy")#" index="y">
						<option value="#y#"<cfif matchVal eq y Or (matchVal eq 0 And y eq 1930)> SELECTED</cfif>>#y#</option>
					</cfloop>
				</select>
				<cfset safList = ListAppend(safList, "n-#answerfield#_year")>
				</CFOUTPUT>				
				<CFELSE>
					<cfif session.screening.prepopulate>
						<cf_handleScreeningAnswerfield action="get" code="#answerfield#" element="pre" var="matchVal">
					<cfelse>
						<cfset matchVal = ''>
					</cfif>
					<CFOUTPUT><INPUT TYPE="text" NAME="#answerfield#" value="#HTMLEditFormat(matchVal)#" SIZE="#textlength#" MAXLENGTH="#textlength#" onBlur="validateDateSelf(value);"></CFOUTPUT>
					<cfset safList = ListAppend(safList, "s-#answerfield#")>
				</CFIF>
			<CFELSE>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="#answerfield#" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = ''>
				</cfif>
				<CFOUTPUT><INPUT TYPE="text" NAME="#answerfield#" value="#HTMLEditFormat(matchVal)#" SIZE="#textlength#" MAXLENGTH="#textlength#" onBlur="chkDollar(this,value);"></CFOUTPUT>
				<cfif validation Eq 'integer'>
					<cfset safList = ListAppend(safList, "n-#answerfield#")>
				<cfelse>
					<cfset safList = ListAppend(safList, "s-#answerfield#")>
				</cfif>
			</CFIF>
        <cfelseif answertype IS "hh_exp">
        	<cfquery name="opts" datasource="#application.dbSrc#">
				select qa.`sort` as qsort, a.answerfield as option_code
				from question q, question_answerfield qa, answerfield a, program_answerfield pa,
					program p, (
						select sp.program_id
						from subset_program_base sp, program p
						where sp.subset_id=#session.subset_id#
							and sp.program_id=p.program_id
							and (p.state_id IS NULL or p.state_id='#session.st#')
						union
						select pp.parent_program_id as program_id
						from subset_program_base sp, program p, program_parent pp
						where sp.subset_id=#session.subset_id#
							and sp.program_id=p.program_id
							and (p.state_id IS NULL or p.state_id='#session.st#')
							and p.program_id=pp.program_id
					) AS r
				where q.question_code=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="32" value="#answerfield#">
					and q.question_id=qa.question_id
					and qa.answerfield_id=a.answerfield_id
					and (a.state_id is null or a.state_id='#session.st#')
					and a.answerfield_id not in (
						select answerfield_id
						from answerfield_subset_partner
						where subset_id=#session.subset_id#
							and (partner_id IS NULL or partner_id=#session.partner_id#)
							and background_flag=1
					)
					and a.answerfield_id=pa.answerfield_id
					and pa.program_id=p.program_id
					and p.active_flag=1
					and p.program_id=r.program_id
				UNION
				select qa.`sort` as qsort, a.answerfield as option_code
				from (
					select question_id
					from subset_question sq
					where subset_id=#session.subset_id#
						and exclude_flag=0
					union
					select question_id
					from question q
					where include_flag=1
						and question_id not in (
							select question_id
							from subset_question sq
							where subset_id=#session.subset_id#
								and exclude_flag=1
			            )
					) sq, question q, question_answerfield qa, answerfield a
				where sq.question_id=q.question_id
					and q.question_code=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="32" value="#answerfield#">
					and q.question_id=qa.question_id
					and qa.answerfield_id=a.answerfield_id
					and (a.state_id IS NULL or a.state_id='#session.st#')
				order by qsort, option_code
			</cfquery>
            <table border="0" cellpadding="0" cellspacing="0">
            <cfoutput query="opts">
				<cf_displayText code="answerfield_#opts.option_code#" group="answerfield" var="option_nm">
				<CFSET "session.#answerfield#" = 0>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="#option_code#" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = ''>
				</cfif>
				<cfif SESSION.partner_id NEQ 80>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						
							<td align="right" style="max-width:150px;padding:2px 0;" valign="middle">
						
						
							#option_nm#&nbsp;&nbsp;
						</td>
						<td align="left" style="max-width:175px;padding:2px 0;" valign="middle">
							$&nbsp;<INPUT TYPE="text" NAME="#option_code#" value="#HTMLEditFormat(matchVal)#" SIZE="#textlength#" MAXLENGTH="#textlength#" onBlur="chkDollar(this,value);">
						</td>
					</tr>
				<cfelse>
					<tr>
						<td align="left" style="width:150px;padding:2px 0;padding-left:50px;" valign="middle">#option_nm#&nbsp;&nbsp;</td>
						<td align="left" style="max-width:175px;padding:2px 0;" valign="middle">
							$&nbsp;<INPUT TYPE="text" NAME="#option_code#" value="#HTMLEditFormat(matchVal)#" SIZE="#textlength#" MAXLENGTH="#textlength#" onBlur="chkDollar(this,value);">
						</td>
					</tr>
				</cfif>
                	
					<cfset safList = ListAppend(safList, "n-#option_code#")>
			</cfoutput>
            </table>
		<CFELSEIF #answertype# is "opt">
			<!--- pull all options --->
			<CFQUERY DATASOURCE="#application.dbSrc#" NAME="opts">
				SELECT *
				FROM tbl_opt
				WHERE field_nm = '#answerfield#'
				ORDER BY sort_id
			</CFQUERY>
			<!--- Now check the first row to see the type of the answer --->
			<!--- If 'txt' or 'chk' then do another query to get only relevant options --->
			<CFIF (opts.opt_type eq 'txt' Or opts.opt_type eq 'chk') and answerfield neq 'employer' and answerfield neq 'sp_employer'>
				<!--- 05/04/2005 BS  Pull only options relevant for this subset --->
				<cf_populateTableFromView table="subset_program_base" subset_id="#session.subset_id#">
				<cf_populateTableFromView table="program_parent">
				<cfif attributes.options_flag eq 1>
					<cfquery name="opts" datasource="#application.dbSrc#">
						SELECT DISTINCT o.opt_type, o.option_nm, o.fieldtext, o.sort_id, a.answerfieldtype_id
						FROM tbl_opt o, tbl_answerfield_list a
						WHERE o.field_nm=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="30" value="#answerfield#">
							AND (
								o.validation IS NULL
								OR o.validation <> '1'
								OR (
									o.validation='1'
									AND SUBSTRING(fieldtext, 1, 7) = 'rec_#LCase(session.st)#_'
								)
							)
							AND o.fieldtext=a.answerfield
							AND a.RecID NOT IN (
								SELECT answerfield_id
								FROM answerfield_subset_partner
								WHERE subset_id=#session.subset_id#
									AND (partner_id IS NULL or partner_id=#session.partner_id#)
									AND background_flag=1
							)
						ORDER BY o.sort_id
					</cfquery>
				<cfelse>
					<cfquery name="opts" datasource="#application.dbSrc#">
						SELECT DISTINCT o.opt_type, o.option_nm, o.fieldtext, o.sort_id, a.answerfieldtype_id
						FROM tbl_opt o, answerfield a, program_answerfield pa, program p, (
								SELECT sp.program_id
								FROM subset_program_base sp, program p
								WHERE sp.subset_id=#session.subset_id#
									AND sp.program_id=p.program_id
									AND (p.state_id IS NULL or p.state_id='#session.st#')
								UNION
								SELECT pp.parent_program_id as program_id
								FROM subset_program_base sp, program p, program_parent pp
								WHERE sp.subset_id=#session.subset_id#
									AND sp.program_id=p.program_id
									AND (p.state_id IS NULL or p.state_id='#session.st#')
									AND p.program_id=pp.program_id
							) AS r
						WHERE o.field_nm=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="32" value="#answerfield#">
							AND o.fieldtext=a.answerfield
							AND a.answerfield_id NOT IN (
								SELECT answerfield_id
								FROM answerfield_subset_partner
								WHERE subset_id=#session.subset_id#
									AND (partner_id IS NULL or partner_id=#session.partner_id#)
									AND background_flag=1
							)
							AND a.answerfield_id=pa.answerfield_id
							AND pa.program_id=p.program_id
							AND p.active_flag=1
							AND p.program_id=r.program_id
						ORDER BY o.sort_id
					</cfquery>
				</cfif>
			</cfif>
			<CFIF opts.opt_type is "txt"><!--- if opt type is txt, set textboxes --->
				<CFLOOP query="opts">
					<CFSET "session.#fieldtext#"="0">	
					<CF_TagYewhitespace>
					<cfif session.screening.prepopulate>
						<cf_handleScreeningAnswerfield action="get" code="#fieldtext#" element="pre" var="matchVal">
					<cfelse>
						<cfset matchVal = ''>
					</cfif>
					<CFOUTPUT><cf_expandTextCodes text="#option_nm#">
					<INPUT TYPE="text" NAME="#fieldtext#" value="#HTMLEditFormat(matchVal)#" SIZE="#textlength#" MAXLENGTH="#textlength#" onBlur="chkDollar(this,value);"></CFOUTPUT>
					<cfif answerfieldtype_id lt 4>
						<cfset safList = ListAppend(safList, "n-#fieldtext#")>
					<cfelse>
						<cfset safList = ListAppend(safList, "s-#fieldtext#")>
					</cfif>
				</CFLOOP>
			<CFELSEIF #opts.opt_type# is "cmbo">  <!--- if combo box, set combo box --->
				<CF_TagYewhitespace>
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="#opts.field_nm#" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = 0>
				</cfif>
				<cfif opts.field_nm eq 'client'>
					<cfif session.subsetStateFlag eq 1>
						<SELECT NAME="client1" onChange="var objrow = document.getElementById('client_other_question'); if (this.options[this.selectedIndex].text == 'Other') {objrow.style.display = '';<cfif Not attributes.suppress_js> this.form.aflist.value = 'o-client1-client,s-client_other,g-gender,s-zip<cfif session.partner_id is 76>,s-fit_last_name,s-fit_agency_id</cfif>';</cfif>} else {objrow.style.display = 'none';<cfif Not attributes.suppress_js> this.form.aflist.value = 'o-client1-client,g-gender,s-zip<cfif session.partner_id is 76>,s-fit_last_name,s-fit_agency_id</cfif>';</cfif>} if (this.options[this.selectedIndex].text == 'Mother' || this.options[this.selectedIndex].text == 'Sister') this.form.gender[1].checked = true; else if (this.options[this.selectedIndex].text == 'Father' || this.options[this.selectedIndex].text == 'Brother') this.form.gender[0].checked = true;">
					<cfelseif session.partner_id is 76>
                    	<SELECT NAME="client1" onChange="var objrow = document.getElementById('client_other_question'); if (this.options[this.selectedIndex].text == 'Other') {objrow.style.display = '';<cfif Not attributes.suppress_js> this.form.aflist.value = 'o-client1-client,s-client_other,g-gender,s-st,y-pri_resident,s-fit_last_name,s-fit_agency_id,s-zip';</cfif>} else {objrow.style.display = 'none';<cfif Not attributes.suppress_js> this.form.aflist.value = 'o-client1-client,g-gender,s-st,y-pri_resident,s-fit_last_name,s-fit_agency_id,s-fit_last_name,s-fit_agency_id,s-zip';</cfif>} if (this.options[this.selectedIndex].text == 'Mother' || this.options[this.selectedIndex].text == 'Sister') this.form.gender[1].checked = true; else if (this.options[this.selectedIndex].text == 'Father' || this.options[this.selectedIndex].text == 'Brother') this.form.gender[0].checked = true;">
                    <cfelse>
						<SELECT NAME="client1" onChange="var objrow = document.getElementById('client_other_question'); if (this.options[this.selectedIndex].text == 'Other') {objrow.style.display = '';<cfif Not attributes.suppress_js> this.form.aflist.value = 'o-client1-client,s-client_other,g-gender,s-st,y-pri_resident,s-zip<cfif session.partner_id is 76>,s-fit_last_name,s-fit_agency_id</cfif>';</cfif>} else {objrow.style.display = 'none';<cfif Not attributes.suppress_js> this.form.aflist.value = 'o-client1-client,g-gender,s-st,y-pri_resident,s-zip<cfif session.partner_id is 76>,s-fit_last_name,s-fit_agency_id</cfif>';</cfif>} if (this.options[this.selectedIndex].text == 'Mother' || this.options[this.selectedIndex].text == 'Sister') this.form.gender[1].checked = true; else if (this.options[this.selectedIndex].text == 'Father' || this.options[this.selectedIndex].text == 'Brother') this.form.gender[0].checked = true;">
					</cfif>
					<option value="">-- Select One --
					<cfif session.partner_id eq 47>
					<option value="2436-healthplanmember" selected> Health Plan Member </option>
                    </cfif>
				<cfelse>
				<CFOUTPUT><SELECT NAME="#opts.field_nm#"></CFOUTPUT>
					<option>
				</cfif>
					<CFOUTPUT QUERY="opts">
						<CFSET "session.#answerfield#"="0">
                        <cfif session.subset_id eq 51 and session.partner_id eq 76 and opt_id eq 1358>
                    		<option value="1358-client" selected>Client</option>
                        <cfelse>
						<OPTION VALUE="#opt_id#-#fieldtext#"<cfif matchVal eq opt_id Or (matchVal eq 0 And attributes.default eq opt_id)> SELECTED</cfif>><font face="Arial">#option_nm#</font></OPTION></cfif>
					</CFOUTPUT>
					</SELECT>
				<cfset safList = ListAppend(safList, "o-#answerfield#")>
			<CFELSEIF #opts.opt_type# is "chk">	<!--- if check box, set check boxes --->
				<cf_handleScreening action="get" element="mode" var="localMode">
				<cfif localMode eq 'print'>
					<cfset stripTags = true>
				<cfelse>
					<cfset stripTags = false>
				</cfif>
				<cfif IsDefined('session.st') and (session.st eq '' or session.st eq 0)>
					<cfset localStateID = session.state_id>
				<cfelse>
					<cfset localStateID = session.st>
				</cfif>
				<cf_cacheSubsetQuestionAnswerfieldPool action="get" state_id="#localStateID#" subset_id="#session.subset_id#" partner_id="#session.partner_id#" question="#answerfield#" var="checkboxes">

				<table cellpadding="0" cellspacing="0" border="0">
				<cf_loopPoolStruct struct="checkboxes" index="checkboxName">
                    <cfset checkboxStruct = application.AnswerfieldPool.getAnswerfield('#checkboxName#')>
					<cfif checkboxStruct.state_id eq '' or checkboxStruct.state_id eq '#localStateID#'>
						<CFSET "session.#checkboxName#" = 0>
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="#checkboxName#" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = 0>
						</cfif>
						<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<!---- These are the check boxes, and there variations to make sure we get the javascript for the none of the above --->
						<td valign="top" align="right" width="20"><cf_displayAnswerfield code="#checkboxName#" type="#checkboxStruct.type#" showText="false" aflistvarname="safList"></td>
						<td>&nbsp;</td>
						<td valign="middle" align="left"><font face="Arial"><cf_displayText group="answerfield" code="answerfield_#checkboxName#" stripTags="#stripTags#"></font></td>
						</tr>
					</cfif>
				</cf_loopPoolStruct>
				</table>
			</CFIF>
		<CFELSEIF answertype eq 'yn' or answertype eq 'yns' or answertype eq 'ynd' or answertype eq 'ynns'>
			<cfif session.screening.prepopulate>
				<cf_handleScreeningAnswerfield action="get" code="#answerfield#" element="pre" var="matchVal">
				<cfif matchVal eq ''>
					<cfset matchVal = -1>
				</cfif>
            <cfelseif attributes.default neq ''>
            	<cfset matchVal = attributes.default >
			<cfelse>
				<cfset matchVal = -1>
			</cfif>
			<CF_TagYewhitespace><CFOUTPUT><INPUT TYPE="radio" NAME="#answerfield#" VALUE="Y"<cfif matchVal Eq 1 Or (matchVal Eq -1 And answerfield Eq 'int_aarp_programs')> CHECKED</cfif>> <font face="Arial">Yes &nbsp;&nbsp;</font>
			<INPUT TYPE="radio" NAME="#answerfield#" VALUE="N"<cfif matchVal Eq 0 Or (matchVal Eq -1 And answerfield Neq 'int_aarp_programs' and answerfield neq 'receive_ma_plan')> CHECKED</cfif>><font face="Arial"> No</font>
			<cfif answertype eq 'yns'>
				&nbsp;&nbsp;<INPUT TYPE="radio" NAME="#answerfield#" VALUE="notsure"<cfif matchVal Eq 1462> CHECKED</cfif>><font face="Arial"> I Don't Know</font>
			</cfif>
			<cfif answertype eq 'ynd'>
				&nbsp;&nbsp;<INPUT TYPE="radio" NAME="#answerfield#" VALUE="dontknow"<cfif matchVal Eq 1474> CHECKED</cfif>><font face="Arial"> I Don't Know</font>
			</cfif>
            <cfif answertype eq 'ynns'>
				&nbsp;&nbsp;<INPUT TYPE="radio" NAME="#answerfield#" VALUE="unsure"<cfif matchVal Eq 1462> CHECKED</cfif>><font face="Arial">Not Sure</font>
			</cfif>
			</CFOUTPUT>
			<cfset safList = ListAppend(safList, "y-#answerfield#")>
		</CFIF>
		
	</TD>
</TR>
<cfif attributes.listvarname Neq '' And safList Neq ''>
	<cfset "caller.#attributes.listvarname#" = ListAppend(Evaluate("caller.#attributes.listvarname#"), safList)>
</cfif>