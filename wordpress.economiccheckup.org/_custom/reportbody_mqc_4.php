<?PHP

if (isset($_GET["subset_id"])){
$subsetID = htmlspecialchars($_GET["subset_id"]);
}
else {
$subsetID = '79'; //needed for the soap client
}

require_once('_custom/soap_client.php');
$functionDebugging = "false"; // Debugging on = true and Debugging off = false
//TBD - Need to move DB connections to DB help functions
$bcudb = new wpdb(DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU,DB_HOST_BCU);
$bcudb->show_errors();
$state = 'california';
/* 5017990, 5018048, 5017788, 5017774, 5017603 */
$screeningID = -1; 
$showCalculator = 0;
$learnMore = 0;
$contentWaysCounter = 0;
$waysshown = 0;
$showbcu = 0;
if (isset($_GET['screeningID']))
{
//echo "ScreeningID from questionnaire:".$_GET['screeningID'];
$screeningID = $_GET['screeningID'];
}
$_SESSION['screeningID'] = $screeningID;
$shadowID = -1;
if (isset($_GET['shadowID']))
{
//echo "ScreeningID from questionnaire:".$_GET['screeningID'];
$shadowID = $_GET['shadowID'];
}
if (isset($_GET['request_id']))
{
//echo 
$request_id = $_GET['request_id'];
}
$reportkey = "screeningID=".$screeningID."&shadowID=".$shadowID."&request_id=".$request_id;
$_SESSION['reportkey'] = $reportkey;
//echo $reportkey;



    $AF_array = $soapClient->getSAF($screeningID);
    //$AF_array = restructureWSArray ($AF_array);

//echo "<pre>";
//print_r ($AF_array);



    $AFShadow_array = $soapClient->getAFShadow($shadowID);
    //$AFShadow_array = restructureWSArray ($AFShadow_array);


//echo "<pre>";
//print_r ($AFShadow_array);



function searchForId($id, $array){
	foreach ($array as $key => $val){
//echo "key: ";
//echo $key;
//echo "<br/> value: ";
//print_r ($val);
//echo "<br/> val[ANSWERFIELD]: ";
//echo $val["ANSWERFIELD"];
		if ($val["ANSWERFIELD"] === $id){
//echo "TRUE";
			return $key;
		}
	}
	return null;
}
$age_id = searchForId('dob', $AFShadow_array);
$age = $AFShadow_array[$age_id]["RESPONSE"];

// debug to show programcategory_ids returned for the shadow screening
$Program_array = $soapClient->getPrograms($shadowID);
//$Program_array = restructureWSArray($Program_array);
foreach ($Program_array as $i => $row){
	//echo $row["program_id"]." | ";	
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

// use the zipcode to detect county
	$AFrow_index = searchForId('mqc_zipcode', $AF_array);
	if (isset($AF_array[$AFrow_index]["RESPONSE"])){
		$string_zip = $AF_array[$AFrow_index]["RESPONSE"];
		$mqc_zipcode = $AF_array[$AFrow_index]["RESPONSE"];
		$_SESSION['zipcode'] = $mqc_zipcode;
		//echo $_SESSION['zipcode'];
		//echo "zip:".$mqc_zipcode.$_SESSION['zipcode'];
	} 
	else {
		$string_zip = "00000";
	}
	unset ($AFrow_index);
	// Get County using zip
//echo $string_zip;
$County_array = $soapClient->getCounty($string_zip);
//$County_array = restructureWSArray($County_array);
//echo "<pre>";
//print_r($County_array);
	$county = trim($County_array[0]["COUNTY_NAME"]);
	$modifiedCountyName = trim($County_array[0]["COUNTY_NAME"])." County";
	$state_id = trim($County_array[0]["STATE_ID"]);
	$state = trim($County_array[0]["STATE_NAME"]);
	$state_lower = strtolower($state);
	$state_lower = str_replace(" ", "-",$state_lower);
	$state_lower = str_replace(",", "",$state_lower);
	$county_title = ucwords(strtolower($county));
	//echo "zip:".$mqc_zip;
	//echo $county;
	


?>
<div class="span7" id="printContent"> 
<img alt="MedicareQuickCheck" title="MedicareQuickCheck" src="/wp-content/uploads/2014/10/Medicare-QuickCheck_logo_425x72.jpg">
	<section id="summary"> 
        <div class="body-header-wrapper">	<h2 id="summaryShow"> Summary  </h2>
         <div class="body-header" style="z-index: 999;">
            
          	</div>
     	</div>
       	
<div id="summaryShow_more">
         	<div  id="commentForm" class="well cmxform">
          		<div>
<?php require('report/summary_mqc_4.php');
//echo "testing:".$showSEP.$showIEP.$age3months;
require_once('affinity_client.php');
//log to click table...partner_id,partner_session_id,url_id,campaign_id,internal_flag,ahn_contact_flag,screening_id,click_id
$ws_click_id = $affinityClient->logAffinityClick(0,'',0,0,0,0,$screeningID,$_SESSION['click_id']);
?>				
              	</div>
            </div>		
<div>
	</section>
	<?php require_once('report/enrollment_chart.php') ?>
	<?php require_once('report/recommendation.php') ?>
    	<?php require_once('report/waystogethelp.php') ?>
</div>  	    	    
	    	    
<?php require_once('report/sidebar.php') ?>

<!--span7-->
</div>


