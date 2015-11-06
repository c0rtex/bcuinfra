<script type="text/javascript">
var axel = Math.random() + "";
var a = axel * 10000000000000;
document.write('<iframe src="https://4381487.fls.doubleclick.net/activityi;src=4381487;type=searc942;cat=viewy846;ord=1;num=' + a + '?" width="1" height="1" frameborder="0" style="display:none"></iframe>');
</script>
<noscript>
<iframe src="https://4381487.fls.doubleclick.net/activityi;src=4381487;type=searc942;cat=viewy846;ord=1;num=1?" width="1" height="1" frameborder="0" style="display:none"></iframe>
</noscript>

<!-- End of DoubleClick Floodlight Tag: Please do not remove -->
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
$showAonButton = 0;
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
        <div class="body-header-wrapper">	<h2><i class="icon-bar-chart "></i> Summary </h2>	
         <div class="body-header" style="z-index: 999;">
            
          	</div>
     	</div>
       	
         	<div  id="commentForm" class="well cmxform">
          		<div>
<?php require('report/summary.php');?>					

              	</div>
            </div>
		
	</section>
	<section id="recs">  	
        <div class="body-header-wrapper">	<h2><i class="icon-user-md "></i>  Recommended Actions  </h2>	
          	<div class="body-header" style="z-index: 999;">
           
          	</div>
     		
     	</div>
     
	
	<div id="commentForm" class="well ">

<p>
		<ol>
		<?php 
			//print_r($content_array);
//part d			
				$query_contentPartD = "
SELECT Distinct
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id
from screening_content
where
(content_code like 'mqc_report_partd_savemoney' 
or content_code like 'mqc_report_partd_considerdifferent' or content_code like 'mqc_report_partd_considerpurchase')
and screening_id = $screeningID 
limit 1
";
				$content_query = $bcudb->get_results($query_contentPartD);
				foreach($content_query as $contentPartDObj):
			  		$post_id = $contentPartDObj->post_id;
					$content_code = $contentPartDObj->content_code;
			 		$post = get_post($post_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							//echo "<div>";
							//echo "<h4>" .$title. "</h4>";
							echo "<li>" .$desc. "</li>";
							//echo "<li>" .$desc."debug:".$content_code."</li>";	

					if ($content_code == 'mqc_report_partd_considerdifferent' || $content_code == 'mqc_report_partd_savemoney') {
					$showCalculator = 1;
					// Disabled Calculator for first release $showCalculator = 1;
					//echo '<br>

					//<div class="white well" align="center">
					//	<div class="btn-group" align="center">
  					//	<a align=center class="btn btn-info btn-large" href="/mqc-results/?'.$reportkey.'#savings"><strong> View Potential Cost Savings </strong></a>
					//	</div>
					//</div>
		
					//';
			
					}
					
					
					endforeach;	
			   		//echo "ShowCal:".$showCalculator;
			
							
//other partd
			//print_r($content_array);
			
				$query_contentPartD = "
SELECT Distinct
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id
from screening_content
where
content_code not like 'mqc_report_partd_savemoney' 
and content_code not like 'mqc_report_partd_considerdifferent'
and content_code not like 'mqc_report_partd_considerpurchase'
and content_code like 'mqc_report_partd_%'
and screening_id = $screeningID
";
				$content_query = $bcudb->get_results($query_contentPartD);
				foreach($content_query as $contentPartDObj):
			  		$post_id = $contentPartDObj->post_id;
					$content_code = $contentPartDObj->content_code;
			 		$post = get_post($post_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							//echo "<div>";
							//echo "<h4>" .$title. "</h4>";
							echo "<li>" .$desc. "</li>";	
							//echo "<li>" .$desc."debug other partd:".$content_code."</li>";
				endforeach;	
			
							
//ma plans
			//print_r($content_array);
			
				$query_contentPartD = "
SELECT Distinct
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id
from screening_content
where  
content_code like 'mqc_report_ma%'
and screening_id = $screeningID 
";
				$content_query = $bcudb->get_results($query_contentPartD);
				foreach($content_query as $contentPartDObj):
			  		$post_id = $contentPartDObj->post_id;
					$content_code = $contentPartDObj->content_code;
			 		$post = get_post($post_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							//echo "<div>";
							//echo "<h4>" .$title. "</h4>";
							echo "<li>" .$desc. "</li>";
							//echo "<li>" .$desc."debug:".$content_code."</li>";	
				endforeach;	
			
							
//other 
			//print_r($content_array);
			
				$query_contentPartD = "
SELECT
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id
from screening_content
where
content_code not like 'mqc_report_partd_%'
and content_code not like 'mqc_report_ma_%'
and content_code not like 'mqc_report_refer_bcu'
and content_code not like 'mqc_report_benefitsadvisor%'
and content_code not like 'mqc_report_searchplans'
and screening_id = $screeningID
";
				$content_query = $bcudb->get_results($query_contentPartD);
				foreach($content_query as $contentPartDObj):
			  		$post_id = $contentPartDObj->post_id;
					$content_code = $contentPartDObj->content_code;
			 		$post = get_post($post_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							//echo "<div>";
							//echo "<h4>" .$title. "</h4>";
							echo "<li>" .$desc. "</li>";
							//echo "<li>" .$desc."debug other:".$content_code."</li>";	
				endforeach;	
//more info search plans
$query_contentPartD = "
SELECT
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id
from screening_content
where
content_code not like 'mqc_report_partd_%'
and content_code not like 'mqc_report_ma_%'
and (content_code like 'mqc_report_benefitsadvisor%' or content_code like 'mqc_report_searchplans')
and content_code not like 'mqc_report_refer_bcu'
and screening_id = $screeningID
order by content_code asc
limit 1
";
				$content_query = $bcudb->get_results($query_contentPartD);
				foreach($content_query as $contentPartDObj):
			  		$post_id = $contentPartDObj->post_id;
					$content_code = $contentPartDObj->content_code;
			 		$post = get_post($post_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							//echo "<div>";
							//echo "<h4>" .$title. "</h4>";
							//echo "<li>" .$desc. "</li>";
				if ($content_code == 'mqc_report_benefitsadvisor_confirm' || $content_code == 'mqc_report_benefitsadvisor_summary' || $content_code == 'mqc_report_benefitsadvisor_challenge' || $content_code == 'mqc_report_benefitsadvisor_overwhelmed' ||  $content_code == 'mqc_report_benefitsadvisor_confident' ||  $content_code == 'mqc_report_benefitsadvisor_planning' ||  $content_code == 'mqc_report_searchplans' ||  $content_code == 'mqc_report_benefitsadvisor_medicare') {
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
  						<a class="btn btn-info btn-large" href="/screening-contact/?state='.$state_lower.'&'.$reportkey.'"> CONTACT AON HEWITT NAVIGATORS </a>
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
					$desc3  = str_replace('<span class="learnmore"></span>',$buttontext, $desc2);
					$desc4  = str_replace('<span class="transitionlink"></span>',$transitiontext, $desc3);
					echo "<li>" .$desc4. "</li>";
					
				}
				else {
				
				echo "<li>" .$desc. "</li>";
				}
				
				if ($content_code == 'mqc_report_benefitsadvisor_confirm' || $content_code == 'mqc_report_benefitsadvisor_summary' || $content_code == 'mqc_report_benefitsadvisor_challenge' || $content_code == 'mqc_report_benefitsadvisor_overwhelmed' ||  $content_code == 'mqc_report_benefitsadvisor_confident' ||  $content_code == 'mqc_report_benefitsadvisor_planning' ||  $content_code == 'mqc_report_benefitsadvisor_medicare') {
					$learnMore = 1;
					$showAonButton = 1;
					IF (1 == 0){
					echo '<br>

					<div class="white well" align="center">
						<div class="btn-group" align="center">

  						<a class="btn btn-info btn-large" href="/screening-contact/?state='.$state_lower.'&'.$reportkey.'"> Click Here to Contact a Licensed Insurance Agent </a>
  						<!-- <a class="btn btn-info btn-large" href="/medicarequickcheck-transition/?state='.$state_lower.'&'.$reportkey.'"> Click Here to Contact a Licensed Insurance Agent </a> -->
  						<!-- <a class="btn btn-info btn-large" href="#mqc_contactform" role="button" data-toggle="modal"> Click Here to Contact a Licensed Insurance Agent </a> -->
						</div>
					</div>
		
					';
					}
				}
				
				endforeach;	
							

		?>
		</ol>
</p>



		
	</section>

	<?php 

			$query_contentBCU = "
SELECT
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id
from screening_content
where
content_code like 'mqc_report_refer_bcu'
and post_id = 3690
and screening_id = $screeningID
limit 1
";

$content_query = $bcudb->get_results($query_contentBCU);
				foreach($content_query as $contentBCUObj):
			  		$post_id = $contentBCUObj->post_id;
					$content_code = $contentBCUObj->content_code;
			 		$post = get_post($post_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							//echo "<div>";
								//echo '<section id="apply" class="well">';  	
  								//echo '<div class="body-header-wrapper">';  
							
	
  		
			 $counter = 0;
			//print_r($Program_array);
			$numrowsBCU = count ($Program_array);
			//echo $numrows;
			if ($numrowsBCU > 0 ) {
			echo '<h2><i class="icon-ok-sign"></i> Apply for Benefits</h2>';
			echo '<p>Based on your responses to the Medicare QuickCheck, you should consider
applying for the following benefit program(s) which can help you pay for your
healthcare and prescription drugs. Click on the links below to access program
fact sheets which include benefit descriptions, program application forms, and
local offices to apply for programs.</p>';
			}
			foreach ($Program_array as $i => $row){
				$program_id = $row["program_id"];
				//echo "program_id ".$program_id;
				$query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = ".$program_id." LIMIT 1";
				$programName_query = $bcudb->get_results($query_programName);
				foreach($programName_query as $programNameObj):
					$counter++;
			  		$programTitle = $programNameObj->program_title;
			 		 echo "<a href='/medicarequickcheck-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$mqc_zipcode."&screeningID=".$screeningID."&shadowID=".$shadowID."'><i class='icon-info-sign'></i></a> <a href='/medicarequickcheck-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$mqc_zipcode."&screeningID=".$screeningID."&shadowID=".$shadowID."'>".$programTitle."</a><BR />";
				endforeach;	
			}
			if ($counter == 0) {
				 echo "<p></p>";
				}	


				
				
			
//echo '<h2  id="benefits"><i class="icon-ok-sign"></i> Learn About All of the Benefits Available to You </h2>';
//echo "<p>" .$desc. "</p>";								

echo '		
  	</div>
	</section>
';
endforeach;	
?>
  	    	    
<div>
<div class="span5">
   	<div  class="well " id="your-report">
        <legend><i class="icon-list-alt "></i> Your Report</legend>
        <ol class="nav nav-list">
	   <li class="active"><a href="#summary"><i class="icon-bar-chart "></i> Summary </a></li>
          <li ><a href="#recs"><i class="icon-user-md "></i> Recommended Actions </a></li>
          <?php if ($numrowsBCU > 0 )  { echo '<li class=""><a href="#apply"><i class="icon-money "></i> Apply for Benefits</a></li>'; } ?>
        </ol>
  		<?php if ($learnMore > 0 )  { echo '<div class="btn-group" align="left">
  						<a class="btn btn-info btn-large" href="/screening-contact/?state='.$state_lower.'&'.$reportkey.'"> Contact Aon Hewitt Navigators </a>
  						
						</div>	
						'; } ?>	 				
	</div>
<?php if ($showAonButton == 1) {
echo '
<div class="well" id="your-report">
<div align=center><img src="/wp-content/uploads/2014/01/MQC_call-center_woman_small.jpg" alt="Speak to a Licensed Insurance Agent" /></div>
<p><strong>If you'; echo "'"; echo 'd like to speak to a licensed insurance agent, call: 1-800-975-9655 (TTY Dial 711).</strong></p>
<p> Hours: Monday-Friday, 8 a.m. - 8 p.m. (CST). Closed on holidays.</p>
<p><a href="https://www.mymedicarematters.org/about/ncoa-mymedicarematters-aon-hewitt-navigators/" target="_new">Learn more</a> about Aon Hewitt Navigators and why NCOA recommends them.</p>
</p>
</div>';
}
?>

</div> <!--span7-->
<?php 
//get contact form to display (starts invisible)
//require_once "screening_user_bodyv2.php";
?>


	<div  style="z-index: 999; position: static; width:300px; top: 191px;">
	
       <?php if ($showCalculator == 1) { echo '		
   	<BR>

        <ol class="nav nav-list"><li>
	<iframe src="https://ncoa.picwell.net/mqc?session_id='.$screeningID."-".$_GET['request_id']."&zipcode=".$_SESSION['zipcode'].'&profile=test"  class="medium"  style="height:900px"  frameborder="0"></iframe>
	</li>
	</ol>
        '; } ?>
       </div>  
</div>



</div>
