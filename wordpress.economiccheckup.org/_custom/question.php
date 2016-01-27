<?php 

//Get question display text.
$query_getDisplayTextByID = "
						select dl.display_text
						from display_language dl, language l
						where dl.display_id=".$questionDisplayID."
						and dl.language_id in ('EN')
						and dl.language_id=l.language_id
						and l.active = 1
						order by l.default_flag
						";
$questionDisplay_query = $bcudb->get_row($query_getDisplayTextByID); 
$questionText = $questionDisplay_query->display_text;
//$questionString = $questionText;
//$findA   = '[[';
//$findB   = ']]';
//$posA = strpos($mystring, $findA);
//$posB = strpos($mystring, $findB);
//echo "Pos:".$posA.":".$posB;
$line = $questionText;

$line = preg_replace_callback(
        '/\[\[[^\]]*\]\]/' // / is a delimiter denoting start and end of expression
,
        function ($matches) {

$parts = explode('|', $matches[0]);
if ( sizeOf($parts) == 2){
 $cleanedLinkTitle = substr ($parts[1], 0, -2);
 $theKey = $cleanedLinkTitle;
 //echo '<h3>size 2:'.$theKey .'</h3>';
}
else if (sizeOf($parts) == 3){
 $cleanedLinkTitle = substr ($parts[2], 0, -2);
 $theKey = $parts[1];
}
$defContent = $theKey;
$defContent = getHelpDisplayTextbyCode($theKey);

 $printLink =  '<a title="'.$cleanedLinkTitle.'" data-content="'.$defContent.'" data-placement="top" data-toggle="popover" href="#" data-original-title="'.$cleanedLinkTitle.'">'.$cleanedLinkTitle.'</a>';
 return $printLink;

        },
        $questionText
    );

$questionText = $line;

$query_getQuestionHelp = "
SELECT
`help`.help_id,
`help`.helptype_id,
`help`.help_code,
`help`.keyword,
`help`.title_display_id,
`help`.display_id,
question_help.question_id,
dl.display_text as helptext,
dl.display_id,
dl.language_id,
dl2.display_text as title
FROM
`help`
INNER JOIN question_help ON `help`.help_id = question_help.help_id
INNER JOIN display_language as dl ON `help`.display_id = dl.display_id
INNER JOIN display_language as dl2 ON `help`.title_display_id = dl2.display_id
WHERE
question_help.question_id = '".$questionID."'
and dl2.language_id = 'EN'
and dl.language_id = 'EN'
";
$getQuestionHelp_query = $bcudb->get_results($query_getQuestionHelp);
//var_dump($getQuestionHelp_query);
echo'
						<div class="clearfix">
                        	<div class="row-fluid" id="row_'.$questionCode.'">
                            	<div class="span1"><strong>'.$questionNumberTotal.'.</strong></div>
                                <div class="span11">					      	
                                	<label for="normalSelect">'.$questionText;

foreach ($getQuestionHelp_query as $questionHelpObj):

$displayID = $questionHelpObj->display_id;
$titleDisplayID = $questionHelpObj->title_display_id;

$helpText = htmlentities(getDisplayTextbyID($displayID));
$helpTitle = getDisplayTextbyID($titleDisplayID);
//$questionHelpText = $questionHelpObj->$helptext;	
//$questionHelpTitle = $questionHelpObj->$title;	
//echo 	$questionHelpText;						
echo'									
									<a data-content="'.$helpText.'" title="'.$helpTitle.'" data-html="true"  data-toggle="popover" href="#" data-original-title="Help"><i class="icon-question-sign icon-large fonta1"></i></a>
';	
endforeach;							
echo'									</label>';
									require('_custom/questiontype.php');
									
                                    
echo'                                </div>
                          	</div>
						</div>
';
?> 

