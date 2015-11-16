<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: second stage of adding a new question. inserts question (self and other), answer type, category, pri_sec, and hint
			 captures order num, and answerfield
CALLED BY: add_ques.cfm
GOES TO: add_ques2.cfm
=====================================================--->
<!-- set question_id -->
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="qid">
	SELECT max(question_id) as maxid
	FROM tbl_questions_new
</CFQUERY>
<CFSET question_id1 = #qid.maxid# + 1>

<!-- insert "self" question -->

<CFQUERY DATASOURCE="#application.dbSrc#">
	INSERT INTO tbl_questions_new(question,client,category,type,pri_sec)
	SELECT '#self_question#', 'self', '#category#', '#type#', '#pri_sec#'
</CFQUERY>

<!-- insert hint -->
<CFIF Trim(hint) neq ''>
	<CFQUERY DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_hints(keyword,definition)
		SELECT '#question_id1#','#hint#'
	</CFQUERY>
</CFIF>

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="dep">
	SELECT answerfield
	FROM tbl_answerfield_list
	ORDER BY answerfield
</CFQUERY>

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="order">
	SELECT order_num,question
	FROM tbl_questions_new
	WHERE client = 'self' and category = '#category#' and pri_sec = '#pri_sec#' and order_num <> ''
	ORDER BY order_num
</CFQUERY>

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="answer">
	SELECT DISTINCT tbl_answerfield_list.answerfield
	FROM tbl_answerfield_list LEFT JOIN tbl_questions_new ON tbl_answerfield_list.answerfield = tbl_questions_new.answerfield
	WHERE tbl_questions_new.answerfield IS Null
	ORDER BY tbl_answerfield_list.answerfield
</CFQUERY>

<CFFORM NAME="add_ques2" ACTION="add_ques3.cfm" METHOD="post">

<CFIF type IS "txt">
	What is the maximum length the answer can be? <INPUT TYPE="text" NAME="textlength" size="5"><br>
	What type of answer is required?
	<SELECT NAME="validation">
		<OPTION>Anything
		<OPTION VALUE="date">Date
		<OPTION VALUE="integer">Number
	</SELECT>
	<BR>
<CFELSEIF type IS "cur">
	What is the maximum length the answer can be? <INPUT TYPE="text" NAME="textlength" size="5"><br>
	<CFSET type = "opt">
	<CFSET option_nm = "$">
<CFELSEIF type IS "opt">
	Please enter the options and type of option. If option type is text or checkboxes select the field the answer should go into (these fields must be added seperately).
	<BR>
	<CFGRID NAME="opts" SELECTMODE="edit" INSERT="yes" WIDTH="500" DELETE="yes">
	<CFGRIDCOLUMN HEADER="Option" NAME="option_nm">
	<CFGRIDCOLUMN HEADER="Option Answerfield" NAME="fieldtext">
	<CFGRIDCOLUMN HEADER="Validation" NAME="validation">
	<CFGRIDCOLUMN HEADER="Type" NAME="type">
	</CFGRID>
</CFIF>
<BR>

<!-- for secondary or secondary dependent questions -->
<CFIF pri_sec IS NOT "pri">
	What question is this dependent on? <BR>
<!--- 	<SELECT NAME="dep_field">
		<CFOUTPUT QUERY="dep">
			<OPTION VALUE="#dep.field_nm#">#dep.field_desc#
		</CFOUTPUT>
	</SELECT> --->
	<!--- Darren 8/20/2000--->
	<SELECT NAME="dep_field">
		<CFOUTPUT QUERY="dep">
			<OPTION VALUE="#dep.answerfield#">#dep.answerfield#
		</CFOUTPUT>
	</SELECT>
	<BR>
	What should the answer to the primary question be (or not be) before this question should be asked?
	<BR>
	<SELECT NAME="dep_op">
		<OPTION VALUE="eq">must be
		<OPTION VALUE="neq">must not be
		<OPTION VALUE="lt">less than
		<OPTION VALUE="lteq">less than/equal to
		<OPTION VALUE="gt">greater than
		<OPTION VALUE="gteq">greater than/equal to
	</SELECT>
	<INPUT TYPE="text" NAME="dep_criteria" SIZE="10">
	<BR>
</CFIF>

This is the order in which the questions in this category will be asked.
Please arrange the order as needed.
<TABLE>
	<TR>
		<TD>
			<INPUT TYPE="text" NAME="order_num" size="2"><CFOUTPUT>#self_question#</CFOUTPUT>
		</TD>
	</TR>
	<CFOUTPUT QUERY="order">
	<TR>
		<TD>
			<INPUT TYPE="text" NAME="#order_num#" VALUE="#order_num#" size="2"> #question#
		</TD>
	</TR>
	</CFOUTPUT>
</TABLE>

Where should the answer to this question go?<BR>
<SELECT NAME="answerfield">
	<CFOUTPUT query="answer">
		<OPTION VALUE="#answerfield#">#answerfield#
	</CFOUTPUT>
</SELECT>
<BR>
<INPUT TYPE="submit" VALUE="Next">
<!---CF_tagHidden--->
<CFOUTPUT>
	<INPUT TYPE="hidden" NAME="question_id1" VALUE="#question_id1#">
	<INPUT TYPE="hidden" NAME="type" VALUE="#type#">
</CFOUTPUT>
</CFFORM>
<cfmodule template="../footer.cfm">