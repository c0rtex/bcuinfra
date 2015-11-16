<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: second stage of add_ques. Adds info from add_ques to table. If option type, capture option, else go on to add_ques3
CALLED BY: add_ques.cfm
GOES TO: add_ques3.cfm
=====================================================--->

<CFQUERY DATASOURCE="#application.dbSrc#">
	UPDATE tbl_questions_new
	SET type = '#type#', <CFIF isdefined("dep_field")>dep_field='#dep_field#', dep_criteria='#dep_criteria#', dep_op='#dep_op#',</CFIF>order_num = '#order_num#', answerfield = '#answerfield#'
	WHERE question_id = #question_id1#
</CFQUERY>

<!-- insert options -->
<CFFORM NAME="add_ques3" ACTION="questions.cfm" METHOD="post">
<CFIF IsDefined("opts")>
	<CFGRIDUPDATE DATASOURCE="#application.dbSrc#" GRID="opts" TABLENAME="tbl_opt">
	<CFQUERY DATASOURCE="#application.dbSrc#">
		UPDATE tbl_opt
		SET field_nm = '#answerfield#'
		WHERE option IN (#opts.option_nm#)
	</CFQUERY>
</CFIF>
<CFLOCATION URL="questions.cfm">
</CFFORM>
<cfmodule template="../footer.cfm">