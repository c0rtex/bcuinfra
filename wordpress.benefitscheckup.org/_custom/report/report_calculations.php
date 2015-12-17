<?php
require_once('_custom/soap_client.php');
require_once('_custom/displaycontent.php');
//echo '<h3>testing</h3>';
$cats2 = array(
"income" => "bcu_quickcheck_report_heading_income", 
"veteran"  => "bcu_quickcheck_report_heading_veteran", 
"taxrelief" => "bcu_quickcheck_report_heading_taxrelief",
"foodsupp" => "bcu_quickcheck_report_heading_foodsupp",
"nutrition" => "bcu_quickcheck_report_heading_nutrition",
"rxgov" => "bcu_quickcheck_report_heading_rx",
"medicaid" => "bcu_quickcheck_report_heading_medicaid"
);
//print_r($cats2 );

$cats = $soapClient->getSubCats(93);
//print_r($cats );	
//echo $screeningID;
$fields = $soapClient->getAFShadow($screeningID );
//print_r($fields);	
					foreach ($fields as $f => $row)
					{
						if ($row["ANSWERFIELD"] == 'zip') {
						$zip = $row["RESPONSE"];
						//echo "zip".$zip;			
						}
						if ($row["ANSWERFIELD"] == 'county') {
						$county = $row["RESPONSE"];
						//echo "county".$county;			
						}

					}	


$location = $soapClient->getStateDetails($zip,1);
//print_r($location);						 
$state_id = $location[0]["STATE_ID"];				
//echo "state_id".$state_id;
$functionDebugging = "false"; // Debugging on = true and Debugging off = false

/* 5017990, 5018048, 5017788, 5017774, 5017603 */
$screeningID = 5051454; 
if (isset($_GET['screeningID']))
{
//echo "ScreeningID from questionnaire:".$_GET['screeningID'];
$screeningID = $_GET['screeningID'];
}
$shadowID = $screeningID;
if (isset($_GET['shadowID']))
{
//echo "ScreeningID from questionnaire:".$_GET['screeningID'];
$shadowID = $_GET['shadowID'];
}
					

function searchForId($id, $array){
	foreach ($array as $key => $val){
		if ($val["answerfield"] === $id){
			return $key;
		}
	}
	return null;
}

	//test
	$AFrow_index = searchForId('esi_category_retirement_planning', $AF_array);
	$esi_category_retirement_planning = false;
	if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y'))
	{
	//echo "testing......................esi_category_retirement_planning";
	$esi_category_retirement_planning = true;
	}
	$AFrow_index = searchForId('esi_category_consumer_protection', $AF_array);
	$esi_category_consumer_protection = false;
	if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y'))
	{
	//echo "testing......................esi_category_consumer_protection";
	$esi_category_consumer_protection = true;
	}
	
	$AFrow_index = searchForId('esi_category_credit_debt_management', $AF_array);
	$esi_category_credit_debt_management = false;
	if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y'))
	{
	//echo "testing......................esi_category_credit_debt_management";
	$esi_category_credit_debt_management = true;
	}
	$AFrow_index = searchForId('esi_category_employment_training', $AF_array);
	$esi_category_employment_training = false;
	if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y'))
	{
	//echo "testing......................esi_category_employment_training";
	$esi_category_employment_training = true;
	}
	$AFrow_index = searchForId('esi_category_health_resources', $AF_array);
	$esi_category_health_resources = false;
	if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y'))
	{
	//echo "testing......................esi_category_health_resources";
	$esi_category_health_resources = true;
	}
	
	$AFrow_index = searchForId('esi_category_homeowner_resources', $AF_array);
	$esi_category_homeowner_resources = false;
	if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y'))
	{
	//echo "testing......................esi_category_homeowner_resources";
	$esi_category_homeowner_resources = true;
	}
	$AFrow_index = searchForId('esi_category_legal_resources', $AF_array);
	$esi_category_legal_resources = false;
	if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y'))
	{
	//echo "testing......................esi_category_legal_resources";
	$esi_category_legal_resources = true;
	}
	$AFrow_index = searchForId('esi_category_money_management', $AF_array);
	$esi_category_money_management = false;
	if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y'))
	{
	//echo "testing......................esi_category_money_management";
	$esi_category_money_management = true;
	}
	//esi_category_renter_resources
	$AFrow_index = searchForId('esi_category_renter_resources', $AF_array);
	$esi_category_renter_resources = false;
	if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y'))
	{
	//echo "testing......................esi_category_renter_resources";
	$esi_category_renter_resources = true;
	}
					


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
$sectioncode = 'bcu_quickcheck_report_heading_veteran';
//show sections and program info
		foreach ($cats as $c => $row)
					{
						$cat_title = $row["CATEGORY_TITLE"];
						$sort_id = $row["SORT"];
						$cat_code = $row["CODE"];
						$programcategory_id = $row["PROGRAMCATEGORY_ID"];
						//echo $cat_code;
						if ($cat_code == 'veteran'){
						$sectioncode = 'bcu_quickcheck_report_heading_veteran';
						$iconcode = 'user';
						}
						elseif ($cat_code == 'taxrelief'){
						$sectioncode = 'bcu_quickcheck_report_heading_taxrelief';
						$iconcode = 'building';
						}
						
						elseif ($cat_code == 'foodsupp'){
						$sectioncode = 'bcu_quickcheck_report_heading_foodsupp';
						$iconcode = 'coffee';
						}

						elseif ($cat_code == 'nutrition'){
						$sectioncode = 'bcu_quickcheck_report_heading_nutrition';
						$iconcode = 'heart';
						}
						elseif ($cat_code == 'rxgov'){
						$sectioncode = 'bcu_quickcheck_report_heading_rx';
						$iconcode = 'medkit';
						}
						elseif ($cat_code == 'medicaid'){
						$sectioncode = 'bcu_quickcheck_report_heading_medicaid';
						$iconcode = 'ambulance';
						}
						elseif ($cat_code == 'income'){
						$sectioncode = 'bcu_quickcheck_report_heading_income';
						$iconcode = 'money';
						}
						$sectiontext = $soapClient->getWPPostByMetaTag($sectioncode);
						$sectionSummary = $sectiontext[0]["POST_CONTENT"];		
						//print_r($sectiontext);
						require('sections.php');
						//echo $cat_code.$programcategory_id;
						//echo $sort_id;
						//echo "<br>";
					}	

?>