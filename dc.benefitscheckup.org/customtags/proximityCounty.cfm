<cfsilent>
<cfparam name="attributes.mode" type="string" default="screen">
<cfparam name="attributes.entrypointgroup_id" type="numeric">
<cfparam name="attributes.program_id" type="numeric" default="0">
<cfparam name="attributes.zipcode" type="string">
<cfparam name="attributes.limit" type="numeric" default="3">
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.append" type="boolean" default="false">
<cfparam name="attributes.successvar" type="string" default="">
<cfparam name="attributes.suppressOfficesLink" type="string" default="false">
<cfparam name="attributes.google" type="boolean" default="false">

<cfset outstr = ''>
<cfset isPrintMode = Evaluate("attributes.mode eq 'print'")>

<cfquery name="st" datasource="#application.dbSrc#">
	select state_id
	from zip
	where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#attributes.zipcode#">
</cfquery>

<cfquery name="ep" datasource="#application.dbSrc#">
	select e.entrypoint_id, zd.distance
	from entrypoint_entrypointgroup eg, entrypoint_county ec, entrypoint e, view_zip_distance zd
	where eg.entrypointgroup_id=<cfqueryparam cfsqltype="cf_sql_integer" maxlength="6" value="#attributes.entrypointgroup_id#">
		and eg.entrypoint_id=ec.entrypoint_id
		and ec.county_id in (select county_id from zip where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#attributes.zipcode#">)
		and ec.entrypoint_id=e.entrypoint_id
		and e.active_flag=1
		and e.zipcode=zd.start_zipcode
		and zd.end_zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#attributes.zipcode#">
	UNION
	select e.entrypoint_id, 999999 distance
	from entrypoint_entrypointgroup eg, entrypoint e, entrypoint_county ec
	where eg.entrypointgroup_id=<cfqueryparam cfsqltype="cf_sql_integer" maxlength="6" value="#attributes.entrypointgroup_id#">
		and eg.entrypoint_id=e.entrypoint_id
		and e.active_flag=1
		and e.zipcode is null
		and e.state_id in (select state_id from zip where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#attributes.zipcode#">)
		and e.entrypoint_id=ec.entrypoint_id
		and ec.county_id in (select county_id from zip where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#attributes.zipcode#">)
	order by distance
</cfquery>

<cfif ep.RecordCount eq 0>
	<cfset success = false>
<cfelse>
	<cfset success = true>
	<cfif attributes.suppressOfficesLink IS FALSE>
		<cfif ep.RecordCount eq 1>
			<cf_displayText group="site" code="site_ep_county_singular" var="msg">
			<cfset outstr = outstr & "#msg#<br>">
		<cfelse>
			<cf_displayText group="site" code="site_ep_county_plural" var="msg">
			<cfset outstr = outstr & "#msg#<br>">
			<cf_displayEntrypointsLink entrypointgroup_id="#attributes.entrypointgroup_id#" program_id="#attributes.program_id#" state_id="#st.state_id#" mode="#attributes.mode#" var="outstr" append="true">
		</cfif>
	</cfif>
	<cfloop query="ep" startrow="1" endrow="#attributes.limit#">
		<cf_displayEntrypoint entrypoint_id="#entrypoint_id#" mode="#attributes.mode#" var="outstr" append="true" google="#attributes.google#">
	</cfloop>
</cfif>

<cfif attributes.successvar neq ''>
	<cfset "caller.#attributes.successvar#" = success>
</cfif>

</cfsilent><cfif attributes.var eq ''><cfsilent>
	</cfsilent><cfoutput>#outstr#</cfoutput><cfsilent>
</cfsilent><cfelseif attributes.append><cfsilent>
	<cfset "caller.#attributes.var#" = Evaluate("caller.#attributes.var#") & outstr>
</cfsilent><cfelse><cfsilent>
	<cfset "caller.#attributes.var#" = outstr>
</cfsilent></cfif>