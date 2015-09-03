<cfcomponent output="false" displayname="displayDAO" hint="I am a display data access object.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="display" type="fw.model.display.display" required="yes">
		<cftransaction>	
			<cfif arguments.display.getDisplay_id() neq 0>
				<cfset update(arguments.display)>
			<cfelse>
				<cfset create(arguments.display)>
			</cfif>
		</cftransaction>
	</cffunction>
	
	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="display" type="fw.model.display.display" required="yes">
		<cfset var data = display.getInstanceMemento()>
		<cfset var newdisplay = "">
		<cftransaction>
            <cfquery name="newdisplay" datasource="#variables.dsn#">
                INSERT INTO display (displaygroup_id, display_code,display_name, display_desc, active_flag)
                VALUES (
                	<cfqueryparam cfsqltype="cf_sql_integer" value="#data.displaygroup_id#" null="#yesnoformat(len(data.displaygroup_id) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.display_code#" null="#yesnoformat(len(data.display_code) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.display_name#" null="#yesnoformat(len(data.display_name) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.display_desc#" null="#yesnoformat(len(data.display_desc) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_bit" value="#data.active_flag#" null="#yesnoformat(len(data.active_flag) eq 0)#">
                )
            </cfquery>
            <cfquery name="qMaxID" datasource="#variables.dsn#">
            	SELECT MAX(display_id) as maxID from display
            </cfquery>
		</cftransaction>
		<cfset display.setDisplay_id(qMaxID.maxID)>
	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="display" type="fw.model.display.display" required="yes">
		<!--- <cfset var data = user.getInstanceMemento()> --->
		<cfset var updatedisplay = "">
		<cfquery name="updatedisplay" datasource="#variables.dsn#">
			UPDATE display
			SET 
				displaygroup_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#display.getDisplaygroup_id()#">,
				display_code = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#display.getDisplay_code()#">,
				display_name = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#display.getDisplay_name()#">,
                display_desc = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#display.getDisplay_desc()#">,
				active_flag = 
					<cfqueryparam cfsqltype="cf_sql_bit" value="#display.getActive_flag()#">
			WHERE display_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#display.getDisplay_id()#">
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="fw.model.display.display" output="false">
		<cfargument name="display_id" type="numeric" required="yes">
		<cfset var data = structNew()>
		<cfset var display = "">
		<cfset var readdisplay = "">
		<cfquery name="readdisplay" datasource="#variables.dsn#">
            SELECT 	*
            FROM 	display
            WHERE 	display_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.display_id#">
		</cfquery>
		<cfloop list="#readdisplay.columnList#" index="field">
			<cfset 'data.#field#' = evaluate('readdisplay.#field#')>
		</cfloop>
		<cfset display = createObject("component", "fw.model.display.display").init(argumentcollection=data)>
		<cfreturn display>
	</cffunction>

</cfcomponent>