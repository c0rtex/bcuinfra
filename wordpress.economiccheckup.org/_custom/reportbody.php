<?PHP
$bcudb = new wpdb(DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU,DB_HOST_BCU);
$bcudb->show_errors();

/* 5017990, 5018048, 5017788, 5017774, 5017603 */
$screeningID = 5017603; 
if (isset($_GET['screeningID']))
{
//echo "ScreeningID from questionnaire:".$_GET['screeningID'];
$screeningID = $_GET['screeningID'];
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

$query_getPrograms = "select sp.program_id, p.program_code from program p INNER JOIN screening_program sp ON sp.program_id = p.program_id where screening_id =".$screeningID;
$result1 = mysql_query($query_getPrograms);
while($ProgramRow = mysql_fetch_assoc( $result1)){
    $Program_array[] = $ProgramRow;
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

?>

<div class="span8">  
	<section id="benefits"> 
        <div class="body-header-wrapper">	<h2><i class="icon-bar-chart "></i> Recommendations </h2>	
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
          		<div >
					<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
                    <html xmlns="http://www.w3.org/1999/xhtml">
                      <head>
                        <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
                        <title>
                          	Monthly, Income, Benefits and Expenses
                        </title>
			   <script type="text/javascript" src="/cf/js/flot/jquery-1-10-1.js"></script>
                <!--[if lte IE 8]>
                    <script language="javascript" type="text/javascript" src="/cf/js/flot/excanvas.min.js"></script>
                <![endif]-->
                <script type="text/javascript" src="/cf/js/flot/jquery.flot.min.js"></script>
                <script type="text/javascript" src="/cf/js/flot/jquery.flot.time.js"></script>
                <script type="text/javascript" src="/cf/js/flot/jquery.flot.symbol.js"></script>
                <script type="text/javascript" src="/cf/js/flot/jquery.flot.axislabels.js"></script>
                <script type="text/javascript" src="/cf/js/flot/jquery.flot.dashes.js"></script>
                <script>
                    $(function() {
                        var d4 = [
                            [.5, 1750]
                        ];
                        
                        var d2 = [
                            [.5, 3000, 1750]
                        ];
                        
                        var d3 = [
                            [2, 4250]
                        ];
                
                        var d5 = [
                            [0, 3750],
                            [5, 3750]
                        ];
                        
                        var d6 = [
                            [0, 3000],
                            [5, 3000]
                        ];
                
                        var d9 = [
                            [5, 3005]
                        ];
                
                                  
                        $.plot($("#flot-placeholder"), [{
                            data: d4,
                            color: '#aebc37',
                            label: 'Income',
                            bars: {
                                show: true,
                                fill: 1
                            }
                        }, {
                            data: d2,
                            color: '#fdb813',
                            label: 'Benefits',
                            bars: {
                                show: true,
                                fill: 1
                            }
                        }, {
                            data: d3,
                            color: '#f47735',
                            label: 'Expenses',
                            bars: {
                                show: true,
                                fill: 1
                            }
                        },{
                            data: d5,
                            color: '#00468b',
                yaxis: 2,
                            stack: null,
                            dashes:{show:true}
                        },{
                            data: d6,
                            color: '#00468b',
                yaxis: 2,
                            stack: null,
                            dashes:{show:false}
                        }, {
                            data: d9,
                            color: 'rgba(255, 255, 255, 0.5)',
                            label: 'Your Shortfall',
                            bars: {
                                show: true,
                                fill: 0.5,
                                horizontal: true,
                                barWidth: 740
                            }
                        }], {
                            series: {
                                stack: true,
                            },
                            grid: {
                                backgroundColor: {
                                    colors: ["#ccdae8", "#ccdae8"]
                                }
                
                            },
                            legend: {
                                position: "se",
                                backgroundOpacity: 0.5
                            },
                            xaxis: {
                                font: {size: 12, style: "italic", weight: "bold", color: "black"},
                                ticks: [
                                    [1, 'Income &amp; Benefits'],
                                    [2.5, 'Expenses']
                                ]
                            },
                            yaxes: [
                                {
                                    ticks: [
                                        [0, '$0'],
                                        [500, ''],
                                        [1000, '$1000'],
                                        [1500, ''],
                                        [2000, '$2000'],
                                        [2500, ''],
                                        [3000, '$3000'],
                                        [3500, ''],
                                        [4000, '$4000'],
                                        [4500, ''],
                                        [5000, '$5000']
                                    ]
                                 },
                                {
                                    position: "right",
                                    font: {size: 12, style: "italic", weight: "bold", color: "#00468b"},
                                    ticks: [
                                        [0, ' '],
                                        [500, ' '],
                                        [1000, ' '],
                                        [1500, ' '],
                                        [2000, ' '],
                                        [2500, ' '],
                                        [3000, 'Total Income &amp; Benefits<BR>$3000'],
                                        [3500, ' '],
                                        [3750, 'Basic Needs*<BR>$3750'],
                                        [4000, ' '],
                                        [4500, ' '],
                                        [5000, ' ']
                                    ]	
                                 }
                            ],
                        });
                    });
                </script>
                  	</head>
                   	<body>
                     	<div id="flot-placeholder" style="width:550px;height:300px;margin:0 auto"></div>
                    </body>
              	</html>
          	</div>
            </div>
		</div>
	</section>
	<section id="money">  	
        <div class="body-header-wrapper">	<h2><i class="icon-money "></i>  Money Management & Budgeting </h2>	
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
				<?php
					$money_recs = array( array('postid' => 2573, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2577, 'bcu' => 1, 'show' => 1),
                       array('postid' => 2581, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2586, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2592, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2596, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2600, 'bcu' => 1, 'show' => 1),
                       array('postid' => 2604, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2609, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2613, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2617, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2620, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2623, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2630, 'bcu' => 0, 'show' => 1)
                     );
					
					// Online Money Management Tool (post id = 2573)
					$AFrow_index = searchForId('esi_interest_budgeting', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[0]["show"] = 1;}
					unset($AFrow_index);
					
					// Cell Phone - BCU (post id = 2577)
					foreach ($Program_array as $pid => $pcode) {
						foreach ($pcode as &$value) {
							if(strpos($value,'safelink_wireless')){ 
								$links_2577[] = $pid;
								 } 
							if((strpos($value,'_lifeline')) and (strpos($value, '_lifelines') === false)){ 
								$links_2577[] = $pid; 
								}
							if(strpos($value,'_assurance_wireless')){ $links_2577[] = $pid; }
						}
					}
					if (isset(${'links_'.$money_recs[1]["postid"]})) {
						if (count($links_2577) > 0){$money_recs[1]["show"] = 1;}
					}
					unset($pid);
					unset($pcode);
					unset($value);
					
					//Local Food Bank (post id = 2581)
					$AFrow_index = searchForId('esi_basicneeds', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"]) AND ($AF_array[$AFrow_index]["option_code"] != 'esi_notachallenge')){$money_recs[2]["show"] = 1;}
					unset ($AFrow_index);
					
					// Budget Calculator (post id = 2586)
					$AFrow_index = searchForId('esi_helpbalancing', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[3]["show"] = 1;}
					unset($AFrow_index);
					
					//Create a Budget  (post id = 2592)
					$AFrow_index = searchForId('esi_helpbalancing', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[4]["show"] = 1;}
					unset($AFrow_index);
					
					//Budgeting Assistance  (post id = 2596)
					$AFrow_index = searchForId('esi_helpbalancing', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[5]["show"] = 1;}
					unset($AFrow_index);
										
					// Pension Assistance (post id = 2600)
					foreach ($Program_array as $pid =>$pcode) {
						foreach ($pcode as &$value) {
	    					if(strpos($value,'assistance_fd_pension_right_cntr')){ $links_2600[] = $pid; } 
						}
					}
					if (isset(${'links_'.$money_recs[6]["postid"]})) {
						if (count($links_2600) > 0){$money_recs[6]["show"] = 1;}
					}
					unset ($pid);
					unset ($pcode);
					unset ($value);
					
					// Retirement Plan  (post id = 2604)
					$AFrow_index1 = searchForId('esi_birth_month', $AF_array);
					$AFrow_index2 = searchForId('esi_birth_year', $AF_array);
					$userBirthMonth = $AF_array[$AFrow_index1]["response"];
					$userBirthYear = $AF_array[$AFrow_index2]["response"];
					$userAge = age($userBirthMonth,1,$userBirthYear); // Reuse User Age
					$AFrow_index3 = searchForId('esi_retire_resources', $AF_array);
					if ((isset($AF_array[$AFrow_index3]["option_code"])) AND $userAge > 50){$money_recs[7]["show"] = 1;}
					unset($AFrow_index1);
					unset($AFrow_index2);
					unset($AFrow_index3);
					
					// Financial Planning (post id = 2609)
					$AFrow_index = searchForId('esi_retire_planner', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[8]["show"] = 1;}
					unset ($AFrow_index);
										
					// Life Insurance (post id = 2613)
					$AFrow_index = searchForId('esi_retire_ins', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[9]["show"] = 1;}
					unset($AFrow_index);
					
					// Tax Preparation Assistance (post id = 2617)
					$AFrow_index = searchForId('esi_interest_tax', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[10]["show"] = 1;}
					unset ($AFrow_index);
					
					// Fraud (post id = 2620)
					$AFrow_index = searchForId('esi_interest_protect', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[11]["show"] = 1;}
					unset ($AFrow_index);
					
					// Banking (post id = 2623)
					$AFrow_index = searchForId('esi_interest_bank', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[12]["show"] = 1;}
					unset ($AFrow_index);
					
					// Coupon Websites (post id = 2630)
					$AFrow_index = searchForId('esi_interest_coupon', $AF_array);
					if (isset($AF_array[$AFrow_index]["option_code"])){$money_recs[13]["show"] = 1;}
					unset($AFrow_index);
										
					// Show all 'Money Management & Budgeting' Recommendations flagged with show == 1
                    $num_money_recs = count($money_recs);
                    for ($row = 0; $row < $num_money_recs; $row++)
                    {
                        if ($money_recs[$row]["show"] == 1)                 
						{
							$current_id = $money_recs[$row]["postid"];
							$post = get_post($current_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "</p>";
							echo "</div>";
						}
						if ($money_recs[$row]["bcu"] == 1)
						{
							if ($money_recs[$row]["postid"] == 2577)
							{
								echo "<ul><li><a href='/esi-fact-sheet'>Safelink Fact Sheet</a></li>";
								echo "<li><a href='#'>Lifeline Fact Sheet</a></li>";
								echo "<li><a href='#'>Assurance Wireless</a></li></ul>";
							}
							if ($money_recs[$row]["postid"] == 2600)
							{
								echo "<ul><li><a href='#'>PensionHelp America Fact Sheet</a></li></ul>";
							}
							
							/*if (isset(${'links_'.$money_recs[$row]["postid"]})) {
								foreach (${'links_'.$money_recs[$row]["postid"]} as $value)

								{
									echo "<a href='#'>".$value."</a>";
									//showFactSheetLink($value);
									echo "\r\n";
								}
								unset($value);
							}*/
						}
					}
					unset($row);
                ?>
            </div>
        </div>
  	</section>
    <section id="housing">  	
        <div class="body-header-wrapper">	<h2><i class="icon-home "></i>  Housing </h2>	
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
                <?php
                    $housing_recs = array( array('postid' => 2637, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2642, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2645, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2648, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2652, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2657, 'bcu' => 1, 'show' => 1),
                       array('postid' => 2662, 'bcu' => 1, 'show' => 1),
                       array('postid' => 2665, 'bcu' => 1, 'show' => 1),
                       array('postid' => 2669, 'bcu' => 1, 'show' => 1),
                       array('postid' => 2680, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2683, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2686, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2692, 'bcu' => 0, 'show' => 1),
					   array('postid' => 2695, 'bcu' => 0, 'show' => 1)
                     );
					
					/* Foreclosure (post id 2637)
					$req1 = 0; // 62 or older
					$req2 = 0; // owns home
					$req3 = 0; // owe more than worth OR some equity but can't keep up with mthly bills
					if ($userAge > 61){$req1 = 1;}
					$AFrow_index2 = searchForId("esi_housingtype", $AF_array);
					if (isset($AF_array[$AFrow_index2]["option_code"]) and ($AF_array[$AFrow_index2]["option_code"] === "esi_housingtype_own")){$req2 = 1;}
					$AFrow_index3 = searchForId("esi_housingsituation", $AF_array);
					if ((isset($AF_array[$AFrow_index3]["option_code"]) and (($AF_array[$AFrow_index3]["option_code"] == "esi_housing_someequity")) || ($AF_array[$AFrow_index3]["option_code"]) == "esi_housing_reversemortgage")){$req3 = 1;}
					if ($req1 == 1 and  $req2 == 1 and  $req3 == 1){$housing_recs[0]["show"] = 1;}																																		
					unset($AFrow_index2);
					unset($AFrow_index3);
					unset($req1);
					unset($req2);
					unset($req3);*/
					
                    // Show all 'Housing' Recommendations flagged with show == 1
                    $num_housing_recs = count($housing_recs);
                    for ($row = 0; $row < $num_housing_recs; $row++)
                    {
                        if ($housing_recs[$row]["show"] == 1)                 
						{
							$current_id = $housing_recs[$row]["postid"];
							$post = get_post($current_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "</p>";
							echo "</div>";
						}
						
                    }
					unset($row);
                ?>
            </div>
      	</div>
    </section>
   	<section id="health">  	
		<div class="body-header-wrapper">	<h2><i class="icon-medkit "></i>  Health </h2>	
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
                <?php
                    $health_recs = array( array('postid' => 2698, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2701, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2705, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2712, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2715, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2720, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2724, 'bcu' => 0, 'show' => 1)
                     );
                    $num_health_recs = count($health_recs);
                    for ($row = 0; $row < $num_health_recs; $row++)
                    {
                        if ($health_recs[$row]["show"] == 1)                 
						{
							$current_id = $health_recs[$row]["postid"];
							$post = get_post($current_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "</p>";
							echo "</div>";
						}
						
                    }
					unset($row);
                ?>
            </div>
		</div>
    </section>
	<section id="employment">  	
    	<div class="body-header-wrapper">	<h2><i class="icon-certificate "></i> Employment & Training </h2>	
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
        		<?php
                    $employment_recs = array( array('postid' => 2728, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2734, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2738, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2742, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2744, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2747, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2751, 'bcu' => 0, 'show' => 1)
                     );
                    $num_employment_recs = count($employment_recs);
                    for ($row = 0; $row < $num_employment_recs; $row++)
                    {
                        if ($employment_recs[$row]["show"] == 1)                 
						{
							$current_id = $employment_recs[$row]["postid"];
							$post = get_post($current_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "</p>";
							echo "</div>";
						}
						
                    }
					unset($row);
                ?>
           	</div>
      	</div>
  	</section>
    	<section id="debt">  	
    	<div class="body-header-wrapper">	<h2><i class="icon-credit-card "></i> Debt & Credit </h2>	
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
        		<?php
                    $debt_recs = array( array('postid' => 2754, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2758, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2761, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2763, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2766, 'bcu' => 0, 'show' => 1)
                     );
                    $num_debt_recs = count($debt_recs);
                    for ($row = 0; $row < $num_debt_recs; $row++)
                    {
                        if ($debt_recs[$row]["show"] == 1)                 
						{
							$current_id = $debt_recs[$row]["postid"];
							$post = get_post($current_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "</p>";
							echo "</div>";
						}
						
                    }
					unset($row);
                ?>
           	</div>
      	</div>
  	</section>
    <section id="consumer"> 
    	<div class="body-header-wrapper">	<h2><i class="icon-lock "></i>  Consumer Protections </h2>	
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
                <?php
                    $consumer_recs = array( array('postid' => 2768, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2771, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2773, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2775, 'bcu' => 0, 'show' => 1),
                       array('postid' => 2777, 'bcu' => 0, 'show' => 1)
                     );
                   $num_consumer_recs = count($consumer_recs);
                    for ($row = 0; $row < $num_consumer_recs; $row++)
                    {
                        if ($consumer_recs[$row]["show"] == 1)                 
						{
							$current_id = $consumer_recs[$row]["postid"];
							$post = get_post($current_id); 
							$title = $post->post_title;
							$desc = $post->post_content;
							echo "<div>";
							echo "<h4>" .$title. "</h4>";
							echo "<p>" .$desc. "</p>";
							echo "</div>";
						}
						
                    }
					unset($row);
                ?>
            </div>
		</div>
    </section>
    <section>
    	<div align="center" class="clearfix"><small>Note: Economic Security determination calculated using Wider Opportunities for Women's Elder Economic Security Standard&trade; Index.</small><br /><BR /><a target="_new" href="http://www.wowonline.org"><img border="0" alt="Wider Opportunities for Women" title="Wider Opportunities for Women" src="/cf/img/partners/economicsecurity/wow.png"></a>
      	</div>
	</section>
</div> <!--span8-->
<div class="span4">
   	<div class="well sidebar-nav" style="z-index: 999; position: static; width:220px; top: 191px;">
        <legend><i class="icon-list-alt "></i> Your Report</legend>
        <ol class="nav nav-list">
            <li class="active"><a href="#benefits"><i class="icon-bar-chart "></i> Recommendations </a></li>
            <li class=""><a href="#money"><i class="icon-money "></i> Money Mgmt & Budgeting </li>
            <li class=""><a href="#housing"><i class="icon-home "></i> Housing </a></li>
            <li class=""><a href="#health"><i class="icon-medkit "></i> Health </a></li>
            <li class=""><a href="#employment"><i class="icon-certificate "></i> Employment & Training </a></li>
            <li class=""><a href="#debt"><i class="icon-credit-card "></i> Debt & Credit </a></li>
            <li class=""><a href="#consumer"><i class="icon-lock "></i> Consumer Protections </a></li>
        </ol><BR>
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
        	<li><a data-toggle="modal" role="button" href="#printquestions"><i class="icon-print "></i>Print</a></li>
            <li><a data-toggle="modal" role="button" href="#feedback"><i class="icon-user "></i>Send Us Your Feedback</a></li>
        </ol>		
    </div>	  
</div>