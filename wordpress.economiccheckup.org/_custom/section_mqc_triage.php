<?PHP

require_once('_custom/soap_client.php');

//print_r ($sectionQuestion_wsArray);
//echo $query_getSections;

$questionNumberTotal = 0;
//$section_query = $bcudb->get_results($query_getSections);
$section_query = $soapClient->getSubsetSections("79");
//print_r($section_query);
//$section_query = restructureWSArray ($section_query);

foreach ($section_query  as $sectionObj) :
$sectionCode = $sectionObj["QUESTIONCATEGORY_CODE"];
$sectionName = $sectionObj["QUESTIONCATEGORY_CODE"];
$sectionDiplayID = $sectionObj["DISPLAY_ID"];
$sectionHeadingText = getDisplayTextbyID($sectionDiplayID, $soapClient);
//Show Intro and legend Section
/*$sectionLegend*/

//$sectionLegend = apply_filters('the_content', get_post_field('post_content', 13353));
$sectionLegendPost = $soapClient->getWPPost('13353');
$icon = getIconTextByCode($sectionCode, $soapClient);
$iconText = 'icon-'.$icon;

//get the questions for the section via web services


$sectionQuestion_wsArray = $soapClient->getSectionQuestions("79", $sectionCode, "14", "NY");

if ($sectionHeadingText == 'Basics' ){
$sectionHeadingText = 'Basics';
}
echo'
<section id="'.$sectionCode.'">  	
        <div class="">
            <div class="well">
                <fieldset class="triage">';
		      if ($sectionCode == 'basics'){
			  //Warning Message regarding validation errors
				if ( isset($_GET['badresponselist'])) {
				echo '<div class="alert alert-error">';
      				echo "<p><i class='icon-warning-sign'></i> We're sorry, but some responses are missing or were completed incorrectly. Please correct the problems where indicated below.</p></div>";
				}
			  //Show Intro text under basics section
                       echo '<p><p></p>Take this Medicare QuickCheck&trade; to get a personalized report that can help you:
<ul><li>Understand when to sign up for Medicare and when to delay</li>
<li>Find people to help answer your questions about Medicare</li>
<li>Learn if there are additional resources to help you pay for your health care costs</ul></li>
<p></p>
<p><strong>Please note: You must answer all questions in the questionnaire.</strong></p>
<br></p>';
			}
		      else {
			//No Section Legend text displayed
			$sectionLegend = '';
		    	 echo '<NOlegend>'.$sectionLegend.'</NOlegend>';
			}
			echo '<h2><i class="icon-medkit"></i> Medicare Enrollment Status</h2>';

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
						require('_custom/question_mqc_4.php');
					endforeach;  
         
echo '   
                </fieldset>
            </div>
        </div>
    </section>
';
endforeach;


?>
