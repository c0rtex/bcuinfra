<?PHP
$functionDebugging = "false"; // Debugging on = true and Debugging off = false
//TBD - Need to move DB connections to DB help functions
$bcudb = new wpdb(DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU,DB_HOST_BCU);
$bcudb->show_errors();
$state = 'california';
/* 5017990, 5018048, 5017788, 5017774, 5017603 */
$screeningID = -1; 
$showCalculator = 0;
$learnMore = 0;
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
$query_getSAF = "SELECT a.answerfield, o.option_id, o.option_code, sa.response FROM answerfield a INNER JOIN screening_answerfield sa ON sa.answerfield_id = a.answerfield_id LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id WHERE sa.screening_id= ".$screeningID." ORDER BY sa.pagenum, a.answerfield, sa.submit_datetime";

$result = mysql_query($query_getSAF);

while($AFrow = mysql_fetch_assoc($result)){
	/* Inside while loop */
    $AF_array[] = $AFrow;
}

$query_getAFShadow = "SELECT a.answerfield, o.option_id, o.option_code, sa.response FROM answerfield a INNER JOIN screening_answerfield sa ON sa.answerfield_id = a.answerfield_id LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id WHERE sa.screening_id= ".$shadowID." ORDER BY sa.pagenum, a.answerfield, sa.submit_datetime";

$result = mysql_query($query_getAFShadow);

while($AFShadowrow = mysql_fetch_assoc($result)){
	/* Inside while loop */
    $AFShadow_array[] = $AFShadowrow;
}
//print_r($AF_array);

function searchForId($id, $array){
	foreach ($array as $key => $val){
		if ($val["answerfield"] === $id){
			return $key;
		}
	}
	return null;
}
$age_id = searchForId('dob', $AFShadow_array);
$age = $AFShadow_array[$age_id]["response"];
$query_getPrograms = "select distinct sp.program_id, p.programcategory_id, p.program_code, p.name_display_id from program p INNER JOIN screening_program sp ON sp.program_id = p.program_id where screening_id = ".$shadowID;
$result1 = mysql_query($query_getPrograms);
while($ProgramRow = mysql_fetch_assoc( $result1)){
    $Program_array[] = $ProgramRow;
}
// debug to show programcategory_ids returned for the shadow screening
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
	if (isset($AF_array[$AFrow_index]["response"])){
		$string_zip = "and z.zipcode = ".$AF_array[$AFrow_index]["response"];	
		$mqc_zipcode = $AF_array[$AFrow_index]["response"];
		$_SESSION['zipcode'] = $mqc_zipcode;
		//echo $_SESSION['zipcode'];
		//echo "zip:".$mqc_zipcode.$_SESSION['zipcode'];
	} 
	else {
		$string_zip = "and (1 = 0)";
	}
	unset ($AFrow_index);
	// Get County using zip
	$query_getCounty = "SELECT
z.zipcode,
z.county_id,
c.county_id,
c.state_id,
c.county_name,
c.valid,
c.map_id,
c.update_valid,
state.state_name
FROM
county AS c
INNER JOIN zip AS z ON z.county_id = c.county_id
INNER JOIN state ON state.state_id = c.state_id
".$string_zip;
	$resultCounty = mysql_query($query_getCounty);
	while($CountyRow = mysql_fetch_assoc($resultCounty)){
    	$County_array[] = $CountyRow;
	}
	unset($resultCounty);
	$county = trim($County_array[0]["county_name"]);
	$modifiedCountyName = trim($County_array[0]["county_name"])." County";
	$state_id = trim($County_array[0]["state_id"]);
	$state = trim($County_array[0]["state_name"]);
	$state_lower = strtolower($state);
	$state_lower = str_replace(" ", "-",$state_lower);
	$state_lower = str_replace(",", "",$state_lower);
	$county_title = ucwords(strtolower($county));
	//echo "zip:".$mqc_zip;
	//echo $county;
	

$query_getShip = "select program_id from program where program_code like 'counseling%_ship' and active_flag = 1 and state_id = '".$state_id."'";

?>
<div class="span7" id="printContent"> 
<center><img alt="MedicareQuickCheck" title="MedicareQuickCheck" src="/wp-content/uploads/2013/12/Medicare-QuickCheck.jpg"></center> 
	<section id="summary"> 
        <div class="body-header-wrapper">	<h2><i class="icon-user-md "></i> Summary </h2>	
         <div class="body-header" style="z-index: 999;">
            
          	</div>
     	</div>
       	
         	<div  id="commentForm" class="well cmxform">
          		<div>
<?php require('report/summary_mqc3.php');
//echo "testing:".$showSEP.$showIEP.$age3months;
?>				
              	</div>
            </div>		
	</section>
<?php if ($showIEP > 0 )  { 
$iep_descriptor = apply_filters('the_content', get_post_field('post_content', 12755));
echo '
	<section id="iep">  	
        <div class="body-header-wrapper">	<h2><i class="icon-bar-chart  "></i> Initial Enrollment Period (IEP) Chart</h2>	
          	<div class="body-header" style="z-index: 999;">          
          	</div>
     	</div>	
	<div id="commentForm" class="well ">
<p>
<ol>
<li>Your Initial Enrollment Period (IEP) is or was '.$enrollment_startdate.' through '.$enrollment_enddate.'.<br><br><img src="/cf/img/mqc3_iep_chartv2.jpg" alt="IEP Chart"><br><br>
'.$iep_descriptor.'
</li></ol>
</p>	
	</section>';} ?>

<?php if ($showSEP > 0 )  { 
$sep_descriptor = apply_filters('the_content', get_post_field('post_content', 12794));
echo '
	<section id="sep">  	
        <div class="body-header-wrapper">	
		<h2><i class="icon-bar-chart  "></i> When You Should Sign Up for Medicare</h2>	   		
     	</div>	
	<div id="commentForm" class="well ">
<p>
<ol>
<li>Your Initial Enrollment Period (IEP) is or was '.$enrollment_startdate.' through '.$enrollment_enddate.'.<br><br>
<img src="/cf/img/mqc_sep_chart.jpg"><br><br>'.$sep_descriptor.'</li>
</ol>	
	</section>'; } ?>

	<section id="recs"> 
        <div class="body-header-wrapper">	
		<h2><i class="icon-user-md "></i> Recommended Actions</h2>	
     	</div>
     
	<div id="commentForm" class="well ">

<p>
		<ol>
		<?php 
			//print_r($content_array);
//all			
				$query_contentPartD = "
SELECT Distinct
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id,
subset_content.sort_order
FROM
screening_content
INNER JOIN subset_content ON subset_content.post_code = screening_content.content_code 
where
content_code not like 'mqc_report_benefitsadvisor_new_to_medicare' and content_code not like 'mqc_report_searchplans_new_to_medicare' 
and content_code not like 'mqc_report_refer_bcu_ntm_strong' and content_code not like 'mqc_report_refer_bcu_ntm' 
and screening_id = $screeningID and subset_content.subset_id='75' and subset_content.section_code = 'mqc3'
order by sort_order
limit 10
";

				$content_query = $bcudb->get_results($query_contentPartD);

//echo ("content_query 1");
//var_dump($content_query);

				foreach($content_query as $contentPartDObj):
			  		$post_id = $contentPartDObj->post_id;
					$content_code = $contentPartDObj->content_code;
			 		$post = get_post($post_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							$desc  = str_replace('{spap_nm}',$spap_name, $desc);
							$desc  = str_replace('{medicaid_nm}',$medicaid_name, $desc);
							echo "<li>" .$desc. "</li>";



					
					
				endforeach;	


//bcu info
$query_contentPartD = "
SELECT Distinct
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id,
subset_content.sort_order
FROM
screening_content
INNER JOIN subset_content ON subset_content.post_code = screening_content.content_code
where
(content_code like 'mqc_report_refer_bcu_ntm_strong' or content_code like 'mqc_report_refer_bcu_ntm' )
and screening_id = $screeningID and subset_content.subset_id = '75' and subset_content.section_code = 'mqc3'

order by sort_order
limit 1
";

				$content_query = $bcudb->get_results($query_contentPartD);

//echo ("content_query 2");
//var_dump($content_query);

				foreach($content_query as $contentPartDObj):
			  		$post_id = $contentPartDObj->post_id;
					$content_code = $contentPartDObj->content_code;
			 		$post = get_post($post_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<li>" .$desc. "</li>";

				endforeach;	
		?>
		</ol>
</p>		
	</section>
	<section id="ways"> 
        <div class="body-header-wrapper">	<h2><i class="icon-user-md"></i> Ways to Get Help</h2>	
	<div class="body-header" style="z-index: 999;">
          	</div>		
     	</div>
     
	
	<div id="commentForm" class="well ">

<p>
		<ol>
<?php
										
//ways to get help
//print_r($content_array);

$query_contentWays = "
SELECT 
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id,
subset_content.sort_order
FROM
screening_content
INNER JOIN subset_content ON subset_content.post_code = screening_content.content_code
where
(content_code like 'mqc_report_benefitsadvisor_new_to_medicare' or content_code like 'mqc_report_searchplans_new_to_medicare') 
and subset_content.subset_id='75' and subset_content.section_code = 'mqc3'

and screening_id = $screeningID limit 1
";
			

				$content_query = $bcudb->get_results($query_contentWays);
//echo ("content_query 3");
//var_dump($content_query);

				foreach($content_query as $contentWaysObj):
			  		$post_id = $contentWaysObj->post_id;
					$content_code = $contentWaysObj->content_code;
			 		$post = get_post($post_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							//echo "<div>";
							//echo "<h4>" .$title. "</h4>";
					//check to show aon button link
					if ($content_code == 'mqc_report_benefitsadvisor_new_to_medicare' ) {
					$learnMore = 1;
					}

					
							if ($content_code == 'mqc_report_benefitsadvisor_new_to_medicare' ||  $content_code == 'mqc_report_searchplans_new_to_medicare') {
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
/* Lynna: code needed for the NO-TRACKING version
					$buttontext = '<a href="/medicarequickcheck-transition/?state='.$state_lower.'&'.$reportkey.'">Learn more</a> about Aon Hewitt Navigators and why NCOA recommends them. <br>
					
						<div class="btn-group" align="left">
  						<a class="btn btn-info btn-large" href="/medicarequickcheck-transition/?state='.$state_lower.'&'.$reportkey.'"> CONTACT AON HEWITT NAVIGATORS </a>
						</div>
					
					';
*/
/* Lynna: code needed for the IN-PAGE form
					$buttontext = '
					
						<div class="btn-group" align="left">
  						<a class="btn btn-info btn-large" href="#mqc_contactform" role="button" data-toggle="modal"> CONTACT AON HEWITT NAVIGATORS </a>
						</div>
					
					';
*/
					$buttontext = '
						<div class="btn-group" align="left">
  						<a class="btn btn-info btn-large" href="/cf/redirect.cfm?id=57&tgt=1&partner_id=14&visible=false&'.$reportkey.'"> CONTACT AON HEWITT NAVIGATORS </a>
						</div>
					
					';
					$buttontext = '
						<div  align="left" id="ahnButton">
  						<a class="" target="blank" href="/cf/redirect.cfm?id=61&tgt=1&partner_id=14&visible=false&'.$reportkey.'"><img src="/wp-content/uploads/2014/06/Computer_60x60.png" alt="Compare Plans Online" title="Compare Plans Online"> Compare Plans Online </a>&nbsp;&nbsp;&nbsp;&nbsp;
						
  						<a class="" href="/cf/redirect.cfm?id=51&tgt=1&partner_id=14&visible=false&'.$reportkey.'"><img src="/wp-content/uploads/2014/06/Phone_60x60.png" alt="Request a Phone Appointment" title="Request a Phone Appointment"> Request a Phone Appointment</a>
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
					$transitiontext = '<a href="/carriers/'.$page_template.'">Click here</a>';
					$desc2  = str_replace('<span class="shipinfo"></span>',$page, $desc);
					$desc3  = str_replace('<span class="learnmoreButton"></span>',$buttontext, $desc2);
					$desc4  = str_replace('<span class="transitionlink"></span>',$transitiontext, $desc3);
					echo "<li>" .$desc4. "</li>";
					
				}
				else {
				echo "<li>" .$desc. "</li>";
				}
				endforeach;	
						
		?>
		</ol>
</p>
	</section>
</div>  	    	    
<div class="span5">
	<?php  echo '<div class="well" id="your-report"><h2> Recommended Ways to Get Help</h2>
	<h3>State Health Insurance Assistance Program (SHIP)</h3>
	<p><a href="#ship" >Find</a> the government-sponsored program in your locality for help comparing
Medicare options.</p>
	<!--Lynna Cekova: removed the legend code so that a gray line does not show -->
	';
	if ($learnMore > 0 )  {
	echo '
<legend></legend>
	<h3>Aon Hewitt Navigators&reg;</h3><p>Get expert guidance about your Medicare coverage.</p>
	<ul>
       <li><p><a href="/cf/redirect.cfm?id=62&tgt=1&partner_id=14&visible=false&'.$reportkey.'" target="_blank">Compare</a> supplemental insurance plans online.</p></li>
       <li><a class="" href="/cf/redirect.cfm?id=51&tgt=1&partner_id=14&visible=false&'.$reportkey.'">Request</a> a telephone appointment with a licensed insurance agent to help
you make enrollment decisions.	</li></ul>						
	'; } 
echo '<legend></legend>
	<h3>Medicare.gov</h3>
	<p><a href="#medicare" >Explore</a> your Medicare options yourself using the federal government&apos;s website.</p>
	';?>	
<?php echo '</div>

            <div class="printButton"><form><a data-toggle="modal" class="btn btn-large btn-recs" href="#" onClick="javascript:PrintDiv();"><i class="icon-print "></i> Print Your Report</a></form></div>

'; ?>
</div> <!--span7-->
</div>


