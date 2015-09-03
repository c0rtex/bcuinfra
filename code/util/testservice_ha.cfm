<cfinvoke method="doScreening" 
returnvariable="responseFromService" 
webservice="http://www-in.benefitscheckup.org/util/remotescreening_staging_humanarc.cfc?wsdl" >

<cfinvokeargument name="partner_id" value="47">

<cfinvokeargument name="partner_screening_id" value="1000020">

<cfinvokeargument name="org_id" value="22780">

<cfinvokeargument name="password" value="pass">

<cfinvokeargument name="client_id" value="test123">

<cfinvokeargument name="response_list" value='<?xml version="1.0" encoding="utf-16"?>
<ScreeningSet>

<Screening Subset_id="58">
<Answers>
<Answer AnswerField="marital_stat" AnswerValue="2" />
<Answer AnswerField="gender" AnswerValue="2" />
<Answer AnswerField="zip" AnswerValue="05776" />
<Answer AnswerField="hh_depend" AnswerValue="4" />
<Answer AnswerField="citizen" AnswerValue="1" />
<Answer AnswerField="Disabled" AnswerValue="2" />
<Answer AnswerField="client" AnswerValue="1" />
<Answer AnswerField="state" AnswerValue="VT" />
<Answer AnswerField="pri_resident" AnswerValue="1" />
<Answer AnswerField="lis_apply" AnswerValue="2" />
<Answer AnswerField="Blind" AnswerValue="2" />
<Answer AnswerField="dob_month" AnswerValue="11" />
<Answer AnswerField="dob_year" AnswerValue="1907" />
<Answer AnswerField="dep_child" AnswerValue="2" />
<Answer AnswerField="s_sp_income_earned" AnswerValue="800" />
<Answer AnswerField="s_sp_income_other_nw" AnswerValue="700" />
<Answer AnswerField="s_sp_asset_other_a" AnswerValue="500" />
<Answer AnswerField="med_costs" AnswerValue="88.00" />
<Answer AnswerField="rx_ins_co_pay" AnswerValue="2" />
<Answer AnswerField="rx_drugcosts" AnswerValue="50" />
<Answer AnswerField="rx_all_drugs" AnswerValue="2" />
<Answer AnswerField="stateduration" AnswerValue="10" />
<Answer AnswerField="medicare_receive" AnswerValue="1" />
<Answer AnswerField="hurricane" AnswerValue="2" />
<Answer AnswerField="lis_undeemed" AnswerValue="2" />
<Answer AnswerField="rec_ca_drugdiscount" AnswerValue="1" />
</Answers>
</Screening>
<Screening Subset_id="58">
<Answers>
<Answer AnswerField="marital_stat" AnswerValue="2" />
<Answer AnswerField="gender" AnswerValue="2" />
<Answer AnswerField="zip" AnswerValue="05774" />
<Answer AnswerField="hh_depend" AnswerValue="4" />
<Answer AnswerField="citizen" AnswerValue="1" />
<Answer AnswerField="Disabled" AnswerValue="2" />
<Answer AnswerField="client" AnswerValue="1" />
<Answer AnswerField="state" AnswerValue="VT" />
<Answer AnswerField="pri_resident" AnswerValue="1" />
<Answer AnswerField="lis_apply" AnswerValue="2" />
<Answer AnswerField="Blind" AnswerValue="2" />
<Answer AnswerField="dob_month" AnswerValue="11" />
<Answer AnswerField="dob_year" AnswerValue="1907" />
<Answer AnswerField="dep_child" AnswerValue="2" />
<Answer AnswerField="s_sp_income_earned" AnswerValue="800" />
<Answer AnswerField="s_sp_income_other_nw" AnswerValue="700" />
<Answer AnswerField="s_sp_asset_other_a" AnswerValue="500" />
<Answer AnswerField="med_costs" AnswerValue="88.00" />
<Answer AnswerField="rx_ins_co_pay" AnswerValue="2" />
<Answer AnswerField="rx_drugcosts" AnswerValue="50" />
<Answer AnswerField="rx_all_drugs" AnswerValue="2" />
<Answer AnswerField="stateduration" AnswerValue="10" />
<Answer AnswerField="medicare_receive" AnswerValue="1" />
<Answer AnswerField="hurricane" AnswerValue="2" />
<Answer AnswerField="lis_undeemed" AnswerValue="2" />
<Answer AnswerField="rec_ca_drugdiscount" AnswerValue="1" />
</Answers>
</Screening>
</ScreeningSet>'>
</cfinvoke>
<b>Response from server:</b><br/>
<cfdump var="#responseFromService#">




 
