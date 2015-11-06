
		<?php 
				$query_getShip = "select program_id from program where program_code like 'counseling%_ship' and active_flag = 1 and state_id = '".$state_id."'";
				//print_r($content_array);
				//all	
				$count = 0;		
				$sectionCode = 'waystogethelp';
				$subsetId =  $_GET['subset_id'];
				$content_query = $soapClient->getRecContentBySection($screeningID, $subsetId, $sectionCode);
				//$content_query = restructureWSArray($content_query);

				//echo ("content_query 1");
				//var_dump($content_query);
				foreach($content_query as $contentPartDObj):
			  		$post_id = $contentPartDObj["POST_ID"];
					$content_code = $contentPartDObj["CONTENT_CODE"];
					$post = $soapClient->getWPPost($post_id);
					//$post = restructureWSArray ($post);
					$count++;
					//echo ("<pre>");
					//print_r($post);
					if ($count == 1){
					echo '
							<section id="ways"> <div class="body-header-wrapper">	<h2 id="waysShow">Ways to Get Help </h2>	
     							</div>    
							<div id="commentForm" class="well ">

					<div id="waysShow_more">
							<p>
							<ol>
					';
					}

			 		//$post = get_post($post_id); 
							$title = $post[0]["POST_TITLE"];
							$desc = $post[0]["POST_CONTENT"];
							$desc  = str_replace('{spap_nm}',$spap_name, $desc);
							$desc  = str_replace('{medicaid_nm}',$medicaid_name, $desc);
					
					
					//check to show aon button link mqc_report_benefitsadvisor_annual_enrollment
					if (($content_code == 'mqc_report_benefitsadvisor_new_to_medicare') ||($content_code == 'mqc_report_benefitsadvisor_ahn_right_for_you') ||($content_code == 'mqc_report_benefitsadvisor_annual_enrollment') ) {
						$learnMore = 1;
					}
					
                                  	if ($content_code == 'mqc_report_refer_bcu_ntm_strong' ||  $content_code == 'mqc_report_refer_bcu_ntm') {  
						$showbcu ++;
						$isbcu = 1;
					}
				  	else {

						$isbcu = 0;
				  	}        
				   $hasshipinfo = strpos($desc, '<span class="shipinfo"></span'); 

				  if ($hasshipinfo !== false) {
					 $contentWaysCounter ++;
					$ship_query = $bcudb->get_results($query_getShip);
					//print_r($ship_query);
					foreach($ship_query as $shipObj):
			  		$ship_id = $shipObj->program_id;
							//echo "<div>";
							//echo "<h4>" .$title. "</h4>";
							//echo "<p>Ship: " .$ship_id. "</p>";
							 $program_id = $ship_id;
							 $zip = $mqc_zipcode;
							 //require_once('factsheet/getep.php');
							echo '<br>';

						
						$nodirectepoutput = 1;
  						require_once('_custom/factsheet/getep.php');					 
							//?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$mqc_zipcode."	
					endforeach;

$phoneLinkText = 0;
$compareLinkText = 0;

if ($subsetId == 72){
$phoneLinkText = 65;
$compareLinkText = 68;
}
else if ($subsetId == 74){

$phoneLinkText = 67;
$compareLinkText = 70;
}

else if ($subsetId == 75){

$phoneLinkText = 57;
$compareLinkText = 61;
}					
				
					$buttontext = '
						<div  align="left" id="ahnButton">
  						<a class=""  href="https://www.benefitscheckup.org/cf/redirect.cfm?id='.$compareLinkText.'&tgt=1&partner_id=14&visible=false&'.$reportkey.$appendurl.'" onClick="javascript:aonFloodlightCompareIcon();'." ga('send', 'event', 'mqc', 'MQC Results Page (Compare AON Button)', 'resultscomparebtn'); ga('mmm.send', 'event', 'mqc', 'MQC Results Page (Compare AON Button)', 'resultscomparebtn');  ".'" ><img src="/wp-content/uploads/2014/06/Computer_60x60.png" alt="Compare Plans Online" title="Compare Plans Online"> Compare Plans Online </a>&nbsp;&nbsp;&nbsp;&nbsp;
						
  						<a class="" href="https://www.benefitscheckup.org/cf/redirect.cfm?id='.$phoneLinkText.'&tgt=1&partner_id=14&visible=false&'.$reportkey.$appendurl.'"  onClick="javascript:aonFloodlightRequestIcon();'."
 ga('send', 'event', 'mqc', 'MQC Results Page (Request AON Button)', 'resultsreqbtn'); ga('mmm.send', 'event', 'mqc', 'MQC Results Page (Request AON Button)', 'resultsreqbtn'); ".'" ><img src="/wp-content/uploads/2014/06/Phone_60x60.png" alt="Request a Phone Appointment" title="Request a Phone Appointment"> Request a Phone Appointment</a>
						</div>
					
					';



					$page_template = $state_lower;
					if ($page_template == 'alaska' ) {
 						$page_template = 'carriers_ak';
					}
					elseif ($page_template == 'montana' ) {
 						$page_template = 'carriers_mt';
					}
					elseif ($page_template == 'oklahoma' ) {
 						$page_template = 'carriers_ok';
					}
					elseif ($page_template == 'oregon' ) {
 						$page_template = 'carriers_or';
					}
					elseif ($page_template == 'mississippi' ) {
 						$page_template = 'carriers_ms';
					}
					elseif ($page_template == 'maine' ) {
						$page_template = 'carriers_me';
					}
					elseif ($page_template == 'florida' ) {
 						$page_template = 'carriers_fl';
					}
					$transitiontext = '<a href="https://www.benefitscheckup.org/carriers/state-carrier/?state_id='.$state_id.'">Click here</a>';
					$desc2  = str_replace('<span class="shipinfo"></span>',$page, $desc);
					$desc3  = str_replace('<span class="learnmoreButton"></span>',$buttontext, $desc2);
					$desc4  = str_replace('<span class="transitionlink"></span>',$transitiontext, $desc3);
					

					$desc = $desc4;
					
				   }

				
				
					if ( ($isbcu !== 1) || ($showbcu < 2)) {
					echo "<li>" .$desc. "</li>";
					}
				endforeach;
				if  ($count > 0) {

				echo '	</ol>
				</p>

</div>
				</section>';	
				}
?>
		
						
		
	
