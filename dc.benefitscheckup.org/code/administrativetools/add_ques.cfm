<cfmodule template="../header.cfm">
<!--- ================================================
AUTHOR: JLuhmann a/k/a I.M.N. Iddiott
DESCRIPTION: First stage of adding a new question. 
CALLED BY: prg_rule.cfm
GOES TO: add_rule2.cfm
=====================================================--->

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fields">
select answerfield
from tbl_answerfield_list
</CFQUERY>
 
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="categories">
select distinct category 
from tbl_questions_new
</CFQUERY>

<HTML>
<HEAD>
	<TITLE>Add Questions</TITLE>
</HEAD>


<FORM action="add_ques2.cfm" method="post" NAME="FORM">

<table>
<tr><td>NOTE</td></tr>
<tr><td colspan="3">
The "other" question is no longer used.  You need only enter a "self" question.</td></tr><tr><td colspan="3">
Type question here:<br>
<textarea cols="75" rows="6" NAME="self_question"></textarea></td>
</tr>
<tr><td>Answer type &nbsp;
<select NAME="type">
<option VALUE="cur">Currency
<option VALUE="opt">Option
<option VALUE="txt">Text
<option VALUE="yn">Yes/No
<option VALUE="ynd">Yes/No/I Don't Know
</select></td></tr><tr><td>Category &nbsp;
<select NAME="category"><CFOUTPUT query="categories">
<option VALUE="#category#">#category#</CFOUTPUT>
</select></td></tr>
<!---select NAME="answerfield"><CFOUTPUT query="fields"><option VALUE="#field_nm#">#field_desc#</CFOUTPUT></select></td--->
<td></td></tr>
<tr><td>
<INPUT TYPE="radio" NAME="pri_sec" VALUE="pri" checked>Primary<br>
<INPUT TYPE="radio" NAME="pri_sec" VALUE="sec">Secondary (dependent on primary)<br>
<INPUT TYPE="radio" NAME="pri_sec" VALUE="secdep">Dependent on Secondary</td></tr><tr><td>Hint 
<textarea cols="75" rows="5" NAME="hint">
</textarea></td></tr>
<tr>
<INPUT TYPE="submit" NAME="add" VALUE="Done"></td></tr>
</table>

</FORM>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">