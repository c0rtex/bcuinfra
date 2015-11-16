<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: NO LONGER USED--- original purpose: to give users a list of programs to set eligibility dependent on 
CALLED BY:
GOES TO:
=====================================================--->


<CFIF IsDefined("done")>
	<CFLOCATION URL="prg_rule.cfm?user=#user#&prg_id=#prg_id#&like=#like#">
</CFIF>

<CFIF IsDefined("st")>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prgs">
		SELECT prg_nm,prg_id
		FROM tbl_prg
		WHERE st = '#st#'
	</CFQUERY>
<CFELSE>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="state">
		SELECT st 
		FROM tbl_prg
		WHERE prg_id = '#prg_id#'
	</CFQUERY>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prgs">
		SELECT prg_nm,prg_id
		FROM tbl_prg
		WHERE st = '#state.st#'
	</CFQUERY>
</CFIF>
<HTML>
<HEAD>
	<TITLE>Add rule</TITLE>
</HEAD>
<BODY>
<FORM action="add_rule2.cfm" method="post">
Please choose the program that has the same eligibility rules.<br>
All programs listed are in the same state as the current program.<br>
For programs in a different state; Choose state <cf_tagstate> then click <font size="-1"><INPUT TYPE="submit" NAME="newstate" VALUE="New State"></font><br>
<br>
<select NAME="like"><CFOUTPUT query="prgs"><option VALUE="#prg_id#">#prg_nm#</CFOUTPUT></select>
<br>
<cf_taghidden level=#level# st=#st#> 
<INPUT TYPE="submit" NAME="done" VALUE="Done">
</FORM>
</BODY>
</HTML>
