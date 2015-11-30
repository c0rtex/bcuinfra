<!-- This script takes an input xml file from the screenforbenefits.cfc parses the xml and passes the variables into the bcu screening--> <!-- Try and Catch all processing errors --> 
<!-- default test parameter xml string -->
<cfparam name="org_id" default="0" type="integer">
<cfset xmlstring = '<Screening>
<Answer AnswerField="marital_stat" AnswerValue="2" />
<Answer AnswerField="gender" AnswerValue="2" />
<Answer AnswerField="zip" AnswerValue="05773" />
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
<Answer AnswerField="med_costs" AnswerValue="$88.00" />
<Answer AnswerField="rx_ins_co_pay" AnswerValue="2" />
<Answer AnswerField="rx_drugcosts" AnswerValue="50" />
<Answer AnswerField="rx_all_drugs" AnswerValue="2" />
<Answer AnswerField="stateduration" AnswerValue="10" />
<Answer AnswerField="medicare_receive" AnswerValue="1" />
<Answer AnswerField="hurricane" AnswerValue="2" />
<Answer AnswerField="lis_undeemed" AnswerValue="2" />
<Answer AnswerField="rec_ca_drugdiscount" AnswerValue="1" />
</Screening>' > 
<cfset mappedresults = structnew()>
<cfset form = structnew()>
<cfif isdefined('response_list')>
	<cfset xmlstring = response_list >
</cfif>
<cfset structSynergyVars = #xmlparse(xmlstring)#>
<!--- cfdump var="#structSynergyVars#" expand="yes" label="yes" ---->
<cfset countvars = structcount(structSynergyVars.screening) >
<cfset structBCUvars = structnew()>
<cfloop from="1" index="i" to="#countvars#">
	<cfset results = #structinsert(structBCUvars, structSynergyVars.screening.Answer[i].XmlAttributes.AnswerField,structSynergyVars.screening.Answer[i].XmlAttributes.AnswerValue)#>
</cfloop>
<cfset AFList = "">
<!--- cfdump var="#structBCUvars#" --->
<cfloop collection="#structBCUvars#" item="recvar">
<cfif #findnocase('ec_',recvar)# gt 0>
<cfset teststring = #structfind(structBCUvars,recvar)# >
<cfif teststring eq 1>
	<cfset "mappedresults.#recvar#" = "y">
<cfset AFLIST =  AFLIST & "c-#recvar#," >
</cfif>
</cfif>
</cfloop>
<cfset AFLIST = AFLIST & "y-disabled,s-st,o-client1-client,y-pri_resident,s-zip,o-citizen,n-dob_month,n-dob_year,o-marital_stat,c-medicare_receive,c-receive_partd,c-receive_lis,c-med_receive,c-receive_creditable_coverage,c-receive_msp,c-ssi_receive,y-hurricane,s-hh_depend,s-no_hh_members,s-dep_child,y-lis_undeemed,y-lis_apply,i-s_income_earned,i-s_income_other_nw,a-s_asset_other_a,y-rx_ins,y-rx_ins_co_pay,y-rx_all_drugs,n-stateduration,n-rx_drugcosts,n-med_costs">
<!-- Load form vars -->
<!-- c-medicare_receive,c-receive_partd,c-receive_lis,c-med_receive,c-receive_creditable_coverage,c-receive_msp,c-ssi_receive -->
<cfif isdefined('structBCUvars.gender')>
	<cfset AFLIST = AFLIST & ",g-gender">
</cfif>
<cf_validatezip zipcode="#structBCUvars.ZIP#" state_id="#structBCUvars.state#">
<!-- Check that zip is valid -->
<cfif validationresult eq "false">
	<cfset screeningresults.error_code = "The zip code you entered is invalid for the state selected.">
<cfset screeningresults.report_url = "">
<cfelse>
<!-- Do screening --> 
<cfparam name="structBCUvars.ZIP" default="0"> 
<cfparam name="structBCUvars.medicare_receive" default="0"> 
<cfparam name="structBCUvars.receive_partd" default="0"> 
<cfparam name="structBCUvars.receive_lis" default="0"> 
<cfparam name="structBCUvars.med_receive" default="0"> 
<cfparam name="structBCUvars.ssi_receive" default="0"> 
<cfparam name="structBCUvars.receive_creditable_coverage" default="0"> 
<cfparam name="structBCUvars.receive_msp" default="0"> 
<cfparam name="structBCUvars.lis_apply" default="0"> 
<cfparam name="structBCUvars.ssd_receive_2" default="0"> 
<cfparam name="structBCUvars.ssd_receive" default="0"> 
<cfparam name="structBCUvars.dob_month" default="0"> 
<cfparam name="structBCUvars.dob_year" default="0"> 
<cfparam name="structBCUvars.stateduration" default="0"> 
<cfparam name="structBCUvars.marital_stat" default="2"> 
<cfparam name="structBCUvars.state" default=""> 
<cfparam name="structBCUvars.state_id" default="">
<cfparam name="structBCUvars.citizen" default="1"> 

<cfif isdefined('structBCUvars.stateduration')> 	
<cfset mappedresults.stateduration = structBCUvars.stateduration> 
</cfif> 
<cfparam name="structBCUvars.rx_drugcosts" default="0"> 
<cfparam name="structBCUvars.med_costs" default="0"> 
<cfif structBCUvars.ssd_receive_2 eq 1> 
	<cfset mappedresults.ssd_receive_2 = "y"> 
<cfelse> 
	<cfset mappedresults.ssd_receive_2 = "n"> 
</cfif> 
<cfif structBCUvars.ssd_receive eq 1> 	
	<cfset mappedresults.ssd_receive = "y"> 
<cfelse> 	
	<cfset mappedresults.ssd_receive = "n">
</cfif> 
<cfif structBCUvars.medicare_receive eq 1> 	
	<cfset mappedresults.medicare_receive = "y"> 
<cfelse> 
	<cfset mappedresults.medicare_receive = "n"> 
</cfif> 
<cfif structBCUvars.receive_lis eq 1> 	
	<cfset mappedresults.receive_lis = "y"> 
<cfelse> 	
	<cfset mappedresults.receive_lis = "n"> 
</cfif> 
<cfif structBCUvars.receive_partd eq 1> 	
<cfset mappedresults.receive_partd = "y"> 
<cfelse> 	
<cfset mappedresults.receive_partd = "n"> 
</cfif> 
<cfif structBCUvars.med_receive eq 1> 	
<cfset mappedresults.med_receive = "y"> 
<cfelse> 	
<cfset mappedresults.med_receive = "n">
</cfif> 
<cfif structBCUvars.ssi_receive eq 1> 	
<cfset mappedresults.ssi_receive = "y"> 
<cfelse> 	
<cfset mappedresults.ssi_receive = "n"> 
</cfif>  
<cfif structBCUvars.receive_creditable_coverage eq 1> 	
<cfset mappedresults.receive_creditable_coverage = "y"> 
<cfelse> 	
<cfset mappedresults.receive_creditable_coverage = "n"> 
</cfif> 
<cfif structBCUvars.receive_msp eq 1> 	
<cfset mappedresults.receive_msp = "y"> 
<cfelse> 	
<cfset mappedresults.receive_msp = "n">
</cfif> 
<!-- y-disabled,y-hurricane,s-hh_depend,s-no_hh_members,y-lis_undeemed --> 
<cfparam name="structBCUvars.disabled" default="0"> 
<cfparam name="structBCUvars.blind" default="0"> 
<cfparam name="structBCUvars.hurricane" default="0"> 
<cfparam name="structBCUvars.hh_depend" default="0"> 
<cfparam name="structBCUvars.no_hh_members" default="0"> 
<cfparam name="structBCUvars.lis_undeemed" default="0"> 
<cfparam name="structBCUvars.dep_child" default="0"> 
<cfparam name="structBCUvars.pri_resident" default="1"> 
<cfparam name="structBCUvars.rx_ins" default="0"> 
<cfparam name="structBCUvars.rx_all_drugs" default="0"> 
<cfparam name="structBCUvars.rx_ins_co_pay" default="0"> 
<cfif structBCUvars.hurricane eq 1> 	
	<cfset mappedresults.hurricane = "y"> 
<cfelse> 	
	<cfset mappedresults.hurricane = "n">
</cfif> 
<cfif isdefined('structBCUvars.pri_resident') and structBCUvars.pri_resident eq 1> 
	<cfset mappedresults.pri_resident = "Y"> 
<cfelse> 	
    <cfset mappedresults.pri_resident = "N"> 
</cfif> 
<cfif isdefined('structBCUvars.DISABLED') and structBCUvars.DISABLED eq 1> 	
	<cfset mappedresults.DISABLED = "Y"> 
<cfelse> 	
	<cfset mappedresults.DISABLED = "N"> 
</cfif> 
<cfif isdefined('structBCUvars.Blind') and structBCUvars.Blind eq 1> 	
	<cfset mappedresults.Blind = "Y"> 
<cfelse> 	
	<cfset mappedresults.Blind = "N"> 
</cfif> 
<cfif isdefined('structBCUvars.rx_ins') and structBCUvars.rx_ins eq 1> 	
	<cfset mappedresults.rx_ins = "Y"> 
<cfelse> 	
	<cfset mappedresults.rx_ins = "N"> 
</cfif> 
<cfif isdefined('structBCUvars.rx_all_drugs') and structBCUvars.rx_all_drugs eq 1> 	
	<cfset mappedresults.rx_all_drugs = "Y"> 
<cfelse> 	
	<cfset mappedresults.rx_all_drugs = "N"> 
</cfif> 
<cfif isdefined('structBCUvars.rx_ins_co_pay') and structBCUvars.rx_ins_co_pay eq 1> 	
	<cfset mappedresults.rx_ins_co_pay = "Y"> 
<cfelse> 	
	<cfset mappedresults.rx_ins_co_pay = "N"> 
</cfif> 
<cfset mappedresults.ZIP = structBCUvars.zip> 
<cfset mappedresults.HH_DEPEND = structBCUvars.hh_depend> 
<cfset mappedresults.DOB_MONTH = structBCUvars.DOB_MONTH> 
<cfset mappedresults.DOB_YEAR = structBCUvars.DOB_YEAR> 
<cfparam name="structBCUvars.s_asset_other_a" default="0"> 
<cfparam name="structBCUvars.s_sp_asset_other_a" default="0"> 
<cfparam name="structBCUvars.s_income_earned" default="0"> 
<cfparam name="structBCUvars.s_sp_income_earned" default="0"> 
<cfparam name="structBCUvars.s_sp_income_other_nw" default="0"> 
<cfparam name="structBCUvars.s_income_other_nw" default="0"> 
<!-- Grab income and asset vars and get rid of dollar sign --> 
<cfset mappedresults.s_asset_other_a = #replacenocase(structBCUvars.s_asset_other_a,"$","")#> 
<cfset mappedresults.s_income_earned = #replacenocase(structBCUvars.s_income_earned,"$","")#> 
<cfset mappedresults.s_sp_asset_other_a = #replacenocase(structBCUvars.s_sp_asset_other_a,"$","")#> 
<cfset mappedresults.s_sp_income_earned = #replacenocase(structBCUvars.s_sp_income_earned,"$","")#> 
<cfset mappedresults.s_sp_income_other_nw = #replacenocase(structBCUvars.s_sp_income_other_nw,"$","")#> 
<cfset mappedresults.s_income_other_nw = #replacenocase(structBCUvars.s_income_other_nw,"$","")#>  
<!-- Convert values to integers --> 
<cfset mappedresults.s_asset_other_a = int(mappedresults.s_asset_other_a)+ int(mappedresults.s_sp_asset_other_a) > 
<cfset mappedresults.s_income_earned = int(mappedresults.s_income_earned) +  int(mappedresults.s_sp_income_earned)> 
<cfset mappedresults.s_income_other_nw = int(mappedresults.s_income_other_nw) + int(mappedresults.s_sp_income_other_nw) > 
<cfset mappedresults.s_sp_income_earned = int(mappedresults.s_sp_income_earned) > 
<cfset mappedresults.s_sp_income_other_nw = int(mappedresults.s_sp_income_other_nw) > 
<cfset mappedresults.s_sp_income_other_nw = int(mappedresults.s_sp_income_other_nw) > 
<!-- set other form values directly --> 
<cfset mappedresults.ST = structBCUvars.State>
<cfset mappedresults.state_id = structBCUvars.State>
<cfset mappedresults.rx_drugcosts = structBCUvars.rx_drugcosts> 
<cfset structBCUvars.med_costs = #replacenocase(structBCUvars.med_costs,"$","")#> 
<cfset mappedresults.med_costs = structBCUvars.med_costs> 
<cfparam name="mappedresults.marital_stat" default="6-Single"> 
<cfif structBCUvars.MARITAL_STAT eq 1> 	
<cfset mappedresults.MARITAL_STAT = "6-Single"> 
<cfelseif structBCUvars.MARITAL_STAT eq 2> 	
<cfset mappedresults.MARITAL_STAT = "4-Married"> 
<cfelseif structBCUvars.MARITAL_STAT eq 4> 	
<cfset mappedresults.MARITAL_STAT = "1361-Married Living Separately"> 
<cfelseif structBCUvars.MARITAL_STAT eq 5> 	
<cfset mappedresults.MARITAL_STAT = "5-Divorced"> 
<cfelseif structBCUvars.MARITAL_STAT eq 3> 	
<cfset mappedresults.MARITAL_STAT = "7-Widowed"> 
</cfif> <!-- receives --> 
<cfif isdefined('structBCUvars.LIS_APPLY') and structBCUvars.LIS_APPLY eq 1> 	
	<cfset mappedresults.LIS_APPLY = "y"> 
<cfelse> 	
	<cfset mappedresults.LIS_APPLY = "n"> 
</cfif> 
<cfif isdefined('structBCUvars.CITY') > 	
	<cfset mappedresults.CITY = structBCUvars.CITY > 	
	<cfset AFLIST = AFLIST & ",y-city"> 
</cfif> 
<cfif isdefined('structBCUvars.CITYSUBCC') > 	
	<cfset mappedresults.CITYSUBCC = structBCUvars.CITYSUBCC > 	
	<cfset AFLIST = AFLIST & ",y-citysubcc"> 
</cfif> 
<cfif  isdefined('structBCUvars.GENDER') and structBCUvars.GENDER eq 1> 	
<cfset mappedresults.GENDER = "m"> 	
<cfset AFLIST = AFLIST & ',g-gender'> 
<cfelseif isdefined('structBCUvars.GENDER') and structBCUvars.GENDER eq 2 > 	
<cfset mappedresults.GENDER = "f"> 
<cfset AFLIST = AFLIST & ',g-gender'> 
</cfif> 
<!-- do screening --> 
<cfset url.SUBSET_ID = 27> 
<cfset url.USER_ID = "null" > 

<!-- default demo org id -->
<cfparam name="url.org_id" default="#org_id#" > 
<!-- synergy partner --> 
<cfset url.PARTNER_ID = 26 > 
<!-- Web Service Source --> 
<cfset url.SOURCE_ID = "8"> 
<cfif isdefined('structBCUvars.hurricane') and structBCUvars.hurricane eq 1> 
<cfset mappedresults.hurricane = "Y"> 
<cfelse > 	
<cfset mappedresults.hurricane = "n"> 
</cfif> 
<!-- Citizenship defaults to citizen --> 
<cfset mappedresults.CITIZEN = "13-Citizen"> 
<cfif structBCUvars.CITIZEN eq "1"> 	
	<cfset mappedresults.CITIZEN = "13-Citizen"> 
<cfelseif structBCUvars.CITIZEN eq "2"> 	
	<cfset mappedresults.CITIZEN = "14-Legal Resident"> 
<cfelseif structBCUvars.CITIZEN eq "3"> 	
	<cfset mappedresults.CITIZEN = "15-Other Qualified Alien"> 
<cfelseif structBCUvars.CITIZEN eq "5"> 	
<cfset mappedresults.CITIZEN = "16-Other"> 
</cfif>  
<cfset mappedresults.NO_HH_MEMBERS = structBCUvars.no_hh_members> 
<cfset mappedresults.dep_child = structBCUvars.dep_child> 
<cfset mappedresults.CLIENT1 = "1358-Client"> 
	<cfparam name="structBCUvars.client" default="1"> 
<cfif structBCUvars.client eq "1"> 	
	<cfset mappedresults.CLIENT1 = "1353-Self">
<cfelseif structBCUvars.client eq "2"> 	
	<cfset mappedresults.CLIENT1 = "2345-Spouse">					 
<cfelseif structBCUvars.client eq "3"> 	
	<cfset mappedresults.CLIENT1 = "1354-Mother"> 
<cfelseif structBCUvars.client eq "4"> 	
	<cfset mappedresults.CLIENT1 = "1355-Father"> 
<cfelseif structBCUvars.client eq "5"> 	
	<cfset mappedresults.CLIENT1 = "1356-Sister"> 
<cfelseif structBCUvars.client eq "6"> 
	<cfset mappedresults.CLIENT1 = "1357-Brother"> 
<cfelseif structBCUvars.client eq "7"> 	
	<cfset mappedresults.CLIENT1 = "1358-Client"> 
<cfelseif structBCUvars.client eq "8"> 	
	<cfset mappedresults.CLIENT1 = "1359-Test Case"> 
<cfelseif structBCUvars.client eq "9">
 	<cfset mappedresults.CLIENT1 = "1360-Other"> 
</cfif> 
<cfset mappedresults.SENT = 1> 
<cfif isdefined('structBCUvars.LIS_UNDEEMED') and structBCUvars.LIS_UNDEEMED eq 1>
 	<cfset mappedresults.LIS_UNDEEMED = "Y">
<cfelse >
	  	<cfset mappedresults.LIS_UNDEEMED = "n">
</cfif> 
<cfset mappedresults.client_other = ""> 
<!-- load screening stuff --> 
<cf_sessionLoadVars>
<cfif session.state_id eq ''>
	<cfset session.state_id = mappedresults.st>
</cfif> 
<cfset session.sessionDetailsLogged = False> 
<cf_handleScreening action="start"> 


<cf_logScreeningInput   structname="mappedresults" aflist="#afList#"> 
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
  <cfif Not IsDefined('session.subset_id') Or session.subset_id neq 1>                                
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
<cfset session.prg_list = ListDeleteAt(session.prg_list, helperIndex)>                                		</cfif>                                		<cfset helperIndex = ListContains(session.buff_list, helper_prg_id)>                                		<cfif helperIndex gt 0>                                			
<cfset session.buff_list = ListDeleteAt(session.buff_list, helperIndex)>                                		</cfif>                               
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
<cfif IsDefined('session.partner_id') And session.partner_id eq 5>
	<cfif ListLen(session.prg_list)>
		<cfif session.citizen eq 'Citizen'>
			<cfset showAddedInfo="false">
		<cfelse>
			<cfset showAddedInfo="true">
		</cfif>
		<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" fileformat="html" coverpage="false" toc="false" addedinfo="#showAddedInfo#" ltccinfo="false" pgbreaks="false" brandname="LTCC Public Programs">
	<cfelse>
		<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" blankreport="true">
	</cfif>
</cfif>
<cfoutput>#session.county#</cfoutput>
<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#-synergy" fileformat="pdf" coverpage="true" toc="false"   pgbreaks="false" >
<cfoutput>#session.prg_list#
#session.cfid# #session.cftoken#
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
</cfif>
