<cfcomponent output="false" displayname="displaylanguageDAO" hint="I am a displaylanguage data access object.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="displaylanguage" type="fw.model.display.displaylanguage.displaylanguage" required="yes">
		<cftransaction>	
			<cfif arguments.displaylanguage.getDisplay_id() neq 0>
				<cfset update(arguments.displaylanguage)>
			<cfelse>
				<cfset create(arguments.displaylanguage)>
			</cfif>
		</cftransaction>
	</cffunction>
	
	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="displaylanguage" type="fw.model.display.displaylanguage.displaylanguage" required="yes">
		<cfset var data = displaylanguage.getInstanceMemento()>
		<cfset var newdisplaylanguage = "">
		<cftransaction>
            <cfquery name="newdisplaylanguage" datasource="#variables.dsn#">
                INSERT INTO display_language (display_id, language_id, display_text, update_flag)
                VALUES (
                	<cfqueryparam cfsqltype="cf_sql_integer" value="#data.display_id#" null="#yesnoformat(len(data.display_id) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.language_id#" null="#yesnoformat(len(data.language_id) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.display_text#" null="#yesnoformat(len(data.display_text) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_bit" value="#data.update_flag#" null="#yesnoformat(len(data.update_flag) eq 0)#">
                )
            </cfquery>
		</cftransaction>
	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="displaylanguage" type="fw.model.display.displaylanguage.displaylanguage" required="yes">
		<cfset var updatedisplalanguagey = "">
		<cfquery name="updatedisplaylanguage" datasource="#variables.dsn#">
			UPDATE display_language
			SET 
				display_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#displaylanguage.getDisplay_id()#">,
				language_id = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#displaylanguage.getLanguage_id()#">,
				display_text = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#displaylanguage.getDisplay_text()#">,
				update_flag = 
					<cfqueryparam cfsqltype="cf_sql_bit" value="#display.getUpdate_flag()#">
			WHERE display_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#displaylanguage.getDisplay_id()#">
            AND language_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#displaylanguafe.getLanguage_id()#">
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="fw.model.display.displaylanguage.displaylanguage" output="false">
		<cfargument name="display_id" type="numeric" required="yes">
        <cfargument name="language_id" type="string" required="yes">
		<cfset var data = structNew()>
		<cfset var displaylanguage = "">
		<cfset var readdisplaylanguage = "">
		<cfquery name="readdisplaylanguage" datasource="#variables.dsn#">
            SELECT 	*
            FROM 	display_language
            WHERE 	display_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.display_id#">
            AND language_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.language_id#">
            
		</cfquery>
		<cfloop list="#readdisplaylanguage.columnList#" index="field">
			<cfset 'data.#field#' = evaluate('readdisplaylanguage.#field#')>
		</cfloop>
		<cfset displaylanguage = createObject("component", "fw.model.display.displaylanguage.displaylanguage").init(argumentcollection=data)>
		<cfreturn displaylanguage>
	</cffunction>

</cfcomponent>