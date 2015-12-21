<?php
// Processing Fields and submit to NCOA MQC web service
//Loop Over Posted Fields, generate XML and Send a request to the soap service to process data for report
//echo 'Fields Posted: <br>';
//echo "<pre>";
//print_r($_POST);
//echo 'debug start:';
$subset_id = $_POST['subset_id'];
//echo $subset_id;
$subsetID = $_POST['subset_id'];
//echo $subset_id;
require_once('_custom/soap_client.php');

//Create simple xml to send to server
$answerset_xml = '
<?xml version="1.0" encoding="utf-16"?>
<ScreeningSet>
<Screening Subset_id="'.$subset_id.'">';
//loop over post vars - something like this
foreach( $_POST as $key=>$value ) {
  //debug fields and values set as xml
  echo "key".$key."value=".$value."<br>";
  $answerset_xml = $answerset_xml.'
<Answer AnswerField="'.$key.'" AnswerValue="'.$value.'" ></Answer>';
}
$answerset_xml = $answerset_xml.'
</Screening>
</ScreeningSet>
';
//echo 'debug next:';

//debug xml output
echo "<br>Debug - New XML: </br>";
//echo $answerset_xml;
echo "<pre>";
echo $answerset_xml;
echo "</pre>";
//exit();

//Send XML to Web Service to Process Report
if ($subset_id == 79) {
//doTriage
  $screeningresponse_query = $soapClient->doTriage(14,'','0',$answerset_xml,'');
}
elseif ($subset_id == 83) {
//do screening
  $screeningresponse_query = $soapClient->doScreening(77,'',0,$answerset_xml,'');
}
elseif ($subset_id == 93) {
//do screening
  $screeningresponse_query = $soapClient->doScreening(0,'',0,$answerset_xml,'');
}
else {
//do screening
  $screeningresponse_query = $soapClient->doScreening(14,'','0',$answerset_xml,'');
}
//$screeningresponse_query = restructureWSArray($screeningresponse_query);

print_r($screeningresponse_query);
echo 'done printing....';


//output debug info - response data from service
//echo "<pre><b>Service Response:</b>";
//print_r($screeningresponse_query);
foreach($screeningresponse_query as $screeningresponseObj):
  $screening_id = $screeningresponseObj["screening_id"];
  if ($subset_id == 79){
    $next_subset_id = $screeningresponseObj["next_subset_id"];
    $state_id = $screeningresponseObj["state_id"];
  }
endforeach;

//if triage get next subset id and redirect user to new quesitonnaire
if ($subset_id == 79){

  if ($next_subset_id == 75){
    $link = '/medicare-quickcheck-4/?subset_id=75&partner_id=14&prevID='.$screening_id.'&triage=true&state_id='.$state_id;
  }
  elseif ($next_subset_id == 74){
    $link = '/medicare-quickcheck-4/?subset_id=74&partner_id=14&prevID='.$screening_id.'&triage=true&state_id='.$state_id;
  }
  else {
    $link = '/medicare-quickcheck-4/?subset_id=72&partner_id=14&prevID='.$screening_id.'&triage=true&state_id='.$state_id;
  }
//Link to Report page or redirect to it
//echo "<p>ScreeningID = ".$screening_id."<br><br>";
//echo "NextSubsetID = ".$next_subset_id."<br><br>";
//echo '<center><a data-toggle="modal" class="btn btn-large btn-recs" href="'.$link.'">Next Steps</a></a></center>';
  header("Location: ".$link);
  echo '<META
     HTTP-EQUIV="Refresh"
     CONTENT="0; URL='.$link.'">';
}
//the rest of the subsets use this to continue to report page
else {

  $link = '/mqc-results-4/?screeningID='.$screening_id.'&shadowID='.$screening_id.'&subset_id='.$subset_id;
  if ($subset_id == 83){
    $link = '/esi-quickcheck-report/?subset_id=83&partner_id=77&screeningID='.$screening_id.'&shadowID='.$screening_id;
  }
  else if ($subset_id == 93) {
    $link = '/quickcheck-report/?subset_id=93&partner_id=0&screeningID='.$screening_id.'&shadowID='.$screening_id;
  }
//echo '<center><a data-toggle="modal" class="btn btn-large btn-recs" href="'.$link.'">Continue</a></center>';
  header("Location: ".$link);
  echo '<META
     HTTP-EQUIV="Refresh"
     CONTENT="0; URL='.$link.'">';
}
?>