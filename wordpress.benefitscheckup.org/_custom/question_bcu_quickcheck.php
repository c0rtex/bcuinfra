<?php 

//Get question display text.
echo'
						<div class="clearfix">
                        	<div class="bcuQuickcheckQuestion" id="question_'.$questionCode.'">
                            	<span class="span1"><strong>';


echo '</strong></span>
                                <span class="span11">					      	
                                	<label for="normalSelect">'.$questionText;
									require('_custom/questiontype_bcu_quickcheck.php');
echo '


</span>
                          	</div>
						</div>
';





?> 

