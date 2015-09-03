<cfcomponent output="false" displayname="addressGateway" hint="I am a address gateway.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" required="yes" type="string">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<!--- <cffunction name="getAddresss" access="public" returntype="query" output="false">
		<cfargument name="address_id" required="no" type="numeric" default="0">
		<cfargument name="address1" required="no" type="string" default="">
		<cfargument name="address2" required="no" type="string" default="">
		<cfargument name="city" required="no" type="string" default="">
		<cfargument name="state" required="no" type="string" default="">
		<cfargument name="zip" required="no" type="string" default="">
		<cfargument name="country" required="no" type="string" default="">
		<cfset var qAddresss = 0>
		<cfquery name="qAddresss" datasource="#variables.dsn#">
		SELECT id, address1, address2, city, state, zip, country
		FROM addresses
		WHERE (1=1)
			<cfif arguments.address_id neq "0">AND id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.address_id#"
				null="#yesnoformat(len(arguments.address_id) eq 0)#"></cfif>
			<cfif arguments.address1 neq "">AND address1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.address1#"
				null="#yesnoformat(len(arguments.address1) eq 0)#" maxlength="100"></cfif>
			<cfif arguments.address2 neq "">AND address2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.address2#"
				null="#yesnoformat(len(arguments.address2) eq 0)#" maxlength="100"></cfif>
			<cfif arguments.city neq "">AND city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.city#"
				null="#yesnoformat(len(arguments.city) eq 0)#" maxlength="100"></cfif>
			<cfif arguments.state neq "">AND state = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.state#"
				null="#yesnoformat(len(arguments.state) eq 0)#" maxlength="50"></cfif>
			<cfif arguments.zip neq "">AND zip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.zip#"
				null="#yesnoformat(len(arguments.zip) eq 0)#" maxlength="50"></cfif>
			<cfif arguments.country neq "">AND country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.country#"
				null="#yesnoformat(len(arguments.country) eq 0)#" maxlength="100"></cfif>
		</cfquery>
		<cfreturn qAddresss>
	</cffunction> --->

</cfcomponent>