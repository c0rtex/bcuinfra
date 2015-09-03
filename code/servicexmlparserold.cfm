<!-- This script takes an input xml file from the screenforbenefits.cfc parses the xml and passes the variables into the bcu screening--> <!-- Try and Catch all processing errors --> 
<cfparam name="testresponse" default="1">
<cfparam name="request.partner_id" default="47">
<cfparam name="request.client_id" default="0">
<cfparam name="request.org_id" default="0">
<cfparam name="request.partner_screening_id" default="">
<cfparam name="PROGRAM_XML" default="">

<!-- default test parameter xml string -->
<cfif testresponse and not isdefined('response_list')>
<cfset xmlstring = '
<?xml version="1.0" encoding="utf-16"?>
<ScreeningSet>
  <Screening Subset_id="41">
    <Answers>
      <Answer AnswerField="ct_thrd_pty_xnd" AnswerValue="Y" />
      <Answer AnswerField="ct_mail_xnd" AnswerValue="N" />
      <Answer AnswerField="ct_receive_medicare_xnd" AnswerValue="Y" />
      <Answer AnswerField="ct_older_xnd" AnswerValue="Y" />
      <Answer AnswerField="ct_ss_disblty_xnd" AnswerValue="N" />
      <Answer AnswerField="ct_live" AnswerValue="TX" />
      <Answer AnswerField="ct_mrtl_stus" AnswerValue="separated" />
      <Answer AnswerField="be_sav_lmt_xnd" AnswerValue="N" />
      <Answer AnswerField="be_thrd_fnm" AnswerValue="Human Arc" />
      <Answer AnswerField="be_thrd_mnm" AnswerValue="" />
      <Answer AnswerField="be_thrd_lnm" AnswerValue="Human Arc" />
      <Answer AnswerField="be_thrd_rel" AnswerValue="rel_agency" />
      <Answer AnswerField="be_thrd_rel_oth" AnswerValue="" />
      <Answer AnswerField="be_thrd_phnarea" AnswerValue="866" />
      <Answer AnswerField="be_thrd_phnexch" AnswerValue="297" />
      <Answer AnswerField="be_thrd_phnnum" AnswerValue="3160" />
      <Answer AnswerField="be_thrd_addrln_1" AnswerValue="1457 East 40th Street" />
      <Answer AnswerField="be_thrd_apt_no" AnswerValue="" />
      <Answer AnswerField="be_thrd_addrln_2" AnswerValue="" />
      <Answer AnswerField="be_thrd_addrln_3" AnswerValue="" />
      <Answer AnswerField="be_thrd_addr_city" AnswerValue="Cleveland" />
      <Answer AnswerField="be_thrd_addr_st" AnswerValue="OH" />
      <Answer AnswerField="be_thrd_addr_zip5" AnswerValue="44103" />
      <Answer AnswerField="be_clnt_fnm" AnswerValue="Marjorie J" />
      <Answer AnswerField="be_clnt_mnm" AnswerValue="" />
      <Answer AnswerField="be_clnt_lnm" AnswerValue="Hayden" />
      <Answer AnswerField="be_clnt_sfx" AnswerValue="" />
      <Answer AnswerField="be_clnt_cossn" AnswerValue="458440498" />
      <Answer AnswerField="be_clnt_dob_month" AnswerValue="11" />
      <Answer AnswerField="be_clnt_dob_day" AnswerValue="5" />
      <Answer AnswerField="be_clnt_dob_year" AnswerValue="1933" />
      <Answer AnswerField="be_clnt_wrkd_l2yr_xnd" AnswerValue="N" />
      <Answer AnswerField="be_wh_apply" AnswerValue="" />
      <Answer AnswerField="be_noncl_fnm" AnswerValue="" />
      <Answer AnswerField="be_noncl_lnm" AnswerValue="" />
      <Answer AnswerField="be_noncl_mnm" AnswerValue="" />
      <Answer AnswerField="be_noncl_sfx" AnswerValue="" />
      <Answer AnswerField="be_noncl_cossn" AnswerValue="" />
      <Answer AnswerField="be_noncl_dob_month" AnswerValue="" />
      <Answer AnswerField="be_noncl_dob_day" AnswerValue="" />
      <Answer AnswerField="be_noncl_dob_year" AnswerValue="" />
      <Answer AnswerField="be_noncl_wrkd_l2yr_xnd" AnswerValue="N" />
      <Answer AnswerField="be_clnt_chg_addr_sw" AnswerValue="" />
      <Answer AnswerField="be_clnt_mail_addrln_1" AnswerValue="807 APPLE BLOSSOM LANE" />
      <Answer AnswerField="be_clnt_mail_apt_no" AnswerValue="" />
      <Answer AnswerField="be_clnt_mail_addrln_2" AnswerValue="" />
      <Answer AnswerField="be_clnt_mail_addrln_3" AnswerValue="" />
      <Answer AnswerField="be_clnt_mail_addr_city" AnswerValue="PEARLAND" />
      <Answer AnswerField="be_clnt_mail_addr_st" AnswerValue="TX" />
      <Answer AnswerField="be_clnt_mail_addr_zip5" AnswerValue="77584" />
      <Answer AnswerField="be_clnt_phnarea" AnswerValue="713" />
      <Answer AnswerField="be_clnt_phnexch" AnswerValue="436" />
      <Answer AnswerField="be_clnt_phnnum" AnswerValue="9450" />
      <Answer AnswerField="be_cntct_fnm" AnswerValue="" />
      <Answer AnswerField="be_cntct_lnm" AnswerValue="" />
      <Answer AnswerField="be_cntct_phnarea" AnswerValue="" />
      <Answer AnswerField="be_cntct_phnexch" AnswerValue="" />
      <Answer AnswerField="be_cntct_phnnum" AnswerValue="" />
      <Answer AnswerField="be_rltvs_sup" AnswerValue="0" />
      <Answer AnswerField="be_expense_xnd" AnswerValue="N" />
      <Answer AnswerField="be_expense_amt" AnswerValue="" />
      <Answer AnswerField="be_res_bank_acc_xnd" AnswerValue="N" />
      <Answer AnswerField="be_res_bank_acc_amt" AnswerValue="" />
      <Answer AnswerField="be_res_invst_xnd" AnswerValue="N" />
      <Answer AnswerField="be_res_invst_amt" AnswerValue="" />
      <Answer AnswerField="be_res_csh_xnd" AnswerValue="N" />
      <Answer AnswerField="be_res_csh_amt" AnswerValue="" />
      
      <Answer AnswerField="be_clnt_buexp_xnd" AnswerValue="N" />
      <Answer AnswerField="be_noncl_buexp_xnd" AnswerValue="" />
      <Answer AnswerField="be_restt_xnd" AnswerValue="N" />
      <Answer AnswerField="be_clnt_ss_benefits_xnd" AnswerValue="N" />
      <Answer AnswerField="be_clnt_ss_benefits_amt" AnswerValue="" />
      <Answer AnswerField="be_noncl_ss_benefits_xnd" AnswerValue="N" />
      <Answer AnswerField="be_noncl_ss_benefits_amt" AnswerValue="" />
      <Answer AnswerField="be_clnt_rr_incm_xnd" AnswerValue="N" />
      <Answer AnswerField="be_clnt_rr_incm_amt" AnswerValue="" />
      <Answer AnswerField="be_noncl_rr_incm_xnd" AnswerValue="N" />
      <Answer AnswerField="be_noncl_rr_incm_amt" AnswerValue="" />
      <Answer AnswerField="be_clnt_va_benefits_xnd" AnswerValue="N" />
      <Answer AnswerField="be_clnt_va_benefits_amt" AnswerValue="" />
      <Answer AnswerField="be_noncl_va_benefits_xnd" AnswerValue="N" />
      <Answer AnswerField="be_noncl_va_benefits_amt" AnswerValue="" />
      <Answer AnswerField="be_clnt_pens_annuit_xnd" AnswerValue="N" />
      <Answer AnswerField="be_clnt_pens_annuit_amt" AnswerValue="" />
      <Answer AnswerField="be_noncl_pens_annuit_xnd" AnswerValue="N" />
      <Answer AnswerField="be_noncl_pens_annuit_amt" AnswerValue="" />
      <Answer AnswerField="be_clnt_oth_incm_xnd" AnswerValue="N" />
      <Answer AnswerField="be_clnt_oth_incm_amt" AnswerValue="" />
      <Answer AnswerField="be_clnt_oth_incm_typ" AnswerValue="" />
      <Answer AnswerField="be_noncl_oth_incm_xnd" AnswerValue="N" />
      <Answer AnswerField="be_noncl_oth_incm_amt" AnswerValue="" />
      <Answer AnswerField="be_noncl_oth_incm_typ" AnswerValue="" />
      <Answer AnswerField="be_incm_decrs_xnd" AnswerValue="N" />
      <Answer AnswerField="be_clnt_earn_wgs_xnd" AnswerValue="N" />
      <Answer AnswerField="be_clnt_earn_wgs_amt" AnswerValue="" />
      <Answer AnswerField="be_noncl_earn_wgs_xnd" AnswerValue="N" />
      <Answer AnswerField="be_noncl_earn_wgs_amt" AnswerValue="" />
      <Answer AnswerField="be_clnt_earn_loss_xnd" AnswerValue="" />
      <Answer AnswerField="be_clnt_earn_amt" AnswerValue="" />
      <Answer AnswerField="be_clnt_loss_amt" AnswerValue="" />
      <Answer AnswerField="be_noncl_earn_loss_xnd" AnswerValue="" />
      <Answer AnswerField="be_noncl_earn_amt" AnswerValue="" />
      <Answer AnswerField="be_noncl_loss_amt" AnswerValue="" />
      <Answer AnswerField="be_wgs_decrs_xnd" AnswerValue="N" />
      <Answer AnswerField="be_clnt_stop_wrk_xnd" AnswerValue="" />
      <Answer AnswerField="be_clnt_stop_wrk_month" AnswerValue="" />
      <Answer AnswerField="be_clnt_stop_wrk_year" AnswerValue="" />
      <Answer AnswerField="be_noncl_stop_wrk_xnd" AnswerValue="" />
      <Answer AnswerField="be_noncl_stop_wrk_month" AnswerValue="" />
      <Answer AnswerField="be_noncl_stop_wrk_year" AnswerValue="" />
      <Answer AnswerField="be_clnt_pay_disblty_xnd" AnswerValue="" />
      <Answer AnswerField="be_noncl_pay_disblty_xnd" AnswerValue="" />
      <Answer AnswerField="be_thrd_sub_sw" AnswerValue="Y" />
      <Answer AnswerField="be_clnt_sub_sw" AnswerValue="" />
      <Answer AnswerField="be_noncl_sub_sw" AnswerValue="" />
    </Answers>
  </Screening>
  <Screening Subset_id="58">
    <Answers>
      <Answer AnswerField="pri_resident" AnswerValue="Y" />
      <Answer AnswerField="city" AnswerValue="" />
      <Answer AnswerField="stateduration" AnswerValue="20" />
      <Answer AnswerField="citizen" AnswerValue="13_citizen" />
      <Answer AnswerField="vet_wartime" AnswerValue="N" />
      <Answer AnswerField="vet_legalres" AnswerValue="N" />
      <Answer AnswerField="vet_sp_died" AnswerValue="N" />
      <Answer AnswerField="vet_dis_perm" AnswerValue="N" />
      <Answer AnswerField="vet_dis_certified" AnswerValue="N" />
      <Answer AnswerField="frail" AnswerValue="N" />
      <Answer AnswerField="dep_care" AnswerValue="N" />
      <Answer AnswerField="trans_dis_co" AnswerValue="N" />
      <Answer AnswerField="sp_disabled" AnswerValue="N" />
      <Answer AnswerField="sp_dep_care" AnswerValue="N" />
      <Answer AnswerField="sp_dec_blind" AnswerValue="N" />
      <Answer AnswerField="dev_disabled" AnswerValue="N" />
      <Answer AnswerField="houseduration" AnswerValue="15" />
      <Answer AnswerField="tel_costs" AnswerValue="N" />
      <Answer AnswerField="sold" AnswerValue="N" />
      <Answer AnswerField="impairment_sub_emp_dis" AnswerValue="N" />
      <Answer AnswerField="impairment_sub_emp_imp" AnswerValue="N" />
      <Answer AnswerField="int_inc_excl" AnswerValue="N" />
      <Answer AnswerField="int_taxes" AnswerValue="N" />
      <Answer AnswerField="emerg_needs" AnswerValue="N" />
      <Answer AnswerField="dep_care_costs" AnswerValue="0" />
      <Answer AnswerField="dep_tax" AnswerValue="N" />
      <Answer AnswerField="scsep_inc" AnswerValue="0" />
      <Answer AnswerField="rent" AnswerValue="" />
      <Answer AnswerField="dep_child" AnswerValue="0" />
      <Answer AnswerField="realproperty_value" AnswerValue="" />
      <Answer AnswerField="s_income_cash_assist" AnswerValue="0.00" />
      <Answer AnswerField="sp_income_cash_assist" AnswerValue="0.00" />
      <Answer AnswerField="s_income_rr_ben" AnswerValue="0.00" />
      <Answer AnswerField="sp_income_rr_ben" AnswerValue="0.00" />
      <Answer AnswerField="s_income_ssi" AnswerValue="0.00" />
      <Answer AnswerField="sp_income_ssi" AnswerValue="0.00" />
      <Answer AnswerField="s_income_tanf" AnswerValue="0.00" />
      <Answer AnswerField="sp_income_tanf" AnswerValue="0.00" />
      <Answer AnswerField="s_asset_revocable" AnswerValue="0.00" />
      <Answer AnswerField="sp_asset_revocable" AnswerValue="0.00" />
      <Answer AnswerField="s_asset_irrevocable" AnswerValue="0.00" />
      <Answer AnswerField="sp_asset_irrevocable" AnswerValue="0.00" />
      <Answer AnswerField="fdstmp_receive" AnswerValue="" />
      <Answer AnswerField="scsep_receive" AnswerValue="" />
      <Answer AnswerField="med_receive" AnswerValue="" />
      <Answer AnswerField="ssi_receive" AnswerValue="" />
      <Answer AnswerField="liheap_receive" AnswerValue="" />
      <Answer AnswerField="receive_pub_housing" AnswerValue="" />
      <Answer AnswerField="receive_section_8" AnswerValue="" />
      <Answer AnswerField="receive_msp" AnswerValue="" />
      <Answer AnswerField="medicare_receive" AnswerValue="" />
      <Answer AnswerField="receive_partd" AnswerValue="" />
      <Answer AnswerField="ssd_receive_2" AnswerValue="" />
      <Answer AnswerField="receive_lis" AnswerValue="" />
      <Answer AnswerField="az_srp" AnswerValue="" />
      <Answer AnswerField="az_aps" AnswerValue="" />
      <Answer AnswerField="az_qwest" AnswerValue="" />
      <Answer AnswerField="az_sg" AnswerValue="" />
      <Answer AnswerField="az_unisource" AnswerValue="" />
      <Answer AnswerField="abused" AnswerValue="Y" />
      <Answer AnswerField="int_deaf" AnswerValue="Y" />
      <Answer AnswerField="legal" AnswerValue="Y" />
      <Answer AnswerField="int_trans_personal" AnswerValue="Y" />
      <Answer AnswerField="int_assistech" AnswerValue="Y" />
      <Answer AnswerField="int_low_inc_house" AnswerValue="N" />
      <Answer AnswerField="int_emp" AnswerValue="N" />
      <Answer AnswerField="leg_resident_5years" AnswerValue="" />
      <Answer AnswerField="gender" AnswerValue="Female" />
      <Answer AnswerField="zip" AnswerValue="77584" />
      <Answer AnswerField="dob" AnswerValue="111933" />
      <Answer AnswerField="marital_stat" AnswerValue="6_single" />
      <Answer AnswerField="med_costs" AnswerValue="0.00" />
      <Answer AnswerField="sp_dob" AnswerValue="" />
      <Answer AnswerField="veteran" AnswerValue="N" />
      <Answer AnswerField="vet_disability" AnswerValue="N" />
      <Answer AnswerField="vet_hon" AnswerValue="N" />
      <Answer AnswerField="sp_veteran" AnswerValue="N" />
      <Answer AnswerField="sp_vet_disability" AnswerValue="N" />
      <Answer AnswerField="sp_vet_hon" AnswerValue="N" />
      <Answer AnswerField="sp_blind" AnswerValue="N" />
      <Answer AnswerField="disabled" AnswerValue="N" />
      <Answer AnswerField="Blind" AnswerValue="N" />
      <Answer AnswerField="homebound" AnswerValue="N" />
      <Answer AnswerField="housing" AnswerValue="8_own_home" />
      <Answer AnswerField="hh_depend" AnswerValue="0" />
      <Answer AnswerField="property_tax" AnswerValue="Y" />
      <Answer AnswerField="shelter_costs" AnswerValue="0.00" />
      <Answer AnswerField="s_income_dividends" AnswerValue="" />
      <Answer AnswerField="sp_income_dividends" AnswerValue="" />
      <Answer AnswerField="s_income_earned" AnswerValue="517.50" />
      <Answer AnswerField="sp_income_earned" AnswerValue="0" />
      <Answer AnswerField="s_income_other_nw" AnswerValue="0" />
      <Answer AnswerField="sp_income_other_nw" AnswerValue="0" />
      <Answer AnswerField="s_income_pri_retire" AnswerValue="0" />
      <Answer AnswerField="sp_income_pri_retire" AnswerValue="0" />
      <Answer AnswerField="s_income_unemploy" AnswerValue="0" />
      <Answer AnswerField="sp_income_unemploy" AnswerValue="0" />
      <Answer AnswerField="s_income_vet_ben" AnswerValue="0" />
      <Answer AnswerField="sp_income_vet_ben" AnswerValue="0" />
      <Answer AnswerField="s_asset_auto1" AnswerValue="0" />
      <Answer AnswerField="sp_asset_auto1" AnswerValue="0" />
      <Answer AnswerField="s_asset_auto2" AnswerValue="0" />
      <Answer AnswerField="sp_asset_auto2" AnswerValue="0" />
      <Answer AnswerField="s_asset_home" AnswerValue="0" />
      <Answer AnswerField="sp_asset_home" AnswerValue="0" />
      <Answer AnswerField="s_asset_life_cash" AnswerValue="0" />
      <Answer AnswerField="sp_asset_life_cash" AnswerValue="0" />
      <Answer AnswerField="s_asset_life_face" AnswerValue="0" />
      <Answer AnswerField="sp_asset_life_face" AnswerValue="0" />
      <Answer AnswerField="s_asset_other_a" AnswerValue="0.00" />
      <Answer AnswerField="sp_asset_other_a" AnswerValue="0.00" />
      <Answer AnswerField="s_asset_retirement" AnswerValue="0.00" />
      <Answer AnswerField="sp_asset_retirement" AnswerValue="0.00" />
      <Answer AnswerField="s_asset_stocks" AnswerValue="0.00" />
      <Answer AnswerField="sp_asset_stocks" AnswerValue="0" />
      <Answer AnswerField="utility_2" AnswerValue="N" />
      <Answer AnswerField="hh_disabled" AnswerValue="0" />
      <Answer AnswerField="s_asset_cash" AnswerValue="0.00" />
      <Answer AnswerField="sp_asset_cash" AnswerValue="0.00" />
      <Answer AnswerField="no_hh_members" AnswerValue="1" />
      <Answer AnswerField="over_60" AnswerValue="1" />
      <Answer AnswerField="s_income_ss_disable" AnswerValue="0" />
      <Answer AnswerField="s_income_ss_retire" AnswerValue="0.00" />
      <Answer AnswerField="sp_income_ss_retire" AnswerValue="0.00" />
      <Answer AnswerField="sp_income_ss_disable" AnswerValue="0.00" />
      <Answer AnswerField="int_blind" AnswerValue="N" />
      <Answer AnswerField="work_status" AnswerValue="30_employed" />
    </Answers>
  </Screening>
</ScreeningSet>
' > 
</cfif>

<cfset mappedresults = structnew()>
<cfset form = structnew()>
<cfif isdefined('response_list')>
	<cfset xmlstring = response_list >
</cfif>

<cfset xmlstring = #replacenocase(xmlstring,'<?xml version="1.0" encoding="utf-16"?>','','ALL')#>
<cfset xmlstring = #replacenocase(xmlstring,'<Answers>','','ALL')#>
<cfset xmlstring = #replacenocase(xmlstring,'</Answers>','','ALL')#>
<cfset structRemoteVars = #xmlparse(xmlstring)#>
<!--- cfdump var="#structRemoteVars#" expand="yes" label="yes" --->
<cfset countScreenings = structcount(structRemoteVars.ScreeningSet) >
<cfoutput>Screening count #countScreenings#</cfoutput>
	<cfif not isdefined('resultset')>
		<cfset resultset = QueryNew("screening_id,partner_screening_id,partner_id,org_id,subset_id,client_id,report_url,validation_error,program_list,screening_status,reentry_number,date_time,program_title","integer,varchar,integer,integer,integer,varchar,varchar,varchar,varchar,varchar,integer,date,varchar")>
	</cfif>
	<cfset newRow = #QueryAddRow(resultset, countScreenings)#>
	<!--- cfdump var="#resultset#" ---->
<cfloop from="1" index="x" to="#countScreenings#">

	<cfset rownum = x >

	<cfset CountAnswers = structcount(structRemoteVars.ScreeningSet.Screening[x]) > 

	<cfset structBCUvars[#x#] = structnew()>
	
	<cfset current_subset_id = #structRemoteVars.ScreeningSet.screening[x].XmlAttributes.Subset_ID#>

	<cfoutput>Answer count #CountAnswers#</cfoutput>

	<cfloop from="1" index="i" to="#CountAnswers#">
	 <cfif structRemoteVars.ScreeningSet.screening[x].Answer[i].XmlAttributes.AnswerField neq "client">
		<cfif structRemoteVars.ScreeningSet.screening[x].Answer[i].XmlAttributes.AnswerField eq 'be_clnt_buexp_xnd'>
			<cfset fieldtoinsert = 'be_clnt_buexp_sw'>
		<cfelseif structRemoteVars.ScreeningSet.screening[x].Answer[i].XmlAttributes.AnswerField eq 'be_noncl_buexp_xnd'>
			<cfset fieldtoinsert = 'be_noncl_buexp_sw'> 

		<cfelse>
			<cfset fieldtoinsert = structRemoteVars.ScreeningSet.screening[x].Answer[i].XmlAttributes.AnswerField> 
		</cfif>
		<cfset results = #structinsert(structBCUvars[#x#], fieldtoinsert,structRemoteVars.ScreeningSet.screening[x].Answer[i].XmlAttributes.AnswerValue)#>
	 </cfif>	
	</cfloop>

	<!--- cfdump var="#structBCUvars[x]#" label="#current_subset_id#" ---> 

	<cfif current_subset_id neq 41 >	
	<!--- Make two rows in the query --->
	<!--- Set the values of the cells in the query --->
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
	<cfelse>
	  <cfset temp = #QuerySetCell(resultset, "screening_id", "0", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "partner_id", request.partner_id, rownum)#>
      <cfset temp = #QuerySetCell(resultset, "partner_screening_id", request.partner_screening_id, rownum)#>
      <cfset temp = #QuerySetCell(resultset, "org_id", request.org_id, rownum)#>
      <cfset temp = #QuerySetCell(resultset, "subset_id", current_subset_id, rownum)#>
      <cfset temp = #QuerySetCell(resultset, "client_id", request.client_id, rownum)#>
      <cfset temp = #QuerySetCell(resultset, "report_url", "", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "validation_error", "", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "program_list", "", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "screening_status", "Social Security Cannot Process Your Request At This Time", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "reentry_number", "", rownum)#>
      <cfset temp = #QuerySetCell(resultset, "date_time", now(), rownum)#>
      <cfset temp = #QuerySetCell(resultset, "program_title","", rownum)#>
	</cfif>

<cfif current_subset_id eq 41>
<cfset structWebServiceVars = structBCUvars[#x#]>
<cfset row_num = x>
<cfset screen_source = "remote">
<cfinclude template="procSSASubmission.cfm" >

		<h2>Updating LIS Application info for Webservice</h2>
		<cfif isdefined('badResponseList')>
		<h2>Updating LIS badResponseList validation</h2>
			<cfset temp = #QuerySetCell(resultset, "validation_error", badresponselist, rownum)#>
		</cfif>
		<cfif isdefined('screening_submission.reentry_number')>
		<h2>Updating Reentry</h2>
			<cfset temp = #QuerySetCell(resultset, "reentry_number", screening_submission.reentry_number, rownum)#>
		</cfif>
		<cfif isdefined('status_message')>
		 <cfif #findnocase('Validation',status_message)# gt 0>
			<cfset status_message = "Valiation Error">
			<h2>Updating submission_status</h2>
		 </cfif>
		
		 <cfif status_message eq "Successful">
			<cfset status_message = "success">
		 </cfif>
		  <cfset temp = #QuerySetCell(resultset, "screening_status", status_message, rownum)#>
		</cfif>
		<cfif isdefined('batch_screening_id')>
		<h2>Updating batch_screening_id <cfoutput>#batch_screening_id#</cfoutput></h2>
			<cfset temp = #QuerySetCell(resultset, "screening_id", batch_screening_id, rownum)#>
		</cfif>

			<cfset temp = #QuerySetCell(resultset, "partner_id", request.partner_id, rownum)#>

			<cfset temp = #QuerySetCell(resultset, "subset_id", current_subset_id, rownum)#>

		<cfset temp = #QuerySetCell(resultset, "client_id", request.client_id, rownum)#>

		

		<cfset temp = #QuerySetCell(resultset, "program_list", "", rownum)#>

	
		<cfset temp = #QuerySetCell(resultset, "date_time", now(), rownum)#>

		<cfset temp = #QuerySetCell(resultset, "program_title", "", rownum)#>
	
		


<cfelse>

<cfset AFList = "">
<cfset mappedresults = #structBCUvars[x]#>
<!---cf_validatezip zipcode="#structBCUvars[x].ZIP#" state_id="#structBCUvars[x].state#"--->
<!-- Check that zip is valid -->


<cfif 1 eq 0>
<!--cfif validationresult eq "false" -->



	<cfset screeningresults.error_code = "The zip code you entered is invalid for the state selected.">



<cfset screeningresults.report_url = "">



<cfelse>



<!-- Do screening --> 




<!-- do screening --> 

<cfset url.SUBSET_ID = current_subset_id> 

<cfset url.USER_ID = "null" > 

<!-- default demo org id -->

<cfparam name="url.org_id" default="#request.org_id#" > 

<!-- partner --> 

<cfset url.PARTNER_ID = request.partner_id > 

<cfset url.test_ID = testresponse> 

<!-- Web Service Source --> 

<cfset url.SOURCE_ID = "8"> 
<!--- cfdump var="#mappedresults#" label="Mapped Fields" --->
<!-- load screening stuff --> 
<cf_sessionLoadVars>
<cfset session.sessionDetailsLogged = False> 
<cfif isdefined('mappedresults.zip') and mappedresults.zip neq ''>
		<cfquery name="zipstate" datasource="#application.dbSrc#">
			select state_id
			from zip
			where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#mappedresults.zip#" maxlength="5">
				and valid=1
		</cfquery>
		<cfif zipstate.RecordCount>
			<cfset session.state_id = zipstate.state_id>
			<cfset session.st = zipstate.state_id>
			<cfset session.zip = mappedresults.zip>
		<cfelse>
			<cfset zip = ''>
		</cfif>
		</cfif>

<cfif structkeyexists(structBCUvars[x],"dob")>
 	<cfset result = #structinsert(mappedresults,"dob_year",right(structBCUvars[x].dob,4))#>
 	<cfset result = #structinsert(mappedresults,"dob_month",left(structBCUvars[x].dob,1))#>
<cfelseif structkeyexists(structBCUvars[x],"dob_year")>
	<cfset mappedresults.DOB_MONTH = structBCUvars[x].DOB_MONTH> 
	<cfset mappedresults.DOB_YEAR = structBCUvars[x].DOB_YEAR> 
</cfif>
<cfif structkeyexists(structBCUvars[x],"sp_dob")>
 	<cfset result = #structinsert(mappedresults,"sp_dob_year",right(structBCUvars[x].dob,4))#>
 	<cfset result = #structinsert(mappedresults,"sp_dob_month",left(structBCUvars[x].dob,1))#>
<cfelseif structkeyexists(structBCUvars[x],"sp_dob_year")>
	<cfset mappedresults.sp_DOB_MONTH = structBCUvars[x].sp_DOB_MONTH> 
	<cfset mappedresults.sp_DOB_YEAR = structBCUvars[x].sp_DOB_YEAR> 
</cfif>
<cfif structkeyexists(structBCUvars[x],"city") and isdefined('zipstate.state_id')>
		<cfif zipstate.state_id neq "IL">
 			<cfset result = #structinsert(structBCUvars[x],"othercity",structBCUvars[x].city)#>
	 		<cfset result = StructDelete(structBCUvars[x],"city")>
		</cfif>
</cfif>

<cf_handleScreening action="start" > 
<cfoutput>Pre -: #aflist#</cfoutput>
<cfset aflist = "">
<cfset x = 0>
<cfloop collection="#mappedresults#" item="listvar">
	<cfset x = x + 1>
	<cfif listvar neq "client1" and listvar neq "state_id" and listvar neq "sent" and listvar neq "dob">
		<cf_getAFlistVar answerfield="#listvar#">
	</cfif>
	<cfoutput>#listvar#:#aflistvar#:</cfoutput>
	<cfif aflistvar neq "">
	<cfif x eq 1>
		<cfset aflist = aflistvar>
	<cfelse>
		<cfset aflist = aflist & "," & aflistvar >
	</cfif>
	</cfif>
	<cfset varvalue = #evaluate('mappedresults.#listvar#')#>
	<cfif varvalue eq '2346_separated'>
		<cfset 'mappedresults.#listvar#' = '2346-separated'>
	</cfif>
	<cfset firstchar = #left(varvalue,1)#>
	<cfif #isnumeric(firstchar)# and (#findnocase("-",varvalue)# eq 0)>
		<cfoutput>- #firstchar# -</cfoutput>
		<cfset varvalue = #replacenocase(varvalue,"_","-")#>
		<cfset 'mappedresults.#listvar#' = varvalue >
	</cfif>
	<cfoutput>#varvalue#<br></cfoutput>

</cfloop>
<cfset aflist = aflist & "," & "o-client" >
<cfoutput>post -: #aflist#</cfoutput>
<cf_logScreeningInput structname="mappedresults" aflist="#afList#"> 
<cfset session.strclient = 'self'>
 	<cfset session.zipradius = 100> 
<cfif session.subsetSCHIPFlag eq 1> 	
	<cfset session.wantchips = 'N'> 
</cfif>                      
<cfif session.st eq 'IL' and session.county eq 'COOK' and isDefined('mappedresults.city')> 	
	<cfset session.city = mappedresults.city> 
</cfif> 
<cfif session.st eq 'IL' and session.county eq 'COOK' and isDefined('mappedresults.citysubcc') and mappedresults.citysubcc eq 'NotChi'>
 	<CFSET session.city = mappedresults.citysubcc> 
</cfif>  
<CFIF isDefined('mappedresults.othercity')>
 	<CFSET session.othercity = mappedresults.othercity> 
	<CFELSE> 	<cfset session.othercity = ''> 
</cfif>   
<!----======================================= 
DESCRIPTION: takes possible programs, pulls the rules, then checks the answers to see if the user     
qualifies   CALLED BY: proc_asset.cfm  GOES TO: N/A   
REQUIRED: N/A   ============================================---->  

 <cf_handleScreening action="end" screening_id="#session.screening_id#"> 
 <cfset session.city = ""> 
 <cfset session.SKIPINC =""> 
 <cfset session.SKIPASSETS =""> 
 <!--- 05/21/2003 BS - Make sure there's a session.selectedDrugs variable --->  
  <cfif not IsDefined("session.selectedDrugs")>   	
  	<cfset session.selectedDrugs = ''>                              
  </cfif>                               
   <!--- 08/02/2002 Bill - This code is to strip leading zeroes off the household 
   number, so we don't look up a column with a name like "mem02" --->                               
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
 <cf_cacheProgramPool>                              
 <cf_tagTestRules ynDoBuffer="FALSE">                                                               
  <cfif 1 eq 0>                                
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
<cf_populateTableFromView table="subset_program_sum" subset_id="#session.subset_id#">  
<cf_populateTableFromView table="subset_program_sum" subset_id="#session.subset_id#">                              
<cfif IsDefined('session.subset_id') And session.subset_id gt 0>                                	
<cfquery name="helperPrg" datasource="#session.datasrc#">                                		
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
DUPLICATE SET OF ENTRIES IF THE USER BACKS UP AND RESUBMITS HIS ANSWERS TO THIS PROCESS                                 PAGE. --->
<cfif session.subsetRecFlag eq 1>                                
	<cfset unseenVal = 1>                                
	<cfelse>                                	
		<cfset unseenVal = 0>                                
	</cfif>                                
	<cf_loadApplicationVars hashname="prgvars">                               
	<cfoutput><br> <h2>looping session program list</h2></cfoutput>                              
	<cfset session.newlist = "">
	<cfset session.programtitlelist = "">
<cfset program_xml = '
<?xml version="1.0" encoding="utf-16"?>

<Programs>'>

  <cfloop list="#session.prg_list#" index="prg_id">                                	

	<cfset unseenAdjustedVal = unseenVal>                                	

	<cfif unseenVal eq 0>
		<cfif Mid(prg_id, Find('-', prg_id) + 1, Find('-', prg_id, Find('-', prg_id) + 1) - Find('-', prg_id) - 1) eq '333'>
			<cfset unseenAdjustedVal = 1>
		</cfif>
	</cfif>                                	


	<cfquery name="insertprograms" DATASOURCE="#session.datasrc#">                                		
	INSERT INTO screening_program                                			
	(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)                                		
	VALUES                                			
	(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenAdjustedVal#, 0, 0)    </CFQUERY>
	<cfset list_prg = #Mid(prg_id, 2, Len(prg_id) - 2)#>
	<cfset session.newlist = #listappend(session.newlist,StructFind(application.prgvars, list_prg),";")#>
	<cfoutput><br>Session list #session.newlist# <br></cfoutput>
	<cfoutput>prg: #prg_id# <br><br></cfoutput>
	<cf_cacheProgramPool action="get" id="#StructFind(application.prgvars, list_prg)#" var="pobj" codevar="code">
	<!---cfdump var="#pobj#" --->
	<!---cfoutput>#code#</cfoutput--->
	<cf_displayText group="program" code="program_#code#" var="programName">
	<cfoutput>#programName#</cfoutput>
    <cfset programName = #XmlFormat(programName)#>
	<cfset session.programtitlelist = #listappend(session.programtitlelist,'"#programName#"',";")#>
	<cfoutput>#session.programtitlelist#</cfoutput>
	<cfset cid = "">
	<cfif isdefined('pobj.cat_id')>
		<cfset cid = pobj.cat_id>
	</cfif>
	<cfset program_xml = program_xml & '
	<Program Id = "#StructFind(application.prgvars, list_prg)#" CatId ="#cid#">#programName#</Program>
'>
  </cfloop>





<cfif session.wantchips eq 'Y'>

	<CFQUERY NAME="insertchips" DATASOURCE="#session.datasrc#"> 		

	INSERT INTO screening_program 			

	(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag) 		

	VALUES 			

	(#session.screening_id#, #StructFind(application.prgvars, '103-309-2191-FD-FD')#, #unseenVal#, 0, 0) 	

	</CFQUERY> 

	</cfif> 



	<cfif session.genericdrugs eq 'Y'>

	<CFQUERY NAME="insertgeneric" DATASOURCE="#session.datasrc#"> 		

	INSERT INTO screening_program 			

	(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag) 		

	VALUES 			

	(#session.screening_id#, #StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#, #unseenVal#, 0, 0)

	</CFQUERY>

</cfif>



<cfloop list="#session.buff_list#" index="prg_id">

	<cfquery name="insertbuffers" DATASOURCE="#session.datasrc#">

		INSERT INTO screening_program

			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

		VALUES 			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenVal#, 1, 0)

	</cfquery>

</cfloop>
<cfset session.partnerPDFLogoFlag = 1>
<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#-ws" fileformat="pdf" coverpage="true" toc="false" partner_id="#request.partner_id#"   pgbreaks="false" >
<cfoutput>#session.prg_list# #session.cfid# #session.cftoken#
</cfoutput>
	<cfset screeningresults.date_time = #now()# >
	<cfset screeningresults.program_list = session.prg_list>
	<cfset screeningresults.screening_id = session.screening_id >
	<cfif session.prg_list eq "">
	<cfset screeningresults.report_url = "https://#session.servername#/util/noprogramsreturned.pdf">
	<cfelse>
		<cfoutput>#session.screening_id# https://#session.servername#/pdf/#pdfname#.pdf</cfoutput>
		<cfset screeningresults.report_url = "https://#session.servername#/pdf/#pdfname#.pdf">
	</cfif>
<cfset program_xml = program_xml & '
</Programs>'>
<cfset program_xml = #replacenocase(program_xml,'<?xml version="1.0" encoding="utf-16"?>','','ALL')#>

</cfif>
	<cfif isdefined('session.screening_id' )>
		<cfset temp = #QuerySetCell(resultset, "screening_id", session.screening_id, rownum)#>
	</cfif>
	<cfset temp = #QuerySetCell(resultset, "partner_id", request.partner_id, rownum)#>
	<cfset temp = #QuerySetCell(resultset, "subset_id", current_subset_id, rownum)#>
	<cfset temp = #QuerySetCell(resultset, "client_id", request.client_id, rownum)#>
	<cfset temp = #QuerySetCell(resultset, "report_url", screeningresults.report_url, rownum)#>
	<cfset temp = #QuerySetCell(resultset, "program_list", program_xml, rownum)#>
	<cfset temp = #QuerySetCell(resultset, "date_time", now(), rownum)#>
	<cfset temp = #QuerySetCell(resultset, "program_title", "", rownum)#>
		<cfset temp = QuerySetCell(resultset, "reentry_number", "", rownum)>
		<cfset temp = QuerySetCell(resultset, "screening_status", "Success", rownum)>
		<cfset temp = #QuerySetCell(resultset, "validation_error", "", rownum)#>
</cfif>
<!--- cfdump var="#structBCUvars[x]#" --->
<!--- cfdump var="#resultset#" label="resultset" --->
<cfoutput><h1>Screening Complete<br></h1></cfoutput>
</cfloop>