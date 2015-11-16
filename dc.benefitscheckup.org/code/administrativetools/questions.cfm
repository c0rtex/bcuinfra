<cfmodule template="../header.cfm">

<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">

<CFIF isdefined("add")>
<CFOUTPUT>#other_question#</CFOUTPUT>
</CFIF>

<form ACTION="questions.cfm" METHOD="POST">
<SELECT NAME="sort" SIZE="1">
 	<option VALUE="answerfield">answerfield
	<option VALUE="order_num,pri_sec">order_num
	<option VALUE="category,order_num,pri_sec">category
	<option VALUE="pri_sec,order_num">pri_sec
</Select>
<Input TYPE="SUBMIT" VALUE="Submit">
</FORM>

<CFIF isDefined("view")>
	<CFQUERY NAME="init" DATASOURCE="#application.dbSrc#">
		select * 
		from tbl_questions_new
		where question_id = '#view#'
	</CFQUERY>
		<CFOUTPUT QUERY="init">
			<CFQUERY NAME="full" DATASOURCE="#application.dbSrc#">
				SELECT *
				FROM tbl_questions_new
				WHERE order_num = '#order_num#' AND pri_sec = '#pri_sec#' AND category = '#category#'
			</CFQUERY>
		</CFOUTPUT>
<table border="0" width="100%" BGCOLOR="cococo">
	<tr>	
		<td COLSPAN="5" BGCOLOR="WHITE"><font size="-1">Reminder: | = father &nbsp;$ = he &nbsp;@ = his &nbsp;^ = him</font></td>
	</tr>

<CFOUTPUT QUERY="full"> 
	<tr>
		<td><a href="edit_ques.cfm?question_id=#question_id#">#order_num#</a></td>
		<td COLSPAN="4">#question#</td>
	</tr>
	<tr>
		<td>#pri_sec#</td>
		<td>#type#</td>
		<td>#answerfield#</td>
		<td>#category#</td>
		<td>&nbsp;</td>
	</tr>
		
				<CFIF #type# is "opt">
	<tr>
		<td COLSPAN="5">
				<CFQUERY DATASOURCE="#application.dbSrc#" NAME="opts">
				select option_nm from tbl_opt where field_nm = '#answerfield#'
				</CFQUERY>
				#opts.option_nm#
		</TD>
	</tr>
				</CFIF>

	<tr>
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="hints">
		select definition from tbl_hints
		where keyword = '#question_id#'
		</CFQUERY>
		<td colspan="5"><BR>#hints.definition#</td>


	</TR>


	<tr>	
		<td COLSPAN="5" BGCOLOR="WHITE"><HR></td>
	</tr>


</cfoutput>
</table>
<BR><BR>
</CFIF>
<!-- View Questions -->
<CFPARAM NAME="form.sort" DEFAULT="answerfield">

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="ques">
select * 
from tbl_questions_new
where client = 'self'
order by #form.sort#
</CFQUERY>


<table border="0" width="100%" BGCOLOR="cococo">
	<tr BGCOLOR="WHITE">	
		<td COLSPAN="5">Click <a href="add_ques.cfm">Here</a> to add a new question.</td>
	</tr>

<CFOUTPUT QUERY="ques"> 
	<tr>
		<td><a href="edit_ques.cfm?question_id=#question_id#">#order_num#</a></td>
		<td COLSPAN="4">#question#</td>
	</tr>
	<tr>
		<td>#pri_sec#</td>
		<td>#type#</td>
		<td>#answerfield#</td>
		<td>#category#</td>
		<td><a href="questions.cfm?view=#question_id#">VIEW ALL</a></td>
	</tr>
		
				<CFIF #type# is "opt">
	<tr>
		<td COLSPAN="5">
				<CFQUERY DATASOURCE="#application.dbSrc#" NAME="opts">
				select option_nm from tbl_opt where field_nm = '#answerfield#'
				</CFQUERY>
				#opts.option_nm#
		</TD>
	</tr>
				</CFIF>

	<tr>	
		<td COLSPAN="5" BGCOLOR="WHITE"><HR></td>
	</tr>


</cfoutput>
</table>

</font>

<cfmodule template="../footer.cfm">