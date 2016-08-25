<?PHP

require_once('displaycontent.php');
$dataBridge2 = "false";
if (isset($_GET['databridge'])) {
    $dataBridge2 = $_GET['databridge'];
}

$questAnswers = "esi-questions";
$esiFactsheet = "esi-factsheet"; //esi factsheet url
$reportClient = $_SERVER['REQUEST_URI'];
//if ($reportClient == "/esi-results-eversafe" || $reportClient == "esi-results-eversafe"){
//if (preg_match('#^esi-results-eversafe#', $reportClient) === 1) { //so that urls with parameters are taken care of
if (substr($reportClient, 0, 27) == "/eversafe-quickcheck-report"){
//echo "YES";
$esiFactsheet = "esi-factsheet-eversafe"; //esi factsheet url
$questAnswers = "esi-questions-eversafe";
}
else {
//echo "NO";
//echo (substr($reportClient, 0, 27));
}

//echo "TEST ".$reportClient;



$functionDebugging = "false"; // Debugging on = true and Debugging off = false
//TBD - Need to move DB connections to DB help functions
$bcudb = new wpdb(DB_USER_BCU, DB_PASSWORD_BCU, DB_NAME_BCU, DB_HOST_BCU);
$bcudb->show_errors();
$esi_zip = 0;
/* 5017990, 5018048, 5017788, 5017774, 5017603 */
$screeningID = 5051454;
if (isset($_GET['screeningID'])) {
//echo "ScreeningID from questionnaire:".$_GET['screeningID'];
    $screeningID = $_GET['screeningID'];
}
$shadowID = $screeningID;
if (isset($_GET['shadowID'])) {
//echo "ScreeningID from questionnaire:".$_GET['screeningID'];
    $shadowID = $_GET['shadowID'];
}

$query_getSAF = "SELECT a.answerfield, o.option_id, o.option_code, sa.response FROM answerfield a INNER JOIN screening_answerfield sa ON sa.answerfield_id = a.answerfield_id LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id WHERE sa.screening_id= " . $screeningID . " ORDER BY sa.pagenum, a.answerfield, sa.submit_datetime";

$result = mysql_query($query_getSAF);

while ($AFrow = mysql_fetch_assoc($result)) {
    /* Inside while loop */
    $AF_array[] = $AFrow;
}

function searchForId($id, $array)
{
    foreach ($array as $key => $val) {
        if ($val["answerfield"] === $id) {
            return $key;
        }
    }
    return null;
}
if(isset($AF_array)){
//test
    $AFrow_index = searchForId('esi_category_retirement_planning', $AF_array);
    $esi_category_retirement_planning = false;
    if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')) {
        //echo "testing......................esi_category_retirement_planning";
        $esi_category_retirement_planning = true;
    }
    $AFrow_index = searchForId('esi_category_consumer_protection', $AF_array);
    $esi_category_consumer_protection = false;
    if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')) {
        //echo "testing......................esi_category_consumer_protection";
        $esi_category_consumer_protection = true;
    }

    $AFrow_index = searchForId('esi_category_credit_debt_management', $AF_array);
    $esi_category_credit_debt_management = false;
    if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')) {
        //echo "testing......................esi_category_credit_debt_management";
        $esi_category_credit_debt_management = true;
    }
    $AFrow_index = searchForId('esi_category_employment_training', $AF_array);
    $esi_category_employment_training = false;
    if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')) {
        //echo "testing......................esi_category_employment_training";
        $esi_category_employment_training = true;
    }
    $AFrow_index = searchForId('esi_category_health_resources', $AF_array);
    $esi_category_health_resources = false;
    if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')) {
        //echo "testing......................esi_category_health_resources";
        $esi_category_health_resources = true;
    }

    $AFrow_index = searchForId('esi_category_homeowner_resources', $AF_array);
    $esi_category_homeowner_resources = false;
    if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')) {
        //echo "testing......................esi_category_homeowner_resources";
        $esi_category_homeowner_resources = true;
    }
    $AFrow_index = searchForId('esi_category_legal_resources', $AF_array);
    $esi_category_legal_resources = false;
    if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')) {
        //echo "testing......................esi_category_legal_resources";
        $esi_category_legal_resources = true;
    }
    $AFrow_index = searchForId('esi_category_money_management', $AF_array);
    $esi_category_money_management = false;
    if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')) {
        //echo "testing......................esi_category_money_management";
        $esi_category_money_management = true;
    }
//esi_category_renter_resources
    $AFrow_index = searchForId('esi_category_renter_resources', $AF_array);
    $esi_category_renter_resources = false;
    if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')) {
        //echo "testing......................esi_category_renter_resources";
        $esi_category_renter_resources = true;
    }

// use the zipcode to detect county
    $AFrow_index = searchForId('esi_zip', $AF_array);
    if (isset($AF_array[$AFrow_index]["response"])) {
        $string_zip = "and z.zipcode = " . $AF_array[$AFrow_index]["response"];
        $esi_zip = $AF_array[$AFrow_index]["response"];
    } else {
        $string_zip = "and (1 = 0)";
    }
    unset ($AFrow_index);
}
// Get County using zip
$query_getCounty = "select z.zipcode, z.county_id, c.* from county c, zip z where c.county_id = z.county_id " . $string_zip;
$result2 = mysql_query($query_getCounty);
while ($CountyRow = mysql_fetch_assoc($result2)) {
    $County_array[] = $CountyRow;
}
unset($result2);
// Get the ESI Numbers based on County ID

// GET Elder index for location
$county = trim($County_array[0]["county_name"]);
$countyId = trim($County_array[0]["county_id"]);
$modifiedCountyName = trim($County_array[0]["county_name"]) . " County";
$state_id = trim($County_array[0]["state_id"]);
$query2 = "select * from economicsecurityindex_v2 where county_name = '" . $modifiedCountyName . "' and state_id = '" . $state_id . "'";
$result2 = mysql_query($query2);
while ($ESICountRow = mysql_fetch_assoc($result2)) {
    $ESICount_array[] = $ESICountRow;
}
$ESICT = count($ESICount_array);
unset($result2);
unset($query2);
//echo "<b>county:".$county."</b>";
//get county and zip based rules for quick evaluation in report
$query_getExendedPrograms = "
SELECT
program.program_id,
rule.rule_text,
program.state_id
FROM
program
INNER JOIN program_rule ON program_rule.program_id = program.program_id
INNER JOIN rule ON program_rule.rule_id = rule.rule_id
INNER JOIN rule_answerfield ON rule.rule_id = rule_answerfield.rule_id
INNER JOIN answerfield ON answerfield.answerfield_id = rule_answerfield.answerfield_id
WHERE
rule.rule_id In (1610,
1535,
1536,
1087,
1611,
1540,
706,
1539,
1541,
1542,
1547,
1546,
1554,
1619,
1550,
1553,
1556,
1612,
1557,
931,
1558,
1559,
1560,
1561,
1618,
1563,
1564,
1087,
686,
1539,
1541,
1542,
1547,
1546,
1554,
1619,
1550,
1553,
1556,
1612,
1557,
931,
1558,
1559,
1560,
1561,
1618,
1563,
1564,
1664,
706,
706,
1801,
1791,
918,
1801,
1749,
1808,
699,
1798,
1577,
1800,
1664,
1664,
1789,
1789,
1789,
1789,
1797,
392,
718,
719,
719,
718,
718,
1791,
1791,
1791,
1791,
1582)
";
$result2 = mysql_query($query_getExendedPrograms);
while ($ProgramRow2 = mysql_fetch_assoc($result2)) {

    $Program_array2[] = $ProgramRow2;
}
//print_r($Program_array2);
// debug to show programcategory_ids returned for the shadow screening
$program_extralist = '';

//special chicago zipcheck for Chicago only CSFP program
$chicago_ziplist = stristr('60290,60601,60602,60603,60604,60605,60606,60607,60608,60609,60610,60611,60612,60613,60614,60615,60616,60617,60618,60619,60620,60621,60622,60623,60624,60625,60626,60628,60629,60630,60631,60632,60633,60634,60636,60637,60638,60639,60640,60641,60642,60643,60644,60645,60646,60647,60649,60651,60652,60653,60654,60655,60656,60657,60659,60660,60661,60664,60666,60668,60669,60670,60673,60674,60675,60677,60678,60680,60681,60682,60684,60685,60686,60687,60688,60689,60690,60691,60693,60694,60695,60696,60697,60699,60701,60706,60707,60803,60804,60805,60827', $esi_zip, false);
if ($chicago_ziplist != false) {
    $chicago = true;
}
/**
 * This loops through all the programs that are retrieved from the data base for
 * the user. If there is no county then set the include to false and dont do the string search.
 */
foreach ($Program_array2 as $i => $row) {
    $includeprogrambycounty = false;
    $includeprogrambyzip = false;

    if ($county) {
        $includeprogrambycounty = stristr($row["rule_text"], $county, false);
    }

    if ($esi_zip) {
        $includeprogrambyzip = stristr($row["rule_text"], $esi_zip, false);
    }

    if (($includeprogrambycounty == false) and ($includeprogrambyzip == false)) {

        //echo $row["program_id"]."  | ".$includeprogrambycounty."| ".$includeprogrambyzip." <br> ";

        //special chicago zipcheck for Chicago only CSFP program
        //echo "chicago: ".$chicago.$esi_zip;
        if (($chicago == false) || ($row["program_id"] != 1836))
            $Program_array3[] = $row["program_id"];
    }
}
//print_r($Program_array3);
$commaList = implode(', ', $Program_array3);
//echo "List: ".$commaList;
$query_getPrograms = "
SELECT
p.program_id, p.programcategory_id, p.program_code, p.state_id, p.name_display_id
FROM
subset_program_sum spb
INNER JOIN program p ON p.program_id = spb.program_id
where spb.subset_id = 84 and (p.state_id = '" . $state_id . "' or p.state_id is null)
and p.active_flag = 1
and p.program_id not in (" . $commaList . ")
order by p.program_id 
";

$result1 = mysql_query($query_getPrograms);
while ($ProgramRow = mysql_fetch_assoc($result1)) {
    $Program_array[] = $ProgramRow;
}
//print_r($Program_array);
// debug to show programcategory_ids returned for the shadow screening
/*foreach ($Program_array as $i => $row){
	echo $row["programcategory_id"]." | ".$row["program_id"];	
}*/


function age($month, $day, $year)
{
    $y = gmstrftime("%Y");
    $m = gmstrftime("%m");
    $d = gmstrftime("%d");
    $age = $y - $year;
    if ($m <= $month) {
        if ($m == $month) {
            if ($d < $day) $age = $age - 1;
        } else $age = $age - 1;
    }
    return ($age);
}


?>


<div class="span8" id="printContent">
    <?php
    if ($dataBridge2 == "true") {

        $screeningID = $_GET['screeningID'];
        echo "<br/>";
        echo "<b>Unique ID: " . $screeningID . "</b>";
        echo "<br/>";
    }
    ?>

    <h2>EconomicCheckUp Report</h2>
    <p>This report provides a listing of services
        and tips that may help you save money. Use the links and contact information
        below to learn more about each opportunity. <strong>Note: Many of the programs
            mentioned below have eligibility requirements that you must meet in order to
            qualify for them.</strong></p>
    <p>
        Want to dig deeper? Take <a href="/<?php echo $questAnswers; ?>/<?php if (isset($_SESSION["eversafe_id"])){echo '?eversafe_id='.$_SESSION["eversafe_id"]; }?>">My CheckUp</a> to get a customized report for your individual
        situation.
    </p>
    <?php
    //Lynna Cekova: MD data bridge

    //echo "test location: ".$county." county id ".$countyId." ".$state_id." ".$esi_zip;

    $dataBridge = false;
    if ($countyId == '24510' || $countyId == '24031' || $countyId == '24027' || $countyId == '24019' || $countyId == '24043' || $countyId == '24039' || $countyId == '24045' || $countyId == '24047') {
        $dataBridge = true;
    }
    if ($dataBridge == true && $dataBridge2 != "true" && !(substr($reportClient, 0, 27) == "/eversafe-quickcheck-report") ) { //user, not agency with databridge=true in url
        echo "<p>You can also discuss your report with an <a target=\"_blank\" href=\"/esi-data-bridge?zip=" . $esi_zip . "&county=" . $countyId . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "\">aging services office in your area</a> that may be able to help you meet your financial goals/needs.</p>";
    }
    //Lynna Cekova: End of data bridge


    ?>

    <br/>
    </section>

    <?php

    require_once('report/getrecommendations.php');


    ?>
    <section id="money">
        <div class="body-header-wrapper"><h2><i class="icon-money "></i> Money Management & Budgeting </h2>
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


                //echo ("<br/> 3 min budget show </br>");
                //echo $money_recs["esi_report_budget_3min"]["show"];
                $AFrow_index = searchForId('esi_category_retirement_planning', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')) {


                    $money_recs["esi_report_retirement_plan"]["show"] = 1;
                    $money_recs["esi_report_budget_3min"]["show"] = 1;

                }


                // SSI 11712
                $links_esi_report_supplemental_security = array();
                foreach ($Program_array as $i => $row) {
                    $value = $row["program_code"];
                    $searchIndex = strpos($value, '_ssi');
                    if (is_numeric($searchIndex)) {
                        $money_recs["esi_report_supplemental_security"]["show"] = 1;
                        $links_esi_report_supplemental_security[] = $row["program_id"];
                        //echo $row["program_id"];
                    }
                }

                //print_r($links_esi_report_supplemental_security);
                unset($i);
                unset($row);
                unset($searchIndex);
                unset($value);
                // Online Money Management Tool (post id = 2573)
                $AFrow_index = searchForId('esi_retire_money_management', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"])) {
                    $money_recs["esi_report_money_management_tool"]["show"] = 1;
                }
                unset($AFrow_index);

                // Federal Lifeline Program - BCU (post id = 2577)
                //print_r($Program_array);
                $link_up = 0;
                $reachout = 0;
                $links_esi_report_federal_lifeline = array();
                foreach ($Program_array as $i => $row) {
                    $value = $row["program_code"];
                    $searchIndex = strpos($value, 'safelink_wireless');
                    $searchIndex3 = strpos($value, '_assurance_wireless');
                    $searchIndex4 = strpos($value, '_reachout_wireless');
                    if (is_numeric($searchIndex)) {
                        $money_recs["esi_report_federal_lifeline"]["show"] = 1;

                        $links_esi_report_federal_lifeline[] = $row["program_id"];
                    }

                    if (is_numeric($searchIndex3)) {
                        $money_recs["esi_report_federal_lifeline"]["show"] = 1;
                        $links_esi_report_federal_lifeline[] = $row["program_id"];
                    }

                    if ($value == 'utility_fd_lifeline_link_up') {
                        $money_recs["esi_report_federal_lifeline"]["show"] = 1;

                        $links_esi_report_federal_lifeline[] = $row["program_id"];
                        $link_up = 1;
                        //echo "<b>val:".$value.$link_up."</b><br>";
                    }
                    if (is_numeric($searchIndex4)) {
                        $money_recs["esi_report_federal_lifeline"]["show"] = 1;
                        $links_esi_report_federal_lifeline[] = $row["program_id"];
                    }


                }
                //print_r($links_esi_report_federal_lifeline);
                unset($i);
                unset($row);
                unset($searchIndex);
                unset($searchIndex2a);
                unset($searchIndex2b);
                unset($searchIndex3);
                unset($value);

                // Food and Nutrition Assistance - BCU (post id = 10217)
                $links_esi_report_food = array();
                //print_r($Program_array);
                $foodsupp = 0;
                $tefap = 0;
                foreach ($Program_array as $i => $row) {
                    $value = $row["program_code"];
                    //echo $value."<br>";
                    $searchIndex = strpos($value, 'nutrition_');
                    if (is_numeric($searchIndex)) {

                        $money_recs["esi_report_food"]["show"] = 1;
                        $links_esi_report_food[] = $row["program_id"];
                    }

                    if ($value == "foodsupp_fd_sfmnp") {
                        //echo $value;


                        $money_recs["esi_report_food"]["show"] = 1;
                        $links_esi_report_food[] = $row["program_id"];
                        //echo "<b>val:foodsupp_fd_sfmnp</b><br>";
                    }
                    $prg_cd = 'foodsupp_' . strtolower($state_id) . '_tefap';
                    if ($value == $prg_cd) {
                        //echo $value;
                        $money_recs["esi_report_food"]["show"] = 1;

                        $links_esi_report_food[] = $row["program_id"];
                        //echo "<b>val:".$prg_cd."</b><br>";
                    }
                    $prg_cd = 'foodsupp_' . strtolower($state_id) . '_commodity_supp';
                    if ($value == $prg_cd) {
                        //echo $value;
                        $money_recs["esi_report_food"]["show"] = 1;

                        $links_esi_report_food[] = $row["program_id"];
                        //echo "<b>val:".$prg_cd."</b><br>";
                    }
                }


                //print_r($links_esi_report_food);
                //echo "<b>val:".$money_recs[6]["show"]."</b><br>";
                unset($i);
                unset($row);
                unset($searchIndex);
                unset($searchIndex2);
                unset($value);

                //print_r($links_esi_report_food);
                //Local Food Bank (post id = 2581)
                $AFrow_index = searchForId('esi_basicneeds', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] != 'esi_notachallenge')) {


                    $money_recs["esi_report_food_bank"]["show"] = 1;
                }
                unset ($AFrow_index);

                // Budget Calculator (post id = 2586, post_code="esi_report_budget_3min")
                $AFrow_index = searchForId('esi_retire_money_management', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) {


                    $money_recs["esi_report_budget_3min"]["show"] = 1;
//echo ("<br/> 3 min budget show AFTER CHANGE</br>");
//echo $money_recs["esi_report_budget_3min"]["show"];


                }
                unset($AFrow_index);

                //Create a Budget  (post id = 2592)
                $AFrow_index = searchForId('esi_retire_money_management', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) {


                    $money_recs["esi_report_cut_spending"]["show"] = 1;

                }
                unset($AFrow_index);

                //Budgeting Assistance  (post id = 2596)
                $AFrow_index = searchForId('esi_retire_money_management', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) {


                    $money_recs["esi_report_budgeting"]["show"] = 1;
                }
                unset($AFrow_index);

                // Pension Assistance (post id = 2600)
                $AFrow_index = searchForId('esi_retire_retirement_planning', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) {


                    $money_recs["esi_report_pension_assitance"]["show"] = 1;
                    $links_esi_report_pension_assitance = array();
                    $links_esi_report_pension_assitance[] = 2081;
                    //$money_recs_count = ++$money_recs_count;
                }

                unset($AFrow_index);


                foreach ($Program_array as $i => $row) {
                    $value = $row["program_code"];
                    $searchIndex = strpos($value, 'assistance_fd_pension_right_cntr');
                    //if(is_numeric($searchIndex)){
                    if (1 == 1) {

                        //$money_recs["esi_report_pension_assitance"]["show"] = 1;
                        //$links_esi_report_pension_assitance[] = 2081;
                    }
                }
                $links_esi_report_pension_assitance[] = 2081;
                unset($i);
                unset($row);
                unset($searchIndex);
                unset($value);

                // Financial Planning (post id = 2609)
                $AFrow_index = searchForId('esi_retire_financial_prg_and_svcs', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"])) {


                    $money_recs["esi_report_financial_planning"]["show"] = 1;
                }
                unset ($AFrow_index);


                // Social Security  (post id = 13514)
                $AFrow_index = searchForId('esi_retire_retirement_planning', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"])) {


                    $money_recs["esi_report_social_security"]["show"] = 1;
                }
                unset ($AFrow_index);

                // Life Insurance (post id = 2613)
                $AFrow_index = searchForId('esi_retire_financial_prg_and_svcs', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"])) {


                    $money_recs["esi_report_life_insurance"]["show"] = 1;
                }
                unset($AFrow_index);

                // Tax Preparation Assistance (post id = 2617)
                $AFrow_index = searchForId('esi_retire_senior_tax_deductions', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"])) {
                    $money_recs["esi_report_tax_preparation"]["show"] = 1;
                }
                unset ($AFrow_index);

                // Fraud (post id = 2620) - show for everyone
                $AFrow_index = searchForId('esi_interest_protect', $AF_array);
                if (1 == 1) {
                    $money_recs["esi_report_fraud"]["show"] = 1;
                }
                unset ($AFrow_index);

                // Banking (post id = 2623)
                $AFrow_index = searchForId('esi_retire_financial_prg_and_svcs', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"])) {

                    $money_recs["esi_report_banking"]["show"] = 1;
                }
                unset ($AFrow_index);

                // Coupon Websites (post id = 2830)
                $AFrow_index = searchForId('esi_retire_money_management', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"])) {

                    $money_recs["esi_report_coupon_websites"]["show"] = 1;
                }
                unset($AFrow_index);


                //echo ("<br/> Money recs </br>");
                //var_dump( $money_recs );
                $money_recs["esi_report_retirement_plan"]["show"] = 1;


                // Show all 'Money Management & Budgeting' Recommendations flagged with show == 1
                $num_money_recs = count($money_recs); // total possible recs in this section
                //$money_recs_count = 0; // total recs to show based on responses.
                //for ($row = 0; $row < $num_money_recs; $row++)


                foreach ($money_recs as $row => $rec) //$row has the key, e.g. esi_report_budget_3min
                {
                    if (($money_recs[$row]["show"] !== 2) && ($money_recs[$row]["post_code"] != "esi_report_pension_assitance")) {
                        //$money_recs_count = ++$money_recs_count;
                        $current_id = $money_recs[$row]["postid"];
                        $post = get_post($current_id);
                        $title = $post->post_title;
                        /*
                        echo ("<br/>POST TITLE</br>");
                        echo $title;
                        echo ("<br/>POST SHOW</br>");
                        echo $money_recs[$row]["show"];
                        echo ("<br/>POST ID</br>");
                        echo $money_recs[$row]["postid"];
                        echo ("<br/>POST CODE</br>");
                        echo $money_recs[$row]["post_code"];
                        var_dump ($money_recs[$row]);
                        */
                        $desc = $post->post_content;
                        echo "<div>";
                        if (($title != 'ESI QuickCheck Report') && ($title != 'EverSafe QuickCheck Report')) {
                            echo "<h4>" . $title . "</h4>";
                        }
                        echo "<p>" . $desc . "<BR />";
                        if ($money_recs[$row]["bcu"] !== 2) {
                            if (isset(${"links_" . $money_recs[$row]["post_code"]})) {
                                foreach (${'links_' . $money_recs[$row]["post_code"]} as $program_id) {
                                    $query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = " . $program_id . " LIMIT 1";
                                    $programName_query = $bcudb->get_results($query_programName);
                                    foreach ($programName_query as $programNameObj):
                                        $programTitle = $programNameObj->program_title;
                                        echo "<a target='blank' href='/".$esiFactsheet."/?program_id=" . $program_id . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'><i class='icon-info-sign'></i></a> <a target='blank' href='/".$esiFactsheet."/?program_id=" . $program_id . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'>" . $programTitle . "</a><BR />";
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
                    } else {
                        if (($money_recs[$row]["show"] !== 2) && $money_recs[$row]["post_code"] == "esi_report_pension_assitance") {
                            $epgEpId = 0;
                            $entrypointgroup_id = 456;
                            $epg_phone = "(651) 641-8612";
                            $query_epgEp = "select e.entrypoint_id, zd.distance,p.number
														from entrypoint_entrypointgroup eg, entrypoint e, view_zip_distance zd, phone p
														where eg.entrypointgroup_id=" . $entrypointgroup_id . "
															and eg.entrypoint_id=e.entrypoint_id
															and e.active_flag=1
															and e.zipcode=zd.start_zipcode
															and zd.end_zipcode='" . $esi_zip . "'
															and zd.distance < 100
															and p.entrypoint_id=e.entrypoint_id
															and p.phonetype_id = 1
														union
														select e.entrypoint_id, 999999 distance,p.number
														from entrypoint_entrypointgroup eg, entrypoint e,phone p
														where eg.entrypointgroup_id=" . $entrypointgroup_id . "
															and eg.entrypoint_id=e.entrypoint_id
															and e.active_flag=1
															and e.zipcode is null
															and e.zipcode='" . $esi_zip . "'
															and p.entrypoint_id=e.entrypoint_id
															and p.phonetype_id = 1
														order by distance limit 1";
                            $epgEp_query = $bcudb->get_results($query_epgEp);
                            foreach ($epgEp_query as $epgEpObj):
                                $epgEpId = $epgEpObj->entrypoint_id;
                            endforeach;
                            $query_getEPGphone = "Select number from phone where entrypoint_id = $epgEpId and phonetype_id = 1 Limit 1";
                            $getEPGphone_query = $bcudb->get_results($query_getEPGphone);
                            foreach ($getEPGphone_query as $epgEpObj4):
                                $epg_phone = $epgEpObj4->number;
                            endforeach;
                            //echo ".$epg_phone.";
                            echo "<div><h4>Pension Assistance</h4><p>PensionHelp America provides counselors who can answer questions about your pension or 401(k) plan. Learn more: <br>";

                            if ($money_recs[$row]["bcu"] !== 2) {
                                if (isset(${"links_" . $money_recs[$row]["post_code"]})) {
                                    foreach (${'links_' . $money_recs[$row]["post_code"]} as $program_id) {
                                        $query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = " . $program_id . " LIMIT 1";
                                        $programName_query = $bcudb->get_results($query_programName);
                                        foreach ($programName_query as $programNameObj):
                                            $programTitle = $programNameObj->program_title;
                                            echo "<a target='blank' href='/".$esiFactsheet."/?program_id=" . $program_id . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'><i class='icon-info-sign'></i></a> <a target='blank' href='/".$esiFactsheet."/?program_id=" . $program_id . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'>" . $programTitle . "</a><BR />";
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
                    echo "
There are no recommendations for you at this time; if your situation changes
please check back.";
                }
                //unset($money_recs_count);
                ?>
            </div>
        </div>

    </section>
    <section id="housing">
        <div class="body-header-wrapper"><h2><i class="icon-home "></i> Housing </h2>
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


                // Foreclosure (post id 2837 and post id 2642)
                // Reverse Mortgage Counseling (post id 2648)
                // Home Owner's Insurance (post id 2652)
                $req1 = 0; // 62 or older
                $req2 = 0; // owns home
                $req3 = 0; // 62, owns home and owes more than worth OR some equity but can't keep up with mthly bills
                $req4 = 0; // homeless or lives in a shelter
                $req5 = 0; // 62, owns home, paid off mortgage but have trouble paying other bills OR have some equity but can make paying other bills
                $req6 = 0; // owns home and doesn't have homeowner's insurance
                $req7 = 0; // rents

                if ($userAge >= 62) {
                    $req1 = 1;
                }
                $AFrow_index2 = searchForId("esi_housingtype", $AF_array);
                if (isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] == "esi_housingtype_own")) {
                    $req2 = 1;
                }
                $AFrow_index3 = searchForId("esi_housingsituation", $AF_array);
                if ((isset($AF_array[$AFrow_index3]["option_code"]) && (($AF_array[$AFrow_index3]["option_code"] == "esi_housing_someequity")) || ($AF_array[$AFrow_index3]["option_code"]) == "esi_housing_underwater")) {
                    $req3 = 1;
                }
                if ((isset($AF_array[$AFrow_index3]["option_code"]) && (($AF_array[$AFrow_index3]["option_code"] == "esi_housing_foreclosure")))) {
                    $req4 = 1;
                }
                if ((isset($AF_array[$AFrow_index3]["option_code"]) && (($AF_array[$AFrow_index3]["option_code"] == "esi_housing_mortgagepaid")) || ($AF_array[$AFrow_index3]["option_code"]) == "esi_housing_someequity")) {
                    $req5 = 1;
                }
                $AFrow_index4 = searchForId("esi_homeinsurance", $AF_array);
                if ((isset($AF_array[$AFrow_index4]["option_code"]) && (($AF_array[$AFrow_index4]["option_code"] == "n")))) {
                    $req6 = 1;
                }
                if (isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] === "esi_housingtype_rent")) {
                    $req7 = 1;
                }
                //if (isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] === "esi_housingtype_homeless")){$req4 = 1;}

                // Qualifies for BCU Rental Assistance Program - post id 2657

                //must check for renting first

                $behindrent = searchForId('esi_behind_in_rent', $AF_array);
                $links_esi_report_renter_assistance = array();


                foreach ($Program_array as $i => $row) {
                    $value = $row["program_code"];
                    $searchIndex = strpos($value, 'housing_fd_');
                    if (is_numeric($searchIndex)) {
                        $housing_recs["esi_report_renter_assistance"]["show"] = 1;
                        $links_esi_report_renter_assistance[] = $row["program_id"];
                    }
                    $searchIndex = strpos($value, 'rent');
                    if (is_numeric($searchIndex)) {
                        $housing_recs["esi_report_renter_assistance"]["show"] = 1;
                        $links_esi_report_renter_assistance[] = $row["program_id"];
                    }
                }
                unset($i);
                unset($row);
                unset($searchIndex);
                unset($value);

                // Qualifies for BCU Property Tax Assistance programs - post id 2662
                $links_esi_report_tax_assistance = array();
                foreach ($Program_array as $i => $row) {
                    //echo "<b>val2:".$row["program_code"]."..".$row["programcategory_id"]."</b><br>";
                    $value = $row["programcategory_id"];
                    $searchIndex = strpos($value, '43');
                    // Check if Property Tax Relief checked in assessment
                    $AFrow_index = searchForId('receive_propertytax', $AF_array);
                    $esi_propertytax_receive = 0;
                    if (isset($AF_array[$AFrow_index]["option_code"])) {
                        $esi_propertytax_receive = 1;
                    }
                    unset ($AFrow_index);
                    $prg_code = $row["program_code"];
                    $searchIndex = strpos($prg_code, 'rent');
                    if (($row["programcategory_id"] == 5) && ($esi_propertytax_receive == 0) && (!is_numeric($searchIndex))) {
                        $housing_recs["esi_report_tax_assistance"]["show"] = 1;
                        $links_esi_report_tax_assistance[] = $row["program_id"];
                    }
                    $searchIndexNY = strpos($prg_code, '_ny_nyc_school');
                    if (is_numeric($searchIndexNY)) {

                        $links_esi_report_tax_assistance[] = $row["program_id"];
                    }

                }
                //print_r($links_esi_report_tax_asssitance);
                unset($i);
                unset($row);
                unset($searchIndex);
                unset($value);

                // Qualifies for BCU Weatherization Programs - post id 2665
                foreach ($Program_array as $i => $row) {
                    $value = $row["program_code"];
                    $searchIndex = strpos($value, 'weather');
                    if (is_numeric($searchIndex)) {
                        $housing_recs["esi_report_weatherization"]["show"] = 1;
                        $links_esi_report_weatherization = array();
                        $links_esi_report_weatherization[] = $row["program_id"];
                    }
                }
                unset($i);
                unset($row);
                unset($searchIndex);
                unset($value);

                // Qualifies for BCU LIHEAP Programs - post id 2669
                foreach ($Program_array as $i => $row) {
//echo ("</br> row ");
//var_dump ($row);
                    $value = $row["program_code"];
                    $searchIndex = strpos($value, 'liheap');
//echo ("</br> Search index ");
//echo $searchIndex;
                    // Check if liheap checked in assessment
                    $AFrow_index = searchForId('liheap_receive', $AF_array);
                    $esi_liheap_receive = 0;
                    if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'y')) {
                        $esi_liheap_receive = $AF_array[$AFrow_index]["option_code"];
                    }
//echo ("</br> liheap ");
//echo $esi_liheap_receive;

                    unset ($AFrow_index);
                    if ((is_numeric($searchIndex)) && ($esi_liheap_receive == 0)) {
                        $housing_recs["esi_report_utility_assitance"]["show"] = 1;
                        $links_esi_report_utility_assitance = array();
                        $links_esi_report_utility_assitance[] = $row["program_id"];
                    }
                }
                unset($i);
                unset($row);
                unset($searchIndex);
                unset($value);

                if ($req1 == 1 && $req2 == 1 && $req3 == 1) {
                    $housing_recs["esi_report_foreclosure_1"]["show"] = 1;
                }    // post id 2837
                if ($req1 == 1 && $req2 == 1 && $req4 == 1) {
                    $housing_recs["esi_report_foreclosure_2"]["show"] = 1;
                }  // post id 2642
                if ($req1 == 1 && $req2 == 1 && $req5 == 1) {
                    $housing_recs["esi_report_reverse_mortgage"]["show"] = 1;
                }  // post id 2648
                if ($req2 == 1 && $req6 == 1) {
                    $housing_recs["esi_report_homeowner_insurance"]["show"] = 1;
                }  // post id 2652
                //if ($req2 == 1) {$housing_recs[10]["show"] = 1;} // post id 2680 energy star
                if ($req7 == 1) {

                    //$housing_recs["esi_report_renter_assistance"]["show"] = 1;
                } // post id 2657
                if ((isset($AF_array[$AFrow_index3]["option_code"]) && (($AF_array[$AFrow_index3]["option_code"] == "esi_housing_underwater")))) {
                    $housing_recs["esi_report_underwater_opportunities"]["show"] = 1;
                } // post id 2692
                $AFrow_index5 = searchForId("esi_healthdisability", $AF_array);
                if ((isset($AF_array[$AFrow_index5]["option_code"]) && (($AF_array[$AFrow_index5]["option_code"] == "y") && ($req2 == 1)))) {
                    $housing_recs["esi_report_home_improvements"]["show"] = 1;
                } // post id 2695

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
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'esi_housingtype_homeless')) {
                    $housing_recs["esi_report_homeless_intervention"]["show"] = 1;
                }
                unset($AFrow_index);

                // Moving (post id 2686)
                $AFrow_index = searchForId('esi_moving_save_money', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')) {
                    $housing_recs["esi_report_moving"]["show"] = 1;

                }
                unset($AFrow_index);

                // Energy (Disabled) (post id 2680)
                // $AFrow_index = searchForId('esi_housingtype', $AF_array);
                // if (isset($AF_array[$AFrow_index]["option_code"])&&($AF_array[$AFrow_index]["option_code"] == 'esi_housingtype_own')){$housing_recs[10]["show"] = 1;}
                // unset($AFrow_index);
                // Homeless Intervention (post id 2645)
                //$AFrow_index = searchForId('esi_housingtype', $AF_array);
                $roomate_countylist = stristr('alameda,contra costa,imperial,marin,san francisco,san mateo,santa clara', $county, false);
                //echo 'roomate:'.$roomate_countylist;
                if ($roomate_countylist != false) {
                    $housing_recs["esi_report_roommate_matching"]["show"] = 1;
                    //echo 'county'.$county;
                } else {
                    $housing_recs["esi_report_roommate_matching"]["show"] = 2;
                    //echo 'No match county'.$county;
                }
                //unset($AFrow_index);


                //	echo ("<br/> HOUSING RECS after the showing");
                //var_dump ($housing_recs);


                // Show all 'Housing' Recommendations flagged with show == 1
                $num_housing_recs = count($housing_recs); // total possible recs in this section


                foreach ($housing_recs as $row => $rec) //$row has the key, e.g. esi_report_budget_3min
                    //for ($row = 0; $row < $num_housing_recs; $row++)
                {


                    if ($housing_recs[$row]["show"] !== 2) {
                        //$housing_recs_count = ++$housing_recs_count;
                        $current_id = $housing_recs[$row]["postid"];
                        $post = get_post($current_id);


                        $title = $post->post_title;
                        /*
                        echo ("<br/>POST TITLE</br>");
                        echo $title;
                        echo ("<br/>POST SHOW </br>");
                        echo $housing_recs[$row]["show"];
                        echo ("<br/>POST ID </br>");
                        echo $housing_recs[$row]["postid"];
                        echo ("<br/>POST CODE</br>");
                        echo $housing_recs[$row]["post_code"];
                        echo "<br/";
                        var_dump ($housing_recs[$row]);
                        */


                        $desc = $post->post_content;
                        echo "<div>";
                        if (($title != 'ESI QuickCheck Report') && ($title != 'EverSafe QuickCheck Report')) {
                            echo "<h4>" . $title . "</h4>";
                        }
                        echo "<p>" . $desc . "<BR />";
                        if ($housing_recs[$row]["bcu"] !== 2) {
                            if (isset(${"links_" . $housing_recs[$row]["post_code"]})) {
                                foreach (${'links_' . $housing_recs[$row]["post_code"]} as $program_id) {
                                    $query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = " . $program_id . " LIMIT 1";
                                    $programName_query = $bcudb->get_results($query_programName);
                                    foreach ($programName_query as $programNameObj):
                                        $programTitle = $programNameObj->program_title;
                                        echo "<a target='blank' href='/".$esiFactsheet."/?program_id=" . $program_id . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'><i class='icon-info-sign'></i></a> <a target='blank' href='/".$esiFactsheet."/?program_id=" . $program_id . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'>" . $programTitle . "</a><BR />";
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
                        $title = "";
                        unset($desc);
                    }

                }
                unset($row);
                if ($housing_recs_count == 0) {

                    echo "There are no recommendations for you at this time; if your situation changes please check back.";
                }
                //unset($housing_recs_count);
                ?>
            </div>
        </div>
    </section>
    <section id="health">
        <div class="body-header-wrapper"><h2><i class="icon-medkit "></i> Health </h2>
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

                //print_r( $Program_array);

                //Medicaid 11710
                $links_esi_report_medicaid = array();
                foreach ($Program_array as $i => $row) {
                    $value = $row["program_code"];
                    $searchIndex = strpos($value, '_medicaid');
                    $searchIndex_IL = strpos($value, 'medicaid_il_');
                    if (is_numeric($searchIndex) || is_numeric($searchIndex_IL)) {
                        $health_recs["esi_report_medicaid"]["show"] = 1;
                        $links_esi_report_medicaid[] = $row["program_id"];
                    }


                }

                //print_r($links_esi_report_medicaid);
                unset($i);
                unset($row);
                unset($searchIndex);
                unset($value);

                // Mental Health (post id = 2698)
                $AFrow_index = searchForId('esi_depression', $AF_array);
                $depressed = 'n';
                if (isset($AF_array[$AFrow_index]["option_code"]) && (($AF_array[$AFrow_index]["option_code"] == "esi_depression_half") || ($AF_array[$AFrow_index]["option_code"] == "esi_depression_every"))) {
                    $health_recs["esi_report_mental_health"]["show"] = 1;
                    $depressed = 'y';
                }
                unset($AFrow_index);

                // CDSMP (post id = 2701)
                $chronic = searchForId('esi_chroniccondition', $AF_array);
                $AFrow_index = searchForId('esi_ratehealth', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && (($AF_array[$AFrow_index]["option_code"] == "esi_ratehealth_fair") || ($AF_array[$AFrow_index]["option_code"] == "esi_ratehealth_poor") || $depressed == 'y')) {
                    $health_recs["esi_report_chronic_disease"]["show"] = 1;
                }
                //echo 'chron:'.$AF_array[$chronic]["option_code"];
                if (isset($AF_array[$chronic]["option_code"]) && (($AF_array[$chronic]["option_code"] == "chroniccondition_2_more") || ($AF_array[$chronic]["option_code"] == "chroniccondition_1"))) {
                    $health_recs["esi_report_chronic_disease"]["show"] = 1;
                    //echo 'chron:'.$AF_array[$chronic]["option_code"];
                }
                unset($AFrow_index);

                // Extra Help (post id = 2705)
                foreach ($Program_array as $i => $row) {
                    $value = $row["program_code"];
                    $searchIndex = strpos($value, 'rxgov_fd_medicare_');
                    if (is_numeric($searchIndex)) {
                        $health_recs["esi_report_extra_help"]["show"] = 1;
                        $links_esi_report_extra_help = array();
                        $links_esi_report_extra_help[] = $row["program_id"];
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
                $links_esi_report_medicare_savings = array();
                foreach ($Program_array as $i => $row) {
                    $value = $row["program_code"];
                    $cat_id = $row["programcategory_id"];
                    $searchIndex = strpos($value, '_msp_');
                    //echo "msp:".$value.$cat_id."<br>";
                    if ($cat_id == 9) {
                        $health_recs["esi_report_medicare_savings"]["show"] = 1;
                        $links_esi_report_medicare_savings[] = $row["program_id"];
                        //echo "msp:".$value.$cat_id."<br>";
                    }
                }
                unset($i);
                unset($row);
                unset($searchIndex);
                unset($value);

                // Prescription Drug Assistance (post id = 2712)
                $AFrow_index = searchForId('esi_rxhelp', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y')) {
                    $health_recs["esi_report_patient_assistance"]["show"] = 1;
                }
                unset($AFrow_index);

                // Medicare Health Insurance Assistance (post id = 13533)
                $health_recs["esi_report_medicare_health_insurance"]["show"] = 1;
                $req1 = 0;
                $req2 = 0;
                $healthExp = 0;
                $calcIncome = $totalMthlyInc * .2;
                $AFrow_index = searchForId('esi_hh_expenses', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"])) {
                    $healthExp = $AF_array[$AFrow_index]["response"];
                }
                $AFrow_index2 = searchForId('esi_counselor', $AF_array);
                if ((($healthExp >= $calcIncome) && ($userAge >= 65)) || (isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] == 1))) {
                    $health_recs["esi_report_medicare_health_insurance"]["show"] = 1;
                    //$health_recs_count = ++$health_recs_count;
                }
                //$health_recs[5]["show"] = 1;
                unset($AFrow_index);
                unset($AFrow_index2);
                unset($calcIncome);

                // Aging Services (post id = 2720)
                if ($userAge >= 65) {
                    $health_recs["esi_report_aging_services"]["show"] = 1;
                }

                // Area Agency on Aging (post id = 2724)
                //if ($userAge >= 60){$health_recs["esi_report_area_aging_agency"]["show"] = 1;}
                //echo "User Age:".$userAge;
                // Show all 'Health' Recommendations flagged with show == 1
                $num_health_recs = count($health_recs); // total possible recs in this section
                //$health_recs_count = 0; // total recs to show based on responses.
                //print_r( $health_recs);
                //echo $num_health_recs;
                //for ($row = 0; $row < $num_health_recs; $row++)
                foreach ($health_recs as $row => $rec)

                    //echo ("health recs before");
                    //var_dump ($health_row has the key, e.g. esi_report_budget_3min
                    //print_r( $health_recs);

                {


                    if (($health_recs[$row]["show"] !== 2) && ($health_recs[$row]["post_code"] != "esi_report_area_aging_agency") && ($health_recs[$row]["post_code"] != "esi_report_medicare_health_insurance")) {
                        //$health_recs_count = ++$health_recs_count;
                        $current_id = $health_recs[$row]["postid"];
                        $post = get_post($current_id);
                        $title = $post->post_title;
                        $desc = $post->post_content;
                        echo "<div>";
                        if (($title != 'ESI QuickCheck Report') && ($title != 'EverSafe QuickCheck Report')) {
                            echo "<h4>" . $title . "</h4>";
                        }
                        echo "<p>" . $desc . "<BR />";
                        //echo "links_ " . $health_recs[$row]["postid"];
                        //echo "test:".$current_id;
                        if ($health_recs[$row]["bcu"] !== 2) {

                            if (isset(${"links_" . $health_recs[$row]["post_code"]})) {

                                foreach (${'links_' . $health_recs[$row]["post_code"]} as $program_id) {
                                    //echo 'program'.$program_id;
                                    $query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = " . $program_id . " LIMIT 1";
                                    $programName_query = $bcudb->get_results($query_programName);
                                    foreach ($programName_query as $programNameObj):
                                        $programTitle = $programNameObj->program_title;
                                        echo "<a target='blank' href='/".$esiFactsheet."/?program_id=" . $program_id . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'><i class='icon-info-sign'></i></a> <a target='blank' href='/".$esiFactsheet."/?program_id=" . $program_id . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'>" . $programTitle . "</a><BR />";
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
                    } else {
                        // Custom handler for AAA
                        if ($health_recs[$row]["post_code"] == "esi_report_area_aging_agency") {
                            $epgEpId = 0;
                            $entrypointgroup_id = 1;
                            // Proximity Zip search
                            $query_epgEp_proximityZip = "select e.entrypoint_id, zd.distance, p.number
                                from entrypoint_entrypointgroup eg, entrypoint_zip ez, entrypoint e, view_zip_distance zd, phone p
                                where eg.entrypointgroup_id=1
                                    and eg.entrypoint_id=ez.entrypoint_id
                                    and ez.zipcode=" . $esi_zip . "
                                    and ez.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode=zd.start_zipcode
                                    and zd.end_zipcode=" . $esi_zip . "
                                union
                                select e.entrypoint_id, 999999 distance, p.number
                                from entrypoint_entrypointgroup eg, entrypoint e, entrypoint_zip ez, phone p
                                where eg.entrypointgroup_id=1
                                    and eg.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode is null
                                    and e.entrypoint_id=ez.entrypoint_id
                                    and ez.zipcode=" . $esi_zip . "
                                order by distance 
								LIMIT 1";
                            $epgEp_proximityZip_query = $bcudb->get_results($query_epgEp_proximityZip);
                            foreach ($epgEp_proximityZip_query as $epgEpObj):
                                $epgEpId = $epgEpObj->entrypoint_id;
                                $epPhone = $epgEpObj->number;
                            endforeach;

                            // Proximity County search
                            $ctyID = 0;
                            if (count($epgEp_proximityZip_query) == 0) {
                                $query_ctyID = "select county_id from zip where zipcode=" . $esi_zip . " Limit 1";
                                $results_ctyID = $bcudb->get_results($query_ctyID);
                                foreach ($results_ctyID as $ctyObj):
                                    $ctyID = $ctyObj->county_id;
                                endforeach;

                                $query_epgEp_proximityCounty = "select e.entrypoint_id, zd.distance, p.number
                                    from entrypoint_entrypointgroup eg, entrypoint_county ec, entrypoint e, view_zip_distance zd, phone p
                                    where eg.entrypointgroup_id=1
                                        and eg.entrypoint_id=ec.entrypoint_id
                                        and ec.county_id in (" . $ctyID . ")
                                        and ec.entrypoint_id=e.entrypoint_id
                                        and e.active_flag=1
                                        and e.zipcode=zd.start_zipcode
                                        and zd.end_zipcode=" . $esi_zip . "
                                    UNION
                                    select e.entrypoint_id, 999999 distance, p.number
                                    from entrypoint_entrypointgroup eg, entrypoint e, entrypoint_county ec, phone p
                                    where eg.entrypointgroup_id=1
                                        and eg.entrypoint_id=e.entrypoint_id
                                        and e.active_flag=1
                                        and e.zipcode is null
                                        and e.entrypoint_id=ec.entrypoint_id
                                        and ec.county_id in (" . $ctyID . ")
                                    order by distance 
									LIMIT 1";
                                $epgEp_proximityCounty_query = $bcudb->get_results($query_epgEp_proximityCounty);
                                foreach ($epgEp_proximityCounty_query as $epgEpObj):
                                    $epgEpId = $epgEpObj->entrypoint_id;
                                endforeach;
                            }
                            // Proximity Radius search. Custom solution for issues with IL Counties Cook and Lake where zips exist cross county
                            if (count($epgEp_proximityCounty_query == 0)) {
                                $query_epgEp_proximityRadius = "select e.entrypoint_id, p.number
                                    from entrypoint_entrypointgroup eg, entrypoint e, view_zip_distance zd, phone p
                                    where eg.entrypointgroup_id=1
                                        and eg.entrypoint_id=e.entrypoint_id
                                        and e.active_flag=1
                                        and e.zipcode=zd.start_zipcode
                                        and zd.start_state_id='IL'
                                        and zd.end_zipcode=" . $esi_zip . "
                                        and zd.distance <= 100
                                    order by zd.distance 
									LIMIT 1";
                                $epgEp_proximityRadius_query = $bcudb->get_results($query_epgEp_proximityRadius);
                                foreach ($epgEp_proximityRadius_query as $epgEpObj):
                                    $epgEpId = $epgEpObj->entrypoint_id;
                                endforeach;
                            }
                            if ($epgEpId > 0) {
                                $query_getEPGphone = "Select number from phone where entrypoint_id = " . $epgEpId . " and phonetype_id = 1 Limit 1";
                                $getEPGphone_query = $bcudb->get_results($query_getEPGphone);
                                foreach ($getEPGphone_query as $phoneObj):
                                    $epPhone = $phoneObj->number;
                                endforeach;
                            }
                            $health_recs["esi_report_area_aging_agency"]["show"] = 1;
                            echo "<div><h4>Area Agency on Aging</h4><p>Across the country, local Area Agencies on Aging provide services like food and nutrition assistance, home care, legal assistance, and health and mental health programs. Contact your local Area Agency on Aging at: " . $epPhone . " to learn more about what's available in your community. You also can locate Area Agencies on Aging nationwide by visiting them online at <a href='http://www.tinyurl.com/AAADirectory' target='_blank'>tinyurl.com/AAADirectory</a>.</div>";
                            //$health_recs_count = ++$health_recs_count;
                        }

                        // Custom handler for SHIP
                        $indexCounselor = searchForId('esi_counselor', $AF_array);
                        $esi_counselor = 0;
                        //echo "ship:".$indexCounselor;
                        if (isset($AF_array[$indexCounselor]["option_code"]) && ($AF_array[$indexCounselor]["option_code"] == 'y')) {
                            $esi_counselor = 1;
                        }
                        $oneFifthMthlyInc = $totalMthlyInc / 5;
                        if ($health_recs[$row]["post_code"] == "esi_report_medicare_health_insurance") {
                            //echo "<h4>Ship Time</h4>";
                            $epgEpId = 0;
                            $entrypointgroup_id = 83;
                            echo "<div><h4>Medicare Health Insurance Assistance</h4>The State Health Insurance Assistance Program (SHIP) is a free health insurance counseling program for all Medicare beneficiaries and their caregivers. Trained volunteer counselors can give you one-on-one, personalized advice on health insurance benefits, information on assistance with paying for Medicare costs, etc.  The SHIP counselors also provide you information and resources that help with paying for prescription drugs, such as patient assistant programs.";

                            // Get local EPG Office
                            $query_epgEP = "select e.entrypoint_id, e.name, e.url, p.number
														from entrypoint_entrypointgroup eg, entrypoint e, phone p
														where eg.entrypointgroup_id=" . $entrypointgroup_id . "
															and eg.entrypoint_id=e.entrypoint_id
															and e.state_id in (select state_id from zip where zipcode='" . $esi_zip . "')
															and e.active_flag=1
															and p.entrypoint_id=e.entrypoint_id
															and p.phonetype_id = 4 limit 1";
                            $epgEP_query = $bcudb->get_results($query_epgEP);
                            foreach ($epgEP_query as $epgEpObj):
                                $epgEpId = $epgEpObj->entrypoint_id;
                                $epgEpName = $epgEpObj->name;
                                $epgEpUrl = $epgEpObj->url;
                                $epgEpNumber = $epgEpObj->number;
                                echo "<p><br>Contact " . $epgEpName . " at " . $epgEpNumber . " or get more information here: <a href='" . $epgEpUrl . "' target='_blank'>" . $epgEpUrl . "</a>.";
                            endforeach;
                            echo "</p></div>";
                        }
                    }
                }
                unset($row);
                if ($health_recs_count == 0) {
                    echo "There are no recommendations for you at this time; if your situation changes please check back.";
                }
                //unset($health_recs_count);
                ?>
            </div>
        </div>
    </section>
    <section id="employment">
        <div class="body-header-wrapper"><h2><i class="icon-certificate "></i> Employment &#38; Training </h2>
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

                // SCSEP (postid = 2728)
                $AFrow_index = searchForId('esi_seekingemployment_usehelp', $AF_array);
                $req1 = 1.25 * $FPL;
                $req2 = 0;
                if (($totalMthlyInc <= $req1) && ($userAge >= 55)) {
                    $req2 = 1;
                }
                if ((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) && ($req2 == 1)) {
                    $employment_recs["esi_report_scsep"]["show"] = 1;
                    $employment_recs_count = ++$employment_recs_count;
                }
                //$employment_recs[3]["show"] = 1;
                // One Stop (postid = 2734)
                $req3 = 0;
                if (($totalMthlyInc <= $req1) && ($userAge < 55)) {
                    $req3 = 1;
                }
                if ((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) && ($req3 == 1)) {
                    $employment_recs["esi_report_one_stop"]["show"] = 1;
                }
                unset($AFrow_index);
                unset($req1);
                unset($req2);
                unset($req3);

                // Senior Companion (postid = 2738)
                // if total monthly income <= 200% of FPL and user selects anything for q13
                if ($functionDebugging == "true") {
                    echo "<p>totalMonthlyInc: " . $totalMthlyInc . "</p>";
                }
                if ($userAge >= 55) {
                    $req1 = 0;
                    //echo "age:".$userAge;
                    $AFrow_index1 = searchForId('esi_seekingemployment_usehelp', $AF_array);
                    $AFrow_index2 = searchForId('esi_seekingemployment_refresher', $AF_array);
                    $AFrow_index3 = searchForId('esi_seekingemployment_skillsassessment', $AF_array);
                    $AFrow_index4 = searchForId('esi_seekingemployment_techhelp', $AF_array);
                    if (isset($AF_array[$AFrow_index1]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'n')) {
                        $req1++;
                    }
                    if (isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] == 'n')) {
                        $req1++;
                    }
                    if (isset($AF_array[$AFrow_index3]["option_code"]) && ($AF_array[$AFrow_index3]["option_code"] == 'n')) {
                        $req1++;
                    }
                    if (isset($AF_array[$AFrow_index4]["option_code"]) && ($AF_array[$AFrow_index4]["option_code"] == 'n')) {
                        $req1++;
                    }
                    $req2 = 2 * $FPL;
                    //echo "test:".$req1;
                    if (($req1 > 0) && ($totalMthlyInc <= $req2)) {
                        $employment_recs["esi_report_senior_companion"]["show"] = 1;
                    }
                    unset($AFrow_index);
                    unset($req1);
                    unset($req2);
                }
                // Learning Technology (postid = 2742)
                $AFrow_index = searchForId('esi_seekingemployment_techhelp', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) {
                    $employment_recs["esi_report_learning_technology"]["show"] = 1;
                }
                unset($AFrow_index);

                // Skills Assessment (postid = 2744)
                $AFrow_index = searchForId('esi_seekingemployment_skillsassessment', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) {
                    $employment_recs["esi_report_skills_assessment"]["show"] = 1;
                }
                unset($AFrow_index);
                //echo "test:".$AF_array[$AFrow_index]["option_code"];

                // Job Training (postid = 2747)
                $AFrow_index = searchForId('esi_seekingemployment_refresher', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) {
                    $employment_recs["esi_report_job_training"]["show"] = 1;
                }
                unset($AFrow_index);

                // Job Search (postid = 2751)
                $AFrow_index = searchForId('esi_seekingemployment_usehelp', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) {
                    $employment_recs["esi_report_job_search"]["show"] = 1;
                }
                unset($AFrow_index);

                // Show all 'Employment and Training' Recommendations flagged with show == 1
                $num_employment_recs = count($employment_recs); // total possible recs in this section


                foreach ($employment_recs as $row => $rec) //$row has the key, e.g. esi_report_budget_3min
                    //for ($row = 0; $row < $num_employment_recs; $row++)
                {


                    if (($employment_recs[$row]["show"] !== 2) && ($employment_recs[$row]["post_code"] !== "esi_report_scsep")) {
                        $employment_recs_count = ++$employment_recs_count;
                        $current_id = $employment_recs[$row]["postid"];
                        $post = get_post($current_id);
                        $title = $post->post_title;
                        $desc = $post->post_content;
                        echo "<div>";
                        echo "<h4>" . $title . "</h4>";
                        echo "<p>" . $desc . "<BR />";
                        if ($employment_recs[$row]["bcu"] == 1) {
                            if (isset(${"links_" . $employment_recs[$row]["post_code"]})) {
                                foreach (${'links_' . $employment_recs[$row]["post_code"]} as $program_id) {
                                    $query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = " . $program_id . " LIMIT 1";
                                    $programName_query = $bcudb->get_results($query_programName);
                                    foreach ($programName_query as $programNameObj):
                                        $programTitle = $programNameObj->program_title;
                                        echo "<a target='blank' href='/".$esiFactsheet."/?program_id=" . $program_id . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'><i class='icon-info-sign'></i></a> <a target='blank' href='/".$esiFactsheet."/?program_id=" . $program_id . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'>" . $programTitle . "</a><BR />";
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
                        if ($title == 'Senior Companion') {
                            echo "<a target='blank' href='/".$esiFactsheet."/?program_id=144&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'><i class='icon-info-sign'></i></a> <a target='blank' href='/".$esiFactsheet."/?program_id=144&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'>Volunteer - Senior Companion Program (SCP)</a><BR />";


                        }
                        unset($current_id);
                        unset($post);
                        unset($title);
                        unset($desc);
                    } else {
                        // Custom handler for SCSEP
                        if (($employment_recs[$row]["post_code"] == "esi_report_scsep") && ($employment_recs["esi_report_scsep"]["show"] !== 2)) {
                            $epgEpId = 0;
                            $entrypointgroup_id = 286;
                            $epg_phone = "(888)480-1527";
                            $query_epgEp = "select e.entrypoint_id, zd.distance,p.number
														from entrypoint_entrypointgroup eg, entrypoint e, view_zip_distance zd, phone p
														where eg.entrypointgroup_id=" . $entrypointgroup_id . "
															and eg.entrypoint_id=e.entrypoint_id
															and e.active_flag=1
															and e.zipcode=zd.start_zipcode
															and zd.end_zipcode='" . $esi_zip . "'
															and zd.distance < 100
															and p.entrypoint_id=e.entrypoint_id
															and p.phonetype_id = 1
														union
														select e.entrypoint_id, 999999 distance,p.number
														from entrypoint_entrypointgroup eg, entrypoint e,phone p
														where eg.entrypointgroup_id=" . $entrypointgroup_id . "
															and eg.entrypoint_id=e.entrypoint_id
															and e.active_flag=1
															and e.zipcode is null
															and e.zipcode='" . $esi_zip . "'
															and p.entrypoint_id=e.entrypoint_id
															and p.phonetype_id = 1
														order by distance limit 1";
                            $epgEp_query = $bcudb->get_results($query_epgEp);
                            foreach ($epgEp_query as $epgEpObj):
                                $epgEpId = $epgEpObj->entrypoint_id;
                            endforeach;
                            $query_getEPGphone = "Select number from phone where entrypoint_id = " . $epgEpId . " and phonetype_id = 1 Limit 1";
                            $getEPGphone_query = $bcudb->get_results($query_getEPGphone);
                            if (count($getEPGphone_query) == 1) {
                                $epg_phone = $getEPGphone_query->number;
                            }
                            echo "<div><h4>SCSEP</h4><p>The Senior Community Service Employment Program (SCSEP) can boost your income by helping you return to work. SCSEP offers training and community service jobs for older workers who are eligible. Learn more:
								</p>";

                            echo "<a target='blank' href='/".$esiFactsheet."/?program_id=148&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'><i class='icon-info-sign'></i></a> <a target='blank' href='/".$esiFactsheet."/?program_id=148&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'>Employment - Senior Community Service Employment Program (SCSEP)</a><BR />";

                            echo "</div>";
                        }
                    }
                }
                unset($row);
                if ($employment_recs_count == 0) {
                    echo "There are no recommendations for you at this time; if your situation changes
please check back.";
                    ?>
                    <script type="text/javascript">
                        $("#employment_li").hide();
                        $("#employment").hide();
                    </script>
                    <?php

                }
                //unset($employment_recs_count);
                ?>
            </div>
        </div>
    </section>


    <section id="debt">
        <div class="body-header-wrapper"><h2><i class="icon-credit-card "></i> Debt &#38; Credit </h2>
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


                // Credit Report (post id 2754) and Debt Consolidation (postid 2758)

                $req5 = 0;
                $AFrow_index1 = searchForId('esi_debtscenarios_creditlimit', $AF_array);
                $AFrow_index2 = searchForId('esi_debtscenarios_minimum', $AF_array);
                $AFrow_index3 = searchForId('esi_debtscenarios_creditors', $AF_array);
                $AFrow_index4 = searchForId('esi_debtscenarios_bankruptcy', $AF_array);
                $AFrow_index5 = searchForId('esi_helpbalancing', $AF_array);
                if ((isset($AF_array[$AFrow_index1]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'n'))) {
                    $req1 = 1;
                }
                if ((isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] == 'n'))) {
                    $req2 = 1;
                }
                if ((isset($AF_array[$AFrow_index3]["option_code"]) && ($AF_array[$AFrow_index3]["option_code"] == 'n'))) {
                    $req3 = 1;
                }
                if ((isset($AF_array[$AFrow_index4]["option_code"]) && ($AF_array[$AFrow_index4]["option_code"] == 'n'))) {
                    $req4 = 1;
                }
                $req5 = $req1 + $req2 + $req3 + $req4;
                if ((isset($AF_array[$AFrow_index5]["option_code"]) && ($AF_array[$AFrow_index5]["option_code"] == 'y')) || ($req5 > 0)) {
                    $debt_recs["esi_report_credit_report"]["show"] = 1;
                    $debt_recs["esi_report_debt_consolidation"]["show"] = 1;
                }
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
                if (isset($AF_array[$AFrow_index]["response"])) {
                    $DebtPayment = $AF_array[$AFrow_index]["response"];
                }
                //echo "debt items:".$req5;
                //echo "<br>Debt Payment:".$DebtPayment;
                //echo "<br>Income:".$Income;
                if ($Income == 0 && $DebtPayment == 0) {
                    $debtRatio = 0;
                } else {
                    $debtRatio = $DebtPayment / $Income;
                }
                if ($DebtPayment == 0) {
                    $debtRatio = 0;
                }
                //echo "<br> Debt Ratio:".$debtRatio;
                if ($debtRatio > .5) {
                    $debt_recs["esi_report_debt_management"]["show"] = 1;
                }
                if ($req5 > 0) {
                    $debt_recs["esi_report_debt_management"]["show"] = 1;
                }
                unset($AFrow_index);

                // Single house value calculations (sum self and household home values)
                if (($esi_marital == "single") || ($esi_marital == "divorced") || ($esi_marital == "widowed") || ($esi_marital == "married_living_sep") || ($esi_marital == "esi_living_with_partner")) {
                    $totalHomeValue = ($s_asset_home + $hh_asset_home_simple) * .3;
                } // Married home value calculations (sum self, spouse, joint and household home values)
                else {
                    $totalHomeValue = ($s_asset_home + $sp_asset_home + $s_sp_asset_home_simple + $hh_asset_home_simple) * .3;
                }

                if ($mthlyDebtPayment >= $totalHomeValue && $totalHomeValue > 0) {
                    $debt_recs["esi_report_debt_managemnt"]["show"] = 1;
                    echo "<br>homevalue calc vs debt: greater than .3";
                }
                unset($AFrow_index);
                unset($calcIncome);

                //Identity Theft (postid = 2783)
                // Avoiding Scams (postid = 2773)
                $AFrow_index = searchForId('esi_interest_protect', $AF_array);
                $AFrow_index1 = searchForId('esi_helpbalancing', $AF_array);
                $req1 = 0;
                $req2 = 0;
                if ((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'y'))) {
                    $req1 = 1;
                }
                if ((isset($AF_array[$AFrow_index1]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'y'))) {
                    $req2 = 1;
                }
                $req3 = $req1 + $req2;
                if (1 == 1) {
                    $debt_recs["esi_report_identity_theft"]["show"] = 1;
                }
                unset ($AFrow_index);
                unset ($AFrow_index1);
                unset ($req1);
                unset ($req2);
                unset ($req3);

                // Bankruptcy (postid = 2766)

                //$debt_recs[4]["show"] = 1;
                $AFrow_index = searchForId('esi_debtscenarios_bankruptcy', $AF_array);
                if (isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) {
                    $debt_recs["esi_report_bankrupcy"]["show"] = 1;
                }
                unset($AFrow_index);

                // Show all 'Debt and Credit' Recommendations flagged with show == 1
                $num_debt_recs = count($debt_recs); // total possible recs in this section
                //$debt_recs_count = 0; // total recs to show based on responses.


                foreach ($debt_recs as $row => $rec) //$row has the key, e.g. esi_report_budget_3min
                    //for ($row = 0; $row < $num_debt_recs; $row++)
                {


                    if ($debt_recs[$row]["show"] !== 2) {
                        //$debt_recs_count = ++$debt_recs_count;
                        $current_id = $debt_recs[$row]["postid"];
                        $post = get_post($current_id);
                        $title = $post->post_title;
                        $desc = $post->post_content;
                        echo "<div>";
                        echo "<h4>" . $title . "</h4>";
                        echo "<p>" . $desc . "<BR />";
                        if (($debt_recs[$row]["post_code"] == "esi_report_debt_management") && ($totalAssets > 0)) {
                            echo "<p>Be sure to discuss with your counselor how your assets could be used to eliminate debt.</p>";
                        }
                        if ($debt_recs[$row]["bcu"] == 1) {
                            if (isset(${"links_" . $debt_recs[$row]["post_code"]})) {
                                foreach (${'links_' . $debt_recs[$row]["post_code"]} as $program_id) {
                                    $query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = " . $program_id . " LIMIT 1";
                                    $programName_query = $bcudb->get_results($query_programName);
                                    foreach ($programName_query as $programNameObj):
                                        $programTitle = $programNameObj->program_title;
                                        echo "<a target='blank' href='/".$esiFactsheet."/?program_id=" . $program_id . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'><i class='icon-info-sign'></i></a> <a target='blank' href='/".$esiFactsheet."/?program_id=" . $program_id . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'>" . $programTitle . "</a><BR />";
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

                }
                unset($row);
                if ($debt_recs_count == 0) {
                    echo "There are no recommendations for you at this time; if your situation changes
please check back.";
                }
                //unset($debt_recs_count);
                ?>
            </div>
        </div>
    </section>
    <section id="consumer">
        <div class="body-header-wrapper"><h2><i class="icon-lock "></i> Consumer Protections </h2>
            <div class="body-header" style="z-index: 999;">
                <div class="body-header-inner">

                </div>
            </div>
            <div></div>
        </div>
        <div class="">
            <div action="" method="get" id="commentForm" class="well cmxform">
                <?php


                // Legal Services (postid = 2768)

                $req4 = 0;
                $AFrow_index = searchForId('esi_retire_legal_concerns', $AF_array);
                $AFrow_index1 = searchForId('esi_interest_legal', $AF_array);
                $AFrow_index2 = searchForId('esi_retire_will', $AF_array);
                $req1 = 0;
                $req2 = 0;
                $req3 = 0;
                if ((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))) {
                    $req1 = 1;
                }
                if ((isset($AF_array[$AFrow_index1]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'n'))) {
                    $req2 = 1;
                }
                if ((isset($AF_array[$AFrow_index2]["option_code"]) && ($AF_array[$AFrow_index2]["option_code"] == 'n'))) {
                    $req3 = 1;
                }
                $req4 = $req1 + $req2 + $req3;
                //if($req4 >= 1){$consumer_recs[0]["show"] = 1;}
                //echo "legal servcies:".$req4;

                $AFrow_index = searchForId('esi_retire_legal_concerns', $AF_array);
                if ((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))) {
                    $links_esi_report_legal_services = array();
                    foreach ($Program_array as $i => $row) {
                        $value = $row["program_code"];
                        //echo $value;
                        $searchIndex = strpos($value, 'legal_fd_legal_services_and_prog');
                        if (is_numeric($searchIndex)) {
                            $consumer_recs["esi_report_legal_services"]["show"] = 1;
                            $links_esi_report_legal_services[] = $row["program_id"];
                        }
                    }
                }
                unset ($req1);
                unset ($AFrow_index);
                unset ($AFrow_index1);
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
                /*
                Lynna Cekova: removed as per bug 7855
                                    $AFrow_index = searchForId('esi_interest_legal', $AF_array);
                                    if ($userAge > 59){
                                    if((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))){$consumer_recs[5]["show"] = 1;}
                                    }
                                    unset($searchIndex);
                                    unset ($AFrow_index);
                */

                // Power of Attorney (postid = 2771)
                $req3 = 0;
                $AFrow_index = searchForId('esi_retire_poa', $AF_array);
                $AFrow_index1 = searchForId('esi_retire_legal_concerns', $AF_array);
                $req1 = 0;
                $req2 = 0;
                if ((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))) {
                    $req1 = 1;
                }
                if ((isset($AF_array[$AFrow_index1]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'n'))) {
                    $req2 = 1;
                }
                $req3 = $req1 + $req2;
                if ($req3 >= 1) {
                    $consumer_recs["esi_report_power_attorney"]["show"] = 1;
                }
                //echo "pow:".$req3;
                unset ($req1);
                unset ($AFrow_index);
                unset ($AFrow_index1);


                // Avoiding Scams (postid = 2773)
                $AFrow_index = searchForId('esi_interest_protect', $AF_array);
                $AFrow_index1 = searchForId('esi_helpbalancing', $AF_array);
                $req1 = 0;
                $req2 = 0;
                if ((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))) {
                    $req1 = 1;
                }
                if ((isset($AF_array[$AFrow_index1]["option_code"]) && ($AF_array[$AFrow_index1]["option_code"] == 'y'))) {
                    $req2 = 1;
                }
                $req3 = $req1 + $req2;
                if ($req3 >= 1) {
                    $consumer_recs["esi_report_avoiding_scams"]["show"] = 1;
                }
                unset ($AFrow_index);
                unset ($AFrow_index1);
                unset ($req1);
                unset ($req2);
                unset ($req3);
                // Adult Protective Services (postid = 2775) - disabled
                //$AFrow_index = searchForId('esi_interest_aps', $AF_array);
                //if((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))){$consumer_recs["esi_report_adult_protective"]["show"] = 1;}
                //unset($AFrow_index);

                // Writing a Will (postid = 2777)
                $AFrow_index = searchForId('esi_retire_legal_concerns', $AF_array);
                if ((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n'))) {
                    $consumer_recs["esi_report_writing_will"]["show"] = 1;
                }


                //Legal Assistance Hotline (postid = 11930, post_code = esi_report_legal_assistance)
                $AFrow_index = searchForId('esi_interest_legal', $AF_array);
                if ((isset($AF_array[$AFrow_index]["option_code"]) && ($AF_array[$AFrow_index]["option_code"] == 'n')) && $userAge >= 60) {
                    $consumer_recs["esi_report_legal_assistance"]["show"] = 1;
                }


                unset($AFrow_index);

                // Show all 'Consumer Protections' Recommendations flagged with show == 1
                $num_consumer_recs = count($consumer_recs); // total possible recs in this section
                $consumer_recs_count = 0; // total recs to show based on responses.


                foreach ($consumer_recs as $row => $rec) //$row has the key, e.g. esi_report_budget_3min
                    //for ($row = 0; $row < $num_consumer_recs; $row++)
                {


                    if ($consumer_recs[$row]["show"] !== 2) {
                        $consumer_recs_count = ++$consumer_recs_count;
                        $current_id = $consumer_recs[$row]["postid"];
                        $post = get_post($current_id);
                        $title = $post->post_title;
                        $desc = $post->post_content;
                        echo "<div>";
                        echo "<h4>" . $title . "</h4>";
                        echo "<p>" . $desc . "</p>";
                        if ($title == 'Legal Services') {
                            echo "<a target='blank' href='/".$esiFactsheet."/?program_id=160&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'><i class='icon-info-sign'></i></a> <a target='blank' href='/".$esiFactsheet."/?program_id=160&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'>Legal Services and Assistance Programs</a><BR />";

                        }
                        echo "</div>";
                        if ($consumer_recs[$row]["bcu"] == 1) {
                            if (isset(${"links_" . $consumer_recs[$row]["post_code"]})) {
                                foreach (${'links_' . $consumer_recs[$row]["post_code"]} as $value) {
                                    $theResult = mysql_query("select display_text from display_language where language_id='EN' and display_id =" . $Program_array[$value]["name_display_id"] . " LIMIT 0, 1");
                                    while ($pnameRow = mysql_fetch_assoc($theResult)) {
                                        $pname[] = $pnameRow;
                                    }
                                    echo "<a target='blank' href='/".$esiFactsheet."/?program_id=" . $Program_array[$value]["program_id"] . "&state_id=" . $state_id . "&county=" . $county . "&zip=" . $esi_zip . "&screeningID=" . $screeningID . "&shadowID=" . $shadowID . "'>" . $pname[0]["display_text"] . "</a>";
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
                    echo "There are no recommendations for you at this time; if your situation changes please check back.";
                }
                //unset($consumer_recs_count);
                ?>
            </div>
        </div>
    </section>


    <div>Have you used EconomicCheckUp to make the most of your money?
        <a href="mailto:economiccheckup@ncoa.org">Tell us</a> how it worked for you.
    </div>

    <br/>
    <div class="printButton printReport">
<?php
if (isset($_GET["eversafe_read_only"])){
if ($_GET["eversafe_read_only"] == 'true'){
$eversafeReadOnly = true;
}
}
if (substr($reportClient, 0, 27) == "/eversafe-quickcheck-report"){
        echo '<form id="reportButtonEversafeForm"><a data-toggle="modal" role="button" class="btn btn-large" href="#" onClick="javascript:PrintDivEversafe();"><i
                    class="icon-print "></i> Print Your Report</a></form>
<form id="doneButtonEversafeForm">
';
if(!$eversafeReadOnly == true) {
echo '
<a role="button" class="btn btn-large" href="https://www.eversafe.com/?ecuRet=2';
if (isset($_SESSION["eversafe_id"])){echo '?eversafe_id='.$_SESSION["eversafe_id"]; }
echo '
" style="margin-left: 20px;">Done</a>
';
}


echo '
</form>
';
}
else {
        echo '<form><a data-toggle="modal" role="button" class="btn btn-large" href="#" onClick="javascript:PrintDiv();"><i
                    class="icon-print "></i> Print Your Report</a></form>
';

}
?>
    </div>

    <?php
    if ($dataBridge == true && $dataBridge2 != "true" && !(substr($reportClient, 0, 27) == "/eversafe-quickcheck-report")) { //user, not agency with databridge=true in url
        ?>
        <div class="printButton printReport">
            <form><a data-toggle="modal" role="button" class="btn btn-large" href="#"
                     onClick="window.open('/esi-data-bridge?zip=<?php echo $esi_zip ?>&county=<?php echo $countyId ?>&screeningID=<?php echo $screeningID ?>&shadowID=<?php echo $shadowID ?>')"></i>
                    Get Help in Your Community</a></form>
        </div>

        <?php
    }
    ?>


</div> <!--span8-->
<div class="span4">
    <div class="well sidebar-nav " style="z-index: 999; position: static; width:220px; top: 191px;">
        <legend><i class="icon-list-alt "></i> Sections</legend>
        <ol class="nav nav-list">
            <li id="money_li" class="active" class=""><a href="#money"><i class="icon-money "></i> Money Mgmt &#38;
                    Budgeting </a></li>
            <li id="housing_li" class=""><a href="#housing"><i class="icon-home "></i> Housing </a></li>
            <li id="health_li" class=""><a href="#health"><i class="icon-medkit "></i> Health </a></li>
            <li id="employment_li" class=""><a href="#employment"><i class="icon-certificate "></i> Employment &#38;
                    Training </a></li>
            <li id="debt_li" class=""><a href="#debt"><i class="icon-credit-card "></i> Debt &#38; Credit </a></li>
            <li id="consumer_li" class=""><a href="#consumer"><i class="icon-lock "></i> Consumer Protections </a></li>
        </ol>
        <BR>

        <?php
        if ($employment_recs_count == 0) {
            ?>
            <script type="text/javascript">
                $("#employment_li").hide();
                $("#employment").hide();
            </script>
            <?php

        }
        unset($employment_recs_count);
        ?>
        <?php
        if ($money_recs_count == 0) {
            ?>
            <script type="text/javascript">
                $("#money_li").hide();
                $("#money").hide();
            </script>
            <?php

        }
        unset($money_recs_count);
        ?>

        <?php
        if ($housing_recs_count == 0) {
            ?>
            <script type="text/javascript">
                $("#housing_li").hide();
                $("#housing").hide();
            </script>
            <?php

        }
        unset($housing_recs_count);
        ?>
        <?php
        if ($debt_recs_count == 0) {
            ?>
            <script type="text/javascript">
                $("#debt_li").hide();
                $("#debt").hide();
            </script>
            <?php

        }
        unset($debt_recs_count);
        ?>
        <?php
        if ($consumer_recs_count == 0) {
            ?>
            <script type="text/javascript">
                $("#consumer_li").hide();
                $("#consumer").hide();
            </script>
            <?php

        }
        unset($employment_recs_count);
        ?>
        <?php
        if ($health_recs_count == 0) {
            ?>
            <script type="text/javascript">
                $("#health_li").hide();
                $("#health").hide();
            </script>
            <?php

        }
        unset($health_recs_count);
        ?>


        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
            <form>

                <li><a data-toggle="modal" role="button" href="https://www.surveymonkey.com/s/3V39M9Z"
                       target="_blank"><i class="icon-user "></i> Send Us Your Feedback</a></li>


<?php
if (substr($reportClient, 0, 27) == "/eversafe-quickcheck-report"){
echo '
                <li><a data-toggle="modal" role="button" href="#" onClick="PrintDivEversafe();"><i class="icon-print "></i>
                        Printable Report</a></li>
';
}
else {
echo '
                <li><a data-toggle="modal" role="button" href="#" onClick="PrintDiv();"><i class="icon-print "></i>
                        Printable Report</a></li>
';

}
?>
                <br/>
                <li><a data-toggle="modal" role="button" href="/<?php echo $questAnswers; ?><?php if (isset($_SESSION["eversafe_id"])){echo '?eversafe_id='.$_SESSION["eversafe_id"]; }?>" target="_blank"><i
                            class="icon-check "></i> My CheckUp -- for a personalized report</a></li>
            </form>
        </ol>
        <?php
        if ($dataBridge == true && $dataBridge2 != "true" && !(substr($reportClient, 0, 27) == "/eversafe-quickcheck-report")) { //user, not agency with databridge=true in url
            ?>
            <div class="printButton">
                <form><a data-toggle="modal" role="button" class="btn" href="#"
                         onClick="window.open('/esi-data-bridge?zip=<?php echo $esi_zip ?>&county=<?php echo $countyId ?>&screeningID=<?php echo $screeningID ?>&shadowID=<?php echo $shadowID ?>')"></i>
                        Get Help in Your Community</a></form>
            </div>

            <?php
        }
        ?>


    </div>
</div>
<div id="learnmore" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="Learn More" aria-hidden="true"
     style="display: none;">
    <div class="modal-header" style="border:none;">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close <i class="icon-remove"></i>
        </button>

    </div>
    <div class="learnmoreModal_outer">
        <h2>Elder Index</h2>
        <div id="infobox" class="whitewell learnmoreModal_inner">
            Your measure of economic security was calculated using the Elder Index. You can
            find more on the Elder Index methodology designed by Wider Opportunities for
            Women and the Gerontology Institute at the University of Massachusetts Boston
            here: <a href="http://www.basiceconomicsecurity.org" target="_blank">www.basiceconomicsecurity.org</a>.

            <div align="center" class="clearfix"><br><br><a target="_blank" href="http://www.wowonline.org"><img
                        border="0" alt="Wider Opportunities for Women" title="Wider Opportunities for Women"
                        src="/cf/img/partners/economicsecurity/logo_wow.png"></a>
            </div>


        </div>

    </div>

    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    </div>
</div>
