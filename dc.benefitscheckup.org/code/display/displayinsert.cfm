<cfparam name="attributes.text" type="string">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.title" type="string">
<cfparam name="attributes.group" type="string" default="">
<cfparam name="attributes.varname" type="string" default="display_id">

<cfset did = 0><!--- output value (0 = no success) --->
<cfquery name="getgroup" datasource="#application.dbSrc#">
	select displaygroup_id
	from displaygroup
	where displaygroup_code='#attributes.group#'
</cfquery>
<cfif attributes.group eq '' Or getgroup.RecordCount><!--- continue only if display group exists --->
	<cfif attributes.group eq ''>
		<cfset dgid = 'NULL'>
	<cfelse>
		<cfset dgid = getgroup.displaygroup_id>
	</cfif>
	<cfquery name="checkcode" datasource="#application.dbSrc#">
		select display_id
		from display
		where display_code='#attributes.code#'
	</cfquery>
	<cfif Not checkcode.RecordCount><!--- continue only if display code doesn't exist --->
		<cfquery name="insertdisplay" datasource="#application.dbSrc#">
			insert into display
				(displaygroup_id, display_code, display_name, display_desc, active_flag)
			values
				(#dgid#, '#attributes.code#', '#attributes.title#', NULL, 1)
		</cfquery>
		<cfquery name="getdid" datasource="#application.dbSrc#">
			select display_id
			from display
			where display_code='#attributes.code#'
		</cfquery>
		<cfset did = getdid.display_id>
		<cfquery name="insertdisplay" datasource="#application.dbSrc#">
			insert into display_language
				(display_id, language_id, display_text, update_flag)
			values
				(#did#, 'EN', '#attributes.text#', 0)
		</cfquery>
		<cfquery name="getactivelanguages" datasource="#application.dbSrc#">
			select language_id
			from language
			where default_flag=0
				and active=1
			order by language_id
		</cfquery>
		<cfloop query="getactivelanguages">
			<cfquery name="insertdisplay" datasource="#application.dbSrc#">
				insert into display_language
					(display_id, language_id, display_text, update_flag)
				values
					(#did#, '#language_id#', '', 1)
			</cfquery>
		</cfloop>
	</cfif>
</cfif>
<cfset "caller.#attributes.varname#" = did>