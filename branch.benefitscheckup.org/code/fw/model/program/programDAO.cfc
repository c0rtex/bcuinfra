<cfcomponent output="false" displayname="programDAO" hint="I am a program data access object.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="program" type="fw.model.program.program" required="yes">
		<cftransaction>	
			<cfif arguments.program.getprogram_id() neq 0>
				<cfset update(arguments.program)>
			<cfelse>
				<cfset create(arguments.program)>
			</cfif>
		</cftransaction>
	</cffunction>

	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="program" type="fw.model.program.program" required="yes">
		<cfset var data = program.getInstanceMemento()>
		<cfset var newprogram = "">
		<cftransaction>
            <cfquery name="newprogram" datasource="#variables.dsn#">
                INSERT INTO users (
                	programcategory_id, state_id, program_code, name_display_id, desc_display_id, url,
                	exclude_flag, significant_flag, active_flag, funder_id, reference_id, last_update, notes, supersort, sort,
                    legacy_prg_id, legacy_pri_sec, create_user_id, create_date, modify_user_id, modify_date
                	)
                VALUES (
                	<cfqueryparam cfsqltype="cf_sql_integer" value="#data.programcategory_id#" null="#yesnoformat(len(data.programcategory_id) eq 0)#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#program.getState_id()#" null="#yesnoformat(len(program.getState_id()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#program.getProgram_code()#" null="#yesnoformat(len(program.getProgram_code()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getName_display_id()#" null="#yesnoformat(len(program.getName_display_id()) eq 0)#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getDesc_display_id()#" null="#yesnoformat(len(program.getDesc_display_id()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#program.getUrl()#" null="#yesnoformat(len(program.getUrl()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_bit" value="#program.getExclude_flag()#" null="#yesnoformat(len(program.getExclude_flag()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_bit" value="#program.getSignificant_flag()#" null="#yesnoformat(len(program.getSignificant_flag()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_bit" value="#program.getActive_flag()#" null="#yesnoformat(len(program.getActive_flag()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getFunder_id()#" null="#yesnoformat(len(program.getFunder_id()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getReference_id()#" null="#yesnoformat(len(program.getReference_id()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_date" value="#program.getLast_update()#" null="#yesnoformat(len(program.getLastUpdate()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#program.getNotes()#" null="#yesnoformat(len(program.getNotes()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getSupersort()#" null="#yesnoformat(len(program.getSupersort()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getSort()#" null="#yesnoformat(len(program.getSort()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#program.getLegacy_prg_id()#" null="#yesnoformat(len(program.getLegacy_prg_id()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getLegacy_pri_sec()#" null="#yesnoformat(len(program.getLegacy_pri_sec()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getCreate_user_id()#" null="#yesnoformat(len(program.getCreate_user_id()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_date" value="#program.getCreate_date()#" null="#yesnoformat(len(program.getCreate_date()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getModify_user_id()#" null="#yesnoformat(len(program.getModify_user_id()) eq 0)#" maxlength="50">,
					<cfqueryparam cfsqltype="cf_sql_date" value="#program.getModify_date()#" null="#yesnoformat(len(program.getModify_date()) eq 0)#" maxlength="50">
                )
            </cfquery>
            <cfquery name="qMaxID" datasource="#variables.dsn#">
            	SELECT MAX(program_id) as maxID from program
            </cfquery>
		</cftransaction>
		<cfset program.setId(qMaxID.maxID)>
	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="program" type="fw.model.program.program" required="yes">
		<!--- <cfset var data = user.getInstanceMemento()> --->
		<cfset var updateprogram = "">
		<cfquery name="updateprogram" datasource="#variables.dsn#">
			UPDATE program
			SET 
				programcategory_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getProgramcategory_id()#" null="#yesnoformat(len(program.getProgramcategory_id()) eq 0)#" maxlength="50">,
				state_id = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#program.getState_id()#" null="#yesnoformat(len(program.getState_id()) eq 0)#" maxlength="50">,
				program_code = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#program.getProgram_code()#" null="#yesnoformat(len(program.getProgram_code()) eq 0)#" maxlength="50">,
				name_display_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getName_display_id()#" null="#yesnoformat(len(program.getName_display_id()) eq 0)#">,
                desc_display_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getDesc_display_id()#" null="#yesnoformat(len(program.getDesc_display_id()) eq 0)#" maxlength="50">,
                url = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#program.getUrl()#" null="#yesnoformat(len(program.getUrl()) eq 0)#" maxlength="50">,
                exclude_flag = 
					<cfqueryparam cfsqltype="cf_sql_bit" value="#program.getExclude_flag()#" null="#yesnoformat(len(program.getExclude_flag()) eq 0)#" maxlength="50">,
                significant_flag = 
					<cfqueryparam cfsqltype="cf_sql_bit" value="#program.getSignificant_flag()#" null="#yesnoformat(len(program.getSignificant_flag()) eq 0)#" maxlength="50">,
                active_flag = 
					<cfqueryparam cfsqltype="cf_sql_bit" value="#program.getActive_flag()#" null="#yesnoformat(len(program.getActive_flag()) eq 0)#" maxlength="50">,
                funder_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getFunder_id()#" null="#yesnoformat(len(program.getFunder_id()) eq 0)#" maxlength="50">,
                reference_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getReference_id()#" null="#yesnoformat(len(program.getReference_id()) eq 0)#" maxlength="50">,
                last_update = 
					<cfqueryparam cfsqltype="cf_sql_date" value="#program.getLast_update()#" null="#yesnoformat(len(program.getLastUpdate()) eq 0)#" maxlength="50">,
                notes = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#program.getNotes()#" null="#yesnoformat(len(program.getNotes()) eq 0)#" maxlength="50">,
                supersort = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getSupersort()#" null="#yesnoformat(len(program.getSupersort()) eq 0)#" maxlength="50">,
                sort = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getSort()#" null="#yesnoformat(len(program.getSort()) eq 0)#" maxlength="50">,
                legacy_prg_id = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#program.getLegacy_prg_id()#" null="#yesnoformat(len(program.getLegacy_prg_id()) eq 0)#" maxlength="50">,
                legacy_pri_sec = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getLegacy_pri_sec()#" null="#yesnoformat(len(program.getLegacy_pri_sec()) eq 0)#" maxlength="50">,
                create_user_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getCreate_user_id()#" null="#yesnoformat(len(program.getCreate_user_id()) eq 0)#" maxlength="50">,
                create_date = 
					<cfqueryparam cfsqltype="cf_sql_date" value="#program.getCreate_date()#" null="#yesnoformat(len(program.getCreate_date()) eq 0)#" maxlength="50">,
                modify_user_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#program.getModify_user_id()#" null="#yesnoformat(len(program.getModify_user_id()) eq 0)#" maxlength="50">,
                modify_date = 
					<cfqueryparam cfsqltype="cf_sql_date" value="#program.getModify_date()#" null="#yesnoformat(len(program.getModify_date()) eq 0)#" maxlength="50">
                
			WHERE program_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#program.getProgram_id()#">
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="fw.model.program.program" output="false">
		<cfargument name="program_id" type="numeric" required="yes">
		<cfset var data = structNew()>
		<cfset var program = "">
		<cfset var readprogram = "">
		<cfquery name="readprogram" datasource="#variables.dsn#">
            SELECT 	program_id, programcategory_id, state_id, program_code, name_display_id, desc_display_id,
            	url, exclude_flag, significant_flag, active_flag, funder_id, reference_id, last_update, notes, supersort, sort,
                sort, legacy_prg_id, legacy_pri_sec, create_user_id, create_date, modify_user_id, modify_date
            FROM 	program
            WHERE 	program_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.program_id#">
		</cfquery>
		<cfloop list="#readprogram.columnList#" index="field">
        	<cfset newVal = evaluate('readprogram.#field#')>
        	<cfif newVal IS "NULL" OR newVal IS "">
            <cfelse>
				<cfset 'data.#field#' = newVal>
            </cfif>
		</cfloop>
		<cfset program = createObject("component", "fw.model.program.program").init(argumentcollection=data)>
		<cfreturn program>
	</cffunction>

</cfcomponent>