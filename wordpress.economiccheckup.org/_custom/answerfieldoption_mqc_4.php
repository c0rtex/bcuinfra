<?php
$answerfieldOption_query = $soapClient->getAnswerfieldOption($answerfieldID);
//$answerfieldOption_query = restructureWSArray ($answerfieldOption_query);

//echo "<pre>";
//print_r ($answerfieldOption_query);

//var_dump($answerfieldOption_query); 
foreach($answerfieldOption_query as $answerfieldOptionObj):

	$optionID = $answerfieldOptionObj["OPTION_ID"];
	$displayID = $answerfieldOptionObj["DISPLAY_ID"];
	$optionText = getDisplayTextbyID($displayID, $soapClient);
	$optionCode = $answerfieldOptionObj["CODE"];
	$optionText = findHelpDefinition($optionText, $soapClient);
	if ($answerfieldValue == $optionCode) {
		$selected = 'selected';
	}
	else {
		$selected = 'noselect';
	}
	echo '<option id="'.$answerfield.'-'.$optionCode.'" '.$selected.' value="'.$optionID.'-'.$optionCode.'">'.$optionText.'</option>';
endforeach;
?>

