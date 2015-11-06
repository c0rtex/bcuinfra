<?php 

//Get question display text.
$questionText = getDisplayTextByID ($questionDisplayID, $soapClient); //located in displaycontent_mqc_4.php
//$questionString = $questionText;
//$findA   = '[[';
//$findB   = ']]';
//$posA = strpos($mystring, $findA);
//$posB = strpos($mystring, $findB);
//echo "Pos:".$posA.":".$posB;
$line = $questionText;
//echo $questionText;
$line = preg_replace_callback(
        '/\[\[[^\]]*\]\]/' // / is a delimiter denoting start and end of expression
,
        function ($matches) use ($soapClient) {


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

//popup upper case first char in each word of title string
//$cleanedLinkTitle2 = ucwords($cleanedLinkTitle);
$cleanedLinkTitle2 = getHelpTitleByCode ($theKey, $soapClient);  //corresponds to cleanedLinkTitleDb in displaycontent_mqc.php for the answers
$defContent = $theKey;

//$url = "https://redesign.benefitscheckup.org/util/remotescreening_3_0.cfc?WSDL";
//$soapClient = new SoapClient($url, array('cache_wsdl' => WSDL_CACHE_NONE));
$defContent = getHelpDisplayTextbyCode($theKey, $soapClient);

 $printLink =  '<a title="'.$cleanedLinkTitle2.'" data-content="'.$defContent.'" data-placement="top" data-toggle="popover" href="#" data-original-title="'.$cleanedLinkTitle.'">'.$cleanedLinkTitle.'</a> ';
 return $printLink;

        },
        $questionText
    );

$questionText = $line;

$getQuestionHelp_query = $soapClient->getQuestionHelp($questionID);
//$getQuestionHelp_query = restructureWSArray ($getQuestionHelp_query);

//var_dump($getQuestionHelp_query);
echo'
						<div class="clearfix">
                        	<div class="row-fluid" id="'.$questionCode.'">
                            	<span class="span1"><strong>';
if ($questionRuleID == '') { 
if ($subsetID == '72' || $subsetID == '74' || $subsetID == '75'){ //this is one of the 3 MQC questionnaires, not the triage
echo $questionNumberTotal.".";
}
}
else {
echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
}

echo '</strong></span>
                                <span class="span11">					      	
                                	<label for="normalSelect">'.$questionText;

foreach ($getQuestionHelp_query as $questionHelpObj):

$displayID = $questionHelpObj["DISPLAY_ID"];
$titleDisplayID = $questionHelpObj["TITLE_DISPLAY_ID"];

$helpText = htmlentities(getDisplayTextbyID($displayID, $soapClient));
$helpTitle = getDisplayTextbyID($titleDisplayID, $soapClient);
//$questionHelpText = $questionHelpObj->$helptext;	
//$questionHelpTitle = $questionHelpObj->$title;	
//echo 	$questionHelpText;						
echo'									
									<a data-content="'.$helpText.'" title="'.$helpTitle.'" data-html="true"  data-toggle="popover" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"></i></a>
';	
endforeach;							
echo'									</label>';
									require('_custom/questiontype_mqc_4.php');
									
                                    
echo'                                </span>
                          	</div>
						</div>
';
?> 

