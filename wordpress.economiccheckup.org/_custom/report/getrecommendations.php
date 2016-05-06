<?php
					$money_recs_count = 0;
					//Lynna Cekova: getting the money_recs directly from the db, together with the sort order
                                        $money_recs = array();                                       
                                        	$moneyRecsQuery = "select rc.post_id, sc.post_code, sc.sort_order, sc.bcu from subset_content sc, rule_content rc, screening_content scc where sc.subset_id='83' and sc.section_code='money_recs' and sc.post_code = rc.post_code and scc.content_code = sc.post_code
and scc.screening_id = ".$screeningID."  order by sc.sort_order;";
								$moneyRecsResults = $bcudb->get_results($moneyRecsQuery);
                                                    foreach( $moneyRecsResults as $moneyRecsResult => $row) {
							$money_recs_count = ++$money_recs_count;
                                                // each column in the row is accessible like this
                                                //echo $row->post_code;
                                                //array_push ($money_recs, array('postid' => $row->post_id, 'bcu' => 0, 'show' => 0, 'post_code' => $row->post_code, 'sort_order' => $row->sort_order));
                                           	$money_recs[$row->post_code] = array('postid' => $row->post_id, 'bcu' => $row->bcu, 'show' => 0, 'post_code' => $row->post_code, 'sort_order' => $row->sort_order);


                                                 }

					echo "<br/>The Money recs </br>".$money_recs_count;
					var_dump( $money_recs );

					
					$housing_recs = array();
                                         							
		            // Show all 'Housing' Recommendations flagged with show == 1
                    			
					$housing_recs_count = 0; // total recs to show based on responses.
                                        $housingRecsQuery = "select rc.post_id, sc.post_code, sc.sort_order, sc.bcu from subset_content sc, rule_content rc, screening_content scc where sc.subset_id='83' and sc.section_code='housing_recs' and sc.post_code = rc.post_code and scc.content_code = sc.post_code
and scc.screening_id = ".$screeningID."  order by sc.sort_order;";
								$housingRecsResults = $bcudb->get_results($housingRecsQuery);
                                                    foreach( $housingRecsResults as $housingRecsResult => $row) {
							$housing_recs_count = ++$housing_recs_count;
                                           		$housing_recs[$row->post_code] = array('postid' => $row->post_id, 'bcu' => $row->bcu, 'show' => 0, 'post_code' => $row->post_code, 'sort_order' => $row->sort_order);


                                                 }
					//echo ("<br/>The Housing recs </br>");
					//var_dump( $housing_recs );
					
					$health_recs_count = 0;

					$health_recs = array();
                                         
                                        $healthRecsQuery = "select rc.post_id, sc.post_code, sc.sort_order, sc.bcu from subset_content sc, rule_content rc, screening_content scc where sc.subset_id='83' and sc.section_code='health_recs' and sc.post_code = rc.post_code and scc.content_code = sc.post_code
and scc.screening_id = ".$screeningID."  order by sc.sort_order;";
								$healthRecsResults = $bcudb->get_results($healthRecsQuery);
                                                    foreach( $healthRecsResults as $healthRecsResult => $row) {
					   $health_recs_count = ++$health_recs_count; 	
                                           $health_recs[$row->post_code] = array('postid' => $row->post_id, 'bcu' => $row->bcu, 'show' => 0, 'post_code' => $row->post_code, 'sort_order' => $row->sort_order);


                                                 }

					//echo ("<br/>The Health recs </br>");
					//var_dump( $health_recs );

					$employment_recs_count = 0; // total recs to show based on responses.


					$employment_recs = array();
                                         
                                        $employmentRecsQuery = "select rc.post_id, sc.post_code, sc.sort_order, sc.bcu from subset_content sc, rule_content rc, screening_content scc where sc.subset_id='83' and sc.section_code='employment_recs' and sc.post_code = rc.post_code and scc.content_code = sc.post_code
and scc.screening_id = ".$screeningID."  order by sc.sort_order;";
								$employmentRecsResults = $bcudb->get_results($employmentRecsQuery);
                                                    foreach( $employmentRecsResults as $employmentRecsResult => $row) {
						 $employment_recs_count = ++$employment_recs_count; 
                                           $employment_recs[$row->post_code] = array('postid' => $row->post_id, 'bcu' => $row->bcu, 'show' => 0, 'post_code' => $row->post_code, 'sort_order' => $row->sort_order);


                                                 }

					//echo ("<br/>The Employment recs </br>");
					//var_dump( $employment_recs );


					$debt_recs = array();
                                         $debt_recs_count = 0;
                                        $debtRecsQuery = "select rc.post_id, sc.post_code, sc.sort_order, sc.bcu from subset_content sc, rule_content rc, screening_content scc where sc.subset_id='83' and sc.section_code='debt_recs' and sc.post_code = rc.post_code and scc.content_code = sc.post_code
and scc.screening_id = ".$screeningID."  order by sc.sort_order;";
								$debtRecsResults = $bcudb->get_results($debtRecsQuery);
                                                    foreach( $debtRecsResults as $debtRecsResult => $row) {
							$debt_recs_count = ++$debt_recs_count; 	
                                           $debt_recs[$row->post_code] = array('postid' => $row->post_id, 'bcu' => $row->bcu, 'show' => 0, 'post_code' => $row->post_code, 'sort_order' => $row->sort_order);


                                                 }

					//echo ("<br/>The Debt recs </br>");
					//var_dump( $debt_recs);

					$consumer_recs = array();
                                        $consumer_recs_count = 0;
                                        $consumerRecsQuery = "select rc.post_id, sc.post_code, sc.sort_order, sc.bcu from subset_content sc, rule_content rc, screening_content scc where sc.subset_id='83' and sc.section_code='consumer_recs' and sc.post_code = rc.post_code and scc.content_code = sc.post_code
and scc.screening_id = ".$screeningID."  order by sc.sort_order;";
								$consumerRecsResults = $bcudb->get_results($consumerRecsQuery);
                                                    foreach( $consumerRecsResults as $consumerRecsResult => $row) {
							$consumer_recs_count = ++$consumer_recs_count; 
                                           $consumer_recs[$row->post_code] = array('postid' => $row->post_id, 'bcu' => $row->bcu, 'show' => 0, 'post_code' => $row->post_code, 'sort_order' => $row->sort_order);


                                                 }

					//echo ("<br/>The Consumer recs </br>");
					//var_dump( $consumer_recs);


					
?>