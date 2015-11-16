<cf_checkAccess level="5">

<cfset grid=StructNew()>
<cfquery name="getgroup" datasource="#application.dbSrc#">
	select dg.displaygroup_id, dg.displaygroup_code, dg.displaygroup_name
	from displaygroup dg
	order by dg.displaygroup_name
</cfquery>
<cfquery name="getlang" datasource="#application.dbSrc#">
	select l.language_id, l.default_flag, l.active, dl.display_text
	from language l, display_language dl
	where l.display_id=dl.display_id
		  and dl.language_id='EN'
	order by l.default_flag desc, l.active desc, substring(dl.display_text, 1, 255)
</cfquery>
<cfquery name="counts" datasource="#application.dbSrc#">
	select l.language_id, q.displaygroup_id, q.displaygroup_code, q.displaygroup_name, sum(1 - q.update_flag) as s
	from language as l left outer join (
			select dl.language_id, dl.update_flag, d.displaygroup_id, dg.displaygroup_code, dg.displaygroup_name
			from display_language dl, display d, displaygroup dg
			where dl.update_flag = 0
				and dl.display_id = d.display_id
				and d.displaygroup_id = dg.displaygroup_id
		) as q on l.language_id = q.language_id
	group by l.language_id, l.default_flag, l.active, q.displaygroup_id, q.displaygroup_code, q.displaygroup_name
	order by l.default_flag desc, l.active desc, l.language_id, q.displaygroup_name
</cfquery>
<cfset colDef = 0>
<cfset colAct = 0>
<cfset colIna = 0>
<cfloop query="getlang">
	<cfif default_flag>
		<cfset colDef = colDef + 1>
	<cfelseif active>
		<cfset colAct = colAct + 1>
	<cfelse>
		<cfset colIna = colIna + 1>
	</cfif>
</cfloop>
<cfloop query="getgroup">
	<cfset dc = displaygroup_code>
	<cfset "grid.#dc#" = StructNew()>
	<cfloop query="getlang">
		<cfset "grid.#dc#.#language_id#" = 0>
	</cfloop>
</cfloop>
<cfloop query="counts">
	<cfif displaygroup_code neq ''>
		<cfset "grid.#displaygroup_code#.#language_id#" = s>
	</cfif>
</cfloop>


<cf_buildPage title="Site Text Administration" section="display"><cfoutput>

<h3>Number of Site Text Strings Requiring Translation</h3>

<table cellpadding="3" cellspacing="3" border="0">
	<tr>
		<td rowspan="2" align="left" valign="bottom" bgcolor="#application.color.display.dark#"><b>Site Text Category</b></td>
		<cfif colDef>
			<td colspan="#colDef#" align="center" valign="bottom" bgcolor="#application.color.display.dark#"><font size="-1"><i>default language</i></font></td>
		</cfif>
		<cfif colAct>
			<td colspan="#colAct#" align="center" valign="bottom" bgcolor="#application.color.display.med#"><font size="-1"><i>active languages</i></font></td>
		</cfif>
		<cfif colAct>
			<td colspan="#colIna#" align="center" valign="bottom" bgcolor="#application.color.display.light#"><font size="-1"><i>inactive languages</i></font></td>
		</cfif>
	</tr>
	<tr bgcolor="#application.color.display.med#">
	<cfloop query="getlang">
		<td align="center" valign="bottom"<cfif default_flag> bgcolor="#application.color.display.dark#"</cfif>><b>#language_id#</b><br><font size="-1"><i>#display_text#</i></font></td>
	</cfloop>
	</tr>
	<cfloop query="getgroup">
		<cfset dc = displaygroup_code>
		<cfset dd = displaygroup_id>
	<tr bgcolor="#application.color.display.light#">
		<td align="left" valign="bottom" bgcolor="#application.color.display.med#"><b>#displaygroup_name#</b></td>
		<cfset basic = 0>
		<cfloop query="getlang">
			<cfif default_flag>
				<cfset basic = Evaluate("grid.#dc#.#language_id#")>
				<cfset total = basic>
		<td align="center" valign="middle" bgcolor="#application.color.display.med#"><b>#basic#</b></td>
			<cfelse>
				<cfset total = basic - Evaluate("grid.#dc#.#language_id#")>
				<cfif total>
		<td align="center" valign="middle"><i><cf_checkAccessLink level="5" href="xlategroup.cfm?displaygroup_id=#dd#&language_id=#language_id#">#total#</cf_checkAccessLink></i></td>
				<cfelse>
		<td align="center" valign="middle" bgcolor="#application.color.display.med#"><b><cf_checkAccessLink level="5" href="xlategroup.cfm?displaygroup_id=#dd#&language_id=#language_id#">#total#</cf_checkAccessLink></b></td>
				</cfif>
			</cfif>
		</cfloop>
	</tr>
	</cfloop>
</table>

<br>
</cfoutput></cf_buildPage>