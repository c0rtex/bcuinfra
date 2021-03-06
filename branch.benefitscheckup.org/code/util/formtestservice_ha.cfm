<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<title>Testing Web Service Screenings</title>

<form  name="servertest" action="proctestservice_ha.cfm" method="post"  >
<h2>Submit Test XML Screening</h2>
Partner ID: <input name="partner_id" type="" value="47" /><br /><br />
<h3>Input XML</h3>
<textarea name="xml_answers" cols="80" rows="20" >
</textarea>
<input type="submit" /><br /><br />

<br /><br />

<p>Example LIS XML Answer Set</p>

<textarea name="example" cols="80" rows="20">

<?xml version="1.0" encoding="utf-16"?>

<ScreeningSet>

<Screening Subset_id="41">

<Answers>

<Answer AnswerField="BE_CLNT_MAIL_ADDR_CITY" AnswerValue="Stoutsville"/>

<Answer AnswerField="BE_CLNT_DOB_DAY" AnswerValue="18"/>

<Answer AnswerField="BE_CLNT_DOB_YEAR" AnswerValue="1962"/>

<Answer AnswerField="BE_CLNT_SS_BENEFITS_AMT" AnswerValue="118"/>

<Answer AnswerField="BE_THRD_SUB_SW" AnswerValue="y"/>

<Answer AnswerField="BE_CLNT_VA_BENEFITS_XND" AnswerValue="n"/>

<Answer AnswerField="BE_CLNT_PHNAREA" AnswerValue="740"/>

<Answer AnswerField="BE_THRD_LNM" AnswerValue="JoJo"/>

<Answer AnswerField="BE_CLNT_MAIL_ADDRLN_2" AnswerValue=""/>

<Answer AnswerField="BE_RLTVS_SUP" AnswerValue="0"/>

<Answer AnswerField="BE_RESTT_XND" AnswerValue="n"/>

<Answer AnswerField="CT_RECEIVE_MEDICARE_XND" AnswerValue="y"/>

<Answer AnswerField="CT_MRTL_STUS" AnswerValue="5-divorced"/>

<Answer AnswerField="BE_CLNT_SUB_SW" AnswerValue="y"/>

<Answer AnswerField="BE_CLNT_INS_POL_XND" AnswerValue="n"/>

<Answer AnswerField="BE_RES_BANK_ACC_XND" AnswerValue="y"/>

<Answer AnswerField="BE_THRD_PHNAREA" AnswerValue="800"/>

<Answer AnswerField="BE_THRD_ADDRLN_1" AnswerValue="220 Washington Avenue"/>

<Answer AnswerField="BE_THRD_PHNEXCH" AnswerValue="221"/>

<Answer AnswerField="BE_THRD_REL_OTH" AnswerValue="TESTY"/>

<Answer AnswerField="BE_THRD_REL" AnswerValue="2365-rel_other"/>

<Answer AnswerField="BE_THRD_FNM" AnswerValue="TEST"/>

<Answer AnswerField="BE_CLNT_WRKD_L2YR_XND" AnswerValue="n"/>

<Answer AnswerField="BE_RES_BANK_ACC_AMT" AnswerValue="5"/>

<Answer AnswerField="BE_CLNT_OTH_INCM_XND" AnswerValue="n"/>

<Answer AnswerField="BE_CLNT_LNM" AnswerValue="AlveyA"/>

<Answer AnswerField="BE_INCM_DECRS_XND" AnswerValue="y"/>

<Answer AnswerField="BE_THRD_ADDR_ZIP5" AnswerValue="12203"/>

<Answer AnswerField="BE_CLNT_DOB_MONTH" AnswerValue="10"/>

<Answer AnswerField="BE_RES_INVST_AMT" AnswerValue="0"/>

<Answer AnswerField="BE_CLNT_CHG_ADDR_SW" AnswerValue=""/>

<Answer AnswerField="CT_SS_DISBLTY_XND" AnswerValue="y"/>

<Answer AnswerField="BE_RES_CSH_XND" AnswerValue="n"/>

<Answer AnswerField="BE_THRD_ADDRLN_3" AnswerValue=""/>

<Answer AnswerField="CT_MAIL_XND" AnswerValue="n"/>

<Answer AnswerField="BE_THRD_ADDR_ST" AnswerValue="NY"/>

<Answer AnswerField="BE_CLNT_MAIL_ADDR_ZIP5" AnswerValue="43154"/>

<Answer AnswerField="BE_THRD_PHNNUM" AnswerValue="3742"/>

<Answer AnswerField="BE_THRD_ADDRLN_2" AnswerValue=""/>

<Answer AnswerField="BE_CLNT_SS_BENEFITS_XND" AnswerValue="y"/>

<Answer AnswerField="BE_CLNT_EARN_WGS_XND" AnswerValue="n"/>

<Answer AnswerField="BE_CLNT_BUEXP_SW" AnswerValue="y"/>

<Answer AnswerField="BE_CLNT_OTH_INCM_TYP" AnswerValue=""/>

<Answer AnswerField="BE_SAV_LMT_XND" AnswerValue="n"/>

<Answer AnswerField="BE_THRD_APT_NO" AnswerValue=""/>

<Answer AnswerField="BE_CLNT_PENS_ANNUIT_XND" AnswerValue="n"/>

<Answer AnswerField="BE_CLNT_COSSN" AnswerValue="743980941"/>

<Answer AnswerField="BE_CLNT_PHNNUM" AnswerValue="7852"/>

<Answer AnswerField="BE_CLNT_STOP_WRK_YEAR" AnswerValue=""/>

<Answer AnswerField="BE_CLNT_MAIL_ADDRLN_3" AnswerValue=""/>

<Answer AnswerField="BE_WH_APPLY" AnswerValue=""/>

<Answer AnswerField="BE_CLNT_PHNEXCH" AnswerValue="497"/>

<Answer AnswerField="BE_CLNT_MAIL_ADDR_ST" AnswerValue="OH"/>

<Answer AnswerField="BE_CLNT_MAIL_APT_NO" AnswerValue=""/>

<Answer AnswerField="BE_CLNT_STOP_WRK_XND" AnswerValue=""/>

<Answer AnswerField="BE_CLNT_FNM" AnswerValue="Belyner"/>

<Answer AnswerField="BE_WGS_DECRS_XND" AnswerValue=""/>

<Answer AnswerField="BE_THRD_ADDR_CITY" AnswerValue="Albany"/>

<Answer AnswerField="BE_CLNT_RR_INCM_XND" AnswerValue="n"/>

<Answer AnswerField="BE_EXPENSE_XND" AnswerValue="n"/>

<Answer AnswerField="BE_RES_INVST_XND" AnswerValue="y"/>

<Answer AnswerField="BE_SAV_LMT_XND1" AnswerValue="n"/>

<Answer AnswerField="CT_OLDER_XND" AnswerValue="n"/>

<Answer AnswerField="BE_CLNT_SFX" AnswerValue=""/>

<Answer AnswerField="CT_LIVE" AnswerValue="OH"/>

<Answer AnswerField="BE_CLNT_MAIL_ADDRLN_1" AnswerValue="11281 Natures Trail"/>

<Answer AnswerField="CT_THRD_PTY_XND" AnswerValue="y"/>

<Answer AnswerField="BE_CLNT_EARN_LOSS_XND" AnswerValue=""/>

<Answer AnswerField="BE_INS_POL_AMT" AnswerValue=""/>

<Answer AnswerField="BE_CLNT_PAY_DISBLTY_XND" AnswerValue=""/>

<Answer AnswerField="BE_CLNT_STOP_WRK_MONTH" AnswerValue=""/>

</Answers>

</Screening>

  <Screening Subset_id="58">

    <Answers>

      <Answer AnswerField="work_status" AnswerValue="54_semi_retired" />

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

      <Answer AnswerField="s_income_cash_assist" AnswerValue="0" />

      <Answer AnswerField="sp_income_cash_assist" AnswerValue="0" />

      <Answer AnswerField="s_income_rr_ben" AnswerValue="0" />

      <Answer AnswerField="sp_income_rr_ben" AnswerValue="0" />

      <Answer AnswerField="s_income_ssi" AnswerValue="0" />

      <Answer AnswerField="sp_income_ssi" AnswerValue="0" />

      <Answer AnswerField="s_income_tanf" AnswerValue="0" />

      <Answer AnswerField="sp_income_tanf" AnswerValue="0" />

      <Answer AnswerField="s_asset_revocable" AnswerValue="0" />

      <Answer AnswerField="sp_asset_revocable" AnswerValue="0" />

      <Answer AnswerField="s_asset_irrevocable" AnswerValue="0" />

      <Answer AnswerField="sp_asset_irrevocable" AnswerValue="0" />

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

      <Answer AnswerField="zip" AnswerValue="11202" />

      <Answer AnswerField="dob_month" AnswerValue="11" />

      <Answer AnswerField="dob_year" AnswerValue="1924" />

      <Answer AnswerField="marital_stat" AnswerValue="4_married" />

      <Answer AnswerField="med_costs" AnswerValue="88" />

      <Answer AnswerField="sp_dob_month" AnswerValue="9" />

      <Answer AnswerField="sp_dob_year" AnswerValue="1930" />

      <Answer AnswerField="veteran" AnswerValue="Y" />

      <Answer AnswerField="vet_disability" AnswerValue="Y" />

      <Answer AnswerField="vet_hon" AnswerValue="Y" />

      <Answer AnswerField="sp_veteran" AnswerValue="N" />

      <Answer AnswerField="sp_vet_disability" AnswerValue="Y" />

      <Answer AnswerField="sp_vet_hon" AnswerValue="Y" />

      <Answer AnswerField="sp_blind" AnswerValue="Y" />

      <Answer AnswerField="disabled" AnswerValue="N" />

      <Answer AnswerField="Blind" AnswerValue="N" />

      <Answer AnswerField="homebound" AnswerValue="N" />

      <Answer AnswerField="hh_depend" AnswerValue="4" />

      <Answer AnswerField="property_tax" AnswerValue="N" />

      <Answer AnswerField="shelter_costs" AnswerValue="0" />

      <Answer AnswerField="s_income_dividends" AnswerValue="12563" />

      <Answer AnswerField="sp_income_dividends" AnswerValue="500" />

      <Answer AnswerField="s_income_earned" AnswerValue="0" />

      <Answer AnswerField="sp_income_earned" AnswerValue="0" />

      <Answer AnswerField="s_income_other_nw" AnswerValue="25126" />

      <Answer AnswerField="sp_income_other_nw" AnswerValue="0" />

      <Answer AnswerField="s_income_pri_retire" AnswerValue="12563" />

      <Answer AnswerField="sp_income_pri_retire" AnswerValue="50" />

      <Answer AnswerField="s_income_unemploy" AnswerValue="12563" />

      <Answer AnswerField="sp_income_unemploy" AnswerValue="500" />

      <Answer AnswerField="s_income_vet_ben" AnswerValue="12563" />

      <Answer AnswerField="sp_income_vet_ben" AnswerValue="0" />

      <Answer AnswerField="s_asset_auto1" AnswerValue="12563" />

      <Answer AnswerField="sp_asset_auto1" AnswerValue="500" />

      <Answer AnswerField="s_asset_auto2" AnswerValue="500" />

      <Answer AnswerField="sp_asset_auto2" AnswerValue="500" />

      <Answer AnswerField="s_asset_home" AnswerValue="12563" />

      <Answer AnswerField="sp_asset_home" AnswerValue="500" />

      <Answer AnswerField="s_asset_life_cash" AnswerValue="12563" />

      <Answer AnswerField="sp_asset_life_cash" AnswerValue="500" />

      <Answer AnswerField="s_asset_life_face" AnswerValue="500" />

      <Answer AnswerField="sp_asset_life_face" AnswerValue="500" />

      <Answer AnswerField="s_asset_other_a" AnswerValue="1000" />

      <Answer AnswerField="sp_asset_other_a" AnswerValue="1000" />

      <Answer AnswerField="s_asset_retirement" AnswerValue="12563" />

      <Answer AnswerField="sp_asset_retirement" AnswerValue="500" />

      <Answer AnswerField="s_asset_stocks" AnswerValue="13563" />

      <Answer AnswerField="sp_asset_stocks" AnswerValue="1500" />

      <Answer AnswerField="utility_2" AnswerValue="N" />

      <Answer AnswerField="hh_disabled" AnswerValue="0" />

      <Answer AnswerField="s_asset_cash" AnswerValue="38189" />

      <Answer AnswerField="sp_asset_cash" AnswerValue="2000" />

      <Answer AnswerField="no_hh_members" AnswerValue="2" />

      <Answer AnswerField="over_60" AnswerValue="1" />

      <Answer AnswerField="s_income_ss_disable" AnswerValue="0" />

      <Answer AnswerField="s_income_ss_retire" AnswerValue="0" />

      <Answer AnswerField="sp_income_ss_retire" AnswerValue="0" />

      <Answer AnswerField="sp_income_ss_disable" AnswerValue="0" />

      <Answer AnswerField="int_blind" AnswerValue="N" />

      </Answers>

  </Screening>

</ScreeningSet>

</textarea>

</form>

