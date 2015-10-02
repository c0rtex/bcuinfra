<?php 
// Example SOAP client for NCOA MQC web service
//Loop Over Posted Fields, generate XML and Send a request to the soap service to process data for report

//echo 'Fields Posted: <br>';
//echo "<pre>";
//print_r($_POST);
/*
if (isset($_GET["subset_id"])){
$subsetID = htmlspecialchars($_GET["subset_id"]);
}
else {
 $subsetID = 79;
}
*/

$subset_id = $_POST['subset_id'];
require_once('_custom/soap_client.php');

//Create simple xml to send to server
$answerset_xml = '
<?xml version="1.0" encoding="utf-16"?>
<ScreeningSet>
<Screening Subset_id="75">
';
//loop over post vars - something like this
foreach( $_POST as $key=>$value ) {
   //debug fields and values set as xml
  //echo "key".$key."value=".$value."<br>";
  $answerset_xml = $answerset_xml.'
<Answer AnswerField="'.$key.'" AnswerValue="'.$value.'" ></Answer>';
}
$answerset_xml = $answerset_xml.'
</Screening>
</ScreeningSet>
';


//debug xml output
//echo "<br>Debug - New XML: </br>";
//echo $answerset_xml;
//echo "<pre>";
//echo $answerset_xml;
//echo "</pre>";
//exit();

//Send XML to Web Service to Process Report

$screeningresponse_query = $soapClient->doScreening(14,'abc-22-33',44,$answerset_xml);

//print_r($screeningresponse_query);
//$screeningresponse_query = restructureWSArray($screeningresponse_query);

//output debug info - response data from service
//echo "<pre><b>Service Response:</b>";
//print_r($screeningresponse_query);
foreach($screeningresponse_query as $screeningresponseObj):
 $screening_id = $screeningresponseObj["screening_id"];
endforeach;

//Link to Report page or redirect to it
//echo "ScreeningID = ".$screening_id."<br><br>";
$link = '/mqc-results-4/?screeningID='.$screening_id.'&shadowID='.$screening_id;
echo '<a data-toggle="modal" class="btn btn-large btn-recs" href="'.$link.'">View Report - Results Page Link</a>';
echo '<META 
     HTTP-EQUIV="Refresh"
     CONTENT="2; URL='.$link.'">';
?>
