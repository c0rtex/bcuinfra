<?PHP

require_once('_custom/soap_client.php');

//print_r ($sectionQuestion_wsArray);
//echo $query_getSections;

$questionNumberTotal = 0;

//NOTE: Lynna Cekova, reg. Bcu Quickcheck: only one section, so we get all questions without dealing with the messy query with the sections 

//get the questions for the section via web services


$sectionQuestion_wsArray = $soapClient->getBcuQuickcheckQuestions($subsetID);

//echo "The questions";
//print_r ($sectionQuestion_wsArray);

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
						$questionCode = $sectionQuestionObj["ANSWERFIELD"];
						$questionCategoryCode = $sectionQuestionObj["CATEGORY"];
						$questionID = $sectionQuestionObj["QUESTION_ID"];
						$questionText = $sectionQuestionObj["QUESTION"];
						$questionTypeCode = $sectionQuestionObj["TYPE"];
						require('_custom/question_bcu_quickcheck.php');
					endforeach;         
echo '   
                </fieldset>
        </div>
    </section>
';


?>
