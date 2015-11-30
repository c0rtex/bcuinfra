<cfparam name="session.poverty_index" default="0">
<cfparam name="SESSION.mqc_zipcode" default="0">
<cfparam name="getcounty.county_id" default="1">
<cfparam name="getcounty.county_name" default="">
<cfset functionDebugging = false>
<cfset esiSiteArray = ArrayNew(1)>

    
<!--- See if county in esiSiteArray matches submitted zipcode --->
<cfquery name="getcounty_esisite" datasource="#application.dbSrc#">
	select  z.zipcode, z.county_id, c.*
	from county c, zip z
	where c.county_id = z.county_id
		<cfif isdefined('session.mqc_zipcode')>
			and z.zipcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mqc_zipcode#">
		<cfelse>
			and (1 = 0)
		</cfif>
</cfquery>

<cfloop from="1" to="#ArrayLen(esiSiteArray)#" index="i">
	<cfif esiSiteArray[i]['county_id'] EQ getcounty_esisite.county_id>
		<cfset esiSite = i>
	</cfif>	
</cfloop>


<!-- Start Loading a New Screening for the Shadow Screening Results -->

<cf_handleScreeningAnswerfield action="get" code="st" element="val" var="preserveStateID">
<cfset preserveSessionID = session.screening.id>
<cfif preserveStateID eq '' and isdefined('session.st')>
	<cfset preserveStateID = session.st > 
</cfif>

<cf_handleScreening action="end" screening_id="#preserveSessionID#">
<cfset session.prev_id = preserveSessionID>
<cfset session.state_id = preserveStateID>
<cfset theList = ''>
<cfset session.subset_id = 71>
<!--- START action:  log the start of a screening and initialize structure --->
<!---Removed Load Screening --->	
<cf_screeningInsert prev_screening_id="#session.prev_id#" source_id="#session.source_id#" org_id="#session.org_id#" partner_id="#session.partner_id#" subset_id="#session.subset_id#" language_id="#session.language_id#" access_id="#session.access_id#" client_id="#session.client_id#" user_id="#session.user_id#" preset_state_id="#preserveStateID#" test_flag="#session.test_id#" var="outvar">			
<cfif functionDebugging>
	<cfoutput>Debug Text: screeningInsert prev_screening_id="#session.prev_id#" source_id="#session.source_id#" org_id="#session.org_id#" partner_id="#session.partner_id#" subset_id="#session.subset_id#" language_id="#session.language_id#" access_id="#session.access_id#" client_id="#session.client_id#" user_id="#session.user_id#" preset_state_id="#preserveStateID#" test_flag="#session.test_id#" var="outvar </cfoutput>
</cfif>
<cfset session.screening.id = outvar>
<cfset session.screening_id = outvar>

<!--- START session info loading --->
	<cfquery name="subsetInfo" datasource="#application.dbSrc#">
		SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text,
			all_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag
		FROM xsubset
		WHERE subset_id=71
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

<!--- mapping  --->
<cfinclude template="mapmqcshadow.cfm">
<cfset session.receive_csfp = "n">   
<cfset session.tefap_receive = "n">
<cfset session.legal = "" >

<cfparam name="session.SSI_RECEIVE" default="N">
<cfparam name="session.EAEDC_receive" default="N">
<cfparam name="session.TANF_receive" default="N">
<cfparam name="session.MED_receive" default="N">
<cfparam name="session.tanf_ar_receive" default="N">
<cfparam name="session.general_assist_receive" default="N">
<cfset session.subset_id = 71>
<CFSET SESSION.WANTCHIPS = 'N'>
<cfset session.client = session.mqc_client>
<cfset session.client_other  = "">
<cfset session.gender = session.mqc_gender>
<cfif session.mqc_gender eq 'male' or session.mqc_gender eq '2-male'>
 <cfset session.gender = 'm'>
<cfelseif session.mqc_gender eq 'female' or session.mqc_gender eq '3-female'>
 <cfset session.gender = 'f'>
</cfif>
<cfset session.zip  = session.mqc_zipcode>
<cfset session.citizen  = "citizen">
<cfset session.marital_stat  = session.mqc_marital>
<cfif session.mqc_marital eq 'mqc_living_with_partner'>
 <cfset session.marital_stat = "single">
</cfif>
<cfset session.dob_month  = session.mqc_birth_month>
<cfset session.dob_year  = session.mqc_birth_year>
<cfset session.dob_day  = session.mqc_birth_day>

<cfset session.disabled  = "">
<cfset session.dep_care  = "">
<!---income--->
<!---assets--->
<!-- mqc_income -->
<cfif session.mqc_income_over eq 'y'>
	<cfset session.s_income_total_unearned =  3001>
	<cfset session.s_income_total_complete =  3001>
</cfif>
<cfif session.mqc_income_range1 eq 'y'>
	<cfset session.s_income_total_unearned =  2000>
	<cfset session.s_income_total_complete =  2000>
</cfif>
<cfif session.mqc_income_range2 eq 'y'>
	<cfset session.s_income_total_unearned =  1500>
	<cfset session.s_income_total_complete =  1500>
</cfif>
<cfif session.mqc_income_range3 eq 'y'>
	<cfset session.s_income_total_unearned =  1000>
       <cfset session.s_income_total_complete =  1000>
</cfif>
<cfif session.mqc_income_under eq 'y'>
	<cfset session.s_income_total_unearned =  0>
	<cfset session.s_income_total_complete =  0>
</cfif>

<!-- mqc_asset -->
<cfif session.mqc_asset_over eq 'y'>
	<cfset session.s_asset_total_complete =  27001>
</cfif>
<cfif session.mqc_asset_range1 eq 'y'>
	<cfset session.s_asset_total_complete =  20000>
</cfif>
<cfif session.mqc_asset_range2 eq 'y'>
	<cfset session.s_asset_total_complete =  14000>
</cfif>
<cfif session.mqc_asset_range3 eq 'y'>
	<cfset session.s_asset_total_complete =  6000>
</cfif>
<cfif session.mqc_asset_under eq 'y'>
	<cfset session.s_asset_total_complete  =  0>
</cfif>


<cfif session.mqc_marital eq 'married'>
	<cfset session.no_hh_members  = "2">
<cfelse>
	<cfset session.no_hh_members  = "1">
</cfif>
<cfset session.dep_care = "">
<cfset session.medicare_receive  = "y">
<cfset session.receive_partd  = "">
<cfset session.over_60  = "">
<cfset session.hh_depend  = "" >
<cfset session.property_tax  = "">
  <cfset session.utility_2  = "n">
<cfset session.rent  = "">
<cfset session.mortgage  = "">
 <cfset session.property_tax = 'y'>
 <cfset session.housing = 'Own Home'>
 <cfset session.mortgage = "">
<cfset session.SKIPASSETS ="Y">
<cfset session.SKIPINC ="Y">
<cfset session.med_costs  = "">
	<cfset session.disabled = 1>
	<cfset session.dep_child  = 1>
<cfset session.blind = "n">
<cfset session.dob = 66 >
<cfif session.dob gte 60>
	<cfset session.over_60 = 1>
</cfif>
	<cfset session.hh_disabled = 1>

<cfset session.pri_resident = "">
<cfset session.county = "">
<cfset session.city = "">
<cfset session.county_id = "">
<cfset session.pri_resident = "">
		<cfquery datasource="#application.dbSrc#" name="getCounty">
			select z.state_id, s.statetype_id, c.county_id, c.county_name
			from zip z, county c, state s
			where z.zipcode='#session.mqc_zipcode#'
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


<cfset varList = "o-client,s-client_other,g-gender,s-zip,o-citizen,o-marital_stat,n-dob_month,n-dob_year,n-dob,y-disabled,y-dep_care,o-housing,n-hh_disabled,n-no_hh_members,n-over_60,n-hh_depend,y-property_tax,y-utility_2,n-rent,n-mortgage,n-med_costs,n-dep_child,c-snap_#session.state_id#_receive,c-liheap_receive,c-med_receive,c-medicare_receive,c-ssi_receive,c-receive_msp,c-receive_partd,c-receive_lis,n-poverty_index,s-st,s-county,s-county_id,i-s_income_pri_retire,i-sp_income_pri_retire,i-s_sp_income_pri_retire_simple,i-hh_income_pri_retire_simple,i-s_income_dividends,i-sp_income_dividends,i-s_sp_income_dividends_simple,i-hh_income_dividends_simple,i-s_income_ssi,i-sp_income_ssi,i-s_sp_income_ssi_simple,i-hh_income_ssi_simple,i-s_income_ss_disable,i-sp_income_ss_disable,i-s_sp_income_ss_disable_simple,i-hh_income_ss_disable_simple,i-s_income_ss_retire,i-sp_income_ss_retire,i-s_sp_income_ss_retire_simple,i-hh_income_ss_retire_simple,i-s_income_rr_ben,i-sp_income_rr_ben,i-s_sp_income_rr_ben_simple,i-hh_income_rr_ben_simple,i-s_income_vet_ben,i-sp_income_vet_ben,i-s_sp_income_vet_ben_simple,i-hh_income_vet_ben_simple,i-s_income_unemployment,i-sp_income_unemployment,i-s_sp_income_unemployment_simple,i-hh_income_unemployment_simple,i-s_income_unemploy,i-sp_income_unemploy,i-s_sp_income_unemploy_simple,i-hh_income_unemploy_simple,i-s_income_tanf,i-sp_income_tanf,i-s_sp_income_tanf_simple,i-hh_income_tanf_simple,i-s_income_cash_assist,i-sp_income_cash_assist,i-s_sp_income_cash_assist_simple,i-hh_income_cash_assist_simple,i-s_income_other_nw,i-sp_income_other_nw,i-s_sp_income_other_nw_simple,i-hh_income_other_nw_simple,i-s_income_earned,i-sp_income_earned,i-s_sp_income_earned_simple,i-hh_income_earned_simple,a-s_asset_cash,a-sp_asset_cash,a-s_sp_asset_cash_simple,a-hh_asset_cash_simple,a-s_asset_auto1,a-sp_asset_auto1,a-s_sp_asset_auto1_simple,a-hh_asset_auto1_simple,a-s_asset_auto2,a-sp_asset_auto2,a-s_sp_asset_auto2_simple,a-hh_asset_auto2_simple,a-s_asset_home,a-sp_asset_home,a-s_sp_asset_home_simple,a-hh_asset_home_simple,a-s_asset_retirement,a-sp_asset_retirement,a-s_sp_asset_retirement_simple,a-hh_asset_retirement_simple,a-s_asset_stocks,a-sp_asset_stocks,a-s_sp_asset_stocks_simple,a-hh_asset_stocks_simple,a-s_asset_life_cash,a-sp_asset_life_cash,a-s_sp_asset_life_cash_simple,a-hh_asset_life_cash_simple,a-s_asset_life_face,a-sp_asset_life_face,a-s_sp_asset_life_face_simple,a-hh_asset_life_face_simple,a-s_asset_revocable,a-sp_asset_revocable,a-s_sp_asset_revocable_simple,a-hh_asset_revocable_simple,a-s_asset_irrevocable,a-sp_asset_irrevocable,a-s_sp_asset_irrevocable_simple,a-hh_asset_irrevocable_simple,a-s_asset_other_a,a-sp_asset_other_a,a-s_sp_asset_other_a_simple,a-hh_asset_other_a_simple,i-s_sp_income_total_complete,i-s_income_total_complete,i-sp_income_total_complete,i-hh_income_total_complete,i-s_sp_income_total_unearned,i-s_income_total_unearned,i-sp_income_total_unearned,i-hh_income_total_unearned,o-race,y-mqc_receive_hsa">

<cfset session.aflist = varList >
<cfparam name="session.povertyindex" default="0">
<cfset session.poverty_index = session.povertyindex> 

<!--- map af var codes --->

<cfset tmpclient = session.client>
<cfset tmphousing =  session.housing >
<cfset tmpmarital_stat =  session.marital_stat >

<cfset session.citizen  = "13-citizen">
<cfset session.race  = "">

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
<cfelseif  session.housing eq 'Rental'>
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


<cfset UNSEENVAL = 0>
<!--- get the program component  --->
<cfinvoke
    component="programHandler" 
    method="getProgramPool"
    returnVariable="queryPrograms">
<cfset session.listProgram_id = "">
<cfloop list="#session.prg_list#" index="prg_id">
<cfset prg_id = replacenocase(prg_id, "'","","all")>
<!--- set the function that we want dynamically then call it (it's a two step process) --->
<cfinvoke  legacy_prg_id = "#prg_id#"
    component="programHandler" 
    method="getProgramIDByLegacyID"
    returnVariable="program_id">
	<cfset unseenAdjustedVal = unseenVal>
	<cfif unseenVal eq 0>
		<cfif Mid(prg_id, Find('-', prg_id) + 1, Find('-', prg_id, Find('-', prg_id) + 1) - Find('-', prg_id) - 1) eq '333'>
			<cfset unseenAdjustedVal = 1>
		</cfif>
	</cfif>
	<cfif listcontains(session.listProgram_id,program_id) eq 0>
	<cfquery name="insertprograms" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #program_id#, #unseenAdjustedVal#, 0, 0)
	</CFQUERY>
	<cfset session.listProgram_id = listappend(session.listProgram_id,program_id)>
	</cfif>
</cfloop>


