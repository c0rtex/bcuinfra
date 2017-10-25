<cfinvoke method="doTriage" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_8.cfc?wsdl" >
<cfinvokeargument name="partner_id" value="14">
<cfinvokeargument name="partner_screening_id" value="542215bbdf4d2">
<cfinvokeargument name="campaign_id" value="abc44">
<cfinvokeargument name="response_list" value='<?xml version="1.0" encoding="utf-16"?>
<screeningset>
<screening subset_id="79">
<answer answerfield="subset_id" answervalue="79"></answer>
<Answer AnswerField="mqc_zipcode" AnswerValue="90211" ></Answer>
<answer answerfield="mqc_medicare_enroll_situation" answervalue="mqc_medicare_enroll_age_65"></answer>
<answer answerfield="mqc_work_soc_sec_10yrs_40qtrs" answervalue="y"></answer>
</screening>
</screeningset>'>
<cfinvokeargument name="partner_session_id" value="abc123-1222-1221">
</cfinvoke>
<b>Response from server:</b><br/>
<cfdump var="#responseFromService#">




 