<?php
//Get question display text.
echo'
						<div class="clearfix bcuQuestionSet">
                        	<div class="row-fluid" id="question_'.$questionCode.'">
                                <span class="span12">
                                	<label for="normalSelect" id="options_'.$questionCode.'">'.$questionText;
require('_custom/questiontype_bcu_quickcheck.php');
echo '
</span>
 							</div>
						</div>
';?> 

