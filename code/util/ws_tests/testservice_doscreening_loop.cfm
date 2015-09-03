

<cfquery name="contacts"  datasource="#application.dbsrc#">	
select a.answerfield, s.screening_id, sa.response, sa.submit_datetime, sa.answerfield_id 
from screening s,  screening_answerfield sa , answerfield a
where s.subset_id = 73
and s.screening_id = sa.screening_id  
and a.answerfield_id = sa.answerfield_id
and s.screening_id > 7788702 and s.screening_id < 7788703
and a.answerfield <> 'othercity'
order by s.screening_id ,a.answerfield
limit 1100
</cfquery>



<cfset original_id = 7568684>
<cfloop query="contacts">
<cfif contacts.answerfield eq 'be_clnt_fnm'>
 <cfset session.be_clnt_fnm = contacts.response >
</cfif>
<cfif contacts.answerfield eq 'be_clnt_lnm'>
 <cfset session.be_clnt_lnm = contacts.response >
</cfif>
<cfif contacts.answerfield eq 'be_clnt_mid'>
 <cfset session.be_clnt_mid = contacts.response >
</cfif>
<cfif contacts.answerfield eq 'be_clnt_phnarea'>
 <cfset session.be_clnt_phnarea = contacts.response >
</cfif>
<cfif contacts.answerfield eq 'be_clnt_phnexch'>
 <cfset session.be_clnt_phnexch = contacts.response >
</cfif>
<cfif contacts.answerfield eq 'be_clnt_phnnum'>
 <cfset session.be_clnt_phnnum = contacts.response >
</cfif>
<cfif contacts.answerfield eq 'email_address'>
 <cfset session.email_address = contacts.response >
</cfif>
<cfif contacts.answerfield eq 'mqc_birth_day'>
 <cfset session.mqc_birth_day = contacts.response >
</cfif>
<cfif contacts.answerfield eq 'mqc_birth_month'>
 <cfset session.mqc_birth_month = contacts.response >
</cfif>
<cfif contacts.answerfield eq 'mqc_birth_year'>
 <cfset session.mqc_birth_year = contacts.response >
</cfif>

<cfif contacts.answerfield eq 'mqc_zipcode'>
	<cfset session.mqc_zipcode = contacts.response >
<cfoutput>screening_id #contacts.screening_id#

</cfoutput>
  <cfinvoke method="doScreening" 
returnvariable="responseFromService" 
webservice="https://www.benefitscheckup.org/util/remotescreening_3_8.cfc?wsdl" >
<cfinvokeargument name="partner_id" value="14">
<cfinvokeargument name="partner_screening_id" value="">
<cfinvokeargument name="campaign_id" value="">

<cfinvokeargument name="response_list" value='
<?xml version="1.0" encoding="utf-16"?>
<ScreeningSet>
<Screening Subset_id="73">
<Answer AnswerField="be_clnt_fnm" AnswerValue="#session.be_clnt_fnm#" ></Answer>
<Answer AnswerField="be_clnt_mid" AnswerValue="#session.be_clnt_mid#" ></Answer>
<Answer AnswerField="be_clnt_lnm" AnswerValue="#session.be_clnt_lnm#" ></Answer>

<Answer AnswerField="mqc_birth_month" AnswerValue="#session.mqc_birth_month#" ></Answer>
<Answer AnswerField="mqc_birth_day" AnswerValue="#session.mqc_birth_day#" ></Answer>
<Answer AnswerField="mqc_birth_year" AnswerValue="#session.mqc_birth_year#" ></Answer>

<Answer AnswerField="mqc_zipcode" AnswerValue="#session.mqc_zipcode#" ></Answer>
<Answer AnswerField="email_address" AnswerValue="#session.email_address#" ></Answer>
<Answer AnswerField="be_clnt_phnarea" AnswerValue="#session.be_clnt_phnarea#" ></Answer>
<Answer AnswerField="be_clnt_phnexch" AnswerValue="#session.be_clnt_phnexch#" ></Answer>
<Answer AnswerField="be_clnt_phnnum" AnswerValue="#session.be_clnt_phnnum#" ></Answer>
</Screening>
</ScreeningSet>
'>
<cfinvokeargument name="partner_session_id" value="">
</cfinvoke>
<b>Response from server:</b><br/>
<cfdump var="#responseFromService#">
</cfif>
<cfflush>
</cfloop>







 