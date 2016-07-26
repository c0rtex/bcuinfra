<cfparam name="attributes.entrypoint_id" type="numeric">
<cfparam name="attributes.var" type="string" default="errMsg">

<cfquery name="eperrchk" datasource="#application.dbSrc#">
	select e.entrypoint_id, e.name, e.subname, e.state_id, e.zipcode zip,
		z.zipcode, z.valid zip_valid, z.state_id as zip_state_id
	from entrypoint e left outer join zip z
		on e.zipcode=z.zipcode
	where e.entrypoint_id=#attributes.entrypoint_id#
	order by e.entrypoint_id
</cfquery>

<cfif eperrchk.RecordCount eq 1>
	<cfset errmsg = ''>
	<cfif eperrchk.zip_valid eq 0>
		<cfset errmsg = errmsg & "<li><strong>error:</strong> zipcode '#eperrchk.zip#' has become invalid</li>">
	<cfelseif eperrchk.zip neq '' and eperrchk.zipcode eq ''>
		<cfset errmsg = errmsg & "<li><strong>error:</strong> zipcode '#eperrchk.zip#' does not exist</li>">
	<cfelseif eperrchk.zip_state_id neq '' and eperrchk.state_id neq '' and eperrchk.zip_state_id neq eperrchk.state_id>
		<cfset errmsg = errmsg & "<li><strong>error:</strong> zipcode '#eperrchk.zip#' belongs in state '#eperrchk.zip_state_id#', not '#eperrchk.state_id#'</li>">
	</cfif>
	<cfset "caller.#attributes.var#" = errmsg>
<cfelse>
	<cfset "caller.#attributes.var#" = ''>
</cfif>