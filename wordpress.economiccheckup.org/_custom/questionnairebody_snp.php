<div id="printContent" class="span8"> 
<img alt="MedicareQuickCheck" title="Medicare QuickCheck Logo" src="/wp-content/uploads/2014/10/Medicare-QuickCheck_logo_425x72.jpg">
<?php 
//echo 'Test';
if (isset($_GET["subset_id"])){
$subsetID = htmlspecialchars($_GET["subset_id"]);
}
else {
 $subsetID = 81;
}

require_once('soap_client.php');
require_once('displaycontent_mqc_4.php');

if (isset($_GET["partner_id"])){
$partnerID = htmlspecialchars($_GET["partner_id"]);
}
else{
 $partnerID = 14;
}
if (isset($_GET["state_id"])){
$stateID = htmlspecialchars($_GET["state_id"]);
}
else{
 $stateID = 'FD';
}

if (isset($_GET["triage"])){
$triage = htmlspecialchars($_GET["triage"]); //questionnaires called from the triage
}

//echo $subsetID;

//echo "<pre>";
//print_r ($soapClient);






//function mqc3Script (){
//wp_enqueue_script( 'mqc-js-3' ); //include mqc_v3.js
//}

//add_action( 'wp_enqueue_scripts', 'mqc3Script' );

//$screening_id = $_GET['Screening_id'];

if (isset($_POST['continue']))
{
	$continue = $_POST["continue"];
if ($continue == 2){
	require_once('processquestions_mqc_4.php'); //this file is not important
	}
}
?>


<?php  require_once('questionnaire/header_includes.php'); 

if ($subsetID == 72 || $subsetID == 74 || $subsetID == 81){ //MQC1 or MQC2
//echo '<form name="mqcForm" id="mqcForm" action="/process_mqc.php" method="post" > ';
//echo '<form name="mqcForm" id="mqcForm" action="/process_mqc.php" method="post" > ';
echo '<form name="mqcForm" id="mqcForm" action="../process_next.php" method="post" > ';
}
elseif ($subsetID == 75 ) { // mqc3
//echo '<form name="mqcForm3" id="mqcForm3" action="/process_mqc.php" method="post" > ';
echo '<form name="mqcForm3" id="mqcForm3" action="../process_next.php" method="post" > ';
}
else { // triage, subset_id 79
echo '<form name="mqcForm3" id="mqcForm3" action="../process_next.php" method="post" > ';
}

//Show Intro and legend Section
/*$sectionLegend*/

if ($subsetID == 72 || $subsetID == 81){ //MQC1
//echo '<form name="mqcForm" id="mqcForm" action="../process_next.php" method="post" > ';
$sectionLegendPost = $soapClient->getWPPost('13698');
}
elseif ($subsetID == 75 ) { // mqc3
$sectionLegendPost = $soapClient->getWPPost('12360');
}
else if ($subsetID == 74){ // MQC2
$sectionLegendPost = $soapClient->getWPPost('3403');
}

//$sectionLegend = apply_filters('the_content', get_post_field('post_content', 12360));
//$sectionLegendPost = restructureWSArray ($sectionLegendPost);
$sectionLegend = $sectionLegendPost[0]["POST_CONTENT"];

//$sectionLegend = $soapClient->getWPPost('3484');

			  //Warning Message regarding validation errors
				if ( isset($_GET['badresponselist'])) {
				echo '<div class="alert alert-error">';
      				echo "<p><i class='icon-warning-sign'></i> We're sorry, but some responses are missing or were completed incorrectly. Please correct the problems where indicated below.</p></div>";
				}
			  //Show Intro text under basics section
                       echo '<p>'.$sectionLegend.'</p>';


?> 
<?php  require_once('section_mqc_4.php'); 

echo '<input type="hidden" name="subset_id" value="'.$subsetID.'">';
 ?>
<button class="btn btn-large btn " id="view_results" type="submit" value="View Your Report" ><i class="icon-chevron-right"></i><i class="icon-chevron-right"></i> View Your Report </button>
</div> 
<!--span8-->
<div class="span4">
   	<div class="well sidebar-nav" >
        <legend><i class="icon-list-alt "></i> Sections </legend>
        <ol class="nav nav-list">
            <li class="active"><a href="#basics"><i class="icon-pencil "></i> Basics <span style="display: none;" id="status-basics">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Done</strong></em></span></a></li>
            <li class=""><a href="#health"><i class="icon-medkit "></i>  Your Health Insurance Coverage <span style="display: none;" id="status-employment">&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Done</strong></em></span></a></li>
            <li class=""><a href="#optional"><i class="icon-file "></i> A Few More Questions <span style="display: none;" id="status-interested">&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Done</strong></em></span></a></li>	
	</ol><br>
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
            <li><a data-toggle="modal" role="button" href="#gettingstarted"><i class="icon-question-sign "></i> Getting Started </a></li>
	     <li><a data-toggle="modal" role="button" target="_new" href="https://www.mymedicarematters.org/get-help/glossary/"><i class="icon-book "></i> Glossary of Terms </a></li>
            <li><a data-toggle="modal" role="button" href="#" onClick="javascript:PrintDiv();"><i class="icon-print "></i> Print a Copy</a></li>
            <!--li><a data-toggle="modal" role="button" href="#referafriend"><i class="icon-link "></i> Refer A Friend </a></li -->
        </ol>		
    </div>	  
</div>

<?php 
if (isset($_GET['screeningID'])) {
echo '<input type="hidden" name="screeningID" value="'.$_GET['screeningID'].'">';
}


?>
</form>
<div id="gettingstarted" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="Getting Started" aria-hidden="true" style="display: none;">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close <i class="icon-remove"></i></button>
    <div><h2>Getting Started</h2></div>
  </div>
  <div class="modal-body">
<?php 
//get info for popup from webservice content db
$neededInfo = $soapClient->getWPPost('3484');
//$neededInfo = restructureWSArray ($neededInfo);
echo $neededInfo[0]["POST_CONTENT"];

?>	
  </div>

  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>


<div id="medicareInfo" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="Medicare Information aria-hidden="true" style="display: none;">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close <i class="icon-remove"></i></button>
    <div><h2>Medicare Information</h2></div>
  </div>
  <div class="modal-body">
<div class="alert alert-danger"><i class="icon-warning-sign"></i>

<?php
//$neededMedicareInfo = apply_filters('the_content', get_post_field('post_content', 3421));
if ($subsetID == 72  || $subsetID == 81){ //MQC1
$neededMedicareInfo = $soapClient->getWPPost('13572');
}
else if ($subsetID == 74) { //MQC2
$neededMedicareInfo = $soapClient->getWPPost('13570');
}
else if ($subsetID == 75){ //MQC3
$neededMedicareInfo = $soapClient->getWPPost('3421');
}
else if ($subsetID == 79){ //triage
$neededMedicareInfo = $soapClient->getWPPost('13574');
}
//$neededMedicareInfo = restructureWSArray ($neededMedicareInfo);
//echo ("<pre>");
//print_r ($neededMedicareInfo);

echo $neededMedicareInfo[0]["POST_CONTENT"];
?>

</div> 
  </div>

  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>
<?php  require_once('questionnaire/footer_includes.php'); ?> 

