<?php 
				//print_r($content_array);
				//all			
				$sectionCode = 'enrollment_period';
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
			  		$chartpost_id = $contentPartDObj["POST_ID"];
					$chartcontent_code = $contentPartDObj["CONTENT_CODE"];
					$chartpost = $soapClient->getWPPost($chartpost_id);
					//$post = restructureWSArray ($post);
					//echo ("<pre>");
					//print_r($post);


					
                                  	       
				 
				endforeach;
//echo "chart:".$chartcontent_code.$chartpost_id;
//show chart info
if ($chartcontent_code == 'mqc_report_iep_chart' )  { 
//$iep_descriptor = apply_filters('the_content', get_post_field('post_content', 12755));
$descriptor1 = $soapClient->getWPPost(12755);
$section_code = 'iep';
$showIEP = 1;
}
elseif ($chartcontent_code == 'mqc_report_sep_chart' )  { 
//$sep_descriptor = apply_filters('the_content', get_post_field('post_content', 12794));
$descriptor1 = $soapClient->getWPPost(12794);
$section_code = 'sep';
$showSEP = 1;
}
//else {
//$descriptor = $soapClient->getWPPost('12794');
//$section_code = 'sep';
//}
//$descriptor = restructureWSArray ($descriptor);
$charttext = str_replace('<span class="enrollment_startdate"></span>',$enrollment_startdate, $descriptor1[0]["POST_CONTENT"]);
$charttext = str_replace('<span class="enrollment_enddate"></span>',$enrollment_enddate, $charttext);
$title = $descriptor[0]["POST_TITLE"];
if (($showSEP > 0)||($showIEP > 0 )){
echo '
	<section id="'.$section_code.'">  	
        <div class="body-header-wrapper">	<h2 id="iepChartShow" > '.$title.' </h2>	
          	<div class="body-header" style="z-index: 999;">          
          	</div>
     	</div>	

<div id="iepChartShow_more">
	<div id="commentForm" class="well ">'.$charttext.'

</div>
</section>';
}

?>
