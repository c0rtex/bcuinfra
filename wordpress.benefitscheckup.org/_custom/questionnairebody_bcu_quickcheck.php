<?php 
  require_once('soap_client.php');
  $benefitsPost = $soapClient->getWPPostByMetaTag('bcu_quickcheck_homepage_heading_introduction');
  $leadtext = $benefitsPost[0]["POST_CONTENT"];
  //print_r($benefits ); 
  
 ?>

<h2><?php print $benefitsPost[0]["POST_TITLE"]; ?></h2>
<p id="feature_paragraph"><?php print $leadtext ?></p>

<p>
<a id="getStartedBCUButton" href="#bcu_quickcheck" data-toggle="modal" data-target="#bcu_quickcheck">                    
<img id="getStartedBCUQuickcheck" src="/wp-content/uploads/2011/09/getstarted.png"></a></p>


<div id="bcu_quickcheck" class="modal hide fade " tabindex="-1" role="dialog" aria-labelledby="QuickCheck" aria-hidden="true" style="display: none;">
  <div class="well modal-body">
<div id="bcuQuickcheckTitle">
<button aria-hidden="true" data-dismiss="modal" class="btn" id="bcuQuickcheckClose">Close <i class="icon-remove"></i> </button>
<h2 class="bcuQuickcheckTitle">BenefitsCheckUp&reg;</h2>
</div>

<div id="printContent">
  <?php

  if (isset($_GET["subset_id"])){
    $subsetID = htmlspecialchars($_GET["subset_id"]);
  }
  else {
    $subsetID = 93;
  }

  //echo 'Test '.$subsetID;
  require_once('displaycontent_bcu_quickcheck.php');

  if (isset($_GET["partner_id"])){
    $partnerID = htmlspecialchars($_GET["partner_id"]);
  }
  else{
    $partnerID = 0;
  }
  if (isset($_GET["state_id"])){
    $stateID = htmlspecialchars($_GET["state_id"]);
  }
  else{
    $stateID = 'FD';
  }








  //function mqc3Script (){
  //wp_enqueue_script( 'mqc-js-3' ); //include mqc_v3.js
  //}

  //add_action( 'wp_enqueue_scripts', 'mqc3Script' );

  //$screening_id = $_GET['Screening_id'];

  if (isset($_POST['continue']))
  {
    $continue = $_POST["continue"];
    if ($continue == 2){
      require_once('processquestions_bcu_quickcheck.php'); //this file is not important
    }
  }

  ?>


  <?php  require_once('questionnaire/header_includes.php');

  if ($subsetID == 72 || $subsetID == 74){ //MQC1 or MQC2
//echo '<form name="mqcForm" id="mqcForm" action="/process_mqc.php" method="post" > ';
//echo '<form name="mqcForm" id="mqcForm" action="/process_mqc.php" method="post" > ';
    echo '<form name="mqcForm" id="mqcForm" action="/process_next.php" method="post" > ';
  }
  elseif ($subsetID == 75 ) { // mqc3
//echo '<form name="mqcForm3" id="mqcForm3" action="/process_mqc.php" method="post" > ';
    echo '<form name="mqcForm3" id="mqcForm3" action="/process_next.php" method="post" > ';
  }
  else {
    echo '<form name="bcuQuickcheckForm" id="bcuQuickcheckForm" action="/process_next.php" method="post" > ';
  }

  //Show Intro and legend Section
  /*$sectionLegend*/

  $sectionLegendPost = $soapClient->getWPPostByMetaTag('bcu_quickcheck_questionnaire_heading_introduction');
  $sectionLegend = $sectionLegendPost[0]["POST_CONTENT"];

  //$sectionLegend = apply_filters('the_content', get_post_field('post_content', 12360));
  //$sectionLegendPost = restructureWSArray ($sectionLegendPost);
  $sectionLegend = $sectionLegendPost[0]["POST_CONTENT"];


  //Warning Message regarding validation errors
  if ( isset($_GET['badresponselist'])) {
    echo '<div class="alert alert-error">';
    echo "<p><i class='icon-warning-sign'></i> We're sorry, but some responses are missing or were completed incorrectly. Please correct the problems where indicated below.</p></div>";
  }
  //Show Intro text under basics section

  echo '<p>'.$sectionLegend.'</p>';

  echo '<div id="bcu_upper_section"></div>'


  ?>
  <?php  require_once('section_bcu_quickcheck.php');

  echo '<input type="hidden" name="subset_id" value="'.$subsetID.'">';
  ?>

<a id="esiQuickcheckSubmit" class="btn-ga" href="#bcu_quickcheck">
<center>
<img id="esiQuickcheckResultsButton" src="/wp-content/uploads/2015/05/ECUGetReportButton.jpg">
</center>
</a>

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

  <div class="modal-footer">
  </div>
</div>


<?php  require_once('questionnaire/footer_includes.php'); ?> 

