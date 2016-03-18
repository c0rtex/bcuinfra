<!-- This script takes an input xml file from the screenforbenefits.cfc parses the xml and passes the variables into the bcu screening--> <!-- Try and Catch all processing errors --> 
<cfparam name="testresponse" default="0">
<cfparam name="request.partner_id" default="14">
<cfparam name="request.client_id" default="0">
<cfparam name="request.org_id" default="0">
<cfparam name="request.partner_screening_id" default="">
<cfparam name="request.campaign_id" default="">
<cfparam name="program_xml" default="">
<cfparam name="request.prg_list" default="">
<cfparam name="request.debug" type="boolean"  default="false">
<cfset request.debug = "false">
<!-- set AEP subset to 72 for open enrollment 86 otherwise -->
<cfset application.AEP_subset = 86>
<cfset application.chicagovars = structnew()>
<!-- default test parameter xml string -->
<cfif testresponse and not isdefined('response_list')>
<cfset xmlstring = '
<?xml version="1.0" encoding="utf-16"?>
<ScreeningSet>
<Screening Subset_id="83">
<Answer AnswerField="esi_zip" AnswerValue="60606" ></Answer>
<Answer AnswerField="esi_category_retirement_planning" AnswerValue="y" ></Answer>
<Answer AnswerField="esi_category_money_management" AnswerValue="y" ></Answer>
<Answer AnswerField="esi_category_homeowner_resources" AnswerValue="y" ></Answer>
<Answer AnswerField="esi_category_consumer_protection" AnswerValue="y" ></Answer>
<Answer AnswerField="esi_category_legal_resources" AnswerValue="y" ></Answer>
<Answer AnswerField="subset_id" AnswerValue="83" ></Answer>
</Screening>
</ScreeningSet>
' > 
</cfif>

<cfset response_set = structnew()>
<cfset form = structnew()>
<cfif isdefined('response_list')>
	<cfset xmlstring = response_list >
</cfif>
<cfset application.response_list = xmlstring >
<cfset xmlstring = #replacenocase(xmlstring,'<?xml version="1.0" encoding="utf-16"?>','','ALL')#>
<cfset xmlstring = #replacenocase(xmlstring,'<Answers>','','ALL')#>
<cfset xmlstring = #replacenocase(xmlstring,'</Answers>','','ALL')#>
<cfset structRemoteVars = #xmlparse(xmlstring)#>
<cfset countScreenings = structcount(structRemoteVars.ScreeningSet) >
<cfif request.debug><cfoutput>Screening count #countScreenings#</cfoutput></cfif>
	<cfif not isdefined('resultset')>
		<cfset resultset = QueryNew("screening_id,partner_screening_id,partner_id,campaign_id, org_id,subset_id,client_id,report_url,validation_error,program_list,screening_status,reentry_number,date_time,program_title,state_id","integer,integer,integer,varchar,integer,integer,varchar,varchar,varchar,varchar,varchar,integer,date,varchar,varchar")>
	</cfif>
	<cfset newRow = #QueryAddRow(resultset, countScreenings)#>
<cfloop from="1" index="x" to="#countScreenings#">
	<cfset rownum = x >
	<cfset CountAnswers = structcount(structRemoteVars.ScreeningSet.Screening[x]) > 
	<cfset structBCUvars[#x#] = structnew()>
	
	<cfset current_subset_id = #structRemoteVars.ScreeningSet.screening[x].XmlAttributes.Subset_ID#>
	<csset request.subset_id = current_subset_id>
	<cfif request.debug><cfoutput>Answer count #CountAnswers#</cfoutput></cfif>

	<cfloop from="1" index="i" to="#CountAnswers#">
	 <cfif structRemoteVars.ScreeningSet.screening[x].Answer[i].XmlAttributes.AnswerField neq "client">
		<cfset results = #structinsert(structBCUvars[#x#], structRemoteVars.ScreeningSet.screening[x].Answer[i].XmlAttributes.AnswerField,structRemoteVars.ScreeningSet.screening[x].Answer[i].XmlAttributes.AnswerValue)#>
	 </cfif>	
	</cfloop>

	<!--- cfdump var="#structBCUvars[x]#" label="#current_subset_id#" ---> 
	

	<!--- Set the default values of the cells in the query --->
      <cfset temp = #QuerySetCell(resultset, "screening_id", "0", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "partner_id", request.partner_id, rownum)#>
      <cfset temp = #QuerySetCell(resultset, "partner_screening_id", request.partner_screening_id, rownum)#>
      <cfset temp = #QuerySetCell(resultset, "org_id", request.org_id, rownum)#>
      <cfset temp = #QuerySetCell(resultset, "subset_id", current_subset_id, rownum)#>
      <cfset temp = #QuerySetCell(resultset, "client_id", request.client_id, rownum)#>
      <cfset temp = #QuerySetCell(resultset, "report_url", "", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "validation_error", "", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "program_list", "", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "screening_status", "Unexpected Error", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "reentry_number", "", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "date_time", now(), rownum)#>
      <cfset temp = #QuerySetCell(resultset, "program_title","", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "state_id","", rownum)#>
<cfset AFList = "">
<cfset response_set = #structBCUvars[x]#>
<!-- Do screening --> 
<cfset request.subset_id = current_subset_id> 
<cfset request.USER_ID = "null" > 
<!-- default demo org id -->
<cfparam name="url.org_id" default="#request.org_id#" > 
<!-- partner --> 
<cfset url.PARTNER_ID = request.partner_id > 
<cfset url.test_ID = testresponse> 
<!-- Web Service Source --> 
<cfset request.SOURCE_ID = "8"> 

<!-- getRadioMappings --> 
<cfquery name="radio_mapping" datasource="#application.dbSrc#">
SELECT
questiontype.`code`,
subset_question.subset_id,
question.question_id,
answerfield.answerfield_id,
answerfield.answerfieldtype_id,
answerfield.answerfield,
question.question_code
FROM
subset_question
INNER JOIN question ON subset_question.question_id = question.question_id
INNER JOIN questiontype ON questiontype.questiontype_id = question.questiontype_id
INNER JOIN question_answerfield ON question.question_id = question_answerfield.question_id
INNER JOIN answerfield ON question_answerfield.answerfield_id = answerfield.answerfield_id
WHERE subset_question.subset_id = #request.subset_id#
and questiontype.code = 'radio'
order by question_code, answerfield
</cfquery>
<cfdump var="#radio_mapping#">
<cfset next_question_code = ''>
<cfloop query="radio_mapping">
<cfif next_question_code neq question_code>
<cfoutput>not evaluated as 'response_set.#question_code#':</cfoutput><Br><br>	
<cfif isdefined('response_set.#question_code#')>
	<cfoutput>This evaluated as #evaluate('response_set.#question_code#')#:</cfoutput><Br><br>
	<cfset newval = #evaluate('response_set.#question_code#')#>
	<cfset #newval# = 'y'>
</cfif>
</cfif>
<cfset next_question_code = radio_mapping.question_code>
<cfif next_question_code eq question_code>
	<cfoutput>#question_code# #answerfield#</cfoutput><Br><br>
	<cfif not isdefined('response_set.#question_code#')>
	<cfset 'response_set.#answerfield#' = ''>
</cfif>
</cfif>
</cfloop>
<cfparam name="response_set.esi_category_health_resources" default="">
	<cfparam name="response_set.esi_rxhelp" default="">

<cfif current_subset_id eq 79>
	<cfparam name="response_set.mqc_medicare_enroll_disability_no" default="">
	<cfparam name="response_set.mqc_medicare_enroll_disability_yes" default="">
	<cfparam name="response_set.mqc_medicare_enroll_within_1_year_yes" default="">
	<cfparam name="response_set.mqc_medicare_enroll_within_1_year_no" default="">
	<cfparam name="response_set.mqc_medicare_enroll_benefits_advisor" default="">
	<cfparam name="response_set.mqc_medicare_enroll_age_65" default="">
	<cfparam name="response_set.MQC_NOT_SURE_MEDICARE_QUALIFY" default=""> 
	<cfif isdefined('response_set.mqc_medicare_enroll_situation')>
	<cfif response_set.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_within_1_year_yes'>
		<cfset response_set.mqc_medicare_enroll_within_1_year_yes = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_disability_no'>
		<cfset response_set.mqc_medicare_enroll_disability_no = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_disability_yes'>
		<cfset response_set.mqc_medicare_enroll_disability_yes = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_disability_no'>
		<cfset response_set.mqc_medicare_enroll_disability_no = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_age_65'>
		<cfset response_set.mqc_medicare_enroll_age_65 = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_benefits_advisor'>
		<cfset response_set.mqc_medicare_enroll_benefits_advisor = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_situation eq 'mqc_not_sure_medicare_qualify'>
		<cfset response_set.mqc_not_sure_medicare_qualify = 'y'>
	</cfif>
	</cfif>
	<cfset request.next_subset_id = 85>
	<cfif response_set.mqc_medicare_enroll_disability_yes eq 'y' or response_set.mqc_medicare_enroll_age_65 eq 'y'>
		<cfset request.next_subset_id = application.AEP_subset>
	<cfelseif response_set.mqc_medicare_enroll_within_1_year_yes  eq 'y' or response_set.mqc_medicare_enroll_disability_no eq 'y'>
		<cfset request.next_subset_id = 75>
	<cfelseif response_set.mqc_medicare_enroll_within_1_year_no  eq 'y' >
		<cfset request.next_subset_id = 85>
	<cfelseif response_set.mqc_not_sure_medicare_qualify eq 'y' and response_set.mqc_work_soc_sec_10yrs_40qtrs neq 'y'>
		<cfset request.next_subset_id = 85>
	<cfelseif response_set.mqc_medicare_enroll_benefits_advisor   eq 'y' >
		<cfset request.next_subset_id = 74>
	</cfif>
<cfelseif current_subset_id eq 80>
<cfparam name="response_set.MQC_ENROLLED_MEDICARE_UNDER_65_DISABLED" default="">
<cfparam name="response_set.MQC_ENROLLED_SNP" default="">
<cfparam name="response_set.DOB"  default="">
<cfparam name="response_set.MQC_GOVBEN"  default="">
<cfparam name="response_set.MQC_LIVENURSINGFACILITY"  default="">
<cfparam name="response_set.MQC_ALS"  default="">
<cfparam name="response_set.mqc_live_outside_us"  default="">
<cfparam name="response_set.MQC_PRISON"  default=""> 
<cfelseif current_subset_id eq 75 or current_subset_id eq 72 or current_subset_id eq 74 or current_subset_id eq 85 or current_subset_id eq 86 >
<cfif current_subset_id eq 72 or current_subset_id eq 74 or current_subset_id eq 85 or current_subset_id eq 86 >
<!--- Process Report from wordpress page questionnaire --->
<cfif isdefined('form.mqc_medicare_enroll')>
	<cfif form.mqc_medicare_enroll eq 'mqc_medicare_enroll_past_3_months'>
		<cfset form.mqc_medicare_enroll_past_3_months = 'y'>
	</cfif>
</cfif>
<cfif isdefined('form.mqc_medicare_enroll_no')>
	<cfif form.mqc_medicare_enroll_no eq 'mqc_medicare_enroll_within_3_months'>
		<cfset form.mqc_medicare_enroll_within_3_months = 'y'>
	<cfelseif form.mqc_medicare_enroll_no eq 'mqc_medicare_enroll_within_1_year_no'>
		<cfset form.mqc_medicare_enroll_within_1_year_no = 'y'>
	<cfelseif form.mqc_medicare_enroll_no eq 'mqc_medicare_enroll_within_1_year_yes'>
		<cfset form.mqc_medicare_enroll_within_1_year_yes = 'y'>
	</cfif>
</cfif>
</cfif>
<!--- MQC 75 Mapping --->
<!--- Process Report from wordpress page questionnaire --->
<cfparam name="response_set.DOB"  default="">
<cfif isdefined('response_set.mqc_medicare_enroll')>
	<cfif response_set.mqc_medicare_enroll eq 'mqc_medicare_enroll_past_3_months'>
		<cfset response_set.mqc_medicare_enroll_past_3_months = 'y'>
	</cfif>
</cfif>
<cfif isdefined('response_set.mqc_medicare_enroll_no')>
	<cfif response_set.mqc_medicare_enroll_no eq 'mqc_medicare_enroll_within_3_months'>
		<cfset response_set.mqc_medicare_enroll_within_3_months = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_no eq 'mqc_medicare_enroll_within_1_year_no'>
		<cfset response_set.mqc_medicare_enroll_within_1_year_no = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_no eq 'mqc_medicare_enroll_within_1_year_yes'>
		<cfset response_set.mqc_medicare_enroll_within_1_year_yes = 'y'>
	</cfif>
</cfif>
<cfif isdefined('response_set.mqc_medicare_enroll_situation')>
	<cfif response_set.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_within_1_year_yes'>
		<cfset response_set.mqc_medicare_enroll_within_1_year_yes = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_disability_yes'>
		<cfset response_set.mqc_medicare_enroll_disability_yes = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_disability_no'>
		<cfset response_set.mqc_medicare_enroll_disability_no = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_age_65'>
		<cfset response_set.mqc_medicare_enroll_age_65 = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_situation eq 'mqc_not_sure_medicare_qualify'>
		<cfset response_set.mqc_not_sure_medicare_qualify = 'y'>
	<cfelseif response_set.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_benefits_advisor'>
		<cfset response_set.mqc_medicare_enroll_benefits_advisor = 'y'>
	</cfif>
</cfif>

	<cfparam name="response_set.MQC_GROUP_INSURANCE_SELF" default="">
	<cfparam name="response_set.MQC_GROUP_INSURANCE_SPOUSE" default="">
	<cfparam name="response_set.MQC_PLANDISCONTINUED" default="">
	<cfparam name="response_set.MQC_COSTSMINORPROBLEM" default="">
	<cfparam name="response_set.MQC_COSTSNOTPROBLEM" default="">
	<cfparam name="response_set.MQC_MEDICARE_ENROLL_AGE_65" default="">
	<cfparam name="response_set.MQC_RECEIVINGPARTA" default="">
	<cfparam name="response_set.MQC_RECEIVINGPARTB" default="">
	<cfparam name="response_set.MQC_RECEIVINGPARTC" default="">
	<cfparam name="response_set.MQC_EMPLOYER_MONEY" default="">
	<cfparam name="response_set.MQC_MEDHEALTHPLAN" default="">
<cfparam name="response_set.mqc_healthneedschange"  default="">
<cfparam name="response_set.MQC_DONTKNOWCOVERAGE"  default="">
<cfparam name="response_set.MQC_JUSTENROLLED"  default="">
<cfparam name="response_set.MQC_MOVING"  default="">
<cfparam name="response_set.MQC_LIFESTYLE"  default="">
<cfparam name="response_set.MQC_TROUBLEACCESSINGCARE"  default="">
<cfparam name="response_set.MQC_ORIGINALMEDICARE"  default="">
<cfparam name="response_set.mqc_health_insurance_aep"  default="">
<cfparam name="response_set.mqc_health_insurance_type_aep"  default="">
<cfparam name="response_set.mqc_number_employees_self_aep"  default="">
<cfparam name="response_set.mqc_number_employees_spouse_aep"  default="">
<cfparam name="response_set.mqc_retiree_plan"  default="">
<cfparam name="response_set.mqc_health_ins_creditable_aep"  default="">
<cfparam name="response_set.mqc_health_insurance_cover_aep"  default="">
<cfparam name="response_set.mqc_circumstance_aep"  default="">
<cfparam name="response_set.mqc_receive_hsa_aep"  default="">
<cfparam name="response_set.mqc_health_insurance_ahn"  default="">
<cfparam name="response_set.mqc_health_insurance_type_ahn"  default="">
<cfparam name="response_set.mqc_number_employees_self_ahn"  default="">
<cfparam name="response_set.mqc_number_employees_spouse_ahn"  default="">
<cfparam name="response_set.mqc_health_ins_creditable_ahn"  default="">
<cfparam name="response_set.mqc_health_insurance_cover_ahn"  default="">
<cfparam name="response_set.mqc_receive_hsa_ahn"  default="">
<cfparam name="response_set.mqc_circumstance_ahn"  default="">
<cfparam name="response_set.MQC_MEDICARE_ENROLL_DISABILITY_NO"  default="">

<cfparam name="response_set.MQC_EMPLOYER_CHOOSE"  default="">
<cfparam name="response_set.MQC_SITUATIONPLANNER"  default="">
<cfparam name="response_set.MQC_SITUATIONHAPPY"  default="">
<cfparam name="response_set.MQC_RECEIVINGSNP" default="">
<cfparam name="response_set.MQC_COSTSBIGPROBLEM" default="">
<cfparam name="response_set.MQC_COSTSMODPROBLEM" default="">
<cfparam name="response_set.MQC_RECEIVE_HSA" default="">
<cfparam name="response_set.MQC_HEALTH_INSURANCE" default="">
<cfparam name="response_set.satisfied_yes"  default="">
<cfparam name="response_set.satisfied_no"  default="">
<cfparam name="response_set.mqc_employees_lt_20_self"  default="">
<cfparam name="response_set.mqc_employees_gt_20_self"  default="">
<cfparam name="response_set.mqc_employees_gt_100_self"  default="">
<cfparam name="response_set.mqc_employees_dont_know"  default="">
<cfparam name="response_set.mqc_employees_lt_20_spouse"  default="">
<cfparam name="response_set.mqc_employees_gt_20_spouse"  default="">
<cfparam name="response_set.mqc_employees_gt_100_spouse"  default="">
<cfparam name="response_set.mqc_employees_dont_know_spouse"  default="">
<cfparam name="response_set.MQC_RECEIVINGRRB"  default="">
<cfparam name="response_set.MQC_RECEIVING_SSI_RETIREMENT"  default="">
<cfparam name="response_set.MQC_BELONGMSP"  default="">
<cfparam name="response_set.MQC_RECEIVING_SSI_RETIREMENT"  default="">
<cfparam name="response_set.MQC_RECVETBEN"  default="">
<cfparam name="response_set.MQC_RECEIVEPARTD"  default="">
<cfparam name="response_set.MQC_PRISON"  default="">
<cfparam name="response_set.MQC_RECEIVINGTRICARE"  default="">
<cfparam name="response_set.MQC_GOVBEN"  default="">
<cfparam name="response_set.MQC_I_CHOOSE"  default="">
<cfparam name="response_set.MQC_SITUATIONCONFIDENT"  default="">
<cfparam name="response_set.MQC_SITUATIONOVERWHELMED"  default="">
<cfparam name="response_set.MQC_SITUATIONCHALLENGE"  default="">
<cfparam name="response_set.MQC_MEDICARE"  default="">
<cfparam name="response_set.MQC_SMALL_EMPLOYER"  default="">
<cfparam name="response_set.MQC_LARGE_EMPLOYER"  default="">
<cfparam name="response_set.MQC_SITUATIONMEDICARE"  default="">
<cfparam name="response_set.MQC_LIVE_OUTSIDE_US"  default="">
<cfparam name="response_set.MQC_RECEIVINGPARB"  default="">
<cfparam name="response_set.MQC_NOT_ELIGIBLE_PARTA"  default="">
<cfparam name="response_set.MQC_MEDICARE_ENROLL_DISABILITY_YES"  default="">
<cfparam name="response_set.mqc_medicare_enroll_benefits_advisor"  default="">
<cfparam name="response_set.MQC_INDIVIDUAL_INSURANCE"  default="">	    
<cfparam name="response_set.MQC_COBRA"  default="">
<cfparam name="response_set.MQC_FORMER_EMPLOYER_RETIREE_BENEFIT"  default="">
<cfparam name="response_set.MQC_INSURANCE_NOT_LISTED"  default="">
<cfparam name="response_set.MQC_RENALDISEASE"  default="">
 <cfparam name="response_set.MQC_ALS"  default="">
 <cfparam name="response_set.MQC_LIVENURSINGFACILITY"  default="">
 <cfparam name="response_set.MQC_INDIVIDUAL_INSURANCE"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID"  default="">
 <cfparam name="response_set.REC_AK_SENIORBENEFITS"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID"  default="">
<cfparam name="response_set.MQC_RECEIVING_SSI"  default="">
 <cfparam name="response_set.MQC_RECEIVING_SSDI"  default="">
 <cfparam name="response_set.MQC_RECEIVINGLIS"  default="">
 <cfparam name="response_set.MQC_HELPMEDICAID_AZ"  default="">
 <cfparam name="response_set.REC_DE_DPA"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID_CA"  default="">
<cfparam name="response_set.REC_DE_DPAP"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID_CT"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID_IL"  default="">
<cfparam name="response_set.REC_IN_HOOSIERRX"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID_KY"  default="">
<cfparam name="response_set.REC_MA_PRESCRIPTIONADVANTAGE"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID_MA"  default="">
<cfparam name="response_set.REC_MD_SPDAP"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID_ME"  default="">
<cfparam name="response_set.REC_ME_DEL_AND_RXPLUS"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID_MO"  default="">
<cfparam name="response_set.REC_MO_RXPLAN"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID_PA"  default="">
<cfparam name="response_set.REC_MT_BIGSKYRX"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID_TN"  default="">
<cfparam name="response_set.REC_NJ_PAAD"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID_WI"  default="">
<cfparam name="response_set.REC_NV_SENIORRX"  default="">
<cfparam name="response_set.MQC_HELPMEDICAID_WY"  default="">
<cfparam name="response_set.REC_NY_EPIC"  default="">
<cfparam name="response_set.REC_OR_PDAP_2"  default="">
<cfparam name="response_set.MQC_INCOME_RANGE1"  default="">
<cfparam name="response_set.REC_PA_PACE_PACENET"  default="">
<cfparam name="response_set.MQC_INCOME_RANGE2"  default="">
<cfparam name="response_set.MQC_INCOME_RANGE3"  default="">
<cfparam name="response_set.REC_RI_RIPAE"  default="">
<cfparam name="response_set.REC_VT_VPHARM_AND_HEALTHYVERMONTERS"  default="">
<cfparam name="response_set.MQC_INCOME_UNDER"  default="">
<cfparam name="response_set.MQC_INCOME_OVER"  default="">
<cfparam name="response_set.REC_WA_PDP"  default="">
<cfparam name="response_set.REC_WI_SENIORCARE "  default="">
<cfparam name="response_set.MQC_INCOME_RETIRE_RANGE1"  default="">
<cfparam name="response_set.MQC_INCOME_RETIRE_RANGE2"  default="">
<cfparam name="response_set.MQC_INCOME_RETIRE_RANGE3"  default="">
<cfparam name="response_set.MQC_INCOME_RETIRE_UNDER"  default="">
<cfparam name="response_set.MQC_MEDICARE_ENROLL_WITHIN_1_YEAR_YES"  default="">
<cfparam name="response_set.MQC_MEDICARE_ENROLL_BENEFITS_ADVISOR"  default="">
<cfparam name="response_set.MQC_CHAMPVA"  default="">
<cfif isdefined('response_set.mqc_situationmedicare')>
	<cfif response_set.mqc_situationmedicare eq  'mqc_situationmedicare_madedecision'>
		<cfset response_set.mqc_situationmedicare_madedecision = "y">
	<cfelseif response_set.mqc_situationmedicare eq 'mqc_situationmedicare_prettysure'>
		<cfset response_set.mqc_situationmedicare_prettysure = "y">
        <cfelseif response_set.mqc_situationmedicare eq 'mqc_situationmedicare_talkpartd'>
		<cfset response_set.mqc_situationmedicare_talkpartd = "y">
	<cfelseif response_set.mqc_situationmedicare eq 'mqc_situationmedicare_heedhelp'>
		<cfset response_set.mqc_situationmedicare_heedhelp = "y">
	<cfelseif response_set.mqc_situationmedicare eq 'mqc_situationmedicare_noneabove'>
		<cfset response_set.mqc_situationmedicare_noneabove = "y">
	<cfelseif response_set.mqc_situationmedicare eq 'mqc_situationmedicare_talkadvisor'>
		<cfset response_set.mqc_situationmedicare_talkadvisor = "y">
	</cfif>
</cfif>

<cfif isdefined('response_set.mqc_coveragesatisfaction_2')>
	<cfif response_set.mqc_coveragesatisfaction_2 eq 'satisfied_yes'>
		<cfset response_set.satisfied_yes = "y">
	<cfelseif response_set.mqc_coveragesatisfaction_2 eq 'satisfied_no'>
		<cfset response_set.satisfied_no = "y">
	</cfif>
</cfif> 
<cfif isdefined('response_set.mqc_coveragesatisfaction')>
	<cfif response_set.mqc_coveragesatisfaction eq 'satisfied_yes'>
		<cfset response_set.satisfied_yes = "y">
	<cfelseif response_set.mqc_coveragesatisfaction eq 'satisfied_no'>
		<cfset response_set.satisfied_no = "y">
	</cfif>
</cfif>
<cfif isdefined('response_set.mqc_number_employees_self')>
	<cfif response_set.mqc_number_employees_self eq 'mqc_employees_lt_20_self'>
		<cfset response_set.mqc_employees_lt_20_self = "y">
	<cfelseif response_set.mqc_number_employees_self eq 'mqc_employees_gt_20_self'>
		<cfset response_set.mqc_employees_gt_20_self = "y">
	<cfelseif response_set.mqc_number_employees_self eq 'mqc_employees_gt_100_self'>
		<cfset response_set.mqc_employees_gt_100_self = "y">
        <cfelseif response_set.mqc_number_employees_self eq 'mqc_employees_dont_know'>
		<cfset response_set.mqc_employees_dont_know = "y">
	</cfif>
</cfif>
<cfif isdefined('response_set.mqc_number_employees_spouse')>
	<cfif response_set.mqc_number_employees_spouse eq 'mqc_employees_lt_20_spouse'>
		<cfset response_set.mqc_employees_lt_20_spouse = "y">
	<cfelseif response_set.mqc_number_employees_spouse eq 'mqc_employees_gt_20_spouse'>
		<cfset response_set.mqc_employees_gt_20_spouse = "y">
	<cfelseif response_set.mqc_number_employees_spouse eq 'mqc_employees_gt_100_spouse'>
		<cfset response_set.mqc_employees_gt_100_spouse = "y">
        <cfelseif response_set.mqc_number_employees_spouse eq 'mqc_employees_dont_know_spouse'>
		<cfset response_set.mqc_employees_dont_know_spouse = "y">
	</cfif>
</cfif>

<cfif isdefined('response_set.mqc_number_employees_self_aep')>
	<cfif response_set.mqc_number_employees_self_aep eq 'mqc_employees_lt_20_self'>
		<cfset response_set.mqc_employees_lt_20_self = "y">
	<cfelseif response_set.mqc_number_employees_self_aep eq 'mqc_employees_gt_20_self'>
		<cfset response_set.mqc_employees_gt_20_self = "y">
	<cfelseif response_set.mqc_number_employees_self_aep eq 'mqc_employees_gt_100_self'>
		<cfset response_set.mqc_employees_gt_100_self = "y">
        <cfelseif response_set.mqc_number_employees_self_aep eq 'mqc_employees_dont_know'>
		<cfset response_set.mqc_employees_dont_know = "y">
	</cfif>
</cfif>
<cfif isdefined('response_set.mqc_number_employees_spouse_aep')>
	<cfif response_set.mqc_number_employees_spouse_aep eq 'mqc_employees_lt_20_spouse'>
		<cfset response_set.mqc_employees_lt_20_spouse = "y">
	<cfelseif response_set.mqc_number_employees_spouse_aep eq 'mqc_employees_gt_20_spouse'>
		<cfset response_set.mqc_employees_gt_20_spouse = "y">
	<cfelseif response_set.mqc_number_employees_spouse_aep eq 'mqc_employees_gt_100_spouse'>
		<cfset response_set.mqc_employees_gt_100_spouse = "y">
        <cfelseif response_set.mqc_number_employees_spouse_aep eq 'mqc_employees_dont_know_spouse'>
		<cfset response_set.mqc_employees_dont_know_spouse = "y">
	</cfif>
</cfif>
<cfif isdefined('response_set.mqc_number_employees_self_ahn')>
	<cfif response_set.mqc_number_employees_self_ahn eq 'mqc_employees_lt_20_self'>
		<cfset response_set.mqc_employees_lt_20_self = "y">
	<cfelseif response_set.mqc_number_employees_self_ahn eq 'mqc_employees_gt_20_self'>
		<cfset response_set.mqc_employees_gt_20_self = "y">
	<cfelseif response_set.mqc_number_employees_self_ahn eq 'mqc_employees_gt_100_self'>
		<cfset response_set.mqc_employees_gt_100_self = "y">
        <cfelseif response_set.mqc_number_employees_self_ahn eq 'mqc_employees_dont_know'>
		<cfset response_set.mqc_employees_dont_know = "y">
	</cfif>
</cfif>
<cfif isdefined('response_set.mqc_number_employees_spouse_ahn')>
	<cfif response_set.mqc_number_employees_spouse_ahn eq 'mqc_employees_lt_20_spouse'>
		<cfset response_set.mqc_employees_lt_20_spouse = "y">
	<cfelseif response_set.mqc_number_employees_spouse_ahn eq 'mqc_employees_gt_20_spouse'>
		<cfset response_set.mqc_employees_gt_20_spouse = "y">
	<cfelseif response_set.mqc_number_employees_spouse_ahn eq 'mqc_employees_gt_100_spouse'>
		<cfset response_set.mqc_employees_gt_100_spouse = "y">
        <cfelseif response_set.mqc_number_employees_spouse_ahn eq 'mqc_employees_dont_know_spouse'>
		<cfset response_set.mqc_employees_dont_know_spouse = "y">
	</cfif>
</cfif>
<cfif isdefined('response_set.mqc_medicarecoverage')>
	<cfif response_set.mqc_medicarecoverage eq 'mqc_originalmedicare'>
		<cfset response_set.mqc_originalmedicare = "y">
	<cfelseif response_set.mqc_medicarecoverage eq 'mqc_medhealthplan'>
		<cfset response_set.mqc_medhealthplan = "y">
	<cfelseif response_set.mqc_medicarecoverage eq 'mqc_justenrolled'>
		<cfset response_set.mqc_justenrolled = "y">
        <cfelseif response_set.mqc_medicarecoverage eq 'mqc_dontknowcoverage'>
		<cfset response_set.mqc_dontknowcoverage = "y">
	</cfif>
</cfif>

<cfif not isdefined('response_set.MQC_EMPLOYEES_LT_20_SELF')>
	<cfset response_set.MQC_EMPLOYEES_LT_20_SELF = "">
</cfif> 
<cfif not isdefined('response_set.MQC_EMPLOYEES_DONT_KNOW_SPOUSE')>
	<cfset response_set.MQC_EMPLOYEES_DONT_KNOW_SPOUSE = "">
</cfif> 
<cfif not isdefined('response_set.MQC_EMPLOYEES_DONT_KNOW')>
	<cfset response_set.MQC_EMPLOYEES_DONT_KNOW = "">
</cfif> 
<cfif not isdefined('response_set.MQC_NOT_RECEIVING_PARTA')>
	<cfset response_set.MQC_NOT_RECEIVING_PARTA = "">
</cfif> 
<cfif not isdefined('response_set.SATISFIED_NO')>
	<cfset response_set.SATISFIED_NO = "">
</cfif> 
<cfif not isdefined('response_set.MQC_HEALTH_INSURANCE_CREDITABLE')>
	<cfset response_set.MQC_HEALTH_INSURANCE_CREDITABLE = "">
</cfif>

</cfif>
<cfset request.sessionDetailsLogged = False> 
<cfif isdefined('response_set.zip') and response_set.zip neq ''>
  <cfset checkzip = response_set.zip>
<cfelseif isdefined('response_set.mqc_zip') and response_set.mqc_zip neq ''>
  <cfset checkzip = response_set.mqc_zip>
<cfelseif isdefined('response_set.mqc_zipcode') and response_set.mqc_zipcode neq ''>
  <cfset checkzip = response_set.mqc_zipcode>
<cfelseif isdefined('response_set.esi_zip') and response_set.esi_zip neq ''>
  <cfset checkzip = response_set.esi_zip>
<cfelse>
  <cfset checkzip = 0>
</cfif>
		<cfquery name="zipstate" datasource="#application.dbSrc#">
			select state_id
			from zip
			where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkzip#" maxlength="5">
				and valid=1
		</cfquery>
		<cfif zipstate.RecordCount>
			<cfset request.state_id = zipstate.state_id>
			<cfset request.st = zipstate.state_id>
			<cfset request.zip = checkzip>
		<cfelse>
			<cfset zip = ''>
			<cfset request.state_id = ''>
			<cfset request.st = ''>
		</cfif>


<cfif structkeyexists(structBCUvars[x],"dob")>
 	<cfset result = #structinsert(response_set,"dob_year",right(structBCUvars[x].dob,4))#>
 	<cfset result = #structinsert(response_set,"dob_month",left(structBCUvars[x].dob,1))#>
<cfelseif structkeyexists(structBCUvars[x],"dob_year")>
	<cfset response_set.DOB_MONTH = structBCUvars[x].DOB_MONTH> 
	<cfset response_set.DOB_YEAR = structBCUvars[x].DOB_YEAR> 
</cfif>
<cfif structkeyexists(structBCUvars[x],"sp_dob")>
 	<cfset result = #structinsert(response_set,"sp_dob_year",right(structBCUvars[x].dob,4))#>
 	<cfset result = #structinsert(response_set,"sp_dob_month",left(structBCUvars[x].dob,1))#>
<cfelseif structkeyexists(structBCUvars[x],"sp_dob_year")>
	<cfset response_set.sp_DOB_MONTH = structBCUvars[x].sp_DOB_MONTH> 
	<cfset response_set.sp_DOB_YEAR = structBCUvars[x].sp_DOB_YEAR> 
</cfif>
<cfif structkeyexists(structBCUvars[x],"city") and isdefined('zipstate.state_id')>
		<cfif zipstate.state_id neq "IL">
 			<cfset result = #structinsert(structBCUvars[x],"othercity",structBCUvars[x].city)#>
	 		<cfset result = StructDelete(structBCUvars[x],"city")>
		</cfif>
</cfif>
<cfif isdefined('checkzip') and checkzip neq 0 >
<cfinvoke  
    component="util" 
    method="getStateCountyFromZip" returnVariable = "locationdata" 
    > 
<cfinvokeargument name="zipcode" value="#checkzip#"/> 
</cfinvoke> 
	<cfset response_set.county = locationdata.county_name>
</cfif>


	<cf_screeningInsert prev_screening_id="" source_id="#request.source_id#" org_id="#request.org_id#" partner_id="#request.partner_id#" subset_id="#request.subset_id#" language_id="EN" access_id="" client_id="#request.client_id#" user_id="" preset_state_id="#request.state_id#" test_flag="#url.test_id#" var="outvar">
 	<cfset request.screening_id = outvar>
	<cfif request.debug><cfoutput>#request.screening_id#</cfoutput>
	<cfoutput>Pre -: #aflist#</cfoutput></cfif>
	<cfset aflist = "">
	<cfset x = 0>
	<cfloop collection="#response_set#" item="listvar">
	<cfset x = x + 1>
	<cfif listvar neq "client1" and listvar neq "state_id" and listvar neq "sent" and listvar neq "dob">
		<cfinvoke  
    component="util" 
    method="getAFListVar" returnVariable = "aflistvar" 
    > 
<cfinvokeargument name="answerfield" value="#listvar#"/> 
</cfinvoke> 
	</cfif>
	<cfif aflistvar neq "">
	<cfif x eq 1>
		<cfset aflist = aflistvar>
	<cfelse>
		<cfset aflist = aflist & "," & aflistvar >
	</cfif>
	</cfif>
	<cfset varvalue = #evaluate('response_set.#listvar#')#>
	<cfif varvalue eq '2346_separated'>
		<cfset 'response_set.#listvar#' = '2346-separated'>
	</cfif>
	<cfset firstchar = #left(varvalue,1)#>
	<cfif #isnumeric(firstchar)# and (#findnocase("-",varvalue)# eq 0)>
		<cfset varvalue = #replacenocase(varvalue,"_","-")#>
		<cfset 'response_set.#listvar#' = varvalue >
	</cfif>
	</cfloop>
	<cfif request.debug><cfoutput>post -: #aflist# <br> subset_id: #request.subset_id#</cfoutput></cfif>
  <!--- Insert questionnaire responses into screening_answerfield --->
<!--- set checkbox options from radios --->
<cfparam name="response_set.MQC_EMPLOYER_INSURANCE"  default="">
<cfif response_set.mqc_employer_insurance eq 'n'>
<cfparam name="response_set.mqc_retiree_plan" default="">
<cfparam name="response_set.mqc_employer_choose" default="">
<cfparam name="response_set.mqc_employer_money" default="">
<cfparam name="response_set.mqc_i_choose" default="">
</cfif>
<cfparam name="response_set.mqc_medicare_drug_plan" default="">
<cfparam name="response_set.mqc_medigap" default="">
<cfparam name="response_set.mqc_work_situation" default="">
<cfparam name="response_set.mqc_medicarecoverage" default="">
<cfparam name="response_set.mqc_outofpocket" default="">
<cfparam name="response_set.mqc_describesituation" default="">
<cfparam name="response_set.mqc_coveragesatisfaction" default="">
<cfparam name="response_set.mqc_plan_network_problem" default="">
<cfparam name="response_set.mqc_retiree_plan_select" default="">
<cfparam name="response_set.mqc_covers_healthcare_and_drugs" default="">
<cfparam name="response_set.mqc_covers_two_medicare_plans" default="">
<cfparam name="response_set.mqc_covers_healthcare_no_drugs" default="">

<cfif response_set.mqc_plan_network_problem eq 'mqc_plannetwork_bigproblem'>
	<cfset response_set.mqc_plannetwork_bigproblem  ="y">
</cfif>
<cfif response_set.mqc_plan_network_problem eq 'mqc_plannetwork_minorproblem'>
	<cfset response_set.mqc_large_employer  ="y">
</cfif>
<cfif response_set.mqc_plan_network_problem eq 'mqc_plannetwork_notproblem'>
	<cfset response_set.mqc_plannetwork_notproblem  ="y">
</cfif>

<cfif response_set.mqc_retiree_plan_select eq 'mqc_employer_money'>
	<cfset response_set.mqc_employer_money  ="y">
</cfif>
<cfif response_set.mqc_retiree_plan_select eq 'mqc_i_choose'>
	<cfset response_set.mqc_i_choose  ="y">
</cfif>
<cfif response_set.mqc_retiree_plan_select eq 'mqc_employer_choose'>
	<cfset response_set.mqc_employer_choose  ="y">
</cfif>

<cfif response_set.mqc_work_situation eq 'mqc_cobra'>
	<cfset response_set.mqc_cobra  ="y">
</cfif>
<cfif response_set.mqc_work_situation eq 'mqc_large_employer'>
	<cfset response_set.mqc_large_employer  ="y">
</cfif>
<cfif response_set.mqc_work_situation eq 'mqc_small_employer'>
	<cfset response_set.mqc_small_employer  ="y">
</cfif>

<cfif response_set.mqc_medicarecoverage eq 'mqc_originalmedicare'>
	<cfset response_set.mqc_originalmedicare  ="y">
</cfif>
<cfif response_set.mqc_medicarecoverage eq 'mqc_medhealthplan'>
	<cfset response_set.mqc_medhealthplan  ="y">
</cfif>
<cfif response_set.mqc_medicarecoverage eq 'mqc_justenrolled'>
	<cfset response_set.mqc_justenrolled  ="y">
</cfif>
<cfif response_set.mqc_medicarecoverage eq 'mqc_dontknowcoverage'>
	<cfset response_set.mqc_dontknowcoverage  ="y">
</cfif>


<cfif response_set.mqc_outofpocket eq 'mqc_costsbigproblem'>
	<cfset response_set.mqc_costsbigproblem  ="y">
</cfif>
<cfif response_set.mqc_outofpocket eq 'mqc_costsmodproblem'>
	<cfset response_set.mqc_costsmodproblem  ="y">
</cfif>
<cfif response_set.mqc_outofpocket eq 'mqc_costsminorproblem'>
	<cfset response_set.mqc_costsminorproblem  ="y">
</cfif>
<cfif response_set.mqc_outofpocket eq 'mqc_costsnotproblem'>
	<cfset response_set.mqc_costsnotproblem  ="y">
</cfif>

<cfif response_set.mqc_describesituation eq 'mqc_situationchallenge'>
	<cfset response_set.mqc_situationchallenge  ="y">
</cfif>
<cfif response_set.mqc_describesituation eq 'mqc_situationconfident'>
	<cfset response_set.mqc_situationconfident  ="y">
</cfif>

<cfif response_set.mqc_describesituation eq 'mqc_situationhappy'>
	<cfset response_set.mqc_situationhappy  ="y">
</cfif>
<cfif response_set.mqc_describesituation eq 'mqc_situationoverwhelmed'>
	<cfset response_set.mqc_situationoverwhelmed  ="y">
</cfif>
<cfif response_set.mqc_describesituation eq 'mqc_situationplanner'>
	<cfset response_set.mqc_situationplanner  ="y">
</cfif>
<cfif response_set.mqc_describesituation eq 'mqc_situation_noneofabove'>
	<cfset response_set.mqc_situation_noneofabove  ="y">
</cfif>	





<!-- mqc_income -->
<cfif not isdefined('response_set.mqc_income')>
      <cfset response_set.mqc_income = 'mqc_income_under'>
      <cfset response_set.mqc_income_under  ="y">
</cfif>
<cfif response_set.mqc_income eq 'mqc_income_over'>
	<cfset response_set.mqc_income_over  ="y">
</cfif>
<cfif response_set.mqc_income eq 'mqc_income_range1'>
	<cfset response_set.mqc_income_range1  ="y">
</cfif>
<cfif response_set.mqc_income eq 'mqc_income_range2'>
	<cfset response_set.mqc_income_range2 ="y">
</cfif>
<cfif response_set.mqc_income eq 'mqc_income_range3'>
	<cfset response_set.mqc_income_range3  ="y">
</cfif>
<cfif response_set.mqc_income eq 'mqc_income_under'>
	<cfset response_set.mqc_income_under  ="y">
</cfif>

<cfif not isdefined('response_set.mqc_income_retired')>
      <cfset response_set.mqc_income_retired = 'mqc_income_under'>
      <cfset response_set.mqc_income_retire_under  ="y">
</cfif>
<cfif response_set.mqc_income_retired eq 'mqc_income_retire_over'>
	<cfset response_set.mqc_income_retire_over  ="y">
</cfif>
<cfif response_set.mqc_income_retired eq 'mqc_income_retire_range1'>
	<cfset response_set.mqc_income_retire_range1  ="y">
</cfif>
<cfif response_set.mqc_income_retired eq 'mqc_income_retire_range2'>
	<cfset response_set.mqc_income_retire_range2  ="y">
</cfif>
<cfif response_set.mqc_income_retired eq 'mqc_income_retire_range3'>
	<cfset response_set.mqc_income_retire_range3  ="y">
</cfif>
<cfif response_set.mqc_income_retired eq 'mqc_income_retire_under'>
	<cfset response_set.mqc_income_retire_under  ="y">
</cfif>

<!-- mqc_asset -->
<cfif not isdefined('response_set.MQC_INCASSET')>
	<cfparam name="response_set.MQC_INCASSET" default="">
	<cfset response_set.mqc_asset_under  ="y">
</cfif>
<cfif response_set.mqc_incasset eq 'mqc_asset_over'>
	<cfset response_set.mqc_asset_over  ="y">
</cfif>
<cfif response_set.mqc_incasset eq 'mqc_asset_range1'>
	<cfset response_set.mqc_asset_range1  ="y">
</cfif>
<cfif response_set.mqc_incasset eq 'mqc_asset_range2'>
	<cfset response_set.mqc_asset_range2  ="y">
</cfif>
<cfif response_set.mqc_incasset eq 'mqc_asset_range3'>
	<cfset response_set.mqc_asset_range3  ="y">
</cfif>
<cfif response_set.mqc_incasset eq 'mqc_asset_under'>
	<cfset response_set.mqc_asset_under  ="y">
</cfif>      
 <cfinvoke  
    component="util" 
    method="logScreeningInput" 
    > 
  <cfinvokeargument name="subset_id" value="#request.subset_id#"/> 
  <cfinvokeargument name="screening_id" value="#request.screening_id#"/> 
  <cfinvokeargument name="responseStruct" value="#response_set#"/>
  <cfinvokeargument name="afList"  value="#afList#"/>
 </cfinvoke> 
<!--- UPDATE screening.end_datetime in database --->
		<cfquery name="logScreeningEnd" datasource="#application.dbSrc#">
			UPDATE screening 
			SET end_datetime=#CreateODBCDateTime(Now())#
			WHERE screening_id=#request.screening_id#
		</cfquery>

 	<cfset request.city = "">                                                                                     
	<cfset screeningresults.date_time = #now()# >
	<cfset screeningresults.program_list = "">
	<cfset screeningresults.screening_id = request.screening_id >
	<cfif request.subset_id eq 75 or request.subset_id eq 74 or request.subset_id eq 72 or request.subset_id eq 85 or request.subset_id eq 86 >
	       <cfset screeningresults.report_url = "">
	<cfelseif request.prg_list eq "">
		<cfset screeningresults.report_url = "">
	<cfelse>
		<cfset screeningresults.report_url = "https://#application.servername#/pdf/#pdfname#.pdf">
	</cfif>
	<cfif isdefined('request.screening_id' )>
		<cfset temp = #QuerySetCell(resultset, "screening_id", request.screening_id, rownum)#>
	</cfif>
	<cfif isdefined('request.partner_screening_id' )>
		<cfset temp = #QuerySetCell(resultset, "partner_screening_id", request.partner_screening_id, rownum)#>
	</cfif>
	<cfif isdefined('request.campaign_id' )>
		<cfset temp = #QuerySetCell(resultset, "campaign_id", request.campaign_id, rownum)#>
	</cfif>
	<cfset temp = #QuerySetCell(resultset, "partner_id", request.partner_id, rownum)#>
	<cfset temp = #QuerySetCell(resultset, "subset_id", current_subset_id, rownum)#>
	<cfset temp = #QuerySetCell(resultset, "client_id", request.client_id, rownum)#>
	<cfset temp = #QuerySetCell(resultset, "report_url", screeningresults.report_url, rownum)#>
	<cfset temp = #QuerySetCell(resultset, "program_list", "", rownum)#>
	<cfset temp = #QuerySetCell(resultset, "date_time", now(), rownum)#>
	<cfset temp = #QuerySetCell(resultset, "program_title", "", rownum)#>
	<cfset temp = QuerySetCell(resultset, "reentry_number", "", rownum)>
	<cfset temp = QuerySetCell(resultset, "screening_status", "Success", rownum)>
	<cfset temp = #QuerySetCell(resultset, "validation_error", "", rownum)#>
	<cfset temp = #QuerySetCell(resultset, "state_id", request.state_id, rownum)#>
	<cfif request.subset_id eq 79>
		<cftry>
		<cfset temp = #QuerySetCell(resultset, "next_subset_id", request.next_subset_id, rownum)#>
		<cfcatch></cfcatch>
		</cftry>
	</cfif>




<cfif request.subset_id eq 75 or request.subset_id eq 74 or request.subset_id eq 72 or request.subset_id eq 80 or request.subset_id eq 83 or request.subset_id eq 85 or request.subset_id eq 86 >
<cfinvoke  
    component="util" 
    method="processContentRules" 
    > 
<cfinvokeargument name="subset_id" value="#request.subset_id#"/> 
<cfinvokeargument name="screening_id" value="#request.screening_id#"/> 
<cfinvokeargument name="responseStruct" value="#response_set#"/>
</cfinvoke> 
<cfelseif request.subset_id eq 73>
<cfset url.screeningId = request.screening_id >
<cfset aon_status = 'Success'>
<!-- include template="util/aon_submit.cfm" -->
<cfset status = aon_status>
<!-- AON  Disabled -->
<cfset temp = #QuerySetCell(resultset, "screening_status", aon_status, rownum)#>
</cfif>
<cfif request.debug><cfoutput><h1>Screening Complete<br></h1></cfoutput></cfif>
</cfloop>
