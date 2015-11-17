<cf_checkAccess level="5">
<cf_buildPage title="Entry Point Error Check" section="entrypoint">

<h2>Entry Point Error Check</h2>

<cfquery name="eperrchk" datasource="#application.dbSrc#">
	select e.entrypoint_id, e.name, e.subname, e.state_id, e.zipcode zip,
		z.zipcode, z.valid zip_valid, z.state_id as zip_state_id
	from entrypoint e left outer join zip z
		on e.zipcode=z.zipcode
	order by e.entrypoint_id
</cfquery>

<cfoutput>

<cfset count = 0>
<cfset err = 0>
<cfloop query="eperrchk">
	<cfset count = count + 1>
	<cfset errmsg = ''>
	<cfif zip_valid eq 0>
		<cfset errmsg = errmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> zipcode '#zip#' has become invalid</font><br>">
		<cfset err = err + 1>
	<cfelseif zip neq '' and zipcode eq ''>
		<cfset errmsg = errmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> zipcode '#zip#' does not exist</font><br>">
		<cfset err = err + 1>
	<cfelseif zip_state_id neq '' and state_id neq '' and zip_state_id neq state_id>
		<cfset errmsg = errmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> zipcode '#zip#' belongs in state '#zip_state_id#', not '#state_id#'</font><br>">
		<cfset err = err + 1>
	</cfif>
	<cfif errmsg neq ''>
		<strong>#entrypoint_id#: <cf_checkAccessLink level="5" href="entrypointview.cfm?id=#entrypoint_id#">#name#<cfif subname neq ''>&##151;#subname#</cfif></cf_checkAccessLink></strong><br>
		&nbsp; &nbsp; state: #state_id#<br>
		&nbsp; &nbsp; zip: #zip#<br>
		#errmsg#
		<br>
	</cfif>
</cfloop>
<strong>entrypoints checked:</strong> #count#<br>
<strong>zipcode errors found:</strong> #err#</em><br>

</cfoutput>

</cf_buildPage>