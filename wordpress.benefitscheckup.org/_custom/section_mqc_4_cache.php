<?PHP

//print_r ($sectionQuestion_wsArray);
//echo $query_getSections;

$questionNumberTotal = 0;
//$section_query = $bcudb->get_results($query_getSections);
$section_query = $soapClient->getSubsetSections($subsetID);
//$section_query = restructureWSArray ($section_query);

foreach ($section_query  as $sectionObj) :
    $sectionCode = $sectionObj["QUESTIONCATEGORY_CODE"];
    $sectionName = $sectionObj["QUESTIONCATEGORY_CODE"];
    $sectionDiplayID = $sectionObj["DISPLAY_ID"];
    $sectionHeadingText = getDisplayTextbyID($sectionDiplayID, $soapClient);


    $icon = getIconTextByCode($sectionCode, $soapClient);
    $iconText = 'icon-'.$icon;

//get the questions for the section via web services


    $sectionQuestion_wsArray = $soapClient->getSectionQuestions($subsetID, $sectionCode, "14", "FD");

    if ($sectionHeadingText == 'Basics' ){
        $sectionHeadingText = 'Basics';
    }
    echo'
<section id="'.$sectionCode.'">  	
        <div class="body-header-wrapper">	<h2><i class="'.$iconText.'"></i> '.$sectionHeadingText.' </h2>	
            <div class="body-header" style="z-index: 999; position: static; top: 251.5px;">

            </div>
            <div style="display: none; width: 620px; height: 0px; float: none;"></div>
        </div>
        <div class="">
            <div class="well">
                <fieldset>';
    //No Section Legend text displayed
    $sectionLegend = '';
    echo '<NOlegend>'.$sectionLegend.'</NOlegend>';


    //$sectionQuestion_wsArray = restructureWSArray($sectionQuestion_wsArray);



    foreach ($sectionQuestion_wsArray as $sectionQuestionObj) :
        $questionCode = $sectionQuestionObj["QUESTION_CODE"];
        $questionRuleID = $sectionQuestionObj["RULE_ID"];
        $questionCategoryCode = $sectionQuestionObj["QUESTIONCATEGORY_CODE"];
        $questionID = $sectionQuestionObj["QUESTION_ID"];
        $questionTypeCode = $sectionQuestionObj["QUESTIONTYPE_CODE"];
        $questionDisplayID = $sectionQuestionObj["DISPLAY_ID"];
        if ($questionRuleID == ''){ $questionNumberTotal++; }
        //echo '<p>QuestionCode:'.$questionCode.'</p>';
        //echo '<h5>Display Header and Display Code'.$questionCode.$questionDisplayID.'</h5>';
        require('question_mqc_4_cache.php');
    endforeach;
    echo '
                </fieldset>
            </div>
        </div>
    </section>
';
endforeach;


?>
