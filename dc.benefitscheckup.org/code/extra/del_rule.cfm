<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!-- delete req material -->
<HTML>
<HEAD>
	<TITLE>Delete</TITLE>
</HEAD>

<BODY>
<FORM action="del_rule2.cfm" method="post">
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="qry">
select rule_id
from tbl_elig_rules
where prg_id ='#prg_id#'
</CFQUERY>

<CFIF level is "session.user1">
Sorry you do not have the rights for this function.<cfabort>
</CFIF>
<CFIF qry.recordcount is 0>No entry points to delete.<cfabort></CFIF>
Please choose which rule(s) you would like to delete.<br>
<select NAME="rule_id" size="10" multiple>
<CFOUTPUT query="qry"><option VALUE="#rule_id#">#rule_id#</CFOUTPUT>
</select>
<INPUT TYPE="submit" VALUE="Delete">
<cf_taghidden level="yes">
</FORM>
</BODY>
</HTML>
