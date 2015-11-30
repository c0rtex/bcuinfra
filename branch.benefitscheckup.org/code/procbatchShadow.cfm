	<cfquery name="screeningdata" datasource="#application.dbSrc#">
		SELECT * from screening s, screening_answerfield sa
		where 
		sa.screening_id = s.screening_id and
		s.partner_id = 29 and s.subset_id = 41
		and s.screening_id = 582272 
	</cfquery>
	<cfdump var="#screeningdata#"><cfabort>
<cf_handleScreeningAnswerfield action="get" code="st" element="val" var="preserveStateID">
<cfset preserveSessionID = screeningdata.screening_id>
<cfset preserveStateID = "NY">
<cfset session.subset_id = 41>
<cf_cacheSubsetPool action="getShadow" subset_id="41" partner_id="29" var="shadowSubsetID">
<cfif shadowSubsetID eq ''>
	<cfset session.subset_id = 0>
<cfelse>
	<cfset session.subset_id = shadowSubsetID>
</cfif>
<cfset session.prev_id = preserveSessionID>
<cfset session.state_id = preserveStateID>
<cfset theList = ''>
<cf_handleScreening action="start" loadsession="true">

<!--- START session info loading --->
	<cfquery name="subsetInfo" datasource="#application.dbSrc#">
		SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text,
			all_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag
		FROM xsubset
		WHERE subset_id=#session.subset_id#
	</cfquery>
	<cfif subsetInfo.RecordCount>
		<cfset session.subsetName = subsetInfo.subset_name>
		<cfset session.subsetLongName = subsetInfo.subset_longname>
		<cfset session.subsetDescription = subsetInfo.subset_description>
		<cfset session.subsetText = subsetInfo.subset_text>
		<cfset session.subsetAllFlag = subsetInfo.all_flag>
		<cfset session.subsetGridFlag = subsetInfo.grid_flag>
		<cfset session.subsetSCHIPFlag = subsetInfo.schip_flag>
		<cfset session.subsetDrugFlag = subsetInfo.drug_flag>
		<cfset session.subsetOptionalFlag = subsetInfo.optional_flag>
		<cfset session.subsetRecFlag = subsetInfo.rec_flag>
		<cfset session.subsetEFormFlag = subsetInfo.eform_flag>
	<cfelse>
		<cfset session.subsetName = ''>
		<cfset session.subsetLongName = ''>
		<cfset session.subsetDescription = ''>
		<cfset session.subsetText = ''>
		<cfset session.subsetAllFlag = 0>
		<cfset session.subsetGridFlag = 0>
		<cfset session.subsetSCHIPFlag = 0>
		<cfset session.subsetDrugFlag = 0>
		<cfset session.subsetOptionalFlag = 0>
		<cfset session.subsetRecFlag = 0>
		<cfset session.subsetEFormFlag = 0>
	</cfif>
	<cfquery name="subsetPartnerInfo" datasource="#application.dbSrc#">
		SELECT resultpage_id
		FROM subset_partner
		WHERE subset_id=#session.subset_id#
			AND partner_id=#session.partner_id#
			AND resultpage_id IS NOT NULL
	</cfquery>
	<cfif subsetPartnerInfo.RecordCount>
		<cfset session.subsetRecFlag = subsetPartnerInfo.resultpage_id - 1>
	</cfif>
<!--- END session info loading --->

<!--- DEBUGGING OUTPUT
<cfoutput>
subset_id = #session.subset_id#<br>
partner_id = #session.partner_id#<br>
subsetRecFlag = #session.subsetRecFlag#<br><br>
</cfoutput>
--->


<!-- Derive SP_DOB answerfield from SP_DOB_MONTH and SP_DOB_YEAR -->
<cfif ListFind(lsiDeriveList, 'sp_dob_month') or ListFind(lsiDeriveList, 'sp_dob_year')>
	<cf_handleScreeningAnswerfield action="get" code="sp_dob_month" element="val" var="lsiMonth">
	<cf_handleScreeningAnswerfield action="get" code="sp_dob_year" element="val" var="lsiYear">
	<cfif lsiMonth eq ''>
		<cfset lsiMonth = 1>
	</cfif>
	<cfif lsiYear neq ''>
		<cfset lsiMakeDOB = DateFormat(lsiMonth & "/01/" & lsiYear, 'mm/dd/yyyy')>
		<cfset lsiAnswer = Abs(DateDiff("yyyy", DateFormat(NOW(), "mm/dd/yyyy"), lsiMakeDOB))>
		<cfset session.sp_dob = lsiAnswer>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="sp_dob" response="#lsiAnswer#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfelse>
		<cfset session.sp_dob = 0>
	</cfif>
</cfif>
<!-- Derive marital_status answerfield from ct_mrtl_stus -->
<cfif ListFind(lsiDeriveList, 'ct_mrtl_stus')>
	<cf_handleScreeningAnswerfield action="get" code="ct_mrtl_stus" element="val" var="afVal">
	<cfset lsiTemp = 1>
	<cfswitch expression="#afVal#">
		<cfcase value="5">
			<cfset lsiAnswer = '5-divorced'>
			<cfset session.marital_stat = 'divorced'>
		</cfcase>
		<cfcase value="6">
			<cfset lsiAnswer = '6-single'>
			<cfset session.marital_stat = 'single'>
		</cfcase>
		<cfcase value="7">
			<cfset lsiAnswer = '7-widowed'>
			<cfset session.marital_stat = 'widowed'>
		</cfcase>
		<cfcase value="2346">
			<cfset lsiAnswer = '5-divorced'>
			<cfset session.marital_stat = 'divorced'>
		</cfcase>
		<cfcase value="2347">
			<cfset lsiAnswer = '4-married'>
			<cfset session.marital_stat = 'married'>
			<cfset lsiTemp = 2>
		</cfcase>
		<cfcase value="2348">
			<cfset lsiAnswer = '1361-married_living_sep'>
			<cfset session.marital_stat = 'married_living_sep'>
		</cfcase>
		<cfdefaultcase>
			<cfset lsiAnswer = ''>
			<cfset session.marital_stat = ''>
		</cfdefaultcase>
	</cfswitch>
	<cfif lsiAnswer neq ''>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="o" response_var="marital_stat" response="#lsiAnswer#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfset session.no_hh_members = lsiTemp>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="no_hh_members" response="#lsiTemp#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!-- Derive state answerfield from be_clnt_mail_addr_st -->
<cfif ListFind(lsiDeriveList, 'be_clnt_mail_addr_st')>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_mail_addr_st" element="val" var="valSt">
	<cfif valSt neq ''>
		<cfset session.st = valSt>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="st" response="#session.st#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
</cfif>
<!-- Derive zip answerfield from be_clnt_mail_addr_zip5 -->
<cfset useDerivedZip = false>
<cfif ListFind(lsiDeriveList, 'be_clnt_mail_addr_zip5')>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_mail_addr_zip5" element="val" var="valZip">
	<cfif valZip neq ''>
		<cfset session.zip = valZip>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="zip" response="#session.zip#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset useDerivedZip = true>
	</cfif>
</cfif>
<!-- Derive dob, sp_dob and over_60 answerfields from be_clnt_under_age_xnd and be_noncl_under_age_xnd -->
<cfif ListFind(lsiDeriveList, 'be_clnt_under_age_xnd') or ListFind(lsiDeriveList, 'be_noncl_under_age_xnd')>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_under_age_xnd" element="val" var="valCUA">
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_under_age_xnd" element="val" var="valNUA">
	<cfif valCUA neq ''>
		<cfif valCUA eq 0>
			<cfset lsiTemp = 65>
		<cfelse>
			<cfset lsiTemp = 0>
		</cfif>
		<cfset session.dob = lsiTemp>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="dob" response="#lsiTemp#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfif valNUA neq ''>
		<cfif valNUA eq 0>
			<cfset lsiTemp = 65>
		<cfelse>
			<cfset lsiTemp = 0>
		</cfif>
		<cfset session.sp_dob = lsiTemp>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="sp_dob" response="#lsiTemp#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfif valCUA neq '' and valNUA neq ''>
		<cfif valCUA eq 0 and valNUA eq 0>
			<cfset lsiTemp = 2>
		<cfelseif valCUA eq 0 or valNUA eq 0>
			<cfset lsiTemp = 1>
		<cfelse>
			<cfset lsiTemp = 0>
		</cfif>
		<cfset session.over_60 = lsiTemp>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="over_60" response="#lsiTemp#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
</cfif>
<!-- Derive dob, sp_dob, over_60, etc. from be_clnt_dob_* and be_noncl_dob_* -->
<cfif (ListFind(lsiDeriveList, 'be_clnt_dob_day') and ListFind(lsiDeriveList, 'be_clnt_dob_month') and ListFind(lsiDeriveList, 'be_clnt_dob_year')) or (ListFind(lsiDeriveList, 'be_noncl_dob_day') and ListFind(lsiDeriveList, 'be_noncl_dob_month') and ListFind(lsiDeriveList, 'be_noncl_dob_year'))>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_dob_day" element="val" var="lsiTempDay">
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_dob_month" element="val" var="lsiTempMonth">
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_dob_year" element="val" var="lsiTempYear">
	<cfif ListFind(lsiDeriveList, 'be_clnt_dob_day') and IsNumeric(lsiTempDay) and ListFind(lsiDeriveList, 'be_clnt_dob_month') and IsNumeric(lsiTempMonth) and ListFind(lsiDeriveList, 'be_clnt_dob_year') and IsNumeric(lsiTempYear)>
		<cfset lsiTempDate = CreateDate(lsiTempYear, lsiTempMonth, lsiTempDay)>
		<cfset lsiTempAge = DateDiff('yyyy', lsiTempDate, Now())>
		<cfset lsiTempAgeMinus = DateDiff('yyyy', DateAdd('d', -1, lsiTempDate), Now())>
		<cfset session.dob_month = lsiTempMonth>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="dob_month" response="#lsiTempMonth#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.dob_year = lsiTempYear>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="dob_year" response="#lsiTempYear#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.dob = lsiTempAge>
		<cfset session.dob_minus_day = lsiTempAgeMinus>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="dob" response="#lsiTempAge#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfelse>
		<cfset lsiTempAge = 0>
	</cfif>
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_dob_day" element="val" var="lsiTempDay">
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_dob_month" element="val" var="lsiTempMonth">
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_dob_year" element="val" var="lsiTempYear">
	<cfif ListFind(lsiDeriveList, 'be_noncl_dob_day') and IsNumeric(lsiTempDay) and ListFind(lsiDeriveList, 'be_noncl_dob_month') and IsNumeric(lsiTempMonth) and ListFind(lsiDeriveList, 'be_noncl_dob_year') and IsNumeric(lsiTempYear)>
		<cfset lsiTempDate = CreateDate(lsiTempYear, lsiTempMonth, lsiTempDay)>
		<cfset lsiTempAgeSpouse = DateDiff('yyyy', lsiTempDate, Now())>
		<cfset lsiTempAgeMinusSpouse = DateDiff('yyyy', DateAdd('d', -1, lsiTempDate), Now())>
		<cfset session.sp_dob_month = lsiTempMonth>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="sp_dob_month" response="#lsiTempMonth#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.sp_dob_year = lsiTempYear>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="sp_dob_year" response="#lsiTempYear#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.sp_dob = lsiTempAgeSpouse>
		<cfset session.sp_dob_minus_day = lsiTempAgeMinusSpouse>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="sp_dob" response="#lsiTempAgeSpouse#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfelse>
		<cfset lsiTempAgeSpouse = 0>
	</cfif>
	<cfif lsiTempAge gt 59 and lsiTempAgeSpouse gt 59>
		<cfset lsiTemp = 2>
	<cfelseif lsiTempAge gt 59 or lsiTempAgeSpouse gt 59>
		<cfset lsiTemp = 1>
	<cfelse>
		<cfset lsiTemp = 0>
	</cfif>
	<cfset session.over_60 = lsiTemp>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="over_60" response="#lsiTemp#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!-- Derive assets answerfields from be_res_bank_acc_amt, be_res_invst_amt, and be_res_csh_amt -->
<cfif ListFind(lsiDeriveList, 'be_res_bank_acc_amt') and ListFind(lsiDeriveList, 'be_res_invst_amt') and ListFind(lsiDeriveList, 'be_res_csh_amt')>
	<cf_handleScreeningAnswerfield action="get" code="be_res_bank_acc_amt" element="val" var="lsiTemp1">
	<cfif lsiTemp1 eq ''>
		<cfset lsiTemp1 = 0>
	</cfif>
	<cf_handleScreeningAnswerfield action="get" code="be_res_invst_amt" element="val" var="lsiTemp2">
	<cfif lsiTemp2 eq ''>
		<cfset lsiTemp2 = 0>
	</cfif>
	<cf_handleScreeningAnswerfield action="get" code="be_res_csh_amt" element="val" var="lsiTemp3">
	<cfif lsiTemp3 eq ''>
		<cfset lsiTemp3 = 0>
	</cfif>
	<cf_handleScreeningAnswerfield action="get" code="be_ins_pol_amt" element="val" var="lsiTemp4">
	<cfif lsiTemp4 eq ''>
		<cfset lsiTemp4 = 0>
	</cfif>
	<cfset session.s_asset_total_complete = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="s_asset_total_complete" response="#session.s_asset_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_asset_total_complete = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="sp_asset_total_complete" response="#session.sp_asset_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_asset_total_complete = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="s_sp_asset_total_complete" response="#session.s_sp_asset_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_asset_total_complete = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="hh_asset_total_complete" response="#session.hh_asset_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!-- Derive self unearned income from turbo app vars -->
<cfif ListFind(lsiDeriveList, 'be_clnt_ss_benefits_amt') and ListFind(lsiDeriveList, 'be_clnt_rr_incm_amt') and ListFind(lsiDeriveList, 'be_clnt_va_benefits_amt') and ListFind(lsiDeriveList, 'be_clnt_pens_annuit_amt') and ListFind(lsiDeriveList, 'be_clnt_oth_incm_amt')>

	<cf_handleScreeningAnswerfield action="get" code="be_clnt_ss_benefits_amt" element="val" var="lsiTemp1">
	<cfif lsiTemp1 eq ''>
		<cfset lsiTemp1 = 0>
	</cfif>
	<cfset session.s_income_ss_retire = lsiTemp1>
	<cfset session.s_income_ss_disable = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_ss_retire" response="#session.s_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_ss_disable" response="#session.s_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_ss_retire = 0>
	<cfset session.sp_income_ss_disable = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_ss_retire" response="#session.sp_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_ss_disable" response="#session.sp_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_ss_retire = lsiTemp1>
	<cfset session.s_sp_income_ss_disable = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_ss_retire" response="#session.s_sp_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_ss_disable" response="#session.s_sp_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_ss_retire = lsiTemp1>
	<cfset session.hh_income_ss_disable = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_ss_retire" response="#session.hh_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_ss_disable" response="#session.hh_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">

	<cf_handleScreeningAnswerfield action="get" code="be_clnt_rr_incm_amt" element="val" var="lsiTemp2">
	<cfif lsiTemp2 eq ''>
		<cfset lsiTemp2 = 0>
	</cfif>
	<cfset session.s_income_rr_ben = lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_rr_ben" response="#session.s_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_rr_ben = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_rr_ben" response="#session.sp_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_rr_ben = lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_rr_ben" response="#session.s_sp_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_rr_ben = lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_rr_ben" response="#session.hh_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">

	<cf_handleScreeningAnswerfield action="get" code="be_clnt_va_benefits_amt" element="val" var="lsiTemp3">
	<cfif lsiTemp3 eq ''>
		<cfset lsiTemp3 = 0>
	</cfif>
	<cfset session.s_income_vet_ben = lsiTemp3>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_vet_ben" response="#session.s_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_vet_ben = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_vet_ben" response="#session.sp_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_vet_ben = lsiTemp3>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_vet_ben" response="#session.s_sp_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_vet_ben = lsiTemp3>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_vet_ben" response="#session.hh_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">

	<cf_handleScreeningAnswerfield action="get" code="be_clnt_pens_annuit_amt" element="val" var="lsiTemp4">
	<cfif lsiTemp4 eq ''>
		<cfset lsiTemp4 = 0>
	</cfif>

	<cf_handleScreeningAnswerfield action="get" code="be_clnt_oth_incm_amt" element="val" var="lsiTemp5">
	<cfif lsiTemp5 eq ''>
		<cfset lsiTemp5 = 0>
	</cfif>

	<cfset session.s_income_total_unearned = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4 + lsiTemp5>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_total_unearned" response="#session.s_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_total_unearned = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_total_unearned" response="#session.sp_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_total_unearned = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4 + lsiTemp5>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_total_unearned" response="#session.s_sp_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_total_unearned = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4 + lsiTemp5>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_total_unearned" response="#session.hh_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfif not IsDefined('session.s_income_earned')>
		<cfset session.s_income_earned = 0>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_earned" response="#session.s_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfif not IsDefined('session.sp_income_earned')>
		<cfset session.sp_income_earned = 0>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_earned" response="#session.sp_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfif not IsDefined('session.s_sp_income_earned')>
		<cfset session.s_sp_income_earned = 0>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_earned" response="#session.s_sp_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfif not IsDefined('session.hh_income_earned')>
		<cfset session.hh_income_earned = 0>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_earned" response="#session.hh_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfset session.s_income_total_complete = session.s_income_total_unearned + session.s_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_total_complete" response="#session.s_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_total_complete = session.sp_income_total_unearned + session.sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_total_complete" response="#session.sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_total_complete = session.s_sp_income_total_unearned + session.s_sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_total_complete" response="#session.s_sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_total_complete = session.hh_income_total_unearned + session.hh_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_total_complete" response="#session.hh_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!-- Derive spouse unearned income from turbo app vars -->
<cfif ListFind(lsiDeriveList, 'be_noncl_ss_benefits_amt') and ListFind(lsiDeriveList, 'be_noncl_rr_incm_amt') and ListFind(lsiDeriveList, 'be_noncl_va_benefits_amt') and ListFind(lsiDeriveList, 'be_noncl_pens_annuit_amt') and ListFind(lsiDeriveList, 'be_noncl_oth_incm_amt')>

	<cf_handleScreeningAnswerfield action="get" code="be_noncl_ss_benefits_amt" element="val" var="lsiTemp1">
	<cfif lsiTemp1 eq ''>
		<cfset lsiTemp1 = 0>
	</cfif>
	<cfset session.sp_income_ss_retire = lsiTemp1>
	<cfset session.sp_income_ss_disable = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_ss_retire" response="#session.sp_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_ss_disable" response="#session.sp_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfif not isdefined('session.s_income_ss_retire')><cfset session.s_income_ss_retire = 0></cfif>
	<cfset session.s_sp_income_ss_retire = session.s_income_ss_retire + lsiTemp1>
	<cfif not isdefined('session.s_income_ss_disable')><cfset session.s_income_ss_disable = 0></cfif>
	<cfset session.s_sp_income_ss_disable = session.s_income_ss_disable>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_ss_retire" response="#session.s_sp_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_ss_disable" response="#session.s_sp_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_ss_retire = session.s_income_ss_retire + lsiTemp1>
	<cfset session.hh_income_ss_disable = session.s_income_ss_disable>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_ss_retire" response="#session.hh_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_ss_disable" response="#session.hh_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">

	<cf_handleScreeningAnswerfield action="get" code="be_noncl_rr_incm_amt" element="val" var="lsiTemp2">
	<cfif lsiTemp2 eq ''>
		<cfset lsiTemp2 = 0>
	</cfif>
	<cfset session.sp_income_rr_ben = lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_rr_ben" response="#session.sp_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfif not isdefined('session.s_income_rr_ben')><cfset session.s_income_rr_ben = 0></cfif>
	<cfset session.s_sp_income_rr_ben = session.s_income_rr_ben + lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_rr_ben" response="#session.s_sp_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_rr_ben = session.s_income_rr_ben + lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_rr_ben" response="#session.hh_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">

	<cf_handleScreeningAnswerfield action="get" code="be_noncl_va_benefits_amt" element="val" var="lsiTemp3">
	<cfif lsiTemp3 eq ''>
		<cfset lsiTemp3 = 0>
	</cfif>
	<cfset session.sp_income_vet_ben = lsiTemp3>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_vet_ben" response="#session.sp_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfif not isdefined('session.s_income_vet_ben')><cfset session.s_income_vet_ben = 0></cfif>
	<cfset session.s_sp_income_vet_ben = session.s_income_vet_ben + lsiTemp3>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_vet_ben" response="#session.s_sp_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_vet_ben = session.s_income_vet_ben + lsiTemp3>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_vet_ben" response="#session.hh_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">

	<cf_handleScreeningAnswerfield action="get" code="be_noncl_pens_annuit_amt" element="val" var="lsiTemp4">
	<cfif lsiTemp4 eq ''>
		<cfset lsiTemp4 = 0>
	</cfif>

	<cf_handleScreeningAnswerfield action="get" code="be_noncl_oth_incm_amt" element="val" var="lsiTemp5">
	<cfif lsiTemp5 eq ''>
		<cfset lsiTemp5 = 0>
	</cfif>

	<cfset session.sp_income_total_unearned = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4 + lsiTemp5>
	<cfif not isdefined('session.s_income_total_unearned')><cfset session.s_income_total_unearned = 0></cfif>
	<cfif not isdefined('session.sp_income_earned')><cfset session.sp_income_earned = 0></cfif>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_total_unearned" response="#session.sp_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_total_unearned = session.s_income_total_unearned + lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4 + lsiTemp5>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_total_unearned" response="#session.s_sp_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_total_unearned = session.s_income_total_unearned + lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4 + lsiTemp5>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_total_unearned" response="#session.hh_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_total_complete = session.sp_income_total_unearned + session.sp_income_earned>
	<cfif not isdefined('session.S_INCOME_EARNED')><cfset session.S_INCOME_EARNED = 0></cfif>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_total_complete" response="#session.sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_total_complete = session.s_income_total_unearned + session.s_income_earned + session.sp_income_total_unearned + session.sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_total_complete" response="#session.s_sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_total_complete = session.s_income_total_unearned + session.s_income_earned + session.sp_income_total_unearned + session.sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_total_complete" response="#session.hh_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!-- Correct work question if didn't really work -->
<cfif ListFind(lsiDeriveList, 'be_clnt_earn_wgs_xnd') and ListFind(lsiDeriveList, 'be_clnt_earn_loss_xnd') and ListFind(lsiDeriveList, 'be_clnt_stop_wrk_xnd')>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_earn_wgs_xnd" element="val" var="lsiTemp1">
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_earn_loss_xnd" element="val" var="lsiTemp2">
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_stop_wrk_xnd" element="val" var="lsiTemp3">
	<cfif lsiTemp1 eq 0 and lsiTemp2 eq 0 and lsiTemp3 eq 0>
		<cfset session.be_clnt_wrkd_l2yr_xnd = 'n'>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="y" response_var="be_clnt_wrkd_l2yr_xnd" response="n" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
</cfif>
<!-- Correct work question if spouse didn't really work -->
<cfif ListFind(lsiDeriveList, 'be_noncl_earn_wgs_xnd') and ListFind(lsiDeriveList, 'be_noncl_earn_loss_xnd') and ListFind(lsiDeriveList, 'be_noncl_stop_wrk_xnd')>
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_earn_wgs_xnd" element="val" var="lsiTemp1">
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_earn_loss_xnd" element="val" var="lsiTemp2">
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_stop_wrk_xnd" element="val" var="lsiTemp3">
	<cfif lsiTemp1 eq 0 and lsiTemp2 eq 0 and lsiTemp3 eq 0>
		<cfset session.be_noncl_wrkd_l2yr_xnd = 'n'>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="y" response_var="be_noncl_wrkd_l2yr_xnd" response="n" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
</cfif>
<!-- Derive self earned income from turbo app vars -->
<cfif ListFind(lsiDeriveList, 'be_clnt_earn_wgs_amt') and ListFind(lsiDeriveList, 'be_clnt_earn_amt')>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_earn_wgs_amt" element="val" var="lsiTemp1">
	<cfif lsiTemp1 eq ''>
		<cfset lsiTemp1 = 0>
	</cfif>
	<cfset lsiTemp1 = lsiTemp1 / 12>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_earn_amt" element="val" var="lsiTemp2">
	<cfif lsiTemp2 eq ''>
		<cfset lsiTemp2 = 0>
	</cfif>
	<cfset lsiTemp2 = lsiTemp2 / 12>
	<cfset session.s_income_earned = lsiTemp1 + lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_earned" response="#session.s_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_earned = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_earned" response="#session.sp_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_earned = lsiTemp1 + lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_earned" response="#session.s_sp_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_earned = lsiTemp1 + lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_earned" response="#session.hh_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_income_total_complete = session.s_income_total_unearned + session.s_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_total_complete" response="#session.s_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_total_complete = session.s_sp_income_total_unearned + session.s_sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_total_complete" response="#session.s_sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_total_complete = session.hh_income_total_unearned + session.hh_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_total_complete" response="#session.hh_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!-- Derive spouse earned income from turbo app vars -->
<cfif ListFind(lsiDeriveList, 'be_noncl_earn_wgs_amt') and ListFind(lsiDeriveList, 'be_noncl_earn_amt')>
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_earn_wgs_amt" element="val" var="lsiTemp1">
	<cfif lsiTemp1 eq ''>
		<cfset lsiTemp1 = 0>
	</cfif>
	<cfset lsiTemp1 = lsiTemp1 / 12>
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_earn_amt" element="val" var="lsiTemp2">
	<cfif lsiTemp2 eq ''>
		<cfset lsiTemp2 = 0>
	</cfif>
	<cfset lsiTemp2 = lsiTemp2 / 12>
	<cfset session.sp_income_earned = lsiTemp1 + lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_earned" response="#session.sp_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_earned = session.s_income_earned + session.sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_earned" response="#session.s_sp_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_earned = session.s_income_earned + session.sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_earned" response="#session.hh_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_total_complete = session.sp_income_total_unearned + session.sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_total_complete" response="#session.sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_total_complete = session.s_sp_income_total_unearned + session.s_sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_total_complete" response="#session.s_sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_total_complete = session.hh_income_total_unearned + session.hh_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_total_complete" response="#session.hh_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!-- Derive hh_disabled and disabled answerfields from ct_ss_disblty_xnd -->
<cfif ListFind(lsiDeriveList, 'ct_ss_disblty_xnd')>
	<cf_handleScreeningAnswerfield action="get" code="ct_ss_disblty_xnd" element="val" var="afVal">
	<cfif afVal eq 1>
		<cfset session.hh_disabled = 1>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="hh_disabled" response="1" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.disabled = 1>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="o" response_var="disabled" response="1-y" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
</cfif>
<!-- Derive COUNTY and COUNTY_ID answerfields from ZIP (and ST if necessary, and CITY and CITY_ID if possible).  This
      is a rare case where we allow one set of vars to be derived from another derived var, to avoid duplicating code
      from where 'zip' gets derived from 'be_clnt_mail_addr_zip5' above.  Of course, if the actual 'zip' field was
      entered in the questionnaire and not derived, we can use that value. -->
<cfif ListFind(lsiDeriveList, 'zip') or useDerivedZip>
	<cf_handleScreeningAnswerfield action="get" code="county" element="val" var="lsiCounty">
	<cf_handleScreeningAnswerfield action="get" code="county_id" element="val" var="lsiCountyID">
	<cf_handleScreeningAnswerfield action="get" code="city" element="val" var="lsiCity">
	<cf_handleScreeningAnswerfield action="get" code="city_id" element="val" var="lsiCityID">
	<cf_handleScreeningAnswerfield action="get" code="zip" element="val" var="lsiZip">
	<cf_handleScreeningAnswerfield action="get" code="st" element="val" var="lsiSt">
	<cf_handleScreeningAnswerfield action="get" code="pri_resident" element="val" var="lsiRes">
	<cfif lsiCounty eq '' and lsiCountyID eq '' and lsiZip neq '' and lsiSt neq ''>
		<cfquery name="getCounty" datasource="#application.dbSrc#">
			select c.county_id, c.county_name
			from zip z , county c 
			where z.zipcode='#lsiZip#'
				and z.valid=1
				and z.state_id='#lsiSt#'
				and z.county_id=c.county_id
		</cfquery>
		<cfif getCounty.RecordCount gt 0>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="county_id" response="#getCounty.county_id#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.county_id = getCounty.county_id>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="county" response="#getCounty.county_name#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.county = getCounty.county_name>
		</cfif>
	<cfelseif lsiSt eq '' and lsiCounty eq '' and lsiCountyID eq '' and lsiZip neq ''>
		<cfquery datasource="#application.dbSrc#" name="getCounty">
			select z.state_id, s.statetype_id, c.county_id, c.county_name
			from zip z , county c , state s 
			where z.zipcode='#lsiZip#'
				and z.valid=1
				and z.state_id=s.state_id
				and <cfif session.subset_id neq 59 and session.subset_id neq 3 >
				s.statetype_id=1
				    <cfelseif session.subset_id eq 3>
				(s.statetype_id=1 or s.state_id = 'VI')
				    <cfelse>
				s.state_id = 'VI'
				    </cfif>
				and z.county_id=c.county_id
		</cfquery>
		<cfif getCounty.RecordCount gt 0>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="st" response="#getCounty.state_id#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.st = getCounty.state_id>
			<cfif lsiRes eq ''>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="y" response_var="pri_resident" response="Y" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
				<cfset session.pri_resident = 'Y'>
			</cfif>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="county_id" response="#getCounty.county_id#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.county_id = getCounty.county_id>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="county" response="#getCounty.county_name#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.county = getCounty.county_name>
		</cfif>
	</cfif>
	<cfif lsiCity eq '' and lsiCityID eq '' and lsiZip neq '' And StructKeyExists(application.chicagovars, lsiZip)>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="o" response_var="city" response="2376-chicago" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="city_name" response="CHICAGO" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.city = 'chicago'>
		<cfset session.city_name = 'CHICAGO'>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="city_id" response="#StructFind(application.chicagovars, lsiZip)#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.city_id = StructFind(application.chicagovars, lsiZip)>
	<cfelseif lsiCity eq '' and lsiCityID eq '' and lsiZip neq ''>
		<cfquery datasource="#application.dbSrc#" name="getCity">
			select cz.city_id, c.city_name
			from view_city_zip_preferred cz, city c
			where cz.zipcode='#lsiZip#'
				and cz.city_id=c.city_id
				and c.valid=1
			order by c.city_name
		</cfquery>
		<cfif getCity.RecordCount eq 1>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="city_name" response="#getCity.city_name#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.city = getCity.city_name>
			<cfset session.city_name = getCity.city_name>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="city_id" response="#getCity.city_id#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.city_id = getCity.city_id>
		<cfelse>
			<cfset session.city = 0>
			<cfset session.city_name = 0>
			<cfset session.city_id = 0>
		</cfif>
	</cfif>
</cfif>
<!-- Derive INCOME variables -->
<cfif lsiDeriveIncome>
	<cfloop index="class" list="s,sp,s_sp,hh">
		<cfset "colaccumvar_#class#_unearned" = 0>
		<cfset "colaccumvar_#class#_complete" = 0>
	</cfloop>
	<cfloop index="element" list="pri_retire,dividends,ssi,ss_disable,ss_retire,rr_ben,vet_ben,unemploy,tanf,child_support,cash_assist,other_nw,earned,total_unearned,total_complete">
		<cfset rowaccumvar = 0>
		<cfloop index="class" list="s,sp,s_sp,hh,ch">
			<cfif class neq "ch" or element eq "total_unearned" or element eq "earned" or element eq "child_support">
			<cfset sessionvarname = "#class#_income_#element#">
			<cfif class eq 's_sp' or class eq 'hh'>
				<cfset databasevarname = "#sessionvarname#_simple">
			<cfelse>
				<cfset databasevarname = sessionvarname>
			</cfif>
			<cfif IsDefined("caller.#attributes.structname#.#databasevarname#")>
				<cfset databaseval = Evaluate("caller.#attributes.structname#.#databasevarname#")>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="#databasevarname#" response="#databaseval#" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
				<cfif databaseval eq '' >
					<cfset databaseval = 0>
				</cfif>
			<cfelseif element eq 'total_unearned' and class neq "ch">
				<cfset databaseval = Evaluate("colaccumvar_#class#_unearned")>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="#databasevarname#" response="#databaseval#" derived_flag="1" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfelseif element eq 'total_complete' and class neq "ch">
				<cfset databaseval = Evaluate("colaccumvar_#class#_complete")>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="#databasevarname#" response="#databaseval#" derived_flag="1" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfelse>
				<cfset databaseval = 0>
			</cfif>
			<cfif databaseval eq 'undefined'>
				<cfset databaseval = 0>
			</cfif>
			<cfset "session.#databasevarname#" = databaseval>
			<cfset rowaccumvar = rowaccumvar + databaseval>
			<cfif element neq 'earned' and element neq 'total_unearned' and element neq 'total_complete' and class neq "ch">
				<cfset "colaccumvar_#class#_unearned" = Evaluate("colaccumvar_#class#_unearned") + databaseval>
			</cfif>
			<cfif (element eq 'earned' or element eq 'total_unearned') and class neq "ch">
				<cfset "colaccumvar_#class#_complete" = Evaluate("colaccumvar_#class#_complete") + databaseval>
			</cfif>
			<cfif sessionvarname neq databasevarname>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="#sessionvarname#" response="#rowaccumvar#" derived_flag="1" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
				<cfset "session.#sessionvarname#" = rowaccumvar>
			</cfif>
			</cfif>
		</cfloop>
	</cfloop>
	<cfset lsiDerivePoverty = True>
</cfif>
<!-- Derive ASSETS variables -->
<cfif lsiDeriveAssets>
	<cfloop index="class" list="s,sp,s_sp,hh">
		<cfset "colaccumvar_#class#_complete" = 0>
	</cfloop>
	<cfloop index="element" list="cash,stocks,life_cash,life_face,auto1,auto2,retirement,home,revocable,irrevocable,other_a,total_complete">
		<cfset rowaccumvar = 0>
		<cfloop index="class" list="s,sp,s_sp,hh,ch">
			<cfif class neq "ch" or  element eq "total_complete">
			<cfset sessionvarname = "#class#_asset_#element#">
			<cfif class eq 's_sp' or class eq 'hh'>
				<cfset databasevarname = "#sessionvarname#_simple">
			<cfelse>
				<cfset databasevarname = sessionvarname>
			</cfif>
			<cfif IsDefined("caller.#attributes.structname#.#databasevarname#")>
				<cfset databaseval = Evaluate("caller.#attributes.structname#.#databasevarname#")>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="#databasevarname#" response="#databaseval#" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
				<cfif databaseval eq ''>
					<cfset databaseval = 0>
				</cfif>
			<cfelseif element eq 'total_complete' and class neq "ch">
				<cfset databaseval = Evaluate("colaccumvar_#class#_complete")>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="#databasevarname#" response="#databaseval#" derived_flag="1" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfelse>
				<cfset databaseval = 0>
			</cfif>
			<cfset "session.#databasevarname#" = databaseval>
			<cfset rowaccumvar = rowaccumvar + databaseval>
			<cfif element neq 'life_face' and element neq 'irrevocable' and element neq 'total_complete' and class neq "ch">
				<cfset "colaccumvar_#class#_complete" = Evaluate("colaccumvar_#class#_complete") + databaseval>
			</cfif>
			<cfif sessionvarname neq databasevarname>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="#sessionvarname#" response="#rowaccumvar#" derived_flag="1" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
				<cfset "session.#sessionvarname#" = rowaccumvar>
			</cfif>
			</cfif>
		</cfloop>
	</cfloop>
</cfif>



<cf_logScreeningInput varname="theList" loadsession="true">
<cf_handleScreening action="end" screening_id="#session.screening.id#">

<!--- DEBUGGING OUTPUT
<cfoutput>
subset_id = #session.subset_id#<br>
partner_id = #session.partner_id#<br>
subsetRecFlag = #session.subsetRecFlag#<br><br>
</cfoutput>
--->

<!--- 05/21/2003 BS - Make sure there's a session.selectedDrugs variable --->
<cfif not IsDefined("session.selectedDrugs")>
	<cfset session.selectedDrugs = ''>
</cfif>
<!--- 08/02/2002 Bill - This code is to strip leading zeroes off the household number, so we don't look up a column with a name like "mem02" --->
<cfif isDefined("session.no_hh_members")>
	<cfset session.no_hh_members = val(session.no_hh_members)>
</cfif>
<cfif isDefined("session.hh_disabled")>
	<cfset session.hh_disabled = val(session.hh_disabled)>
</cfif>
<cfif isDefined("session.over_60")>
	<cfset session.over_60 = val(session.over_60)>
</cfif>
<CFSET session.END_TIME = CreateODBCDATETIME(now())>
<cfset session.prg_list = "">
<cfset session.buff_list = "">
<!--- 07/09/2002 REM  The "normal" pass --->
<cf_tagTestRules ynDoBuffer="FALSE">

<cfif Not IsDefined('session.subset_id') Or session.subset_id neq 1>
<!--- 07/09/2002 REM  Now we set up for Buffer --->
<!--- need to offset the total figures by 500 and 100 respectively --->
<CFSET SESSION.S_asset_TOTAL_COMPLETE = SESSION.s_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.S_SP_asset_TOTAL_COMPLETE = SESSION.S_SP_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.HH_asset_TOTAL_COMPLETE = SESSION.HH_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.S_INCOME_TOTAL_COMPLETE = SESSION.s_INCOME_TOTAL_COMPLETE - 100>
<CFSET SESSION.S_SP_INCOME_TOTAL_COMPLETE = SESSION.S_SP_INCOME_TOTAL_COMPLETE - 100>
<CFSET SESSION.HH_INCOME_TOTAL_COMPLETE = SESSION.HH_INCOME_TOTAL_COMPLETE - 100>
<cf_tagTestRules ynDoBuffer="TRUE">
<!--- now we put the total figures back again :)--->
<CFSET SESSION.S_asset_TOTAL_COMPLETE = SESSION.s_asset_TOTAL_COMPLETE + 500>
<CFSET SESSION.S_SP_asset_TOTAL_COMPLETE = SESSION.S_SP_asset_TOTAL_COMPLETE + 500>
<CFSET SESSION.HH_asset_TOTAL_COMPLETE = SESSION.HH_asset_TOTAL_COMPLETE + 500>
<CFSET SESSION.S_INCOME_TOTAL_COMPLETE = SESSION.s_INCOME_TOTAL_COMPLETE + 100>
<CFSET SESSION.S_SP_INCOME_TOTAL_COMPLETE = SESSION.S_SP_INCOME_TOTAL_COMPLETE + 100>
<CFSET SESSION.HH_INCOME_TOTAL_COMPLETE = SESSION.HH_INCOME_TOTAL_COMPLETE + 100>
</cfif>
<!--- 07/09/2002 REM  DONE WITH BUFFER --->

<cfset session.zipradius = 100>
<!--- Bill Shunn - 10/04/02 --->
<!--- Remove SSI from the program list if in RX questionnaire --->
<!--- We only use SSI to check eligibility for drug programs --->
<!--- Bill Shunn - 10/07/02 --->
<!--- Remove SSI from the buffer list if in RX questionnaire --->
<!--- We only use SSI to check eligibility for drug programs --->
<!--- 01/26/2004 BShunn  Changed to remove subset helper programs from prog and buffer lists.
                         Helpers are base_flag=0 (derived) and base_flag=2 (explicit).
                         Part of the generalization of subset screenings. --->
<!--- 05/04/2005 BShunn  For new subset implementation, rewrote query for finding ancestor programs;
                         query finds all programs that are in the _sum table but not in the _base
						 table, then loop removes those programs from the results lists --->
<cf_populateTableFromView table="subset_program_base" subset_id="#session.subset_id#">
<cf_populateTableFromView table="subset_program_sum" subset_id="#session.subset_id#">
<cfif IsDefined('session.subset_id') And session.subset_id gt 0>
	<cfquery name="helperPrg" datasource="#application.dbSrc#">
		SELECT p.prg_id AS helper_prg_id
		FROM subset_program_base spb RIGHT OUTER JOIN subset_program_sum sps
				ON spb.subset_id=sps.subset_id AND spb.program_id=sps.program_id
			INNER JOIN tbl_prg_all p
				ON sps.program_id=p.RecID
		WHERE sps.subset_id=#session.subset_id#
			AND spb.subset_id IS NULL
		ORDER BY p.prg_id
	</cfquery>
	<cfloop query="helperPrg">
		<cfset helperIndex = ListContains(session.prg_list, helper_prg_id)>
		<cfif helperIndex gt 0>
			<cfset session.prg_list = ListDeleteAt(session.prg_list, helperIndex)>
		</cfif>
		<cfset helperIndex = ListContains(session.buff_list, helper_prg_id)>
		<cfif helperIndex gt 0>
			<cfset session.buff_list = ListDeleteAt(session.buff_list, helperIndex)>
		</cfif>
	</cfloop>
</cfif>

<!--- Bill Shunn - 10/04/02 --->
<!--- Remove Generic Drugs from the program list --->
<!--- Will display separately, like SCHIP --->
<cfset genericnum=ListContains(session.prg_list, "XXX-311-2387-FD-FD")>
<cfif genericnum gt 0>
	<cfset session.prg_list=ListDeleteAt(session.prg_list, genericnum)>
	<cfset session.genericdrugs = "y">
<cfelse>
	<cfset session.genericdrugs = "n">
</cfif>
<!--- Store client prg_id's 5-15-2001--->
<!--- 03/03/2002 REM  NOTE THAT THIS NEEDS TO BE REFINED TO FIGURE OUT HOW TO AVOID WRITING A 
DUPLICATE SET OF ENTRIES IF THE USER BACKS UP AND RESUBMITS HIS ANSWERS TO THIS PROCESS 
PAGE. --->
<cfif session.subsetRecFlag eq 1>
	<cfset unseenVal = 1>
<cfelse>
	<cfset unseenVal = 0>
</cfif>
<cf_loadApplicationVars hashname="prgvars">
<cfloop list="#session.prg_list#" index="prg_id">
	<cfset unseenAdjustedVal = unseenVal>
	<cfif unseenVal eq 0>
		<cfif Mid(prg_id, Find('-', prg_id) + 1, Find('-', prg_id, Find('-', prg_id) + 1) - Find('-', prg_id) - 1) eq '333'>
			<cfset unseenAdjustedVal = 1>
		</cfif>
	</cfif>
	<cfquery name="insertprograms" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenAdjustedVal#, 0, 0)
	</CFQUERY>
</cfloop>
<cfif session.wantchips eq 'Y'>
	<CFQUERY NAME="insertchips" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, '103-309-2191-FD-FD')#, #unseenVal#, 0, 0)
	</CFQUERY>
</cfif>
<cfif session.genericdrugs eq 'Y'>
	<CFQUERY NAME="insertgeneric" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#, #unseenVal#, 0, 0)
	</CFQUERY>
</cfif>
<cfloop list="#session.buff_list#" index="prg_id">
	<cfquery name="insertbuffers" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenVal#, 1, 0)
	</cfquery>
</cfloop>

<cfif IsDefined('session.partner_id') And session.partner_id eq 5>
	<cfif ListLen(session.prg_list)>
		<cfif session.citizen eq 'Citizen'>
			<cfset showAddedInfo="false">
		<cfelse>
			<cfset showAddedInfo="true">
		</cfif>
		<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" fileformat="html" coverpage="false" toc="false" addedinfo="#showAddedInfo#" ltccinfo="false" pgbreaks="false" brandname="LTCC Public Programs">
	<cfelse>
		<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" blankreport="true">
	</cfif>
</cfif>

<cfoutput>done!</cfoutput>