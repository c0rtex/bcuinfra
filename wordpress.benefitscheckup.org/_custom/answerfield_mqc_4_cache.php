<?php
$questionAnswerfield_query = $soapClient->getAFByQuestion($questionCode);
//$questionAnswerfield_query = restructureWSArray ($questionAnswerfield_query);

foreach($questionAnswerfield_query as $questionAnswerfieldObj):

//var_dump($questionAnswerfield_query);
    $answerfieldCode = $questionAnswerfieldObj["CODE"];
    $answerfield = $questionAnswerfieldObj["ANSWERFIELD"];
    $maxLength = $questionAnswerfieldObj["MAX_LENGTH"];
    $defaultValue = $questionAnswerfieldObj["DEFAULT_VALUE"];
    $validationID = $questionAnswerfieldObj["VALIDATION_ID"];
//echo '<div> Start AnsCode: '.$answerfieldCode.'</div>';

    require('answerfieldtype_mqc_4_cache.php');
//echo '<div> End AnsCode: '.$answerfieldCode.'</div>'; 
endforeach;
?>
