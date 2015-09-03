<cfcomponent output="false" displayname="displaygroupDAO" hint="I am a displaygroup data access object.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="displaygroup" type="fw.model.display.displaygroup.displaygroup" required="yes">
		<cftransaction>	
			<cfif arguments.displaygroup.getDisplaygroup_id() neq 0>
				<cfset update(arguments.display)>
			<cfelse>
				<cfset create(arguments.displaygroup)>
			</cfif>
		</cftransaction>
	</cffunction>
	
	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="displaygroup" type="fw.model.display.displaygroup.displaygroup" required="yes">
		<cfset var data = displaygroup.getInstanceMemento()>
		<cfset var newdisplaygroup = "">
		<cftransaction>
            <cfquery name="newdisplaygroupgroup" datasource="#variables.dsn#">
                INSERT INTO displaygroup (displaygroup_code,displaygroup_name, displaygroup_desc)
                VALUES (
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.displaygroup_code#" null="#yesnoformat(len(data.displaygroup_code) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.displaygroup_name#" null="#yesnoformat(len(data.displaygroup_name) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.displaygroup_desc#" null="#yesnoformat(len(data.displaygroup_desc) eq 0)#">
                )
            </cfquery>
            <cfquery name="qMaxID" datasource="#variables.dsn#">
            	SELECT MAX(displaygroup_id) as maxID from displaygroup
            </cfquery>
		</cftransaction>
		<cfset displaygroup.setDisplaygroup_id(qMaxID.maxID)>
	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="display" type="fw.model.display.displaygroup.displaygroup" required="yes">
		<!--- <cfset var data = user.getInstanceMemento()> --->
		<cfset var updatedisplaygroup = "">
		<cfquery name="updatedisplaygroup" datasource="#variables.dsn#">
			UPDATE displaygroup
			SET 
				displaygroup_code = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#displaygroup.getDisplaygroup_code()#">,
				displaygroup_name = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#displaygroup.getDisplaygroup_name()#">,
                displaygroup_desc = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#displaygroup.getDisplaygroup_desc()#">
			WHERE displaygroup_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#displaygroup.getDisplaygroup_id()#">
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="fw.model.display.displaygroup.displaygroup" output="false">
		<cfargument name="displaygroup_id" type="numeric" required="yes">
		<cfset var data = structNew()>
		<cfset var displaygroup = "">
		<cfset var readdisplaygroup = "">
		<cfquery name="readdisplaygroup" datasource="#variables.dsn#">
            SELECT 	*
            FROM 	displaygroup
            WHERE 	displaygroup_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.displaygroup_id#">
		</cfquery>
		<cfloop list="#readdisplaygroup.columnList#" index="field">
			<cfset 'data.#field#' = evaluate('readdisplaygroup.#field#')>
		</cfloop>
		<cfset displaygroup = createObject("component", "fw.model.display.displaygroup.displaygroup").init(argumentcollection=data)>
		<cfreturn display>
	</cffunction>

</cfcomponent>