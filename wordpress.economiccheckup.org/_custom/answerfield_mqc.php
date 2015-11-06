<?php
$query_getAFByQuestion = "
select a.answerfield_id , a.answerfield, a.answerfieldtype_id , aa.code, a.display_id, a.validation_id, a.default_value, a.max_length
	from question q, question_answerfield qa, answerfield a, answerfieldtype aa
	where q.question_code = '".$questionCode."'
		and q.question_id=qa.question_id
		and qa.answerfield_id=a.answerfield_id
    and a.answerfieldtype_id = aa.answerfieldtype_id
	order by qa.sort
";
$questionAnswerfield_query = $bcudb->get_results($query_getAFByQuestion);
foreach($questionAnswerfield_query as $questionAnswerfieldObj):

//var_dump($questionAnswerfield_query);
$answerfieldCode = $questionAnswerfieldObj->code;
$answerfield = $questionAnswerfieldObj->answerfield;
$maxLength = $questionAnswerfieldObj->max_length;
$defaultValue = $questionAnswerfieldObj->default_value;
$validationID = $questionAnswerfieldObj->validation_id;
//echo '<div> Start AnsCode: '.$answerfieldCode.'</div>';
 
require('_custom/answerfieldtype_mqc.php');
//echo '<div> End AnsCode: '.$answerfieldCode.'</div>'; 
endforeach;
?>
