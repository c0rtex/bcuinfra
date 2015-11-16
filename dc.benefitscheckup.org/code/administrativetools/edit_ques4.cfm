<cfmodule template="../header.cfm">

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="cfform.js"></SCRIPT>

<cfoutput>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="optList">
	SELECT opt_id, option_nm, field_nm, fieldtext, validation, opt_type, sort_id
	FROM tbl_opt
	WHERE field_nm='#answerfield#'
	ORDER BY sort_id, fieldtext
</CFQUERY>
<CFFORM action="edit_ques.cfm" method="post">
<cfgrid NAME="optionGrid" query="optList" selectmode="edit" insert="no" width="700" delete="yes" deletebutton="Delete Selected Option">
<cfgridcolumn NAME="opt_id" display="no">
<cfgridcolumn header="Option" NAME="option_nm">
<cfgridcolumn header="Question Answerfield" NAME="field_nm">
<cfgridcolumn header="Option Answerfield" NAME="fieldtext">
<cfgridcolumn header="Validation" NAME="validation">
<cfgridcolumn header="Type" NAME="opt_type">
<cfgridcolumn header="Sort Order" Name="sort_id">
</cfgrid><br>
<INPUT TYPE="submit" VALUE="Process Updates and Deletions">
<INPUT TYPE="hidden" NAME="edit_update" VALUE="1">
<INPUT TYPE="hidden" NAME="question_id" VALUE="#question_id#">
<cf_taghidden>
</cfFORM>
</cfoutput>

<cfmodule template="../footer.cfm">