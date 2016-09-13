<cfparam name="program_id" type="numeric">

<cfquery name="rules" datasource="#application.dbSrc#">
	select r.prg_id, r.elig_rule, r.pri_sec
    from tbl_prg_all p, tbl_rules r
	where p.RecID=<cfqueryparam cfsqltype="cf_sql_integer" value="#program_id#" maxlength="4">
		and p.prg_id=r.prg_id
	order by r.pri_sec, r.RecID
</cfquery>



<cfinclude template="tagGetIncomeTables.cfm">



<cfoutput><h1>#dependcount#</h1><h2>#struct_mem[510]#</h2><h3>#listable[510]#</h3>

<table width="100%" border="0">
	<tr>
		<td align="left" valign="top">
		
<table border="0" cellspacing="0" cellpadding="3">
<tr><td><form action="rules_test.cfm" method="post">
	<input type="hidden" name="program_id" value="#program_id#">
	<input type="Submit" value="Refresh">
</form></td>
<td>&nbsp;</td>
<td><form action="rules.cfm" method="post">
	<input type="Submit" value="Back">
</form></td></tr>
</table>

<table border="1" cellspacing="0" cellpadding="3">
	<tr>
		<td valign="top" colspan="2"><b>Session Answerfields</b></td>
	</tr>
   
<cfloop collection="#application.AnswerfieldPool.getAnswerfields()#" item="af">
	<cf_handleScreeningAnswerfield action="get" code="#af#" element="val" var="afVal">
	<tr>
		<td valign="top">#af#</td>
		<td valign="top">#afVal#</td>
	</tr>
</cfloop>
</table>

		</td>

		<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>

		<td align="right" valign="top">

<table border="1" cellspacing="0" cellpadding="3">
	<tr>
		<td valign="top" colspan="3"><b>Program #rules.prg_id# Rules</b></td>
	</tr>
<cfloop query="rules">
	<tr>		
		<td valign="top">#pri_sec#</td>
		<td valign="top">#elig_rule#</td>
		<cf_testCondition condition="#elig_rule#">
		<td valign="top"><cfif value eq 2><b><font color="green">True</font></b><cfelseif value eq 1><b><font color="red">False</font></b><cfelse>uncertain</cfif></td>
	</tr>
</cfloop>
</table>

		</td>
	</tr>

</table>

</cfoutput>