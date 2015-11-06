<?PHP
$functionDebugging = "false"; // Debugging on = true and Debugging off = false
//TBD - Need to move DB connections to DB help functions
$bcudb = new wpdb(DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU,DB_HOST_BCU);
$bcudb->show_errors();
$state = 'california';
/* 5017990, 5018048, 5017788, 5017774, 5017603 */
$screeningID = -1; 
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
	$county_title = ucwords(strtolower($county));
	//echo "zip:".$mqc_zip;
	//echo $county;


	
			
	
?>
<div class="span8" id="printContent">  
	<section id="summary"> 
        <div class="body-header-wrapper">	<h2><i class="icon-bar-chart "></i> Summary </h2>	
         <div class="body-header" style="z-index: 999;">
            	<div class="body-header-inner">
                	<div class="">
                        
                  	</div>
            	</div>
          	</div>
     		<div></div>
     	</div>
       	<div class="">
         	<div action="" method="get" id="commentForm" class="well cmxform">
          		<div>
<?php require('report/summary.php');?>					
              	</div>
            </div>
		</div>
	</section>
	<section id="recs">  	
        <div class="body-header-wrapper">	<h2><i class="icon-user-md "></i>  Recommended Actions  </h2>	
          	<div class="body-header" style="z-index: 999;">
            	<div class="body-header-inner">
                	<div class="">
                      
                  	</div>
            	</div>
          	</div>
     		<div></div>
     	</div>
        <div class="">
	
	<div id="commentForm" class="well cmxform">

<p>Based on your questionnaire responses, we recommend:
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
content_code like 'mqc_report_partd_savemoney' 
or content_code like 'mqc_report_partd_consider%'
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

					if ($content_code == 'mqc_report_partd_considerdifferent' || $content_code == 'mqc_report_partd_considerpurchase' || $content_code == 'mqc_report_partd_savemoney') {
					echo '<br>

					<div class="white well" align="center">
						<div class="btn-group" align="center">
  						<a align=center class="btn btn-info btn-large" href="/mqc-results/?'.$reportkey.'#savings"><strong> View Potential Cost Savings </strong></a>
						</div>
					</div>
		
					';
			
					}
				endforeach;	
			
							
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
and content_code not like 'mqc_report_partd_consider%'
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
							//echo "<li>" .$desc."debug:".$content_code."</li>";
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
							//echo "<li>" .$desc."debug:".$content_code."</li>";	
				endforeach;	

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
							echo "<li>" .$desc. "</li>";
							//echo "<li>" .$desc."debug:".$content_code."</li>";	

				if ($content_code == 'mqc_report_benefitsadvisor_confirm' || $content_code == 'mqc_report_benefitsadvisor_summary' || $content_code == 'mqc_report_benefitsadvisor_challenge' || $content_code == 'mqc_report_benefitsadvisor_overwhelmed' ||  $content_code == 'mqc_report_benefitsadvisor_confident' ||  $content_code == 'mqc_report_benefitsadvisor_planning') {
					echo '<br>

					<div class="white well" align="center">
						<div class="btn-group" align="center">
  						<a class="btn btn-info btn-large" href="/medicarequickcheck-transition/?state='.$state_lower.'&'.$reportkey.'"><strong> Click Here to Contact a Benefits Advisor </strong></a>
						</div>
					</div>
		
					';
				}
				endforeach;					

		?>
		</ol>
</p>


	</div>
	</div>
		
	</section>

	
		<section id="savings" class="well">  	
  	<div class="body-header-wrapper"><h2><i class="icon-ok-sign "></i> Estimated Savings </h2>			
         <div class="body-header" style="z-index: 999;">
            	<div class="body-header-inner">
                	<div class="">
                        
                  	</div>
            	</div>
          	</div>
     		<div></div>
     	</div>
    <div><h4>How much could you save on prescription drugs in 2014?</h4>
		
		   		<p>It is likely that you could save this much or more by switching to a different Medicare Part D plan in 2014. If these savings are important to you, we recommend that you take the next step to find a better plan for you using one of the options we've recommended above.		
		<br><br><span align=center>
		<a  class="btn btn-large" href="/_custom/loadpicwell.php?session_id=<?php echo $screeningID."-".$_GET['request_id']."&zipcode=".$_SESSION['zipcode']; ?>" target="picwellframe">
			Calculate Savings <i class="icon-chevron-down" ></i> </a> </span>
       	</p>
              <div >
			
		     		<iframe class="well" name="picwellframe" scrolling="no" frameborder="0" width="475" height="500" src="/_custom/loadpicwell.php?session_id=<?php echo $screeningID."-".$_GET['request_id']."&zipcode=".$_SESSION['zipcode']; ?>">
				
				</iframe>
              </div>
      
  	</div>
	</section>
	
	<section id="apply" class="well">  	
  	<div class="body-header-wrapper">	
  		<h2><i class="icon-ok-sign"></i> Apply for Benefits</h2>
		<p>You should apply for the following benefit programs which can help you pay for your healthcare and prescription drug costs.</p>
		<?php $counter = 0;
			//print_r($Program_array);
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

			$query_contentBCU = "
SELECT
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id
from screening_content
where
content_code like 'mqc_report_refer_bcu'
and screening_id = $screeningID
";
				$content_query = $bcudb->get_results($query_contentBCU);
				foreach($content_query as $contentBCUObj):
			  		$post_id = $contentBCUObj->post_id;
					$content_code = $contentBCUObj->content_code;
			 		$post = get_post($post_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							//echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "</p>";	
				endforeach;	
			
							

		?>	
  	</div>
	</section>
   
	    	    
</div> <!--span8-->
<div class="span4">
   	<div class="well sidebar-nav " style="z-index: 999; position: static; width:220px; top: 191px;">
        <legend><i class="icon-list-alt "></i> Your Report</legend>
        <ol class="nav nav-list">
	   <li class="active"><a href="#summary"><i class="icon-bar-chart "></i> Summary </a></li>
          <li class=""><a href="#recs"><i class="icon-user-md "></i> Recommended Actions </a></li>
          <li class=""><a href="#savings"><i class="icon-ok-sign "></i> Cost Savings </a></li>
          <li class=""><a href="#apply"><i class="icon-money "></i> Apply for Benefits</a></li>
        </ol>
        <br>
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">  	
            <li><form><a data-toggle="modal" role="button" href="#" onClick="javascript:PrintDiv();"><i class="icon-print "></i> Printable Report</a></form></li>
        </ol>		
    </div>	  
</div>


