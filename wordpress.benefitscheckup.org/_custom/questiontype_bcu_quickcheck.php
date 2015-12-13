<?php


$questionType_query = $soapClient->getQTByQuestion($questionCode);
//$questionType_query = restructureWSArray($questionType_query);

foreach($questionType_query as $questionTypeObj):

$questionTypeCode = $questionTypeObj["QUESTIONTYPE_CODE"];
$questionCode = $questionTypeObj["QUESTION_CODE"];
//echo "type".$questionTypeCode."<br>";
switch ($questionTypeCode) {
	
    case 'select_other_specify':
		require('_custom/answerfield_bcu_quickcheck.php');
	break;

case 'multi_horizontal':
	require('_custom/answerfield_bcu_quickcheck.php');
	break;
	
case 'general':
	require('_custom/answerfield_bcu_quickcheck.php');
	break;
	
case 'select_drilldown':
	require('_custom/answerfield_bcu_quickcheck.php');
	break;
	
case 'grid':
	require('_custom/questiongrid_bcu_quickcheck.php');
	break;
	
case 'hh_expenses_layout':
	require('_custom/answerfield_bcu_quickcheck.php');
	break;
	
case 'multiselect':
	echo '<div id="esiQuickcheckCheckboxes" data-toggle="buttons-checkbox" >';
	require('_custom/answerfield_bcu_quickcheck.php');
	echo '</div>';
	echo '</div>';
	break;
case 'radio':
	echo '<div class="radio"><div data-toggle="buttons-checkbox">';
	require('_custom/answerfield_bcu_quickcheck.php');
	echo '</div></div>';
	break;
	
default:
       echo '<div class="alert alert-error">Error: No Question Type Defined!</div>';
}
endforeach;
?> 

