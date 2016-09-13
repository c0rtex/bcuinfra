<cfcomponent>
<!--- Web Service component for remote screening --->
    <cffunction access="remote" name="doScreening" output="false" returntype="query"   >
	<!--- pass arguments --->
	<cfargument name="partner_id" type="numeric" required="yes" >
	<cfargument name="partner_screening_id" type="string"  required="no"  >
	<cfargument name="org_id" type="numeric"  required="no"   >
	<cfargument name="password" type="string" required="no"  >
	<cfargument name="client_id" type="string"  required="no" >
	<cfargument name="response_list" type="string" required="yes"  >

	<cfif isdefined('partner_id')>
		<cfset request.partner_id = partner_id>
	</cfif>
	<cfif isdefined('org_id')>
		<cfset request.org_id = org_id>
	<cfelse>
		<cfset request.org_id = "">
	</cfif>
    <!-- set org_id to null for all human arc screenings -->
	<cfif  isdefined('client_id')>
		<cfset request.client_id = client_id>
	<cfelse>
		<cfset request.client_id = 0>
	</cfif>
	<cfif isdefined('partner_screening_id')>
		<cfset request.partner_screening_id = partner_screening_id>
	<cfelse>
		<cfset request.partner_screening_id = "">
	</cfif>		
	<!-- evaluate stuff -->
	<cfset program_list = "">
	<cfset language_id = "2" >
	<cfset screening_id = "" >
	<cfset error_code = "" >


	<!-- evaluate stuff -->
	<!--Set Default Result Values -->
	<cfset testresults = arraynew(1)>
	<cfset resultset = QueryNew("screening_id,partner_screening_id,partner_id,org_id,subset_id,client_id,report_url,validation_error,program_list,screening_status,reentry_number,date_time,program_title","integer,varchar,integer,integer,integer,varchar,varchar,varchar,varchar,varchar,integer,date,varchar")>
	<cfparam name="screeningresults.program_list" default = "">
	<cfparam name="screeningresults.date_time" default = "#dateformat(now())#">
	<cfparam name="screeningresults.language_id" default = "2">
	<cfparam name="screeningresults.error_code" default = "Success">
	<cfparam name="screeningresults.screening_id" default = 0>
	<cfparam name="screeningresults.report_url" default = "">
	
	<!--- do screening or display errors messages --->
	<cfif 1 eq 1>
		<cfinclude template="../servicexmlparser.cfm">
	<cfelse>
		<cfset screeningresults.error_code = "In order to complete a BenefitsCheckUp screening, your account must include a BenefitsCheckUp organization identifier. Please contact your Synergy Administrator for more information.">
		<!--- This error code replacement "displays no longer available" text --->
		<cfset screeningresults.error_code = "This service is no longer available. For more information, please contact Jinny Allison by e-mail at jallison@harmonyis.com or by phone at 802-316-4719. You can also contact BenefitsCheckUp at support@benefitscheckup.org">
	</cfif>
	<!-- Pass the results back to client in a string -->
	<cfreturn  resultset>
  </cffunction>
</cfcomponent>