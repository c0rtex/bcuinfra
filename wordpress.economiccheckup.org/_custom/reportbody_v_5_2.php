<?PHP
$functionDebugging = "false"; // Debugging on = true and Debugging off = false
//TBD - Need to move DB connections to DB help functions
$bcudb = new wpdb(DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU,DB_HOST_BCU);
$bcudb->show_errors();
$esi_zip = 0;
/* 5017990, 5018048, 5017788, 5017774, 5017603 */
$screeningID = 5020607; 
if (isset($_GET['screeningID']))
{
//echo "ScreeningID from questionnaire:".$_GET['screeningID'];
$screeningID = $_GET['screeningID'];
}
$shadowID = 5020608;
if (isset($_GET['shadowID']))
{
//echo "ScreeningID from questionnaire:".$_GET['screeningID'];
$shadowID = $_GET['shadowID'];
}

$query_getSAF = "SELECT a.answerfield, o.option_id, o.option_code, sa.response FROM answerfield a INNER JOIN screening_answerfield sa ON sa.answerfield_id = a.answerfield_id LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id WHERE sa.screening_id= ".$screeningID." ORDER BY sa.pagenum, a.answerfield, sa.submit_datetime";

$result = mysql_query($query_getSAF);

while($AFrow = mysql_fetch_assoc($result)){
	/* Inside while loop */
    $AF_array[] = $AFrow;
}

function searchForId($id, $array){
	foreach ($array as $key => $val){
		if ($val["answerfield"] === $id){
			return $key;
		}
	}
	return null;
}

$query_getPrograms = "select sp.program_id, p.programcategory_id, p.program_code, p.name_display_id from program p INNER JOIN screening_program sp ON sp.program_id = p.program_id where screening_id = ".$shadowID;
$result1 = mysql_query($query_getPrograms);
while($ProgramRow = mysql_fetch_assoc( $result1)){
    $Program_array[] = $ProgramRow;
}
// debug to show programcategory_ids returned for the shadow screening
/*foreach ($Program_array as $i => $row){
	echo $row["programcategory_id"]." | ";	
}*/

function age($month, $day, $year){
 $y = gmstrftime("%Y");
 $m = gmstrftime("%m");
 $d = gmstrftime("%d");
 $age = $y - $year;
 if($m <= $month)
 {
 if($m == $month)
 {
 if($d < $day) $age = $age - 1;
 }
 else $age = $age - 1;
 }
 return($age);
}

// Init Bar Chart Inc Totals (Used in both Married and Single Calculations)
    $Wages_Inc = 0;        
    $SS_Inc = 0;        
    $PB_Inc = 0;        
    $OtherNonWork_Inc = 0;
	$receiveTotal = 0;
	$FPL = 0;
	$totalMthlyInc = 0; 
	$irArray = array();
	$esiMonthlyIncomeByLocation = 0;
	
	$AFrow_index = searchForId('esi_marital', $AF_array);
	$esi_marital = "";
	if (isset($AF_array[$AFrow_index]["option_code"])){
		$esi_marital = $AF_array[$AFrow_index]["option_code"];	
	} 
	unset ($AFrow_index);
    
	// Array of Variable (names) needed for Income, Receive and Expenses related calculations
	$irArray = array("esi_incomesupport","esi_outofpocket","esi_healthmonthly","esi_food","esi_transportation","esi_other_expenses","esi_debtestimate","s_income_pri_retire","s_income_dividends","s_income_ssi","s_income_ss_disable","s_income_ss_retire","s_income_rr_ben","s_income_vet_ben","s_income_unemploy","s_income_tanf","s_income_cash_assist","s_income_other_nw","s_income_earned","s_income_unemployment","sp_income_pri_retire","sp_income_dividends","sp_income_ssi","sp_income_ss_disable","sp_income_ss_retire","sp_income_rr_ben","sp_income_vet_ben","sp_income_unemploy","sp_income_tanf","sp_income_cash_assist","sp_income_other_nw","sp_income_earned","sp_income_unemployment","s_sp_income_pri_retire_simple","s_sp_income_dividends_simple","s_sp_income_ssi_simple","s_sp_income_ss_disable_simple","s_sp_income_ss_retire_simple","s_sp_income_rr_ben_simple","s_sp_income_vet_ben_simple","s_sp_income_unemploy_simple","s_sp_income_tanf_simple","s_sp_income_cash_assist_simple","s_sp_income_other_nw_simple","s_sp_income_earned_simple","s_sp_income_unemployment_simple","hh_income_pri_retire_simple","hh_income_dividends_simple","hh_income_ssi_simple","hh_income_ss_disable_simple","hh_income_ss_retire_simple","hh_income_rr_ben_simple","hh_income_vet_ben_simple","hh_income_unemployment_simple","hh_income_unemploy_simple","hh_income_tanf_simple","hh_income_cash_assist_simple","hh_income_other_nw_simple","hh_income_earned_simple","receive_msp_amount","receive_lis_amount","receive_snap_amount","receive_liheap_amount","receive_medicaid_amount","receive_property_tax_amount");
	
	// Create and Initialize all Variables to 0 initially
	for ($i = 0; $i < count($irArray); ++$i) {
		${$irArray[$i]} = 0;	
	}
	
	// Set User Input Values to All Variables 
	for ($i = 0; $i < count($irArray); ++$i) {
		$AFrow_index = searchForId($irArray[$i], $AF_array);
		if (isset($AF_array[$AFrow_index]["response"]) && ($AF_array[$AFrow_index]["response"] <> "") && ($AF_array[$AFrow_index]["response"] <> 0)){									    		${$irArray[$i]} = $AF_array[$AFrow_index]["response"];
		}
	}
	
    // Single esi_grossmonthly and esi_currentvaluebenefits income calculations (sum self and household income values) 
    if (($esi_marital == "single") || ($esi_marital == "divorced") || ($esi_marital == "widowed") || ($esi_marital == "married_living_sep") || ($esi_marital == "esi_living_with_partner")){
    	$totalMthlyInc = $s_income_pri_retire + $s_income_dividends + $s_income_ssi + $s_income_ss_disable + $s_income_ss_retire + $s_income_rr_ben + $s_income_vet_ben + $s_income_unemploy + $s_income_tanf + $s_income_cash_assist + $s_income_other_nw + $s_income_earned + $s_income_unemployment + $hh_income_pri_retire_simple + $hh_income_dividends_simple + $hh_income_ssi_simple + $hh_income_ss_disable_simple + $hh_income_ss_retire_simple + 
$hh_income_rr_ben_simple + $hh_income_vet_ben_simple + $hh_income_unemployment_simple + $hh_income_unemploy_simple + $hh_income_tanf_simple + $hh_income_cash_assist_simple + $hh_income_other_nw_simple + $hh_income_earned_simple;
	}
    		
    // Married esi_grossmonthly and esi_currentvaluebenefits income calculations (sum self, spouse, joint and household income values)
    else {
    	$totalMthlyInc = $s_income_pri_retire + $s_income_dividends + $s_income_ssi + $s_income_ss_disable + $s_income_ss_retire + $s_income_rr_ben + $s_income_vet_ben + $s_income_unemploy + $s_income_tanf + $s_income_cash_assist + $s_income_other_nw + $s_income_earned + $s_income_unemployment + $sp_income_pri_retire + $sp_income_dividends + $sp_income_ssi + $sp_income_ss_disable + $sp_income_ss_retire + $sp_income_rr_ben + $sp_income_vet_ben + $sp_income_unemploy + $sp_income_tanf + $sp_income_cash_assist + $sp_income_other_nw + $sp_income_earned + $sp_income_unemployment + $s_sp_income_pri_retire_simple + $s_sp_income_dividends_simple + $s_sp_income_ssi_simple + $s_sp_income_ss_disable_simple + $s_sp_income_ss_retire_simple + $s_sp_income_rr_ben_simple + $s_sp_income_vet_ben_simple + $s_sp_income_unemploy_simple + $s_sp_income_tanf_simple + $s_sp_income_cash_assist_simple + $s_sp_income_other_nw_simple + $s_sp_income_earned_simple + $s_sp_income_unemployment_simple + $hh_income_pri_retire_simple + $hh_income_dividends_simple + $hh_income_ssi_simple + $hh_income_ss_disable_simple + $hh_income_ss_retire_simple + 
$hh_income_rr_ben_simple + $hh_income_vet_ben_simple + $hh_income_unemployment_simple + $hh_income_unemploy_simple + $hh_income_tanf_simple + $hh_income_cash_assist_simple + $hh_income_other_nw_simple + $hh_income_earned_simple;
	}
	
	// Array of Variable (names) needed for Asset related calculations
	$assArray = array("s_asset_cash", "s_asset_auto1", "s_asset_auto2", "s_asset_home", "s_asset_retirement", "s_asset_stocks", "s_asset_life_cash", "s_asset_life_face", "s_asset_revocable", "s_asset_irrevocable", "s_asset_other", "sp_asset_cash", "sp_asset_auto1", "sp_asset_auto2", "sp_asset_home", "sp_asset_retirement", "sp_asset_stocks", "sp_asset_life_cash", "sp_asset_life_face", "sp_asset_revocable", "sp_asset_irrevocable", "sp_asset_other", "s_sp_asset_cash_simple", "s_sp_asset_auto1_simple", "s_sp_asset_auto2_simple", "s_sp_asset_home_simple", "s_sp_asset_retirement_simple", "s_sp_asset_stocks_simple", "s_sp_asset_life_cash_simple", "s_sp_asset_life_face_simple", "s_sp_asset_revocable_simple", "s_sp_asset_irrevocable_simple", "s_sp_asset_other_simple", "hh_asset_cash_simple", "hh_asset_auto1_simple", "hh_asset_auto2_simple", "hh_asset_home_simple", "hh_asset_retirement_simple", "hh_asset_stocks_simple", "hh_asset_life_cash_simple", "hh_asset_life_face_simple", "hh_asset_revocable_simple", "hh_asset_irrevocable_simple", "hh_asset_other_simple");
	
	// Set User Input Values to All Asset Variables and get totalAssets amount
	$totalAssets = 0;
		
	for ($k = 0; $k < count($assArray); ++$k) {
		$AFrow_index = searchForId($assArray[$k], $AF_array);
		if (isset($AF_array[$AFrow_index]["response"]) && ($AF_array[$AFrow_index]["response"] <> "") && ($AF_array[$AFrow_index]["response"] <> 0)){									    		$varName = $assArray[$k];
			${$varName} = $AF_array[$AFrow_index]["response"];
		}
		else{ 
			$varName = $assArray[$k];
			${$varName} = 0;
		}
	}
	
	// Single Assets
	if (($esi_marital == "single") || ($esi_marital == "divorced") || ($esi_marital == "widowed") || ($esi_marital == "married_living_sep") || ($esi_marital == "esi_living_with_partner")){
		$totalAssets = $s_asset_cash + $s_asset_auto1 + $s_asset_auto2 + $s_asset_home + $s_asset_retirement + $s_asset_stocks + $s_asset_life_cash + $s_asset_life_face + $s_asset_revocable + $s_asset_irrevocable + $s_asset_other + $hh_asset_cash_simple + $hh_asset_auto1_simple + $hh_asset_auto2_simple + $hh_asset_home_simple + $hh_asset_retirement_simple + $hh_asset_stocks_simple + $hh_asset_life_cash_simple + $hh_asset_life_face_simple + $hh_asset_revocable_simple + $hh_asset_irrevocable_simple + $hh_asset_other_simple;
	}
	else{
		$totalAssets = $s_asset_cash + $s_asset_auto1 + $s_asset_auto2 + $s_asset_home + $s_asset_retirement + $s_asset_stocks + $s_asset_life_cash + $s_asset_life_face + $s_asset_revocable + $s_asset_irrevocable + $s_asset_other + $sp_asset_cash + $sp_asset_auto1 + $sp_asset_auto2 + $sp_asset_home + $sp_asset_retirement + $sp_asset_stocks + $sp_asset_life_cash + $sp_asset_life_face + $sp_asset_revocable + $sp_asset_irrevocable + $sp_asset_other + $s_sp_asset_cash_simple + $s_sp_asset_auto1_simple + $s_sp_asset_auto2_simple + $s_sp_asset_home_simple + $s_sp_asset_retirement_simple + $s_sp_asset_stocks_simple + $s_sp_asset_life_cash_simple + $s_sp_asset_life_face_simple + $s_sp_asset_revocable_simple + $s_sp_asset_irrevocable + $s_sp_asset_other_simple + $hh_asset_cash_simple + $hh_asset_auto1_simple + $hh_asset_auto2_simple + $hh_asset_home_simple + $hh_asset_retirement_simple + $hh_asset_stocks_simple + $hh_asset_life_cash_simple + $hh_asset_life_face_simple + $hh_asset_revocable_simple + $hh_asset_irrevocable_simple + $hh_asset_other_simple;
	}
	
	//Set Values Needed for Graph
	$AFrow_index = searchForId('esi_housingtype', $AF_array);
	if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == "esi_housingtype_own")){
		$own = "true";	
	} 
	else {
		$own = "false";
	}
	unset ($AFrow_index);
	
	$AFrow_index = searchForId('esi_totaldebthouse', $AF_array);
	if (isset($AF_array[$AFrow_index]["response"]) && ($AF_array[$AFrow_index]["response"] > 0)){
		$debt = "true";	
	} 
	else {
		$debt = "false";
	}
	unset ($AFrow_index);
	
	//-BEGIN Calculate ESI Percentage

	// use the zipcode to detect county
	$AFrow_index = searchForId('esi_zip', $AF_array);
	if (isset($AF_array[$AFrow_index]["response"])){
		$string_zip = "and z.zipcode = ".$AF_array[$AFrow_index]["response"];	
		$esi_zip = $AF_array[$AFrow_index]["response"];
	} 
	else {
		$string_zip = "and (1 = 0)";
	}
	unset ($AFrow_index);
	// Get County using zip
	$query_getCounty = "select z.zipcode, z.county_id, c.* from county c, zip z where c.county_id = z.county_id ".$string_zip;
	$result2 = mysql_query($query_getCounty);
	while($CountyRow = mysql_fetch_assoc($result2)){
    	$County_array[] = $CountyRow;
	}
	unset($result2);
	// Get the ESI Numbers based on County ID
	
	// GET Elder index for location
	$county = trim($County_array[0]["county_name"]);
	$modifiedCountyName = trim($County_array[0]["county_name"])." County";
	$state_id = trim($County_array[0]["state_id"]);
	$query2 = "select * from economicsecurityindex_v2 where county_name = '".$modifiedCountyName."' and state_id = '".$state_id."'";
	$result2 = mysql_query($query2);
	while($ESICountRow = mysql_fetch_assoc($result2)){
    	$ESICount_array[] = $ESICountRow;
	}
	$ESICT = count($ESICount_array);
	unset($result2);
	unset($query2);
				
	// Use State Elder Index Values if more than one record returned --->
	if ($ESICT > 1) {
		$query2 = "Select state_name from state where state_id = '".$state_id."'";
		$result2 = mysql_query($query2);
		while($FullStateNameRow = mysql_fetch_assoc($result2)){
    		$FullStateName_array[] = $FullStateNameRow;
		}
		unset($result2);
		unset($query2);
 		
		$trimmedFullStateName = trim($FullStateName_array[0]["state_name"]);
		$query2 = "select * from economicsecurityindex_v2 where state_id = '".$state_id."' and county_name = '".$trimmedFullStateName."'";
		$result2 = mysql_query($query2);
		while($ESIRow = mysql_fetch_assoc($result2)){
    		$ESI_array[] = $ESIRow;
		}
		unset($result2);
		unset($query2);
	}
	else {
		// Use National Elder Index Values if more 0 records returned
		if ($ESICT == 0) {
			$query_getESI = "select * from economicsecurityindex_v2 where economicsecurityindex_id = 3196";
			$result2 = mysql_query($query_getESI);
			while($ESIRow = mysql_fetch_assoc($result2)){
    			$ESI_array[] = $ESIRow;
			}
			unset($result2);
		}
		// Use State and County Specific Elder Index Values if one record returned
		else {
			$query2 = "select * from economicsecurityindex_v2 where county_name = '".$modifiedCountyName."' and state_id = '".$state_id."'";
			$result2 = mysql_query($query2);
			while($ESIRow = mysql_fetch_assoc($result2)){
    			$ESI_array[] = $ESIRow;
			}
			unset($result2);
			unset($query2);
		}
	}
	
	// Get marital status for ESI - married or single
	if ($esi_marital == "married"){ $married = "true"; }
	else { $married = "false";}
	
	if ($esi_incomesupport == 1) { //if 1 person in household
    	if ($own == "true") {
			if ($debt == "true") {
          		$esiMonthlyIncomeByLocation =  $ESI_array[0]["singlewithmortgage"]/12;
			}
			else {
              	$esiMonthlyIncomeByLocation = $ESI_array[0]["singlewithoutmortgage"]/12;
			}
		}
    	else {
			$esiMonthlyIncomeByLocation = $ESI_array[0]["singlerenter"]/12;
		}
	}
	else {
		if ($esi_incomesupport > 1) { // if 2 persons in household
			if ($own == "true") {
				if ($debt == "true") {
					$esiMonthlyIncomeByLocation = $ESI_array[0]["jointwithmortgage"]/12;
				}
				else {
					$esiMonthlyIncomeByLocation = $ESI_array[0]["jointwithoutmortgage"]/12;
				}
			}
			else {
				$esiMonthlyIncomeByLocation = $ESI_array[0]["jointrenter"]/12;
			}
		}
	}
    
	$AFrow_index = searchForId('esi_ratehealth', $AF_array);
	if (isset($AF_array[$AFrow_index]["option_code"])){
		$esi_ratehealth = $AF_array[$AFrow_index]["option_code"];	
	} 
	else {
		$esi_ratehealth = "";
	}
	unset ($AFrow_index);
	
	// Adjust Average by Health Status ( add costs for poor health or decrease costs for excellent health
	if ($esi_ratehealth == "esi_ratehealth_excellent") {
		if (empty($ESI_array[0]["increasegoodhealth"])) {
			$ESI_array[0]["increasegoodhealth"] = 0;
		}
		$esiMonthlyIncomeByLocation = $esiMonthlyIncomeByLocation - ($ESI_array[0]["increasegoodhealth"]/12);
		if ($functionDebugging == "true") {
    		echo "<p>Elder Income Decreased due to Excellent Health Rating</p>";
		}
	}
	else { 
		if ($esi_ratehealth == "esi_ratehealth_poor") {
			if (empty($ESI_array[0]["descreasebadhealth"])) {
				$ESI_array[0]["descreasebadhealth"] = 0;
			}
			$esiMonthlyIncomeByLocation = $esiMonthlyIncomeByLocation + ($ESI_array[0]["descreasebadhealth"]/12);
			if ($functionDebugging == "true") {
    			echo "<p>Elder Income Increase due to Poor Health Rating</p>";
			}
		}
		else { 
			if ($functionDebugging == "true") {
				echo"<p>Elder Income NOT Adjusted: Neither Excellent or Poor Health Statuses were selected.</p>";
			}
		}
	}
	
	// Total Value of Benefits to be used in Bar Graph
		// FPL Calculation
	$numFamMembers = $esi_incomesupport;
	if (($numFamMembers == 0) || ($numFamMembers == "")) {
        $numFamMembers = 1;
	}
	else {
		if ($numFamMembers > 8){
        	$numFamMembers = 8;
		}
	}
    
	$columnName = "mem".$numFamMembers;
	
    $query_getPoverty = "SELECT ".$columnName." FROM tbl_inc_new WHERE proc_id = 484 LIMIT 0, 1";
	$result2 = mysql_query($query_getPoverty);
	while($PovertyRow = mysql_fetch_assoc($result2)){
    	$Poverty_array[] = $PovertyRow;
	}
    $FPL = $Poverty_array[0][$columnName];
	if ($functionDebugging === 'true') {
        echo "<p>FPL: ".$FPL."</p>";
	}
		
	$receiveTotal = 0;
    if ($receive_msp_amount == "") {
		$receive_msp_amount = 0;
	}
	if ($receive_lis_amount == "") {
		$receive_lis_amount == 0;
	}
    if ($receive_snap_amount == "") {
		$receive_snap_amount = 0;
	}
    if ($receive_liheap_amount == "") {
		$receive_liheap_amount = 0;
	}
    if ($receive_medicaid_amount == "") {
		$receive_medicaid_amount = 0;
	}
	if ($receive_property_tax_amount == "") {
		$receive_property_tax_amount = 0;
	}
	
	$receiveTotal = $receive_msp_amount + $receive_lis_amount + $receive_snap_amount + $receive_liheap_amount + $receive_medicaid_amount + $receive_property_tax_amount;
	$IncomeAndBenefits = $receiveTotal + $totalMthlyInc;
	$totalMthlyShortfall = $esiMonthlyIncomeByLocation - $IncomeAndBenefits;
	
	//Expenses Calculation
	$esi_outofpocket = 0; 
	$esi_food = 0; 
	$esi_healthmonthly = 0; 
	$esi_transportation = 0; 
	$esi_other_expenses = 0; 
	$esi_debtestimate = 0;
	
	$AFrow_index = searchForId('esi_outofpocket', $AF_array);
	if (isset($AF_array[$AFrow_index]["response"])){
		$esi_outofpocket = $AF_array[$AFrow_index]["response"];
	} 
	unset($AFrow_index);
	
	$AFrow_index = searchForId('esi_food', $AF_array);
	if (isset($AF_array[$AFrow_index]["response"])){
		$esi_food = $AF_array[$AFrow_index]["response"];
	} 
	unset($AFrow_index);
	
	$AFrow_index = searchForId('esi_healthmonthly', $AF_array);
	if (isset($AF_array[$AFrow_index]["response"])){
		$esi_healthmonthly = $AF_array[$AFrow_index]["response"];
	} 
	unset($AFrow_index);
	
	$AFrow_index = searchForId('esi_transportation', $AF_array);
	if (isset($AF_array[$AFrow_index]["response"])){
		$esi_transportation = $AF_array[$AFrow_index]["response"];
	} 
	unset($AFrow_index);
	
	$AFrow_index = searchForId('esi_other_expenses', $AF_array);
	if (isset($AF_array[$AFrow_index]["response"])){
		$esi_other_expenses = $AF_array[$AFrow_index]["response"];
	} 
	unset($AFrow_index);
	
	$AFrow_index = searchForId('esi_debtestimate', $AF_array);
	if (isset($AF_array[$AFrow_index]["response"])){
		$esi_debtestimate = $AF_array[$AFrow_index]["response"];
	} 
	unset($AFrow_index);
	
	$totalMthlyExp = $esi_outofpocket + $esi_food + $esi_healthmonthly + $esi_transportation + $esi_other_expenses + $esi_debtestimate;
	if ($FPL > $IncomeAndBenefits) {
		$totalMthlyShortfall = $esiMonthlyIncomeByLocation - $IncomeAndBenefits;
	}

	$basicNeeds = 0;
	if (($esi_incomesupport == 1) || ($esi_incomesupport == 2)){
		$basicNeeds = $esiMonthlyIncomeByLocation;
	}
	else {
		$basicNeeds = $FPL * 2;
	}
	
	// ESI Percentage
	$esiPercentage = 0;
	if ($esiMonthlyIncomeByLocation > 0) {
		$esiPercentage = ($IncomeAndBenefits / $basicNeeds) * 100;
		$esiPercentage = round($esiPercentage);
	}
	
	// Set Surplus or Shortfall legend language
	$overOrUnder = "Your Shortfall";
	if ($IncomeAndBenefits > $esiMonthlyIncomeByLocation) {
		$overOrUnder = "Your Surplus";	
	}
?>

<div class="span8" id="printContent">  
	<section id="currentstatus"> 
        <div class="body-header-wrapper">	<h2><i class="icon-bar-chart "></i> Your Current Status </h2>	
         <div class="body-header" style="z-index: 999;">
            	<div class="body-header-inner">
                	<div class="">
                        
                  	</div>
            	</div>
          	</div>
     		<div></div>
     	</div>
       	<div class="">
         	<div action="" method="get" id="commentForm" class="well cmxform">
          		<div>
					<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
                    <html xmlns="http://www.w3.org/1999/xhtml">
                      	<head>
                        	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
                        	<title>
                        	  	Your EconomicCheckUp Report
                        	</title>
                            <!--[if lte IE 8]>
                                <script language="javascript" type="text/javascript" src="/cf/js/flot/excanvas.min.js"></script>
                            <![endif]-->
                            <script type="text/javascript" src="/cf/js/flot/jquery.flot.min.js"></script>
                            <script type="text/javascript" src="/cf/js/flot/jquery.flot.time.js"></script>
                            <script type="text/javascript" src="/cf/js/flot/jquery.flot.symbol.js"></script>
                            <script type="text/javascript" src="/cf/js/flot/jquery.flot.axislabels.js"></script>
                            <script type="text/javascript" src="/cf/js/flot/jquery.flot.dashes.js"></script>
                            <script>
                                $(function() {
                            	$(document).ready(function() {
var canvasImg;
canvasImgCount = 0;
});
	
                                    var d4 = [
                                        [.5, <?php echo $totalMthlyInc; ?>]
                                    ];
                                    
                                    var d2 = [
                                        [.5, <?php echo $IncomeAndBenefits; ?>, <?php echo $totalMthlyInc; ?>]
                                    ];
                                    
                                    var d3 = [
                                        [2, <?php echo $totalMthlyExp; ?>] //Expenses
                                    ];
                            
                                    var d5 = [
                                        [0, <?php echo $basicNeeds; ?>],
                                        [5, <?php echo $basicNeeds; ?>]
                                    ];
                                    
                                    var d6 = [
                                        [0, <?php echo $IncomeAndBenefits; ?>],
                                        [5, <?php echo $IncomeAndBenefits; ?>]
                                    ];
                            
                                    var d9 = [
                                        [5, <?php $IncomeAndBenefits_offset = $IncomeAndBenefits + 25; echo $IncomeAndBenefits_offset; ?>]
                                    ];
								                                              
                                    var thePlot = $.plot($("#flot-placeholder"), [{
                                        data: d4,
                                        color: '#aebc37',
                                        label: 'Income',
                                        bars: {
                                            show: true,
                                            fill: 1
                                        }
                                    }, {
                                        data: d2,
                                        color: '#fdb813',
                                        label: 'Benefits',
                                        bars: {
                                            show: true,
                                            fill: 1
                                        }
                                    }, {
                                        data: d3,
                                        color: '#f47735',
                                        label: 'Expenses',
                                        bars: {
                                            show: true,
                                            fill: 1
                                        }
                                    },{
                                        data: d5,
                                        color: '#00468b',
                            yaxis: 2,
                                        stack: null,
                                        dashes:{show:true}
                                    },{
                                        data: d6,
                                        color: '#00468b',
                            yaxis: 2,
                                        stack: null,
                                        dashes:{show:false}
                                    }, {
                                        data: d9,
                                        color: 'rgba(255, 255, 255, 0.5)',
                                        label: '<?php echo $overOrUnder; ?>',
                                        bars: {
                                            show: true,
                                            fill: 0.5,
                                            horizontal: true,
                                            barWidth: <?php echo $totalMthlyShortfall; ?>
                                        }
                                    }], {
                                        series: {
                                            stack: true,
                                        },
                                        grid: {
                                            backgroundColor: {
                                                colors: ["#ccdae8", "#ccdae8"]
                                            }
                            
                                        },
                                        legend: {
                                            position: "se",
                                            position: "ne",
                                            backgroundOpacity: 0.75	
                                        },
                                        xaxis: {
                                            font: {size: 12, style: "italic", weight: "bold", color: "black"},
                                            ticks: [
                                                [1, 'Income &amp; Benefits<BR />$<?php echo $IncomeAndBenefits; ?>'],
                                                [2.5, 'Expenses<BR />$<?php echo $totalMthlyExp; ?>']
                                            ]
                                        },
					   

                                        yaxes: [
                                            {
                                                ticks: [
                                                    [0, '$0'],
                                                    [500, ''],
                                                    [1000, '$1000'],
                                                    [1500, ''],
                                                    [2000, '$2000'],
                                                    [2500, ''],
                                                    [3000, '$3000'],
                                                    [3500, ''],
                                                    [4000, '$4000'],
                                                    [4500, ''],
                                                    [5000, '$5000']
                                                ]
                                             },
                                            {
                                                position: "right",
                                                font: {size: 12, style: "italic", weight: "bold", color: "#00468b"},
                                                ticks: [
                                                    [0, ' '],
                                                    [500, ' '],
                                                    [1000, ' '],
                                                    [1500, ' '],
                                                    [2000, ' '],
                                                    [2500, ' '],
							   						[3000, ' '],
                                                    [3500, ' '],
                                                    [3750, ' '],
                                                    [4000, ' '],
                                                    [4500, ' '],
                                                    [<?php echo $basicNeeds; ?>, 'Basic Needs * $<?php echo round($basicNeeds); ?>'],
													[<?php echo $IncomeAndBenefits; ?>, ''],
													[5000, ' ']
												]	
                                             }
                                        ],
                             canvas: false
                                    });

var theCanvas = thePlot.getCanvas();
canvasImg = theCanvas.toDataURL("image/png");
//console.log ("canvas img before pringing: "+canvasImg);
                                });
                            </script>


                  		</head>
                   		<body>
                     		<div id="flot-placeholder" style="width:550px;height:300px;margin:0 auto"></div>
                    	</body>
              		</html><br><small>* Basic needs means the amount needed to cover basic necessities.Basic necessities include housing, health care, transportation, food, and long-term care. Your measure of economic security was calculated using the Elder Index. You can find more on the Elder Index methodology designed by Wider Opportunities for Women and the Gerontology Institute at the University of Massachusetts Boston here: <a href="http://www.basiceconomicsecurity.org" target="_blank" >www.basiceconomicsecurity.org</a>. </small><p><br><a href=""><a data-toggle="modal" role="button" href="#learnmore">Learn More About Your Current Status</a></p>
              	</div>
            </div>
		</div>
	</section>
	<section id="recs">  	
        <div class="body-header-wrapper">	<h2><i class="icon-user-md "></i>  Recommendations </h2>	
          	<div class="body-header" style="z-index: 999;">
            	<div class="body-header-inner">
                	<div class="">
                        
                  	</div>
            	</div>
          	</div>
     		<div></div>
     	</div>
        <div class="">
	
	<div action="" method="get" id="commentForm" class="well cmxform">
	<?PHP
	//Rec - If income < expenses or income < elder index: 
       if (($IncomeAndBenefits < $esiMonthlyIncomeByLocation)||($IncomeAndBenefits < $totalMthlyExp ) ){
	echo "<p>You are not alone. There are many free and trusted programs that can help you get back on track with your finances. Let’s get started now!</p>";
	}
	else {
	//Rec - If income > expenses and income > elder index: 
	echo "<p>While you’re on track with your finances today, it’s important to stay on track. There are many free and trusted programs that can help you manage and meet your financial goals. Let’s get started now!</p>";
	}
	//echo "test location:".$county.$state_id.$esi_zip;
	?>
	</div>

	</div>
		
	</section>

	<section id="money">  	
        <div class="body-header-wrapper">	<h2><i class="icon-money "></i>  Money Management & Budgeting </h2>	
          	<div class="body-header" style="z-index: 999;">
            	<div class="body-header-inner">
                	<div class="">
                        
                  	</div>
            	</div>
          	</div>
     		<div></div>
     	</div>
        <div class="">
			<div action="" method="get" id="commentForm" class="well cmxform">
				<?php
					$money_recs_count = 0;
				
					// IMPORTANT: WHEN ADDING NEW POSTS, add to the bottom. DO NOT CHANGE the existing order.
					$money_recs = array( array('postid' => 2586, 'bcu' => 0, 'show' => 0),
						array('postid' => 2592, 'bcu' => 0, 'show' => 0),
						array('postid' => 2604, 'bcu' => 0, 'show' => 0),
                       	array('postid' => 2577, 'bcu' => 1, 'show' => 0),
						array('postid' => 2600, 'bcu' => 1, 'show' => 0),
                       	array('postid' => 2573, 'bcu' => 0, 'show' => 0),
                       	array('postid' => 10217, 'bcu' => 1, 'show' => 0),
                       	array('postid' => 2581, 'bcu' => 0, 'show' => 0),
                       	array('postid' => 2596, 'bcu' => 0, 'show' => 0),
						array('postid' => 2609, 'bcu' => 0, 'show' => 0),
                       	array('postid' => 2613, 'bcu' => 0, 'show' => 0),
                       	array('postid' => 2617, 'bcu' => 0, 'show' => 0),
						array('postid' => 2620, 'bcu' => 0, 'show' => 0),
                       	array('postid' => 2623, 'bcu' => 0, 'show' => 0),
                       	array('postid' => 2630, 'bcu' => 0, 'show' => 0),
				array('postid' => 11445, 'bcu' => 1, 'show' => 0)
                     );  
					// SSI 11445
					$links_11445 = array();
					foreach ($Program_array as $i => $row)
					{
						$value = $row["program_code"];
						$searchIndex = strpos($value,'_ssi');
						if(is_numeric($searchIndex)){ 
							$money_recs[15]["show"] = 1;
							$links_11445[] = $row["program_id"];
							//echo $row["program_id"];
						} 
					}
					
					//print_r($links_11445);
					unset($i);
					unset($row);
					unset($searchIndex);
					unset($value);
					// Online Money Management Tool (post id = 2573)
					$AFrow_index = searchForId('esi_interest_budgeting', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[5]["show"] = 1;}
					unset($AFrow_index);
					
					// Federal Lifeline Program - BCU (post id = 2577)
					//print_r($Program_array);
					$link_up = 0;
					$reachout = 0;
					$links_2577 = array();
					foreach ($Program_array as $i => $row)
					{
						$value = $row["program_code"];
						$searchIndex = strpos($value,'safelink_wireless');
						$searchIndex3 = strpos($value,'_assurance_wireless');
						if(is_numeric($searchIndex)){ 
							$money_recs[3]["show"] = 1;
							$links_2577[] = $row["program_id"];
						} 
						
						if(is_numeric($searchIndex3)){ 
							$money_recs[3]["show"] = 1;
							$links_2577[] = $row["program_id"];
						} 
					
						if($value == 'utility_fd_lifeline_link_up'){ 
							$money_recs[3]["show"] = 1;
							$links_2577[] = $row["program_id"];
							$link_up = 1;
							//echo "<b>val:".$value.$link_up."</b><br>"; 
						} 
						$strPrgCode = "utility_".strtolower($state_id)."_safelink_wireless";
						if($value == $strPrgCode){ 
							$money_recs[3]["show"] = 1;
							$links_2577[] = 2395;
							$reachout = 1;
							//echo "<b>val:".$strPrgCode."</b><br>";
						} 
					}
					//print_r($links_2577);
					unset($i);
					unset($row);
					unset($searchIndex);
					unset($searchIndex2a);
					unset($searchIndex2b);
					unset($searchIndex3);
					unset($value);
					
					// Food and Nutrition Assistance - BCU (post id = 10217)
					$links_10217 = array();
					//print_r($Program_array);
					$foodsupp = 0;
					$tefap = 0;
					foreach ($Program_array as $i => $row)
					{
						$value = $row["program_code"];
						//echo $value."<br>";
						$searchIndex = strpos($value,'nutrition_');
						if(is_numeric($searchIndex)){ 
							$money_recs[6]["show"] = 1;
							$links_10217[] = $row["program_id"];
						} 
						
						if($value == "foodsupp_fd_sfmnp"){ 
							//echo $value;
							$money_recs[6]["show"] = 1;
							$links_10217[] = $row["program_id"];
							//echo "<b>val:foodsupp_fd_sfmnp</b><br>";
						}
						$prg_cd = 'foodsupp_'.strtolower($state_id).'_tefap';
						if($value == $prg_cd){ 
							//echo $value;
							$money_recs[6]["show"] = 1;
							$links_10217[] = $row["program_id"];
							//echo "<b>val:".$prg_cd."</b><br>";
						}
						$prg_cd = 'foodsupp_'.strtolower($state_id).'_commodity_supp';
						if($value == $prg_cd){ 
							//echo $value;
							$money_recs[6]["show"] = 1;
							$links_10217[] = $row["program_id"];
							//echo "<b>val:".$prg_cd."</b><br>";
						}
					}



					//print_r($links_10217);
					//echo "<b>val:".$money_recs[6]["show"]."</b><br>";
					unset($i);
					unset($row);
					unset($searchIndex);
					unset($searchIndex2);
					unset($value);
					
					//print_r($links_10217);
					//Local Food Bank (post id = 2581)
					$AFrow_index = searchForId('esi_basicneeds', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] != 'esi_notachallenge')){$money_recs[7]["show"] = 1;}
					unset ($AFrow_index);
					
					// Budget Calculator (post id = 2586)
					$AFrow_index = searchForId('esi_helpbalancing', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])&&($AF_array[$AFrow_index]["option_code"] == 'y')){$money_recs[0]["show"] = 1;}
					unset($AFrow_index);
					
					//Create a Budget  (post id = 2592)
					$AFrow_index = searchForId('esi_helpbalancing', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])&&($AF_array[$AFrow_index]["option_code"] == 'y')){$money_recs[1]["show"] = 1;}
					unset($AFrow_index);
					
					//Budgeting Assistance  (post id = 2596)
					$AFrow_index = searchForId('esi_helpbalancing', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])&&($AF_array[$AFrow_index]["option_code"] == 'y')){$money_recs[8]["show"] = 1;}
					unset($AFrow_index);
										
					// Pension Assistance (post id = 2600)
					$AFrow_index = searchForId('esi_interest_pension', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])&&($AF_array[$AFrow_index]["option_code"] == 'n')){
						$money_recs[4]["show"] = 1;
						$money_recs_count = ++$money_recs_count;
					}
				
					unset($AFrow_index);
				

					foreach ($Program_array as $i => $row)
					{
						$value = $row["program_code"];
						$searchIndex = strpos($value,'assistance_fd_pension_right_cntr');
						if(is_numeric($searchIndex)){ 
							$money_recs[4]["show"] = 1;
							$links_2600 = array();
							$links_2600[] = $row["program_id"];
						} 
					}
					unset($i);
					unset($row);
					unset($searchIndex);
					unset($value);
					
					// Retirement Plan  (post id = 2604)
					$AFrow_index1 = searchForId('esi_birth_month', $AF_array);
					$AFrow_index2 = searchForId('esi_birth_year', $AF_array);
					$userBirthMonth = $AF_array[$AFrow_index1]["response"];
					$userBirthYear = $AF_array[$AFrow_index2]["response"];
					$userAge = age($userBirthMonth,1,$userBirthYear); // Reuse User Age
					if ($functionDebugging == "true") {
    					echo "<p>User Age: ".$userAge."</p>";
					}
					$AFrow_index3 = searchForId('esi_retire_resources', $AF_array);
					if ((isset($AF_array[$AFrow_index3]["option_code"])) && $userAge > 50){$money_recs[2]["show"] = 1;}
					unset($AFrow_index1);
					unset($AFrow_index2);
					unset($AFrow_index3);
					
					// Financial Planning (post id = 2609)
					$AFrow_index = searchForId('esi_retire_planner', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[9]["show"] = 1;}
					unset ($AFrow_index);
										
					// Life Insurance (post id = 2613)
					$AFrow_index = searchForId('esi_retire_ins', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[10]["show"] = 1;}
					unset($AFrow_index);
					
					// Tax Preparation Assistance (post id = 2617)
					$AFrow_index = searchForId('esi_interest_tax', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[11]["show"] = 1;}
					unset ($AFrow_index);
					
					// Fraud (post id = 2620)
					$AFrow_index = searchForId('esi_interest_protect', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[12]["show"] = 1;}
					unset ($AFrow_index);
					
					// Banking (post id = 2623)
					$AFrow_index = searchForId('esi_interest_bank', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[13]["show"] = 1;}
					unset ($AFrow_index);
					
					// Coupon Websites (post id = 2630)
					$AFrow_index = searchForId('esi_interest_coupon', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[14]["show"] = 1;}
					unset($AFrow_index);
										
					// Show all 'Money Management & Budgeting' Recommendations flagged with show == 1
                    $num_money_recs = count($money_recs); // total possible recs in this section
					$money_recs_count = 0; // total recs to show based on responses.
                    for ($row = 0; $row < $num_money_recs; $row++)
                    {
						if (($money_recs[$row]["show"] == 1) && ( $money_recs[$row]["postid"] != 2600))                 
						{
							$money_recs_count = ++$money_recs_count;
							$current_id = $money_recs[$row]["postid"];
							$post = get_post($current_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "<BR />";
							if ($money_recs[$row]["bcu"] == 1)
							{
								if (isset(${"links_" . $money_recs[$row]["postid"]})) {
									foreach (${'links_'.$money_recs[$row]["postid"]} as $program_id)
									{
										$query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = ".$program_id." LIMIT 1";
										$programName_query = $bcudb->get_results($query_programName);
										foreach($programName_query as $programNameObj):
											$programTitle = $programNameObj->program_title;
											echo "<a href='/esi-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'><i class='icon-info-sign'></i></a> <a href='/esi-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'>".$programTitle."</a><BR />";
										endforeach;
									}
									unset($program_id);
									unset($query_getProgramName);
									unset($programName_query);
									unset($programNameObj);
									unset($programTitle);								
								}
							}
							
							echo "</p>";
							echo "</div>";
							
							unset($current_id);
							unset($post); 
							unset($title); 
							unset($desc);
						}
						else {
							if (($money_recs[$row]["show"] == 1) && $money_recs[$row]["postid"] == 2600) {
								$epgEpId = 0;
								$entrypointgroup_id = 456; 
								$epg_phone = "(651) 641-8612";
								$query_epgEp = "select e.entrypoint_id, zd.distance,p.number
														from entrypoint_entrypointgroup eg, entrypoint e, view_zip_distance zd, phone p
														where eg.entrypointgroup_id=".$entrypointgroup_id."
															and eg.entrypoint_id=e.entrypoint_id
															and e.active_flag=1
															and e.zipcode=zd.start_zipcode
															and zd.end_zipcode='".$esi_zip."'
															and zd.distance < 100
															and p.entrypoint_id=e.entrypoint_id
															and p.phonetype_id = 1
														union
														select e.entrypoint_id, 999999 distance,p.number
														from entrypoint_entrypointgroup eg, entrypoint e,phone p
														where eg.entrypointgroup_id=".$entrypointgroup_id."
															and eg.entrypoint_id=e.entrypoint_id
															and e.active_flag=1
															and e.zipcode is null
															and e.zipcode='".$esi_zip."'
															and p.entrypoint_id=e.entrypoint_id
															and p.phonetype_id = 1
														order by distance limit 1";
								$epgEp_query = $bcudb->get_results($query_epgEp);
								foreach($epgEp_query as $epgEpObj):
									$epgEpId = $epgEpObj->entrypoint_id;
								endforeach;
								$query_getEPGphone = "Select number from phone where entrypoint_id = $epgEpId and phonetype_id = 1 Limit 1";
								$getEPGphone_query = $bcudb->get_results($query_getEPGphone);
								foreach($getEPGphone_query as $epgEpObj4):
									$epg_phone = $epgEpObj4->number;
								endforeach;
								//echo ".$epg_phone.";
								echo "<div><h4>Pension Assistance</h4><p>PensionHelp America provides counselors who can answer questions about your pension or 401(k) plan. Learn more: <br>";
								
								if ($money_recs[$row]["bcu"] == 1)
								{
									if (isset(${"links_" . $money_recs[$row]["postid"]})) {
										foreach (${'links_'.$money_recs[$row]["postid"]} as $program_id)
										{
											$query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = ".$program_id." LIMIT 1";
											$programName_query = $bcudb->get_results($query_programName);
											foreach($programName_query as $programNameObj):
												$programTitle = $programNameObj->program_title;
												echo "<a href='/esi-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'><i class='icon-info-sign'></i></a> <a href='/esi-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'>".$programTitle."</a><BR />";
											endforeach;
										}
										unset($program_id);
										unset($query_getProgramName);
										unset($programName_query);
										unset($programNameObj);
										unset($programTitle);						
									}
								}
								echo "</p>";
								echo "</div>";
							}
						}
                    }
					unset($row);
					if ($money_recs_count == 0) {
						echo "<center><strong>You're doing a great job!</strong><BR />Based on your responses, we currently have no recommendations for you.</center>";
					}
					unset($money_recs_count);
                ?>
            </div>
        </div>
  	</section>
    <section id="housing">  	
        <div class="body-header-wrapper">	<h2><i class="icon-home "></i>  Housing </h2>	
            <div class="body-header" style="z-index: 999;">
                <div class="body-header-inner">
                    <div class="">
                        
                    </div>
                </div>
            </div>
            <div></div>
        </div>
        <div class="">
        	<div action="" method="get" id="commentForm" class="well cmxform">
                <?php
					// IMPORTANT: WHEN ADDING NEW POSTS, add to the bottom. DO NOT CHANGE the existing order.
                    $housing_recs = array( array('postid' => 2686, 'bcu' => 0, 'show' => 0),
						array('postid' => 2657, 'bcu' => 1, 'show' => 0),
                       array('postid' => 2662, 'bcu' => 1, 'show' => 0),
                       array('postid' => 2665, 'bcu' => 1, 'show' => 0),
                       array('postid' => 2669, 'bcu' => 1, 'show' => 0),
                       array('postid' => 2637, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2642, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2645, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2648, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2652, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2680, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2692, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2695, 'bcu' => 0, 'show' => 0)
                     );
					
					// Foreclosure (post id 2637 and post id 2642)
					// Reverse Mortgage Counseling (post id 2648)
					// Home Owner's Insurance (post id 2652)
					$req1 = 0; // 62 or older
					$req2 = 0; // owns home
					$req3 = 0; // 62, owns home and owes more than worth OR some equity but can't keep up with mthly bills
					$req4 = 0; // homeless or lives in a shelter
					$req5 = 0; // 62, owns home, paid off mortgage but have trouble paying other bills OR have some equity but can make paying other bills
					$req6 = 0; // owns home and doesn't have homeowner's insurance
					$req7 = 0; // rents
					
					if ($userAge >= 62){$req1 = 1;}
					$AFrow_index2 = searchForId("esi_housingtype", $AF_array);
					if (isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] == "esi_housingtype_own")){$req2 = 1;}
					$AFrow_index3 = searchForId("esi_housingsituation", $AF_array);
					if ((isset($AF_array[$AFrow_index3]["option_code"]) && (($AF_array[$AFrow_index3]["option_code"] == "esi_housing_someequity")) || ($AF_array[$AFrow_index3]["option_code"]) == "esi_housing_underwater")){$req3 = 1;}
					if ((isset($AF_array[$AFrow_index3]["option_code"]) && (($AF_array[$AFrow_index3]["option_code"] == "esi_housing_foreclosure")))){$req4 = 1;}
					if ((isset($AF_array[$AFrow_index3]["option_code"]) && (($AF_array[$AFrow_index3]["option_code"] == "esi_housing_mortgagepaid")) || ($AF_array[$AFrow_index3]["option_code"]) == "esi_housing_someequity")){$req5 = 1;}																				   
					$AFrow_index4 = searchForId("esi_homeinsurance", $AF_array);
					if ((isset($AF_array[$AFrow_index4]["option_code"]) && (($AF_array[$AFrow_index4]["option_code"] == "n")))){$req6 = 1;}
					if (isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] === "esi_housingtype_rent")){$req7 = 1;}
					//if (isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] === "esi_housingtype_homeless")){$req4 = 1;}
			
					// Qualifies for BCU Rental Assistance Program - post id 2657

					//must check for renting first		
					if ($req7 == 1) {
					$links_2657 = array();
					foreach ($Program_array as $i => $row)
					{
						$value = $row["program_code"];
						$searchIndex = strpos($value,'housing_fd_');
						if(is_numeric($searchIndex)){ 
							$housing_recs[1]["show"] = 1;
							
							$links_2657[] = $row["program_id"];
						} 
						$searchIndex = strpos($value,'rent');
						if(is_numeric($searchIndex)){ 
							$housing_recs[1]["show"] = 1;
							$links_2657[] = $row["program_id"];
						}
					}
					unset($i);
					unset($row);
					unset($searchIndex);
					unset($value);
					}
					// Qualifies for BCU Property Tax Assistance programs - post id 2662
					$links_2662 = array();
					foreach ($Program_array as $i => $row)
					{
						//echo "<b>val2:".$row["program_code"]."..".$row["programcategory_id"]."</b><br>";
						$value = $row["programcategory_id"];
						$searchIndex = strpos($value,'43');
						// Check if Property Tax Relief checked in assessment
						$AFrow_index = searchForId('receive_propertytax', $AF_array);
						$esi_propertytax_receive = 0;
						if (isset($AF_array[$AFrow_index]["option_code"])){
							$esi_propertytax_receive = 1;	
						}
						unset ($AFrow_index);
						$prg_code = $row["program_code"];
						$searchIndex = strpos($prg_code,'rent');
						if( ( $row["programcategory_id"] == 5) && ($esi_propertytax_receive == 0) && (! is_numeric($searchIndex)) ){ 
							$housing_recs[2]["show"] = 1;
							$links_2662[] = $row["program_id"];
						} 
						
						
					}
					//print_r($links_2662);
					unset($i);
					unset($row);
					unset($searchIndex);
					unset($value);
					
					// Qualifies for BCU Weatherization Programs - post id 2665
					foreach ($Program_array as $i => $row)
					{
						$value = $row["program_code"];
						$searchIndex = strpos($value,'weather');
						if(is_numeric($searchIndex)){ 
							$housing_recs[3]["show"] = 1;
							$links_2665 = array();
							$links_2665[] = $row["program_id"];
						} 
					}
					unset($i);
					unset($row);
					unset($searchIndex);
					unset($value);
					
					// Qualifies for BCU LIHEAP Programs - post id 2669
					foreach ($Program_array as $i => $row)
					{
						$value = $row["program_code"];
						$searchIndex = strpos($value,'liheap');
						// Check if liheap checked in assessment
						$AFrow_index = searchForId('liheap_receive', $AF_array);
						$esi_liheap_receive = 0;
						if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'y')){
							$esi_liheap_receive = $AF_array[$AFrow_index]["option_code"];	
						} 
						unset ($AFrow_index);
						if((is_numeric($searchIndex)) && ($esi_liheap_receive == 0)){ 
							$housing_recs[4]["show"] = 1;
							$links_2669 = array();
							$links_2669[] = $row["program_id"];
						} 
					}
					unset($i);
					unset($row);
					unset($searchIndex);
					unset($value);				
									
					if ($req1 == 1 &&  $req2 == 1 &&  $req3 == 1){$housing_recs[5]["show"] = 1;}	// post id 2637
					if ($req1 == 1 &&  $req2 == 1 &&  $req4 == 1){$housing_recs[6]["show"] = 1;}  // post id 2642
					if ($req1 == 1 &&  $req2 == 1 &&  $req5 == 1){$housing_recs[8]["show"] = 1;}  // post id 2648
					if ($req2 == 1 &&  $req6 == 1){$housing_recs[9]["show"] = 1;}  // post id 2652
					//if ($req2 == 1) {$housing_recs[10]["show"] = 1;} // post id 2680 energy star
					if ($req7 == 1) {$housing_recs[1]["show"] = 1;} // post id 2657
					if ((isset($AF_array[$AFrow_index3]["option_code"]) && (($AF_array[$AFrow_index3]["option_code"] == "esi_housing_underwater")))){$housing_recs[11]["show"] = 1;} // post id 2692
					$AFrow_index5 = searchForId("esi_healthdisability", $AF_array);
					if ((isset($AF_array[$AFrow_index5]["option_code"]) && (($AF_array[$AFrow_index5]["option_code"] == "y") && ($req2 == 1)))){$housing_recs[12]["show"] = 1;} // post id 2695
					
					unset($AFrow_index3);
					unset($AFrow_index4);
					unset($AFrow_index5);
					unset($req1);
					unset($req2);
					unset($req3);
					unset($req4);
					unset($req5);
					unset($req6);
					unset($req7);
					unset($pid);
					unset($pcode);
					unset($value);
								
					// Homeless Intervention (post id 2645)
					$AFrow_index = searchForId('esi_housingtype', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])&&($AF_array[$AFrow_index]["option_code"] == 'esi_housingtype_homeless')){$housing_recs[7]["show"] = 1;}
					unset($AFrow_index);

					// Moving (post id 2686)
					$AFrow_index = searchForId('esi_interest_moving', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])&&($AF_array[$AFrow_index]["option_code"] == 'n')){$housing_recs[0]["show"] = 1;}
					unset($AFrow_index);

					// Energy (Disabled) (post id 2680)
					// $AFrow_index = searchForId('esi_housingtype', $AF_array);
					// if (isset($AF_array[$AFrow_index]["option_code"])&&($AF_array[$AFrow_index]["option_code"] == 'esi_housingtype_own')){$housing_recs[10]["show"] = 1;}
					// unset($AFrow_index);

					
					
					
										
		            // Show all 'Housing' Recommendations flagged with show == 1
                    $num_housing_recs = count($housing_recs); // total possible recs in this section
					$housing_recs_count = 0; // total recs to show based on responses.
                    for ($row = 0; $row < $num_housing_recs; $row++)
                    {
						if ($housing_recs[$row]["show"] == 1)                 
						{
							$housing_recs_count = ++$housing_recs_count;
							$current_id = $housing_recs[$row]["postid"];
							$post = get_post($current_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "<BR />";
							if ($housing_recs[$row]["bcu"] == 1)
							{
								if (isset(${"links_" . $housing_recs[$row]["postid"]})) {
									foreach (${'links_'.$housing_recs[$row]["postid"]} as $program_id)
									{
										$query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = ".$program_id." LIMIT 1";
										$programName_query = $bcudb->get_results($query_programName);
										foreach($programName_query as $programNameObj):
											$programTitle = $programNameObj->program_title;
											echo "<a href='/esi-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'><i class='icon-info-sign'></i></a> <a href='/esi-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'>".$programTitle."</a><BR />";
										endforeach;
									}
									unset($program_id);
									unset($query_getProgramName);
									unset($programName_query);
									unset($programNameObj);
									unset($programTitle);								}
							}
							echo "</p>";
							echo "</div>";
							
							unset($current_id);
							unset($post); 
							unset($title); 
							unset($desc);
						}
						
                    }
					unset($row);
					if ($housing_recs_count == 0) {
						echo "<center><strong>You're doing a great job!</strong><BR />Based on your responses, we currently have no recommendations for you.</center>";
					}
					unset($housing_recs_count);
                ?>
            </div>
      	</div>
    </section>
   	<section id="health">  	
		<div class="body-header-wrapper">	<h2><i class="icon-medkit "></i>  Health </h2>	
			<div class="body-header" style="z-index: 999;">
            	<div class="body-header-inner">
                	<div class="">
                        
                  	</div>
            	</div>
          	</div>
     		<div></div>
     	</div>
       	<div class="">
        	<div action="" method="get" id="commentForm" class="well cmxform">
                <?php
					$health_recs_count = 0;
				
					// IMPORTANT: WHEN ADDING NEW POSTS, add to the bottom. DO NOT CHANGE the existing order.
                    				$health_recs = array( array('postid' => 2705, 'bcu' => 1, 'show' => 0),
						array('postid' => 2709, 'bcu' => 1, 'show' => 0),
						array('postid' => 2712, 'bcu' => 1, 'show' => 0),
						array('postid' => 2698, 'bcu' => 0, 'show' => 0),
						array('postid' => 2701, 'bcu' => 0, 'show' => 0),
                       			array('postid' => 2715, 'bcu' => 0, 'show' => 0),
					   	array('postid' => 2720, 'bcu' => 0, 'show' => 0),
                       			array('postid' => 2724, 'bcu' => 0, 'show' => 0),
						array('postid' => 11443, 'bcu' => 1, 'show' => 0)
                    				 );
					//Medicaid 11443
					$links_11443 = array();
					foreach ($Program_array as $i => $row)
					{
						$value = $row["program_code"];
						$searchIndex = strpos($value,'_medicaid');
						if(is_numeric($searchIndex)){ 
							$health_recs[8]["show"] = 1;
							
							$links_11443[] = $row["program_id"];
						} 
					}
					//print_r($links_11443);
					unset($i);
					unset($row);
					unset($searchIndex);
					unset($value);

					// Mental Health (post id = 2698)
					$AFrow_index = searchForId('esi_depression', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"]) && (($AF_array[$AFrow_index]["option_code"] == "esi_depression_several") || ($AF_array[$AFrow_index]["option_code"] == "esi_depression_half") || ($AF_array[$AFrow_index]["option_code"] == "esi_depression_every"))){$health_recs[3]["show"] = 1;}
					unset($AFrow_index);
					
					// CDSMP (post id = 2701)
					$AFrow_index = searchForId('esi_ratehealth', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"]) && (($AF_array[$AFrow_index]["option_code"] == "esi_ratehealth_fair") || ($AF_array[$AFrow_index]["option_code"] == "esi_ratehealth_poor"))){$health_recs[4]["show"] = 1;}
					unset($AFrow_index);
					
					// Extra Help (post id = 2705)
					foreach ($Program_array as $i => $row)
					{
						$value = $row["program_code"];
						$searchIndex = strpos($value,'rxgov_fd_medicare_');
						if(is_numeric($searchIndex)){ 
							$health_recs[0]["show"] = 1;
							$links_2705 = array();
							$links_2705[] = $row["program_id"];
						} 
					}
					unset($i);
					unset($row);
					unset($searchIndex);
					unset($value);
					
					// Medicare Savings Program (post id = 2709)
					//health_az_mcs_qi
					//health_az_mcs_qmb
					//health_az_mcs_slmb
					//health_ct_msp_almb
					//health_fd_msp_qi
					//health_fd_msp_qmb
					//health_fd_msp_slmb
					$links_2709 = array();
					foreach ($Program_array as $i => $row)
					{
						$value = $row["program_code"];
						$cat_id = $row["programcategory_id"];
						$searchIndex = strpos($value,'_msp_');
						//echo "msp:".$value.$cat_id."<br>";
						if($cat_id == 9){ 
							$health_recs[1]["show"] = 1;
							$links_2709[] = $row["program_id"];
							//echo "msp:".$value.$cat_id."<br>";
						} 
					}
					unset($i);
					unset($row);
					unset($searchIndex);
					unset($value);
					
					// Prescription Drug Assistance (post id = 2712)
					$AFrow_index = searchForId('esi_rxhelp', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')){$health_recs[2]["show"] = 1;}
					unset($AFrow_index);
					
					// Medicare Health Insurance Assistance (post id = 2715)
					$req1 = 0;
					$req2 = 0;
					$healthExp = 0;
					$calcIncome = $totalMthlyInc * .2;
					$AFrow_index = searchForId('esi_hh_expenses', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$healthExp = $AF_array[$AFrow_index]["response"];}
					$AFrow_index2 = searchForId('esi_counselor', $AF_array);
					if ((($healthExp >= $calcIncome) && ($userAge >= 65)) || (isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] == 1))){$health_recs[5]["show"] = 1;
					$health_recs_count = ++$health_recs_count;}
					//$health_recs[5]["show"] = 1;
					unset($AFrow_index);
					unset($AFrow_index2);
					unset($calcIncome);
					
					// Aging Services (post id = 2720)
					if ($userAge >= 65){$health_recs[6]["show"] = 1;}
					
					// Area Agency on Aging (post id = 2724)
					//if ($userAge >= 60){$health_recs[7]["show"] = 1;}
					//echo "User Age:".$userAge;
					// Show all 'Health' Recommendations flagged with show == 1
                    $num_health_recs = count($health_recs); // total possible recs in this section
					$health_recs_count = 0; // total recs to show based on responses.
                    for ($row = 0; $row < $num_health_recs; $row++)
                    {
						if (($health_recs[$row]["show"] == 1) && ($health_recs[$row]["postid"] != 2724) && ($health_recs[$row]["postid"] != 2715))                
						{
							$health_recs_count = ++$health_recs_count;
							$current_id = $health_recs[$row]["postid"];
							$post = get_post($current_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "<BR />";
							//echo "links_" . $health_recs[$row]["postid"];
							if ($health_recs[$row]["bcu"] == 1)
							{
								
								if (isset(${"links_" . $health_recs[$row]["postid"]})) {
										
									foreach (${'links_'.$health_recs[$row]["postid"]} as $program_id)
									{
										//echo 'program'.$program_id;
										$query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = ".$program_id." LIMIT 1";
										$programName_query = $bcudb->get_results($query_programName);
										foreach($programName_query as $programNameObj):
											$programTitle = $programNameObj->program_title;
											echo "<a href='/esi-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'><i class='icon-info-sign'></i></a> <a href='/esi-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'>".$programTitle."</a><BR />";
										endforeach;
									}
									unset($program_id);
									unset($query_getProgramName);
									unset($programName_query);
									unset($programNameObj);
									unset($programTitle);								}
							}
							echo "</p>";
							echo "</div>";
							
							unset($current_id);
							unset($post); 
							unset($title); 
							unset($desc);
						}
						else {
							// Custom handler for AAA
							if (($health_recs[$row]["postid"] == 2724) && ($userAge >= 60) ) {
								$epgEpId = 0;
								$entrypointgroup_id = 1;
								// Proximity Zip search
								$query_epgEp_proximityZip = "select e.entrypoint_id, zd.distance, p.number
                                from entrypoint_entrypointgroup eg, entrypoint_zip ez, entrypoint e, view_zip_distance zd, phone p
                                where eg.entrypointgroup_id=1
                                    and eg.entrypoint_id=ez.entrypoint_id
                                    and ez.zipcode=".$esi_zip."
                                    and ez.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode=zd.start_zipcode
                                    and zd.end_zipcode=".$esi_zip."
                                union
                                select e.entrypoint_id, 999999 distance, p.number
                                from entrypoint_entrypointgroup eg, entrypoint e, entrypoint_zip ez, phone p
                                where eg.entrypointgroup_id=1
                                    and eg.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode is null
                                    and e.entrypoint_id=ez.entrypoint_id
                                    and ez.zipcode=".$esi_zip."
                                order by distance 
								LIMIT 1";
								$epgEp_proximityZip_query = $bcudb->get_results($query_epgEp_proximityZip);
								foreach($epgEp_proximityZip_query as $epgEpObj):
									$epgEpId = $epgEpObj->entrypoint_id;
									$epPhone = $epgEpObj->number;
								endforeach;						
								
								// Proximity County search
								$ctyID = 0;
								if (count($epgEp_proximityZip_query) == 0) {
									$query_ctyID = "select county_id from zip where zipcode=".$esi_zip." Limit 1";
									$results_ctyID = $bcudb->get_results($query_ctyID);
									foreach($results_ctyID as $ctyObj):
										$ctyID = $ctyObj->county_id;
									endforeach;
									
									$query_epgEp_proximityCounty = "select e.entrypoint_id, zd.distance, p.number
                                    from entrypoint_entrypointgroup eg, entrypoint_county ec, entrypoint e, view_zip_distance zd, phone p
                                    where eg.entrypointgroup_id=1
                                        and eg.entrypoint_id=ec.entrypoint_id
                                        and ec.county_id in (".$ctyID.")
                                        and ec.entrypoint_id=e.entrypoint_id
                                        and e.active_flag=1
                                        and e.zipcode=zd.start_zipcode
                                        and zd.end_zipcode=".$esi_zip."
                                    UNION
                                    select e.entrypoint_id, 999999 distance, p.number
                                    from entrypoint_entrypointgroup eg, entrypoint e, entrypoint_county ec, phone p
                                    where eg.entrypointgroup_id=1
                                        and eg.entrypoint_id=e.entrypoint_id
                                        and e.active_flag=1
                                        and e.zipcode is null
                                        and e.entrypoint_id=ec.entrypoint_id
                                        and ec.county_id in (".$ctyID.")
                                    order by distance 
									LIMIT 1";
									$epgEp_proximityCounty_query = $bcudb->get_results($query_epgEp_proximityCounty);						
									foreach($epgEp_proximityCounty_query as $epgEpObj):
										$epgEpId = $epgEpObj->entrypoint_id;
									endforeach;
								}
								// Proximity Radius search. Custom solution for issues with IL Counties Cook and Lake where zips exist cross county
								if(count($epgEp_proximityCounty_query == 0)){
									$query_epgEp_proximityRadius = "select e.entrypoint_id, p.number
                                    from entrypoint_entrypointgroup eg, entrypoint e, view_zip_distance zd, phone p
                                    where eg.entrypointgroup_id=1
                                        and eg.entrypoint_id=e.entrypoint_id
                                        and e.active_flag=1
                                        and e.zipcode=zd.start_zipcode
                                        and zd.start_state_id='IL'
                                        and zd.end_zipcode=".$esi_zip."
                                        and zd.distance <= 100
                                    order by zd.distance 
									LIMIT 1";
								$epgEp_proximityRadius_query = $bcudb->get_results($query_epgEp_proximityRadius);						
								foreach($epgEp_proximityRadius_query as $epgEpObj):
										$epgEpId = $epgEpObj->entrypoint_id;
								endforeach;	
								}
								if ($epgEpId > 0) {
									$query_getEPGphone = "Select number from phone where entrypoint_id = ".$epgEpId." and phonetype_id = 1 Limit 1";
									$getEPGphone_query = $bcudb->get_results($query_getEPGphone);
									foreach($getEPGphone_query as $phoneObj):
										$epPhone = $phoneObj->number;
									endforeach;	
								}
								echo "<div><h4>Area Agency on Aging</h4><p>Across the country, local Area Agencies on Aging provide services like food and nutrition assistance, home care, legal assistance, and health and mental health programs. Contact your local Area Agency on Aging at: ".$epPhone." to learn more about what's available in your community. You also can locate Area Agencies on Aging nationwide by visiting them online at <a href='http://www.tinyurl.com/AAADirectory' target='_blank'>tinyurl.com/AAADirectory</a>.</div>";
								$health_recs_count = ++$health_recs_count;
							}

							// Custom handler for SHIP
							$indexCounselor = searchForId('esi_counselor', $AF_array);
							$esi_counselor = 0;
							//echo "ship:".$indexCounselor;
							if (isset($AF_array[$indexCounselor]["option_code"]) && ($AF_array[$indexCounselor]["option_code"] == 'y')){$esi_counselor = 1;}
							$oneFifthMthlyInc = $totalMthlyInc/5;
							if (($health_recs[$row]["postid"] == 2715) && ((($esi_healthmonthly >= $oneFifthMthlyInc) && ($userAge >= 65)) || ($esi_counselor == 1))) {
								//echo "<h4>Ship Time</h4>";
								$epgEpId = 0;
								$entrypointgroup_id = 83;
								echo "<div><h4>Medicare Health Insurance Assistance</h4>The State Health Insurance Assistance Program (SHIP) is a free health insurance counseling program for all Medicare beneficiaries and their caregivers. Volunteer counselors can give you information on health benefits and make sure that you’re receiving all the benefits you qualify for.";
								
								// Get local EPG Office
								$query_epgEP = "select e.entrypoint_id, e.name, e.url, p.number
														from entrypoint_entrypointgroup eg, entrypoint e, phone p
														where eg.entrypointgroup_id=".$entrypointgroup_id."
															and eg.entrypoint_id=e.entrypoint_id
															and e.state_id in (select state_id from zip where zipcode='".$esi_zip."')
															and e.active_flag=1
															and p.entrypoint_id=e.entrypoint_id
															and p.phonetype_id = 4 limit 1";
								$epgEP_query = $bcudb->get_results($query_epgEP);
								foreach($epgEP_query as $epgEpObj):
									$epgEpId = $epgEpObj->entrypoint_id;
									$epgEpName = $epgEpObj->name;
									$epgEpUrl = $epgEpObj->url;
									$epgEpNumber = $epgEpObj->number;
									echo "<p><br>Contact ".$epgEpName." at ".$epgEpNumber." or get more information online: <a href='".$epgEpUrl."' target='_blank'>".$epgEpUrl."</a>.";
								endforeach;
								echo "</p></div>";
							}
						}
					}
					unset($row);
					if ($health_recs_count == 0) {
						echo "<center><strong>You're doing a great job!</strong><BR />Based on your responses, we currently have no recommendations for you.</center>";
					}
					unset($health_recs_count);
                ?>
            </div>
		</div>
    </section>
<section id="employment">  	
    	<div class="body-header-wrapper">	<h2><i class="icon-certificate "></i> Employment &#38; Training </h2>	
        	<div class="body-header" style="z-index: 999;">
            	<div class="body-header-inner">
                	<div class="">
                        
                  	</div>
            	</div>
          	</div>
     		<div></div>
     	</div>
       	<div class="">
        	<div action="" method="get" id="commentForm" class="well cmxform">
        		<?php
					$employment_recs_count = 0; // total recs to show based on responses.
					
					// IMPORTANT: WHEN ADDING NEW POSTS, add to the bottom. DO NOT CHANGE the existing order.
                    $employment_recs = array( array('postid' => 2744, 'bcu' => 0, 'show' => 0),
						array('postid' => 2747, 'bcu' => 0, 'show' => 0),
						array('postid' => 2751, 'bcu' => 0, 'show' => 0),
                       	array('postid' => 2728, 'bcu' => 0, 'show' => 0),
						array('postid' => 2734, 'bcu' => 0, 'show' => 0),
                       	array('postid' => 2738, 'bcu' => 0, 'show' => 0),
						array('postid' => 2742, 'bcu' => 0, 'show' => 0),
                     );
					
					// SCSEP (postid = 2728)
					$AFrow_index = searchForId('esi_seekingemployment_usehelp', $AF_array);
					$req1 = 1.25*$FPL;
					$req2 = 0;
					if (($totalMthlyInc <= $req1) && ($userAge >= 55)){$req2 = 1;}
					if ((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) && ($req2 == 1)){$employment_recs[3]["show"] = 1;
						$employment_recs_count = ++$employment_recs_count;
					}
					//$employment_recs[3]["show"] = 1;
					// One Stop (postid = 2734)
					$req3 = 0;
					if (($totalMthlyInc <= $req1) && ($userAge < 55)){$req3 = 1;}
					if ((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) && ($req3 == 1)){$employment_recs[4]["show"] = 1;}
					unset($AFrow_index);
					unset($req1);
					unset($req2);
					unset($req3);
					
					// Senior Companion (postid = 2738)
					// if total monthly income <= 200% of FPL and user selects anything for q13
					if ($functionDebugging == "true") {
    					echo "<p>totalMonthlyInc: ".$totalMthlyInc."</p>";
					}
					if ($userAge >= 55) {
					$req1 = 0;
					//echo "age:".$userAge;
					$AFrow_index1 = searchForId('esi_seekingemployment_usehelp', $AF_array);
					$AFrow_index2 = searchForId('esi_seekingemployment_refresher', $AF_array);
					$AFrow_index3 = searchForId('esi_seekingemployment_skillsassessment', $AF_array);
					$AFrow_index4 = searchForId('esi_seekingemployment_techhelp', $AF_array);
					if (isset($AF_array[$AFrow_index1]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'n')){$req1++;}
					if (isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] == 'n')){$req1++;}
					if (isset($AF_array[$AFrow_index3]["option_code"]) && ($AF_array[$AFrow_index3]["option_code"] == 'n')){$req1++;}
					if (isset($AF_array[$AFrow_index4]["option_code"]) && ($AF_array[$AFrow_index4]["option_code"] == 'n')){$req1++;}
					$req2 = 2*$FPL;
					//echo "test:".$req1;
					if (($req1 > 0) && ($totalMthlyInc <= $req2)){$employment_recs[5]["show"] = 1;}
					unset($AFrow_index);
					unset($req1);
					unset($req2);
					}
					// Learning Technology (postid = 2742)
					$AFrow_index = searchForId('esi_seekingemployment_techhelp', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')){$employment_recs[6]["show"] = 1;}
					unset($AFrow_index);
					
					// Skills Assessment (postid = 2744)
					$AFrow_index = searchForId('esi_seekingemployment_skillsassessment', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')){$employment_recs[0]["show"] = 1;}
					unset($AFrow_index);
					//echo "test:".$AF_array[$AFrow_index]["option_code"];

					// Job Training (postid = 2747)
					$AFrow_index = searchForId('esi_seekingemployment_refresher', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')){$employment_recs[1]["show"] = 1;}
					unset($AFrow_index);
					
					// Job Search (postid = 2751)
					$AFrow_index = searchForId('esi_seekingemployment_usehelp', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')){$employment_recs[2]["show"] = 1;}
					unset($AFrow_index);
					
					// Show all 'Employment and Training' Recommendations flagged with show == 1
					$num_employment_recs = count($employment_recs); // total possible recs in this section
					
                    for ($row = 0; $row < $num_employment_recs; $row++)
                    {
						if (($employment_recs[$row]["show"] == 1) && ($employment_recs[$row]["postid"] !== 2728))                
						{
							$employment_recs_count = ++$employment_recs_count;
							$current_id = $employment_recs[$row]["postid"];
							$post = get_post($current_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "<BR />";
							if ($employment_recs[$row]["bcu"] == 1)
							{
								if (isset(${"links_" . $employment_recs[$row]["postid"]})) {
									foreach (${'links_'.$employment_recs[$row]["postid"]} as $program_id)
									{
										$query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = ".$program_id." LIMIT 1";
										$programName_query = $bcudb->get_results($query_programName);
										foreach($programName_query as $programNameObj):
											$programTitle = $programNameObj->program_title;
											echo "<a href='/esi-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'><i class='icon-info-sign'></i></a> <a href='/esi-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'>".$programTitle."</a><BR />";
										endforeach;
									}
									unset($program_id);
									unset($query_getProgramName);
									unset($programName_query);
									unset($programNameObj);
									unset($programTitle);								}
							}
							echo "</p>";
							echo "</div>";
							if ($title == 'Senior Companion') {
								echo "<a href='/esi-factsheet/?program_id=144&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'><i class='icon-info-sign'></i></a> <a href='/esi-factsheet/?program_id=144&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'>Volunteer - Senior Companion Program (SCP)</a><BR />";
										

							}
							unset($current_id);
							unset($post); 
							unset($title); 
							unset($desc);
						}
						else {
							// Custom handler for SCSEP
							if (($employment_recs[$row]["postid"] == 2728) && ($employment_recs[3]["show"] == 1)) {
								$epgEpId = 0;
								$entrypointgroup_id = 286;
								$epg_phone = "(888)480-1527";
								$query_epgEp = "select e.entrypoint_id, zd.distance,p.number
														from entrypoint_entrypointgroup eg, entrypoint e, view_zip_distance zd, phone p
														where eg.entrypointgroup_id=".$entrypointgroup_id."
															and eg.entrypoint_id=e.entrypoint_id
															and e.active_flag=1
															and e.zipcode=zd.start_zipcode
															and zd.end_zipcode='".$esi_zip."'
															and zd.distance < 100
															and p.entrypoint_id=e.entrypoint_id
															and p.phonetype_id = 1
														union
														select e.entrypoint_id, 999999 distance,p.number
														from entrypoint_entrypointgroup eg, entrypoint e,phone p
														where eg.entrypointgroup_id=".$entrypointgroup_id."
															and eg.entrypoint_id=e.entrypoint_id
															and e.active_flag=1
															and e.zipcode is null
															and e.zipcode='".$esi_zip."'
															and p.entrypoint_id=e.entrypoint_id
															and p.phonetype_id = 1
														order by distance limit 1";
								$epgEp_query = $bcudb->get_results($query_epgEp);
								foreach($epgEp_query as $epgEpObj):
									$epgEpId = $epgEpObj->entrypoint_id;
								endforeach;
								$query_getEPGphone = "Select number from phone where entrypoint_id = ".$epgEpId." and phonetype_id = 1 Limit 1";
								$getEPGphone_query = $bcudb->get_results($query_getEPGphone);
								if (count($getEPGphone_query) == 1){
									$epg_phone = $getEPGphone_query->number;
								}
								echo "<div><h4>SCSEP</h4><p>The Senior Community Service Employment Program (SCSEP) can boost your income by helping you return to work. SCSEP offers training and community service jobs for older workers who are eligible. Learn more: 
								</p>";

								echo "<a href='/esi-factsheet/?program_id=148&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'><i class='icon-info-sign'></i></a> <a href='/esi-factsheet/?program_id=148&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'>Employment - Senior Community Service Employment Program (SCSEP)</a><BR />";
								
								echo "</div>";
							}
						}
                    }
					unset($row);
					if ($employment_recs_count == 0) {
						echo "<center><strong>You're doing a great job!</strong><BR />Based on your responses, we currently have no recommendations for you.</center>";
					}
					unset($employment_recs_count);
                ?>
           	</div>
      	</div>
  	</section>


	    	<section id="debt">  	
    	<div class="body-header-wrapper">	<h2><i class="icon-credit-card "></i> Debt &#38; Credit </h2>	
        	<div class="body-header" style="z-index: 999;">
            	<div class="body-header-inner">
                	<div class="">
                        
                  	</div>
            	</div>
          	</div>
     		<div></div>
     	</div>
       	<div class="">
        	<div action="" method="get" id="commentForm" class="well cmxform">
        		<?php
					// IMPORTANT: WHEN ADDING NEW POSTS, add to the bottom. DO NOT CHANGE the existing order.
                    $debt_recs = array( array('postid' => 2754, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2758, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2761, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2763, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2766, 'bcu' => 0, 'show' => 0)
                     );
					
					// Credit Report (post id 2754) and Debt Consolidation (postid 2758)
					
					$req5 = 0;
					$AFrow_index1 = searchForId('esi_debtscenarios_creditlimit', $AF_array);
					$AFrow_index2 = searchForId('esi_debtscenarios_minimum', $AF_array);
					$AFrow_index3 = searchForId('esi_debtscenarios_creditors', $AF_array);
					$AFrow_index4 = searchForId('esi_debtscenarios_bankruptcy', $AF_array);
					$AFrow_index5 = searchForId('esi_helpbalancing', $AF_array);
					if((isset($AF_array[$AFrow_index1]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'n'))){$req1 = 1;}
					if((isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] == 'n'))){$req2 = 1;}
					if((isset($AF_array[$AFrow_index3]["option_code"]) && ($AF_array[$AFrow_index3]["option_code"] == 'n'))){$req3 = 1;}
					if((isset($AF_array[$AFrow_index4]["option_code"]) && ($AF_array[$AFrow_index4]["option_code"] == 'n'))){$req4 = 1;}
					$req5 = $req1 + $req2 + $req3 + $req4;
					if ((isset($AF_array[$AFrow_index5]["option_code"]) && ($AF_array[$AFrow_index5]["option_code"] == 'y')) || ($req5 > 0)){$debt_recs[0]["show"] = 1; $debt_recs[1]["show"] = 1;}
					unset($req1);
					unset($AFrow_index1);
					unset($AFrow_index2);
					unset($AFrow_index3);
					unset($AFrow_index4);
					unset($AFrow_index5);
					
					// Debt Management Services (postid = 2761)
					//if debt payments amt >= 50% of total annual income
					
					$DebtPayment = 0;
					$Income = $totalMthlyInc;
					$AFrow_index = searchForId('esi_debtestimate', $AF_array);
					if(isset($AF_array[$AFrow_index]["response"]) ){
					$DebtPayment = $AF_array[$AFrow_index]["response"];
					}
					//echo "debt items:".$req5;
					//echo "<br>Debt Payment:".$DebtPayment;
					//echo "<br>Income:".$Income;
					$debtRatio = $DebtPayment/$Income;
					if ($Income == 0 && $DebtPayment == 0) {
						$debtRatio = 0;
					}
					if ($DebtPayment == 0) {
						$debtRatio = 0;
					}
					//echo "<br> Debt Ratio:".$debtRatio;
					if($debtRatio  > .5){$debt_recs[2]["show"] = 1;} 
					if ($req5 > 0)  {
						$debt_recs[2]["show"] = 1;
					} 
					unset($AFrow_index);

					// Single house value calculations (sum self and household home values) 
    					if (($esi_marital == "single") || ($esi_marital == "divorced") || ($esi_marital == "widowed") || ($esi_marital == "married_living_sep") || ($esi_marital == "esi_living_with_partner")){
    					$totalHomeValue = ($s_asset_home + $hh_asset_home_simple) * .3;
					}
    					// Married home value calculations (sum self, spouse, joint and household home values)
    					else {
    					$totalHomeValue = ($s_asset_home + $sp_asset_home + $s_sp_asset_home_simple + $hh_asset_home_simple) * .3;
					}
					
					if($mthlyDebtPayment >= $totalHomeValue && $totalHomeValue > 0){
					$debt_recs[2]["show"] = 1;
					echo "<br>homevalue calc vs debt: greater than .3";
					} 
					unset($AFrow_index);
					unset($calcIncome);
										
					//Identity Theft (postid = 2763)
					// Avoiding Scams (postid = 2773)
					$AFrow_index = searchForId('esi_interest_protect', $AF_array);
					$AFrow_index1 = searchForId('esi_helpbalancing', $AF_array);
					$req1 = 0;
					$req2 = 0;
					if((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y'))){$req1 = 1;}
					if((isset($AF_array[$AFrow_index1]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'y'))){$req2 = 1;}
					$req3 = $req1 + $req2;
					if($req3 >= 1){$debt_recs[3]["show"] = 1;}
					unset ($AFrow_index);
					unset ($AFrow_index1);	
					unset ($req1);
					unset ($req2);
					unset ($req3);
					
					// Bankruptcy (postid = 2766)
					
					//$debt_recs[4]["show"] = 1;
					$AFrow_index = searchForId('esi_debtscenarios_bankruptcy', $AF_array);
					if(isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')){$debt_recs[4]["show"] = 1;}
					unset($AFrow_index);
					
                    // Show all 'Debt and Credit' Recommendations flagged with show == 1
					$num_debt_recs = count($debt_recs); // total possible recs in this section
					$debt_recs_count = 0; // total recs to show based on responses.
                    for ($row = 0; $row < $num_debt_recs; $row++)
                    {
						if ($debt_recs[$row]["show"] == 1)                 
						{
							$debt_recs_count = ++$debt_recs_count;
							$current_id = $debt_recs[$row]["postid"];
							$post = get_post($current_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "<BR />";
							if (($current_id == 2761) && ($totalAssets > 0)){
								 echo "<p>Be sure to discuss with your counselor how your assets could be used to eliminate debt.</p>";
							}
							if ($debt_recs[$row]["bcu"] == 1)
							{
								if (isset(${"links_" . $debt_recs[$row]["postid"]})) {
									foreach (${'links_'.$debt_recs[$row]["postid"]} as $program_id)
									{
										$query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = ".$program_id." LIMIT 1";
										$programName_query = $bcudb->get_results($query_programName);
										foreach($programName_query as $programNameObj):
											$programTitle = $programNameObj->program_title;
											echo "<a href='/esi-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'><i class='icon-info-sign'></i></a> <a href='/esi-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'>".$programTitle."</a><BR />";
										endforeach;
									}
									unset($program_id);
									unset($query_getProgramName);
									unset($programName_query);
									unset($programNameObj);
									unset($programTitle);								}
							}
							echo "</p>";
							echo "</div>";
							
							unset($current_id);
							unset($post); 
							unset($title); 
							unset($desc);
						}
						
                    }
					unset($row);
					if ($debt_recs_count == 0) {
						echo "<center><strong>You're doing a great job!</strong><BR />Based on your responses, we currently have no recommendations for you.</center>";
					}
					unset($debt_recs_count);
                ?>
           	</div>
      	</div>
  	</section>
    <section id="consumer"> 
    	<div class="body-header-wrapper">	<h2><i class="icon-lock "></i>  Consumer Protections </h2>	
			<div class="body-header" style="z-index: 999;">
            	<div class="body-header-inner">
                	
            	</div>
          	</div>
     		<div></div>
     	</div>
       	<div class="">
         	<div action="" method="get" id="commentForm" class="well cmxform">
                <?php
                    $consumer_recs = array( array('postid' => 2768, 'bcu' => 1, 'show' => 0),
                       array('postid' => 2771, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2773, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2775, 'bcu' => 0, 'show' => 0),
                       array('postid' => 2777, 'bcu' => 0, 'show' => 0),
			  array('postid' => 11583, 'bcu' => 0, 'show' => 0)
                     );
					
					// Legal Services (postid = 2768)
					
					$req4 = 0;
					$AFrow_index = searchForId('esi_retire_poa', $AF_array);
					$AFrow_index1 = searchForId('esi_interest_legal', $AF_array);
					$AFrow_index2 = searchForId('esi_retire_will', $AF_array);
					$req1 = 0;
					$req2 = 0;
					$req3 = 0;
					if((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))){$req1 = 1;}
					if((isset($AF_array[$AFrow_index1]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'n'))){$req2 = 1;}
					if((isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] == 'n'))){$req3 = 1;}
					$req4 = $req1 + $req2 + $req3;
					//if($req4 >= 1){$consumer_recs[0]["show"] = 1;}
					//echo "legal servcies:".$req4;
					unset ($req1);
					unset ($AFrow_index);
					unset ($AFrow_index1);
					
					foreach ($Program_array as $i => $row)
					{
						$value = $row["program_code"];
						$searchIndex = strpos($value,'legal_fd_legal_services_and_prog');
						if(is_numeric($searchIndex)){ 
							$consumer_recs[0]["show"] = 1;
							$links_2768 = array();
							$links_2768[] = $row["program_id"];
						} 
					}
					unset($i);
					unset($row);
					unset($searchIndex);
					unset ($pid);
					unset ($pcode);
					unset ($value);
					unset ($req1);
					unset ($AFrow_index1);
					unset ($AFrow_index2);
					unset ($AFrow_index3);


					//Legal Assistance Hotline  
					$AFrow_index = searchForId('esi_interest_legal', $AF_array);
					if ($userAge > 59){
					if((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))){$consumer_recs[5]["show"] = 1;}
					}
					unset($searchIndex);
					unset ($AFrow_index);
					
					// Power of Attorney (postid = 2771)
					$req3 = 0;
					$AFrow_index = searchForId('esi_retire_poa', $AF_array);
					$AFrow_index1 = searchForId('esi_interest_legal', $AF_array);
					$req1 = 0;
					$req2 = 0;
					if((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))){$req1 = 1;}
					if((isset($AF_array[$AFrow_index1]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'n'))){$req2 = 1;}
					$req3 = $req1 + $req2;
					if($req3 >= 1){$consumer_recs[1]["show"] = 1;}
					//echo "pow:".$req3;
					unset ($req1);
					unset ($AFrow_index);
					unset ($AFrow_index1);
					
				
					
					// Avoiding Scams (postid = 2773)
					$AFrow_index = searchForId('esi_interest_protect', $AF_array);
					$AFrow_index1 = searchForId('esi_helpbalancing', $AF_array);
					$req1 = 0;
					$req2 = 0;
					if((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))){$req1 = 1;}
					if((isset($AF_array[$AFrow_index1]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'y'))){$req2 = 1;}
					$req3 = $req1 + $req2;
					if($req3 >= 1){$consumer_recs[2]["show"] = 1;}
					unset ($AFrow_index);
					unset ($AFrow_index1);	
					unset ($req1);
					unset ($req2);
					unset ($req3);																																																								 					
					// Adult Protective Services (postid = 2775)
					$AFrow_index = searchForId('esi_interest_aps', $AF_array);
					if((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))){$consumer_recs[3]["show"] = 1;}
					unset($AFrow_index);																																		
																																			 
					// Writing a Will (postid = 2777)
					$AFrow_index = searchForId('esi_retire_will', $AF_array);
					if((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))){$consumer_recs[4]["show"] = 1;}
					unset($AFrow_index);
					
                   // Show all 'Consumer Protections' Recommendations flagged with show == 1
					$num_consumer_recs = count($consumer_recs); // total possible recs in this section
					$consumer_recs_count = 0; // total recs to show based on responses.
                    for ($row = 0; $row < $num_consumer_recs; $row++)
                    {
                        if ($consumer_recs[$row]["show"] == 1)                 
						{
							$consumer_recs_count = ++$consumer_recs_count;
							$current_id = $consumer_recs[$row]["postid"];
							$post = get_post($current_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "</p>";
							if ($title == 'Legal Services'){
							echo "<a href='/esi-factsheet/?program_id=160&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'><i class='icon-info-sign'></i></a> <a href='/esi-factsheet/?program_id=160&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'>Legal Services and Assistance Programs</a><BR />";
								
							}
							echo "</div>";
							if ($consumer_recs[$row]["bcu"] == 1)
							{
								if (isset(${"links_" . $consumer_recs[$row]["postid"]})) {
									foreach (${'links_'.$consumer_recs[$row]["postid"]} as $value)
									{
										$theResult = mysql_query("select display_text from display_language where language_id='EN' and display_id =".		$Program_array[$value]["name_display_id"]." LIMIT 0, 1");
										while($pnameRow = mysql_fetch_assoc($theResult)){
											$pname[] = $pnameRow;
										}
										echo "<a href='/esi-factsheet/?program_id=".$Program_array[$value]["program_id"]."&state_id=".$state_id."&county=".$county."&zip=".$esi_zip."&screeningID=".$screeningID."&shadowID=".$shadowID."'>".$pname[0]["display_text"]."</a>";
										echo "\r\n";
									}
									unset($value);
									unset($query_getProgramName);
									unset($theResult);
									unset($pnameRow);
									unset($pname);
								}
							}
						}
						
                    }
					unset($row);
					if ($consumer_recs_count == 0) {
						echo "<center><strong>You're doing a great job!</strong><BR />Based on your responses, we currently have no recommendations for you.</center>";
					}
					unset($consumer_recs_count);
                ?>
            </div>
		</div>
    </section>
    
</div> <!--span8-->
<div class="span4">
   	<div class="well sidebar-nav " style="z-index: 999; position: static; width:220px; top: 191px;">
        <legend><i class="icon-list-alt "></i> Your Report</legend>
        <ol class="nav nav-list">
	     <li class="active"><a href="#currentstatus"><i class="icon-bar-chart "></i> Current Status </a></li>
            <li class=""><a href="#recs"><i class="icon-user-md "></i> Recommendations </a></li>
            <li class=""><a href="#money"><i class="icon-money "></i> Money Mgmt &#38; Budgeting </a></li>
            <li class=""><a href="#housing"><i class="icon-home "></i> Housing </a></li>
            <li class=""><a href="#health"><i class="icon-medkit "></i> Health </a></li>
            <li class=""><a href="#employment"><i class="icon-certificate "></i> Employment &#38; Training </a></li>
            <li class=""><a href="#debt"><i class="icon-credit-card "></i> Debt &#38; Credit </a></li>
            <li class=""><a href="#consumer"><i class="icon-lock "></i> Consumer Protections </a></li>
        </ol><BR>
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
		<?PHP if(isset($screeningID)){echo '<li><a data-toggle="modal" role="button" href="/esi-questions/?screeningID='.$screeningID.'"><i class="icon-reply "></i> Want to Change Answers? </a></li>';
 		} ?>
        	<li><a data-toggle="modal" role="button" href="https://www.surveymonkey.com/s/3V39M9Z" target="_blank"><i class="icon-user "></i> Send Us Your Feedback</a></li>

            <li><form><a data-toggle="modal" role="button" href="#" onClick="canvasImgCount = canvasImgCount + 1;javascript:PrintDivCanvas(canvasImg, canvasImgCount);"><i class="icon-print "></i> Printable Report</a></form></li>
        </ol>		
    </div>	  
</div>
<div id="learnmore" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="Learn More" aria-hidden="true" style="display: none;">
  <div class="modal-header" style="border:none;">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close <i class="icon-remove"></i></button>

  </div>
  <div class="learnmoreModal_outer">
    <h2>More About Your Current Status</h2>
    <div id="infobox" class="whitewell learnmoreModal_inner">
    	<?PHP
	if (($IncomeAndBenefits < $esiMonthlyIncomeByLocation) && ($IncomeAndBenefits < $totalMthlyExp)){
	//If income below expenses and elder index
	echo '<p>Your income does not provide enough to meet your basic needs. It is tough to meet basic needs considering your cost of living in '.$modifiedCountyName.'. Without support, you are only going to be able to achieve '.$esiPercentage.'% of your economic security. There are public and private programs that can help.</p>';
	}
	//If income exceeds or is equal to expenses but is below the elder index
	elseif (($IncomeAndBenefits < $esiMonthlyIncomeByLocation) && ($IncomeAndBenefits > $totalMthlyExp || $IncomeAndBenefits == $totalMthlyExp)){
	echo '<p>You are able to cover your expenses but not all your basic needs. Without additional support you are at risk and will only be able to achieve '.$esiPercentage.'% of economic security for '.$modifiedCountyName.'. There are public and private programs that may be able to help. </p>';
	}
	//if income exceeds elder index but is below expenses 
	elseif (($IncomeAndBenefits > $esiMonthlyIncomeByLocation) && ($IncomeAndBenefits < $totalMthlyExp)){
		echo "<p>You can cover your basic needs, but not all your expenses. Without support, you are at risk. There are programs that may help you.</p>";
	}
	else {
	//If income > expenses and income > elder index: 
	echo '<p>You are in good financial health. Even so, we know one bump in the road can change everything. There are programs that are available that may help you avoid any pitfalls. We encourage you to re-visit us if anything about your situation changes. </p>';
	}
	?>
	
    	<div align="center" class="clearfix"><br><br><br><br><small>Note: Economic Security determination calculated using Wider Opportunities for Women's Elder Economic Security Standard&#8482; Index.</small><br /><BR /><a target="_blank" href="http://www.wowonline.org"><img border="0" alt="Wider Opportunities for Women" title="Wider Opportunities for Women" src="/cf/img/partners/economicsecurity/logo_wow.png"></a>
      	</div>
	
    </div>
  </div>

  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>
