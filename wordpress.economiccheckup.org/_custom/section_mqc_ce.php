<?PHP
$questionNumberTotal = 0;
$section_query = $bcudb->get_results($query_getSections);
foreach ($section_query  as $sectionObj) :
$sectionCode = $sectionObj->questioncategory_code;
$sectionName = $sectionObj->questioncategory_code;
$sectionDiplayID = $sectionObj->display_id;
$sectionHeadingText = getDisplayTextbyID($sectionDiplayID);
//Show Intro and legend Section
$sectionLegend = "

<p>
If you enrolled in Medicare within the past 3 months or expect to enroll within
the next twelve months, take this Medicare QuickCheck&trade; to find the best service
to help you make the right decisions about your health insurance coverage and
costs.</p>
<p>
When you fill out this brief and confidential questionnaire, we will tell you
if we think Aon Hewitt Navigators&#174; is the best source of help for you and, if
it is, we will give you options for taking the next step.  If Aon Hewitt
Navigators&#174; is not right for you, we will direct you to other reliable sources
of assistance.</p>

<p><b>Why Aon Hewitt?</b></p><p>   Aon Hewitt Navigators&#174; is a Medicare insurance brokerage
service recommended by NCOA because it meets rigorous Standards of Excellence
established by NCOA in collaboration with leading Medicare experts.  All of
their services are provided at no cost to consumers. Let&#180;s get started!</p>
";
$sectionLegend = apply_filters('the_content', get_post_field('post_content', 109));



$query_getQuestionsbySubsetPartnerState = "
SELECT q.question_id, q.question_code, q.display_id, qc.questioncategory_code , qt.code questiontype_code, q.rule_id, sqc.sort
FROM ( SELECT q.question_id, NULL AS page_id FROM ( SELECT pa.answerfield_id FROM subset_program_base sp, program p, program_answerfield pa, answerfield a WHERE sp.subset_id=74 AND sp.program_id=p.program_id AND (p.state_id IS NULL or p.state_id='MN') AND p.active_flag=1 AND p.program_id=pa.program_id AND pa.answerfield_id NOT IN ( SELECT answerfield_id FROM answerfield_subset_partner WHERE subset_id=74 AND (partner_id is null OR partner_id=77) AND background_flag=1 ) AND pa.answerfield_id=a.answerfield_id AND ( a.state_id IS NULL or a.state_id='MN') UNION SELECT ar.right_answerfield_id as answerfield_id FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a WHERE sp.subset_id=74 AND sp.program_id=p.program_id AND (p.state_id IS NULL or p.state_id='MN') AND p.active_flag=1 AND p.program_id=pa.program_id AND pa.answerfield_id NOT IN ( SELECT answerfield_id FROM answerfield_subset_partner WHERE subset_id=74 AND (partner_id is null OR partner_id=77) AND background_flag=1 ) AND pa.answerfield_id=ar.left_answerfield_id AND ar.relationship_id=2 AND ar.right_answerfield_id=a.answerfield_id AND (a.state_id IS NULL or a.state_id='MN') UNION SELECT pa.answerfield_id FROM subset_program_sum sps, program_answerfield pa, answerfield a WHERE sps.subset_id=74 and pa.program_id = sps.program_id and a.answerfield_id = pa.answerfield_id and sps.program_id in ( select pp.parent_program_id from program_parent pp, program p, subset_program_base spb where spb.program_id = pp.program_id and pp.program_id = p.program_id and spb.subset_id = 74 and (p.state_id = 'MN' or p.state_id IS NULL) ) UNION SELECT ar.right_answerfield_id as answerfield_id FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a WHERE sp.subset_id=74 AND sp.program_id=p.program_id AND (p.state_id IS NULL or p.state_id='MN') AND p.active_flag=1 AND p.program_id=pa.program_id AND pa.answerfield_id NOT IN ( SELECT answerfield_id FROM answerfield_subset_partner WHERE subset_id=74 AND (partner_id is null OR partner_id=77) AND background_flag=1 ) and sp.program_id in (	select pp.parent_program_id from program_parent pp, program p, subset_program_base spb where spb.program_id = pp.program_id and pp.program_id = p.program_id and spb.subset_id = 74 and ( p.state_id = 'NY' or p.state_id is NULL ) ) AND pa.answerfield_id=ar.left_answerfield_id AND ar.relationship_id=2 AND ar.right_answerfield_id=a.answerfield_id AND (a.state_id IS NULL or a.state_id='MN') ) AS a, question_answerfield qa, question q WHERE a.answerfield_id=qa.answerfield_id AND qa.question_id NOT IN ( SELECT question_id FROM subset_question WHERE subset_id=74 AND exclude_flag=1 ) AND qa.question_id=q.question_id AND q.exclude_flag=0 UNION SELECT q.question_id, sq.page_id FROM subset_question sq, question q WHERE sq.subset_id=74 AND sq.exclude_flag=0 AND sq.question_id=q.question_id UNION SELECT q.question_id, NULL AS page_id FROM question q WHERE q.include_flag=1 AND q.question_id NOT IN ( SELECT question_id FROM subset_question WHERE subset_id=74 AND exclude_flag=1 ) ) 
AS a, question q, questioncategory qc , questiontype qt, subset_questioncategory sqc
WHERE a.question_id=q.question_id 
AND q.questioncategory_id=qc.questioncategory_id 
AND q.questiontype_id = qt.questiontype_id
AND sqc.questioncategory_id = qc.questioncategory_id
AND sqc.subset_id = 74
AND qc.questioncategory_code = '".$sectionCode."'
AND q.question_code like 'mqc_%'
ORDER BY qc.sort, q.sort
 ";
$sectionQuestion_query = $bcudb->get_results($query_getQuestionsbySubsetPartnerState);
$icon = getIconTextByCode($sectionCode);
$iconText = 'icon-'.$icon;
if ($sectionHeadingText == 'Basics' ){
$sectionHeadingText = 'Basics';
}
echo'
<section id="'.$sectionCode.'">  	
        <div class="body-header-wrapper">	<h2><i class="'.$iconText.'"></i> '.$sectionHeadingText.' </h2>	
            <div class="body-header" style="z-index: 999; position: static; top: 251.5px;">
                <div class="body-header-inner">
                    <div class="">   
                    </div>
                </div>
            </div>
            <div style="display: none; width: 620px; height: 0px; float: none;"></div>
        </div>
        <div class="">
            <h4></h4>
          
        </div>
        <div class="">
            <div class="well">
                <fieldset>';
		      if ($sectionCode == 'basics'){
			  //Warning Message regarding validation errors
				if ( isset($_GET['badresponselist'])) {
				echo '<div class="alert alert-error">';
      				echo "<p><i class='icon-warning-sign'></i> We're sorry, but some responses are missing or were completed incorrectly. Please correct the problems where indicated below.</p></div>";
				}
			  //Show Intro text under basics section
                       echo '<p>'.$sectionLegend.'</p>';
			}
		      else {
			//No Section Legend text displayed
			$sectionLegend = '';
		    	 echo '<NOlegend>'.$sectionLegend.'</NOlegend>';
			}
					foreach ($sectionQuestion_query  as $sectionQuestionObj) : 
						$questionCode = $sectionQuestionObj->question_code;
						$questionRuleID = $sectionQuestionObj->rule_id;
						$questionCategoryCode = $sectionQuestionObj->questioncategory_code;
						$questionID = $sectionQuestionObj->question_id;
						$questionTypeCode = $sectionQuestionObj->questiontype_code;
						$questionDisplayID = $sectionQuestionObj->display_id;
						if ($questionRuleID == ''){ $questionNumberTotal++; }
						//echo '<p>QuestionCode'.$questionCode.'</p>';
						//echo '<h5>Display Header and Display Code'.$questionCode.$questionDisplayID.'</h5>';
						require('_custom/question_mqc.php');
					endforeach;  
if (($sectionCode !== 'interested') &&( 1 == 0)) {					
echo ' 
<a class="btn btn-primary " id="button-'.$sectionCode.'-show" href="#basics">Continue to Next Section</a>
<script>
$("#button-'.$sectionCode.'-hide").click(function () {
  $("#status-'.$sectionCode.'").hide("fast", function () {
    // use callee so do not have to name the function
    $(this).prev().hide("fast", arguments.callee);
    //document.location.href="#basics"; 
  });
});
$("#button-'.$sectionCode.'-show").click(function () {
  $("#status-'.$sectionCode.'").show(1000);
  nextsection("'.$sectionCode.'");
});
</script>     
';
}          
echo '   
                </fieldset>
            </div>
        </div>
    </section>
';
endforeach;
?> 