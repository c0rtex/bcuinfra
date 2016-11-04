<cfcomponent rest="true" restpath="/snap">
    <cffunction name="getSnapCountByStateYear" access="remote" restpath="/count/{state_id}/{year}" returnType="String" httpMethod="GET">
        <cfargument name="state_id" required="true" restargsource="Path" type="string"/>
	<cfargument name="year" required="true" restargsource="Path" type="numeric"/>

	<cfquery name="snapQuery" datasource="dbSrc">
	select s.state_name, ssn.state_id, ssn.snap_seniors from state_snap ssn, state s
	where ssn.year = '#year#' and ssn.state_id = s.state_id and s.state_id = '#state_id#'
	</cfquery>


        <cfreturn serializeJSON(snapQuery)>
    </cffunction>

     <cffunction name="getSnapCountByYear" access="remote" restpath="/countallstates/{year}" returnType="String" httpMethod="GET">

	<cfargument name="year" required="true" restargsource="Path" type="numeric"/>

	<cfquery name="snapQuery" datasource="dbSrc">
	select s.state_name, ssn.state_id, ssn.snap_seniors from state_snap ssn, state s
	where ssn.year = '#year#' and ssn.state_id = s.state_id
	</cfquery>


        <cfreturn serializeJSON(snapQuery)>
    </cffunction>
</cfcomponent>
