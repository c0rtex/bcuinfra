<cfcomponent output="false" displayname="programcategoryDAO" hint="I am a program category data access object.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="programCategory" type="fw.model.program.programCategory.programCategory" required="yes">
		<cftransaction>	
			<cfif arguments.programCategory.getProgramcategory_id() neq 0>
				<cfset update(arguments.programCategory)>
			<cfelse>
				<cfset create(arguments.programCategory)>
			</cfif>
		</cftransaction>
	</cffunction>

	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="programCategory" type="fw.model.program.programCategory.programCategory" required="yes">
		<cfset var data = programCategory.getInstanceMemento()>
		<cfset var newprogramcategory = "">
		<cftransaction>
            <cfquery name="newprogramcategory" datasource="#variables.dsn#">
                INSERT INTO programcategory (
                	display_id, code, description, legacy_code, sort
                	)
                VALUES (
                	<cfqueryparam cfsqltype="cf_sql_integer" value="#data.display_id#" null="#yesnoformat(len(data.programcategory_id) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.code#" null="#yesnoformat(len(data.code) eq 0)#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.description#" null="#yesnoformat(len(data.description) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.legacy_code#" null="#yesnoformat(len(data.legacy_code) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#data.sort#" null="#yesnoformat(len(data.sort) eq 0)#">
                )
            </cfquery>
            <cfquery name="qMaxID" datasource="#variables.dsn#">
            	SELECT max(programcategory_id) as maxID from programcategory
            </cfquery>
		</cftransaction>
		<cfset programCategory.setProgramcategory_id(qMaxID.maxID)>
	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="programCategory" type="fw.model.program.programCategory.programCategory" required="yes">
		<!--- <cfset var data = user.getInstanceMemento()> --->
		<cfset var updateprogramcategory = "">
		<cfquery name="updateprogramcategory" datasource="#variables.dsn#">
			UPDATE programcategory
			SET 
				display_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#programCategory.getDisplay_id()#" null="#yesnoformat(len(programCategory.getDisplay_id()) eq 0)#">,
				code = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#programCategory.getCode()#" null="#yesnoformat(len(programCategory.getCode()) eq 0)#">,
				description = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#programCategory.getDescription()#" null="#yesnoformat(len(programCategory.getDescription()) eq 0)#">,
				legacy_code = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#programCategory.getlegacy_code()#" null="#yesnoformat(len(programCategory.getlegacy_code()) eq 0)#">,
				sort = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#programCategory.getSort()#" null="#yesnoformat(len(programCategory.getSort()) eq 0)#">
                
			WHERE programcategory_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#programCategory.getProgramcategory_id()#">
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="fw.model.program.programCategory.programCategory" output="false">
		<cfargument name="programcategory_id" type="numeric" required="yes">
		<cfset var data = structNew()>
		<cfset var programCategory = "">
		<cfset var readprogramcategory = "">
		<cfquery name="readprogramcategory" datasource="#variables.dsn#">
            SELECT 	programcategory_id, display_id, code, description, legacy_code, sort
            FROM 	programcategory
            WHERE 	programcategory_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.programcategory_id#">
		</cfquery>
		<cfloop list="#readprogramcategory.columnList#" index="field">
			<cfset 'data.#field#' = evaluate('readprogramcategory.#field#')>
		</cfloop>
		<cfset programCategory = createObject("component", "fw.model.program.programCategory.programCategory").init(argumentcollection=data)>
		<cfreturn programCategory>
	</cffunction>

</cfcomponent>