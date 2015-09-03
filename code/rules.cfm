
<cfquery name="programs" datasource="#application.dbSrc#">
	select sp.program_id, p.st, p.prg_id, p.prg_nm
	from view_subset_program_sum sp, tbl_prg_all p
	where sp.subset_id=<cfif IsDefined("session.subset_id")>#session.subset_id#<cfelse>0</cfif>
		and sp.program_id=p.RecID
		<cfif IsDefined('session.st') and session.st neq ''>
		and p.st in ('FD', '#session.st#')
		</cfif>
	order by p.st, p.prg_nm
</cfquery>


<cfoutput>

<table width="100%" border="0">
	<tr>
		<td align="left" valign="top">
		
<form action="rules.cfm" method="post">
	<input type="Submit" value="Refresh">
</form>

<table border="1" cellspacing="0" cellpadding="3">
	<tr>
		<td valign="top" colspan="2"><b>Screening Answerfields</b></td>
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
		<td valign="top" colspan="4"><b>Subset <cfif IsDefined("session.subset_id")>#session.subset_id#<cfelse>0</cfif> Programs</b><cfif IsDefined('session.st') and session.st neq ''> (FD and #session.st#)</cfif></td>
	</tr>
<cfloop query="programs">
	<tr>
		<td valign="top">#st#</td>
		<td valign="top">#prg_id#</td>
		<td valign="top">#prg_nm#</td>
		<td valign="top"><a href="rules_test.cfm?program_id=#program_id#">test</a></td>
	</tr>
</cfloop>
</table>

		</td>
	</tr>

</table>

</cfoutput>