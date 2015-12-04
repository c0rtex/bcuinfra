<cfparam name="attributes.sproc" type="string" default="">
<cfparam name="attributes.var" type="string" default="sprocList">

<cfif attributes.sproc eq ''>
	<cfset "caller.#attributes.var#" = 'screening_insert,sequence,sp_NextKey,sp_ZipRad'>
</cfif>
