<cfcomponent   >
    <cffunction   access="remote" name="doScreening" output="false" returntype="query"  hint="accepts list of responses and processes screening results" >
	<!-- pass arguments -->
	<cfargument name="partner_id" type="numeric" required="yes" >
	<cfargument name="partner_screening_id" type="numeric"  required="no"  >
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
	<cfif isdefined('client_id')>
		<cfset request.client_id = client_id>
	<cfelse>
		<cfset request.client_id = "">
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
	<cfset Lognumber = int(rand() * 1000)>
	<cffile action="WRITE" file="#session.strPDFPath#ServiceCallTesting#Lognumber#.txt" output="#response_list#">

	<!-- evaluate stuff -->
	<!--Set Default Result Values -->
	<cfset testresults = arraynew(1)>
	<cfset resultset = QueryNew("screening_id,partner_screening_id,partner_id,org_id,subset_id,client_id,report_url,validation_error,program_list,screening_status,reentry_number,date_time,program_title","integer,integer,integer,integer,integer,varchar,varchar,varchar,varchar,varchar,integer,date,varchar")>
	<cfparam name="screeningresults.program_list" default = "">
	<cfparam name="screeningresults.date_time" default = "#dateformat(now())#">
	<cfparam name="screeningresults.language_id" default = "2">
	<cfparam name="screeningresults.error_code" default = "Success">
	<cfparam name="screeningresults.screening_id" default = 0>
	<cfparam name="screeningresults.report_url" default = "">
	
	<!-- do screening or display errors messages -->
	<cfif 1 eq 1>
		<cfinclude template="/cf/servicexmlparser.cfm">
	<cfelse>
		<cfset screeningresults.error_code = "In order to complete a BenefitsCheckUp screening, your account must include a BenefitsCheckUp organization identifier. Please contact your Synergy Administrator for more information.">
		<!-- This error code replacement displays no longer available text -->
		<cfset screeningresults.error_code = "This service is no longer available. For more information, please contact Jinny Allison by e-mail at jallison@harmonyis.com or by phone at 802-316-4719. You can also contact BenefitsCheckUp at support@benefitscheckup.org">
	</cfif>
	<!-- Pass the results back to client in a string -->
	<cfreturn  resultset>
  </cffunction>

  <cffunction access="remote" name="getQuestions" output="false" returntype="string"   hint="returns questions by state and subset id">
	<!-- pass arguments -->
	<cfargument name="subset_id" type="numeric" required="yes" >
	<cfargument name="partner_id" type="numeric" required="yes" >
	<cfargument name="state_id" type="string" required="yes" >
	<cfset url.state_id ="#state_id#">
	<cfset url.subset_id ="#subset_id#">
	<cfset url.partner_id ="#partner_id#">
	<cfinclude template="/cf/remotequestionnaire.cfm">
	<!--cfset resultset = querynew('Col1, Col2')--->
	<cfset resultset = questionnaireXML>
	<cfreturn  resultset>
  </cffunction>


  <cffunction access="remote" name="getProgramEntryPoints" output="false" returntype="string" hint="returns entry point offices by program"  >
	<!-- pass arguments -->
	<cfargument name="program_id" type="numeric" required="yes" >
	<cfargument name="partner_id" type="numeric" required="no" default="0" >
	<cfargument name="county" type="string" required="yes" >
	<cfargument name="city" type="string" required="no" >
	<cfargument name="state_id" type="string" required="yes" >
	<cfargument name="limit" type="numeric" required="no" default="3" >
	<cfargument name="radius" type="numeric" required="no" default="100" >
	<cfargument name="zip" type="string" required="yes" >
	<!-- cf_displayprogramdetailentrypoints proximityOverride="county" city="#city#" program_id="#program_id#" state_id="#state_id#" county="#county#" zip="#zip#" source="details" var="resultstring" google="#showgooglemaplink#" -->
	<cfset testzipcode = "#zip#">
    	<cfset session.partner_id = 0>
    	<cf_displayprogramdetailAgis program_id = "#program_id#" state_id="#state_id#" county="#county#" zip="#testzipcode#" source="ec" supressforms="true" suppressOfficesLink="true" eplimit="#limit#" requisites="false" description="false"  entrypoints="true"  var="resultstring"  >

	<cfreturn  resultstring>
  </cffunction>


   <cffunction access="remote" name="getProgramDetails" output="false" returntype="string"  hint="returns details and description about program" >
	<!-- pass arguments -->
	<cfargument name="program_id" type="numeric" required="yes" default="" >
	<cfargument name="state_id" type="string" required="yes" default="">
       	<cfargument name="county" type="string" required="yes" default="">
	<cfargument name="zip" type="string"  default="0">
	<cfargument name="showdescription" type="boolean"  default="true">
       	<cfargument name="showentrypoints" type="boolean"  default="true">
       	<cfargument name="showrequisites" type="boolean"  default="true">
       	<cfargument name="eplimit" type="numeric"  default="3">
	<cfset session.st = state_id >
    	<cfset session.partner_id = 0>
   	<cfset session.org_id = 0>
    	<cfset resultstring = "">
	<cf_displayprogramdetailAgis program_id = "#program_id#" state_id="#state_id#" county="#county#" zip="#zip#" source="ec" eplimit="#eplimit#" requisites="#showrequisites#" description="#showdescription#"  entrypoints="#showentrypoints#"  var="resultstring" supressforms="true"  >
	
	<cfreturn  resultstring>
  </cffunction>
   
   <cffunction access="remote" name="getProgramForms" output="false" returntype="string" hint="returns application forms by program"   >
	<!-- pass arguments -->
	<cfargument name="program_id" type="numeric" required="true" hint="valid bcu program identified" >
	<cfargument name="state_id" type="string" required="true" hint="2 digit state abrev" >
	<cfargument name="format" type="string" required="true" default="html" hint="html or xml" >
	<cfset session.test_id = 1>
	<cfset session.partner_id = 0>
    <cfset session.state_id = state_id>
	<cfif format eq "html">
	<cf_displayprogramdetailformsAgis foodStampLegendVar="a" multiProgramLegendVar="b" fillableLegendVar="c" program_id = "#program_id#" state_id="#state_id#"  var="resultstring" formtype_id=0 source="details" >
	<cfelse>
	<cf_displayprogramdetailformsAgis foodStampLegendVar="a"  multiProgramLegendVar="b"  fillableLegendVar="c"  program_id = "#program_id#" state_id="#state_id#"  var="resultstring" formtype_id=0 source="details" format="xml">
	</cfif>
	<cfreturn  resultstring>
  </cffunction>

    <cffunction access="remote" name="getProgramCategories" output="false" returntype="query"  hint="return program categories"  >
	<!-- pass arguments -->
	<cfset session.test_id = 1>
	<cfset session.partner_id = 0>
	<cfset queryCat = QueryNew("program_category_id, category_code, category")>
	<cfquery name="queryCat" datasource="#application.dbSrc#">
		select programcategory_id,code as category_code, '' as category  from programcategory order by sort
	</cfquery>
		<cfreturn  queryCat>
    </cffunction>

	<cffunction access="remote" name="getSubsetPrograms" output="false" returntype="query"  hint="return all programs in subset"  >
	<!-- pass arguments -->
	<cfargument name="subset_id" type="numeric" required="yes"  >
		<cfset querySubsetProgram = QueryNew("program_id, program_category_id, subset_id, program_code, program_title, category_code")>
		<cfquery name="querySubsetProgram" datasource="#application.dbSrc#">
		select p.program_id, p.program_code, p.programcategory_id,sp.subset_id,
		pa.prg_nm as program_name,pc.code as category_code
		from subset_program_sum sp, program p, tbl_prg_all pa, programcategory pc
		where 
		sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
		and sp.program_id=p.program_id
		and p.active_flag=1
		and pa.recid = p.program_id
		and pc.programcategory_id = p.programcategory_id
		order by p.sort,p.program_id
		</cfquery>
		<cfreturn  querySubsetProgram>
    </cffunction>

	
     <cffunction access="remote" name="getProgramRequisites" output="false" returntype="query" hint="display list of program required materials for application processing"  >
	<!-- pass arguments -->
	<cfargument name="program_id" type="numeric" required="yes" >
	<cfargument name="state_id" type="string" required="yes" >
	<cfset session.test_id = 1>
	<cfset session.partner_id = 0>
	<cfset results = QueryNew("program_id, requisite_id, requisite_title, requisite_description")>
	<cfreturn  results>
    </cffunction>
</cfcomponent>