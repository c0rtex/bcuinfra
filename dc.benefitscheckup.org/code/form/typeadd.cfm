<cfparam name="form_id" type="numeric">
<cfparam name="type_id" type="numeric">
<cfparam name="string" type="string" default="">
<cfparam name="active" type="numeric" default="0">
<cfparam name="fd_month" type="numeric" default="0">
<cfparam name="fd_day" type="numeric" default="0">
<cfparam name="fd_year" type="numeric" default="0">
<cfparam name="ed_month" type="numeric" default="0">
<cfparam name="ed_day" type="numeric" default="0">
<cfparam name="ed_year" type="numeric" default="0">

<cfset string = trim(string)>

<cfif string eq ''>
	<cflocation url="typeassociate.cfm?form_id=#form_id#&type_id=#type_id#">
<cfelse>
	<cfif fd_month gt 0 and fd_year gt 0>
		<cfif fd_day gt 0>
			<cfset null_form_date="'#fd_year#-#fd_month#-#fd_day#'">
			<cfset form_day_ignore_flag=0>
		<cfelse>
			<cfset null_form_date="'#fd_year#-#fd_month#-01'">
			<cfset form_day_ignore_flag=1>
		</cfif>
	<cfelse>
		<cfset null_form_date='NULL'>
		<cfset form_day_ignore_flag=0>
	</cfif>
	<cfif ed_month gt 0 and ed_day gt 0 and ed_year gt 0>
		<cfset null_entry_date="'#ed_year#-#ed_month#-#ed_day#'">
	<cfelse>
		<cfset null_entry_date='NULL'>
	</cfif>
	<cfquery name="typeadd" datasource="#application.dbSrc#">
		INSERT INTO form_formtype
			(form_id, formtype_id, string, active, form_date, form_day_ignore_flag, entry_date)
		VALUES
			(#form_id#, #type_id#, '#string#', #active#, #PreserveSingleQuotes(null_form_date)#, #form_day_ignore_flag#, #PreserveSingleQuotes(null_entry_date)#)
	</cfquery>
	<cflocation url="formview.cfm?id=#form_id#">
</cfif>