<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION:     NO LONGER USED
CALLED BY:
GOES TO:
=====================================================--->



<!--add eligibility rule-->

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fields1">
select * 
from tbl_fields_list
where field_nm = '#field#'
</CFQUERY>

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fields2">
select * 
from tbl_fields_list
where field_nm = '#field2#'
</CFQUERY>

<HTML>
<HEAD>
	<TITLE>New Rule</TITLE>
</HEAD>

<BODY>
Please choose the most delimiting factor.<br>
<em><font color="Red"><b>If you have a question about a rule, PLEASE ASK!!! This is VERY important!</font></b></em><br>
<CFOUTPUT><FORM action="prg_rule.cfm" method="post"></CFOUTPUT>
<CFOUTPUT>
<INPUT TYPE="hidden" NAME="field" VALUE="#field#">
<INPUT TYPE="hidden" NAME="field2" VALUE="#field2#">
</CFOUTPUT>
<cfloop query="fields1"><CFOUTPUT>
<INPUT TYPE="hidden" NAME="field_nm" VALUE="#field_nm#">
<CFIF #type# is "txt">
	#fields1.field_desc# must be
	<select NAME="op" size="1">
		<option>
		<option VALUE="eq">equal to
		<option VALUE="gt">greater than
		<option VALUE="lt">less than
		<option VALUE="gteq">greater than or equal to 
		<option VALUE="lteq">less than or equal to
	</select>
	<CFIF isdefined("inc")><INPUT TYPE="text" NAME="criteria" size="10" VALUE="income table">
		<table border="1" width="75%">
		<tr><th>No in Household</th><th>Income Level</th></tr>
		<tr><td>1</td><td><INPUT TYPE="text" NAME="hh_1"></td></tr>
		<tr><td>2</td><td><INPUT TYPE="text" NAME="hh_2"></td></tr>
		<tr><td>3</td><td><INPUT TYPE="text" NAME="hh_3"></td></tr>
		<tr><td>4</td><td><INPUT TYPE="text" NAME="hh_4"></td></tr>
		<tr><td>5</td><td><INPUT TYPE="text" NAME="hh_5"></td></tr>
		<tr><td>6</td><td><INPUT TYPE="text" NAME="hh_6"></td></tr>
		<tr><td>7</td><td><INPUT TYPE="text" NAME="hh_7"></td></tr>
		<tr><td>8 or more</td><td><INPUT TYPE="text" NAME="hh_8"></td></tr>
		</table>
	<cfelse>
		<INPUT TYPE="text" NAME="criteria" size="10"><br>
		If this rule applies to an income table, please click <INPUT TYPE="submit" NAME="inc" VALUE="Here"><br></CFIF>
</CFIF></CFOUTPUT><CFOUTPUT>
<CFIF #type# is "yn">
	#fields1.field_desc# must be
	<INPUT TYPE="hidden" NAME="op" VALUE="eq">
	<select NAME="criteria"><option><option VALUE="Y">Yes &nbsp;<option VALUE="N">No</select>
</CFIF></CFOUTPUT>
<CFIF #type# is "opt">
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="opts">
		select option_nm from tbl_opt where field_nm = '#field_nm#'
	</CFQUERY>
	<select NAME="op"><option><option VALUE="eq">Must be <option VALUE="neq"> Must not be</select>
	<select NAME="criteria"><option><CFOUTPUT query="opts"><option VALUE="#option#">#option#</CFOUTPUT></select><br>
</CFIF><br>
</cfloop>
<br><br>
<CFIF #fields2.recordcount# is not 0>
	<u>Alternative Rule</u><br>
	<cfloop query="fields2"><CFOUTPUT>
	<INPUT TYPE="hidden" NAME="field_nm2" VALUE="#field_nm#">
	<INPUT TYPE="hidden" NAME="alt" VALUE="Y">
	<CFIF #type# is "txt">
		#field_desc# must be
		<select NAME="op2" size="1">
			<option>
			<option VALUE="eq">equal to
			<option VALUE="gt">greater than
			<option VALUE="lt">less than
			<option VALUE="gteq">greater than or equal to 
			<option VALUE="lteq">less than or equal to
		</select>
	<CFIF isdefined("inc2")><INPUT TYPE="text" NAME="criteria2" size="10" VALUE="income table">
		<table border="1" width="75%">
		<tr><th>No in Household</th><th>Income Level</th></tr>
		<tr><td>1</td><td><INPUT TYPE="text" NAME="2hh_1"></td></tr>
		<tr><td>2</td><td><INPUT TYPE="text" NAME="2hh_2"></td></tr>
		<tr><td>3</td><td><INPUT TYPE="text" NAME="2hh_3"></td></tr>
		<tr><td>4</td><td><INPUT TYPE="text" NAME="2hh_4"></td></tr>
		<tr><td>5</td><td><INPUT TYPE="text" NAME="2hh_5"></td></tr>
		<tr><td>6</td><td><INPUT TYPE="text" NAME="2hh_6"></td></tr>
		<tr><td>7</td><td><INPUT TYPE="text" NAME="2hh_7"></td></tr>
		<tr><td>8 or more</td><td><INPUT TYPE="text" NAME="2hh_8"></td></tr>
		</table>
	<cfelse>
		<INPUT TYPE="text" NAME="criteria2" size="10"><br>
		If this rule applies to an income table, please click <INPUT TYPE="submit" NAME="inc2" VALUE="Here"><br></CFIF>
	</CFIF></CFOUTPUT><CFOUTPUT>
	<CFIF #type# is "yn">
		#field_desc# must be
		<INPUT TYPE="hidden" NAME="op2" VALUE="eq">
		<select NAME="criteria2"><option><option VALUE="Y">Yes &nbsp;<option VALUE="N">No</select>
	</CFIF></CFOUTPUT>
	<CFIF #type# is "opt">
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="opts">
			select option_nm from tbl_opt where field_nm = '#field_nm#'
		</CFQUERY>
		<select NAME="op2"><option><option VALUE="eq">Must be <option VALUE="neq"> Must not be</select>
		<select NAME="criteria2"><option><CFOUTPUT query="opts"><option VALUE="#option#">#option#</CFOUTPUT></select><br>
	</CFIF>
	</cfloop>
<cfelse>
	<INPUT TYPE="hidden" NAME="field_nm2" VALUE=" ">
	<INPUT TYPE="hidden" NAME="alt" VALUE="N">
</CFIF><br><br>
Note:<textarea NAME="note" cols="45" rows="2"></textarea><br>
<cf_taghidden><br>
<INPUT TYPE="submit" NAME="add" VALUE="Add">
<INPUT TYPE="submit" VALUE="Cancel" onclick="history.go(-1)">
</FORM>
</BODY>
</HTML>
