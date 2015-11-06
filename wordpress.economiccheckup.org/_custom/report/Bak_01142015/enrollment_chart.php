<?php 
//show chart info
if ($showIEP > 0 )  { 
//$iep_descriptor = apply_filters('the_content', get_post_field('post_content', 12755));
$descriptor = $soapClient->getWPPost('12755');
$section_code = 'iep';
}
elseif ($showSEP > 0 )  { 
//$sep_descriptor = apply_filters('the_content', get_post_field('post_content', 12794));
$descriptor = $soapClient->getWPPost('12794');
$section_code = 'sep';
}
else {
$descriptor = $soapClient->getWPPost('12794');
$section_code = 'sep';
}
//$descriptor = restructureWSArray ($descriptor);
$charttext = str_replace('<span class="enrollment_startdate"></span>',$enrollment_startdate, $descriptor[0]["POST_CONTENT"]);
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
