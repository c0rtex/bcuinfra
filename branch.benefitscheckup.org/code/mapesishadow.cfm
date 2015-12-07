<!-- mapping ESI V2 -->
<cfparam name="session.snap_ak_receive" default=""> 
<cfparam name="session.snap_al_receive" default="">
<cfparam name="session.snap_ar_receive" default="">
<cfparam name="session.snap_az_receive" default=""> 
<cfparam name="session.snap_ca_receive" default=""> 
<cfparam name="session.snap_co_receive" default=""> 
<cfparam name="session.snap_ct_receive" default=""> 
<cfparam name="session.snap_dc_receive" default=""> 
<cfparam name="session.snap_de_receive" default=""> 
<cfparam name="session.snap_fl_receive" default=""> 
<cfparam name="session.snap_ga_receive" default=""> 
<cfparam name="session.snap_hi_receive" default=""> 
<cfparam name="session.snap_ia_receive" default=""> 
<cfparam name="session.snap_id_receive" default=""> 
<cfparam name="session.snap_il_receive" default=""> 
<cfparam name="session.snap_in_receive" default=""> 
<cfparam name="session.snap_ks_receive" default=""> 
<cfparam name="session.snap_ky_receive" default=""> 
<cfparam name="session.snap_la_receive" default=""> 
<cfparam name="session.snap_ma_receive" default=""> 
<cfparam name="session.snap_md_receive" default=""> 
<cfparam name="session.snap_me_receive" default=""> 
<cfparam name="session.snap_mi_receive" default=""> 
<cfparam name="session.snap_mn_receive" default=""> 
<cfparam name="session.snap_mo_receive" default=""> 
<cfparam name="session.snap_ms_receive" default=""> 
<cfparam name="session.snap_mt_receive" default=""> 
<cfparam name="session.snap_nc_receive" default=""> 
<cfparam name="session.snap_nd_receive" default=""> 
<cfparam name="session.snap_ne_receive" default=""> 
<cfparam name="session.snap_nh_receive" default=""> 
<cfparam name="session.snap_nj_receive" default=""> 
<cfparam name="session.snap_nm_receive" default=""> 
<cfparam name="session.snap_nv_receive" default=""> 
<cfparam name="session.snap_ny_receive" default=""> 
<cfparam name="session.snap_oh_receive" default=""> 
<cfparam name="session.snap_ok_receive" default=""> 
<cfparam name="session.snap_or_receive" default=""> 
<cfparam name="session.snap_pa_receive" default=""> 
<cfparam name="session.snap_ri_receive" default=""> 
<cfparam name="session.snap_sc_receive" default=""> 
<cfparam name="session.snap_sd_receive" default=""> 
<cfparam name="session.snap_tn_receive" default=""> 
<cfparam name="session.snap_tx_receive" default=""> 
<cfparam name="session.snap_ut_receive" default=""> 
<cfparam name="session.snap_va_receive" default=""> 
<cfparam name="session.snap_vt_receive" default=""> 
<cfparam name="session.snap_wa_receive" default=""> 
<cfparam name="session.snap_wi_receive" default=""> 
<cfparam name="session.snap_wv_receive" default=""> 
<cfparam name="session.snap_wy_receive" default="">
<cfparam name="session.SCSEP_RECEIVE" default="">
<cfparam name="session.esi_interest_pension" default="">
<cfparam name="session.ESI_OTHER_SPECIFY" default="">
<cfif session.esi_interest_pension neq ''>
<cfset session.int_pension = 'y'>
<cfelse>
<cfparam name="session.INT_PENSION" default="">
</cfif>
<!-- default values -->
<cfset session.receive_csfp = "n">   
<cfset session.tefap_receive = "n">

<!-- clean receives -->
<cfif isdefined('session.receive_lis') and session.receive_lis neq ''>
	<cfset session.receive_lis = 'y' >
</cfif>
<cfif isdefined('session.receive_msp') and session.receive_msp neq ''>
	<cfset session.receive_msp = 'y' >
</cfif>
<cfif isdefined('session.receive_propertytax') and session.receive_propertytax neq ''>
	<cfset session.receive_propertytax = 'y' >
</cfif>
<cfif isdefined('session.fdstmp_receive') and session.fdstmp_receive neq ''>
	<cfset session.fdstmp_receive = 'y' >
</cfif>
<cfif isdefined('session.liheap_receive') and session.liheap_receive neq ''>
	<cfset session.liheap_receive = 'y' >
</cfif>
<cfif isdefined('session.med_receive') and session.med_receive neq ''>
	<cfset session.med_receive = 'y' >
</cfif>
<cfif isdefined('session.SCSEP_RECEIVE') and session.SCSEP_RECEIVE neq ''>
	<cfset session.med_receive = 'y' >
</cfif>


<!-- legal -->
<cfif isdefined('session.esi_retire_legal_concerns') and session.esi_retire_legal_concerns neq ''>
	<cfset session.legal = 'y' >
<cfelseif isdefined('session.esi_retire_poa') and  session.esi_retire_poa neq ''>
	<cfset session.legal = 'y' >
<cfelseif isdefined('session.esi_retire_will') and  session.esi_retire_will neq ''>
	<cfset session.legal = 'y' >
</cfif>

<!-- own home -->
<cfif session.esi_housingtype eq 'esi_housingtype_own'>
	<cfset session.housing = 'Own Home'>
<cfelseif session.esi_housingtype eq 'esi_housingtype_rent'>
	<cfset session.housing = 'Rental'>
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
<cfset session.no_hh_members  = session.esi_incomesupport >
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

<cfset session.int_emp = "y">
<cfset session.pri_resident = "">
<cfset session.county = "">
<cfset session.city = "">
<cfset session.county_id = "">
<cfset session.pri_resident = "">
<cfset session.int_vol = "y">
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
