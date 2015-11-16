<cfparam name="program_id" type="string" default="">
<cfparam name="display_id" type="string" default="">
<cfparam name="programtext_id" type="string" default="">
<cfparam name="definition_id" type="string" default="">
<cfparam name="hint_id" type="string" default="">
<cfparam name="partner_id" type="string" default="">
<cfparam name="subset_id" type="string" default="">
<cfparam name="entrypoint_id" type="string" default="">
<cfparam name="desc" type="string" default="">
<cfparam name="name" type="string" default="">

<cfif program_id neq ''>

	<cfquery name="lookup" datasource="#application.dbSrc#">
		select prg_id, st
		from tbl_prg_all
		where RecID=#program_id#
	</cfquery>
	<cfif lookup.RecordCount gt 0>
		<cfset session.st = lookup.st>
		<cfset session.prgid = lookup.prg_id>
		<cfset session.prg_nm = ''>
		<cfif name neq ''>
			<cflocation url="../programs/program.cfm?prg_id=#lookup.prg_id#&st=#lookup.st#">
		<cfelse>
			<cflocation url="../programs/prg_edit_name.cfm?prg_id=#lookup.prg_id#&st=#lookup.st#">
		</cfif>
	<cfelse>
		<h1>That program ID number could not be found.  Please check the number and try again.</h1>
	</cfif>

<cfelseif display_id neq ''>

	<cfquery name="lookup" datasource="#application.dbSrc#">
		select dg.displaygroup_code, dg.displaygroup_name
		from display d, displaygroup dg
		where d.display_id=#display_id#
	        and d.displaygroup_id=dg.displaygroup_id
	</cfquery>
	<cfif lookup.RecordCount gt 0>
		<cfif lookup.displaygroup_code eq 'question'>
			<cfquery name="relookup" datasource="#application.dbSrc#">
				select question_id
				from question
				where display_id=#display_id#
			</cfquery>
			<cfif relookup.RecordCount gt 0>
				<cflocation url="../question/questionview.cfm?id=#relookup.question_id#&action=edit">
			<cfelse>
				<h1>That display ID number could not be found.  Please check the number and try again.</h1>
			</cfif>
		<cfelseif lookup.displaygroup_code eq 'rx'>
			<cfquery name="relookup" datasource="#application.dbSrc#">
				select answerfield_id
				from answerfield
				where display_id=#display_id#
			</cfquery>
			<cfif relookup.RecordCount gt 0>
				<cflocation url="../rx/drugedit.cfm?brand_id=#relookup.answerfield_id#">
			<cfelse>
				<h1>That display ID number could not be found.  Please check the number and try again.</h1>
			</cfif>
		<cfelseif lookup.displaygroup_code eq 'site'>
			<cfquery name="relookup" datasource="#application.dbSrc#">
				select sitetext_id
				from sitetext
				where display_id=#display_id#
			</cfquery>
			<cfif relookup.RecordCount gt 0>
				<cflocation url="../display/sitetextview.cfm?id=#relookup.sitetext_id#&action=edit">
			<cfelse>
				<h1>That display ID number could not be found.  Please check the number and try again.</h1>
			</cfif>
		<cfelse>
			<h2><cfoutput>Please tell Bill that I don't know how to handle "<b>#lookup.displaygroup_name#</b>," or check the number and try again.</cfoutput></h2>
		</cfif>
	<cfelse>
		<h1>That display ID number could not be found.  Please check the number and try again.</h1>
	</cfif>

<cfelseif programtext_id neq ''>

	<cflocation url="../programs/programtextview.cfm?id=#programtext_id#&action=edit">

<cfelseif definition_id neq ''>

	<cflocation url="../definitions/edit_def.cfm?id=#definition_id#">

<cfelseif hint_id neq ''>

	<cfquery name="lookup" datasource="#application.dbSrc#">
		select keyword
		from tbl_hints
		where id=#hint_id#
	</cfquery>
	<cfif lookup.RecordCount gt 0>
		<cflocation url="../definitions/edit_hint.cfm?keyword=#lookup.keyword#">
	<cfelse>
		<h1>That hint ID number could not be found.  Please check the number and try again.</h1>
	</cfif>

<cfelseif partner_id neq ''>

	<cflocation url="../partner/partnerview.cfm?id=#partner_id#&action=edit">

<cfelseif subset_id neq ''>

	<cflocation url="../subset/subsetedit.cfm?id=#subset_id#">

<cfelseif entrypoint_id neq ''>

	<cfquery name="lookup" datasource="#application.dbSrc#">
		select org_id
		from tbl_entry
		where RecID=#entrypoint_id#
	</cfquery>
	<cfif lookup.RecordCount gt 0>
		<cfquery name="relookup" datasource="#application.dbSrc#">
			select prg_id
			from tbl_prg_entry
			where org_id=#lookup.org_id#
		</cfquery>
		<cfset session.prg_id = relookup.prg_id>
		<cflocation url="../programs/edit_spons.cfm?org_id=#lookup.org_id#&prg_id=#relookup.prg_id#">
	<cfelse>
		<h1>That entry point ID number could not be found.  Please check the number and try again.</h1>
	</cfif>

<cfelse>
	<h1>That ID number could not be found.</h1>
</cfif>