<cfsilent>
<cfparam name="attributes.prev_screening_id" type="any" default="">
<cfparam name="attributes.source_id" type="any" default="">
<cfparam name="attributes.org_id" type="any" default="">
<cfparam name="attributes.partner_id" type="any" default="">
<cfparam name="attributes.subset_id" type="any" default="">
<cfparam name="attributes.language_id" type="string" default="EN">
<cfparam name="attributes.access_id" type="any" default="">
<cfparam name="attributes.client_id" type="string" default="">
<cfparam name="attributes.user_id" type="string" default="">
<cfparam name="attributes.preset_state_id" type="string" default="">
<cfparam name="attributes.test_flag" type="any" default="">
<cfparam name="attributes.log_end" type="boolean" default="false">
<cfparam name="attributes.var" type="string" default="screening_id">

<cfif attributes.language_id eq 'NULL'>
	<cfset attributes.language_id = ''>
</cfif>
<cfif attributes.client_id eq 'NULL'>
	<cfset attributes.client_id = ''>
</cfif>
<cfif attributes.user_id eq 'NULL'>
	<cfset attributes.user_id = ''>
</cfif>
<cfif attributes.preset_state_id eq 'NULL'>
	<cfset attributes.preset_state_id = ''>
</cfif>

<cfset start_datetime = CreateODBCDateTime(Now())>
<cfif attributes.log_end>
	<cfset end_datetime = CreateODBCDateTime(Now())>
<cfelse>
	<cfset end_datetime = ''>
</cfif>

<!--- Check if attributes.prev_screening_id is a list instead of a singular value --->
<cfif attributes.prev_screening_id NEQ 0 AND ListLen(attributes.prev_screening_id) GT 1>
	<cfset attributes.prev_screening_id = ListLast(attributes.prev_screening_id)>
	<cfset SESSION.prev_id = ListLast(attributes.prev_screening_id)>
</cfif>

<cfstoredproc procedure="screening_insert" datasource="#application.dbSrc#">
	<cfprocparam type="in" value="#attributes.prev_screening_id#" cfsqltype="cf_sql_integer" null="#Evaluate("attributes.prev_screening_id eq ''")#">
	<cfprocparam value="#session.cfid#" cfsqltype="cf_sql_bigint">
	<cfprocparam value="#session.cftoken#" cfsqltype="cf_sql_bigint">
	<cfprocparam value="#attributes.source_id#" cfsqltype="cf_sql_integer" null="#Evaluate("attributes.source_id eq ''")#">
	<cfprocparam value="#attributes.org_id#" cfsqltype="cf_sql_integer" null="#Evaluate("attributes.org_id eq ''")#">
	<cfprocparam value="#attributes.partner_id#" cfsqltype="cf_sql_integer" null="#Evaluate("attributes.partner_id eq ''")#">
	<cfprocparam value="#attributes.subset_id#" cfsqltype="cf_sql_integer" null="#Evaluate("attributes.subset_id eq ''")#">
	<cfprocparam value="#attributes.language_id#" cfsqltype="cf_sql_char">
	<cfprocparam value="#attributes.access_id#" cfsqltype="cf_sql_integer" null="#Evaluate("attributes.access_id eq ''")#">
	<cfprocparam value="#attributes.client_id#" cfsqltype="cf_sql_varchar" null="#Evaluate("attributes.client_id eq ''")#">
	<cfprocparam value="#attributes.user_id#" cfsqltype="cf_sql_varchar" null="#Evaluate("attributes.user_id eq ''")#">
	<cfprocparam value="#attributes.preset_state_id#" cfsqltype="cf_sql_char" null="#Evaluate("attributes.preset_state_id eq ''")#">
	<cfprocparam value="#attributes.test_flag#" cfsqltype="cf_sql_tinyint" null="#Evaluate("attributes.test_flag eq ''")#">
	<cfprocparam value="#start_datetime#" cfsqltype="cf_sql_timestamp">
	<cfprocparam value="#end_datetime#" cfsqltype="cf_sql_timestamp" null="#Evaluate("end_datetime eq ''")#">
	<cfprocparam type="out" variable="screening_id" cfsqltype="cf_sql_integer">
</cfstoredproc>

<cfset "caller.#attributes.var#" = screening_id>
</cfsilent>