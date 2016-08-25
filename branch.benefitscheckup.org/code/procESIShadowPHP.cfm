<cfparam name="SESSION.esiTotalPoints" default="0">
<cfparam name="SESSION.esiPovertyLevel" default="0">
<cfparam name="session.poverty_index" default="0">
<cfparam name="SESSION.esi_zip" default="0">
<cfparam name="getcounty.county_id" default="1">
<cfparam name="getcounty.county_name" default="">
<cfparam name="session.esiPercentage" default="0">
<cfparam name="SESSION.esi_grossmonthlyincome" default="0">
<cfparam name="SESSION.esi_totalassets" default="0">
<cfparam name="esiMonthlyIncomeByLocation" default="1">
<cfparam name="SESSION.esi_debtestimate" default="0">
<cfparam name="session.esi_dependgrandchild" default="n">
<cfparam name="eligibleForDebtManagement" default="false">
<cfparam name="SESSION.client_id" default="0">
<cfset calcIncome = SESSION.esi_grossmonthlyincome * .2>
<cfset functionDebugging = false>
<cfset esiSiteArray = ArrayNew(1)>
<cfset esiSiteArray[1]['county_id'] = "55079">
<cfset esiSiteArray[1]['county'] = "Milwaukee">  
<cfset esiSiteArray[1]['sitename'] = "Aurora Family Service"> 
<cfset esiSiteArray[1]['phonenumber'] = "414-482-8802"> 

<cfset esiSiteArray[2]['county_id'] = "39035">
<cfset esiSiteArray[2]['county'] = "Cuyahoga">  
<cfset esiSiteArray[2]['sitename']  = "Cleveland Department on Aging"> 
<cfset esiSiteArray[2]['phonenumber'] = "216-664-2833">

<cfset esiSiteArray[3]['county_id'] = "06037">
<cfset esiSiteArray[3]['county'] = "Los Angeles">  
<cfset esiSiteArray[3]['sitename']  = "Insight Center for Community Economic Development"> 
<cfset esiSiteArray[3]['phonenumber'] = "213-235-2614">

<cfset esiSiteArray[4]['county_id'] = "34021">
<cfset esiSiteArray[4]['county'] = "Mercer">  
<cfset esiSiteArray[4]['sitename']  = "NCOA's New Jersey Senior Community Service Employment Program Resource Center"> 
<cfset esiSiteArray[4]['phonenumber'] = "732-367-7111">

<cfset esiSiteArray[5]['county_id'] = "26163">
<cfset esiSiteArray[5]['county'] = "Wayne">  
<cfset esiSiteArray[5]['sitename']  = "Detroit Area Agency on Aging"> 
<cfset esiSiteArray[5]['phonenumber'] = "313-446-4444">

<cfset esiSiteArray[6]['county_id'] = "06075">
<cfset esiSiteArray[6]['county'] = "San Francisco">  
<cfset esiSiteArray[6]['sitename']  = "Family Services Agency of San Francisco"> 
<cfset esiSiteArray[6]['phonenumber'] = "415-474-7310">

<cfset esiSiteArray[7]['county_id'] = "36061">
<cfset esiSiteArray[7]['county'] = "New York">  
<cfset esiSiteArray[7]['sitename']  = "Lenox Hill Neighborhood House"> 
<cfset esiSiteArray[7]['phonenumber'] = "212-744-5022">

<cfset esiSiteArray[8]['county_id'] = "17031">
<cfset esiSiteArray[8]['county'] = "Cook">  
<cfset esiSiteArray[8]['sitename']  = "AgeOptions"> 
<cfset esiSiteArray[8]['phonenumber'] = "708-383-0258">

<cfset esiSiteArray[9]['county_id'] = "36027">
<cfset esiSiteArray[9]['county'] = "Dutchess">  
<cfset esiSiteArray[9]['sitename']  = "PathStone Corporation"> 
<cfset esiSiteArray[9]['phonenumber'] = "585-340-3369">

<cfset esiSiteArray[10]['county_id'] = "36105">
<cfset esiSiteArray[10]['county'] = "Sullivan">  
<cfset esiSiteArray[10]['sitename']  = "PathStone Corporation"> 
<cfset esiSiteArray[10]['phonenumber'] = "585-340-3369">

<cfset esiSiteArray[11]['county_id'] = "36071">
<cfset esiSiteArray[11]['county'] = "Orange">  
<cfset esiSiteArray[11]['sitename']  = "PathStone Corporation"> 
<cfset esiSiteArray[11]['phonenumber'] = "585-340-3369">

<cfset esiSiteArray[12]['county_id'] = "04019">
<cfset esiSiteArray[12]['county'] = "Pima">  
<cfset esiSiteArray[12]['sitename']  = "United Way of Tucson and Southern Arizona"> 
<cfset esiSiteArray[12]['phonenumber'] = "520-903-3924">

<cfset esiSiteArray[13]['county_id'] = "24005">
<cfset esiSiteArray[13]['county'] = "Baltimore">  
<cfset esiSiteArray[13]['sitename']  = "Baltimore CASH Campaign"> 
<cfset esiSiteArray[13]['phonenumber'] = "410-234-2801">

<cfset esiSiteArray[14]['county_id'] = "48201">
<cfset esiSiteArray[14]['county'] = "Harris">  
<cfset esiSiteArray[14]['sitename']  = "Care for Elders"> 
<cfset esiSiteArray[14]['phonenumber'] = "713-558-6396"> 	
    
<!--- See if county in esiSiteArray matches submitted zipcode --->
<cfquery name="getcounty_esisite" datasource="#application.dbSrc#">
	select  z.zipcode, z.county_id, c.*
	from county c, zip z
	where c.county_id = z.county_id
		<cfif isdefined('session.esi_zip')>
			and z.zipcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.esi_zip#">
		<cfelse>
			and (1 = 0)
		</cfif>
</cfquery>

<cfloop from="1" to="#ArrayLen(esiSiteArray)#" index="i">
	<cfif esiSiteArray[i]['county_id'] EQ getcounty_esisite.county_id>
		<cfset esiSite = i>
	</cfif>	
</cfloop>

<cfscript>
	calculateESI(functionDebugging = false);
</cfscript>

<cffunction name="calculateESI" access="public" output="true" returntype="void">
	<cfargument name="functionDebugging" default="false" required="no">
	<!--- 
		Risk Level using scale 
		0-30 pts: In Crisis
		31-40: Vulnerable
		41-55: Stable
		56-69: Safe
		70-80: Thriving
	--->
	
	<!--- Set baseline --->
	<cfset SESSION.esiTotalPoints = 0>
    <cfset SESSION.esiPovertyLevel = 0>
    <cfset session.poverty_index = 0>
	
	<!--- Set default SESSION variables --->
	<!---<cfparam name='functionDebugging' default='true'>--->
    <cfparam name='SESSION.annualIncome' default='0'>
    <cfparam name='SESSION.homeEquity' default='0'>
    <cfparam name='SESSION.esi_agency' default=''>
    <cfparam name='SESSION.esi_basicneeds' default=''>
    <cfparam name='SESSION.esi_birth' default=''>
    <cfparam name='SESSION.esi_client' default=''>
    <cfparam name='SESSION.esi_counselor' default=''>
    <cfparam name='SESSION.esi_currentvaluebenefits' default='0'>
    <cfparam name='SESSION.esi_debtestimate' default='0'>
    <cfparam name='SESSION.esi_debt_scenario' default=''>
    <cfparam name='SESSION.esi_dependant_type' default=''>
    <cfparam name='SESSION.esi_dependants' default=''>
    <cfparam name='SESSION.esi_employmentsituation_list' default=''>
    <cfparam name='SESSION.esi_enrolledmedicare' default=''>
    <cfparam name='SESSION.esi_estimatedvalue' default='0'>
    <cfparam name='SESSION.esi_gender' default=''>
    <cfparam name='SESSION.esi_grossmonthlyincome' default='0'>
    <cfparam name='SESSION.esi_healthchronic' default=''>
    <cfparam name='SESSION.esi_healthdisability' default=''>
    <cfparam name='SESSION.esi_healthmonthly' default='0'>
    <cfparam name='SESSION.esi_helpbalancing' default=''>
    <cfparam name='SESSION.esi_homeinsurance' default=''>
    <cfparam name='SESSION.esi_housingsituation' default=''>
    <cfparam name='SESSION.esi_housingtype' default=''>
    <cfparam name='SESSION.esi_incomesupport' default=''>
    <cfparam name='SESSION.esi_marital' default=''>
    <cfparam name='SESSION.esi_medicaresupplement_employer' default=''>
    <cfparam name='SESSION.esi_medicaresupplement_medicareadvantage' default=''>
    <cfparam name='SESSION.esi_medicaresupplement_medigap' default=''>
    <cfparam name='SESSION.percentageFPL' default='0'>
    <cfparam name='SESSION.esi_ethnicity' default=''>
    <cfparam name='SESSION.esi_ratehealth' default=''>
    <cfparam name='SESSION.esi_receivepublicbenefits' default=''>
    <cfparam name='SESSION.esi_rent' default='0'>
    <cfparam name='SESSION.esi_seekingemployment_refresher' default=''>
    <cfparam name='SESSION.esi_seekingemployment_skillsassessment' default=''>
    <cfparam name='SESSION.esi_seekingemployment_usehelp' default=''>
    <cfparam name='SESSION.esi_totalassets' default='0'>
    <cfparam name='SESSION.esi_totaldebthouse' default='0'>
    <cfparam name='SESSION.esi_zip' default='11111'>
    <cfparam name='SESSION.esi_debtscenarios_creditlimit' default=''>
    <cfparam name='SESSION.esi_debtscenarios_minimum' default=''>
    <cfparam name='SESSION.esi_debtscenarios_creditors' default=''>
    <cfparam name='SESSION.esi_debtscenarios_bankruptcy' default=''>
    <cfparam name='SESSION.esi_outofpocket' default='0'>
    <cfparam name='SESSION.esi_healthmonthly' default='0'>
    <cfparam name='SESSION.esi_food' default='0'>
    <cfparam name='SESSION.esi_transportation' default='0'>
    <cfparam name='SESSION.esi_other_expenses' default='0'>
    <cfparam name='SESSION.esi_debtestimate' default='0'>
    <cfparam name='SESSION.ESI_BIRTH_Year' default='1901'>
    <cfparam name='SESSION.ESI_BIRTH_MONTH' default='1'>
    <cfparam name='session.fdstmp_receive' default=''>
    <cfparam name='session.housing' default=''>
    <!--- Default values for hh-expense fields --->
    <cfif SESSION.esi_outofpocket IS ''>
    	<cfset SESSION.esi_outofpocket = 0>
    </cfif>
    <cfif SESSION.esi_healthmonthly IS ''>
	    <cfset SESSION.esi_healthmonthly=0>
   	</cfif>
    <cfif SESSION.esi_food IS ''>
    	<cfset SESSION.esi_food=0>
  	</cfif>
    <cfif SESSION.esi_transportation IS ''>
    	<cfset SESSION.esi_transportation=0>
   	</cfif>
    <cfif SESSION.esi_other_expenses IS ''>
    	<cfset SESSION.esi_other_expenses=0>
    </cfif>
    <cfif SESSION.esi_debtestimate IS ''>
    	<cfset SESSION.esi_debtestimate=0>
   	</cfif>
    
    <!--- Init Bar Chart Inc Totals (Used in both Married and Single Calculations --->
    <cfparam name='SESSION.Wages_Inc' default='0'>        
    <cfparam name='SESSION.SS_Inc' default='0'>        
    <cfparam name='SESSION.PB_Inc' default='0'>        
    <cfparam name='SESSION.OtherNonWork_Inc' default='0'>
    
	<!--- Init Income Values for Single/Self --->
    <cfparam name='SESSION.s_income_pri_retire' default='0'>
    <cfparam name='SESSION.s_income_dividends' default='0'>
    <cfparam name='SESSION.s_income_ssi' default='0'>
    <cfparam name='SESSION.s_income_ss_disable' default='0'>
    <cfparam name='SESSION.s_income_ss_retire' default='0'>
    <cfparam name='SESSION.s_income_rr_ben' default='0'>
    <cfparam name='SESSION.s_income_vet_ben' default='0'>
    <cfparam name='SESSION.s_income_unemploy' default='0'>
    <cfparam name='SESSION.s_income_tanf' default='0'>
    <cfparam name='SESSION.s_income_cash_assist' default='0'>
    <cfparam name='SESSION.s_income_other_nw' default='0'>
    <cfparam name='SESSION.s_income_earned' default='0'>
    <cfparam name='SESSION.s_income_scsep' default='0'>
    <cfparam name='SESSION.s_income_unemployment' default='0'>
           
    
    <!--- Init Income Values for Married/Spouse --->
    <cfparam name='SESSION.sp_income_pri_retire' default='0'>
    <cfparam name='SESSION.sp_income_dividends' default='0'>
    <cfparam name='SESSION.sp_income_ssi' default='0'>
    <cfparam name='SESSION.sp_income_ss_disable' default='0'>
    <cfparam name='SESSION.sp_income_ss_retire' default='0'>
    <cfparam name='SESSION.sp_income_rr_ben' default='0'>
    <cfparam name='SESSION.sp_income_vet_ben' default='0'>
    <cfparam name='SESSION.sp_income_unemploy' default='0'>
    <cfparam name='SESSION.sp_income_tanf' default='0'>
    <cfparam name='SESSION.sp_income_cash_assist' default='0'>
    <cfparam name='SESSION.sp_income_other_nw' default='0'>
    <cfparam name='SESSION.sp_income_earned' default='0'>  
    <cfparam name='SESSION.sp_income_scsep' default='0'> 
    <cfparam name='SESSION.sp_income_unemployment' default='0'>     
    
    <!--- Init Income Values for Married/Joint --->
    <cfparam name='SESSION.s_sp_income_pri_retire_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_dividends_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_ssi_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_ss_disable_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_ss_retire_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_rr_ben_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_vet_ben_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_unemploy_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_tanf_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_cash_assist_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_other_nw_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_earned_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_scsep_simple' default='0'>
    <cfparam name='SESSION.s_sp_income_unemployment_simple' default='0'>
    
    <!--- Init Income Values for Household --->
    <cfparam name='SESSION.hh_income_pri_retire_simple' default='0'>
    <cfparam name='SESSION.hh_income_dividends_simple' default='0'>
    <cfparam name='SESSION.hh_income_ssi_simple' default='0'>
    <cfparam name='SESSION.hh_income_ss_disable_simple' default='0'>
    <cfparam name='SESSION.hh_income_ss_retire_simple' default='0'>
    <cfparam name='SESSION.hh_income_rr_ben_simple' default='0'>
    <cfparam name='SESSION.hh_income_vet_ben_simple' default='0'>
    <cfparam name='SESSION.hh_income_unemployment_simple' default='0'>
    <cfparam name='SESSION.hh_income_unemploy_simple' default='0'>
    <cfparam name='SESSION.hh_income_tanf_simple' default='0'>
    <cfparam name='SESSION.hh_income_cash_assist_simple' default='0'>
    <cfparam name='SESSION.hh_income_other_nw_simple' default='0'>
    <cfparam name='SESSION.hh_income_earned_simple' default='0'>
    <cfparam name='SESSION.hh_income_scsep_simple' default='0'>   
    <!--- Init Asset Values for Single --->
    <cfparam name='SESSION.s_asset_cash' default='0'>
    <cfparam name='SESSION.s_asset_auto1' default='0'>
    <cfparam name='SESSION.s_asset_auto2' default='0'>
    <cfparam name='SESSION.s_asset_home' default='0'>
    <cfparam name='SESSION.s_asset_retirement' default='0'>
    <cfparam name='SESSION.s_asset_stocks' default='0'>
    <cfparam name='SESSION.s_asset_life_cash' default='0'>
    <cfparam name='SESSION.s_asset_life_face' default='0'>
    <cfparam name='SESSION.s_asset_revocable' default='0'>
    <cfparam name='SESSION.s_asset_irrevocable' default='0'>
    <cfparam name='SESSION.s_asset_other_a' default='0'>
        
    <!--- Init Asset Values for Spouse --->
    <cfparam name='SESSION.sp_asset_cash' default='0'>
    <cfparam name='SESSION.sp_asset_auto1' default='0'>
    <cfparam name='SESSION.sp_asset_auto2' default='0'>
    <cfparam name='SESSION.sp_asset_home' default='0'>
    <cfparam name='SESSION.sp_asset_retirement' default='0'>
    <cfparam name='SESSION.sp_asset_stocks' default='0'>
    <cfparam name='SESSION.sp_asset_life_cash' default='0'>
    <cfparam name='SESSION.sp_asset_life_face' default='0'>
    <cfparam name='SESSION.sp_asset_revocable' default='0'>
    <cfparam name='SESSION.sp_asset_irrevocable' default='0'>
    <cfparam name='SESSION.sp_asset_other_a' default='0'>
    
    <!--- Init Asset Values for Joint --->
    <cfparam name='SESSION.s_sp_asset_cash_simple' default='0'>
    <cfparam name='SESSION.s_sp_asset_auto1_simple' default='0'>
    <cfparam name='SESSION.s_sp_asset_auto2_simple' default='0'>
    <cfparam name='SESSION.s_sp_asset_home_simple' default='0'>
    <cfparam name='SESSION.s_sp_asset_retirement_simple' default='0'>
    <cfparam name='SESSION.s_sp_asset_stocks_simple' default='0'>
    <cfparam name='SESSION.s_sp_asset_life_cash_simple' default='0'>
    <cfparam name='SESSION.s_sp_asset_life_face_simple' default='0'>
    <cfparam name='SESSION.s_sp_asset_revocable_simple' default='0'>
    <cfparam name='SESSION.s_sp_asset_irrevocable_simple' default='0'>
    <cfparam name='SESSION.s_sp_asset_other_a_simple' default='0'>
    
    <!--- Init Receive Values used by both Single and Married Income Calculations --->
    <cfparam name='SESSION.receive_msp_amount' default='0'>
    <cfparam name='SESSION.receive_lis_amount' default='0'>
    <cfparam name='SESSION.receive_snap_amount' default='0'>
    <cfparam name='SESSION.receive_liheap_amount' default='0'>
    <cfparam name='SESSION.receive_medicaid_amount' default='0'>
    <cfparam name='SESSION.receive_property_tax_amount' default='0'>
    <cfparam name='SESSION.receiveTotal' default='0'>
   
    
    <!--- Strip commas from entries :Bug 5999 - ESI - Get error when entering comma with large number --->
    <cfset SESSION.esi_debtestimate = REReplace(SESSION.esi_debtestimate, ",", "")>
    <cfset SESSION.esi_estimatedvalue = REReplace(SESSION.esi_estimatedvalue, ",", "")>
    <cfset SESSION.esi_grossmonthlyincome = REReplace(SESSION.esi_grossmonthlyincome, ",", "")>
    <cfset SESSION.esi_healthmonthly = REReplace(SESSION.esi_healthmonthly, ",", "")>
    <cfset SESSION.esi_outofpocket = REReplace(SESSION.esi_outofpocket, ",", "")>
    <cfset SESSION.esi_food = REReplace(SESSION.esi_food, ",", "")>
    <cfset SESSION.esi_transportation = REReplace(SESSION.esi_transportation, ",", "")>
    <cfset SESSION.esi_other_expenses = REReplace(SESSION.esi_other_expenses, ",", "")>
    <cfset SESSION.esi_rent = REReplace(SESSION.esi_rent, ",", "")>
    <cfset SESSION.esi_totalassets = REReplace(SESSION.esi_totalassets, ",", "")>
    <cfset SESSION.esi_totaldebthouse = REReplace(SESSION.esi_totaldebthouse, ",", "")>	
    <cfset SESSION.s_income_pri_retire = REReplace(SESSION.s_income_pri_retire, ",", "")>
    <cfset SESSION.s_income_dividends = REReplace(SESSION.s_income_dividends, ",", "")>
    <cfset SESSION.s_income_ssi = REReplace(SESSION.s_income_ssi, ",", "")>
    <cfset SESSION.s_income_ss_disable = REReplace(SESSION.s_income_ss_disable, ",", "")>
    <cfset SESSION.s_income_ss_retire = REReplace(SESSION.s_income_ss_retire, ",", "")>
    <cfset SESSION.s_income_rr_ben = REReplace(SESSION.s_income_rr_ben, ",", "")>
    <cfset SESSION.s_income_vet_ben = REReplace(SESSION.s_income_vet_ben, ",", "")>
    <cfset SESSION.s_income_unemploy = REReplace(SESSION.s_income_unemploy, ",", "")>
    <cfset SESSION.s_income_tanf = REReplace(SESSION.s_income_tanf, ",", "")>
    <cfset SESSION.s_income_cash_assist = REReplace(SESSION.s_income_cash_assist, ",", "")>
    <cfset SESSION.s_income_other_nw = REReplace(SESSION.s_income_other_nw, ",", "")>
    <cfset SESSION.s_income_earned = REReplace(SESSION.s_income_earned, ",", "")>
    <cfset SESSION.s_income_scsep = REReplace(SESSION.s_income_scsep, ",", "")>
    <cfset SESSION.s_income_unemployment = REReplace(SESSION.s_income_unemployment, ",", "")>        
    <cfset SESSION.sp_income_pri_retire = REReplace(SESSION.sp_income_pri_retire, ",", "")>
    <cfset SESSION.sp_income_dividends = REReplace(SESSION.sp_income_dividends, ",", "")>
    <cfset SESSION.sp_income_ssi = REReplace(SESSION.sp_income_ssi, ",", "")>
    <cfset SESSION.sp_income_ss_disable = REReplace(SESSION.sp_income_ss_disable, ",", "")>
    <cfset SESSION.sp_income_ss_retire = REReplace(SESSION.sp_income_ss_retire, ",", "")>
    <cfset SESSION.sp_income_rr_ben = REReplace(SESSION.sp_income_rr_ben, ",", "")>
    <cfset SESSION.sp_income_vet_ben = REReplace(SESSION.sp_income_vet_ben, ",", "")>
    <cfset SESSION.sp_income_unemploy = REReplace(SESSION.sp_income_unemploy, ",", "")>
    <cfset SESSION.sp_income_tanf = REReplace(SESSION.sp_income_tanf, ",", "")>
    <cfset SESSION.sp_income_cash_assist = REReplace(SESSION.sp_income_cash_assist, ",", "")>
    <cfset SESSION.sp_income_other_nw = REReplace(SESSION.sp_income_other_nw, ",", "")>
    <cfset SESSION.sp_income_earned = REReplace(SESSION.sp_income_earned, ",", "")>  
    <cfset SESSION.sp_income_scsep = REReplace(SESSION.sp_income_scsep, ",", "")>       
    <cfset SESSION.sp_income_unemployment = REReplace(SESSION.sp_income_unemployment, ",", "")>
	<cfset SESSION.s_sp_income_pri_retire_simple = REReplace(SESSION.s_sp_income_pri_retire_simple, ",", "")>
    <cfset SESSION.s_sp_income_dividends_simple = REReplace(SESSION.s_sp_income_dividends_simple, ",", "")>
    <cfset SESSION.s_sp_income_ssi_simple = REReplace(SESSION.s_sp_income_ssi_simple, ",", "")>
    <cfset SESSION.s_sp_income_ss_disable_simple = REReplace(SESSION.s_sp_income_ss_disable_simple, ",", "")>
    <cfset SESSION.s_sp_income_ss_retire_simple = REReplace(SESSION.s_sp_income_ss_retire_simple, ",", "")>
    <cfset SESSION.s_sp_income_rr_ben_simple = REReplace(SESSION.s_sp_income_rr_ben_simple, ",", "")>
    <cfset SESSION.s_sp_income_vet_ben_simple = REReplace(SESSION.s_sp_income_vet_ben_simple, ",", "")>
    <cfset SESSION.s_sp_income_unemploy_simple = REReplace(SESSION.s_sp_income_unemploy_simple, ",", "")>
    <cfset SESSION.s_sp_income_tanf_simple = REReplace(SESSION.s_sp_income_tanf_simple, ",", "")>
    <cfset SESSION.s_sp_income_cash_assist_simple = REReplace(SESSION.s_sp_income_cash_assist_simple, ",", "")>
    <cfset SESSION.s_sp_income_other_nw_simple = REReplace(SESSION.s_sp_income_other_nw_simple, ",", "")>
    <cfset SESSION.s_sp_income_earned_simple = REReplace(SESSION.s_sp_income_earned_simple, ",", "")>
    <cfset SESSION.s_sp_income_scsep_simple = REReplace(SESSION.s_sp_income_scsep_simple, ",", "")>
    <cfset SESSION.s_sp_income_unemployment_simple = REReplace(SESSION.s_sp_income_unemployment_simple, ",", "")>
    <cfset SESSION.s_asset_cash = REReplace(SESSION.s_asset_cash, ",", "")>
    <cfset SESSION.s_asset_auto1 = REReplace(SESSION.s_asset_auto1, ",", "")>
    <cfset SESSION.s_asset_auto2 = REReplace(SESSION.s_asset_auto2, ",", "")>
    <cfset SESSION.s_asset_home = REReplace(SESSION.s_asset_home, ",", "")>
    <cfset SESSION.s_asset_retirement = REReplace(SESSION.s_asset_retirement, ",", "")>
    <cfset SESSION.s_asset_stocks = REReplace(SESSION.s_asset_stocks, ",", "")>
    <cfset SESSION.s_asset_life_cash = REReplace(SESSION.s_asset_life_cash, ",", "")>
    <cfset SESSION.s_asset_life_face = REReplace(SESSION.s_asset_life_face, ",", "")>
    <cfset SESSION.s_asset_revocable = REReplace(SESSION.s_asset_revocable, ",", "")>
    <cfset SESSION.s_asset_irrevocable = REReplace(SESSION.s_asset_irrevocable, ",", "")>
    <cfset SESSION.s_asset_other_a = REReplace(SESSION.s_asset_other_a, ",", "")>        
    <cfset SESSION.sp_asset_cash = REReplace(SESSION.sp_asset_cash, ",", "")>
    <cfset SESSION.sp_asset_auto1 = REReplace(SESSION.sp_asset_auto1, ",", "")>
    <cfset SESSION.sp_asset_auto2 = REReplace(SESSION.sp_asset_auto2, ",", "")>
    <cfset SESSION.sp_asset_home = REReplace(SESSION.sp_asset_home, ",", "")>
    <cfset SESSION.sp_asset_retirement = REReplace(SESSION.sp_asset_retirement, ",", "")>
    <cfset SESSION.sp_asset_stocks = REReplace(SESSION.sp_asset_stocks, ",", "")>
    <cfset SESSION.sp_asset_life_cash = REReplace(SESSION.sp_asset_life_cash, ",", "")>
    <cfset SESSION.sp_asset_life_face = REReplace(SESSION.sp_asset_life_face, ",", "")>
    <cfset SESSION.sp_asset_revocable = REReplace(SESSION.sp_asset_revocable, ",", "")>
    <cfset SESSION.sp_asset_irrevocable = REReplace(SESSION.sp_asset_irrevocable, ",", "")>
    <cfset SESSION.sp_asset_other_a = REReplace(SESSION.sp_asset_other_a, ",", "")>
    <cfset SESSION.s_sp_asset_cash_simple = REReplace(SESSION.s_sp_asset_cash_simple, ",", "")>
    <cfset SESSION.s_sp_asset_auto1_simple = REReplace(SESSION.s_sp_asset_auto1_simple, ",", "")>
    <cfset SESSION.s_sp_asset_auto2_simple = REReplace(SESSION.s_sp_asset_auto2_simple, ",", "")>
    <cfset SESSION.s_sp_asset_home_simple = REReplace(SESSION.s_sp_asset_home_simple, ",", "")>
    <cfset SESSION.s_sp_asset_retirement_simple = REReplace(SESSION.s_sp_asset_retirement_simple, ",", "")>
    <cfset SESSION.s_sp_asset_stocks_simple = REReplace(SESSION.s_sp_asset_stocks_simple, ",", "")>
    <cfset SESSION.s_sp_asset_life_cash_simple = REReplace(SESSION.s_sp_asset_life_cash_simple, ",", "")>
    <cfset SESSION.s_sp_asset_life_face_simple = REReplace(SESSION.s_sp_asset_life_face_simple, ",", "")>
    <cfset SESSION.s_sp_asset_revocable_simple = REReplace(SESSION.s_sp_asset_revocable_simple, ",", "")>
    <cfset SESSION.s_sp_asset_irrevocable_simple = REReplace(SESSION.s_sp_asset_irrevocable_simple, ",", "")>
    <cfset SESSION.s_sp_asset_other_a_simple = REReplace(SESSION.s_sp_asset_other_a_simple, ",", "")>    
    <cfset SESSION.hh_income_pri_retire_simple = REReplace(SESSION.hh_income_pri_retire_simple, ",", "")>
    <cfset SESSION.hh_income_dividends_simple = REReplace(SESSION.hh_income_dividends_simple, ",", "")>
    <cfset SESSION.hh_income_ssi_simple = REReplace(SESSION.hh_income_ssi_simple, ",", "")>
    <cfset SESSION.hh_income_ss_disable_simple = REReplace(SESSION.hh_income_ss_disable_simple, ",", "")>
    <cfset SESSION.hh_income_ss_retire_simple = REReplace(SESSION.hh_income_ss_retire_simple, ",", "")>
    <cfset SESSION.hh_income_rr_ben_simple = REReplace(SESSION.hh_income_rr_ben_simple, ",", "")>
    <cfset SESSION.hh_income_vet_ben_simple = REReplace(SESSION.hh_income_vet_ben_simple, ",", "")>
    <cfset SESSION.hh_income_unemployment_simple = REReplace(SESSION.hh_income_unemployment_simple, ",", "")>
    <cfset SESSION.hh_income_unemploy_simple = REReplace(SESSION.hh_income_unemploy_simple, ",", "")>
    <cfset SESSION.hh_income_tanf_simple = REReplace(SESSION.hh_income_tanf_simple, ",", "")>
    <cfset SESSION.hh_income_cash_assist_simple = REReplace(SESSION.hh_income_cash_assist_simple, ",", "")>
    <cfset SESSION.hh_income_other_nw_simple = REReplace(SESSION.hh_income_other_nw_simple, ",", "")>
    <cfset SESSION.hh_income_earned_simple = REReplace(SESSION.hh_income_earned_simple, ",", "")>
    <cfset SESSION.hh_income_scsep_simple = REReplace(SESSION.hh_income_scsep_simple, ",", "")>

    <cfset SESSION.receive_msp_amount = REReplace(SESSION.receive_msp_amount, ",", "")>
    <cfset SESSION.receive_lis_amount = REReplace(SESSION.receive_lis_amount, ",", "")>
    <cfset SESSION.receive_snap_amount = REReplace(SESSION.receive_snap_amount, ",", "")>
    <cfset SESSION.receive_liheap_amount = REReplace(SESSION.receive_liheap_amount, ",", "")>
    <cfset SESSION.receive_medicaid_amount = REReplace(SESSION.receive_medicaid_amount, ",", "")>
    <cfset SESSION.receive_property_tax_amount = REReplace(SESSION.receive_property_tax_amount, ",", "")>
    <cfset SESSION.esi_outofpocket = REReplace(SESSION.esi_outofpocket, ",", "")>
    <cfset SESSION.esi_food = REReplace(SESSION.esi_food, ",", "")>
    <cfset SESSION.esi_healthmonthly = REReplace(SESSION.esi_healthmonthly, ",", "")>
    <cfset SESSION.esi_transportation = REReplace(SESSION.esi_transportation, ",", "")>
    <cfset SESSION.esi_other_expenses = REReplace(SESSION.esi_other_expenses, ",", "")>
    <cfset SESSION.esi_debtestimate = REReplace(SESSION.esi_debtestimate, ",", "")>
    
    <!--- Total Assets used in Recs --->
    <cfif SESSION.esi_marital EQ 'married'>
    	<cfset SESSION.esi_totalassets = SESSION.s_asset_cash + SESSION.s_asset_auto1 + SESSION.s_asset_auto2 + SESSION.s_asset_home + SESSION.s_asset_retirement + SESSION.s_asset_stocks + SESSION.s_asset_life_cash + SESSION.s_asset_life_face + SESSION.s_asset_revocable + SESSION.s_asset_irrevocable + SESSION.s_asset_other_a + SESSION.sp_asset_cash + SESSION.sp_asset_auto1 + SESSION.sp_asset_auto2 + SESSION.sp_asset_home + SESSION.sp_asset_retirement + SESSION.sp_asset_stocks + SESSION.sp_asset_life_cash + SESSION.sp_asset_life_face + SESSION.sp_asset_revocable + SESSION.sp_asset_irrevocable + SESSION.sp_asset_other_a + SESSION.s_sp_asset_cash_simple + SESSION.s_sp_asset_auto1_simple + SESSION.s_sp_asset_auto2_simple + SESSION.s_sp_asset_home_simple + SESSION.s_sp_asset_retirement_simple + SESSION.s_sp_asset_stocks_simple + SESSION.s_sp_asset_life_cash_simple + SESSION.s_sp_asset_life_face_simple + SESSION.s_sp_asset_revocable_simple + SESSION.s_sp_asset_irrevocable_simple + SESSION.s_sp_asset_other_a_simple>
    <cfelse>
    	<cfset SESSION.esi_totalassets = SESSION.s_asset_cash + SESSION.s_asset_auto1 + SESSION.s_asset_auto2 + SESSION.s_asset_home + SESSION.s_asset_retirement + SESSION.s_asset_stocks + SESSION.s_asset_life_cash + SESSION.s_asset_life_face + SESSION.s_asset_revocable + SESSION.s_asset_irrevocable + SESSION.s_asset_other_a>    
    </cfif>
	
	<!--- Total Value of Benefits to be used in ESI Percentage Calculation --->
    <cfset SESSION.esi_currentvaluebenefits = 0>
    
    <!--- Total based on input in Receive Question Only --->
	<cfset SESSION.receiveTotal = 0>
    <cfif SESSION.receive_msp_amount EQ ''><cfset SESSION.receive_msp_amount = 0></cfif>
    <cfif SESSION.receive_lis_amount EQ ''><cfset SESSION.receive_lis_amount = 0></cfif>
    <cfif SESSION.receive_snap_amount EQ ''><cfset SESSION.receive_snap_amount = 0></cfif>
    <cfif SESSION.receive_liheap_amount EQ ''><cfset SESSION.receive_liheap_amount = 0></cfif>
    <cfif SESSION.receive_medicaid_amount EQ ''><cfset SESSION.receive_medicaid_amount = 0></cfif>
    <cfif SESSION.receive_property_tax_amount EQ ''><cfset SESSION.receive_property_tax_amount = 0></cfif>
    <cfset SESSION.receiveTotal = SESSION.receive_msp_amount + SESSION.receive_lis_amount + SESSION.receive_snap_amount + SESSION.receive_liheap_amount + SESSION.receive_medicaid_amount + SESSION.receive_property_tax_amount>       
    <cfset SESSION.esi_currentvaluebenefits = SESSION.receiveTotal>    
    <cfset SESSION.esi_grossmonthlyincome = 0>
	
	<!--- Single esi_grossmonthly and esi_currentvaluebenefits income calculations (sum self and household income values) --->
    <cfif SESSION.esi_marital EQ 'single' OR SESSION.esi_marital EQ 'divorced' OR SESSION.esi_marital EQ 'widowed' OR SESSION.esi_marital EQ 'married_living_sep' OR SESSION.esi_marital EQ 'esi_living_with_partner'>
    	<cfset SESSION.esi_grossmonthlyincome = SESSION.s_income_pri_retire + SESSION.s_income_dividends + SESSION.s_income_ssi + SESSION.s_income_ss_disable + SESSION.s_income_ss_retire + SESSION.s_income_rr_ben + SESSION.s_income_vet_ben + SESSION.s_income_unemploy + SESSION.s_income_tanf + SESSION.s_income_cash_assist + SESSION.s_income_other_nw + SESSION.s_income_earned + SESSION.s_income_scsep  + SESSION.s_income_unemployment + SESSION.hh_income_pri_retire_simple + SESSION.hh_income_dividends_simple + SESSION.hh_income_ssi_simple + SESSION.hh_income_ss_disable_simple + SESSION.hh_income_ss_retire_simple + SESSION.hh_income_rr_ben_simple + SESSION.hh_income_vet_ben_simple + SESSION.hh_income_unemployment_simple + SESSION.hh_income_unemploy_simple + SESSION.hh_income_tanf_simple + SESSION.hh_income_cash_assist_simple + SESSION.hh_income_other_nw_simple + SESSION.hh_income_earned_simple + SESSION.hh_income_scsep_simple>
    		
    <!--- Married esi_grossmonthly and esi_currentvaluebenefits income calculations (sum self, spouse, joint and household income values)--->
    <cfelse>
    	<cfset SESSION.esi_grossmonthlyincome = SESSION.s_income_pri_retire + SESSION.s_income_dividends + SESSION.s_income_ssi + SESSION.s_income_ss_disable + SESSION.s_income_ss_retire + SESSION.s_income_rr_ben + SESSION.s_income_vet_ben + SESSION.s_income_unemploy + SESSION.s_income_tanf + SESSION.s_income_cash_assist + SESSION.s_income_other_nw + SESSION.s_income_earned + SESSION.s_income_scsep + SESSION.s_income_unemployment + SESSION.sp_income_pri_retire + SESSION.sp_income_dividends + SESSION.sp_income_ssi + SESSION.sp_income_ss_disable + SESSION.sp_income_ss_retire + SESSION.sp_income_rr_ben + SESSION.sp_income_vet_ben + SESSION.sp_income_unemploy + SESSION.sp_income_tanf + SESSION.sp_income_cash_assist + SESSION.sp_income_other_nw + SESSION.sp_income_earned + SESSION.sp_income_scsep + SESSION.sp_income_unemployment + SESSION.s_sp_income_pri_retire_simple + SESSION.s_sp_income_dividends_simple + SESSION.s_sp_income_ssi_simple + SESSION.s_sp_income_ss_disable_simple + SESSION.s_sp_income_ss_retire_simple + SESSION.s_sp_income_rr_ben_simple + SESSION.s_sp_income_vet_ben_simple + SESSION.s_sp_income_unemploy_simple + SESSION.s_sp_income_tanf_simple + SESSION.s_sp_income_cash_assist_simple + SESSION.s_sp_income_other_nw_simple + SESSION.s_sp_income_earned_simple  + SESSION.s_sp_income_scsep_simple + SESSION.s_sp_income_unemployment_simple + SESSION.hh_income_pri_retire_simple + SESSION.hh_income_dividends_simple + SESSION.hh_income_ssi_simple + SESSION.hh_income_ss_disable_simple + SESSION.hh_income_ss_retire_simple + 
SESSION.hh_income_rr_ben_simple + SESSION.hh_income_vet_ben_simple + SESSION.hh_income_unemployment_simple + SESSION.hh_income_unemploy_simple + SESSION.hh_income_tanf_simple + SESSION.hh_income_cash_assist_simple + SESSION.hh_income_other_nw_simple + SESSION.hh_income_earned_simple + SESSION.hh_income_scsep_simple >
    </cfif>
	<cfset SESSION.homeValue = 0>
   	<cfif SESSION.esi_totaldebthouse EQ ''>
		<cfset SESSION.esi_totaldebthouse = 0>
	</cfif>
   <cfif SESSION.esi_marital EQ 'married'>
		<cfif SESSION.s_asset_home EQ ''>
        	<cfset SESSION.s_asset_home = 0>
        </cfif>
        <cfif SESSION.sp_asset_home EQ ''>
        	<cfset SESSION.sp_asset_home = 0>
        </cfif>
        <cfif SESSION.s_sp_asset_home_simple EQ ''>
        	<cfset SESSION.s_sp_asset_home_simple = 0>
        </cfif>
        <cfset SESSION.homeValue = SESSION.s_asset_home + SESSION.sp_asset_home + SESSION.s_sp_asset_home_simple>
    <cfelse>
		<cfif SESSION.s_asset_home  EQ ''>
        	<cfset SESSION.s_asset_home = 0>
        </cfif>    
        <cfset SESSION.homeValue = SESSION.s_asset_home>
    </cfif>
		
	<!--- Annual Income --->
	<cfset SESSION.annualIncome = (SESSION.esi_grossmonthlyincome * 12)>
	
	<!--- Get estimated home equity --->
	<cfset SESSION.homeEquity = SESSION.homeValue - SESSION.esi_totaldebthouse>
	
	<cfif SESSION.homeEquity LT 0>
		<cfset SESSION.homeEquity = 0>
	</cfif>
	
	<!---  Calculate age: Aged 80 or more = 0pt;Aged 79 or less = 3pt 	
			SESSION.esi_birth --->
	<cfset session.esi_birth = SESSION.esi_birth_month & "/" & SESSION.esi_birth_year>
	<cfset birthDate = ParseDateTime(#SESSION.esi_birth#) />
	<cfset dateNow = ParseDateTime(Now()) />
	<cfset diffYears = DateDiff("yyyy", birthDate, dateNow) />
	<cfset SESSION.diffYears = diffYears>
	
	<cfif diffYears LTE 79>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>
		<cfif functionDebugging>
			<p>Less than 80 years of age: 3 points</p>
		</cfif>
	</cfif>
	
	<!--- Marital Status: A/C/D/E = 0pt, B/F= 3pt 
			SESSION.esi_marital --->
	<cfif SESSION.esi_marital EQ 'married'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>
		<cfif functionDebugging>
			<p>Married: 3 points</p>
		</cfif>
	</cfif>
	<cfif SESSION.esi_marital EQ 'esi_living_with_partner'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>
		<cfif functionDebugging>
			<p>Living with partner: 3 points</p>
		</cfif>
	</cfif>
	
	<!--- Gender: A=0pt,B=3pt
			SESSION.esi_gender --->
	<cfif SESSION.esi_gender EQ 'male'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>
		<cfif functionDebugging>
			<p>Male: 3 points</p>
		</cfif>
	</cfif>
	
	<!---  A/B/D/E = 0pt, C(caucasian) = 3pt
			SESSION.esi_race--->
	<cfif SESSION.esi_ethnicity EQ 'white'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>
		<cfif functionDebugging>
			<p>Caucasian: 3 points</p>
		</cfif>
	</cfif>
	
	<!--- On a scale from 1-5 how challenging is it for you to provide for your basic needs on a monthly basis? 
					1 = not a challenge; [5pt]
					2=can be a challenge; [4pt]
					3=is a challenge every month, [3pt]
					4=every month I need assistance; [2pt]
					5 = cannot meet obligations even with assistance [1pt]
			SESSION.esi_basicneeds --->
	<cfswitch expression='#SESSION.esi_basicneeds#'>
		<cfcase value='esi_notachallenge'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>
			<cfif functionDebugging>
				<p>Basic needs not a challenge: 5 points</p>
			</cfif>
		</cfcase>
		<cfcase value='esi_canbeachallenge'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 4>
			<cfif functionDebugging>
				<p>Basic needs can be a challenge: 4 points</p>
			</cfif>
		</cfcase>
		<cfcase value='esi_isachallenge'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>
			<cfif functionDebugging>
				<p>Basic needs is a challenge every month: 3 points</p>
			</cfif>
		</cfcase>
		<cfcase value='esi_ineedassistance'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>
			<cfif functionDebugging>
				<p>Basic needs every month I need assistance: 2 points</p>
			</cfif>
		</cfcase>
		<cfcase value='esi_cannotmeetobligations'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 1>
			<cfif functionDebugging>
				<p>Basic needs cannot meet obligations even with assistance: 1 point</p>
			</cfif>
		</cfcase>
	</cfswitch>
	
	<!--- How many people in your household does your income support? 
				If married w/dependent add 3pt, otherwise = 0pt
				SESSION.esi_marital;SESSION.esi_dependants--->
	<cfif SESSION.esi_marital EQ 'married' AND SESSION.esi_dependants EQ 'y'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>
		<cfif functionDebugging>
			<p>Married with dependants: 2 points</p>
		</cfif>
	</cfif>
	
	<!---  If employed add 3pt
			SESSION.esi_employmentsituation_list--->
	<cfif SESSION.esi_employmentsituation_list EQ 'esi_employmentsituation_employed'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>
		<cfif functionDebugging>
			<p>Employed: 3 points</p>
		</cfif>
	</cfif>
	
	<!--- #7019 Debt Payments
	For Debt Points, use Debt Payments answerfield(SESSION.esi_debtestimate) in new Expenses question(esi_hh_expenses). 
	The calculation is if debt amount = 0 then 5 pt, if > 0 but <= 50% of total income from income grid then 3 pt, 
	> 50% = 0 pt. --->
    <cfset halfGrossMonthly = 0>
    <cfset halfGrossMonthly = SESSION.esi_grossmonthlyincome * .5>
    <cfif halfGrossMonthly LT 0>
			<cfset halfGrossMonthly = 0>
		</cfif>
	<cfif SESSION.esi_debtestimate EQ 0>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>
        <cfif functionDebugging>
			<p>No non-housing debt : 5 points</p>
		</cfif>
    <cfelseif SESSION.esi_debtestimate LTE halfGrossMonthly>
    	<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>
        <cfif functionDebugging>
			<p>Non-housing debt <= 50 % of total income : 3 points</p>
		</cfif>
    </cfif>
		    
	<!--- For Debt Scenario Points, If no answer options are selected = 3 pt, if 1 
	or more selected = 0 pt [esi_debtscenarios_question] --->
    <cfparam name='SESSION.esi_debtscenarios_creditlimit' default=''>
    <cfparam name='SESSION.esi_debtscenarios_minimum' default=''>
    <cfparam name='SESSION.esi_debtscenarios_creditors' default=''>
    <cfparam name='SESSION.esi_debtscenarios_bankruptcy' default=''>
	<cfif SESSION.esi_debtscenarios_creditlimit EQ '' AND SESSION.esi_debtscenarios_minimum EQ '' AND SESSION.esi_debtscenarios_creditors EQ '' AND SESSION.esi_debtscenarios_bankruptcy EQ ''>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>	
		<cfif functionDebugging>
			<p>No Debt Scenarios Selected: 3 points</p>
		</cfif>	
	</cfif>
	
	<!--- In what type of housing do you live? Please check one:
					a) own home [5pt]
			SESSION.esi_housingtype=esi_housingtype_own --->
	<cfif SESSION.esi_housingtype EQ 'esi_housingtype_own'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>
		<cfif functionDebugging>
			<p>Own home: 5 points</p>
		</cfif>
	</cfif>
	
	<!--- If  you are a homeowner, please share the estimated value of the home: $______ and the total 
    debt on the house: $_______ (mortgage/other home loans). Do you have homeowner's insurance? Yes/No
Also, please check all of the items below that describe your situation? 
(select all that apply; if you are not a homeowner, skip to the next question)
				a)	My mortgage is paid off, but I have trouble with the utility, 
				property tax, and/or homeowner's insurance payments. 
					[3 pt with mention of pre-lender RM opportunities in the report, if the client is 62+]
				b)	My mortgage exceeds the current value of my home. 
					[2 pt with mention of the underwater opportunities HUD just released and recommend NeighborWorks map]
				c)	I have some equity, but just can't keep up with my monthly bills. 
					[2 pt with mention of RM and NeighborWorks in report, if the client is 62+]
				d)	I have a reverse mortgage and am behind on my utility, property tax, 
				and/or homeowner's insurance payments.
					[1pt]
				e)	Facing foreclosure. 
					[0 pt & refer to legal services]
				f)	Not applicable 
					[5pt] --->
	<cfif SESSION.esi_housingsituation EQ 'esi_housing_mortgagepaid'>

		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>	<br />
		<cfif functionDebugging>
			<p>Mortgage paid off: 3 points</p>
		</cfif>
	</cfif>	
	<cfif SESSION.esi_housingsituation EQ 'esi_housing_underwater'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>	
		<cfif functionDebugging>
			<p>Mortgage underwater: 2 points</p>
		</cfif>
	</cfif>	
	<cfif SESSION.esi_housingsituation EQ 'esi_housing_someequity'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>	
		<cfif functionDebugging>
			<p>Have some equity: 2 points</p>
		</cfif>
	</cfif>	
	<cfif SESSION.esi_housingsituation EQ 'esi_housing_reversemortgage'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 1>	
		<cfif functionDebugging>
			<p>Reverse mortgage: 1 points</p>
		</cfif>
	</cfif>	
	<cfif SESSION.esi_housingsituation EQ 'esi_housing_notapplicable'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>	
		<cfif functionDebugging>
			<p>Housing situation Not Applicable: 5 points</p>
		</cfif>
	</cfif>			
	
	<!--- Please check all of the items below that describe your situation.
				a)	I am able to pay my rent, but am having difficulty paying my other expenses. [3pt]
				b)	I am behind on my rent. [2pt]
				c)	I am behind on my rent and facing eviction. [0pt]
				d)	Not applicable [5pt]
					esi_rent_behind
					esi_rent_difficultypaying
					esi_rent_eviction
					esi_rent_noneoftheabove
				 --->
	<cfif SESSION.esi_rent EQ 'esi_rent_difficultypaying'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>
		<cfif functionDebugging>
			<p>Difficulty paying rent: 3 points</p>
		</cfif>	
	</cfif>
	<cfif SESSION.esi_rent EQ 'esi_rent_behind'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>	
		<cfif functionDebugging>
			<p>Behind on rent: 2 points</p>
		</cfif>
	</cfif>
	<cfif SESSION.esi_rent EQ 'esi_rent_noneoftheabove'>
		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>	
		<cfif functionDebugging>
			<p>Rent situation Not Applicable: 5 points</p>
		</cfif>
	</cfif>
	
	<!--- For Housing Points, use Housing answerfield (esi_outofpocket) in new Expenses(esi_hh_expenses) 
	question.  The calculation is if housing amount >= 1/3 of total income from income grid then 2 pt;
	otherwise = 5 pt. --->
    	<cfset oneThirdGrossMonthly = 0>
		<cfset oneThirdGrossMonthly = (SESSION.esi_grossmonthlyincome * .33)>
		<cfif oneThirdGrossMonthly LT 0>
			<cfset oneThirdGrossMonthly = 0>
		</cfif>
		<cfif SESSION.esi_outofpocket GTE oneThirdGrossMonthly>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>	
			<cfif functionDebugging>
				<p>Monthly Housing Expense GTE 1/3 of monthly income: 2 points</p>
			</cfif>
		<cfelse>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>	
			<cfif functionDebugging>
				<p>Monthly Housing Expense LT 1/3 of monthly income: 5 points</p>
			</cfif>
		</cfif>
		
		<!--- How would you rate your health? 
				a)	Excellent – No diagnosed chronic illnesses, active and mobile. [5pt]
				b)	Very Good – No diagnosed chronic illnesses, minor difficulty with mobility and activity [4pt]
				c)	Good – Diagnosed chronic condition, but manageable condition [3pt]
				d)	Fair - More than one diagnosed chronic illness, difficult to manage [2pt]
				e)	Poor - More than one diagnosed chronic illness, constant impediment to daily life. [0pt]
				SESSION.esi_ratehealth
		 --->

		<cfswitch expression='#SESSION.esi_ratehealth#'>
			<cfcase value='esi_ratehealth_excellent'>
				<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>
				<cfif functionDebugging>
					<p>Excellent Health: 5 points</p>
				</cfif>
			</cfcase>
			<cfcase value='esi_ratehealth_verygood'>
				<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 4>
				<cfif functionDebugging>
					<p>Very Good Health: 4 points</p>
				</cfif>
			</cfcase>
			<cfcase value='esi_ratehealth_good'>
				<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>
				<cfif functionDebugging>
					<p>Good Health: 3 points</p>
				</cfif>
			</cfcase>
			<cfcase value='esi_ratehealth_fair'>
				<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>
				<cfif functionDebugging>
					<p>Fair Health: 2 points</p>
				</cfif>
			</cfcase>
		</cfswitch>
		
        <!--- For Health Points, use Health answerfield(esi_healthmonthly)in new Expenses 
		question(esi_hh_expenses). The calculation is if health amount > 1/5 of total 
		income from income grid = 2 pt; otherwise = 5 pt. --->
		<cfset oneFifthGrossMonthly = 0>
		<cfset oneFifthGrossMonthly = (SESSION.esi_grossmonthlyincome * .2)>
        <cfif oneFifthGrossMonthly LT 0>
			<cfset oneFifthGrossMonthly = 0>
		</cfif>
		<cfif SESSION.esi_healthmonthly GT oneFifthGrossMonthly>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>	
			<cfif functionDebugging>
				<p>Monthly health expenses GT 1/5 monthly income: 2 points</p>
			</cfif>
		<cfelse>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>	
			<cfif functionDebugging>
				<p>Monthly health expenses LTE 1/5 monthly income: 5 points</p>
			</cfif>
		</cfif>
		
		<!--- > Do you have a medically documented disability that substantially reduces or
		eliminates one's ability to support or care for oneself or one's family?
		[esi_healthdisability_question]. Yes = 2 pt, No = 5 pt --->
		<cfif SESSION.esi_healthdisability EQ 'y'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>	
				<cfif functionDebugging>
					<p>Has Medically Documented Disability: 2 points</p>
				</cfif>
		<cfelseif SESSION.esi_healthdisability EQ 'n'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>	
				<cfif functionDebugging>
					<p>NO Medically Documented Disability: 5 points</p>
				</cfif>
		</cfif>
		<!---BEGIN Calculate ESI Percentage --->
			<!--- use the zipcode to detect county --->
						
			<cfquery name="getcounty" datasource="#application.dbSrc#">
				select  z.zipcode, z.county_id, c.*
                from county c, zip z
                where c.county_id = z.county_id
                    <cfif isdefined('session.esi_zip')>
                        and z.zipcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.esi_zip#">
                    <cfelse>
                        and (1 = 0)
                    </cfif>
            </cfquery>
				
			<!--- Get the ESI Numbers based on County ID --->
	
			<!---GET ESI index for location--->
            <cfparam name="modifiedCountyName" type="string" default="">
			<cfset modifiedCountyName = "#Trim(getcounty.county_name)# County">
			<cfquery name="getESICount" datasource="#application.dbSrc#">
				select * 
				from economicsecurityindex_v2 
				where county_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#modifiedCountyName#"> and state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcounty.state_id#">
			</cfquery>
			<!--- Use State Elder Index Values if more than one record returned --->
			<cfif getESICount.recordcount GT 1>
            	<cfquery name="getFullStateName" datasource="#application.dbSrc#">
                	Select state_name from state where state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcounty.state_id#">
                </cfquery>
                <cfparam name="trimmedFullStateName" type="string" default="">
				<cfset trimmedFullStateName = "#Trim('getFullStateName.state_name')#">
				<cfquery name="getESI" datasource="#application.dbSrc#" >
					select * 
					from economicsecurityindex_v2 
					where state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcounty.state_id#"> and county_name = '#trimmedFullStateName#'
				</cfquery>
           	<!--- Use National Elder Index Values if more 0 records returned --->
			<cfelseif getESICount.recordcount EQ 0>
            	<cfquery name="getESI" datasource="#application.dbSrc#" >
					select * 
					from economicsecurityindex_v2 
					where economicsecurityindex_id = 3196
				</cfquery>
            <!--- Use State and County Specific Elder Index Values if one record returned --->
            <cfelse>
            	<cfquery name="getESI" datasource="#application.dbSrc#">
					select * 
					from economicsecurityindex_v2 
					where county_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#modifiedCountyName#"> and state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcounty.state_id#">
				</cfquery>
            </cfif>
					
			<!---Get marital status for ESI - married or single --->
			
			<cfif session.esi_marital eq 'married'>
				<cfset married = true>
			<cfelse>
				<cfset married = false >
			</cfif>
					
			<!---Get Rental status for ESI  either Rent or Own Home --->
			
			<cfif session.esi_housingtype eq 'esi_housingtype_own'>
				<cfset own = true>
			<cfelse>
				<cfset own = false>
			</cfif>
					
			<!---Get Rental status for ESI - Rent or Own Home --->
			
			<cfif session.esi_totaldebthouse GT 0>
				<cfset debt = true>
			<cfelse>
				<cfset debt = false>
			</cfif>
			
			<cfset esiMonthlyIncomeByLocation = 1>
					
			<!---Choose ESI value from table --->
			<cfif SESSION.esi_incomesupport EQ 1><!--- if 1 person in household --->
            	<cfif own eq 'true' >
					<cfif debt eq 'true' >
                        <cfset esiMonthlyIncomeByLocation =  getESI.singlewithmortgage/12>
                    <cfelse>
                        <cfset esiMonthlyIncomeByLocation = getESI.singlewithoutmortgage/12>
                    </cfif>
                <cfelse>
                    <cfset esiMonthlyIncomeByLocation = getESI.singlerenter/12>
                </cfif>
            <cfelseif SESSION.esi_incomesupport EQ 2><!--- if 2 persons in household --->
            	<cfif own eq 'true' >
					<cfif debt eq 'true' >
                        <cfset esiMonthlyIncomeByLocation = getESI.jointwithmortgage/12 >
                    <cfelse>
                        <cfset esiMonthlyIncomeByLocation = getESI.jointwithoutmortgage/12 >
                    </cfif>
                <cfelse>
                    <cfset esiMonthlyIncomeByLocation = getESI.jointrenter/12 >
                </cfif>
            </cfif>
             
			<!---Adjust Average by Health Status ( add costs for poor health or decrease costs for excellent health  --->
			<cfif session.esi_ratehealth eq 'esi_ratehealth_excellent'>
				<cfif NOT isDefined('getESI.increasegoodhealth')>
					<cfset getESI.increasegoodhealth = 0>
				</cfif>
				<cfset esiMonthlyIncomeByLocation = esiMonthlyIncomeByLocation - (getESI.increasegoodhealth/12)>
                <cfif functionDebugging>
                    <p>Elder Income Decreased due to Excellent Health Rating</p>
                </cfif>
			<cfelseif session.esi_ratehealth eq 'esi_ratehealth_poor'>
				<cfif NOT isDefined('getESI.DESCREASEBADHEALTH')>
					<cfset getESI.DESCREASEBADHEALTH = 0>
				</cfif>
            	<cfset esiMonthlyIncomeByLocation = esiMonthlyIncomeByLocation + (getESI.DESCREASEBADHEALTH/12)>
                <cfif functionDebugging>
                    <p>Elder Income Increased due to Poor Health Rating</p>
                </cfif>
            <cfelse>
            	<cfif functionDebugging>
                    <p>Elder Income NOT Adjusted: Neither Excellent or Poor Health Statuses were selected.</p>
                </cfif>
			</cfif>
            	<!--- FPL Percentage --->
				<cfset numFamMembers = session.esi_incomesupport>
                <cfif numFamMembers  eq 0 or numFamMembers eq ''>
                    <cfset numFamMembers = 1>
                    <cfelseif numFamMembers gt 8>
                    <cfset numFamMembers   = 8>
                </cfif>
                
                <cfquery datasource="#application.dbSrc#" name="getPoverty">
                    SELECT mem#numFamMembers# AS povLevel
                    FROM tbl_inc_new 
                    WHERE proc_id = 484
                </cfquery>
        		<cfset SESSION.esiPovertyLevel = #getPoverty.povLevel#>
                <cfset session.poverty_index = session.esi_grossmonthlyincome/SESSION.esiPovertyLevel>
                <cfset SESSION.percentageFPL = session.esi_grossmonthlyincome/SESSION.esiPovertyLevel * 100>	
                <cfif functionDebugging>
                	<p>For Demographics Reporting --> poverty_index : #session.esi_grossmonthlyincome#/#SESSION.esiPovertyLevel# --> #SESSION.poverty_index#</p>
                    <p>FPL Percentage : #SESSION.percentageFPL#</p>
                </cfif>

				<cfif SESSION.esi_incomesupport EQ 1 or SESSION.esi_incomesupport EQ 2> <!--- if 1 or 2 persons in household --->
					<!---GET ESI Percentage  ...income plus benefits over location based costs index--->
					<cfset session.esiPercentage = ((#session.esi_grossmonthlyincome# + #session.receiveTotal# )/ #esiMonthlyIncomeByLocation#)  * 100 >
                    <cfif functionDebugging>
                        <p>
                            ESI Number in Household: #SESSION.esi_incomesupport#<BR />
                            ESI Gross Monthly Income : #session.esi_grossmonthlyincome#<BR />
                            ESI Total VOB : #session.receiveTotal#<BR />
                            ESI Monthly Income by Location  : #esiMonthlyIncomeByLocation#<BR /><BR />
                            ESI % Calculation --> (#session.esi_grossmonthlyincome# + #session.receiveTotal#) / #esiMonthlyIncomeByLocation# * 100<BR />
                            ESI Percentage : #session.esiPercentage#
                        </p>
                    </cfif>
              	<cfelse> <!--- 3 or more persons in household (esi_incomesupport) --->
                	<!---GET ESI Percentage  ...income plus benefits over 200% FPL (related to number in the household from the income table)--->
					<cfset session.esiPercentage = ((#session.esi_grossmonthlyincome# + #session.receiveTotal# )/ (#SESSION.esiPovertyLevel# * 2)) * 100>
                    <cfif functionDebugging>
                        <p>
                            ESI Number in Household: #SESSION.esi_incomesupport#<BR />
                            ESI Gross Monthly Income : #session.esi_grossmonthlyincome#<BR />
                            ESI Total VOB : #session.receiveTotal#<BR />
                            ESI Monthly Income by Location  : #esiMonthlyIncomeByLocation#<BR /><BR />
                            ESI % Calculation --> (#session.esi_grossmonthlyincome# + #session.receiveTotal#) / (#SESSION.esiPovertyLevel# * 2)<BR />
                            ESI Percentage : #session.esiPercentage#
                        </p>
                    </cfif>
               	</cfif>				
							
				<!--- What is the gross total monthly income for you and, 
   		  			if applicable, your spouse/partner from all sources before taxes and other deductions?
   					To get the % of Economic Security based on zip code, 
					the variables needed are monthly income, #of dependents, housing, and health.
					IF INCOME IS BELOW 200% OF FPL, RECOMMEND BCU IN REPORT 
					& PUSH KEY DATA POINTS TO PRE-POPULATE.
					The % of ES derived from Economic Security Standard Index 
					should be accounted as 100%+ = 5pt; 76-99% = 3pt
					61-75% = 2pt; 0-60% = 0pt  
					SESSION.percentageFPL --->
					
				<cfif session.esiPercentage GTE 100>
					<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>
					<cfif functionDebugging>
						<p>esiPercentage GTE 100 (#session.esiPercentage#%): 5 points</p>
					</cfif>
				<cfelseif session.esiPercentage LTE 99 AND session.esiPercentage GTE 76>
					<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>
					<cfif functionDebugging>
						<p>esiPercentage LTE 99 AND GTE 76 (#session.esiPercentage#%): 3 points</p>
					</cfif>
				<cfelseif session.esiPercentage LTE 75 AND session.esiPercentage GTE 61>
					<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>
					<cfif functionDebugging>
						<p>esiPercentage LTE 75 AND GTE 61 (#session.esiPercentage#%): 2 points</p>
					</cfif>
				</cfif>
				<!--- Show ESI Points Debug --->
                <cfif functionDebugging>
					<p>Total Points : #SESSION.esiTotalPoints# points</p>
				</cfif>
				
 		<!--- END Calculate ESI Percentage --->
</cffunction>


<!-- Start Loading a New Screening for the Shadow Screening Results -->
<cfparam name="session.reloadpage" default="false">
<cfif not session.reloadpage >
<cfset session.reloadpage = true>
<cf_handleScreeningAnswerfield action="get" code="st" element="val" var="preserveStateID">
<cfset preserveSessionID = session.screening.id>
<cfif preserveStateID eq '' and isdefined('session.st')>
	<cfset preserveStateID = session.st > 
</cfif>

<cf_handleScreening action="end" screening_id="#preserveSessionID#">
<cfset session.prev_id = preserveSessionID>
<cfset session.state_id = preserveStateID>
<cfset theList = ''>
<cfset session.subset_id = 67>
<!--- START action:  log the start of a screening and initialize structure --->
<!---Removed Load Screening --->	
<cf_screeningInsert prev_screening_id="#session.prev_id#" source_id="#session.source_id#" org_id="#session.org_id#" partner_id="#session.partner_id#" subset_id="#session.subset_id#" language_id="#session.language_id#" access_id="#session.access_id#" client_id="#session.client_id#" user_id="#session.user_id#" preset_state_id="#preserveStateID#" test_flag="#session.test_id#" var="outvar">			
<cfif functionDebugging>
	<cfoutput>Debug Text: screeningInsert prev_screening_id="#session.prev_id#" source_id="#session.source_id#" org_id="#session.org_id#" partner_id="#session.partner_id#" subset_id="#session.subset_id#" language_id="#session.language_id#" access_id="#session.access_id#" client_id="#session.client_id#" user_id="#session.user_id#" preset_state_id="#preserveStateID#" test_flag="#session.test_id#" var="outvar </cfoutput>
</cfif>
<cfset session.screening.id = outvar>
<cfset session.screening_id = outvar>

<!--- START session info loading --->
	<cfquery name="subsetInfo" datasource="#application.dbSrc#">
		SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text,
			all_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag
		FROM xsubset
		WHERE subset_id=67
	</cfquery>
	<cfif subsetInfo.RecordCount>
		<cfset session.subsetName = subsetInfo.subset_name>
		<cfset session.subsetLongName = subsetInfo.subset_longname>
		<cfset session.subsetDescription = subsetInfo.subset_description>
		<cfset session.subsetText = subsetInfo.subset_text>
		<cfset session.subsetAllFlag = subsetInfo.all_flag>
		<cfset session.subsetGridFlag = subsetInfo.grid_flag>
		<cfset session.subsetSCHIPFlag = subsetInfo.schip_flag>
		<cfset session.subsetDrugFlag = subsetInfo.drug_flag>
		<cfset session.subsetOptionalFlag = subsetInfo.optional_flag>
		<cfset session.subsetRecFlag = subsetInfo.rec_flag>
		<cfset session.subsetEFormFlag = subsetInfo.eform_flag>
	<cfelse>
		<cfset session.subsetName = ''>
		<cfset session.subsetLongName = ''>
		<cfset session.subsetDescription = ''>
		<cfset session.subsetText = ''>
		<cfset session.subsetAllFlag = 0>
		<cfset session.subsetGridFlag = 0>
		<cfset session.subsetSCHIPFlag = 0>
		<cfset session.subsetDrugFlag = 0>
		<cfset session.subsetOptionalFlag = 0>
		<cfset session.subsetRecFlag = 0>
		<cfset session.subsetEFormFlag = 0>
	</cfif>

		<cfset session.subsetRecFlag = 0>
<!--- END session info loading --->

<!--- DEBUGGING OUTPUT
<cfoutput>
subset_id = #session.subset_id#<br>
partner_id = #session.partner_id#<br>
subsetRecFlag = #session.subsetRecFlag#<br><br>
</cfoutput>
--->


<!--- 05/21/2003 BS - Make sure there's a session.selectedDrugs variable --->
<cfif not IsDefined("session.selectedDrugs")>
	<cfset session.selectedDrugs = ''>
</cfif>

<CFSET session.END_TIME = CreateODBCDATETIME(now())>
<cfset session.prg_list = "">
<cfset session.buff_list = "">

<cfinclude template="mapesishadow.cfm">
<cfif session.marital_stat eq 'single' and session.hh_depend lt 1 >
	<cfset session.hh_depend = 1>
<cfelseif session.marital_stat eq 'married' and session.hh_depend lt 2 >
	<cfset session.hh_depend = 2>
</cfif>
<cfparam name="session.scsep_inc" default="0"> 
<cfif not  isnumeric(session.sp_income_scsep)>
   <cfset session.sp_income_scsep = 0>
</cfif>
<cfif not  isnumeric(session.s_income_scsep)>
   <cfset session.sp_income_scsep = 0>
</cfif>
<cfif not  isnumeric(session.s_sp_income_scsep_simple)>
   <cfset session.s_sp_income_scsep_simple = 0>
</cfif>
<cfif not isnumeric(session.hh_income_scsep_simple)>
   <cfset session.hh_income_scsep_simple = 0>
</cfif>

<!-- use all 4 fields for all cases -->
<cfif (1 eq 1) or session.marital_stat EQ 'married' >
	<cfset session.scsep_inc = session.s_income_scsep + session.sp_income_scsep + session.s_sp_income_scsep_simple + session.hh_income_scsep_simple>
<cfelse>
	<cfset session.s_sp_income_scsep_simple = 0>
	<cfset session.sp_income_scsep = 0>
	<cfset session.scsep_inc = session.s_income_scsep  + session.hh_income_scsep_simple>
</cfif>
<cfif 1 eq 0><cfoutput>session.marital_stat #session.marital_stat#  hh_depend  #session.hh_depend#  hh_members  #session.no_hh_members#</cfoutput></cfif>
<cfset varList = "o-client,s-client_other,g-gender,s-zip,o-citizen,o-marital_stat,n-dob_month,n-dob_year,n-dob,y-disabled,y-dep_care,o-housing,n-hh_disabled,n-no_hh_members,n-over_60,n-hh_depend,
y-property_tax,y-utility_2,n-rent,n-mortgage,n-med_costs,n-dep_child,c-snap_#session.state_id#_receive,c-liheap_receive,c-med_receive,c-medicare_receive,c-ssi_receive,c-receive_msp,c-receive_partd,c-receive_lis,n-poverty_index,s-st,s-county,s-county_id,i-s_income_pri_retire,i-sp_income_pri_retire,i-s_sp_income_pri_retire_simple,i-hh_income_pri_retire_simple,i-s_income_dividends,i-sp_income_dividends,i-s_sp_income_dividends_simple,i-hh_income_dividends_simple,i-s_income_ssi,i-sp_income_ssi,i-s_sp_income_ssi_simple,i-hh_income_ssi_simple,i-s_income_ss_disable,i-sp_income_ss_disable,i-s_sp_income_ss_disable_simple,i-hh_income_ss_disable_simple,i-s_income_ss_retire,i-sp_income_ss_retire,i-s_sp_income_ss_retire_simple,i-hh_income_ss_retire_simple,i-s_income_rr_ben,i-sp_income_rr_ben,i-s_sp_income_rr_ben_simple,i-hh_income_rr_ben_simple,i-s_income_vet_ben,i-sp_income_vet_ben,i-s_sp_income_vet_ben_simple,i-hh_income_vet_ben_simple,i-s_income_unemployment,i-sp_income_unemployment,i-s_sp_income_unemployment_simple,i-hh_income_unemployment_simple,i-s_income_unemploy,i-sp_income_unemploy,i-s_sp_income_unemploy_simple,i-hh_income_unemploy_simple,i-s_income_tanf,i-sp_income_tanf,i-s_sp_income_tanf_simple,i-hh_income_tanf_simple,i-s_income_cash_assist,i-sp_income_cash_assist,i-s_sp_income_cash_assist_simple,i-hh_income_cash_assist_simple,i-s_income_other_nw,i-sp_income_other_nw,i-s_sp_income_other_nw_simple,i-hh_income_other_nw_simple,i-s_income_earned,i-sp_income_earned,i-s_sp_income_earned_simple,i-hh_income_earned_simple,i-s_income_scsep,i-sp_income_scsep,i-s_sp_income_scsep_simple,i-hh_income_scsep_simple,a-s_asset_cash,a-sp_asset_cash,a-s_sp_asset_cash_simple,a-hh_asset_cash_simple,a-s_asset_auto1,a-sp_asset_auto1,a-s_sp_asset_auto1_simple,a-hh_asset_auto1_simple,a-s_asset_auto2,a-sp_asset_auto2,a-s_sp_asset_auto2_simple,a-hh_asset_auto2_simple,a-s_asset_home,a-sp_asset_home,a-s_sp_asset_home_simple,a-hh_asset_home_simple,a-s_asset_retirement,a-sp_asset_retirement,a-s_sp_asset_retirement_simple,a-hh_asset_retirement_simple,a-s_asset_stocks,a-sp_asset_stocks,a-s_sp_asset_stocks_simple,a-hh_asset_stocks_simple,a-s_asset_life_cash,a-sp_asset_life_cash,a-s_sp_asset_life_cash_simple,a-hh_asset_life_cash_simple,a-s_asset_life_face,a-sp_asset_life_face,a-s_sp_asset_life_face_simple,a-hh_asset_life_face_simple,a-s_asset_revocable,a-sp_asset_revocable,a-s_sp_asset_revocable_simple,a-hh_asset_revocable_simple,a-s_asset_irrevocable,a-sp_asset_irrevocable,a-s_sp_asset_irrevocable_simple,a-hh_asset_irrevocable_simple,a-s_asset_other_a,a-sp_asset_other_a,a-s_sp_asset_other_a_simple,a-hh_asset_other_a_simple,i-s_sp_income_total_complete,i-s_income_total_complete,i-sp_income_total_complete,i-hh_income_total_complete,i-s_sp_income_total_unearned,i-s_income_total_unearned,i-sp_income_total_unearned,i-hh_income_total_unearned,o-race,i-scsep_inc,n-scsep_inc">

<cfset session.aflist = varList >
<cfset session.poverty_index = session.povertyindex> 

<cfoutput>fdstmp_receive: #session.fdstmp_receive#</cfoutput>
<!--- map af var codes --->
<cfset Evaluate( "snap_#session.state_id#_receive = session.fdstmp_receive" ) />
<cfset Evaluate( "session.snap_#session.state_id#_receive = session.fdstmp_receive" ) />

<cfset tmpclient = session.client>
<cfset tmphousing =  session.housing >
<cfset tmpmarital_stat =  session.marital_stat >

<cfset session.citizen  = "13-citizen">
<cfset session.race  = session.esi_ethnicity>

<cfif session.race eq 'american_indian_native_alaskans'>
	<cfset session.race = '1381-american_indian_native_alaskans'>
<cfelseif  session.race eq 'asian'>
	<cfset session.race = '1382-asian'>
<cfelseif  session.race eq 'african_american'>
	<cfset session.race = '1380-african_american'>
<cfelseif  session.race eq 'hispanic'>
	<cfset session.race = '1384-hispanic'>
<cfelseif  session.race eq 'pacific_islander'>
	<cfset session.race = '1383-pacific_islander'>
<cfelseif session.race eq 'white'>
	<cfset  session.race = '1379-white'>
<cfelseif  session.race eq 'other_race'>
	<cfset session.race = '1385-other_race'>
</cfif>


<cfif session.client eq 'Self'>
	<cfset session.client = '1353-self'>
<cfelseif  session.client eq 'Spouse'>
	<cfset session.client = '2345-spouse'>
<cfelseif  session.client eq 'Mother'>
	<cfset session.client = '1354-mother'>
<cfelseif  session.client eq 'Father'>
	<cfset session.client = '1355-father'>
<cfelseif  session.client eq 'Sister'>
	<cfset session.client = '1356-sister'>
<cfelseif  session.client eq 'Brother'>
	<cfset session.client = '1357-brother'>
<cfelseif  session.client eq 'Client'>
	<cfset session.client = '1358-client'>
<cfelseif  session.client eq 'Test'>
	<cfset session.client = '1359-test'>
<cfelseif  session.client eq 'Other'>
	<cfset session.client = '1360-other'>
</cfif>


<cfif session.marital_stat eq 'Single'>
	<cfset session.marital_stat  = '6-single'>
<cfelseif  session.marital_stat  eq 'Married'>
	<cfset session.marital_stat  = '4-married'>
<cfelseif  session.marital_stat  eq 'married_living_sep'>
	<cfset session.marital_stat  = '1361-married_living_sep'>
<cfelseif  session.marital_stat  eq 'Divorced'>
	<cfset session.marital_stat  = '5-divorced'>
<cfelseif  session.marital_stat  eq 'Widowed'>
	<cfset session.marital_stat  = '7-widowed'>
</cfif>




<cfif session.housing eq 'Own Home'>
	<cfset session.housing = '8-own_home'>
<cfelseif  session.housing eq 'Rental'>
	<cfset session.housing = '9-rent_dwelling'>
<cfelseif  session.housing eq 'Own Mobile Home'>
	<cfset session.housing = '10-own_mobile_home'>
<cfelseif  session.housing eq 'Boarding Home'>
	<cfset session.housing = '11-boarding_home'>
<cfelseif  session.housing eq 'Live with Others'>
	<cfset session.housing = '12-live_with_others'>
<cfelseif  session.housing eq 'Nursing Facility'>
	<cfset session.housing = '121-nursing_facility'>
<cfelseif  session.housing eq 'Assisted Living'>
	<cfset session.housing = '122-assisted_living'>
<cfelseif  session.housing eq 'Subsidized Housing'>
	<cfset session.housing = '754-subsidized_housing'>
<cfelseif  session.housing eq 'Homeless Shelter'>
	<cfset session.housing = '1074-homeless_shelter'>
</cfif>





<cf_logScreeningInput  structname="session" >
<cf_handleScreening action="end" screening_id="#session.screening.id#">
<cfset session.citizen  = "citizen">
<cfset session.client = tmpclient>
<cfset session.marital_stat = tmpmarital_stat>
<cfset session.housing = tmphousing >


<!--- This code is to strip leading zeroes off the household number, so we don't look up a column with a name like "mem02" --->
<cfif isDefined("session.no_hh_members")>
	<cfset session.no_hh_members = val(session.no_hh_members)>
</cfif>
<cfif isDefined("session.hh_disabled")>
	<cfset session.hh_disabled = val(session.hh_disabled)>
</cfif>
<cfif isDefined("session.over_60")>
	<cfset session.over_60 = val(session.over_60)>
</cfif>
<cfset session.ssi_receive = 'N'>
<cfif (session.s_income_ssi + session.sp_income_ssi + session.s_sp_income_ssi) gt 0 >
	<cfset session.ssi_receive = 'Y'>
</cfif>
<!---cfdump var="#session#"--->
<!---  The "normal" pass --->
<cf_tagTestRules ynDoBuffer="FALSE" debugOutput="false">



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
<cf_populateTableFromView table="subset_program_base" subset_id="#session.subset_id#">
<cf_populateTableFromView table="subset_program_sum" subset_id="#session.subset_id#">
<cfif IsDefined('session.subset_id') And session.subset_id gt 0>
	<cfquery name="helperPrg" datasource="#application.dbSrc#">
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
DUPLICATE SET OF ENTRIES IF THE USER BACKS UP AND RESUBMITS HIS ANSWERS TO THIS PROCESS 
PAGE. --->
<cfif session.subsetRecFlag eq 1>
	<cfset unseenVal = 1>
<cfelse>
	<cfset unseenVal = 0>
</cfif>

<!--- get the program component  --->
<cfinvoke
    component="programHandler" 
    method="getProgramPool"
    returnVariable="queryPrograms">
<cfset session.listProgram_id = "">
<cfloop list="#session.prg_list#" index="prg_id">
<cfset prg_id = replacenocase(prg_id, "'","","all")>
<!--- set the function that we want dynamically then call it (it's a two step process) --->
<cfinvoke  legacy_prg_id = "#prg_id#"
    component="programHandler" 
    method="getProgramIDByLegacyID"
    returnVariable="program_id">
	<cfset unseenAdjustedVal = unseenVal>
	<cfif unseenVal eq 0>
		<cfif Mid(prg_id, Find('-', prg_id) + 1, Find('-', prg_id, Find('-', prg_id) + 1) - Find('-', prg_id) - 1) eq '333'>
			<cfset unseenAdjustedVal = 1>
		</cfif>
	</cfif>
	<cfif listcontains(session.listProgram_id,program_id) eq 0>
	<cfquery name="insertprograms" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #program_id#, #unseenAdjustedVal#, 0, 0)
	</CFQUERY>
	<cfset session.listProgram_id = listappend(session.listProgram_id,program_id)>
	</cfif>
</cfloop>
<cfif session.wantchips eq 'Y'>
<!-- 103-309-2191-FD-FD -->
	<CFQUERY NAME="insertchips" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, 930, #unseenVal#, 0, 0)
	</CFQUERY>
</cfif>
<cfif session.genericdrugs eq 'Y'>
<!-- XXX-311-2387-FD-FD -->
	<CFQUERY NAME="insertgeneric" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, 1045, #unseenVal#, 0, 0)
	</CFQUERY>
</cfif>



<!--- Bug 6399 --->
            <cfquery name="logESIPoints" datasource="#application.dbSrc#">
        		INSERT INTO screening_answerfield
            	(screening_id, answerfield_id, responsetype, response, pagenum, derived_flag, submit_datetime)
        		VALUES
            	(#session.screening.id#, 6663, 1, #SESSION.esiTotalPoints#, 1, 1, #CreateODBCDateTime(Now())#)
    		</cfquery>	
            <cfquery name="logesiPercentage" datasource="#application.dbSrc#">
                INSERT INTO screening_answerfield
                (screening_id, answerfield_id, responsetype, response, pagenum, derived_flag, submit_datetime)
                VALUES
                (#session.screening.id#, 6664, 1, #session.esiPercentage#, 1, 1, #CreateODBCDateTime(Now())#)
    		</cfquery>
            <cfquery name="updateESIPovertyLevel" datasource="#application.dbSrc#">
        		UPDATE screening_answerfield
				SET response = #SESSION.poverty_index#
				WHERE screening_id = #session.screening_id# and answerfield_id = 5262
          	</cfquery>
<!---cfoutput>
TEMPORARY LINK FOR DEBUGGING PURPOSES:<br>
click below to continue on and submit application<br>
<a href="#goto#">View Report</a><br><br>

subset_id = #session.subset_id#<br>
partner_id = #session.partner_id#<br>
subsetRecFlag = #session.subsetRecFlag#<br>
PrgList = #session.prg_list#<br />
</cfoutput--->
</cfif>
<!---cfoutput> <h2>Screening ID: #session.screening.id#   #session.esi_gender# #session.gender# #session.race#</h2></cfoutput--->
