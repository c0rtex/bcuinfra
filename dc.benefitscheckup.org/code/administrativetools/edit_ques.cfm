<CFIF isdefined('form.edit_update')>
	<CFGRIDUPDATE GRID="optionGrid" DATASOURCE="#application.dbSrc#" TABLENAME="tbl_opt" keyonly="yes">
<CFELSEIF isdefined('form.edit_insert')>
	<CFGRIDUPDATE GRID="optionGrid" DATASOURCE="#application.dbSrc#" TABLENAME="tbl_opt">
</CFIF>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="ques">
select * from tbl_questions_new
where question_id = #question_id#
</CFQUERY>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="hints">
select * from tbl_hints
where keyword = '#question_id#'
</CFQUERY>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="cat">
select distinct category from tbl_questions_new
</CFQUERY>

<cfmodule template="../header.cfm">


<FORM name="question" NAME="FORM" ACTION="edit_ques2.cfm" METHOD="POST">
<table border="0" cellspacing="6" cellpadding="0">

<cfloop query="ques">
<CFOUTPUT query="ques">
<tr>
	<td valign="top" align="right">Question</td>
	<td><textarea NAME="question" cols="70" rows="8">#Trim(question)#</textarea></td>
</tr>

<tr>
	<td valign="top" align="right">Answer Type</td>
	<td><select NAME="type">
<option VALUE="txt"<CFIF type is "txt"> selected</CFIF>>Value
<option VALUE="opt"<CFIF type is "opt"> selected</CFIF>>Option
<option VALUE="yn"<CFIF type is "yn"> selected</CFIF>>Yes/No
<option VALUE="ynd"<CFIF type is "ynd"> selected</CFIF>>Yes/No/I Don't Know
<option VALUE="yns"<CFIF type is "yns"> selected</CFIF>>Yes/No/Not Sure
</select> <CFIF type is "opt">
<a href="edit_ques3.cfm?datasrc=#application.dbSrc#&user=#session.user#&answerfield=#answerfield#&question_id=#question_id#">Add New Options</a>
&nbsp;
<a href="edit_ques4.cfm?datasrc=#application.dbSrc#&user=#session.user#&answerfield=#answerfield#&question_id=#question_id#">Update or Delete Existing Options</a>
</CFIF></td>
</tr>

<tr>
	<td valign="top" align="right">Validation</td>
	<td>
<select NAME="validation">
<option VALUE="integer" <CFIF validation is "integer">selected</CFIF>>Number
<option VALUE="date" <CFIF validation is "date">selected</CFIF>>Date
<option VALUE="" <CFIF validation is "">selected</CFIF>>Anything
</select></td>
</tr>

<tr>
	<td valign="top" align="right">Max Answer Length</td>
	<td><INPUT TYPE="text" NAME="textlength" VALUE="#Trim(textlength)#" size="4"></td>
</tr>

<tr>
	<td valign="top" align="right">Order Number</td>
	<td><INPUT TYPE="text" NAME="order_num" VALUE="#Trim(order_num)#" size="4"></td>
</tr>

<tr>
	<td></td>
	<td>
<INPUT TYPE="radio" NAME="pri_sec" VALUE="pre"<CFIF pri_sec is "pre"> checked</CFIF>>Pre-Screen (first page)
<INPUT TYPE="radio" NAME="pri_sec" VALUE="pri"<CFIF pri_sec is "pri"> checked</CFIF>>Primary 
<INPUT TYPE="radio" NAME="pri_sec" VALUE="sec"<CFIF pri_sec is "sec"> checked</CFIF>>Secondary (dependent on primary) 
<INPUT TYPE="radio" NAME="pri_sec" VALUE="secdep"<CFIF pri_sec is "secdep"> checked</CFIF>>Dependent on Secondary 
	</td>
</tr>

<tr>
	<td valign="top" align="right">Answerfield</td>
	<td>
<INPUT TYPE="text" NAME="answerfield" VALUE="#answerfield#" size="40"></td>
</tr>

<tr>
	<td valign="top" align="right">Category</td>
	<td></CFOUTPUT>
<select NAME="category"><CFOUTPUT query="cat"><option VALUE="#category#" <CFIF ques.category is category>selected</CFIF>>#category#</CFOUTPUT>
</select></td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td></td>
	<td>If secondary question, criteria to ask question.</td>
</tr>
<tr>
	<td></td>
	<td valign="top"><table border="0">
			<tr>
				<td>primary question</td>
				<td>operator</td>
				<td>criteria</td>
			</tr>
			<tr>
				<td>
<CFIF dep_field is not "">
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="dep">
select answerfield from tbl_answerfield_list 
order by answerfield
</CFQUERY>
<select NAME="dep_field"><CFOUTPUT query="dep"><option VALUE="#answerfield#" <CFIF ques.dep_field is answerfield>selected</CFIF>>#answerfield#</CFOUTPUT></select><cfelse><INPUT TYPE="text" NAME="dep_field"></CFIF></td>
	<CFOUTPUT query="ques">
	<td align="left"><INPUT TYPE="text" NAME="dep_op" VALUE="#dep_op#"></td>
	<td><INPUT TYPE="text" NAME="dep_criteria" VALUE="#dep_criteria#"></td>
	</cfoutput>
		</tr>
	</table></td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td valign="top" align="right">Hint<cfif hints.RecordCount gt 0><br><br>
	<i>To delete this hint,<br>simply submit this<br>form with this<br>field left blank.</i><br><br>
	<input type="button" value="clear" onClick="this.form.hint.value = '';">.</i></cfif></td>
	<td><textarea NAME="hint" cols="70" rows="8"><CFOUTPUT query="hints">#Trim(definition)#</CFOUTPUT></textarea></td>
</tr>
</cfloop>
<tr><td>&nbsp;</td></tr>
</table>
<INPUT TYPE="submit" VALUE=" Update Question ">

<CFOUTPUT><INPUT TYPE="hidden" NAME="question_id" VALUE="#question_id#">
<INPUT TYPE="hidden" NAME="client" VALUE="#ques.client#">
</CFOUTPUT>
</BODY></FORM>
</HTML>
<cfmodule template="../footer.cfm">