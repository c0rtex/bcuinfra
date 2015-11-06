<?php
$query_answerfieldOption = "
SELECT
answerfield_option.answerfield_id,
answerfield_option.option_id,
answerfield_option.sort,
`option`.option_id,
`option`.display_id,
`option`.option_code as code,
`option`.include_flag
FROM
answerfield_option
INNER JOIN `option` ON answerfield_option.option_id = `option`.option_id
WHERE answerfield_id =".$answerfieldID." 
order by answerfield_option.sort
";
$answerfieldOption_query = $bcudb->get_results($query_answerfieldOption);

//var_dump($answerfieldOption_query); 
foreach($answerfieldOption_query as $answerfieldOptionObj):

	$optionID = $answerfieldOptionObj->option_id;
	$displayID = $answerfieldOptionObj->display_id;
	$optionText = getDisplayTextbyID($displayID);
	$optionCode = $answerfieldOptionObj->code;
	$optionText = findHelpDefinition($optionText);
	if ($answerfieldValue == $optionCode) {
		$selected = 'selected';
	}
	else {
		$selected = 'noselect';
	}
	echo '<option id="'.$answerfield.'-'.$optionCode.'" '.$selected.' value="'.$optionID.'-'.$optionCode.'">'.$optionText.'</option>';
endforeach;
?>

