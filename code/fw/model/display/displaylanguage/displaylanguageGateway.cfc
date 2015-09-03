<cfcomponent output="false" displayname="displaylanguageGateway" hint="I am a displaylanguage gateway.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" required="yes" type="string">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="getDisplaylanguages" access="public" returntype="query" output="false">
		<cfargument name="display_id" required="no" type="numeric" default="0">
		<cfargument name="language_id" required="no" type="string" default="">
		<cfargument name="display_text" required="no" type="string" default="">
        <cfargument name="update_flag" required="no" type="boolean" default="">
 		<cfset var qDisplaylanguages = "">
		<cfquery name="qDisplaylanguages" datasource="#variables.dsn#">
            SELECT 	*
            FROM 	display_language
            WHERE 	(1=1)
                <cfif arguments.display_id neq 0>
                    AND display_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.display_id#">
                </cfif>
                <cfif arguments.language_id neq "">
                    AND language_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.language_id#">
                </cfif>
                <cfif arguments.display_text neq "">
                    AND display_text = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.display_text#">
                </cfif>
                <cfif arguments.update_flag neq "">
                    AND update_flag = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.update_flag#">
                </cfif>
			ORDER BY display_id
		</cfquery>
		<cfreturn qDisplaylanguages>
	</cffunction>
    <cffunction name="getDistinctLanguages" access="public" returntype="array" output="no">
    	<cfargument name="display_id" required="yes" type="numeric" default="0">
        <cfset qDistinctLang = "">
        <cfset aDistinctLang = arrayNew(1)>
        <cfquery name="qDistinctLang" datasource="#variables.dsn#">
        	SELECT DISTINCT language_id
            FROM display_language
            WHERE display_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.display_id#">
        </cfquery>
        <cfif qDistinctLang.recordCount GT 0>
        	<cfloop query="qDistinctLang">
        		<cfset arrayAppend(aDistinctLang, qDistinctLang.language_id)>
            </cfloop>
        </cfif>
        <cfreturn aDistinctLang />
    </cffunction>

</cfcomponent>