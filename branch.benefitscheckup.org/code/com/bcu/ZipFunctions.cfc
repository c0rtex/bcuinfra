<cfcomponent displayname="ZipFunctions" hint="This component does all Zip validations from the DB" >
	<cffunction name="getStateFromZip" access="remote" returntype="any" returnformat="json">
		<cfargument name="zipCode" type="numeric" required="yes">
        <cfset var findZip = "">
        <cfsetting showdebugoutput="no">
        <cfset vZip = validateZip(arguments.zipCode)>
        <cfset session.mZip = arguments.zipcode>
        <cfif vZip>
            <cfquery name="findZip" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
                SELECT z.state_id , s.state_name
                FROM zip z
                LEFT JOIN state s ON s.state_id = z.state_id
                WHERE zipcode = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#left(zipCode, 5)#">
            </cfquery>
        <cfelse>
        	<cfset findZip = false>
        </cfif>
        <cfreturn findZip />
	</cffunction>
    
    <cffunction name="validateZip" access="public" returntype="boolean">
    	<cfargument name="zipcode" required="yes" type="string">
        <cfargument name="state_id" required="no" type="string" default="">
		<cfset validzip = "">
    	<cfquery name="validzip" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
            SELECT zipcode, state_id, valid
            FROM zip
            WHERE zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#arguments.zipcode#">
            AND valid=1
            <cfif arguments.state_id neq ''>
                AND state_id=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="2" value="#arguments.state_id#">									    
            </cfif>
		</cfquery>
        <cfif validzip.recordCount is 1 AND validzip.valid>
        	<cfreturn true />
        <cfelse>
        	<cfreturn false />
        </cfif>
    </cffunction>
    <cffunction name="isZipInState" access="remote" returnformat="json">
    	<cfargument name="zipcode" required="yes" type="string">
        <cfargument name="state_id" required="yes" type="string">
        <cfset var rtn = false>
        <cfset var validZip = validateZip(arguments.zipcode, arguments.state_id)>
        <cfsetting showdebugoutput="no">
        <cfif validZip>
        	<cfset rtn = true>
        </cfif>
        <cfreturn rtn />
    </cffunction>
</cfcomponent>