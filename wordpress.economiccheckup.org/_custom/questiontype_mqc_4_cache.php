<?php

$questionType_query = $soapClient->getQTByQuestion($questionCode);
//$questionType_query = restructureWSArray($questionType_query);

foreach($questionType_query as $questionTypeObj):

    $questionTypeCode = $questionTypeObj["QUESTIONTYPE_CODE"];
    $questionCode = $questionTypeObj["QUESTION_CODE"];
//echo "type".$questionTypeCode."<br>";
    switch ($questionTypeCode) {

        case 'select_other_specify':
            require('answerfield_mqc_4_cache.php');
            break;

        case 'multi_horizontal':
            require('answerfield_mqc_4_cache.php');
            break;

        case 'general':
            require('answerfield_mqc_4_cache.php');
            break;

        case 'select_drilldown':
            require('answerfield_mqc_4_cache.php');
            break;

        case 'grid':
            require('questiongrid_mqc_4_cache.php');
            break;

        case 'hh_expenses_layout':
            require('answerfield_mqc_4_cache.php');
            break;

        case 'multiselect':
            echo '<div data-toggle="buttons-checkbox" >';
            require('answerfield_mqc_4_cache.php');
            echo '</div>';
            break;
        case 'radio':
            echo '<div class="radio"><div data-toggle="buttons-checkbox">';
            require('answerfield_mqc_4_cache.php');
            echo '</div></div>';
            break;

        default:
            echo '<div class="alert alert-error">Error: No Question Type Defined!</div>';
    }
endforeach;
?> 

