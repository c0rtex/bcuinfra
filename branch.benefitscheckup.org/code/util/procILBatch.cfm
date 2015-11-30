<cfset session.source_id = 7>
<cfset session.test_id = "0">	
<cfset session.client = "Client">
<cfset session.race = "">	
<cfset session.receive_va = "N">	
<cfset session.veteran = "N">
<cfset session.ssi_receive	= "">
<cfset session.int_vol = "Y">
<cfset session.dob_year = "1947">
<cfset session.dob_month = "01">
<cfset SESSION.INT_MEDICARE_2 = "">
<cfset SESSION.INT_RETIRE_TAX_ESTATE_PLANNING = "">
<cfset SESSION.EYECARE = "">
<cfset SESSION.INT_CAREGIVER_RESPITE = "">	    
<cfset SESSION.EYECARE = "">
<cfset SESSION.SNAP_AK_RECEIVE = "">
<cfset SESSION.SCSEP_RECEIVE = "">
<cfset SESSION.INT_HEALTH_CENTER = "">
<cfset SESSION.INT_HOMEOWNERS_INSURANCE  = "">
<cfset SESSION.INT_RETIRE_TAX_ESTATE_PLANNING = "">
<cfset SESSION.INT_CAREGIVER_RESPITE  = "">
<cfset SESSION.SNAP_AL_RECEIVE = "">
<cfset SESSION.hh_disabled = 1>
<cfset SESSION.receive_va = "">
<cfset SESSION.SNAP_IL_RECEIVE = "">
<cfset session.property_tax = "y">
<cfset session.int_homeowners_insurance = "y">
<cfset session.int_retire_tax_estate_planning  = "y">
<cfset session.int_medicare_2  = "y">
<cfset session.int_health_center = "y">
<cfset session.int_vol = "y">
<cfset session.int_assistech = "y">
<cfset session.int_emp = "y">
<cfset session.legal = "y">
<cfset session.int_caregiver_respite = "y">
<cfset session.int_trans_personal = "y">
<cfset session.int_deaf = "y">
<cfset session.citizen = "Citizen">
<cfset session.pri_resident = "Y">
<cfset session.eyecare = "N">
<cfset session.reverse_mortgage = "Y">
<cfset session.medicare_receive  = "Y">
<cfset session.property_tax = "Y">
<cfparam name="session.reloadpage" default="false">
<cfquery name="ildata" datasource="#application.dbSrc#">
select * from ilscreeningdata where uniqueID > 2022624 order by uniqueID  limit 14000
</cfquery>
<h2>Starting...Run number 9........</h2><cfflush>
<cfloop query="ildata">
<cfsilent>
	<cfset session.client_id = ildata.UNIQUEID>
	<cfset session.dob = ildata.age>
	<cfset session.s_income_total_complete = ildata.clientincome>
	<cfset session.s_income_total_complete = session.s_income_total_complete/12>
	<cfset SESSION.s_asset_total_complete = ildata.assets>
	<cfset session.state_id = ildata.STATE >
	<cfset session.zip = ildata.zipCD>
	<cfset session.city = ildata.city>
	<cfset session.no_hh_members  = ildata.HH_SIZE>
	<cfset session.marital_stat = ildata.MARITAL_STATUS>
	<cfset session.receive_lis = ildata.LISSTATUS>
	<cfset session.povertyindex = ildata.POVERTY_INDEX>
	<cfif session.marital_stat eq 1>
		<cfset session.marital_stat = "4-married">
	<cfelse>
		<cfset session.marital_stat = "6-single">
	</cfif>
	<cfif session.receive_lis neq 'NA'>
		<cfset session.receive_lis = "Y">
	<cfelse>
		<cfset session.receive_lis = "N">
	</cfif>	
<!---cfdump var="#ildata#"--->
<!---cfdump var="#session#"--->
<cfif ildata.agency_name eq 'AgeOptions'>
  <cfset session.partner_id = 61>
<cfelseif ildata.agency_name eq 'City of Chicago'>
  <cfset session.partner_id = 81>
</cfif>
<cfif session.city eq 'chicago'>
  <cfset session.city = "2376-chicago">
<cfelse>
  <cfset session.city = "2378-notchi">
</cfif>

<cfset theList = ''>
<cfset session.subset_id = 69>
<!--- START action:  log the start of a screening and initialize structure --->
<!---Removed Load Screening --->	
<cf_screeningInsert prev_screening_id="" source_id="7" org_id="" partner_id="#session.partner_id#" subset_id="#session.subset_id#" language_id="EN" access_id="" client_id="#session.client_id#" user_id="" preset_state_id="#session.state_id#" test_flag="#session.test_id#" var="outvar">			
<cfset session.screening.id = outvar>
<cfset session.screening_id = session.screening.id>


<!--- START session info loading --->
	<cfquery name="subsetInfo" datasource="#application.dbSrc#">
		SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text,
			all_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag
		FROM xsubset
		WHERE subset_id=69
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
<cfset session.receive_msp = "">
<!--- mapping --->
<cfset SESSION.tefap_receive = "N">  
<cfset SESSION.receive_csfp = "N">
<cfset SESSION.int_emp = "Y">
<cfset SESSION.scsep_receive = "N">
<cfset SESSION.int_def = "Y">
<cfset SESSION.int_deaf = "Y">
<cfset SESSION.int_assistech = "Y">
<cfparam name="session.SSI_RECEIVE" default="">
<cfparam name="session.EAEDC_receive" default="N">
<cfparam name="session.TANF_receive" default="N">
<cfparam name="session.MED_receive" default="N">
<cfparam name="session.tanf_ar_receive" default="N">
<cfparam name="session.general_assist_receive" default="N">
<cfset session.subset_id = 69>
<CFSET SESSION.WANTCHIPS = 'N'>
<cfset session.citizen  = "citizen">
<cfset session.disabled  = "y">
<cfset session.dep_care  = "y">
<cfset session.utility_2 = "y">
<cfset session.SKIPASSETS ="Y">
<cfset session.SKIPINC ="Y">
<cfset session.county = "">
<cfset session.county_id = "">
<cfset session.housing = "8-own_home">
<cfset session.chronic_condition = "2603-chroniccondition_1">
<cfif session.marital_stat eq "4-married">
	<cfset session.over_60 = 2>
	<cfset session.hh_depend = 2>
<cfelse>
	<cfset session.over_60 = 1>
	<cfset session.hh_depend = 1>
</cfif>


<cfif session.receive_lis eq "y">
	<cfset session.receive_partd = "y">
<cfelse>
	<cfset session.receive_partd = "n">
</cfif>

		<cfquery datasource="#application.dbSrc#" name="getCounty">
			select z.state_id, s.statetype_id, c.county_id, c.county_name
			from zip z, county c, state s
			where z.zipcode='#session.zip#'
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
<cfset varList = "o-city,c-tefap_receive,c-receive_csfp,y-reverse_mortgage,c-int_emp,c-scsep_receive,c-int_def,c-int_assistech,c-legal,c-int_homeowners_insurance,c-int_retire_tax_estate_planning,c-int_medicare_2,c-int_health_center,c-int_vol,c-int_caregiver_respite,c-int_trans_personal,c-int_deaf,o-chronic_condition,o-client,s-client_other,s-zip,o-citizen,o-marital_stat,n-dob_month,n-dob_year,n-dob,y-disabled,y-dep_care,o-housing,n-hh_disabled,n-no_hh_members,n-over_60,n-hh_depend,y-property_tax,y-utility_2,n-rent,n-mortgage,n-med_costs,n-dep_child,c-liheap_receive,c-SNAP_IL_RECEIVE,c-receive_va,c-med_receive,c-medicare_receive,c-ssi_receive,c-receive_msp,c-receive_partd,c-receive_lis,n-poverty_index,s-st,s-county,s-county_id,i-s_income_pri_retire,i-sp_income_pri_retire,i-s_sp_income_pri_retire_simple,i-hh_income_pri_retire_simple,i-s_income_dividends,i-sp_income_dividends,i-s_sp_income_dividends_simple,i-hh_income_dividends_simple,i-s_income_ssi,i-sp_income_ssi,i-s_sp_income_ssi_simple,i-hh_income_ssi_simple,i-s_income_ss_disable,i-sp_income_ss_disable,i-s_sp_income_ss_disable_simple,i-hh_income_ss_disable_simple,i-s_income_ss_retire,i-sp_income_ss_retire,i-s_sp_income_ss_retire_simple,i-hh_income_ss_retire_simple,i-s_income_rr_ben,i-sp_income_rr_ben,i-s_sp_income_rr_ben_simple,i-hh_income_rr_ben_simple,i-s_income_vet_ben,i-sp_income_vet_ben,i-s_sp_income_vet_ben_simple,i-hh_income_vet_ben_simple,i-s_income_unemployment,i-sp_income_unemployment,i-s_sp_income_unemployment_simple,i-hh_income_unemployment_simple,i-s_income_unemploy,i-sp_income_unemploy,i-s_sp_income_unemploy_simple,i-hh_income_unemploy_simple,i-s_income_tanf,i-sp_income_tanf,i-s_sp_income_tanf_simple,i-hh_income_tanf_simple,i-s_income_cash_assist,i-sp_income_cash_assist,i-s_sp_income_cash_assist_simple,i-hh_income_cash_assist_simple,i-s_income_other_nw,i-sp_income_other_nw,i-s_sp_income_other_nw_simple,i-hh_income_other_nw_simple,i-s_income_earned,i-sp_income_earned,i-s_sp_income_earned_simple,i-hh_income_earned_simple,a-s_asset_cash,a-sp_asset_cash,a-s_sp_asset_cash_simple,a-hh_asset_cash_simple,a-s_asset_auto1,a-sp_asset_auto1,a-s_sp_asset_auto1_simple,a-hh_asset_auto1_simple,a-s_asset_auto2,a-sp_asset_auto2,a-s_sp_asset_auto2_simple,a-hh_asset_auto2_simple,a-s_asset_home,a-sp_asset_home,a-s_sp_asset_home_simple,a-hh_asset_home_simple,a-s_asset_retirement,a-sp_asset_retirement,a-s_sp_asset_retirement_simple,a-hh_asset_retirement_simple,a-s_asset_stocks,a-sp_asset_stocks,a-s_sp_asset_stocks_simple,a-hh_asset_stocks_simple,a-s_asset_life_cash,a-sp_asset_life_cash,a-s_sp_asset_life_cash_simple,a-hh_asset_life_cash_simple,a-s_asset_life_face,a-sp_asset_life_face,a-s_sp_asset_life_face_simple,a-hh_asset_life_face_simple,a-s_asset_revocable,a-sp_asset_revocable,a-s_sp_asset_revocable_simple,a-hh_asset_revocable_simple,a-s_asset_irrevocable,a-sp_asset_irrevocable,a-s_sp_asset_irrevocable_simple,a-hh_asset_irrevocable_simple,a-s_asset_other_a,a-sp_asset_other_a,a-s_sp_asset_other_a_simple,a-hh_asset_other_a_simple,a-s_asset_total_complete,i-s_sp_income_total_complete,i-s_income_total_complete,i-sp_income_total_complete,i-hh_income_total_complete,i-s_sp_income_total_unearned,i-s_income_total_unearned,i-sp_income_total_unearned,i-hh_income_total_unearned,o-race,y-veteran,y-pri_resident,y-eyecare">
<cfset session.aflist = varList >
<cfset session.poverty_index = session.povertyindex> 
<!--- map af var codes --->
<cfset session.citizen  = "13-citizen">
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
<cf_logScreeningInput  structname="session" >
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
<cfset session.chronic_condition = "One Chronic Condition">
<cfset session.housing = "Own Home">
<cfset session.citizen  = "citizen">

<cfif session.city eq '2376-chicago'>
  <cfset session.city = "chicago">
<cfelseif session.city eq '2378-notchi'>
  <cfset session.city = "Suburban Cook County">
</cfif>
<SESSION.reverse_mortgage = "Y">
<cfset tmpPartner_id = session.partner_id>
<cfset session.partner_id = 0>
<cf_tagTestRulesILBatch ynDoBuffer="FALSE" debugOutput="false">
<cfset session.partner_id = tmpPartner_id>
<cfif Not IsDefined('session.subset_id') Or session.subset_id neq 1>
<!--- 07/09/2002 REM  Now we set up for Buffer --->
<!--- need to offset the total figures by 500 and 100 respectively --->
<CFSET SESSION.S_asset_TOTAL_COMPLETE = SESSION.s_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.S_SP_asset_TOTAL_COMPLETE = SESSION.S_SP_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.HH_asset_TOTAL_COMPLETE = SESSION.HH_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.S_INCOME_TOTAL_COMPLETE = SESSION.s_INCOME_TOTAL_COMPLETE - 100>
<CFSET SESSION.S_SP_INCOME_TOTAL_COMPLETE = SESSION.S_SP_INCOME_TOTAL_COMPLETE - 100>
<CFSET SESSION.HH_INCOME_TOTAL_COMPLETE = SESSION.HH_INCOME_TOTAL_COMPLETE - 100>
<cf_tagTestRulesILBatch ynDoBuffer="TRUE">
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
<!--- Delete programs based on special asset and income rules --->
<cfloop list="#session.prg_list#" index="prg_id">
	<cfset ignoreflag = 0>
	<cfoutput>	
	<cfset listpos = #ListContainsNoCase(session.prg_list,prg_id)#>
	<cfif prg_id eq "'101-302-1023-FD-FD'"><h3>program  101-302-1023-FD-FD  #session.s_income_total_complete#  #session.s_asset_total_complete#</h3></cfif>
	<cfif session.marital_stat eq 'single'>
		<cfif prg_id eq "'101-302-1023-FD-FD'" and (session.s_income_total_complete gt 718 or session.s_asset_total_complete gt 2000) >
	       <cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		<h3>program deleted 101-302-1023-FD-FD </h3>
		</cfif>
		<cfif prg_id eq "'103-308-2076-IL-ST'" and ( session.s_income_total_complete gt 976 or session.s_asset_total_complete gt 2000 ) >
		<h3>program deleted 103-308-2076-IL-ST</h3>
		<cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
		<cfif prg_id eq "'103-309-1031-FD-FD'" and ( session.s_income_total_complete gt 956 or session.s_asset_total_complete gt 6940 ) >
		<h3>program deleted 103-309-1031-FD-FD</h3>
		 <cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
		<cfif prg_id eq "'103-309-1032-FD-FD'" and ( session.s_income_total_complete gt 1142 or session.s_asset_total_complete gt 6940 ) >
		<h3>program deleted 103-309-1032-FD-FD</h3>
		<cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
		<cfif prg_id eq "'103-309-1071-FD-FD'" and ( session.s_income_total_complete gt 1282 or session.s_asset_total_complete gt 6940 ) >
		<h3>program deleted 103-309-1071-FD-FD</h3>
		 <cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
		<cfif prg_id eq "'XXX-308-1573-IL-ST'" and ( session.s_income_total_complete gt 976 or session.s_asset_total_complete gt 2000 ) >
		<h3>program deleted XXX-308-1573-IL-ST</h3>
		<cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
		<cfif prg_id eq "'XXX-309-1556-IL-ST'" and  session.s_asset_total_complete gt 17500  >
		<h3>program deleted XXX-309-1556-IL-ST</h3>
		<cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
		
	<cfelse>
		<cfif prg_id eq "'101-302-1023-FD-FD'" and ( session.s_income_total_complete gt 1068 or session.s_asset_total_complete gt 3000 ) >
		<h3>program deleted 101-302-1023-FD-FD</h3>
		 <cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
		<cfif prg_id eq "'103-308-2076-IL-ST'" and ( session.s_income_total_complete gt 1306 or session.s_asset_total_complete gt 3000 ) >
		<h3>program deleted 103-308-2076-IL-ST</h3>
		 <cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
		<cfif prg_id eq "'103-309-1031-FD-FD'" and ( session.s_income_total_complete gt 1311 or session.s_asset_total_complete gt 10490 ) >
		<h3>program deleted 103-309-1031-FD-FD</h3>
		 <cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
		<cfif prg_id eq "'103-309-1032-FD-FD'" and ( session.s_income_total_complete gt 1563 or session.s_asset_total_complete gt 10490 ) >
		<h3>program deleted 103-309-1032-FD-FD</h3>
		 <cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
		<cfif prg_id eq "'103-309-1071-FD-FD'" and ( session.s_income_total_complete gt 1752 or session.s_asset_total_complete gt 10490 ) >
		<h3>program deleted 103-309-1071-FD-FD</h3>
		 <cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
		<cfif prg_id eq "'XXX-308-1573-IL-ST'" and ( session.s_income_total_complete gt 1306 or session.s_asset_total_complete gt 3000 ) >
		<h3>program deleted XXX-308-1573-IL-ST</h3>
		 <cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
		 <cfif prg_id eq "'XXX-309-1556-IL-ST'" and session.s_asset_total_complete gt 17500  >
		<h3>program deleted XXX-309-1556-IL-ST</h3>
		 <cfset session.prg_list = #ListDeleteAt(session.prg_list,listpos)#><cfset ignoreflag = 1>
		</cfif>
	</cfif>
	<cfset unseenAdjustedVal = unseenVal>
	<cfif unseenVal eq 0>
		<cfif Mid(prg_id, Find('-', prg_id) + 1, Find('-', prg_id, Find('-', prg_id) + 1) - Find('-', prg_id) - 1) eq '333'>
			<cfset unseenAdjustedVal = 1>
		</cfif>
	</cfif>
	<cfif prg_id neq 'XXX-311-2387-FD-FD' and ignoreflag eq 0>
	<cfquery name="insertprograms" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenAdjustedVal#, 0, 0)
	</CFQUERY>
	</cfif>
	</cfoutput>
</cfloop>
<cfif session.wantchips eq 'Y'>
	<CFQUERY NAME="insertchips" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, '103-309-2191-FD-FD')#, #unseenVal#, 0, 0)
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
	<cfset goto="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
<cf_handleScreening action="end" screening_id="#session.screening.id#">
</cfsilent>
</cfloop>
</table>
<h2>Complete</h2>	