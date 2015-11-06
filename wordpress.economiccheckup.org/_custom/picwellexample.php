<?PHP
$functionDebugging = "false"; // Debugging on = true and Debugging off = false
//TBD - Need to move DB connections to DB help functions
$bcudb = new wpdb('esidtc','W6ApuXec','esidtc','172.31.33.35');
$bcudb->show_errors();

/* 5017990, 5018048, 5017788, 5017774, 5017603 */
$screeningID = 5020607; 
if (isset($_GET['screeningID']))
{
//echo "ScreeningID from questionnaire:".$_GET['screeningID'];
$screeningID = $_GET['screeningID'];
}
$shadowID = 5020608;
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

function searchForId($id, $array){
	foreach ($array as $key => $val){
		if ($val["answerfield"] === $id){
			return $key;
		}
	}
	return null;
}

$query_getPrograms = "select sp.program_id, p.programcategory_id, p.program_code, p.name_display_id from program p INNER JOIN screening_program sp ON sp.program_id = p.program_id where screening_id = ".$shadowID;
$result1 = mysql_query($query_getPrograms);
while($ProgramRow = mysql_fetch_assoc( $result1)){
    $Program_array[] = $ProgramRow;
}
// debug to show programcategory_ids returned for the shadow screening
/*foreach ($Program_array as $i => $row){
	echo $row["programcategory_id"]." | ";	
}*/

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
?>
<div class="span8" id="printContent">  
	<section id="summary"> 
        <div class="body-header-wrapper">	<h2><i class="icon-bar-chart "></i> Summary of Your Current Situation </h2>	
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
<li>You live in Cook County</li>
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
	<p>Because you said (answers from Q10-13), we recommend...
			<ol><li>We strongly recommend that you consider a different Medicare Part D plan. Answer these two questions to find out how much you could save on Medicare Part D </li>
			<li>Click <a href="#savings">here</a> to view your potential cost savings below.</li>
			<li>Learn about and Apply for benefits programs. Click <a href="#apply">here</a>.</li>
				</ol>
				 </p>
	</div>

	</div>
		
	</section>
	
	<section id="savings" class="well">  	
  	<div class="body-header-wrapper">	
  		<h2><i class="icon-ok-sign"></i> Cost Savings</h2>
		<p>It's possible you could saving money......placeholder text.placeholder text.placeholder text.placeholder text.placeholder text</p>
      	Your Part D plan:<input type="text"><br>
	Your medications:<input type="text"><br>
	<input type="button" class="btn btn-large" value="Calculate Savings" name="Calculate Savings" >
		<h3>Cost Savings Estimate: $120.77</h3>
	
  	</div>
	</section>

	<section id="apply" class="well">  	
  	<div class="body-header-wrapper">	
  		<h2><i class="icon-ok-sign"></i> Apply for Benefits</h2>
		<p>Placeholder text......placeholder text.placeholder text.placeholder text.placeholder text.placeholder text</p>
      
	
  	</div>
	</section>
   
	    	    
</div> <!--span8-->
<div class="span4">
   	<div class="well sidebar-nav " style="z-index: 999; position: static; width:220px; top: 191px;">
        <legend><i class="icon-list-alt "></i> Your Report</legend>
        <ol class="nav nav-list">
	   <li class="active"><a href="#summary"><i class="icon-bar-chart "></i> Summary of Your Situation </a></li>
          <li class=""><a href="#recs"><i class="icon-user-md "></i> Recommended Actions </a></li>
          <li class=""><a href="#savings"><i class="icon-ok-sign "></i> Cost Savings </a></li>
          <li class=""><a href="#apply"><i class="icon-money "></i> Apply for Benefits</a></li>
        </ol>
        <br>
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
		<?PHP if(isset($screeningID)){echo '<li><a data-toggle="modal" role="button" href="/quickcheck/?screeningID='.$screeningID.'"><i class="icon-reply "></i> Want to Change Answers? </a></li>';
 		} ?>
        	<li><a data-toggle="modal" role="button" href="http://www.surveymonkey.com/s/LQPZRWN" target="_blank"><i class="icon-user "></i> Send Us Your Feedback</a></li>
            <li><form><a data-toggle="modal" role="button" href="#" onClick="javascript:PrintDiv();"><i class="icon-print "></i> Printable Report</a></form></li>
        </ol>		
    </div>	  
</div>

</div>
