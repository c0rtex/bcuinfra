<cfparam name="attributes.action" type="string">
<cfparam name="attributes.display_id" type="numeric" default="0">
<cfparam name="attributes.value" type="string">
<cfparam name="attributes.minor" type="boolean" default="false">
<cfparam name="attributes.group" type="string" default="">
<cfparam name="attributes.name" type="string" default="">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.var" type="string" default="display_id">
<cfparam name="attributes.datasource" type="string" default="">

<cfif attributes.datasource eq ''>
	<cfset attributes.datasource = application.dbSrc>
</cfif>

<cfif attributes.action eq 'insert'>

	<cfif attributes.group eq ''>
		<cfset group_id = 'NULL'>
		<cfset compname = attributes.name>
		<cfset compcode = LCase(attributes.code)>
	<cfelse>
		<cfquery name="groupinfo" datasource="#attributes.datasource#">
			select displaygroup_id, displaygroup_name
			from displaygroup
			where displaygroup_code = '#attributes.group#'
		</cfquery>
		<cfset group_id = groupinfo.displaygroup_id>
		<cfset compname = "#groupinfo.displaygroup_name#: #attributes.name#">
		<cfset compcode = LCase("#attributes.group#_#attributes.code#")>
	</cfif>

	<cfquery name="insertdisplay" datasource="#attributes.datasource#">
		insert into display
			(displaygroup_id, display_code, display_name, active_flag)
		values
			(#group_id#, '#compcode#', '#compname#', 1)
	</cfquery>
	<cfquery name="getdisp" datasource="#attributes.datasource#">
		select display_id
		from display
		where display_code='#compcode#'
	</cfquery>
	<cfset display_id=getdisp.display_id>

	<cfquery name="langinfo" datasource="#attributes.datasource#">
		select language_id, default_flag
		from language
		where active=1
	</cfquery>
	<cfloop query="langinfo">
		<cfif default_flag eq 1>
			<cfset display_text = attributes.value>
		<cfelse>
			<cfset display_text = ''>
		</cfif>
		<cfif attributes.value eq ''>
			<cfset update_flag = 0>
		<cfelse>
			<cfset update_flag = 1 - default_flag>
		</cfif>
		<cfquery name="insertdisplay" datasource="#attributes.datasource#">
			insert into display_language
				(display_id, language_id, display_text, update_flag)
			values
				(#display_id#, '#language_id#', '#display_text#', #update_flag#)
		</cfquery>
	</cfloop>
	<cfset "caller.#attributes.var#" = display_id>
<cfelse>

	<cfquery name="langinfo" datasource="#attributes.datasource#">
		select language_id
		from language
		where default_flag=1
			and active=1
	</cfquery>
	<cfset deflang_id = langinfo.language_id>
	
	<cfquery name="textcheck" datasource="#attributes.datasource#">
		select display_text
		from display_language
		where display_id=#attributes.display_id#
			and language_id='#deflang_id#'
	</cfquery>
	<cfset oldtext = textcheck.display_text>
	
	<!--- ONLY RESAVE THE DISPLAY TEXT IF IT HAS CHANGED --->
	<!--- This will keep the update_flags for the translations from being set repeatedly for no reason --->
	<cfif Compare(oldtext, attributes.value) neq 0>
		
		<cfquery name="textsave" datasource="#attributes.datasource#">
			update display_language
			set display_text='#attributes.value#'
			where display_id=#attributes.display_id#
				and language_id='#deflang_id#'
		</cfquery>
		
		<!--- If not minor update, set update_flags for translated strings that are clear --->
		<cfif attributes.minor eq false>
			<cfquery name="flagupdate" datasource="#attributes.datasource#">
				select language_id
				from display_language
				where display_id=#attributes.display_id#
					and language_id <> '#deflang_id#'
					and update_flag=0
			</cfquery>
			<cfloop query="flagupdate">
				<cfquery name="updateflag" datasource="#attributes.datasource#">
					update display_language
					set update_flag=1
					where display_id=#attributes.display_id#
						and language_id='#language_id#'
				</cfquery>
			</cfloop>
		</cfif>
		
	</cfif>

</cfif>