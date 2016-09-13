<cfcomponent output="false" displayname="subsetDAO" hint="I am a subset data access object.">


	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="subset" type="fw.model.subset.subset" required="yes">
		<cftransaction>	
			<cfif arguments.subset.getSubset_id() neq 0>
				<cfset update(arguments.subset)>
			<cfelse>
				<cfset create(arguments.subset)>
			</cfif>
		</cftransaction>
	</cffunction>

	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="subset" type="fw.model.subset.subset" required="yes">
		<cfset var data = subset.getInstanceMemento()>
		<cfset var newsubset = 0>
		<cftransaction>
            <cfquery name="newsubset" datasource="#variables.dsn#">
                INSERT INTO subset (subsettype_id, code, description, display_id, alt_display_id, spq_display_id, oe_name, intro_display_id, resultpage_id, 
                	shadow_subset_id, branding_partner_id, active_flag, test_flag, eform_flag, report_flag, create_user_id, create_date, modify_user_id, modify_date)
                VALUES (
                	<cfqueryparam cfsqltype="cf_sql_integer" value="#data.subsettype_id#" null="#yesnoformat(len(data.subsettype_id) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.code#" null="#yesnoformat(len(data.code) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.description#" null="#yesnoformat(len(data.description) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#data.display_id#" null="#yesnoformat(len(data.display_id) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_integer" value="#data.alt_display_id#" null="#yesnoformat(len(data.alt_display_id) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#data.spq_display_id#" null="#yesnoformat(len(data.spq_display_id) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.oe_name#" null="#yesnoformat(len(data.oe_name) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#data.intro_display_id#" null="#yesnoformat(len(data.intro_display_id) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#data.resultpage_id#" null="#yesnoformat(len(data.resultpage_id) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#data.shadow_subset_id#" null="#yesnoformat(len(data.shadow_subset_id) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#data.branding_partner_id#" null="#yesnoformat(len(data.branding_partner_id) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_bit" value="#data.active_flag#" null="#yesnoformat(len(data.active_flag) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_bit" value="#data.test_flag#" null="#yesnoformat(len(data.test_flag) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_bit" value="#data.eform_flag#" null="#yesnoformat(len(data.eform_flag) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_bit" value="#data.reprt_flag#" null="#yesnoformat(len(data.report_flag) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#data.create_user_id#" null="#yesnoformat(len(data.create_user_id) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_date" value="#data.create_date#" null="#yesnoformat(len(data.create_date) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#data.modify_user_id#" null="#yesnoformat(len(data.modify_user_id) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_date" value="#data.modify_date#" null="#yesnoformat(len(data.modify_date) eq 0)#">
                )
            </cfquery>
            <cfquery name="qMaxID" datasource="#variables.dsn#">
            	SELECT MAX(subset_id) as maxID from subset
            </cfquery>
		</cftransaction>
		<cfset subset.setSubset_id(qMaxID.maxID)>
	</cffunction>


	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="subset" type="fw.model.subset.subset" required="yes">
		<cfset var updatesubset = 0>
		<cfquery name="updatesubset" datasource="#variables.dsn#">
			UPDATE subset
			SET 
				subsettype_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user.getSubsettype_id()#" null="#yesnoformat(len(user.getSubsettype_id()) eq 0)#">,
				code = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#user.getCode()#" null="#yesnoformat(len(user.getCode()) eq 0)#">,
				description = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#user.getDescription()#" null="#yesnoformat(len(user.getDescription()) eq 0)#">,
                display_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user.getDisplay_id()#" null="#yesnoformat(len(user.getDisplay_id()) eq 0)#">,
				alt_display_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user.getAlt_display_id()#" null="#yesnoformat(len(user.getAlt_display_id()) eq 0)#">,
                spq_display_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user.getSpq_display_id()#" null="#yesnoformat(len(user.getSpq_display_id()) eq 0)#">,
                oe_name = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#user.getOe_name()#" null="#yesnoformat(len(user.getOe_name()) eq 0)#">,
                intro_display_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user.getIntro_display_id()#" null="#yesnoformat(len(user.getIntro_display_id()) eq 0)#">,
              	resultpage_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user.getResultpage_id()#" null="#yesnoformat(len(user.getResultpage_id()) eq 0)#">,
                shadow_subset_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user.getShadow_subset_id()#" null="#yesnoformat(len(user.getShadow_subset_id()) eq 0)#">,
                branding_partner_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user.getBranding_partner_id()#" null="#yesnoformat(len(user.getBranding_partner_id()) eq 0)#">,
                active_flag = 
					<cfqueryparam cfsqltype="cf_sql_bit" value="#user.getActive_flag()#" null="#yesnoformat(len(user.getActive_flag()) eq 0)#">,
                test_flag = 
					<cfqueryparam cfsqltype="cf_sql_bit" value="#user.getTest_flag()#" null="#yesnoformat(len(user.getTest_flag()) eq 0)#">,
                report_flag = 
					<cfqueryparam cfsqltype="cf_sql_bit" value="#user.getReport_flag()#" null="#yesnoformat(len(user.getReport_flag0()) eq 0)#">,
                create_user_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user.getCreate_user_id()#" null="#yesnoformat(len(user.getCreate_user_id()) eq 0)#">,
                create_date = 
					<cfqueryparam cfsqltype="cf_sql_date" value="#user.getCreate_date()#" null="#yesnoformat(len(user.getCreate_date()) eq 0)#">,
                modify_user_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user.getModify_user_id()#" null="#yesnoformat(len(user.getModify_user_id()) eq 0)#">,
                modify_date = 
					<cfqueryparam cfsqltype="cf_sql_date" value="#user.getModify_date()#" null="#yesnoformat(len(user.getModify_date()) eq 0)#">
			WHERE subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user.getSubset_id()#">
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="fw.model.subset.subset" output="false">
		<cfargument name="subset_id" type="numeric" required="yes">
		<cfset var data = structNew()>
		<cfset var subset = "">
		<cfset var readsubset = "">
		<cfquery name="readsubset" datasource="#variables.dsn#">
            SELECT 	*
            FROM 	subset
            WHERE 	subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.subset_id#">
		</cfquery>
		<cfloop list="#readsubset.columnList#" index="field">
			<cfset newVal = evaluate('readsubset.#field#')>
        	<cfif newVal IS "NULL" OR newVal IS "">
            <cfelse>
				<cfset 'data.#field#' = newVal>
            </cfif>
		</cfloop>
		<cfset subset = createObject("component", "fw.model.subset.subset").init(argumentcollection=data)>
		<cfreturn subset>
	</cffunction>

</cfcomponent>