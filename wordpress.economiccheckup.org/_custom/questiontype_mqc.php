<?php
$query_getQTByQuestion = "
select q.question_id, q.question_code, qt.`code` as questiontype_code
	from question q, questiontype qt
	where q.question_code = '".$questionCode."'
    and q.questiontype_id = qt.questiontype_id
	order by q.sort
";
$questionType_query = $bcudb->get_results($query_getQTByQuestion);

foreach($questionType_query as $questionTypeObj):

$questionTypeCode = $questionTypeObj->questiontype_code;
$questionCode = $questionTypeObj->question_code;
//echo "type".$questionTypeCode."<br>";
switch ($questionTypeCode) {
	
    case 'select_other_specify':
		require('_custom/answerfield_mqc.php');
	break;

case 'multi_horizontal':
	require('_custom/answerfield_mqc.php');
	break;
	
case 'general':
	require('_custom/answerfield_mqc.php');
	break;
	
case 'select_drilldown':
	require('_custom/answerfield_mqc.php');
	break;
	
case 'grid':
	require('_custom/questiongrid.php');
	break;
	
case 'hh_expenses_layout':
	require('_custom/answerfield_mqc.php');
	break;
	
case 'multiselect':
	echo '<div data-toggle="buttons-checkbox" >';
	require('_custom/answerfield_mqc.php');
	echo '</div>';
	break;
case 'radio':
	echo '<div class="radio"><div data-toggle="buttons-checkbox">';
	require('_custom/answerfield_mqc.php');
	echo '</div></div>';
	break;
	
default:
       echo '<div class="alert alert-error">Error: No Question Type Defined!</div>';
}
endforeach;
?> 

