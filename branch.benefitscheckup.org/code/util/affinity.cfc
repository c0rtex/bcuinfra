<cfcomponent>
<cffunction access="remote" name="LogAffinityClick" output="false" returntype="numeric"  hint="Log to db an affinity url click"  >
	<!-- pass arguments -->
	<cfargument name="partner_id" type="numeric" required="yes"  >
        <cfargument name="partner_session_id" type="string" required="no" default=""  >
        <cfargument name="url_id" type="numeric" required="yes"  >
        <cfargument name="campaign_id" type="string" required="yes"  >
	<cfargument name="internal_flag" type="numeric" required="no" default="1"  >
        <cfargument name="ahn_contact_flag" type="numeric" required="no" default="0"  >
        <cfargument name="eversafe_id" type="numeric" required="no" default="0"  >
        <cfargument name="screening_id" type="numeric" required="no" default="0"  >
        <cfargument name="click_id" type="numeric" required="no" default="0"  >
		<cfif click_id eq 0 and url_id gt 0 >
		<cfquery name="logClick" datasource="#application.dbSrc#" result="clickresult">
			INSERT INTO click 
				(url_id, campaign_id, screening_id, partner_session_id,cfid, oe_flag,cftoken, partner_id, test_flag, target_flag,internal_flag, ahn_contact_flag,click_datetime)
			VALUES
				(#url_id#,
				'#campaign_id#', 
				#screening_id#, 
				'#partner_session_id#', 
				0, 
				0,
				0,
				#partner_id#,  
				0, 
				0,
				#internal_flag#,
				#ahn_contact_flag#,
				#CreateODBCDateTime(Now())#
				)
		</cfquery>
		     <cfset click_id = clickresult.GENERATED_KEY>
		<cfelseif screening_id gt 0 and click_id gt 0>
			<cfquery name="updateClick" datasource="#application.dbSrc#" result="clickresult">
			update click set screening_id = #screening_id# where click_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#click_id#" maxlength="4">
			</cfquery>
		<cfelseif ahn_contact_flag gt 0 and click_id gt 0>
			<cfquery name="updateClick" datasource="#application.dbSrc#" result="clickresult">
			update click set ahn_contact_flag = 1 where click_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#click_id#" maxlength="4">
			</cfquery>
		</cfif>
		<cfreturn  click_id>
    </cffunction>
</cfcomponent>
