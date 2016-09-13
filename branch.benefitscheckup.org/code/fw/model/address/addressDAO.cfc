<cfcomponent output="false" displayname="addressDAO" hint="I am a address data access object.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="address" type="fw.model.address.address" required="yes">
		<cfif arguments.address.getID() neq 0>
			<cfset update(arguments.address)>
		<cfelse>
			<cfset create(arguments.address)>
		</cfif>
	</cffunction>

	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="address" type="fw.model.address.address" required="yes">
		<cfset var data = address.getInstanceMemento()>
		<cfset var newaddress = 0>
		<cftransaction>
		<cfquery name="newaddress" datasource="#variables.dsn#">
            INSERT INTO address (street, city, state, zip)
            VALUES (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.street#" null="#yesnoformat(len(data.street) eq 0)#" maxlength="100">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.city#" null="#yesnoformat(len(data.city) eq 0)#" maxlength="100">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.state#" null="#yesnoformat(len(data.state) eq 0)#" maxlength="50">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.zip#" null="#yesnoformat(len(data.zip) eq 0)#" maxlength="50">
            )
		</cfquery>
		<cfquery name="qMaxID" datasource="#variables.dsn#">
			SELECT MAX(id) as maxID from address
		</cfquery>
		</cftransaction>
		<cfset address.setId(qMaxID.maxID)>
	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="address" type="fw.model.address.address" required="yes">
		<cfset var data = address.getInstanceMemento()>
		<cfset var updateaddress = 0>
		<cfquery name="updateaddress" datasource="#variables.dsn#">
            UPDATE address
            SET 
                street = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.street#" null="#yesnoformat(len(data.street) eq 0)#" maxlength="100">,
                city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.city#" null="#yesnoformat(len(data.city) eq 0)#" maxlength="100">,
                state = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.state#" null="#yesnoformat(len(data.state) eq 0)#" maxlength="50">,
                zip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.zip#" null="#yesnoformat(len(data.zip) eq 0)#" maxlength="50">
            WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#data.id#">
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="fw.model.address.address" output="false">
		<cfargument name="address_id" type="numeric" required="yes">
		<cfset var data = structNew()>
		<cfset var address = 0>
		<cfset var readaddress = 0>
		<cfquery name="readaddress" datasource="#variables.dsn#">
            SELECT id, street,city, state, zip
            FROM address
            WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#address_id#">
		</cfquery>
		<cfloop list="#readaddress.columnList#" index="field">
			<cfset 'data.#field#' = evaluate('readaddress.#field#')>
		</cfloop>
		<cfset address = createObject("component", "fw.model.address.address").init(argumentcollection=data)>
		<cfreturn address>
	</cffunction>

</cfcomponent>