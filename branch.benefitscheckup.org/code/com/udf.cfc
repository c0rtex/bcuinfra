<cfcomponent displayname="User Defined Functions">
<!--- Bug 5787 - Locators - store stats needed for reporting purposes --->
	<cffunction name="logPageViews" output="false" returntype="void">
		<cfargument name="county_id" default="" required="false">
		<cfargument name="program_id" default="" required="false">
		<cfargument name="state_id" default="" required="false">
		<cfargument name="zipcode" default="00000" required="true">
		<cfargument name="partner_id" default="0" required="false">
		<cfargument name="address" default="#CGI.remote_addr#" required="false">
		<cfargument name="host" default="#CGI.remote_addr#" required="false">
		<cfargument name="referer" default="#Left(CGI.http_referer, 95)#" required="false">
		<cfargument name="agent" default="#CGI.http_user_agent#" required="false">
		<cfargument name="page" default="#CGI.script_name#" re    quired="false">
		<cfargument name="cfid" default="#SESSION.cfid#" required="false">
		<cfargument name="cftoken" default="#SESSION.cftoken#" required="false">
		<cfargument name="programcategory_id" default="0" required="false">
		<cfargument name="application_id" default="0" required="false">
		
		<cfif IsDefined('SESSION.programcategory_id')>
			<cfset arguments.programcategory_id = SESSION.programcategory_id>
		</cfif>
		
		<cfif isDefined('URL.county_id')>
			<cfset arguments.county_id = URL.county_id>
		</cfif>
		<cfif isDefined('URL.program_id')>
			<cfset arguments.program_id = URL.program_id>
		</cfif>
		<cfif isDefined('SESSION.program_id')>
			<cfset arguments.program_id = SESSION.program_id>
		</cfif>
		<cfif isDefined('FORM.zipcode')>
			<cfset arguments.zipcode = FORM.zipcode>
		</cfif>
		<cfif isDefined('SESSION.partner_id') AND SESSION.partner_id NEQ 0>
			<cfset arguments.partner_id = SESSION.partner_id>
		</cfif>
		<cfif IsDefined('URL.partner_id')>
			<cfset arguments.partner_id = URL.partner_id>
		</cfif>
		<cfif isDefined('SESSION.application_id')>
			<cfset arguments.application_id = SESSION.application_id>
		</cfif>
		<cfif arguments.page EQ '/locator_county.cfm'>
			<cfset arguments.page = '/medicaid_locator_county.cfm'>
		</cfif>
	
		<CFIF host EQ ''>
		    <CFSET host = "unknown">
		</CFIF>
		<CFIF referer EQ ''>
		    <CFSET referer = "unknown">
		</CFIF>
		
		<!--- Get state_id if county_id exists --->
		<cfif arguments.county_id NEQ ''>
			<cfquery datasource="#application.dbSrc#" name="getStateID">
				SELECT *
				FROM county
				WHERE county_id = <cfqueryparam cfsqltype="cf_sql_char" value="#arguments.county_id#">
			</cfquery>
			
				<cfset arguments.state_id = getStateID.state_id>
				<cfset arguments.county_id = getStateID.county_id>
		</cfif>
		
		<cfquery datasource="#application.dbSrc#" name="getStateAndCounty">
			SELECT *
			FROM zip
			WHERE zipcode = <cfqueryparam cfsqltype="cf_sql_char" value="#arguments.zipcode#"> LIMIT 0, 1
		</cfquery>
		
		<cfif getStateAndCounty.recordcount>
			<cfset arguments.state_id = getStateAndCounty.state_id>
			<cfset arguments.county_id = getStateAndCounty.county_id>
		</cfif>
		
		<cfif NOT isDefined('SESSION.program_id')>
			<!--- Get program_id --->
			<cfquery datasource="#application.dbSrc#" name="getProgramID">
				SELECT program_id
		    	FROM program
		    	WHERE state_id = <cfqueryparam cfsqltype="cf_sql_char" value="#arguments.state_id#"> 
				AND programcategory_id = <cfqueryparam cfsqltype="cf_sql_char" value="#arguments.programcategory_id#"> 
			</cfquery>
			
			<cfif getProgramID.recordcount>
				<cfset arguments.program_id = getProgramID.program_id>
			</cfif>
		</cfif>
		
		<cfif arguments.zipcode NEQ '00000'>
			<cfset arguments.county_id = ''>
		</cfif>
		
		<cfif arguments.zipcode EQ '00000'>
			<cfset arguments.zipcode = ''>
		</cfif>
		
		<cfif Find('aarp', referer)>
			<cfset arguments.partner_id = 22>
		</cfif>
		<cfif Find('eldercare', referer)>
			<cfset arguments.partner_id = 79>
		</cfif>
		
		<!--- Log to database --->
		<cfif arguments.state_id NEQ ''>
			<cfquery datasource="#application.dbSrc#">
				INSERT INTO logPageViews (
					county_id,
					program_id,
					state_id,
					zipcode,
					partner_id,
					address,
					host,
					referer,
					agent,
					page,
					cfid,
					cftoken,
					application_id
				) VALUES (
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.county_id)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.program_id)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.state_id)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.zipcode)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.partner_id)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.address)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.host)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.referer)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.agent)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.page)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.cfid)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.cftoken)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(arguments.application_id)#">
				);
			</cfquery>
		</cfif>
	</cffunction>
</cfcomponent>