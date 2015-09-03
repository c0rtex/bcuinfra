<cfparam name="session.reloadpage" default="false">
<cfif not session.reloadpage >
<cfset session.reloadpage = true>
<cf_handleScreeningAnswerfield action="get" code="st" element="val" var="preserveStateID">
<cfset preserveSessionID = session.screening.id>
<cfif preserveStateID eq '' and isdefined('session.st')>
	<cfset preserveStateID = session.st > 
</cfif>


<cf_handleScreening action="end" screening_id="#preserveSessionID#">
<cfset session.prev_id = preserveSessionID>
<cfset session.state_id = preserveStateID>
<cfset theList = ''>
<cfset session.subset_id = 67>
<!--- START action:  log the start of a screening and initialize structure --->
<!---Removed Load Screening --->	
<cf_screeningInsert prev_screening_id="#session.prev_id#" source_id="#session.source_id#" org_id="#session.org_id#" partner_id="#session.partner_id#" subset_id="#session.subset_id#" language_id="#session.language_id#" access_id="#session.access_id#" client_id="#session.client_id#" user_id="#session.user_id#" preset_state_id="#preserveStateID#" test_flag="#session.test_id#" var="outvar">			
<!---cfoutput>Debug Text: screeningInsert prev_screening_id="#session.prev_id#" source_id="#session.source_id#" org_id="#session.org_id#" partner_id="#session.partner_id#" subset_id="#session.subset_id#" language_id="#session.language_id#" access_id="#session.access_id#" client_id="#session.client_id#" user_id="#session.user_id#" preset_state_id="#preserveStateID#" test_flag="#session.test_id#" var="outvar cfoutput--->
<cfset session.screening.id = outvar>


<!--- START session info loading --->
	<cfquery name="subsetInfo" datasource="#application.dbSrc#">
		SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text,
			all_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag
		FROM xsubset
		WHERE subset_id=67
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

		<cfset session.subsetRecFlag = 0>
<!--- END session info loading --->

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

<CFSET session.END_TIME = CreateODBCDATETIME(now())>
<cfset session.prg_list = "">
<cfset session.buff_list = "">

<!--- mapping --->
  
<cfif session.esi_housingtype eq 'esi_housingtype_own'>
	<cfset session.housing = 'Own Home'>
<cfelseif session.esi_housingtype eq 'esi_housingtype_rent'>
	<cfset session.housing = 'Rent Dwelling'>
<cfelseif session.esi_housingtype eq 'esi_housingtype_liveothers'>
	<cfset session.housing = 'Live with Others'>
<cfelseif session.esi_housingtype eq 'esi_housingtype_subsidized'>
	<cfset session.housing = 'Subsidized Housing'>
<cfelseif session.esi_housingtype eq 'esi_housingtype_homeless'>
	<cfset session.housing = 'homeless shelter'>
</cfif>
<cfparam name="session.SSI_RECEIVE" default="N">
<cfparam name="session.EAEDC_receive" default="N">
<cfparam name="session.TANF_receive" default="N">
<cfparam name="session.MED_receive" default="N">
<cfparam name="session.tanf_ar_receive" default="N">
<cfparam name="session.general_assist_receive" default="N">
<cfset session.subset_id = 67>
<CFSET SESSION.WANTCHIPS = 'N'>
<cfset session.client = session.esi_client>
<cfset session.client_other  = session.esi_other_specify>
<cfset session.gender = session.esi_gender>
<cfif session.esi_gender eq 'male' or session.esi_gender eq '2-male'>
 <cfset session.gender = 'm'>
<cfelseif session.esi_gender eq 'female' or session.esi_gender eq '3-female'>
 <cfset session.gender = 'f'>
</cfif>
<cfset session.zip  = session.esi_zip>
<cfset session.citizen  = "citizen">
<cfset session.marital_stat  = session.esi_marital>
<cfif session.esi_marital eq 'esi_living_with_partner'>
 <cfset session.marital_stat = "single">
</cfif>
<cfset session.dob_month  = session.esi_birth_month>
<cfset session.dob_year  = session.esi_birth_year>

<cfset session.disabled  = "">
<cfset session.dep_care  = "">

<cfif session.esi_marital eq 'married'>
	<cfset session.no_hh_members  = "2">
<cfelse>
	<cfset session.no_hh_members  = "1">
</cfif>
<cfset session.dep_care = session.esi_healthdisability>
<cfset session.medicare_receive  = session.esi_enrolledmedicare>
<cfset session.receive_partd  = session.esi_enrolledmedicare>
<cfset session.over_60  = "">
<cfset session.hh_depend  = session.esi_incomesupport >
<cfset session.property_tax  = "">
<cfif session.esi_housingtype eq 'esi_housingtype_own' or  session.esi_housingtype eq  'esi_housingtype_rent' >
  <cfset session.utility_2  = "y">
<cfelse>
  <cfset session.utility_2  = "n">
</cfif>
<cfset session.rent  = "">
<cfset session.mortgage  = "">
<cfif session.esi_housingtype eq 'esi_housingtype_own'>
 <cfset session.property_tax = 'y'>
 <cfset session.housing = 'Own Home'>
 <cfset session.mortgage = session.esi_outofpocket>
<cfelseif session.esi_housingtype eq  'esi_housingtype_rent' >
 <cfset session.rent = session.esi_outofpocket>
</cfif>
<cfset session.SKIPASSETS ="Y">
<cfset session.SKIPINC ="Y">
<cfset session.med_costs  = session.esi_healthmonthly>
<cfif session.esi_healthdisability eq 'y'>
	<cfset session.disabled = 1>
</cfif>
<cfif session.esi_dependgrandchild eq 'y'>
	<cfset session.dep_child  = 1>
<cfelse>
	<cfset session.dep_child  = 0>
</cfif>
<cfset session.blind = "n">
<cfset session.dob = SESSION.diffYears >
<cfif SESSION.diffYears gte 60>
	<cfset session.over_60 = 1>
</cfif>
<cfset session.disabled = session.esi_healthdisability>
<cfif session.esi_healthdisability eq 'y'>
	<cfset session.hh_disabled = 1>
<cfelse>
	<cfset session.hh_disabled = 0>
</cfif>

<cfset session.pri_resident = "">
<cfset session.county = "">
<cfset session.city = "">
<cfset session.county_id = "">
<cfset session.pri_resident = "">
		<cfquery datasource="#application.dbSrc#" name="getCounty">
			select z.state_id, s.statetype_id, c.county_id, c.county_name
			from zip z, county c, state s
			where z.zipcode='#session.esi_zip#'
				and z.valid=1
				and z.state_id=s.state_id
				and <cfif session.subset_id neq 59 and session.subset_id neq 3 and session.subset_id neq 62 >
				s.statetype_id=1
				    <cfelseif session.subset_id eq 3 or session.subset_id eq 62>
				(s.statetype_id=1 or s.state_id = 'VI')
				    <cfelse>
				s.state_id = 'VI'
				    </cfif>
				and z.county_id=c.county_id
		</cfquery>
		<cfif getCounty.RecordCount gt 0>
			<cfset session.st = getCounty.state_id>
			<cfset session.state_id = getCounty.state_id>
			<cfset session.pri_resident = 'Y'>
			<cfset session.county_id = getCounty.county_id>
			<cfset session.county = getCounty.county_name>
		</cfif>


<cfset varList = "o-client,s-client_other,g-gender,s-zip,o-citizen,o-marital_stat,n-dob_month,n-dob_year,n-dob,y-disabled,y-dep_care,o-housing,n-hh_disabled,n-no_hh_members,n-over_60,n-hh_depend,
y-property_tax,y-utility_2,n-rent,n-mortgage,n-med_costs,n-dep_child,c-liheap_receive,c-med_receive,c-medicare_receive,c-ssi_receive,c-receive_msp,c-receive_partd,c-receive_lis,n-poverty_index,s-st,s-county,s-county_id,i-s_income_pri_retire,i-sp_income_pri_retire,i-s_sp_income_pri_retire_simple,i-hh_income_pri_retire_simple,i-s_income_dividends,i-sp_income_dividends,i-s_sp_income_dividends_simple,i-hh_income_dividends_simple,i-s_income_ssi,i-sp_income_ssi,i-s_sp_income_ssi_simple,i-hh_income_ssi_simple,i-s_income_ss_disable,i-sp_income_ss_disable,i-s_sp_income_ss_disable_simple,i-hh_income_ss_disable_simple,i-s_income_ss_retire,i-sp_income_ss_retire,i-s_sp_income_ss_retire_simple,i-hh_income_ss_retire_simple,i-s_income_rr_ben,i-sp_income_rr_ben,i-s_sp_income_rr_ben_simple,i-hh_income_rr_ben_simple,i-s_income_vet_ben,i-sp_income_vet_ben,i-s_sp_income_vet_ben_simple,i-hh_income_vet_ben_simple,i-s_income_unemployment,i-sp_income_unemployment,i-s_sp_income_unemployment_simple,i-hh_income_unemployment_simple,i-s_income_unemploy,i-sp_income_unemploy,i-s_sp_income_unemploy_simple,i-hh_income_unemploy_simple,i-s_income_tanf,i-sp_income_tanf,i-s_sp_income_tanf_simple,i-hh_income_tanf_simple,i-s_income_cash_assist,i-sp_income_cash_assist,i-s_sp_income_cash_assist_simple,i-hh_income_cash_assist_simple,i-s_income_other_nw,i-sp_income_other_nw,i-s_sp_income_other_nw_simple,i-hh_income_other_nw_simple,i-s_income_earned,i-sp_income_earned,i-s_sp_income_earned_simple,i-hh_income_earned_simple,a-s_asset_cash,a-sp_asset_cash,a-s_sp_asset_cash_simple,a-hh_asset_cash_simple,a-s_asset_auto1,a-sp_asset_auto1,a-s_sp_asset_auto1_simple,a-hh_asset_auto1_simple,a-s_asset_auto2,a-sp_asset_auto2,a-s_sp_asset_auto2_simple,a-hh_asset_auto2_simple,a-s_asset_home,a-sp_asset_home,a-s_sp_asset_home_simple,a-hh_asset_home_simple,a-s_asset_retirement,a-sp_asset_retirement,a-s_sp_asset_retirement_simple,a-hh_asset_retirement_simple,a-s_asset_stocks,a-sp_asset_stocks,a-s_sp_asset_stocks_simple,a-hh_asset_stocks_simple,a-s_asset_life_cash,a-sp_asset_life_cash,a-s_sp_asset_life_cash_simple,a-hh_asset_life_cash_simple,a-s_asset_life_face,a-sp_asset_life_face,a-s_sp_asset_life_face_simple,a-hh_asset_life_face_simple,a-s_asset_revocable,a-sp_asset_revocable,a-s_sp_asset_revocable_simple,a-hh_asset_revocable_simple,a-s_asset_irrevocable,a-sp_asset_irrevocable,a-s_sp_asset_irrevocable_simple,a-hh_asset_irrevocable_simple,a-s_asset_other_a,a-sp_asset_other_a,a-s_sp_asset_other_a_simple,a-hh_asset_other_a_simple,i-s_sp_income_total_complete,i-s_income_total_complete,i-sp_income_total_complete,i-hh_income_total_complete,i-s_sp_income_total_unearned,i-s_income_total_unearned,i-sp_income_total_unearned,i-hh_income_total_unearned,o-race">

<cfset session.aflist = varList >
<cfset session.poverty_index = session.povertyindex> 


<!--- map af var codes --->
<cfset tmpclient = session.client>
<cfset tmphousing =  session.housing >
<cfset tmpmarital_stat =  session.marital_stat >

<cfset session.citizen  = "13-citizen">
<cfset session.race  = session.esi_ethnicity>

<cfif session.race eq 'american_indian_native_alaskans'>
	<cfset session.race = '1381-american_indian_native_alaskans'>
<cfelseif  session.race eq 'asian'>
	<cfset session.race = '1382-asian'>
<cfelseif  session.race eq 'african_american'>
	<cfset session.race = '1380-african_american'>
<cfelseif  session.race eq 'hispanic'>
	<cfset session.race = '1384-hispanic'>
<cfelseif  session.race eq 'pacific_islander'>
	<cfset session.race = '1383-pacific_islander'>
<cfelseif session.race eq 'white'>
	<cfset  session.race = '1379-white'>
<cfelseif  session.race eq 'other_race'>
	<cfset session.race = '1385-other_race'>
</cfif>


<cfif session.client eq 'Self'>
	<cfset session.client = '1353-self'>
<cfelseif  session.client eq 'Spouse'>
	<cfset session.client = '2345-spouse'>
<cfelseif  session.client eq 'Mother'>
	<cfset session.client = '1354-mother'>
<cfelseif  session.client eq 'Father'>
	<cfset session.client = '1355-father'>
<cfelseif  session.client eq 'Sister'>
	<cfset session.client = '1356-sister'>
<cfelseif  session.client eq 'Brother'>
	<cfset session.client = '1357-brother'>
<cfelseif  session.client eq 'Client'>
	<cfset session.client = '1358-client'>
<cfelseif  session.client eq 'Test'>
	<cfset session.client = '1359-test'>
<cfelseif  session.client eq 'Other'>
	<cfset session.client = '1360-other'>
</cfif>


<cfif session.marital_stat eq 'Single'>
	<cfset session.marital_stat  = '6-single'>
<cfelseif  session.marital_stat  eq 'Married'>
	<cfset session.marital_stat  = '4-married'>
<cfelseif  session.marital_stat  eq 'married_living_sep'>
	<cfset session.marital_stat  = '1361-married_living_sep'>
<cfelseif  session.marital_stat  eq 'Divorced'>
	<cfset session.marital_stat  = '5-divorced'>
<cfelseif  session.marital_stat  eq 'Widowed'>
	<cfset session.marital_stat  = '7-widowed'>
</cfif>




<cfif session.housing eq 'Own Home'>
	<cfset session.housing = '8-own_home'>
<cfelseif  session.housing eq 'Rent Dwelling'>
	<cfset session.housing = '9-rent_dwelling'>
<cfelseif  session.housing eq 'Own Mobile Home'>
	<cfset session.housing = '10-own_mobile_home'>
<cfelseif  session.housing eq 'Boarding Home'>
	<cfset session.housing = '11-boarding_home'>
<cfelseif  session.housing eq 'Live with Others'>
	<cfset session.housing = '12-live_with_others'>
<cfelseif  session.housing eq 'Nursing Facility'>
	<cfset session.housing = '121-nursing_facility'>
<cfelseif  session.housing eq 'Assisted Living'>
	<cfset session.housing = '122-assisted_living'>
<cfelseif  session.housing eq 'Subsidized Housing'>
	<cfset session.housing = '754-subsidized_housing'>
<cfelseif  session.housing eq 'Homeless Shelter'>
	<cfset session.housing = '1074-homeless_shelter'>
</cfif>





<cf_logScreeningInput  structname="session" >
<cf_handleScreening action="end" screening_id="#session.screening.id#">
<cfset session.citizen  = "citizen">
<cfset session.client = tmpclient>
<cfset session.marital_stat = tmpmarital_stat>
<cfset session.housing = tmphousing >


<!--- This code is to strip leading zeroes off the household number, so we don't look up a column with a name like "mem02" --->
<cfif isDefined("session.no_hh_members")>
	<cfset session.no_hh_members = val(session.no_hh_members)>
</cfif>
<cfif isDefined("session.hh_disabled")>
	<cfset session.hh_disabled = val(session.hh_disabled)>
</cfif>
<cfif isDefined("session.over_60")>
	<cfset session.over_60 = val(session.over_60)>
</cfif>
<cfset session.ssi_receive = 'N'>
<cfif (session.s_income_ssi + session.sp_income_ssi + session.s_sp_income_ssi) gt 0 >
	<cfset session.ssi_receive = 'Y'>
</cfif>
<!---cfdump var="#session#"--->
<!---  The "normal" pass --->
<cf_tagTestRules ynDoBuffer="FALSE" debugOutput="false">

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
	<cfset goto="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
<!---cfoutput>
TEMPORARY LINK FOR DEBUGGING PURPOSES:<br>
click below to continue on and submit application<br>
<a href="#goto#">View Report</a><br><br>

subset_id = #session.subset_id#<br>
partner_id = #session.partner_id#<br>
subsetRecFlag = #session.subsetRecFlag#<br>
PrgList = #session.prg_list#<br />
</cfoutput--->
</cfif>
<!---cfoutput> <h2>Screening ID: #session.screening.id#   #session.esi_gender# #session.gender# #session.race#</h2></cfoutput--->