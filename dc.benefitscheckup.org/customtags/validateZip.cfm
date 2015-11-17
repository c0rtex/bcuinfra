<cfparam name="attributes.zipcode" type="string">
<cfparam name="attributes.state_id" type="string" default="">
<cfparam name="attributes.var" type="string" default="validationResult">
<cfparam name="attributes.subset_id" type="integer" default="0">

<cfquery name="validzip" datasource="#application.dbSrc#">
	select zipcode, state_id, valid
	from zip
	where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#attributes.zipcode#">
		and valid=1
	<cfif attributes.state_id neq ''>
		and state_id=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="2" value="#attributes.state_id#">									    
    </cfif>
    <cfif isdefined('attributes.subset_id') and attributes.subset_id eq 59>
    	and state_id=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="2" value="VI">	
    </cfif>
</cfquery>
<cfif validzip.RecordCount eq 1 and validzip.valid eq 1>
	<cfset result = true>
<cfelse>
	<cfset result = false>
</cfif>
<cfset "caller.#attributes.var#" = result>