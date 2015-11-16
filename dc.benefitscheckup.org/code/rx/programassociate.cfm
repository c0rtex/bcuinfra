<cfset src=url.src>

<cfif IsDefined('url.brand_id') or IsDefined('url.generic_id') or IsDefined('url.company_id')>

<cfif IsDefined('url.brand_id')>
	<cfset id=url.brand_id>
	<cfset title="Associate Program with Brand-Name Drug">
	<cfset section="drug">
	<cfset namepart="drug">
	<cfset hide="brand_id">
<cfelseif IsDefined('url.generic_id')>
	<cfset id=url.generic_id>
	<cfset title="Associate Program with Generic Drug">
	<cfset section="generic">
	<cfset namepart="generic">
	<cfset hide="generic_id">
<cfelse>
	<cfset id=url.company_id>
	<cfset title="Associate Program with Rx Company">
	<cfset section="drugcompany">
	<cfset namepart="company">
	<cfset hide="company_id">
</cfif>

<cfquery name="get" datasource="#application.dbSrc#">
	select dl.display_text
	from answerfield a, display_language dl
	where a.answerfield_id=#id#
		and a.display_id=dl.display_id
		and dl.language_id='EN'
</cfquery>

<cfif get.recordcount eq 0>
	<cfset name="">
<cfelse>
	<cfset name=get.display_text>
</cfif>

<cf_buildPage title="#title#" section="rx">
<cfoutput>

<h2>#title#</h2>

<table border="0" cellpadding="3" cellspacing="3">
<tr>
	<td bgcolor="#Evaluate("application.color.#section#.dark")#" colspan="2"><font size="+1"><b>#name#</b></font></td>
</tr>
</table><br>


<cfset pids = "''">
<cfquery name="programlist_vpa" datasource="#application.dbSrc#">
			select program_id
			from view_program_answerfield
			where answerfield_id=#id#
</cfquery>

<cfloop query="programlist_vpa">
    	<cfset pids = pids & ", " & #program_id# & "">
</cfloop>

<cfquery name="programlist" datasource="#application.dbSrc#">
	select p.program_id recid, p.program_code
	from program p
	where p.program_id not in ( #pids# )
	order by p.program_code
</cfquery>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#Evaluate("application.color.#section#.med")#">
<form action="association.cfm" method="post">
	<tr>
	<td colspan="2"><b>Choose a program from the list:</b></td>
	</tr>
	<tr>
	<td colspan="2"><select name="program_id">
	<cfloop query="programlist">
		<option value="#recid#">#program_code#</option>
	</cfloop>
	</select></td>
	</tr>
	<tr>
	<td><input type="hidden" name="answerfield_id" value="#id#">
	<input type="hidden" name="src" value="#src#">
	<input type="submit" value="Associate program with #namepart#"></td>
</form>
<form action="#namepart#view.cfm?#hide#=#id#" method="post">
	<td align="right"><input type="submit" value="Cancel"></td>
</form>
	</tr>
<table>

</cfoutput>
</cf_buildPage>




<cfelse>



<cfset id=url.program_id>

<cfquery name="ra" datasource="#application.dbSrc#">
	select rule_id
	from `rule` r
	where rx_program_id=#id#
</cfquery>
<cfif ra.RecordCount eq 0>
	<cfset rule_id = 0>
<cfelse>
	<cfset rule_id = ra.rule_id>
</cfif>

<cfquery name="get" datasource="#application.dbSrc#">
	select dl.display_text prg_nm
	from program p, display_language dl
	where p.program_id=#id#
		and p.name_display_id=dl.display_id
		and dl.language_id='EN'
</cfquery>
<cfif get.recordcount eq 0>
	<cfset name="">
<cfelse>
	<cfset name=get.prg_nm>
</cfif>


<cfif src eq 'd'>


<cfset title="Associate Brand-Name Drug with Program">
<cf_buildPage title="#title#" section="rx">
<cfoutput>

<h2>#title#</h2>

<table border="0" cellpadding="3" cellspacing="3">
<tr>
	<td bgcolor="#application.color.program.dark#" colspan="2"><font size="+1"><b>#name#</b></font></td>
</tr>
</table><br>

<cfquery name="druglist" datasource="#application.dbSrc#">
	select a.answerfield_id, substring(dl.display_text, 1, 255) as chop
	from answerfield a, display_language dl
	where a.answerfieldtype_id=13
		and a.answerfield_id not in (
				select answerfield_id
				from rule_answerfield
				where rule_id=#rule_id#
			)
		and a.display_id=dl.display_id
		and dl.language_id='EN'
	order by chop
</cfquery>
<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.drug.med#">
<form action="association.cfm" method="post">
	<tr>
	<td colspan="2"><b>Choose a brand-name drug from the list:</b></td>
	</tr>
	<tr>
	<td colspan="2"><select name="answerfield_id">
	<cfloop query="druglist">
		<option value="#answerfield_id#">#Left(chop, 70)#</option>
	</cfloop>
	</select></td>
	</tr>
	<tr>
	<td><input type="hidden" name="program_id" value="#id#">
	<input type="hidden" name="src" value="p">
	<input type="submit" value="Associate brand-name with program"></td>
</form>
<form action="programview.cfm?program_id=#id#" method="post">
	<td align="right"><input type="submit" value="Cancel"></td>
</form>
	</tr>
</table>

</cfoutput>
</cf_buildPage>


<cfelseif src eq 'g'>

<cfset title="Associate Generic Drug with Program">
<cf_buildPage title="#title#" section="rx">
<cfoutput>

<h2>#title#</h2>

<table border="0" cellpadding="3" cellspacing="3">
<tr>
	<td bgcolor="#application.color.program.dark#" colspan="2"><font size="+1"><b>#name#</b></font></td>
</tr>
</table><br>

<cfquery name="druglist" datasource="#application.dbSrc#">
	select a.answerfield_id, substring(dl.display_text, 1, 255) as chop
	from answerfield a, display_language dl
	where a.answerfieldtype_id=14
		and a.answerfield_id not in (
				select answerfield_id
				from rule_answerfield
				where rule_id=#rule_id#
			)
		and a.display_id=dl.display_id
		and dl.language_id='EN'
	order by chop
</cfquery>
<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.generic.med#">
<form action="association.cfm" method="post">
	<tr>
	<td colspan="2"><b>Choose a generic drug from the list:</b></td>
	</tr>
	<tr>
	<td colspan="2"><select name="answerfield_id">
	<cfloop query="druglist">
		<option value="#answerfield_id#">#Left(chop, 70)#</option>
	</cfloop>
	</select></td>
	</tr>
	<tr>
	<td><input type="hidden" name="program_id" value="#id#">
	<input type="hidden" name="src" value="p">
	<input type="submit" value="Associate generic with program"></td>
</form>
<form action="programview.cfm?program_id=#id#" method="post">
	<td align="right"><input type="submit" value="Cancel"></td>
</form>
	</tr>
</table>

</cfoutput>
</cf_buildPage>

<cfelse>

<cfset title="Associate Rx Company with Program">
<cf_buildPage title="#title#" section="rx">
<cfoutput>

<h2>#title#</h2>

<table border="0" cellpadding="3" cellspacing="3">
<tr>
	<td bgcolor="#application.color.program.dark#" colspan="2"><font size="+1"><b>#name#</b></font></td>
</tr>
</table><br>

<cfquery name="druglist" datasource="#application.dbSrc#">
	select a.answerfield_id, substring(dl.display_text, 1, 255) as chop
	from answerfield a, display_language dl
	where a.answerfieldtype_id=15
		and a.answerfield_id not in (
				select answerfield_id
				from rule_answerfield
				where rule_id=#rule_id#
			)
		and a.display_id=dl.display_id
		and dl.language_id='EN'
	order by chop
</cfquery>
<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.drugcompany.med#">
<form action="association.cfm" method="post">
	<tr>
	<td colspan="2"><b>Choose an Rx company from the list:</b></td>
	</tr>
	<tr>
	<td colspan="2"><select name="answerfield_id">
	<cfloop query="druglist">
		<option value="#answerfield_id#">#Left(chop, 70)#</option>
	</cfloop>
	</select></td>
	</tr>
	<tr>
	<td><input type="hidden" name="program_id" value="#id#">
	<input type="hidden" name="src" value="p">
	<input type="submit" value="Associate company with program"></td>
</form>
<form action="programview.cfm?program_id=#id#" method="post">
	<td align="right"><input type="submit" value="Cancel"></td>
</form>
	</tr>
</table>

</cfoutput>
</cf_buildPage>

</cfif>


</BODY>
</HTML>
</cfif>