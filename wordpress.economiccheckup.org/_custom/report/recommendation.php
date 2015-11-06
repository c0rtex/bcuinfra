	<section id="recs"> 
        <div class="body-header-wrapper">	
		<h2 id="recShow" class="showMore" >Recommended Actions</h2>	
     	</div>    

<div id="recShow_more" >
	<div id="commentForm" class="well ">
	<p>
		<ol>
		<?php 
				//print_r($content_array);
				//all			
				$sectionCode = 'recommendations';
				$subsetId =  $_GET['subset_id'];
//echo $screeningID;
				$content_query = $soapClient->getRecContentBySection($screeningID, $subsetId, $sectionCode);
				//$content_query = restructureWSArray($content_query);
//echo "<pre>";
//print_r ($content_query);

				//echo ("content_query 1");
				//var_dump($content_query);
				//exit;
				foreach($content_query as $contentPartDObj):
			  		$post_id = $contentPartDObj["POST_ID"];
					$content_code = $contentPartDObj["CONTENT_CODE"];
					$post = $soapClient->getWPPost($post_id);
					//$post = restructureWSArray ($post);
					//echo ("<pre>");
					//print_r($post);


			 		//$post = get_post($post_id); 
							$title = $post[0]["POST_TITLE"];
							$desc = $post[0]["POST_CONTENT"];
							$desc  = str_replace('{spap_nm}',$spap_name, $desc);
							$desc  = str_replace('{medicaid_nm}',$medicaid_name, $desc);
					
					
					//check to show aon button link
					if ($content_code == 'mqc_report_benefitsadvisor_new_to_medicare' ) {
						$learnMore = 1;
					}
					
                                  	if ($content_code == 'mqc_report_refer_bcu_ntm_strong' ||  $content_code == 'mqc_report_refer_bcu_ntm') {  
						$showbcu ++;
						$isbcu = 1;
					}
				  	else {

						$isbcu = 0;
				  	}        
				   
				  if ($content_code == 'mqc_report_benefitsadvisor_new_to_medicare' ||  $content_code == 'mqc_report_searchplans_new_to_medicare') {
					 $contentWaysCounter ++;
					$ship_query = $bcudb->get_results($query_getShip);
					//print_r($ship_query);
					foreach($ship_query as $shipObj):
			  		$ship_id = $shipObj->program_id;
							$title = $post->post_title;
							$desc = $post->post_content;
							//echo "<div>";
							//echo "<h4>" .$title. "</h4>";
							//echo "<p>Ship: " .$ship_id. "</p>";
							 $program_id = $ship_id;
							 $zip = $mqc_zipcode;
							 //require_once('factsheet/getep.php');
							echo '<br>';

						
						$nodirectepoutput = 1;
  						require_once('factsheet/getep.php');					 
							//?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$mqc_zipcode."	
					endforeach;

					$buttontext = '
						<div  align="left" id="ahnButton">
  						<a class="" target="blank" href="/cf/redirect.cfm?id=61&tgt=1&partner_id=14&visible=false&'.$reportkey.'" onClick="javascript:aonFloodlightCompareIcon();window.location.reload()" ><img src="/wp-content/uploads/2014/06/Computer_60x60.png" alt="Compare Plans Online" title="Compare Plans Online"> Compare Plans Online </a>&nbsp;&nbsp;&nbsp;&nbsp;
						
  						<a class="" href="/cf/redirect.cfm?id=51&tgt=1&partner_id=14&visible=false&'.$reportkey.'"  onClick="javascript:aonFloodlightRequestIcon()"  ><img src="/wp-content/uploads/2014/06/Phone_60x60.png" alt="Request a Phone Appointment" title="Request a Phone Appointment"> Request a Phone Appointment</a>
						</div>
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
?>
		
						
		
		</ol>
	</p>
	</section>
