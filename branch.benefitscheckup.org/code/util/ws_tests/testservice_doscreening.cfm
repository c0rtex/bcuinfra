<cfinvoke method="doScreening" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_8.cfc?wsdl" >
<cfinvokeargument name="partner_id" value="77">
<cfinvokeargument name="partner_screening_id" value="11111aaa333">
<cfinvokeargument name="campaign_id" value="">

<cfinvokeargument name="response_list" value='
<?xml version="1.0" encoding="utf-16"?>
<ScreeningSet>
<Screening Subset_id="73">
<Answer AnswerField="be_clnt_fnm" AnswerValue="Jeannie" ></Answer>
<Answer AnswerField="be_clnt_mid" AnswerValue="Mae" ></Answer>
<Answer AnswerField="be_clnt_lnm" AnswerValue="TylerT" ></Answer>
<Answer AnswerField="mqc_birth_month" AnswerValue="12" ></Answer>
<Answer AnswerField="mqc_birth_day" AnswerValue="3" ></Answer>
<Answer AnswerField="mqc_birth_year" AnswerValue="1950" ></Answer>
<Answer AnswerField="mqc_zipcode" AnswerValue="44866" ></Answer>
<Answer AnswerField="email_address" AnswerValue="jsfrostbite@gmail.com" ></Answer>
<Answer AnswerField="be_clnt_phnarea" AnswerValue="330" ></Answer>
<Answer AnswerField="be_clnt_phnexch" AnswerValue="466" ></Answer>
<Answer AnswerField="be_clnt_phnnum" AnswerValue="4690" ></Answer>
</Screening>
</ScreeningSet>
'>



<cfinvokeargument name="partner_session_id" value="abc123-1222-1221">
</cfinvoke>
<b>Response from server:</b><br/>
<cfdump var="#responseFromService#">

<cfinvoke  component="util" method="getStateCountyFromZip" returnVariable="statequery"> 
	<cfinvokeargument name="zipcode" value="99999"/>
</cfinvoke>
<cfdump var="#statequery#">




 