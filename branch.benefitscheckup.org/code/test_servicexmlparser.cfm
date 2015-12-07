<!-- This script takes an input xml file from the screenforbenefits.cfc parses the xml and passes the variables into the bcu screening--> <!-- Try and Catch all processing errors --> 
<cfparam name="testresponse" default="1">
<cfparam name="request.partner_id" default="0">
<cfparam name="request.client_id" default="0">
<cfparam name="request.org_id" default="0">
<cfparam name="request.partner_screening_id" default="">
<cfparam name="PROGRAM_XML" default="">
<cfset application.chicagovars = structnew()>
<!-- default test parameter xml string -->
<cfif testresponse and not isdefined('response_list')>
<cfset xmlstring = '
<?xml version="1.0" encoding="utf-16"?>
<ScreeningSet>
	<Screening Subset_id="0">
		<Answers>
			<Answer AnswerField="client" AnswerValue="1353-self"/>
			<Answer AnswerField="gender" AnswerValue="m"/>
			<Answer AnswerField="zip" AnswerValue="96789"/>
			<Answer AnswerField="dob_month" AnswerValue="1"/>
			<Answer AnswerField="dob_year" AnswerValue="1910"/>
			<Answer AnswerField="citizen" AnswerValue="13-citizen"/>
			<Answer AnswerField="leg_resident_5years" AnswerValue="n"/>
			<Answer AnswerField="marital_stat" AnswerValue="4-married"/>
			<Answer AnswerField="medicare_receive" AnswerValue="y"/>
			<Answer AnswerField="receive_lis" AnswerValue="y"/>
			<Answer AnswerField="veteran" AnswerValue="n"/>
			<Answer AnswerField="sp_veteran" AnswerValue="n"/>
			<Answer AnswerField="tricare" AnswerValue="n"/>
			<Answer AnswerField="alzheimer" AnswerValue="n"/>
			<Answer AnswerField="eyecare" AnswerValue="n"/>
			<Answer AnswerField="disabled" AnswerValue="n"/>
			<Answer AnswerField="blind" AnswerValue="n"/>
			<Answer AnswerField="dep_care" AnswerValue="n"/>
			<Answer AnswerField="property_tax" AnswerValue="n"/>
			<Answer AnswerField="utility_2" AnswerValue="n"/>
			<Answer AnswerField="chip" AnswerValue="n"/>
			<Answer AnswerField="hh_expenses" AnswerValue="0"/>
			<Answer AnswerField="med_costs" AnswerValue="0"/>
			<Answer AnswerField="scsep_inc" AnswerValue="0"/>
			<Answer AnswerField="s_income_pri_retire" AnswerValue="0"/>
			<Answer AnswerField="sp_income_pri_retire" AnswerValue="0"/>
			<Answer AnswerField="s_sp_income_pri_retire_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_income_pri_retire_simple" AnswerValue="0"/>
			<Answer AnswerField="s_income_dividends" AnswerValue="0"/>
			<Answer AnswerField="sp_income_dividends" AnswerValue="0"/>
			<Answer AnswerField="s_sp_income_dividends_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_income_dividends_simple" AnswerValue="0"/>
			<Answer AnswerField="s_income_ssi" AnswerValue="0"/>
			<Answer AnswerField="sp_income_ssi" AnswerValue="0"/>
			<Answer AnswerField="s_sp_income_ssi_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_income_ssi_simple" AnswerValue="0"/>
			<Answer AnswerField="s_income_ss_disable" AnswerValue="0"/>
			<Answer AnswerField="sp_income_ss_disable" AnswerValue="0"/>
			<Answer AnswerField="s_sp_income_ss_disable_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_income_ss_disable_simple" AnswerValue="0"/>
			<Answer AnswerField="s_income_ss_retire" AnswerValue="0"/>
			<Answer AnswerField="sp_income_ss_retire" AnswerValue="0"/>
			<Answer AnswerField="s_sp_income_ss_retire_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_income_ss_retire_simple" AnswerValue="0"/>
			<Answer AnswerField="s_income_rr_ben" AnswerValue="0"/>
			<Answer AnswerField="sp_income_rr_ben" AnswerValue="0"/>
			<Answer AnswerField="s_sp_income_rr_ben_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_income_rr_ben_simple" AnswerValue="0"/>
			<Answer AnswerField="s_income_vet_ben" AnswerValue="0"/>
			<Answer AnswerField="sp_income_vet_ben" AnswerValue="0"/>
			<Answer AnswerField="s_sp_income_vet_ben_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_income_vet_ben_simple" AnswerValue="0"/>
			<Answer AnswerField="s_income_unemploy" AnswerValue="0"/>
			<Answer AnswerField="sp_income_unemploy" AnswerValue="0"/>
			<Answer AnswerField="s_sp_income_unemploy_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_income_unemploy_simple" AnswerValue="0"/>
			<Answer AnswerField="s_income_tanf" AnswerValue="0"/>
			<Answer AnswerField="sp_income_tanf" AnswerValue="0"/>
			<Answer AnswerField="s_sp_income_tanf_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_income_tanf_simple" AnswerValue="0"/>
			<Answer AnswerField="s_income_cash_assist" AnswerValue="0"/>
			<Answer AnswerField="sp_income_cash_assist" AnswerValue="0"/>
			<Answer AnswerField="s_sp_income_cash_assist_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_income_cash_assist_simple" AnswerValue="0"/>
			<Answer AnswerField="s_income_other_nw" AnswerValue="0"/>
			<Answer AnswerField="sp_income_other_nw" AnswerValue="0"/>
			<Answer AnswerField="s_sp_income_other_nw_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_income_other_nw_simple" AnswerValue="0"/>
			<Answer AnswerField="s_income_earned" AnswerValue="0"/>
			<Answer AnswerField="sp_income_earned" AnswerValue="0"/>
			<Answer AnswerField="s_sp_income_earned_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_income_earned_simple" AnswerValue="0"/>
			<Answer AnswerField="s_asset_cash" AnswerValue="0"/>
			<Answer AnswerField="sp_asset_cash" AnswerValue="0"/>
			<Answer AnswerField="s_sp_asset_cash_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_asset_cash_simple" AnswerValue="0"/>
			<Answer AnswerField="s_asset_auto1" AnswerValue="0"/>
			<Answer AnswerField="sp_asset_auto1" AnswerValue="0"/>
			<Answer AnswerField="s_sp_asset_auto1_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_asset_auto1_simple" AnswerValue="0"/>
			<Answer AnswerField="s_asset_auto2" AnswerValue="0"/>
			<Answer AnswerField="sp_asset_auto2" AnswerValue="0"/>
			<Answer AnswerField="s_sp_asset_auto2_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_asset_auto2_simple" AnswerValue="0"/>
			<Answer AnswerField="s_asset_home" AnswerValue="0"/>
			<Answer AnswerField="sp_asset_home" AnswerValue="0"/>
			<Answer AnswerField="s_sp_asset_home_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_asset_home_simple" AnswerValue="0"/>
			<Answer AnswerField="s_asset_retirement" AnswerValue="0"/>
			<Answer AnswerField="sp_asset_retirement" AnswerValue="0"/>
			<Answer AnswerField="s_sp_asset_retirement_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_asset_retirement_simple" AnswerValue="0"/>
			<Answer AnswerField="s_asset_stocks" AnswerValue="0"/>
			<Answer AnswerField="sp_asset_stocks" AnswerValue="0"/>
			<Answer AnswerField="s_sp_asset_stocks_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_asset_stocks_simple" AnswerValue="0"/>
			<Answer AnswerField="s_asset_life_cash" AnswerValue="0"/>
			<Answer AnswerField="sp_asset_life_cash" AnswerValue="0"/>
			<Answer AnswerField="s_sp_asset_life_cash_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_asset_life_cash_simple" AnswerValue="0"/>
			<Answer AnswerField="s_asset_life_face" AnswerValue="0"/>
			<Answer AnswerField="sp_asset_life_face" AnswerValue="0"/>
			<Answer AnswerField="s_sp_asset_life_face_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_asset_life_face_simple" AnswerValue="0"/>
			<Answer AnswerField="s_asset_revocable" AnswerValue="0"/>
			<Answer AnswerField="sp_asset_revocable" AnswerValue="0"/>
			<Answer AnswerField="s_sp_asset_revocable_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_asset_revocable_simple" AnswerValue="0"/>
			<Answer AnswerField="s_asset_irrevocable" AnswerValue="0"/>
			<Answer AnswerField="sp_asset_irrevocable" AnswerValue="0"/>
			<Answer AnswerField="s_sp_asset_irrevocable_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_asset_irrevocable_simple" AnswerValue="0"/>
			<Answer AnswerField="s_asset_other_a" AnswerValue="0"/>
			<Answer AnswerField="sp_asset_other_a" AnswerValue="0"/>
			<Answer AnswerField="s_sp_asset_other_a_simple" AnswerValue="0"/>
			<Answer AnswerField="hh_asset_other_a_simple" AnswerValue="0"/>
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
		<cfset resultset = QueryNew("screening_id,partner_screening_id,partner_id,org_id,subset_id,client_id,report_url,validation_error,program_list,screening_status,reentry_number,date_time,program_title","integer,integer,integer,integer,integer,varchar,varchar,varchar,varchar,varchar,integer,date,varchar")>
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
		<cfset results = #structinsert(structBCUvars[#x#], structRemoteVars.ScreeningSet.screening[x].Answer[i].XmlAttributes.AnswerField,structRemoteVars.ScreeningSet.screening[x].Answer[i].XmlAttributes.AnswerValue)#>
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
	<cfif current_subset_id eq 41>
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
	
	</cfif>


<cfelseif current_subset_id neq 41>

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
		<cfset varvalue = #replacenocase(varvalue,"_","-")#>
		<cfset 'mappedresults.#listvar#' = varvalue >
	</cfif>
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
<h3>bugg</h3>
<CFSET session.END_TIME = CreateODBCDATETIME(now())>                                
<cfset session.prg_list = "">                               
<cfset session.buff_list = "">                                
 <!--- 07/09/2002 REM  The "normal" pass --->  
 <cf_cacheProgramPool>
<h3>bugg2</h3>                              
 <cf_tagTestRules ynDoBuffer="FALSE">  
<h3>bugg3</h3>                                                                
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
	(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenAdjustedVal#, 0, 0)  
	</CFQUERY>
	<cfset list_prg = #Mid(prg_id, 2, Len(prg_id) - 2)#>
	<cfset session.newlist = #listappend(session.newlist,StructFind(application.prgvars, list_prg),";")#>
	<cf_cacheProgramPool action="get" id="#StructFind(application.prgvars, list_prg)#" var="pobj" codevar="code">
	<cf_displayText group="program" code="program_#code#" var="programName">
       <cfset programName = #XmlFormat(programName)#>
	<cfset session.programtitlelist = #listappend(session.programtitlelist,'"#programName#"',";")#>
	<cfoutput>#session.programtitlelist#</cfoutput>
	<cfset cid = "">
	<cfquery name="getCat" DATASOURCE="#session.datasrc#">                                		
	select programcategory_id  from programcategory where code = '#pobj.cat#'   
	</CFQUERY>
	<cfif isdefined('getCat.programcategory_id')>
		<cfset cid = getCat.programcategory_id>
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
<cfset PDFNAME = "">
<cfif session.partner_id eq 47 >
<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#-ws" fileformat="pdf" coverpage="true" toc="false" partner_id="#request.partner_id#"   pgbreaks="false" >
</cfif>
<!---cfoutput>#session.prg_list# #session.cfid# #session.cftoken#
</cfoutput--->
	<cfset screeningresults.date_time = #now()# >
	<cfset screeningresults.program_list = session.prg_list>
	<cfset screeningresults.screening_id = session.screening_id >
	<cfif session.prg_list eq "">
		<cfset screeningresults.report_url = "https://#session.servername#/cf/util/noprogramsreturned.pdf">
	<cfelse>
		<!---cfoutput>#session.screening_id# https://#session.servername#/cf/pdf/#pdfname#.pdf</cfoutput--->
		<cfset screeningresults.report_url = "https://#session.servername#/cf/pdf/#pdfname#.pdf">
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