<?PHP

require_once('_custom/soap_client.php');
require_once('_custom/questionnairebody_mqc_4_jsTest.php');


//$questionRule_query = $soapClient->getQuestionRules($subsetID); //from questionnairebody_mqc_4.php
$questionRule_query = $soapClient->getQuestionRules($subsetID); //from questionnairebody_mqc_4.php
$questionRule_query = restructureWSArray ($questionRule_query);

echo '<br/>';
echo '<br/>';
echo '<br/>';
echo '<br/>';
echo '<br/>';
echo '<br/>';
echo '<br/>';
echo '<br/>';
echo '<br/>';
echo '<br/>';
echo '<br/>';
echo '<br/>';
//print_r ($questionRule_query);


echo '<script type="text/javascript">';

foreach ($questionRule_query  as $questionRuleObj) {
$ruledQuestion = $questionRuleObj["QUESTION_CODE"];
$rulingQuestion = $questionRuleObj["RULING_QUESTION_CODE"];
$rulingAnswerType = $questionRuleObj["RULE_ANSWERFIELD_TYPE"];
$ruleType = $questionRuleObj["RULE_TYPE"];
$ruleTextMQC = $questionRuleObj["RULE_TEXT_MQC"];

 

//Lynna's test
//$ruledQuestion = 'mqc_health_insurance_type';
//$rulingQuestion = 'mqc_health_insurance';
//$rulingAnswers = array ("y", "dontknow"); //case matters!
//$rulingAnswerType = 'radio';


echo "\n";
echo "\n";
echo "\n";
echo "\n";

if ($ruleType == 'showhide'){ //show/hide question based on other answers

if ($rulingAnswerType == 'radio'){ //based on radiobuttons; they have have the same name, and there can't be an && condition; also, no need to get the field name from the rule, since it is the same as the ruling question ID

$rulingAnswers = array ();

$answersWithQID = explode("||", $ruleTextMQC);

foreach ($answersWithQID  as $answer) {

$answerQID = explode("=", $answer);
array_push ($rulingAnswers, $answerQID[1]); //0 is the radio name / question ID, 1 is the value

}

showHideBasedOnRadio ($ruledQuestion, $rulingQuestion, $rulingAnswers);
radioOnChange ($ruledQuestion, $rulingQuestion, $rulingAnswers);

}

if ($rulingAnswerType == 'checkbox'){ //based on checkboxes; they have have different names, and there can be an && condition; we need to get the field name from the rule

$rulingAnswers = array ();

$answersWithQID = explode("||", $ruleTextMQC);

showHideBasedOnCheckbox ($ruledQuestion, $rulingQuestion, $answersWithQID); //and &&, if available
checkboxOnChange ($ruledQuestion, $rulingQuestion, $answersWithQID);

}


}



}
echo '</script>';



function radioOnchange ($ruledQuestion, $rulingQuestion, $rulingAnswers){

echo "\n";
echo '$("input:radio[name=';
echo $rulingQuestion;
echo ']").change (function(){';
showHideBasedOnRadio ($ruledQuestion, $rulingQuestion, $rulingAnswers);
echo '})';

}

function checkboxOnchange ($ruledQuestion, $rulingQuestion, $rulingAnswers){

foreach ($rulingAnswers as $value){ //there can be && inside the || array

$checkboxesAnd = explode("&&", $value); //in case there are && cases

foreach ($checkboxesAnd as $chKey => $checkbox){
$checkboxNameValue = explode("=", $checkbox);

echo "\n";
echo '$("input:checkbox[name=';
echo $checkboxNameValue[0];
echo ']").change (function(){';
showHideBasedOnCheckbox ($ruledQuestion, $rulingQuestion, $rulingAnswers);
echo '})';
}
}

}




function showHideBasedOnCheckbox ($toShow, $ruler, $checkboxes) { //$checkboxes is an array of arrays that holds checkboxes united by &&. The big array is divided by ||. $ruler is not used here but in showing/hiding radiobuttons

echo ' if ('; 

foreach ($checkboxes as $key => $value){

if ($key != 0){
echo ' || ';
}


$checkboxesAnd = explode("&&", $value); //in case there are && cases

foreach ($checkboxesAnd as $chKey => $checkbox){
$checkboxNameValue = explode("=", $checkbox);

echo '( '; //containing the ends together

if ($chKey == 0){

buildCheckboxRadioCheck ("checkbox", $checkboxNameValue[0], $checkboxNameValue[1]);
}


else {

echo ' && ';
buildCheckboxRadioCheck ("checkbox", $checkboxNameValue[0], $checkboxNameValue[1]);

}

echo ' )';

}




}

echo '){';
showHide ("show", $toShow);
echo '}';
echo "\n";
echo 'else {';
showHide ("hide", $toShow);
echo '}';


}


function showHideBasedOnRadio ($toShow, $ruler, $radios) { //$radios is an array

echo ' if ('; 

foreach ($radios as $key => $value){


if ($key == 0){
buildCheckboxRadioCheck ("radio", $ruler, $radios[$key]);
}

else {
echo ' || ';
buildCheckboxRadioCheck ("radio", $ruler, $radios[$key]);
}

}

echo '){';
showHide ("show", $toShow);
echo '}';
echo "\n";
echo 'else {';
showHide ("hide", $toShow);
echo '}';


}

function showHide ($type, $input){

echo "\n";
buildJQSet ($input);
echo '.';
echo $type;
echo '();';
echo "\n";

if ($type == "hide"){
buildJQSet($input);
echo '.prev(".alert").remove();';
//delete inputsCheckboxRadio.mqc_additionalplans; TODO
echo "\n";
buildJQSetInput($input);
echo '.removeAttr("checked");';

}


}

function buildCheckboxRadioCheck ($type, $name, $value){ //uses name in both cases

echo ' $(';
echo '\'input:';
echo $type;
echo '[name=';
echo $name;
echo ']:checked\').val() == ';
echo '"';
echo  $value;
echo '"';


}


function buildJQSet ($input){
echo '$("#';
echo $input;
echo '")';

}

function buildJQSetInput ($input){
echo '$("#';
echo $input;
echo ' :input")';

}


/*

if( $('input:radio[name=mqc_health_insurance]:checked').val() == 'n'){

$("#mqc_health_insurance_type").hide();
$("#mqc_health_insurance_type").prev(".alert").remove();
$("#mqc_health_insurance_type :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_health_insurance_type;

*/

?>
