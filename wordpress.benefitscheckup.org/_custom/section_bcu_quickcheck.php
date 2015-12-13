<?PHP

require_once('_custom/soap_client.php');

//print_r ($sectionQuestion_wsArray);
//echo $query_getSections;

$questionNumberTotal = 0;
//$section_query = $bcudb->get_results($query_getSections);
$section_query = $soapClient->getSubsetSections($subsetID);
//$section_query = restructureWSArray ($section_query);
//print_r ($section_query);
foreach ($section_query  as $sectionObj) :
$sectionCode = $sectionObj["QUESTIONCATEGORY_CODE"];
//echo "dryndiri";
//echo $sectionCode;
$sectionName = $sectionObj["QUESTIONCATEGORY_CODE"];
$sectionDiplayID = $sectionObj["DISPLAY_ID"];
$sectionHeadingText = getDisplayTextbyID($sectionDiplayID, $soapClient);


$icon = getIconTextByCode($sectionCode, $soapClient);
$iconText = 'icon-'.$icon;

//NOTE: Lynna Cekova, reg. Esi Quickcheck: only one section, so we get all questions without dealing with the messy query with the sections 

//get the questions for the section via web services


$sectionQuestion_wsArray = $soapClient->getEsiQuickcheckQuestions($subsetID);

if ($sectionHeadingText == 'Basics' ){
$sectionHeadingText = 'Basics';
}
echo'
        <div class="">
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
						require('_custom/question_bcu_quickcheck.php');
					endforeach;         
echo '   
                </fieldset>
        </div>
    </section>
';
endforeach;


?>
