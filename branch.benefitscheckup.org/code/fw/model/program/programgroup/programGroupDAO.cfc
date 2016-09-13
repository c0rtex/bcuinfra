<cfcomponent output="false" displayname="programGroupDAO" hint="I am a program group data access object.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="programGroup" type="fw.model.program.programGroup.programGroup" required="yes">
		<cftransaction>	
			<cfif arguments.programCategory.getProgramcategory_id() neq 0>
				<cfset update(arguments.programGroup)>
			<cfelse>
				<cfset create(arguments.programGroup)>
			</cfif>
		</cftransaction>
	</cffunction>

	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="programGroup" type="fw.model.program.programGroup.programGroup" required="yes">
		<cfset var data = programGroup.getInstanceMemento()>
		<cfset var newprogramgroup = "">
		<cftransaction>
            <cfquery name="newprogramgroup" datasource="#variables.dsn#">
                INSERT INTO programgroup (
                	display_id, code, description, blurb_display_id, sort
                	)
                VALUES (
                	<cfqueryparam cfsqltype="cf_sql_integer" value="#data.display_id#" null="#yesnoformat(len(data.programcategory_id) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.code#" null="#yesnoformat(len(data.code) eq 0)#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.description#" null="#yesnoformat(len(data.description) eq 0)#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#data.blurb_display_id#" null="#yesnoformat(len(data.blurb_display_id) eq 0)#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#data.sort#" null="#yesnoformat(len(data.sort) eq 0)#">
                )
            </cfquery>
            <cfquery name="qMaxID" datasource="#variables.dsn#">
            	SELECT MAX(programgroup_id) as maxID from programgroup
            </cfquery>
		</cftransaction>
		<cfset programGroup.setProgramgroup_id(qMaxID.maxID)>
	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="programGroup" type="fw.model.program.programGroup.programGroup" required="yes">
		<!--- <cfset var data = user.getInstanceMemento()> --->
		<cfset var updateprogramgroup = "">
		<cfquery name="updateprogramgroup" datasource="#variables.dsn#">
			UPDATE programgroup
			SET 
				display_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#programGroup.getProgramcategory_id()#" null="#yesnoformat(len(programGroup.getProgramcategory_id()) eq 0)#">,
				code = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#programGroup.getProgramgroup_id()#" null="#yesnoformat(len(programGroup.getProgramgroup_id()) eq 0)#">,
				description = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#programGroup.getState_id()#" null="#yesnoformat(len(programGroup.getState_id()) eq 0)#">,
				blurb_display_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#programGroup.getBlurb_display_id()#" null="#yesnoformat(len(programGroup.getBlurb_display_id()) eq 0)#">,
				sort = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#programGroup.getSort()#" null="#yesnoformat(len(programGroup.getSort()) eq 0)#">
                
			WHERE programgroup_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#programGroup.getProgramgroup_id()#">
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="fw.model.program.programCategory.programCategory" output="false">
		<cfargument name="programgroup_id" type="numeric" required="yes">
		<cfset var data = structNew()>
		<cfset var programGroup = "">
		<cfset var readprogramgroup = "">
		<cfquery name="readprogramgroup" datasource="#variables.dsn#">
            SELECT 	programcategory_id, display_id, code, description, legacy_code, sort
            FROM 	programgroup
            WHERE 	programgroup_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.programgroup_id#">
		</cfquery>
		<cfloop list="#readprogramgroup.columnList#" index="field">
			<cfset 'data.#field#' = evaluate('readprogramgroup.#field#')>
		</cfloop>
		<cfset programGroup = createObject("component", "fw.model.program.programGroup.programGroup").init(argumentcollection=data)>
		<cfreturn programGroup>
	</cffunction>

</cfcomponent>