<cfset api_campaign = ''>
<cfif isdefined('request.campaign_id')>
	<cfset api_campaign = request.campaign_id>
</cfif>
<cfset screeningId  = 0 >
<cfif isdefined('url.screeningId')>
	<cfset screeningId = url.screeningId >
</cfif>
<cfif isdefined('url.api_campaign')>
	<cfset api_campaign = url.api_campaign  >
</cfif>
<cfset fName = 'testing'>
<cfset lName = 'the'>
<cfset mName = 'testing1233'>
<cfset dob = '11/21/1933'>
<cfset address_1 = 'ncoa address'>
<cfset city = 'ncoa city'>
<cfset zip = '10022'>
<cfset state_province = 'AK'>
<cfset email = 'testing@testthis.com'>
<cfset phone = '(212) 333-3333'>
<cfquery name="screeningdata"  datasource="#application.dbsrc#">				 
select a.answerfield answer, 
                                ifnull(sa.response, ifnull(o.option_code, '')) response, sa.submit_datetime submit
                        from screening_answerfield sa inner join answerfield a
                                        on sa.answerfield_id = a.answerfield_id
                                left outer join `option` o 
                                        on sa.option_id = o.option_id
                        where sa.screening_id= #screeningId#
</cfquery>
<cfquery name="campaigndata"  datasource="#application.dbsrc#">				 
select campaign_id from click where screening_id = #screeningId#
</cfquery>
<cfif campaigndata.recordcount gt 0>
	<cfset api_campaign = campaigndata.campaign_id>
	<cfoutput>db cid set to #api_campaign#</cfoutput>
</cfif>
<cfloop query="screeningdata">
<cfif answer eq 'be_clnt_fnm'>
	<cfset fName = response ><cfoutput>#fname#</cfoutput>
</cfif>
<cfif answer eq 'be_clnt_lnm'>
	<cfset lName = response ><cfoutput>#lname#</cfoutput>
</cfif>
<cfif answer eq 'be_clnt_mid'>
	<cfset mName = response ><cfoutput>#mname#</cfoutput>
</cfif>

<cfif answer eq 'mqc_birth_day'>
	<cfset mqc_birth_day = response ><cfoutput>#mqc_birth_day#</cfoutput>
</cfif>
<cfif answer eq 'mqc_birth_month'>
	<cfset mqc_birth_month = response ><cfoutput>#mqc_birth_month#</cfoutput>
</cfif>
<cfif answer eq 'mqc_birth_year'>
	<cfset mqc_birth_year = response ><cfoutput>#mqc_birth_year#</cfoutput>
</cfif>
<cfif answer eq 'mqc_zipcode'>
	<cfset zip = response ><cfoutput>#zip#</cfoutput>
</cfif>
<cfif answer eq 'email_address'>
	<cfset email = response ><cfoutput>#email#</cfoutput>
</cfif>
<cfif answer eq 'be_clnt_phnarea'>
	<cfset be_clnt_phnarea = response ><cfoutput>#be_clnt_phnarea#</cfoutput>
</cfif>
<cfif answer eq 'be_clnt_phnexch'>
	<cfset be_clnt_phnexch = response ><cfoutput>#be_clnt_phnexch#</cfoutput>
</cfif>
<cfif answer eq 'be_clnt_phnnum'>
	<cfset be_clnt_phnnum = response ><cfoutput>#be_clnt_phnnum#</cfoutput>
</cfif>
</cfloop>
<cfif mqc_birth_month lt 10>
	<cfset mqc_birth_month = '0' & mqc_birth_month >
</cfif>
<cfif mqc_birth_day lt 10>
	<cfset mqc_birth_day = '0' & mqc_birth_day >
</cfif>
<cfset dob = mqc_birth_month & '/' & mqc_birth_day & '/' & mqc_birth_year>
<cfset address_1 = 'ncoa address'>
<cfset state_province = 'AK'>
<cfset phone = '(' & be_clnt_phnarea & ')' &be_clnt_phnexch  &'-' & be_clnt_phnnum >
<cfoutput>phone #phone#</cfoutput>
<cfoutput>dob #dob#</cfoutput>

<cfhttp method="Post" 
    url="https://medicarequickcheck.benefitscheckup.org/screening-contact/"> 
  
    <cfhttpparam type="Formfield" 
        value="#fName#" 
        name="first_name"> 
    <cfhttpparam type="Formfield" 
        value="#lName#" 
        name="last_name"> 
    <cfhttpparam type="Formfield" 
        value="#mName#" 
        name="middle_name"> 
    <cfhttpparam type="Formfield" 
        value="#dob#" 
        name="dob"> 
    <cfhttpparam type="Formfield" 
        value="ncoa address" 
        name="address_1"> 
    <cfhttpparam type="Formfield" 
        value="ncoa city" 
        name="city"> 
    <cfhttpparam type="Formfield" 
        value="AK" 
        name="state_province"> 
    <cfhttpparam type="Formfield" 
        value="#zip#" 
        name="zip_code"> 
    <cfhttpparam type="Formfield" 
        value="#phone#" 
        name="phone_number"> 
    <cfhttpparam type="Formfield" 
        value="#phone#" 
        name="confirm_phone">
   <cfhttpparam type="Formfield" 
        value="#email#" 
        name="email">
    <cfhttpparam type="Formfield" 
        value="#email#" 
        name="confirmemail">
    <cfhttpparam type="Formfield" 
        value="true" 
        name="submitted">
     <cfhttpparam type="Formfield" 
        value="true" 
        name="consent">
     <cfhttpparam type="Formfield" 
        value="#api_campaign#" 
        name="api_val">
    <cfhttpparam type="Formfield" 
        value="#screeningId#" 
        name="screeningId">
    <cfhttpparam type="Formfield" 
        value="true" 
        name="submit">
</cfhttp> 
<cfoutput> 
File Content:<br> 
    #cfhttp.filecontent#<br> 
Mime Type:#cfhttp.MimeType#<br> 
</cfoutput> 

<cfif (findnocase('error',#cfhttp.filecontent#) gt 0) or (findnocase('alert-danger',#cfhttp.filecontent#) gt 0 )>
	<cfset aon_status = 'Error'>
<cfelse>
	<cfset aon_status = 'Success'>
</cfif>
<cffile action = "append"
    file = "/opt/bcu/apps/bcu_code/branch.benefitscheckup.org/code/util/ws_tests/test.cfm" output="#cfhttp.filecontent#" addnewline="yes"
   > 
<cffile action = "append"
    file = "/opt/bcu/apps/bcu_code/branch.benefitscheckup.org/code/util/ws_tests/test.cfm" output="screeningid: #screeningId# : #aon_status# api_val=#api_campaign#" addnewline="yes"
   > 
<cfoutput>aon_status: #aon_status#  api_campaign: #api_campaign#</cfoutput>
