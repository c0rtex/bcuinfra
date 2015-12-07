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
<cfparam name="eligibleForDebtManagement" default="false">
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
    <cfparam name='SESSION.esi_meals_balanced' default=''>
    <cfparam name='SESSION.esi_meals_inadequate' default=''>
    <cfparam name='SESSION.esi_meals_nofood' default=''>
    <cfparam name='SESSION.esi_meals_relyonassistance' default=''>
    <cfparam name='SESSION.esi_meals_withassistance' default=''>
    <cfparam name='SESSION.esi_medicaresupplement_employer' default=''>
    <cfparam name='SESSION.esi_medicaresupplement_medicareadvantage' default=''>
    <cfparam name='SESSION.esi_medicaresupplement_medigap' default=''>
    <cfparam name='SESSION.esi_mobility' default=''>
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
    <cfparam name='SESSION.esi_interest_pleasure' default=''>
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
    	<cfset SESSION.esi_grossmonthlyincome = SESSION.s_income_pri_retire + SESSION.s_income_dividends + SESSION.s_income_ssi + SESSION.s_income_ss_disable + SESSION.s_income_ss_retire + SESSION.s_income_rr_ben + SESSION.s_income_vet_ben + SESSION.s_income_unemploy + SESSION.s_income_tanf + SESSION.s_income_cash_assist + SESSION.s_income_other_nw + SESSION.s_income_earned + SESSION.s_income_unemployment + SESSION.hh_income_pri_retire_simple + SESSION.hh_income_dividends_simple + SESSION.hh_income_ssi_simple + SESSION.hh_income_ss_disable_simple + SESSION.hh_income_ss_retire_simple + 
SESSION.hh_income_rr_ben_simple + SESSION.hh_income_vet_ben_simple + SESSION.hh_income_unemployment_simple + SESSION.hh_income_unemploy_simple + SESSION.hh_income_tanf_simple + SESSION.hh_income_cash_assist_simple + SESSION.hh_income_other_nw_simple + SESSION.hh_income_earned_simple>
    		
    <!--- Married esi_grossmonthly and esi_currentvaluebenefits income calculations (sum self, spouse, joint and household income values)--->
    <cfelse>
    	<cfset SESSION.esi_grossmonthlyincome = SESSION.s_income_pri_retire + SESSION.s_income_dividends + SESSION.s_income_ssi + SESSION.s_income_ss_disable + SESSION.s_income_ss_retire + SESSION.s_income_rr_ben + SESSION.s_income_vet_ben + SESSION.s_income_unemploy + SESSION.s_income_tanf + SESSION.s_income_cash_assist + SESSION.s_income_other_nw + SESSION.s_income_earned + SESSION.s_income_unemployment + SESSION.sp_income_pri_retire + SESSION.sp_income_dividends + SESSION.sp_income_ssi + SESSION.sp_income_ss_disable + SESSION.sp_income_ss_retire + SESSION.sp_income_rr_ben + SESSION.sp_income_vet_ben + SESSION.sp_income_unemploy + SESSION.sp_income_tanf + SESSION.sp_income_cash_assist + SESSION.sp_income_other_nw + SESSION.sp_income_earned + SESSION.sp_income_unemployment + SESSION.s_sp_income_pri_retire_simple + SESSION.s_sp_income_dividends_simple + SESSION.s_sp_income_ssi_simple + SESSION.s_sp_income_ss_disable_simple + SESSION.s_sp_income_ss_retire_simple + SESSION.s_sp_income_rr_ben_simple + SESSION.s_sp_income_vet_ben_simple + SESSION.s_sp_income_unemploy_simple + SESSION.s_sp_income_tanf_simple + SESSION.s_sp_income_cash_assist_simple + SESSION.s_sp_income_other_nw_simple + SESSION.s_sp_income_earned_simple + SESSION.s_sp_income_unemployment_simple + SESSION.hh_income_pri_retire_simple + SESSION.hh_income_dividends_simple + SESSION.hh_income_ssi_simple + SESSION.hh_income_ss_disable_simple + SESSION.hh_income_ss_retire_simple + 
SESSION.hh_income_rr_ben_simple + SESSION.hh_income_vet_ben_simple + SESSION.hh_income_unemployment_simple + SESSION.hh_income_unemploy_simple + SESSION.hh_income_tanf_simple + SESSION.hh_income_cash_assist_simple + SESSION.hh_income_other_nw_simple + SESSION.hh_income_earned_simple>
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

		<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>	
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
		
		<cfif SESSION.esi_mobility EQ 'esi_mobility_owncar'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>
			<cfif functionDebugging>
				<p>Owns car: 5 points</p>
			</cfif>	
		</cfif>
		<cfif SESSION.esi_mobility EQ 'esi_mobility_useavailable'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 4>
			<cfif functionDebugging>
				<p>Uses available transportation: 4 points</p>
			</cfif>	
		</cfif>
		<cfif SESSION.esi_mobility EQ 'esi_mobility_limited'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>	
			<cfif functionDebugging>
				<p>Limited transportation depending on subsidies: 3 points</p>
			</cfif>	
		</cfif>
		<cfif SESSION.esi_mobility EQ 'esi_mobility_unreliable'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>
			<cfif functionDebugging>
				<p>Transportation unreliable: 2 points</p>
			</cfif>	
		</cfif>
		
		<!--- Please select which best describes your access to meals.
				a)	Well balanced meals with or without assistance [5pt] 
				b)	Daily well-balanced meals with social and/or community assistance [4pt]
				c)	Relies on community/social assistance for basic nutritional needs. [3pt]
				d)	Food inadequate for nutritional needs. [2pt]
				e)	No food and at risk for malnutrition.  [0pt]
				SESSION.esi_meals
			    esi_meals,esi_meals_withassistance,esi_meals_relyonassistance,esi_meals_inadequate,esi_meals_nofood		
		 --->
		<cfif SESSION.esi_meals EQ 'esi_meals'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>	
			<cfif functionDebugging>
				<p>Well balanced meals: 5 points</p>
			</cfif>
		</cfif>
		<cfif SESSION.esi_meals EQ 'esi_meals_withassistance'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 4>	
			<cfif functionDebugging>
				<p>Daily well-balanced meals with social and/or community assistance: 4 points</p>
			</cfif>
		</cfif>
		<cfif SESSION.esi_meals EQ 'esi_meals_relyonassistance'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 3>
			<cfif functionDebugging>
				<p>Rely on community/social assistance for basic nutritional needs: 3 points</p>
			</cfif>	
		</cfif>
		<cfif SESSION.esi_meals EQ 'esi_meals_inadequate'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>
			<cfif functionDebugging>
				<p>Food inadequate for nutritional needs: 2 points</p>
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
		
        <!--- For new esi_interest_pleasure question, answer option a = 5 pts, b = 2 pts, c or d= 0 pts --->
        <cfif SESSION.esi_interest_pleasure EQ 'esi_pleasure_notatall'>
			<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 5>	
			<cfif functionDebugging>
				<p>Pleasure Doing Activities Daily : 5 points</p>
			</cfif>
        <cfelseif SESSION.esi_interest_pleasure EQ 'esi_pleasure_several'>
        	<cfset SESSION.esiTotalPoints = SESSION.esiTotalPoints + 2>	
			<cfif functionDebugging>
				<p>Enjoy Activities Some Days : 2 points</p>
			</cfif>
		</cfif>
        
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


<link href="css/esi.css" rel="stylesheet" type="text/css">
<!-- [if IE 6]><link rel="stylesheet" type="text/css" href="EconomicCheckUp_files/ie6.css" /><![endif] -->
<!-- [if IE 7]><link rel="stylesheet" type="text/css" href="EconomicCheckUp_files/ie7.css" /><![endif] -->
<!--[if gte IE 8]>
<style>
	BODY{margin-top:0px;}
    #header {
        height: 140 px;
        overflow: visible;
        position: relative;
     	width: 934px;   
     }
    #main-nav, .menu-main-menu-container {
    background: none repeat scroll 0 0 #F1601B;
    height: 30px;
    margin: 0 auto;
    width: 100%;

    }
    #main-nav LI {
        background: none repeat scroll 934 0 #F1601B;
        border-left: medium none;
        border-right: 1px solid #FFFFFF;
        float: left;
        font-size: 20px;
        height: 30px;
        line-height: 30px;
        margin-top: 0;
        text-align: center;
        text-shadow: none;
        width: 155px;
	}
    
    #main-nav li#esi-home {
    	border-left: 1px solid #CCCCCC !important;
    	width: 120px;
        margin-right: 1px;
	}
	#main-nav li#esi-findfood {
    	width: 180px;
        margin-right: 1px;
	}
	#main-nav li#esi-findhelp {
    	width: 180px;
        margin-right: 1px;
	}
	#main-nav li#esi-taxrelief {
    width: 160px;
    margin-right: 1px;
	}
	#main-nav li#esi-about {
    border-right: medium none; !important;
    width: 134px;
    margin-left:1px;
	}
	#main-nav li#esi-benefits {
    width: 155px;
    margin-right: 1px;
	}

    #header A.block
    {
    text-align: left;
    width: 360px;
    position: absolute;
    top: 30px;
    left: 10px;
    height: 140px;
    }
           
    IMG#expenses
{
	float: left;
    position: relative;
	left: 61px;
    top: 0px;
}

#page {
    background: url("images/bg/border_shadow.png") repeat-y scroll 934px 0 #FFFFFF;
    border-left: 1px solid #CCCCCC;
    border-top: 1px solid #CCCCCC;
    clear: both;
	top: 0;
    position: relative;
    width: 934px;
    left: 1px;
}
#page {
    border-top: 0 none;
    padding-bottom: 0;
}

#footer {
	margin: 0 auto;
    display: block;
    overflow: visible;
}
</style>
<![endif]-->

<!--- Start building page --->
<cf_buildHTML cellpadding="12" cellspacing="2" allowBack="true">

<div class="report_container" id="report_container">
  <!---div class="content" id="content"--->
  		<div style="padding-top:5px;">
  		<table border="0" width="100%">
        	<tr>
            	<td align="left" width="50px;">
        			<cf_sessionPassVars href="esi_questions.cfm?ht=#session.esi_housingtype#" prev_id="#session.screening_id#" style="font-size:16px;">Back</cf_sessionPassVars>
    			</td>
                <td align="center"><h1>EconomicCheckUp Report</h1></td>
            	<td align="right"  width="315px;">
					<cfset goto="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
					<cfoutput>
                        <!---span><input type="button" id="view_results" value="VIEW BENEFITSCHECKUP QUICK SCREEN RESULTS" style="float:right; margin-bottom:0px; margin-right:0px; margin-top:12px;" onclick="javascript:window.open('frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#', '_self'); return false;"></span--->
                    </cfoutput>
                    <cfif URL.printfriendly>
                        <CFSET CurrentURL = 'http://' & CGI.SERVER_NAME & CGI.SCRIPT_NAME & '?' & CGI.QUERY_STRING>
                        <cfoutput><CFSET CurrentURL = "#Replace(CurrentURL, '&printfriendly=TRUE', '')#"></cfoutput>
                        <span style="float:right;"><a style="font-size:16px;" id="printfriendly_link" href="<cfoutput>#currentURL#</cfoutput>">Back to EconomicCheckUp Web Report</a></span>
                    <cfelse>
                        <CFSET CurrentURL = 'http://' & CGI.SERVER_NAME & CGI.SCRIPT_NAME & '?' & CGI.QUERY_STRING &'&printfriendly=TRUE'>
                        <span style="float:right;"><a style="font-size:16px;" id="printfriendly_link" href="<cfoutput>#currentURL#</cfoutput>">Printer Friendly EconomicCheckUp Report</a></span>
                    </cfif>
				</td>
        	</tr>
        </table>
        </div>
		<div id="current_status">
			<!---<img class="float_left" src="esi_demo/images/subheader_5min_current_status.jpg" width="756" height="62" alt="Current Status">--->
			
			<!--- 
			0-30 pts: In Crisis
				0 - 9   show meter_01.jpg
				10 - 19 show meter_02.jpg
				20 - 30 show meter_03.jpg
			31-40: Vulnerable
				31 - 33 show meter_04.jpg
				34 - 36 show meter_05.jpg
				37 - 40 show meter_06.jpg
			41-69: Safe / Stable	
				41 - 49 show meter_07.jpg
				50 - 59 show meter_08.jpg
				60 - 69 show meter_09.jpg
			70-80: Thriving
				70 - 72 show meter_10.jpg
				73 - 76 show meter_11.jpg
				77 - 80 show meter_12.jpg				--->
			
		<cfoutput>
        	<cfset chartExpenses = SESSION.esi_outofpocket + SESSION.esi_food + SESSION.esi_healthmonthly + SESSION.esi_transportation + SESSION.esi_other_expenses + SESSION.esi_debtestimate>
        	<!--- CURRENT STATUS DIVIDER --->
            <div align="left"><h2 style="clear:both; float:left; background-color:##C6E5FD; font-weight:700; line-height:26px; padding:5px 0px 5px 5px; color:##1f419b; width:100%;">YOUR ECONOMIC SECURITY STATUS</h2></div>
        	<!--- Meter - Thriving --->
			<cfif (SESSION.esiTotalPoints LTE 80 AND SESSION.esiTotalPoints GTE 70) AND (session.esiPercentage GT 100)>
            	<div id="stairway_image">
                	<cfif chartExpenses LT SESSION.esi_grossmonthlyincome>
						<cfif SESSION.esiTotalPoints GTE 70 AND SESSION.esiTotalPoints LTE 72>
                            <img src="img/partners/economicsecurity/meter_10.jpg" width="500" height="275" alt="Economic Security Meter - Very Secure" title="Economic Security Meter - Very Secure">
                        <cfelseif SESSION.esiTotalPoints GTE 73 AND SESSION.esiTotalPoints LTE 76>
                            <img src="img/partners/economicsecurity/meter_11.jpg" width="500" height="275" alt="Economic Security Meter - Very Secure" title="Economic Security Meter - Very Secure">
                        <cfelseif SESSION.esiTotalPoints GTE 77 AND SESSION.esiTotalPoints LTE 80>
                            <img src="img/partners/economicsecurity/meter_12.jpg" width="500" height="275" alt="Economic Security Meter - Very Secure" title="Economic Security Meter - Very Secure">
                        </cfif>
                        <div class="clearfloat"></div>
                        <div style="margin-top:25px;">
                            <p align="left">According to the EconomicCheckUp, you are in good financial health.  You plan for the future and are able to handle unplanned expenses. Since your financial situation can change, it is important to know that both government and private programs may be able to help you.</p>
                        </div>
                  	<cfelse>
                    	<img src="img/partners/economicsecurity/meter_05.jpg" width="500" height="275" alt="Economic Security Meter - Somewhat Secure" title="Economic Security Meter - Somewhat Secure">
                        <div class="clearfloat"></div>
                    	<div style="margin-top:25px;">
							<p align="left">
								<cfif session.esiPercentage LT 100>
                                    According to the EconomicCheckUp, you are struggling to meet all your current needs. It is important to know that both government and private programs may be able to help you.
                               	<cfelse>
									According to the EconomicCheckUp, it may be hard for you to meet unplanned expenses now and in the future. It is important to know that both
government and private programs may be able to help.                             
                                </cfif>
                            </p>
                  		</div>
                  	</cfif>
				</div>
			</cfif>
            <!--- Meter - Safe/Stable --->
			<cfif (SESSION.esiTotalPoints LTE 69 AND SESSION.esiTotalPoints GTE 41) AND (session.esiPercentage GT 100)>
				<div id="stairway_image">
					<cfif chartExpenses LT SESSION.esi_grossmonthlyincome>
						<cfif SESSION.esiTotalPoints GTE 41 AND SESSION.esiTotalPoints LTE 49>
                            <img src="img/partners/economicsecurity/meter_07.jpg" width="500" height="275" alt="Economic Security Meter - Secure" title="Economic Security Meter - Secure">
                        <cfelseif SESSION.esiTotalPoints GTE 50 AND SESSION.esiTotalPoints LTE 59>
                            <img src="img/partners/economicsecurity/meter_08.jpg" width="500" height="275" alt="Economic Security Meter - Secure" title="Economic Security Meter - Secure">
                        <cfelseif SESSION.esiTotalPoints GTE 60 AND SESSION.esiTotalPoints LTE 69>
                            <img src="img/partners/economicsecurity/meter_09.jpg" width="500" height="275" alt="Economic Security Meter - Secure" title="Economic Security Meter - Secure">
                        </cfif>
                        <div class="clearfloat"></div>
                        <div style="margin-top:25px;">
                            <p align="left">According to the EconomicCheckUp, you are not facing serious money problems. You are doing well and have enough money to meet your current needs.  But, it may be hard for you to meet unplanned expenses now and in the future.  It is important to know that both government and private programs may be able to help.</p>
                        </div>
                   	<cfelse>
                    	<img src="img/partners/economicsecurity/meter_05.jpg" width="500" height="275" alt="Economic Security Meter - Somewhat Secure" title="Economic Security Meter - Somewhat Secure">
                        <div class="clearfloat"></div>
                    	<div style="margin-top:25px;">
							<p align="left">
								<cfif session.esiPercentage LT 100>
                                    According to the EconomicCheckUp, you are struggling to meet all your current needs. It is important to know that both government and private programs may be able to help you.
                               	<cfelse>
									According to the EconomicCheckUp, it may be hard for you to meet unplanned expenses now and in the future. It is important to know that both
government and private programs may be able to help.                             
                                </cfif>
                            </p>
                  	</cfif>
				</div>
			</cfif>
            <!--- Meter - Vulnerable --->
			<cfif (SESSION.esiTotalPoints LTE 40 AND SESSION.esiTotalPoints GTE 31) OR (session.esiPercentage LTE 100 AND SESSION.esiTotalPoints GTE 41)>
				<div id="stairway_image">
					<cfif SESSION.esiTotalPoints GTE 31 AND SESSION.esiTotalPoints LTE 33>
						<img src="img/partners/economicsecurity/meter_04.jpg" width="500" height="275" alt="Economic Security Meter - Somewhat Secure" title="Economic Security Meter - Somewhat Secure">
                  	<cfelseif (SESSION.esiTotalPoints GTE 34 AND SESSION.esiTotalPoints LTE 36) OR (session.esiPercentage LTE 100 AND SESSION.esiTotalPoints GTE 41)>
						<img src="img/partners/economicsecurity/meter_05.jpg" width="500" height="275" alt="Economic Security Meter - Somewhat Secure" title="Economic Security Meter - Somewhat Secure">
                  	<cfelseif SESSION.esiTotalPoints GTE 37 AND SESSION.esiTotalPoints LTE 40>
						<img src="img/partners/economicsecurity/meter_06.jpg" width="500" height="275" alt="Economic Security Meter - Somewhat Secure" title="Economic Security Meter - Somewhat Secure">
                  	</cfif>
                    <div class="clearfloat"></div>
                    <div style="margin-top:25px;">
                    	<p align="left">According to the EconomicCheckUp, you are struggling to meet all your current needs. It is important to know that both government and private programs may be able to help you.</p>
                  	</div>
				</div>
			</cfif>
            <!--- Meter - In Crisis --->
			<cfif (SESSION.esiTotalPoints LTE 30 AND SESSION.esiTotalPoints GTE 0)>
				<div id="stairway_image">
					<cfif SESSION.esiTotalPoints GTE 0 AND SESSION.esiTotalPoints LTE 9>
						<img src="img/partners/economicsecurity/meter_01.jpg" width="500" height="275" alt="Economic Security Meter - Not Secure" title="Economic Security Meter - Not Secure">
                  	<cfelseif SESSION.esiTotalPoints GTE 10 AND SESSION.esiTotalPoints LTE 19>
						<img src="img/partners/economicsecurity/meter_02.jpg" width="500" height="275" alt="Economic Security Meter - Not Secure" title="Economic Security Meter - Not Secure">
                  	<cfelseif SESSION.esiTotalPoints GTE 20 AND SESSION.esiTotalPoints LTE 30>
						<img src="img/partners/economicsecurity/meter_03.jpg" width="500" height="275" alt="Economic Security Meter - Not Secure" title="Economic Security Meter - Not Secure">
                  	</cfif>
                    <div class="clearfloat"></div>
                    <div style="margin-top:25px;">
	                    <p align="left">According to the EconomicCheckUp, you have serious money problems. You are unable to meet your basic needs. Also, you do not have help or do not know how to get the help you need to pay your bills. The EconomicCheckUp provides you with information on both government and private programs that may be able to assist you.</p>
                    </div>
              	</div>
			</cfif>
		</cfoutput>
			<div align="center">
				<!--- Chart calculations --->
                <cfset chartIncome = SESSION.esi_grossmonthlyincome>
				<cfset chartBenefits = SESSION.esi_currentvaluebenefits>
				<cfset chartIncomeAndBenefits = SESSION.esi_currentvaluebenefits + SESSION.esi_grossmonthlyincome>
				<cfif SESSION.esi_currentvaluebenefits EQ 0>
					<cfset chartIncomeAndBenefits = SESSION.esi_grossmonthlyincome>
				</cfif>


				<!--- For later use: If 1 or 2 people in household XXXX value is #esiMonthlyIncomeByLocation# --->
            	<!--- If 3 or more people in household XXXX value is (#SESSION.esiPovertyLevel# * 2 --->
                <cfoutput>
                	<cfset chartXXXX = 0>
					<cfif session.esi_incomesupport EQ 1 or session.esi_incomesupport EQ 2>
                        <cfset chartXXXX = #esiMonthlyIncomeByLocation#>
                    <cfelseif session.esi_incomesupport GTE 3>
                    	<cfset chartXXXX = #SESSION.esiPovertyLevel# * 2>
                    </cfif>
                </cfoutput>
                <cfinclude template="esibarchart.cfm">
			</div>
				<div style="padding-top:25px; margin-bottom:25px;">
                	<!--- Thriving --->
					<cfif (SESSION.esiTotalPoints LTE 80 AND SESSION.esiTotalPoints GTE 70) AND (session.esiPercentage GT 100)>
                    	<cfif chartExpenses LT SESSION.esi_grossmonthlyincome>
                            <p align="left">
                                    You have made it! You are in good financial health.  Even so, we know one bump in the road can change everything. We encourage you to re-visit us if anything about your situation changes. In <strong><cfoutput>#modifiedCountyName#</cfoutput></strong> your income exceeds your basic needs. You have been able to achieve <strong><cfoutput>#Round(session.esiPercentage)#</cfoutput>%</strong> of your economic security. There are public and private programs that may be able to assist you.          
                            </p>
                        <cfelse>
                        	<cfif session.esiPercentage LT 100>
                              	<p align="left">
                                	We are here to help you reach economic security. In <strong><cfoutput>#modifiedCountyName#</cfoutput></strong> your income does not adequately meet your basic needs. Without additional support, you will only be able to achieve <strong><cfoutput>#Round(session.esiPercentage)#</cfoutput>%</strong> of economic security for your county. However, there are public and private programs that can help.
                               	</p>
                         	<cfelse>
                            	<p align="left">
									We are here to help you strive for economic security, and there are public and private programs that may be able to help.                          		</p>
                          	</cfif>
                        </cfif>
                    <!--- Safe/Stable --->
                    <cfelseif (SESSION.esiTotalPoints LTE 69 AND SESSION.esiTotalPoints GTE 41) AND (session.esiPercentage GT 100)>
                    	<cfif chartExpenses LT SESSION.esi_grossmonthlyincome>
							<cfif session.esiPercentage GTE 125>
                                <p align="left">
                                    We are here to help you strive for economic security. There are public and private programs that may be able to help.
                               </p>
                            <cfelse>
                                <p align="left">
                                    We are here to help you strive for economic security. In <strong><cfoutput>#modifiedCountyName#</cfoutput></strong> your income provides for your basic needs; however, there are community services that can aid to building a safety net of resources to help you thrive for years to come.  Without additional support, you will only be able to achieve <strong><cfoutput>#Round(session.esiPercentage)#</cfoutput>%</strong> of your economic security. There are public and private programs that may be able to help.         	
                                </p>	
                            </cfif>
						<cfelse>
                        	<cfif session.esiPercentage LT 100>
                            	<p align="left">
                              		We are here to help you reach economic security. In <strong><cfoutput>#modifiedCountyName#</cfoutput></strong> your income does not adequately meet your basic needs. Without additional support, you will only be able to achieve <strong><cfoutput>#Round(session.esiPercentage)#</cfoutput>%</strong> of economic security for your county. However, there are public and private programs that can help.
                               	</p>
                         	<cfelse>
                            	<p align="left">
									We are here to help you strive for economic security, and there are public and private programs that may be able to help.                          		</p>
                          	</cfif>
                        </cfif>
					<!--- Vulnerable --->
                    <cfelseif (SESSION.esiTotalPoints LTE 40 AND SESSION.esiTotalPoints GTE 31) OR (session.esiPercentage LTE 100 AND SESSION.esiTotalPoints GTE 41)>
                    	<cfif session.esiPercentage LT 100>
                            <p align="left">
                                We are here to help you reach economic security. In <strong><cfoutput>#modifiedCountyName#</cfoutput></strong> your income does not adequately meet your basic needs. Without additional support, you will only be able to achieve <strong><cfoutput>#Round(session.esiPercentage)#</cfoutput>%</strong> of economic security for your county. However, there are public and private programs that can help.
                            </p>
                        <cfelse>
                            <p align="left">
                                We are here to help you strive for economic security, and there are public and private programs that may be able to help.                          		</p>
                        </cfif>
					<!--- In Crisis --->
                    <cfelseif (SESSION.esiTotalPoints LTE 30 AND SESSION.esiTotalPoints GTE 0)>
                    	<cfif session.esiPercentage GTE 125>
                        	<p align="left">
                                We are here to help you attain economic security. There are public and private programs that can help.
                           </p>
                    	<cfelse>
                        	<p align="left">
                           		We are here to help you attain economic security. In <strong><cfoutput>#SESSION.esi_zip#</cfoutput></strong> your income does not provide enough to make basic ends meet. Without support, you are only going to be able to achieve <strong><cfoutput>#Round(session.esiPercentage)#</cfoutput>%</strong> of your economic security. It is tough to meet basic needs considering your cost of living in <strong><cfoutput>#modifiedCountyName#</cfoutput></strong>. There are public and private programs that can help.     
                            </p>	
                    	</cfif>
                    </cfif>
                </div>
			<div id="howwecanhelp" style="padding:0px;">
				<div align="left"><h2 style="clear:both; float:left; background-color:#C6E5FD; font-weight:700; line-height:26px; margin-bottom:15px;padding:5px 0px 5px 5px; color:#1f419b; width:100%;">HOW WE CAN HELP</h2></div>
				<div>
                	<p style="margin:0 0 0 -25px;">
                        Balance your income against expenses in a more efficient and economically secure way. For assistance, please visit the recommended resource sites below.<!---cfif IsDefined("esiSite")> and contact your Economic Security Service Center, <cfoutput><strong>#esiSiteArray[esiSite]['sitename']#</strong>, at #esiSiteArray[esiSite]['phonenumber']#</cfoutput> to get a pathway to economic security today</cfif--->
					</p>
               	</div>
                <div class="clearfloat"></div>
				<ul style="margin-left:85px; margin-top:15px; margin-bottom:15px;">
					<cfif SESSION.percentageFPL LT 200>
                    <li>
						<p>Free up limited income with the help of a BenefitsCheckUp.</p>
					</li>
                   	<li>
						<p>Explore paid community service opportunities.</p>
					</li>
					 </cfif>
                     <cfif SESSION.esi_debtestimate GT (.3 * SESSION.esi_grossmonthlyincome)>
                    <li>
						<p>Get money management advice from certified debt management experts.</p>
					</li>
                    </cfif>
					<cfif (SESSION.esi_mobility EQ 'esi_mobility_limited' OR SESSION.esi_mobility EQ 'esi_mobility_unreliable' OR SESSION.esi_mobility EQ 'esi_mobility_notransportation')>
					<li>
						<p>Access community transportation services.</p>
					</li>
                    </cfif>
					<cfif SESSION.esi_housingtype EQ 'esi_housingtype_own' AND SESSION.esi_housingsituation EQ 'esi_housing_foreclosure'>
						<li>
							<p>It's your home, keep it with foreclosure mitigation information. </p>
						</li>
					</cfif>
				</ul>
				<div class="clearfloat"></div>
				<div><p align="left" style="margin:0 0 0 -25px;">
					Pending approval from providers
					of these services, the combination of public and private supports may help you
					achieve 100% of economic security.
				</p></div>
				<div id="next_steps" style="padding:0px;">
                	<div align="left"><h2 style="clear:both; float:left; background-color:#C6E5FD; font-weight:700; margin-top:25px; line-height:26px; margin-bottom:15px;padding:5px 0px 5px 5px; color:#1f419b; width:100%;">NEXT STEPS</h2></div>
                    <div>
                        <p align="left" style="margin:0 0 0 -25px;">
                            You are not alone on this journey. There are many important community
                            resources to help you get on track. There are federal, state, and local
                            programs that can help. Because you deserve it, let's get started today!
                        </p>
                    </div>
               	<div align="left" style="margin-top:15px;"><h3 style="padding-left:10px; padding-bottom:0px; font-size:20px;">RECOMMENDATIONS</h3></div>
				<div id="recommendations">
                	<div style="margin-left:50px;"><h3 style="background-color:#C6E5FD; font-weight:700; line-height:16px; margin-top:15px; margin-bottom:25px; padding:5px 0px 5px 5px; color:#1f419b; width:810px;">BENEFITSCHECKUP</h3><br></div>
										
					<div class="recommendation_detail">
                        <p>
                            Good news! As part of the EconomicCheckUp assessment, we completed a BenefitsCheckUp Quick Screen for you.  The BenefitsCheckUp Quick Screen can
provide information and contacts for key benefits programs that can help you pay for health care, utilities, property taxes, and more.  Get your <cfoutput><a href="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" target="_self">BenefitsCheckUp Quick Screen Results</a></cfoutput> now.<BR /><BR />
						</p>
						<cfif SESSION.percentageFPL LTE 200>
                           	<p>
 		                       	In addition, because you have limited income and can use additional help, you may want to complete a  BenefitsCheckUp Comprehensive questionnaire.  This questionnaire includes all state, federal, and private benefits programs available where you live.  Start a <a href="frmwelcome2.cfm?subset_id=0&partner_id=77" target="_blank">BenefitsCheckUp Comprehensive</a> now.
                          	</p>
						</cfif>
					</div>
                    
					<cfif (SESSION.esi_seekingemployment_usehelp EQ 'y' AND SESSION.diffYears GTE 55 AND SESSION.percentageFPL LTE 125) 
						OR (SESSION.esi_seekingemployment_usehelp EQ 'y' AND SESSION.diffYears LT 55 AND SESSION.percentageFPL LTE 125) 
						OR (SESSION.percentageFPL LTE 200 AND SESSION.esi_employmentsituation_list NEQ 'esi_employmentsituation_employed')>
						<div style="margin-left:50px;"><h3 style="background-color:#C6E5FD; font-weight:700; line-height:16px; margin-top:15px; margin-bottom:25px; padding:5px 0px 5px 5px; color:#1f419b; width:810px;">EMPLOYMENT</h3><br></div>
					</cfif>
					                    
					<cfif SESSION.esi_seekingemployment_usehelp EQ 'y' AND SESSION.diffYears GTE 55 AND SESSION.percentageFPL LTE 125>
						<!--- Get local SCSEP Office --->
                        <cfoutput>
                            <cfquery name="scsepEP" datasource="#application.dbSrc#" maxrows="1">
                                select e.entrypoint_id, zd.distance,p.number
                                from entrypoint_entrypointgroup eg, entrypoint e, view_zip_distance zd, phone p
                                where eg.entrypointgroup_id=286
                                    and eg.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode=zd.start_zipcode
                                    and zd.end_zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">
                                    and zd.distance < 100
                                    and p.entrypoint_id=e.entrypoint_id
                                    and p.phonetype_id = 1
                                union
                                select e.entrypoint_id, 999999 distance,p.number
                                from entrypoint_entrypointgroup eg, entrypoint e,phone p
                                where eg.entrypointgroup_id=286
                                    and eg.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode is null
                                    and e.zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">
                                    and p.entrypoint_id=e.entrypoint_id
                                    and p.phonetype_id = 1
                                order by distance
                            </cfquery>
                            <cfif IsDefined("scsepEP.entrypoint_id") and scsepEP.entrypoint_id neq ''>
                                <cfset mySCSEP_id = #scsepEP.entrypoint_id#>
                            <cfelse>
                                <cfset mySCSEP_id = 0>
                            </cfif>
                            <cfif IsDefined("mySCSEP_id")  >
                                <cfquery name="getSCSEPphone" datasource="#application.dbSrc#" maxrows="1">
                                    Select number
                                    from phone
                                    where entrypoint_id = #mySCSEP_id# and phonetype_id = 1
                                </cfquery>
                            </cfif>
                            <cfset scsep_phone = '(888)480-1527'>
                            <cfif getSCSEPphone.RecordCount EQ 1>
                                <cfset scsep_phone = '#getSCSEPphone.number#'>
                            </cfif>
                    	</cfoutput>
                        <div class="recommendation_detail">
							<h3>SCSEP</h3>
							<p>
                            	The Senior Community Service Employment Program (SCSEP) can help you find a job and offers you job training if you have low-income and are 55 years of age or older. If you are unemployed and are having difficulty getting a job, SCSEP will help you learn the skills you need to find work. Contact your local SCSEP office at <cfoutput>#Trim(scsep_phone)# </cfoutput>for more information.<BR /><BR />For other employment  assistance, go to <a href="http://www.servicelocator.org" target="_blank">America's Service</a> Locator to find a local One-Stop Career Center or call (877) US2-JOBS. 
							</p>
						</div>
					</cfif>
					
					<cfif SESSION.esi_seekingemployment_usehelp EQ 'y' AND SESSION.diffYears LT 55 AND SESSION.percentageFPL LTE 125>
						<div class="recommendation_detail">
							<h3>One Stop</h3>
							<p>
								The One-Stop Career Center can help you find a job, review your resume, learn tips on interviewing, and provide education and training to update your job skills.  Find out more about the One-Stop Career centers by going to <a href="http://www.servicelocator.org" target="_blank">America's Service Locator</a> or by calling (877) US2-JOBS.
							</p>
						</div>
					</cfif>
					
					<cfif SESSION.percentageFPL LTE 200 AND SESSION.esi_employmentsituation_list NEQ 'esi_employmentsituation_employed'>
						<div class="recommendation_detail">
							<h3>Senior Companion</h3>
							<p>
								You can become a volunteer by joining the Senior Corps. You will receive a small amount of money for the services you provide (also known as a stipend).  For more information, visit their <a href="http://www.seniorcorps.org" target="_blank">website</a> or call (800) 942-2677.
							</p>
						</div>
					</cfif>
					
					<cfif (( SESSION.esi_debtestimate GT (SESSION.annualIncome/2) ) OR ( SESSION.esi_debtestimate GT (SESSION.homeEquity * .30) ) OR (SESSION.esi_debtscenarios_creditlimit EQ 'y' OR SESSION.esi_debtscenarios_minimum EQ 'y' OR SESSION.esi_debtscenarios_creditors EQ 'y' OR SESSION.esi_debtscenarios_bankruptcy EQ 'y'))
						 OR (SESSION.esi_helpbalancing EQ 'n' AND eligibleForDebtManagement EQ false) OR (SESSION.diffYears GTE 62 AND SESSION.esi_housingsituation EQ 'esi_housing_foreclosure') OR (SESSION.esi_interest_budgeting EQ 'y') OR (SESSION.esi_interest_pension EQ 'y')>
						<div style="margin-left:50px;"><h3 style="background-color:#C6E5FD; font-weight:700; line-height:16px; margin-top:15px; margin-bottom:25px; padding:5px 0px 5px 5px; color:#1f419b; width:810px;">DEBT</h3><br></div>
					</cfif>
					<cfif (SESSION.esi_debtestimate GT (SESSION.annualIncome/2)) OR ( SESSION.esi_debtestimate GT (SESSION.homeEquity * .30) ) OR (SESSION.esi_debtscenarios_creditlimit EQ 'y' OR SESSION.esi_debtscenarios_minimum EQ 'y' OR SESSION.esi_debtscenarios_creditors EQ 'y' OR SESSION.esi_debtscenarios_bankruptcy EQ 'y')>
						<div class="recommendation_detail">
							<h3>Debt Management Services</h3>
							<p>
							Use the <a href="http://www.wiserwomen.org/index.php?id=89" target="_blank">Retirement Income Calculator</a> to find out how much money you need to live comfortably after you retire. The Women's Institute for a Secure Retirement developed this tool.<BR /><BR /> 
Use the <a href="http://www.aarp.org/money/credit-loans-debt/debt_consolidation_calculator" target="_blank">Debt Consolidation Calculator</a> from AARP to learn if debt consolidation is right for you. This is the process of taking out one loan to pay off many other loans.<BR /><BR />
The National Foundation for Credit Counseling (NFCC) promotes financially responsible behavior, and builds capacity for its members to deliver the highest-quality financial education and counseling services. NFCC Member Agencies provide individual, confidential counseling in-person, by phone, or over the Internet. Local offices are staffed by professional Certified Consumer Credit Counselors that provide personal assistance to people who need help with stressful financial situations. To locate an NFCC Member Agency in your area, call 800-388-2227 or go online to <a href="https://www.mymoneycheckup.org/" target="_blank">https://www.mymoneycheckup.org/</a>. Para ayuda en espa&ntilde;ol llame al 800-682-9832.<BR /><BR />
Use the <a href="http://www.aarpmmp.org" target="_blank">AARP Money Management</a> program to help you with your money problems. This program helps low-income and disabled people budget their money, keep track of their money, and pay their bills.<BR /><BR />
Check your credit scores at <a href="http://www.AnnualCreditReport.com" target="_blank">AnnualCreditReport.com</a>. <BR /><BR />
The <a href="http://www.nclc.org/for-consumers/brochures-for-older-consumers.html" target="_blank">National Consumer Law Center</a> provides information on how to prevent foreclosure and what to do if you are going through foreclosure. It also gives you information about bankruptcy, debt collection, unfair and dishonest practices, sales and warranties rights, energy assistance, and public utilities.<BR /><BR />
The Federal Trade Commission (FTC) protects your rights as a consumer.  If you are having trouble with a company, the FTC will take your complaint and look into the company's business practices.  They will also help you with cases of identity theft. For more information, visit their <a href="https://www.ftccomplaintassistant.gov" target="_blank">website</a> or call to report a complaint at (877) FTC-HELP.
<cfif SESSION.esi_totalassets GT 0><BR /><BR />Your  counselor may be able to discuss how you can use your  assets to lower your debt.</cfif>
							</p>
						</div>
						<cfset eligibleForDebtManagement = true>
					</cfif>
					
					<cfif SESSION.esi_helpbalancing EQ 'n' AND eligibleForDebtManagement EQ false>
						<div class="recommendation_detail">
							<h3>Certified Debt Management Companies</h3>
							<p>
								Use the <a href="http://www.aarp.org/money/credit-loans-debt/debt_consolidation_calculator" target="_blank">Debt Consolidation Calculator</a> from AARP to learn if debt consolidation is right for you. This is the process of taking out one loan to pay off many other loans.<BR /><BR />
The National Foundation for Credit Counseling (NFCC) promotes financially responsible behavior, and builds capacity for its members to deliver the highest-quality financial education and counseling services. NFCC Member Agencies provide individual, confidential counseling in-person, by phone, or over the Internet. Local offices are staffed by professional Certified Consumer Credit Counselors that provide personal assistance to people who need help with stressful financial situations. To locate an NFCC Member Agency in your area, call 800-388-2227 or go online to <a href="https://www.mymoneycheckup.org/" target="_blank">https://www.mymoneycheckup.org/</a>. Para ayuda en espa&ntilde;ol llame al 800-682-9832.
						</div>
					</cfif>
					
					<cfif SESSION.diffYears GTE 62 AND SESSION.esi_housingsituation EQ 'esi_housing_foreclosure'>
						<div class="recommendation_detail">
							<h3>Legal Services</h3>
							<p>
								Visit the <a href="http://legalhotlines.org/naslh.php" target="_blank">Directory of Legal Assistance Hotlines</a>. This program is from the Center for Elder Rights Advocacy.<BR /><BR />
The <a href="http://www.foreclosurelegalassistance.org" target="_blank">Instititue for Foreclosure Legal Assistance</a> provides funding and training to groups that help homeowners fight foreclosure. Find out about groups in your area that can provide you with legal help to fight foreclosure on your home.
							</p>
						</div>
					</cfif>
                    
                    <cfif SESSION.esi_interest_budgeting EQ 'y'>
                    	<div class="recommendation_detail">
							<h3>Budgeting Assistance</h3>
							<p>
								GreenPath Debt Solutions is a non-profit group that helps consumers cope with money problems. It provides free classes and tools to help people create and manage a budget. To speak to a counselor, call (800) 550-1961 or visit their <a href="http://www.greenpath.com/university/managing-money/budgeting.htm" target="_blank">website</a>.<BR /><BR />
Use NCOA's Savvy Saving Seniors <a href="http://www.ncoa.org/assets/files/pdf/savvy-saving-seniors/Savvy-Saving-Seniors-Training-Guide-FINAL.pdf" target="_blank">"Becoming Resource-FULL with the Help of Benefits and Peace of Mind Savings"</a> to learn more about how to create a budget and access benefits.
							</p>
						</div>
                    </cfif>
					
                    <cfif SESSION.esi_interest_pension EQ 'y'>
                    	
                        <!--- Get local Pension Office --->
                        <cfoutput>
                            <cfquery name="pensionEP" datasource="#application.dbSrc#" maxrows="1">
                                select e.entrypoint_id, e.name, zd.distance, p.number
                                from entrypoint_entrypointgroup eg, entrypoint_county ec, entrypoint e, view_zip_distance zd, phone p
                                where eg.entrypointgroup_id=456
                                    and eg.entrypoint_id=e.entrypoint_id
                                    and ec.county_id in (select county_id from zip where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">)
									and ec.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode=zd.start_zipcode
                                    and zd.end_zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">
                                    and p.entrypoint_id=e.entrypoint_id
                                    and p.phonetype_id = 4
                                union
                                select e.entrypoint_id, e.name, 999999 distance, p.number
                                from entrypoint_entrypointgroup eg, entrypoint e, entrypoint_county ec, phone p
                                where eg.entrypointgroup_id=456
                                    and eg.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode is null
                                    and e.zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">
                                    and p.entrypoint_id=e.entrypoint_id
                                    and e.entrypoint_id=ec.entrypoint_id
									and ec.county_id in (select county_id from zip where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">)
                                    and p.phonetype_id = 4
                                order by distance
                            </cfquery>
                            <cfif IsDefined("pensionEP.entrypoint_id") and pensionEP.entrypoint_id neq ''>
                                <cfset myPension_id = #pensionEP.entrypoint_id#>
                            <cfelse>
                                <cfset myPension_id = 0>
                            </cfif>
                            <cfif IsDefined("myPension_id")  >
                                <cfquery name="getPensionPhone" datasource="#application.dbSrc#" maxrows="1">
                                    Select number
                                    from phone
                                    where entrypoint_id = #myPension_id# and phonetype_id = 4
                                </cfquery>
                            </cfif>
                            <cfset pension_phone = ''>
                            <cfif getPensionPhone.RecordCount EQ 1>
                                <cfset pension_phone = '#getPensionPhone.number#'>
                            </cfif>
                    	</cfoutput>
                        
                    	<div class="recommendation_detail">
							<h3>Pension Assistance</h3>
							<p>
                            	<cfif myPension_id EQ 0 OR myPension_id EQ 54643>
                                	Contact the <a href="http://www.pensionrights.org/" target="_blank">Pension Rights Center</a> to get help with your pension.
								<cfelse>
                                    Contact the <cfoutput>#Trim(pensionEP.name)# at #Trim(pension_phone)#</cfoutput> to get help with your pension.
                                </cfif>
                            </p>
						</div>
                    </cfif>
                    
					<cfif (SESSION.esi_housingtype EQ 'esi_housingtype_homeless') 
						OR ((SESSION.esi_housingsituation EQ 'esi_housing_mortgagepaid' OR SESSION.esi_housingsituation EQ 'esi_housing_someequity') AND SESSION.diffYears GTE 62)
						OR (SESSION.esi_housingsituation EQ 'esi_housing_underwater')
						OR (SESSION.diffYears GTE 62 AND (SESSION.esi_housingsituation EQ 'esi_housing_underwater' OR SESSION.esi_housingsituation EQ 'esi_housing_someequity'))
						OR (SESSION.esi_housingtype eq 'esi_housingtype_rent')
						OR (SESSION.esi_housingtype EQ 'esi_housingtype_own' AND SESSION.esi_homeinsurance EQ 'y')>
						<div style="margin-left:50px;"><h3 style="background-color:#C6E5FD; font-weight:700; line-height:16px; margin-top:15px; margin-bottom:25px; padding:5px 0px 5px 5px; color:#1f419b; width:810px;">HOUSING</h3><br></div>
					</cfif>
					
					<cfif SESSION.esi_housingtype EQ 'esi_housingtype_own' AND SESSION.esi_homeinsurance EQ 'y'>
						<div class="recommendation_detail">
							<h3>Homeowner's Insurance</h3>
							<p>
								To learn more about how to get homeowner's insurance, call a HUD-approved <a href="http://www.hud.gov/offices/hsg/sfh/hcc/hcs.cfm" target="_blank">housing agency</a> for advice.
							</p>
						</div>
					</cfif>
					
					<cfif SESSION.esi_housingtype EQ 'esi_housingtype_homeless'>
						<div class="recommendation_detail">
							<h3>Homeless Intervention</h3>
							<p>
								If you are homeless there are options that can  help you.  HUD provides grants to help with homelessness.  You can use the <a href="http://www.hudhre.info/index.cfm?do=viewCocContacts" target="_blank">Continuum of Care (CoC) Homeless Assistance Locator</a> to find contact information for a CoC agency and for the HUD Field Office serving the CoC's territory.<BR /><BR /> 
If you are a homeless veteran, visit <a href="http://portal.hud.gov/hudportal/HUD?src=/program_offices/comm_planning/veteran_information" target="_blank">HUDVet</a>, the <a href="http://www1.va.gov/homeless/index.asp" target="_blank">Veterans Administration page for homeless veterans</a>, and the <a href="http://www.nchv.org" target="_blank">National Coalition for Homeless Veterans</a>,  or call (877) 4AID VET to find out more about benefits and help that might be specifically available to you.<BR /><BR />
For advice on buying homes, renting, preventing foreclosure, credit problems and reverse mortgages, call 1-800-569-4287 or go online to <a href="http://www.hud.gov/offices/hsg/sfh/hcc/hcs.cfm" target="_blank">Housing Counseling Agency</a>.
							</p>
						</div>
					</cfif>
					
					<cfif (SESSION.esi_housingsituation EQ 'esi_housing_mortgagepaid' OR SESSION.esi_housingsituation EQ 'esi_housing_someequity') AND SESSION.diffYears GTE 62>
						<div class="recommendation_detail">
							<h3>Pre-lender Reverse Mortgage Opportunities</h3>
							<p>
								A reverse mortgage is a loan for senior homeowners. It uses some of the home's equity to secure the mortgage. Most of the time, the loan does not have to be repaid until the last homeowner moves out or passes away. Once that happens, the homeowner's estate has about 6 months to repay the balance or to sell the home to pay off the balance due. Any money remaining after the sale of the home goes to the estate. The estate does not have to pay if the home sells for less that what is owed on the mortgage. Using the equity in your home may seem like a good idea. But is it right for you? For help making your decision, use NCOA's <a href="http://www.ncoa.org/news-ncoa-publications/publications/ncoa_reverse_mortgage_booklet_073109.pdf" target="_blank">Use Your Home to Stay at Home: A Guide for Older Homeowners Who Need Help Now</a>. It talks about the pros and cons of using the equity in your home.<BR /><BR />
Estimate the benefits you might receive from a reverse mortgage by using the <a href="http://rmc.ibisreverse.com/default_nrmla.aspx" target="_blank">Reverse Mortgage Calculator</a> sponsored by the National Reverse Mortgage Lender Association.
							</p>
						</div>
					</cfif>
					
					<cfif SESSION.esi_housingsituation EQ 'esi_housing_underwater'>
						<div class="recommendation_detail">
							<h3>Underwater Opportunities</h3>
							<p>
								You can get <a href="http://www.hud.gov/offices/hsg/sfh/hcc/fc/index.cfm" target="_blank">foreclosure counseling</a> from HUD.<BR /><BR />
You can get <a href="http://www.federalreserve.gov/consumerinfo/foreclosure.htm" target="_blank">state-based foreclosure counseling</a> from the Federal Reserve Bank. 
							</p>
						</div>
					</cfif>
					
					<cfif SESSION.diffYears GTE 62 AND (SESSION.esi_housingsituation EQ 'esi_housing_underwater' OR SESSION.esi_housingsituation EQ 'esi_housing_someequity')>
						<div class="recommendation_detail">
							<h3>NeighborWorks</h3>
							<p>

								Learn about NeighborWork's <a href="http://www.findaforeclosurecounselor.org/network/nfmc_lookup" target="_blank">Foreclosure Counseling</a> program.
							</p>
						</div>
					</cfif>
					
					<cfif SESSION.esi_housingtype eq 'esi_housingtype_rent'>
						<div class="recommendation_detail">
							<h3>Renter Assistance</h3>
							<p>
                            	Learn about HUD Rental Assistance programs by visiting their <a href="http://portal.hud.gov/portal/page/portal/HUD/topics/rental_assistance" target="_blank">website</a> or calling (800) 569-4287.
							</p>
						</div>
					</cfif>
					<cfif (SESSION.esi_mobility EQ 'esi_mobility_owncar'
							OR SESSION.esi_mobility EQ 'esi_mobility_limited'
							OR SESSION.esi_mobility EQ 'esi_mobility_unreliable'
							OR SESSION.esi_mobility EQ 'esi_mobility_notransportation'
							OR SESSION.esi_mobility EQ 'esi_mobility_useavailable')>
						<!--- Mobility --->
						<div style="margin-left:50px;"><h3 style="background-color:#C6E5FD; font-weight:700; line-height:16px; margin-top:15px; margin-bottom:25px; padding:5px 0px 5px 5px; color:#1f419b; width:810px;">MOBILITY</h3><br></div>
					</cfif>
					
					<cfif SESSION.esi_mobility EQ 'esi_mobility_owncar'>
						<div class="recommendation_detail">
							<h3>AARP Driver Safety Program</h3>
							<p>
								Use the <a href="http://www.aarp.org/home-garden/transportation/driver_safety/" target="_blank">AARP Driver Safety Program</a> to learn how to keep driving safely as you get older.
							</p>
						</div>
					</cfif>
					
					<cfif (SESSION.esi_mobility EQ 'esi_mobility_limited'
							OR SESSION.esi_mobility EQ 'esi_mobility_unreliable'
							OR SESSION.esi_mobility EQ 'esi_mobility_notransportation')>
						<div class="recommendation_detail">
							<h3>ITN America</h3>
							<p>
								Get help meeting your transportation needs with <a href="http://www.itnamerica.org/content/WereHereIfYouWantHelp.php" target="_blank">ITN America</a>, which offers door-to-door transportation services.
							</p>
						</div>
					</cfif>
					
					<cfif SESSION.esi_mobility EQ 'esi_mobility_limited'
							OR SESSION.esi_mobility EQ 'esi_mobility_unreliable'
							OR SESSION.esi_mobility EQ 'esi_mobility_notransportation'
							OR SESSION.esi_mobility EQ 'esi_mobility_useavailable'>
						<div class="recommendation_detail">
							<h3>Public Transit System</h3>
							<p>
								Find out about <a href="http://www.publictransportation.org/systems/" target="_blank">public tranportation</a> in your community.
							</p>
						</div>
					</cfif>
					
					<!--- Meals --->
					<cfif (SESSION.esi_meals EQ 'esi_meals_relyonassistance' 
							OR SESSION.esi_meals EQ 'esi_meals_inadequate' 
							OR SESSION.esi_meals EQ 'esi_meals_nofood')>
						<div style="margin-left:50px;"><h3 style="background-color:#C6E5FD; font-weight:700; line-height:16px; margin-top:15px; margin-bottom:25px; padding:5px 0px 5px 5px; color:#1f419b; width:810px;">FOOD</h3><br></div>
					</cfif>
					
					<cfif (SESSION.esi_meals EQ 'esi_meals_relyonassistance' 
							OR SESSION.esi_meals EQ 'esi_meals_inadequate' 
							OR SESSION.esi_meals EQ 'esi_meals_nofood')>
						<div class="recommendation_detail">
							<h3>Local Food Bank</h3>
							<p>
								Find a local <a href="http://feedingamerica.org/foodbank-results.aspx" target="_blank">food bank</a>.
							</p>
						</div>
					</cfif>
					
					<cfif (SESSION.diffYears GTE 60 AND (SESSION.esi_healthmonthly GTE calcIncome)) or (isdefined('session.esi_counselor') and session.esi_counselor eq 'Y' )
						OR (SESSION.esi_ratehealth EQ 'esi_ratehealth_poor' OR SESSION.esi_ratehealth EQ 'esi_ratehealth_fair' OR SESSION.esi_healthdisability EQ 'y')>
						<div style="margin-left:50px;"><h3 style="background-color:#C6E5FD; font-weight:700; line-height:16px; margin-top:15px; margin-bottom:25px; padding:5px 0px 5px 5px; color:#1f419b; width:810px;">HEALTH</h3><br></div>
					</cfif>
					
					<cfif (SESSION.diffYears GTE 65 AND (SESSION.esi_healthmonthly GTE calcIncome)) OR (isdefined('session.esi_counselor') and session.esi_counselor eq 'Y' )>
                    	<!--- Get local SHIP Office --->
                        <cfoutput>
                            <cfquery name="shipEP" datasource="#application.dbSrc#" maxrows="1">
                                 select e.entrypoint_id, e.name, e.url, p.number
                                from entrypoint_entrypointgroup eg, entrypoint e, phone p
                                where eg.entrypointgroup_id=83
                                    and eg.entrypoint_id=e.entrypoint_id
                                    and e.state_id in (select state_id from zip where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">)
				    				and e.active_flag=1
                                    and p.entrypoint_id=e.entrypoint_id
                                    and p.phonetype_id = 4
                            </cfquery>
                            <cfif IsDefined("shipEP.entrypoint_id") and shipEP.entrypoint_id neq ''>
                                <cfset mySHIP_id = #shipEP.entrypoint_id#>
                            <cfelse>
                                <cfset mySHIP_id = 0>
                            </cfif>
                            <cfif IsDefined("mySHIP_id")  >
                                <cfquery name="getSHIPphone" datasource="#application.dbSrc#" maxrows="1">
                                    Select number
                                    from phone
                                    where entrypoint_id = #mySHIP_id# and phonetype_id = 4
                                </cfquery>
                            </cfif>
                            <cfset ship_phone = ''>
                            <cfif getSHIPphone.RecordCount EQ 1>
                                <cfset ship_phone = '#getSHIPphone.number#'>
                            </cfif>
                    	</cfoutput>
						<div class="recommendation_detail">
							<h3>State Health Insurance Assistance Program</h3>
							<p>
								To get help with your health insurance options, contact <cfoutput>#Trim(shipEP.name)# at #Trim(ship_phone)# or get more information here: <a href="#Trim(shipEP.url)#" target="_blank">#Trim(shipEP.url)#</a></cfoutput>.<BR /><BR />
Get help choosing a Prescription Drug Plan under Medicare Part D. Check out NCOA's <a href="http://www.mymedicarematters.org/PrescriptionDrugs/index.php" target="_blank">MyMedicareMatters</a>.<BR /><BR />
Learn about <a href="http://www.cms.gov/Medigap/" target="_blank">Medigap</a> insurance. This is supplemental or additional insurance to your Medicare insurance. Contact the Centers for Medicare and Medicaid for more information. 
							</p>
						</div>
					</cfif>
					
					<cfif (SESSION.esi_ratehealth EQ 'esi_ratehealth_poor' OR SESSION.esi_ratehealth EQ 'esi_ratehealth_fair' OR SESSION.esi_healthdisability EQ 'y')>
						<div class="recommendation_detail">
							<h3>Chronic Disease Self-Management Workshop</h3>
							<p>
								Use Stanford University's Chronic Diseases Self Management Workshop to help you: find ways to deal with pain, fatigue, and stress; make better food and exercise choices; make informed treatment decisions; learn better ways to talk with your doctor and family about your health; and get the support you need. If you have a chronic illness, such as diabetes, arthritis, high blood pressure, heart disease, chronic pain, anxiety, or something else, please consider taking a workshop. These workshops can help you take better control of your health and your life. To find out about a workshop in your area, please email <a href="mailto:cdsmp@ncoa.org">cdsmp@ncoa.org</a>.
							</p>
						</div>
					</cfif>
				
					<cfif SESSION.diffYears GTE 65>
						<div class="recommendation_detail">
							<h3>Aging Services</h3>
							<p>
								Use the <a href="http://www.eldercare.gov" target="_blank">Eldercare Locator</a> to help you find services for older adults and their families. Or call 1-800-677-1116.
							</p>
							
						</div>
					</cfif>
                    
                    <cfif SESSION.diffYears GTE 60>
                    	<cfoutput>
                            <!--- Proximity Zip search --->
                            <cfquery name="aaaEP" datasource="#application.dbSrc#" maxrows="1">
                                select e.entrypoint_id, zd.distance, p.number
                                from entrypoint_entrypointgroup eg, entrypoint_zip ez, entrypoint e, view_zip_distance zd, phone p
                                where eg.entrypointgroup_id=1
                                    and eg.entrypoint_id=ez.entrypoint_id
                                    and ez.zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">
                                    and ez.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode=zd.start_zipcode
                                    and zd.end_zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">
                                union
                                select e.entrypoint_id, 999999 distance, p.number
                                from entrypoint_entrypointgroup eg, entrypoint e, entrypoint_zip ez, phone p
                                where eg.entrypointgroup_id=1
                                    and eg.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode is null
                                    and e.entrypoint_id=ez.entrypoint_id
                                    and ez.zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">
                                order by distance
                            </cfquery>
                            <!--- Proximity County search --->
                            <cfif aaaEP.RecordCount EQ 0>
                            	<cfquery name="aaaEP" datasource="#application.dbSrc#" maxrows="1">
                                    select e.entrypoint_id, zd.distance, p.number
                                    from entrypoint_entrypointgroup eg, entrypoint_county ec, entrypoint e, view_zip_distance zd, phone p
                                    where eg.entrypointgroup_id=1
                                        and eg.entrypoint_id=ec.entrypoint_id
                                        and ec.county_id in (select county_id from zip where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">)
                                        and ec.entrypoint_id=e.entrypoint_id
                                        and e.active_flag=1
                                        and e.zipcode=zd.start_zipcode
                                        and zd.end_zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">
                                    UNION
                                    select e.entrypoint_id, 999999 distance, p.number
                                    from entrypoint_entrypointgroup eg, entrypoint e, entrypoint_county ec, phone p
                                    where eg.entrypointgroup_id=1
                                        and eg.entrypoint_id=e.entrypoint_id
                                        and e.active_flag=1
                                        and e.zipcode is null
                                        and e.entrypoint_id=ec.entrypoint_id
                                        and ec.county_id in (select county_id from zip where zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">)
                                    order by distance
                                </cfquery>
                        	</cfif>
                            <!--- Proximity Radius search. Custom solution for issues with IL Counties Cook and Lake where zips exist cross county --->
                            <cfif aaaEP.RecordCount EQ 0>
                                <cfquery name="aaaEP" datasource="#application.dbSrc#" maxrows="1">
                                    select e.entrypoint_id, p.number
                                    from entrypoint_entrypointgroup eg, entrypoint e, view_zip_distance zd, phone p
                                    where eg.entrypointgroup_id=1
                                        and eg.entrypoint_id=e.entrypoint_id
                                        and e.active_flag=1
                                        and e.zipcode=zd.start_zipcode
                                        and zd.start_state_id='IL'
                                        and zd.end_zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#SESSION.esi_zip#">
                                        and zd.distance <= 100
                                    order by zd.distance
                                </cfquery>
							</cfif>                 
                                                        
                            <cfif IsDefined("aaaEP.entrypoint_id")>
                                <cfset myAAA_id = #aaaEP.entrypoint_id#>
                            <cfelse>
                                <cfset myAAA_id = 0>
                            </cfif>
							<cfset getAAAphone = querynew("")>
                            <cfif IsDefined("myAAA_id") and myAAA_id neq ''>
                                <cfquery name="getAAAphone" datasource="#application.dbSrc#" maxrows="1">
                                    Select number
                                    from phone
                                    where entrypoint_id = #myAAA_id# and phonetype_id = 1
                                </cfquery>
                            </cfif>
                            <cfset aaa_phone = ''>
                            <cfif getAAAphone.RecordCount EQ 1>
                                <cfset aaa_phone = '#getAAAphone.number#'>
                            </cfif>
                    	</cfoutput>
						<div class="recommendation_detail">
							<h3>Area Agency on Aging</h3>
							<p>
								Contact your local Area Agency on Aging today at <cfoutput>#Trim(aaa_phone)# </cfoutput>to learn more about the aging services available in your community. All people who are 60 years of age or older can get community services from the agency, but people with the greatest needs are helped first. 
							</p>
						</div>
					</cfif>
                    
                    <cfif SESSION.esi_interest_aps EQ 'y'>
						<div class="recommendation_detail">
							<h3>Adult Protective Services</h3>
							<p>
								Contact your state's <a href="http://www.ncea.aoa.gov/NCEAroot/Main_Site/Find_Help/State_Resources.aspx" target="_blank">Adult Protective Services Agency</a> if you are worried that an older person you know is being abused, neglected, or seriously taken advantage of or call the Eldercare Locator at (800) 677-1116. If someone is in immediate danger, call 911 or the local police.
							</p>
						</div>
					</cfif>   <!--- END recommendations --->                 
				</div>
              	<div style="margin-left:50px;">
                	<div style="text-align:center;">
                	<p align="center">
                    	<div class="clearfloat"></div>
                    	<input type="button" id="view_results" style="font-size:12px; margin: 25px 10px 0px 0pt;" value="Better Choices Better Health" onClick="javascript:window.open('http://www.selfmanage.org', '_blank'); return false;">
						<input type="button" id="view_results" style="font-size:12px;margin: 25px 10px 0px 0pt;" value="Savvy Seniors" onClick="javascript:window.open('http://www.ncoa.org/enhance-economic-security/economic-security-Initiative/savvy-saving-seniors/savvy-saving-seniors.html', '_blank'); return false;">
						
						<cfif SESSION.esi_seekingemployment_skillsassessment EQ 'Y' or Session.esi_seekingemployment_refresher EQ 'Y' or Session.esi_seekingemployment_usehelp EQ 'Y' >
							<input type="button" id="view_results" style="font-size:12px; margin: 25px 10px 25px 0pt;" value="Job Source" onClick="javascript:window.open('/jobsource', '_blank'); return false;">
						</cfif>
                        <cfif SESSION.esi_housingtype EQ 'esi_housingtype_own'>
                        	<input type="button" id="view_results" style="font-size:12px;margin: 25px 10px 25px 0pt;" value="Home Equity Advisor" onClick="javascript:window.open('http://www.homeequityadvisor.org', '_blank'); return false;">
                        </cfif>
                    </p>
                    </div>
                </div>
                <!---div class="clearfloat"></div>
				<div id="recommendations">
                	<div style="margin-left:50px;"><h3 style="background-color:#C6E5FD; font-weight:700; line-height:16px; margin-top:15px; margin-bottom:25px; padding:5px 0px 5px 5px; color:#1f419b; width:810px;">COMMENTS</h3><br></div>
					<div class="recommendation_detail">
                        <p>
                           	Please give us feedback on the EconomicCheckUp.<BR />
                            <a href="http://www.surveymonkey.com/s/LQPZRWN" target="_blank">Click here</a> to complete a short satisfaction survey. Thank you!
						</p>
					</div>
                </div--->                
                <div class="clearfloat"></div>
                <div align="left" style="margin-top:15px;"><h3 style="padding-left:10px; padding-bottom:0px; font-size:20px;">COMMENTS</h3></div>
                <div id="recommendations">
                	<div class="recommendation_detail">
                     	<p>
                       		Please give us feedback on the EconomicCheckUp.<BR />
                            <a href="http://www.surveymonkey.com/s/LQPZRWN" target="_blank">Click here</a> to complete a short satisfaction survey. Thank you!
                  		</p>
             		</div>
                </div>
                 <div style="width:875px;margin:0px auto;" align="center">
                 		<div class="clearfloat"></div><BR />
                        Note: Economic Security determination calculated using Wider Opportunities for Women's Elder Economic Security Standard&trade; Index.
				</div>
				<div style="width:875px;margin:0px auto;padding:10px;" align="center">
						<a href="http://www.wowonline.org" target="_new"><img src="img/partners/economicsecurity/wow.png" title="Wider Opportunities for Women" alt="Wider Opportunities for Women" border="0" /></a>
				</div>
				
			</div>
			
		</div>
	
		<div style="float:right; clear:both; padding-bottom:15px;">
        	<cfif URL.printfriendly>
            	<CFSET CurrentURL = 'http://' & CGI.SERVER_NAME & CGI.SCRIPT_NAME & '?' & CGI.QUERY_STRING>
                <cfoutput><CFSET CurrentURL = "#Replace(CurrentURL, '&printfriendly=TRUE', '')#"></cfoutput>
				<a style="font-size:16px;" id="printfriendly_link" href="<cfoutput>#currentURL#</cfoutput>">Back to EconomicCheckUp Web Report</a>
            <cfelse>
				<CFSET CurrentURL = 'http://' & CGI.SERVER_NAME & CGI.SCRIPT_NAME & '?' & CGI.QUERY_STRING &'&printfriendly=TRUE'>
				<a style="font-size:16px;" id="printfriendly_link" href="<cfoutput>#currentURL#</cfoutput>">Printer Friendly EconomicCheckUp Report</a>
            </cfif>
		</div>
    <!-- end .content --></div>
  <!-- end .container --></div>

</cf_buildHTML>

<!--- DEBUGGING BELOW :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::>
<hr>

<h1>Debugging Info</h1>

<cfif session.esi_grossmonthlyincome eq ''>
	<cfset session.esi_grossmonthlyincome = 0>
</cfif>

<cf_buildHTML>
<style>
	td {
		font-size:11px;
	}
	h3.status {
		font-size:24px;
		color:#006;
	}
</style>
	<table width="600" border="0" align="left" cellpadding="0" cellspacing="0">
		<tr>
			<td><h3>Debugging ESI Calculations</h3>
				
<!--- use the zipcode to detect county --->
				
<cfquery name="getcounty" datasource="#application.dbSrc#">
select  z.zipcode, z.county_id, c.*
from county c, zip z
where c.county_id = z.county_id
<cfif isdefined('session.esi_zip')>
and z.zipcode = #session.esi_zip#
<cfelse>
and (1 = 0)
</cfif>
</cfquery>
				<cfdump var="#getcounty#" label="County Data" expand="false">
				<br>
				<cfoutput>
					<h3>Fields Used For ESI Calculation:</h3>
					User Zipcode: #session.esi_zip# <br>
					User County Derived from Zip: #getcounty.county_name# <br>
					User Gross Monthly Income: #session.esi_grossmonthlyincome# <br>
					Marital Status: #session.esi_marital# <br>
					Type of Housing: #session.esi_housingtype# <br>
					Total Debt Remaining on Home: #session.esi_totaldebthouse# <br>
					Rate Your Health: #session.esi_ratehealth# <br>
					Non Home Debt: #session.esi_debtestimate# <br>
					Number of Household Members Supported: #session.esi_incomesupport# <br>
					Value of Benefits: #session.esi_currentvaluebenefits# <br>
				</cfoutput> <br>
				<br>
				
				<!--- Get the ESI Numbers based on County ID --->
				
				<h3>Get Percentage  ESI Calculation:</h3>
				<cfoutput>Check Health Cost Adjustment: #session.esi_ratehealth# <br>
				</cfoutput> 
				<!---Get Health Status --->
				
				<cfif  session.esi_ratehealth eq 'esi_ratehealth_excellent' or session.esi_ratehealth eq 'esi_ratehealth_verygood' >
					<cfset decreaseESIcost = true>
					<cfoutput>Health Adjustment: Decrease Costs <br>
					</cfoutput>
					<cfelseif session.esi_ratehealth neq 'esi_ratehealth_good' >
					<cfset decreaseESIcost = false>
					<cfoutput>Health Adjustment: Increase Costs <br>
					</cfoutput>
				</cfif>
				
				<!---GET ESI index for location--->
				
				<cfquery name="getESI" datasource="#application.dbSrc#">
select * from economicsecurityindex where county_id = #getcounty.county_id#
</cfquery>
				<cfif getESI.recordcount eq 0>
					<cfquery name="getESI" datasource="#application.dbSrc#" >
select * from economicsecurityindex where county_id = 1
</cfquery>
				</cfif>
				<cfdump var="#getESI#" label="ESI Index" expand="false">
				<!--- show calculations for monthly health costs--->
				<cfoutput>Out of Pocket Medical: #session.esi_healthmonthly# <br></cfoutput>
				<cfoutput>Age: #SESSION.diffYears# <br></cfoutput>
				<cfoutput>20 percent of gross monthly income:  #calcIncome# <br></cfoutput>
				<!---Get marital status for ESI - married or single --->
				
				<cfif session.esi_marital eq 'married'>
					<cfset married = true>
					<cfoutput>ESI Marital Status: Married <br>
					</cfoutput>
					<cfelse>
					<cfset married = false >
					<cfoutput>ESI Marital Status: Single<br>
					</cfoutput>
				</cfif>
				
				<!---Get Rental status for ESI  either Rent or Own Home --->
				
				<cfif session.esi_housingtype eq 'esi_housingtype_own'>
					<cfset own = true>
					<cfoutput>ESI Housing Status: Own Home<br>
					</cfoutput>
					<cfelse>
					<cfset own = false>
					<cfoutput>ESI Housing Status: Rent Home<br>
					</cfoutput>
				</cfif>
				
				<!---Get Rental status for ESI - Rent or Own Home --->
				
				<cfif session.esi_totaldebthouse gt 0>
					<cfset debt = true>
					<cfoutput>Home Debt Paid off :  No<br>
					</cfoutput>
					<cfelse>
					<cfset debt = false>
					<cfoutput>Home Debt Paid off : Yes<br>
					</cfoutput>
				</cfif>
				<cfset esiMonthlyIncomeByLocation = 1>
				
				<!---Choose ESI value from table --->
				
				<cfif married eq 'true' >
					<cfif own eq 'true' >
						<cfif debt eq 'true' >
							<cfset esiMonthlyIncomeByLocation = getESI.jointwithmortgage >
							<cfelse>
							<cfset esiMonthlyIncomeByLocation = getESI.jointwithoutmortgage >
						</cfif>
						<cfelse>
						<cfset esiMonthlyIncomeByLocation = getESI.jointrenter >
					</cfif>
					<cfelse>
					<cfif own eq 'true' >
						<cfif debt eq 'true' >
							<cfset esiMonthlyIncomeByLocation =  getESI.singlewithmortgage >
							<cfelse>
							<cfset esiMonthlyIncomeByLocation = getESI.singlewithoutmortgage >
						</cfif>
						<cfelse>
						<cfset esiMonthlyIncomeByLocation = getESI.singlerenter >
					</cfif>
				</cfif>
				<cfoutput>ESI Before Health Adjustment: #esiMonthlyIncomeByLocation# <br>
				</cfoutput> 
				
				<!---Adjust Average by Health Status ( add costs for bad health or decrease costs for good health  --->
				
				<cfif decreaseESIcost >
					<cfset esiMonthlyIncomeByLocation = esiMonthlyIncomeByLocation - getESI.Increasegoodhealth>
					<cfoutput>ESI Health Adjustment Decrease for Good Health: #getESI.Increasegoodhealth# <br></cfoutput> 
				<cfelseif session.esi_ratehealth neq 'esi_ratehealth_good' >
					<cfset esiMonthlyIncomeByLocation = esiMonthlyIncomeByLocation + getESI.DESCREASEBADHEALTH >
					<cfoutput>ESI Health Adjustment Incease for Bad Health: #getESI.DESCREASEBADHEALTH# <br></cfoutput> 
				</cfif>
				<cfoutput>ESI After Health Adjustment: #esiMonthlyIncomeByLocation# <br>
				</cfoutput> 
				
				<!---GET ESI Percentage--->
				<cfset esitotalincome = #session.esi_grossmonthlyincome# + #session.esi_currentvaluebenefits# >
				<cfset esiPercentage = (#session.esi_grossmonthlyincome# + #session.esi_currentvaluebenefits# )/ #esiMonthlyIncomeByLocation#  * 100 >
				<cfoutput>Gross Monthly Income Plus Benefits:  #esitotalincome#<br></cfoutput>
				<cfoutput>Calculate ESI Percentage: Gross Monthly Income  + Value of Benefits/ ESI <br>
				</cfoutput> <cfoutput>
					<h3>ESI Percentage: #esiPercentage# % </h3>
					<br>
				</cfoutput> 
				 <!--- Bug 6399 --->
                <cfoutput>
                <cfquery name="logesiPercentage" datasource="#application.dbSrc#">
        			INSERT INTO screening_answerfield
            		(screening_id, answerfield_id, responsetype, response, pagenum, derived_flag, submit_datetime)
        			VALUES
            		(#session.screening.id#, 6664, 1, #esiPercentage#, 1, 1, #CreateODBCDateTime(Now())#)
    			</cfquery>
                </cfoutput>
                
				<!---FPL  derive poverty index based on number of household members --->
				
				<h3>FPL Calculation</h3>
				<cfset numFamMembers = session.esi_incomesupport>
				<cfif numFamMembers  eq 0 or numFamMembers eq ''>
					<cfset numFamMembers = 1>
					<cfelseif numFamMembers gt 8>
					<cfset numFamMembers   = 8>
				</cfif>
				
				<!-- POVERTYINDEX=HH_INCOME_TOTAL_COMPLETE/poverylevel --> 
				<!-- povertylevel is retrieved from db, by using session.NO_HH_MEMBERS and tbl_id of 330 (HARDCODED !) --> 
				<!-- for now, hardcode it; otherwise retrieve from table (based on state, family members, etc.? ) -->
				
				<cfquery datasource="#application.dbSrc#" name="getPoverty">
			SELECT mem#numFamMembers# AS povLevel
			FROM tbl_inc_new 
			WHERE proc_id = 484
		</cfquery>
				<cfoutput>Monthly Poverty Level by Number of HH Members: #SESSION.esiPovertyLevel#<br>
				</cfoutput>
				<cfset SESSION.percentageFPL = #session.esi_grossmonthlyincome#/#SESSION.esiPovertyLevel# * 100>
				<cfoutput>% FPL  Monthly Gross Income/ Monthly Poverty Level: #SESSION.percentageFPL#<br>
				</cfoutput></td>
		</tr>
		<tr>
			<td>
			<br>
			<h3>ESI Points</h3>
			
			<cfscript>
				calculateESI(functionDebugging = true);
			</cfscript>
			<h3>ESI Total Points: <cfoutput>#SESSION.esiTotalPoints#</cfoutput></h3>
			<hr>	
            <!--- Bug 6399 --->
            <cfquery name="logESIPoints" datasource="#application.dbSrc#">
        		INSERT INTO screening_answerfield
            	(screening_id, answerfield_id, responsetype, response, pagenum, derived_flag, submit_datetime)
        		VALUES
            	(#session.screening.id#, 6663, 1, #SESSION.esiTotalPoints#, 1, 1, #CreateODBCDateTime(Now())#)
    		</cfquery>		
			</td>
		</tr>
	</table>
<br><br--->
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

<cfinclude template="procESIShadow.cfm">