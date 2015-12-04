<cfinvoke method="doScreening" 
returnvariable="responseFromService" 
webservice="https://www.benefitscheckup.org/util/remotescreening_3_8.cfc?wsdl" >
<cfinvokeargument name="partner_id" value="77">
<cfinvokeargument name="partner_screening_id" value="11111aaa333">
<cfinvokeargument name="campaign_id" value="">

<cfinvokeargument name="response_list" value='
<?xml version="1.0" encoding="utf-16"?>
<ScreeningSet>
<Screening Subset_id="83">
<Answer AnswerField="esi_zip" AnswerValue="55417" ></Answer>
<Answer AnswerField="esi_category_retirement_planning" AnswerValue="y" ></Answer>
<Answer AnswerField="esi_category_renter_resources" AnswerValue="y" ></Answer>
<Answer AnswerField="esi_category_legal_resources" AnswerValue="y" ></Answer>
<Answer AnswerField="subset_id" AnswerValue="83" ></Answer>
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




 