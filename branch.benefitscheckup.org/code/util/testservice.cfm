<cfinvoke method="doScreening" returnvariable="responseFromService" webservice="https://bcuqa.benefitscheckup.org/util/screenforbenefits.cfc?wsdl" >
<cfinvokeargument name="subset_id" value=27>
<cfinvokeargument name="partner_id" value=0>
<cfinvokeargument name="partner_screening_id" value="">
<cfinvokeargument name="org_id" value="2278">
<cfinvokeargument name="password" value="">
<cfinvokeargument name="client_id" value="">
<cfinvokeargument name="response_list" value='<Screening>
  <Answer AnswerField="marital_stat" AnswerValue="2" />
  <Answer AnswerField="zip" AnswerValue="55414" />
  <Answer AnswerField="hh_depend" AnswerValue="1" />
  <Answer AnswerField="citizen" AnswerValue="1" />
  <Answer AnswerField="Disabled" AnswerValue="2" />
  <Answer AnswerField="client" AnswerValue="8" />
  <Answer AnswerField="gender" AnswerValue="1" />
  <Answer AnswerField="state" AnswerValue="MN" />
  <Answer AnswerField="pri_resident" AnswerValue="1" />
  <Answer AnswerField="lis_apply" AnswerValue="2" />
  <Answer AnswerField="s_asset_other_a" AnswerValue="$100.00" />
  <Answer AnswerField="Blind" AnswerValue="2" />
  <Answer AnswerField="dob_month" AnswerValue="10" />
  <Answer AnswerField="dob_year" AnswerValue="22" />
  <Answer AnswerField="rx_ins" AnswerValue="2" />
  <Answer AnswerField="s_sp_income_earned" AnswerValue="$0.00" />
  <Answer AnswerField="s_sp_income_other_nw" AnswerValue="$250.00" />
  <Answer AnswerField="no_hh_members" AnswerValue="1" />
  <Answer AnswerField="hurricane" AnswerValue="2" />
  <Answer AnswerField="medicare_receive" AnswerValue="1" />
  <Answer AnswerField="lis_undeemed" AnswerValue="2" />
</Screening>'>
</cfinvoke>
<b>Response from server:</b><br/>
<cfdump var="#responseFromService#">




 