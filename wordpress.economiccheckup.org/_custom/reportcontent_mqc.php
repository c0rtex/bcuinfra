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
$shadowID = -1;
if (isset($_GET['shadowID']))
{
//echo "ScreeningID from questionnaire:".$_GET['screeningID'];
$shadowID = $_GET['shadowID'];
}

$query_getSAF = "SELECT a.answerfield, o.option_id, o.option_code, sa.response FROM answerfield a INNER JOIN screening_answerfield sa ON sa.answerfield_id = a.answerfield_id LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id WHERE sa.screening_id= ".$screeningID." ORDER BY sa.pagenum, a.answerfield, sa.submit_datetime";

$result = mysql_query($query_getSAF);

while($AFrow = mysql_fetch_assoc($result)){
	/* Inside while loop */
    $AF_array[] = $AFrow;
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
					<p><ul>
<li>You live in <?php echo $county_title; ?> county, <?php echo $state; ?> </li>
<li>You are 66 years old</li>
<li>You have Original Medicare and a Medigap Plan</li>
<li>You have Medicare A and B</li>
</ul></p>
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
	<p>Based on your questionnaire responses, we recommend (partd):
		<ol>
		<?php 
			//print_r($content_array);
//part d			
				$query_contentPartD = "
SELECT
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id
from screening_content
where
content_code like 'mqc_report_partd_savemoney' 
or content_code like 'mqc_report_partd_consider%'
and screening_id = -2 
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
							echo "<li>" .$desc. "(<i>Debug: ".$content_code."</i>)<br></li>";	
				endforeach;	
			
							

		?>
		</ol>
</p>
<p>Based on your questionnaire responses, we recommend (partd other info):
<ol>

		<?php 
//other partd
			//print_r($content_array);
			
				$query_contentPartD = "
SELECT
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id
from screening_content
where
content_code not like 'mqc_report_partd_savemoney' 
and content_code not like 'mqc_report_partd_consider%'
and content_code like 'mqc_report_partd_%'
and screening_id = -2 
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
							echo "<li>" .$desc. "(<i>Debug: ".$content_code."</i>)<br></li>";	
				endforeach;	
			
							

		?>
		</ol>
</p>

<p>Based on your questionnaire responses, we recommend( ma plans):
<ol>

		<?php 
//ma plans
			//print_r($content_array);
			
				$query_contentPartD = "
SELECT
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id
from screening_content
where
content_code like 'mqc_report_ma%'
and screening_id = -2 
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
							echo "<li>" .$desc. "(<i>Debug: ".$content_code."</i>)<br></li>";	
				endforeach;	
			
							

		?>
		</ol>
</p>
<p>Based on your questionnaire responses, we recommend (other info):
<ol>

		<?php 
//other partd
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
and screening_id = -2 
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
							echo "<li>" .$desc. "(<i>Debug: ".$content_code."</i>)<br></li>";	
				endforeach;	
			
							

		?>
		</ol>
</p>

<p>All Report Content:
		<ol>
		<?php 
//show all content
			//print_r($content_array);
			
				$query_content = "
SELECT
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id
from screening_content
where screening_id = -1";
				$content_query = $bcudb->get_results($query_content);
				foreach($content_query as $contentObj):
			  		$post_id = $contentObj->post_id;
					$content_code = $contentObj->content_code;
			 		$post = get_post($post_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							//echo "<div>";
							//echo "<h4>" .$title. "</h4>";
							echo "<li>" .$desc. "(<i>Debug: ".$content_code."</i>)<br></li>";	
				endforeach;	
			
					
		?>
		</ol>
	</p>
	</div>

	</div>
		
	</section>

	
		<section id="savings" class="well">  	
  	<div class="body-header-wrapper">	
  		<h2><i class="icon-ok-sign"></i> Cost Savings</h2>
    </div>
    <div><h4>How much could you save on prescription drugs in 2014?</h4>
            <ul class="nav nav-tabs" id="myTabs">
              <li><a href="#calculate" data-toggle="tab">Calculate Savings</a></li>
              <li><a href="#estimate" data-toggle="tab">Estimated Savings</a></li>
            </ul>
            
            <div class="tab-content">
              <div class="tab-pane active" id="calculate" data-src="">
			<div class="span8">
		     <iframe name="picwellframe" frameborder="0" width="550" height="450" src="/_custom/loadpicwell.php"></iframe>
			</div>
			<div class="span4"> <a href="/_custom/loadpicwell.php" target="picwellframe"><input type="button" class="btn" value="Calculate Savings" name="Calculate Savings"></a> 
                </div>
		     
                </div>
              <div class="tab-pane" id="estimate" data-src="">
               <h3>Estimated Savings</h3>
		   		<p>It is likely that you could save this much or more by switching to a different Medicare Part D plan in 2014. If these savings are important to you, we recommend that you take the next step to find a better plan for you using one of the options we've recommended above.</p>		
              </div>
            </div>
       
  	</div>
	</section>

	<section id="apply" class="well">  	
  	<div class="body-header-wrapper">	
  		<h2><i class="icon-ok-sign"></i> Apply for Benefits</h2>
		<p>Learn about and Apply for the benefits programs listed below:</p>
		<?php
			//print_r($Program_array);
			foreach ($Program_array as $i => $row){
				$program_id = $row["program_id"];
				//echo "program_id ".$program_id;
				$query_programName = "SELECT display_language.display_text as program_title FROM display_language INNER JOIN program ON program.name_display_id = display_language.display_id where language_id='EN' and  program_id = ".$program_id." LIMIT 1";
				$programName_query = $bcudb->get_results($query_programName);
				foreach($programName_query as $programNameObj):
			  		$programTitle = $programNameObj->program_title;
			 		 echo "<a href='/medicarequickcheck-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$mqc_zipcode."&screeningID=".$screeningID."&shadowID=".$shadowID."'><i class='icon-info-sign'></i></a> <a href='/medicarequickcheck-factsheet/?program_id=".$program_id."&state_id=".$state_id."&county=".$county."&zip=".$mqc_zipcode."&screeningID=".$screeningID."&shadowID=".$shadowID."'>".$programTitle."</a><BR />";
				endforeach;	
			}
				
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


