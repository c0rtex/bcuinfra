<cfcomponent>
<!--- Web Service component for remote screening --->
  <cffunction access="remote" name="doScreening" output="false" returntype="string"   >
	<!--- pass arguments --->
	<cfargument name="subset_id"  type="numeric" required="yes" >
	<cfargument name="partner_id" type="numeric" required="yes" >
	<cfargument name="partner_screening_id" type="string"  required="no"  >
	<cfargument name="org_id" type="string"  required="yes"   >
	<cfargument name="password" type="string" required="no"  >
	<cfargument name="client_id" type="string"  required="no" >
	<cfargument name="response_list" type="string" required="no"  >		
	<!-- evaluate stuff -->
	<cfset program_list = "">
	<cfset language_id = "2" >
	<cfset screening_id = "" >
	<cfset error_code = "" >
	<!-- LIS QuickScreen Subset ID -->
	<cfparam name="subset_id" type="numeric" default= 27>
	<!-- Synergy Partner ID -->
	<cfparam name="partner_id" type="numeric" default=  26>
	<!-- evaluate stuff -->
	<!--Set Default Result Values -->
	<cfparam name="screeningresults.program_list" default = "">
	<cfparam name="screeningresults.date_time" default = "#dateformat(now())#">
	<cfparam name="screeningresults.language_id" default = "2">
	<cfparam name="screeningresults.error_code" default = "Success">
	<cfparam name="screeningresults.screening_id" default = 0>
	<cfparam name="screeningresults.report_url" default = "">
	<!--- This service is no longer available. For more information, please contact your Harmony administrator or BenefitsCheckUp at support@benefitscheckup.org --->
	<cfif org_id neq "" and org_id gt 0 and 1 eq 0>
		<cfinclude template="../synergyxmlparser.cfm">
	<cfelse>
		<cfset screeningresults.error_code = "In order to complete a BenefitsCheckUp screening, your account must include a BenefitsCheckUp organization identifier. Please contact your Synergy Administrator for more information.">
		<!--- This error code replacement "displays no longer available" text --->
		<cfset screeningresults.error_code = "This service is no longer available. For more information, please contact Jinny Allison by e-mail at jallison@harmonyis.com or by phone at 802-316-4719. You can also contact BenefitsCheckUp at support@benefitscheckup.org">
	</cfif>
	<!-- Pass the results back to client in a string -->
	<cfset teststring = "#screeningresults.program_list#;#screeningresults.date_time#;#screeningresults.language_id#;#screeningresults.screening_id#;#screeningresults.error_code#;#screeningresults.report_url#">
	<cfreturn  teststring>
  </cffunction>

    <cffunction access="remote" name="screenMe" output="false" returntype="string"   >
	<!--- pass arguments --->
	<cfargument name="subset_id"  type="numeric" required="yes" >
	<cfargument name="partner_id" type="numeric" required="yes" >
	<cfargument name="partner_screening_id" type="string"  required="no"  >
	<cfargument name="org_id" type="string"  required="yes"   >
	<cfargument name="password" type="string" required="no"  >
	<cfargument name="client_id" type="string"  required="no" >
	<cfargument name="response_list" type="string" required="no"  >		
	<!-- evaluate stuff -->
	<cfset program_list = "">
	<cfset language_id = "2" >
	<cfset screening_id = "" >
	<cfset error_code = "" >
	<!-- LIS QuickScreen Subset ID -->
	<cfparam name="subset_id" type="numeric" default= 27>
	<!-- Synergy Partner ID -->
	<cfparam name="partner_id" type="numeric" default=  26>
	<!-- evaluate stuff -->
	<!--Set Default Result Values -->
	<cfparam name="screeningresults.program_list" default = "">
	<cfparam name="screeningresults.date_time" default = "#dateformat(now())#">
	<cfparam name="screeningresults.language_id" default = "2">
	<cfparam name="screeningresults.error_code" default = "Success">
	<cfparam name="screeningresults.screening_id" default = 0>
	<cfparam name="screeningresults.report_url" default = "">
	<!--- This service is no longer available. For more information, please contact your Harmony administrator or BenefitsCheckUp at support@benefitscheckup.org --->
	<cfif org_id neq "" and org_id gt 0 and 1 eq 0>
		<cfinclude template="../synergyxmlparser.cfm">
	<cfelse>
		<cfset screeningresults.error_code = "In order to complete a BenefitsCheckUp screening, your account must include a BenefitsCheckUp organization identifier. Please contact your Synergy Administrator for more information.">
		<!--- This error code replacement "displays no longer available" text --->
		<cfset screeningresults.error_code = "This service is no longer available. For more information, please contact Jinny Allison by e-mail at jallison@harmonyis.com or by phone at 802-316-4719. You can also contact BenefitsCheckUp at support@benefitscheckup.org">
	</cfif>
	<!-- Pass the results back to client in a string -->
	<cfset teststring = "#screeningresults.program_list#;#screeningresults.date_time#;#screeningresults.language_id#;#screeningresults.screening_id#;#screeningresults.error_code#;#screeningresults.report_url#">
	<cfreturn  teststring>
  </cffunction>
</cfcomponent>