<cfparam name="attributes.table" type="string">
<cfparam name="attributes.item" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.entrypoint_id" type="numeric">
<cfparam name="attributes.state_id" type="string">
<cfparam name="attributes.county_id" type="string" default="">
<cfparam name="attributes.entrypointgroup_id" type="numeric" default="0">
<cfparam name="attributes.crosstable" type="string">
<cfparam name="attributes.crosscolumn" type="string" default="">
<cfparam name="attributes.saving" type="numeric" default="0">
<cfparam name="attributes.reps" type="numeric" default="0">
<cfparam name="attributes.rows" type="numeric" default="18">
<cfparam name="attributes.width" type="numeric" default="250">
<cfparam name="attributes.title" type="string" default="">
<cfparam name="attributes.redirect" type="string" default="">
<cfparam name="attributes.name" type="string" default="">
<cfparam name="attributes.message" type="string" default="">

<cf_tableLoad table="#attributes.table#">
<cfset main = StructNew()>
<cfset main.table = attributes.table>
<cfset main.keys = keys>
<cfset main.tag = tag>
<cfset main.name = name>

<cf_tableLoad table="#attributes.crosstable#">
<cfset cross = StructNew()>
<cfset cross.table = attributes.crosstable>
<cfset cross.tag = tag>

<cfset locallight = Evaluate("application.color.#attributes.code#.light")>
<cfset localmed = Evaluate("application.color.#attributes.code#.med")>
<cfset localdark = Evaluate("application.color.#attributes.code#.dark")>

<cfif attributes.saving eq 1>

	<cfset cleanList = ''>
	<cfloop list="#ListAppend(poollist, servedlist)#" index="x">
		<cfset cleanList = ListAppend(cleanList, "'#x#'", ', ')>
	</cfloop>
	<cfif cleanList neq ''>
		<cfquery name="ordered" datasource="#application.dbSrc#">
			delete from `#cross.table#`
			where entrypoint_id=#attributes.entrypoint_id#
				and #attributes.crosscolumn# in (#PreserveSingleQuotes(cleanList)#)
		</cfquery>
	</cfif>
	<cfloop list="#servedlist#" index="x">
		<cfquery name="ordered" datasource="#application.dbSrc#">
			insert into `#cross.table#`
				(entrypoint_id, #attributes.crosscolumn#)
			values
				(#attributes.entrypoint_id#, '#x#')
		</cfquery>
	</cfloop>
	<cfif attributes.name neq ''>
		<cfset attributes.name = "###attributes.name#">
	</cfif>
	<cfif attributes.redirect eq ''>
		<cflocation url="entrypointview.cfm?id=#attributes.entrypoint_id##attributes.name#" addtoken="no">
	<cfelse>
		<cflocation url="#attributes.redirect##attributes.name#" addtoken="no">
	</cfif>

<cfelse>

<cfif main.table eq 'county'>
	<cfset includeCountySelect = false>
<cfelse>
	<cfset includeCountySelect = true>
</cfif>
<cfif includeCountySelect and attributes.county_id neq ''>
	<cfset limitByCounty = true>
<cfelse>
	<cfset limitByCounty = false>
</cfif>
<cfset attributes.reps = attributes.reps + 1>

<cfquery name="state" datasource="#application.dbSrc#">
	select state_name name
	from state
	where state_id='#attributes.state_id#'
</cfquery>
<cfif limitByCounty>
	<cfquery name="county" datasource="#application.dbSrc#">
		select county_name name
		from county
		where county_id='#attributes.county_id#'
	</cfquery>
	<cfset countyName = ''>
	<cfloop list="#county.name#" index="x" delimiters=" ">
		<cfif countyname eq '' or (x neq 'and' and x neq 'of' and x neq 'de' and x neq 'du')>
			<cfset x = UCase(Left(x, 1)) & LCase(Right(x, Len(x) - 1))>
			<cfif Left(x, 2) eq 'Mc' and Len(x) gt 2>
				<cfset x = Left(x, 2) & UCase(Mid(x, 3, 1)) & Right(x, Len(x) - 3)>
			</cfif>
		<cfelse>
			<cfset x = LCase(x)>
		</cfif>
		<cfset countyName = ListAppend(countyName, x, ' ')>
	</cfloop>
</cfif>
<cfquery name="groups" datasource="#application.dbSrc#">
	select g.entrypointgroup_id, g.name
	from entrypoint_entrypointgroup eg, entrypointgroup g
	where eg.entrypoint_id=#attributes.entrypoint_id#
		and eg.entrypointgroup_id=g.entrypointgroup_id
	order by g.entrypointgroup_id
</cfquery>
<cfquery name="served" datasource="#application.dbSrc#">
	select #main.tag#.#main.keys#, #main.tag#.#main.name#, #main.tag#.valid
	from `#cross.table#` #cross.tag#, `#main.table#` #main.tag#<cfif main.table eq 'city'><cfif limitByCounty>, zip z</cfif></cfif>
	where #cross.tag#.entrypoint_id=#attributes.entrypoint_id#
		and #cross.tag#.#attributes.crosscolumn#=#main.tag#.#attributes.crosscolumn#
		and #main.tag#.state_id='#attributes.state_id#'
		<cfif limitByCounty and main.table eq 'zip'>and #main.tag#.county_id='#attributes.county_id#'</cfif>
		<cfif main.table eq 'city'>
				<cfif limitByCounty>and vw.zipcode=z.zipcode
									and z.valid=1
									and z.county_id='#attributes.county_id#'</cfif></cfif>
	group by #main.tag#.#main.keys#, #main.tag#.#main.name#, #main.tag#.valid
	order by #main.tag#.#main.name#
</cfquery>
<cfquery name="pool" datasource="#application.dbSrc#">
	select #main.tag#.#main.keys#, #main.tag#.#main.name#
	from `#main.table#` #main.tag#<cfif main.table eq 'city'><cfif limitByCounty>, zip z</cfif></cfif>
	where #main.tag#.state_id='#attributes.state_id#'
		and #main.tag#.valid=1
		<cfif limitByCounty and main.table eq 'zip'>and #main.tag#.county_id='#attributes.county_id#'</cfif>
		<cfif main.table eq 'city'>
				<cfif limitByCounty>and vw.zipcode=z.zipcode
									and z.valid=1
									and z.county_id='#attributes.county_id#'</cfif></cfif>
		and #main.tag#.#main.keys# not in (
			select #main.tag#.#main.keys#
			from `#cross.table#` #cross.tag#, `#main.table#` #main.tag#<cfif main.table eq 'city'><cfif limitByCounty>, zip z</cfif></cfif>
			where #cross.tag#.entrypoint_id=#attributes.entrypoint_id#
				and #cross.tag#.#attributes.crosscolumn#=#main.tag#.#attributes.crosscolumn#
				and #main.tag#.state_id='#attributes.state_id#'		
				<cfif limitByCounty and main.table eq 'zip'>and #main.tag#.county_id='#attributes.county_id#'</cfif>
				<cfif main.table eq 'city'>
						<cfif limitByCounty>and vw.zipcode=z.zipcode
											and z.valid=1
											and z.county_id='#attributes.county_id#'</cfif></cfif>
			<cfif attributes.entrypointgroup_id>union
			select #main.tag#.#main.keys#
			from entrypoint_entrypointgroup eg, `#cross.table#` #cross.tag#, `#main.table#` #main.tag#
			where eg.entrypointgroup_id=#attributes.entrypointgroup_id#
				and eg.entrypoint_id != #attributes.entrypoint_id#
				and eg.entrypoint_id=#cross.tag#.entrypoint_id
				and #cross.tag#.#attributes.crosscolumn#=#main.tag#.#attributes.crosscolumn#
				and #main.tag#.valid=1
			group by #main.tag#.#main.keys#</cfif>
		)
	<cfif main.table eq 'city'>group by #main.tag#.#main.keys#, #main.tag#.#main.name#</cfif>
	order by #main.tag#.#main.name#
</cfquery>
<cfset poolList = ''>
<cfset servedList = ''>


<cfoutput>	

<table bgcolor="#localmed#" cellspacing="0" cellpadding="0" border="0"><tr>
<td align="left"><table bgcolor="#localmed#" cellspacing="5" cellpadding="0" border="0">
	<tr></tr>
	<cfquery name="states" datasource="#application.dbSrc#">
		select state_id, state_name
		from state
		where statetype_id in (1, 2)
		order by statetype_id, state_name
	</cfquery>
	<tr></tr>
	<form action="#cgi.script_name#" method="post" name="state">
		<tr>
			<td></td>
			<td valign="bottom" colspan="3" class="normal">
				<select name="state_id">
					<cfloop query="states">
					<option value="#state_id#"<cfif state_id eq attributes.state_id> selected</cfif>>#UCase(state_name)#</option>
					</cfloop>
				</select>
				&nbsp;
				<input type="submit" value="change state" />
			</td>
			<td></td>
		</tr>
		<input type="hidden" name="id" value="#attributes.entrypoint_id#">
		<input type="hidden" name="entrypointgroup_id" value="#attributes.entrypointgroup_id#">
		<input type="hidden" name="name" value="#attributes.name#">
		<input type="hidden" name="reps" value="#attributes.reps#">
	</form>
	<cfif includeCountySelect>
		<tr></tr>
		<cfquery name="counties" datasource="#application.dbSrc#">
			select county_id, county_name
			from county
			where state_id='#attributes.state_id#'
				and valid=1
			order by county_name
		</cfquery>
		<tr></tr>
		<form action="#cgi.script_name#" method="post" name="county">
			<tr>
				<td></td>
				<td valign="bottom" colspan="3" class="normal">
					<select name="county_id">
						<option value="">-- #state.name# counties --</option>
						<cfloop query="counties">
						<option value="#county_id#"<cfif county_id eq attributes.county_id> selected</cfif>>#county_name#</option>
						</cfloop>
					</select>
					&nbsp;
					<input type="submit" value="limit by county" />
				</td>
				<td></td>
			</tr>
			<input type="hidden" name="id" value="#attributes.entrypoint_id#">
			<input type="hidden" name="state_id" value="#attributes.state_id#">
			<input type="hidden" name="entrypointgroup_id" value="#attributes.entrypointgroup_id#">
			<input type="hidden" name="name" value="#attributes.name#">
			<input type="hidden" name="reps" value="#attributes.reps#">
		</form>
	</cfif>
	<cfif groups.RecordCount>
		<tr></tr>
		<tr></tr>
		<form action="#cgi.script_name#" method="post" name="county">
			<tr>
				<td></td>
				<td valign="bottom" colspan="3" class="normal">
					<select name="entrypointgroup_id">
						<option value="0">-- entry point groups --</option>
						<cfloop query="groups">
						<option value="#entrypointgroup_id#"<cfif entrypointgroup_id eq attributes.entrypointgroup_id> selected<cfset groupName = name></cfif>>#name#</option>
						</cfloop>
					</select>
					&nbsp;
					<input type="submit" value="limit by group coverage" />
				</td>
				<td></td>
			</tr>
			<input type="hidden" name="id" value="#attributes.entrypoint_id#">
			<input type="hidden" name="state_id" value="#attributes.state_id#">
			<input type="hidden" name="county_id" value="#attributes.county_id#">
			<input type="hidden" name="name" value="#attributes.name#">
			<input type="hidden" name="reps" value="#attributes.reps#">
		</form>
	</cfif>
	<form action="#cgi.script_name#?id=#attributes.entrypoint_id#&state_id=#attributes.state_id#" method="post" name="served">
	<tr></tr>
	<tr>
		<td>&nbsp;&nbsp;</td>
		<td valign="bottom" width="#attributes.width#" class="normal"><b>Available #attributes.item#<br /><span class="small">for <cfif limitByCounty>#countyName# County, </cfif>#state.name#<cfif IsDefined('groupName')><br />uncovered by #groupName#</cfif></span></b></td>
		<td></td>
		<td valign="bottom" width="#attributes.width#" class="normal"><b>#attributes.title#<br /><span class="small">for <cfif limitByCounty>#countyName# County, </cfif>#state.name#<cfif IsDefined('groupName')><br />uncovered by #groupName#</cfif></span></b></td>
		<td>&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td></td>
		<td valign="top" class="small"><i>Available #LCase(attributes.item)# are listed below. Select<br />a #main.table# and click the right arrow to transfer it to<br />the <b>#attributes.title#</b> box.</i></td>
		<td></td>
		<td valign="top" class="small"><i>Relevant #LCase(attributes.title)# are listed below.<br />Select a #main.table# and click the left arrow to move<br />it back to the <b>Available #attributes.item#</b> box.</i></td>
		<td></td>
	</tr>
	<tr>
		<td></td>
		<td valign="top"><select name="pool" size="#attributes.rows#" width="#attributes.width#" style="width: #attributes.width#" class="search" onMouseUp="if (ie) clicked(this, this.form.served, this, this.form.poollist, this.form.served, this.form.servedlist)" onFocus="if (ns) clicked(this, this.form.served, this, this.form.poollist, this.form.served, this.form.servedlist); this.blur()">|;

		<cfloop query="pool">
			<cfset poolList = ListAppend(poolList, Evaluate(attributes.crosscolumn))>
			<option value="#Evaluate(main.keys)#">#Evaluate(main.name)#</option>
		</cfloop>

		</select></td>
		<td align="center" valign="middle">
<input type="button" value=" --&gt; " class="search" onClick="moveElementAlpha(this.form.pool, this.form.served, this.form.pool, this.form.poollist, this.form.served, this.form.servedlist)"><br>
<br>
<input type="button" value=" &lt;-- " class="search" onClick="moveElementAlpha(this.form.served, this.form.pool, this.form.pool, this.form.poollist, this.form.served, this.form.servedlist)">
		</td>
		<td valign="top"><select name="served" size="#attributes.rows#" width="#attributes.width#" style="width: #attributes.width#" class="search" onMouseUp="if (ie) clicked(this, this.form.pool, this.form.pool, this.form.orderlist, this, this.form.removelist)" onFocus="if (ns) clicked(this, this.form.pool, this.form.pool, this.form.orderlist, this, this.form.removelist); this.blur()">

		<cfloop query="served">
			<cfset servedList = ListAppend(servedList, Evaluate(attributes.crosscolumn))>
			<option value="#Evaluate(main.keys)#">#Evaluate(main.name)#</option>
		</cfloop>

		</select></td>
		<td></td>
	</tr>
	<tr></tr>
	<cfif attributes.message neq ''>
	<tr>
		<td></td>
		<td valign="top" class="small"><i>#attributes.message#</i></td>
	</tr>
	<tr></tr>
	</cfif>
	<tr>
		<td></td>
		<td align="left" valign="top"><input type="button" value="save changes" class="search" onClick="servedSubmit(this.form.pool, this.form.poollist, this.form.served, this.form.servedlist);"> &nbsp; <input type="button" value="cancel" class="search" onClick="history.go(-#attributes.reps#);"><input type="hidden" name="poollist" value="#poolList#"><input type="hidden" name="servedlist" value="#servedList#"><input type="hidden" name="saving" value="1"><input type="hidden" name="reps" value="#attributes.reps#"><input type="hidden" name="name" value="#attributes.name#"></td>
		<td></td>
	</tr>
	<tr></tr>
	</form>
	<tr></tr>
</table></td></tr>
</table>

</cfoutput>

</cfif>
