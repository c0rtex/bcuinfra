<cfcomponent   >
 	<cffunction access="remote" name="getServiceVersion" output="false" returntype="string"  hint="Returns the version of the service"  >
        	<!-- pass arguments -->
        	<cfargument name="partner_id" type="string" required="yes"  >
        	<cfset version = "1.01">
        	<cfreturn  version>
    	</cffunction>
	<cffunction access="remote" name="getUserScreenings" output="false" returntype="query"  hint="returns user screenings by partner_session_id or date range,  max 500 rows. If date params are provided input partner_session_id as empty string, else date params..."  >
        	<cfargument name="partner_id" type="string" required="yes" >
		<cfargument name="partner_session_id" type="string" required="yes" >
		<cfargument name="start_date" type="string" required="yes" >
		<cfargument name="end_date" type="string" required="yes" >
		<cfquery name="queryUserScreenings" datasource="#application.dbSrc#">
			Select * from screening
			where partner_id = 142 
			<cfif partner_session_id neq ''>
			and client_id  like '#partner_session_id#'
			<cfelseif start_date neq '' and end_date neq ''>
			AND start_datetime >= '#start_date#'
			AND end_datetime <= '#end_date#'
			</cfif>
			limit 500
		</cfquery>
		<cfreturn queryUserScreenings>
    	</cffunction>
	<cffunction access="remote" name="getAnswerfieldData" output="false" returntype="query"  hint="returns user Answerfield Data" >
		<cfargument name="partner_id" type="string" required="yes" >
		<cfargument name="screening_id" type="string" required="yes" >
		<cfquery name="queryAnswerfieldData" datasource="#application.dbSrc#">
			SELECT sa.screening_id, a.answerfield, o.option_code, sa.response 
			FROM answerfield a 
			INNER JOIN screening_answerfield sa ON sa.answerfield_id = a.answerfield_id 
			LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id 
			WHERE sa.screening_id= #screening_id#
			ORDER BY sa.pagenum, a.answerfield, sa.submit_datetime
		</cfquery>
		<cfreturn queryAnswerfieldData>
	</cffunction>
	<cffunction access="remote" name="getReportContent"   output="false" returntype="query"  hint="returns report content and recommendations associated to specified ECU screeningID" >
		<cfargument name="partner_id" type="string" required="yes" >
		<cfargument name="screening_id" type="string" required="yes" >
		<cfset queryContent = QueryNew("post_id, content_code, screening_id,sort_order, section_code,programcategory_id,program_id,programgroup_id,bcu_link_flag,report_conten,post_titlet")>
        <cfquery name="queryContent" datasource="#application.dbSrc#">
	SELECT Distinct
	screening_content.post_id,
	screening_content.content_code,
	screening_content.screening_id,
	subset_content.sort_order,
	subset_content.section_code,
	screening.preset_state_id as state_id,
	1 as programcategory_id,
	'' as program_id,
	'' as programgroup_id,
	0 as bcu_link_flag,
	'' as report_content,
	'' as post_title,
	subset_content.is_image,
	subset_content.parent_id,
	subset_content.sub_section
	FROM
	screening_content
	INNER JOIN subset_content ON subset_content.post_code = screening_content.content_code
	INNER JOIN screening ON screening.screening_id = screening_content.screening_id
	where
	screening.screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="30">
	and screening.partner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="142" maxlength="30">
	and screening.subset_id = subset_content.subset_id
	order by section_code, sort_order
	</cfquery>
	<cfset x = 0>
	<cfset wp_db_version = 'wp_posts_v3_1' >
	<cfif screening_id lt 5 >
		<cfset wp_db_version = 'wp_posts_v2_0' >
	</cfif>
	<cfloop query="queryContent">
    		<cfset x = x + 1>
		<cfquery name="querySAFS" datasource="wp_benefitscheckup">
		select post_title, post_content from <cfoutput>#wp_db_version#</cfoutput>
		where ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#post_id#" maxlength="4">
        	</cfquery>
		<cfif queryContent.state_id eq 'ak'>
			<cfset spap_text = "Alaska Senior Benefits">
		<cfelseif queryContent.state_id eq 'de'>
			<cfset spap_text = "Delaware Prescription Assistance Program (DPAP)">
		<cfelseif queryContent.state_id eq 'in'>
			<cfset spap_text = "HoosierRx (State Pharmacy Assistance Program)">
		<cfelseif queryContent.state_id eq 'ma'>
			<cfset spap_text = "Prescription Advantage Plan (State Pharmacy Assistance Program)">
		<cfelseif queryContent.state_id eq 'md'>
			<cfset spap_text = "Maryland Senior Prescription Drug Assistance Program (SPDAP)">
		<cfelseif queryContent.state_id eq 'me'>
			<cfset spap_text = "Maine Low Cost Drugs for the Elderly or Disabled (DEL) or Maine Rx Plus">
		<cfelseif queryContent.state_id eq 'mo'>
			<cfset spap_text = "Missouri Rx Plan (State Pharmacy Assistance Program)">
		<cfelseif queryContent.state_id eq 'mt'>
			<cfset spap_text = "Montana Big Sky Rx Program (State Pharmacy Assistance Program)">
		<cfelseif queryContent.state_id eq 'nj'>
			<cfset spap_text = "Pharmaceutical Assistance to the Aged & Disabled (PAAD)">
		<cfelseif queryContent.state_id eq 'nv'>
			<cfset spap_text = "Nevada Senior Rx (State Pharmacy Assistance Program)">
		<cfelseif queryContent.state_id eq 'ny'>
			<cfset spap_text = "Elderly Pharmaceutical Insurance Coverage (EPIC)">
		<cfelseif queryContent.state_id eq 'or'>
			<cfset spap_text = "Oregon Prescription Drug Assistance">
		<cfelseif queryContent.state_id eq 'pa'>
			<cfset spap_text = "PACE or PACENET (Pharmaceutical Assistance Contract for the Elderly)">
		<cfelseif queryContent.state_id eq 'ri'>
			<cfset spap_text = "Rhode Island Pharmaceutical Assistance to the Elderly (RIPAE)">
		<cfelseif queryContent.state_id eq 'vt'>
			<cfset spap_text = "VPharm or Healthy Vermonters">
		<cfelseif queryContent.state_id eq 'wa'>
			<cfset spap_text = "Washington Prescription Drug Program">
		<cfelseif queryContent.state_id eq 'wi'>
			<cfset spap_text = "Wisconsin SeniorCare (State Pharmacy Assistance Program)">
		<cfelse>
			<cfset spap_text = "SPAP">
		</cfif>

		<cfif queryContent.state_id eq 'ma'>
			<cfset med_text = "MassHealth">
		<cfelseif queryContent.state_id eq 'me'>
			<cfset med_text = "MaineCare">
		<cfelseif queryContent.state_id eq 'ky'>
			<cfset med_text = "KyHealth Choices">
		<cfelseif queryContent.state_id eq 'ct'>
			<cfset med_text = "Husky C">
		<cfelseif queryContent.state_id eq 'mo'>
			<cfset med_text = "HealthNet">
		<cfelseif queryContent.state_id eq 'wi'>
			<cfset med_text = "ForwardHealth Plan">
		<cfelseif queryContent.state_id eq 'wy'>
			<cfset med_text = "EqualityCare">
		<cfelseif queryContent.state_id eq 'az'>
			<cfset med_text = "AHCCCS">
		<cfelseif queryContent.state_id eq 'tn'>
			<cfset med_text = "TennCare">
		<cfelseif queryContent.state_id eq 'il'>
			<cfset med_text = "Medical Assistance">
		<cfelseif queryContent.state_id eq 'pa'>
			<cfset med_text = "Medical Assistance">
		<cfelseif queryContent.state_id eq 'ca'>
			<cfset med_text = "Medi-Cal">
		<cfelse>
			<cfset med_text = "Medicaid">
		</cfif>


		<cfset post_content = querySAFS.post_content>	
		<cfset post_content = ReplaceNoCase(post_content, '{medicaid_nm}', med_text, "ALL")>
		<cfset post_content = ReplaceNoCase(post_content, '{spap_nm}', spap_text, "ALL")>
		<cfset Temp = QuerySetCell(queryContent, "post_title", "#querySAFS.post_title#",x)>
    		<cfset Temp = QuerySetCell(queryContent, "report_content", "#post_content#",x)>
	</cfloop>


        <cfreturn  queryContent>
    	</cffunction>


	<cffunction access="remote" name="viewArchivedReports"  output="false" returntype="query"  hint="returns Listing of links to archived html based user report content.If date params are provided input partner_session_id as empty string, else date params..." >
		<cfargument name="partner_id" type="string" required="yes" >
		<cfargument name="partner_session_id" type="string" required="yes" >
		<cfargument name="start_date" type="string" required="yes" >
		<cfargument name="end_date" type="string" required="yes" >
		<cfquery name="queryUserScreenings" datasource="#application.dbSrc#">
			Select screening_id,subset_id, prev_screening_id from screening
			where partner_id = 142 
			<cfif partner_session_id neq ''>
			and client_id eq '#partner_session_id#'
			<cfelseif start_date neq '' and end_date neq ''>
			and start_datetime >= '#start_date#' and end_datetime <= '#end_date#'
			</cfif>
			and (subset_id = 83 or subset_id = 67)
			limit 500
		</cfquery>		
		<cfset rownum = 0>
		<cfset queryLinks = QueryNew("screening_id, questionnaire_link")>
		<cfloop query="queryUserScreenings">
			<cfset rownum = rownum + 1>
			 <cfset temp = QueryAddRow(queryLinks)> 
  			<cfset result = #QuerySetCell(queryLinks, "screening_id",queryUserScreenings.screening_id,rownum)#>
			<cfif queryUserScreenings.subset_id eq 83>
				<cfset result = QuerySetCell(queryLinks, "questionnaire_link","http://www.economiccheckup.org/eversafe-quickcheck-report/?subset_id=83&partner_id=142&screeningID=#queryUserScreenings.screening_id#&shadowID=#queryUserScreenings.screening_id#&eversafe_read_only=true",#rownum#)>
			<cfelseif queryUserScreenings.subset_id eq 67>
				<cfset result = QuerySetCell(queryLinks, "questionnaire_link","http://www.economiccheckup.org/esi-results-eversafe/?subset_id=83&partner_id=142&screeningID=#queryUserScreenings.prev_screening_id#&shadowID=#queryUserScreenings.screening_id#&eversafe_read_only=true",#rownum#)>
			</cfif>
		</cfloop>
		<cfreturn queryLinks>	
	</cffunction>
	<cffunction access="remote" name="viewCompletedQuestionnaires"   output="false" returntype="query"  hint="returns Listing of screenings and links to associated completed anonymous questionnaires. These are prefilled version of the full ESI assessment.If date params are provided input partner_session_id as empty string, else date params... " >
		<cfargument name="partner_id" type="string" required="yes" >
		<cfargument name="partner_session_id" type="string" required="yes" >
		<cfargument name="start_date" type="string" required="yes" >
		<cfargument name="end_date" type="string" required="yes" >
		<cfquery name="queryUserScreenings" datasource="#application.dbSrc#">
			Select screening_id from screening
			where partner_id = 142 
			<cfif partner_session_id neq ''>
			and client_id eq '#partner_session_id#'
			<cfelseif start_date neq '' and end_date neq ''>
			and start_datetime >= '#start_date#' and end_datetime <= '#end_date#'
			</cfif>
			and subset_id = 63
			limit 500
		</cfquery>		
		<cfset rownum = 0>
		<cfset queryLinks = QueryNew("screening_id, questionnaire_link")>
		<cfloop query="queryUserScreenings">
			<cfset rownum = rownum + 1>
			 <cfset temp = QueryAddRow(queryLinks)> 
  			<cfset result = #QuerySetCell(queryLinks, "screening_id",queryUserScreenings.screening_id,rownum)#>
			<cfset result = QuerySetCell(queryLinks, "questionnaire_link","http://www.economiccheckup.org/esi-questions-eversafe/?screeningID=#queryUserScreenings.screening_id#&eversafe_read_only=true",#rownum#)>
		</cfloop>
		<cfreturn queryLinks>
	</cffunction>
</cfcomponent>

