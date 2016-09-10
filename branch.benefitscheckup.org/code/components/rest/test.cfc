<cfcomponent rest="true" restpath="/test">

    <cffunction name="savePrescreen" access="remote" restpath="/test/{id}" returnType="String" httpMethod="POST">
        <cfargument name="id" required="true" restargsource="Path" type="numeric"/>
        <cfargument name="body" type="String">

        <cfset body = deserializeJSON(body)>

        <cfset zip = entityLoadByPK("zip",body.zipCode)>
        <cfset st = zip.getState()>


     <!---  <cfquery name="st" datasource="#application.dbSrc#">
	select state_id
	from zip
	where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#attributes.zipcode#">
</cfquery>
<cfquery name="ep" datasource="#application.dbSrc#">
	select e.entrypoint_id
	from entrypoint_entrypointgroup eg, entrypoint e, view_zip_distance zd
	where eg.entrypointgroup_id=<cfqueryparam cfsqltype="cf_sql_integer" maxlength="6" value="#attributes.entrypointgroup_id#">
		and eg.entrypoint_id=e.entrypoint_id
		and e.active_flag=1
		and e.zipcode=zd.start_zipcode
		and zd.start_state_id='#st.state_id#'
		and zd.end_zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#attributes.zipcode#">
		and zd.distance <= <cfqueryparam cfsqltype="cf_sql_numeric" maxlength="10" value="#attributes.radius#">
	order by zd.distance
</cfquery>

</cfquery>--->

        <cfset ep=ormExecuteQuery("select ep from entry_point_entry_point_group epepg join epepg.entry_point ep join ep.view_zip_distance zd
         where ep.active_flag=1 and epepg.entry_point_group.id=? and zd.start_state_id = ? and zd.end_zipcode=? and zd.distance=?",
         [body.entryPointGroupId, st, body.zipcode, 500])>



        <cfreturn serializeJSON(ep)>

    </cffunction>

    <cffunction name="st1">
        <cfset var slf = slf>
        <cfset slf = "sdfsfdf">
    </cffunction>
</cfcomponent>
