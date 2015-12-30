<?php


 
    function getDisplayTextbyID($DisplayId, $soapClient) {
		$getDisplayTextbyID_query = $soapClient->getDisplayTextByID($DisplayId);
                //$getDisplayTextbyID_query = restructureWSArray ($getDisplayTextbyID_query);
//echo "<pre>";
//print_r ($getDisplayTextbyID_query);
		//$displayText = $bcudb->get_row();
$displayText = "";
		$rowCount = 0;
		foreach ($getDisplayTextbyID_query  as $textObj) :
			$displayText = $textObj["DISPLAY_TEXT"];
		$rowCount ++;
		endforeach;
		//$rowCount = $bcudb->num_rows();
		if ($rowCount == 0) {
		$displayText = '<h4 class="Alert-Heading">No Content Found</h4>';
		return $displayText;
		}
		else {	
			$displayText = $displayText;
			return $displayText;
		}

	
    }




    function getIconTextByCode($sectionCode, $soapClient){
	
	$getIconTextByCode_query = $soapClient->getIconTextByCode($sectionCode);
//$getIconTextByCode_query = restructureWSArray($getIconTextByCode_query);
	$rowCount = 0;
	foreach ($getIconTextByCode_query  as $iconObj) :
	$iconText = $iconObj["ICON_CODE"];
	$rowCount ++;
	endforeach;
	//$rowCount = $bcudb->num_rows();
	if ($rowCount == 0) {
		$iconText = 'question-sign';
		return $iconText;
	}
	else {	

	return $iconText;
	}

    }
    
	function getHelpDefinition($displayText){
	
	//set definitions replace text code with link
	$fieldString = $displayText;
	//$defContent = "Definition Text";
	//$defTitle = "Definition";
	//$startDef = '<a title="'.$defTitle.'" data-content="'.$defContent.'" html="true" data-placement="top" data-toggle="popover" href="#" data-original-title="'.$defTitle.'">';
	//$endDef = "</a>"; 
	//$outText = str_replace("[[def|", $startDef, $fieldString);
	//$outText2 = str_replace("]]", "$endDef", $outText);
	//$helpDefinitionText = $outText2;
	
	return $fieldString;		
    }


    function getHelpDisplayTextbyCode($helpCode, $soapClient){
			
	$getHelpDisplayTextbyCode_query = $soapClient->getHelpDisplayTextbyCode($helpCode);
	//$getHelpDisplayTextbyCode_query = restructureWSArray($getHelpDisplayTextbyCode_query);
	//$displayText = $bcudb->get_row();
	$rowCount = 0;
	foreach ($getHelpDisplayTextbyCode_query  as $textObj) :
	$displayText = $textObj["DISPLAY_TEXT"];
	$rowCount ++;
	endforeach;
	//$rowCount = $bcudb->num_rows();
	if ($rowCount == 0) {
		$displayText = '<h4 class="Alert-Heading">No Content Found: '.$helpCode.'</h4>';
		return $displayText;
	}
	else {	

	return $displayText;
	}

	
    }

    function getHelpTitleByCode($helpCode, $soapClient){
			
	$getHelpDisplayTextbyCode_query = $soapClient->getHelpTitlebyCode($helpCode);
	//$getHelpDisplayTextbyCode_query = restructureWSArray ($getHelpDisplayTextbyCode_query);
        
	//$displayText = $bcudb->get_row();
	$rowCount = 0;
	foreach ($getHelpDisplayTextbyCode_query  as $textObj) :
	$displayText = $textObj["DISPLAY_TEXT"];
	$rowCount ++;
	endforeach;
	//$rowCount = $bcudb->num_rows();
	if ($rowCount == 0) {
		$displayText = '<h4 class="Alert-Heading">No Content Found: '.$helpCode.'</h4>';
		return $displayText;
	}
	else {	

	return $displayText;
	}

	
    }


function findHelpDefinition($displayText, $soapClient){
	$line = $displayText;
	$line = preg_replace_callback(
        '/\[\[[^\]]*\]\]/' // / is a delimiter denoting start and end of expression
,
        function ($matches) use ($soapClient) {

		$parts = explode('|', $matches[0]);
			if ( sizeOf($parts) == 2){
 				$cleanedLinkTitle = substr ($parts[1], 0, -2);
 				$theKey = $cleanedLinkTitle;
 				echo '<h3>size 2:'.$theKey .'</h3>';
			}
			else if (sizeOf($parts) == 3){
			 	$cleanedLinkTitle = substr ($parts[2], 0, -2);
 				$theKey = $parts[1];
			}
			$defContent = $theKey;
                        //Lynna Cekova TODO
                        //$cleanedLinkTitle = "testOrig";
                        $cleanedLinkTitleDb = htmlentities (getHelpTitleByCode($theKey, $soapClient)); //corresponds to cleanedLinkTite2 in question_mqc.php for the questions
                        //$cleanedLinkTitleDb = "test";
                        
			$defContent = htmlentities(getHelpDisplayTextbyCode($theKey, $soapClient));
			$printLink =  '<a title="'.$cleanedLinkTitleDb.'" html="true" data-content="'.$defContent.'"  data-placement="top" data-toggle="popover" href="#" data-original-title="'.$cleanedLinkTitleDb.'">'.$cleanedLinkTitle.'</a>';
 			return $printLink;

        },
        $displayText
    );

return $line ;
  }
  
  function getScreeningAnswerfield($soapClient, $answerfieldID,$screeningID,$responseType){
		$answerfieldResponse = '';
		$answerfieldValidation = '';
		if ($responseType == 1) {
		//echo $screeningID.'a_id'.$answerfieldID;
		$getScreeningAnswerfield_query = $soapClient->getScreeningAnswerfield1($screeningID, $answerfieldID);
				}
		
		elseif ($responseType == 2) {
		$getScreeningAnswerfield_query = $soapClient->getScreeningAnswerfield2($screeningID, $answerfieldID);
		}
		else {
		$getScreeningAnswerfield_query = $soapClient->getScreeningAnswerfield3($screeningID, $answerfieldID);

		}
//echo '<pre> AF';
//print_r ($getScreeningAnswerfield_query);

		//$getScreeningAnswerfield_query = restructureWSArray ($getScreeningAnswerfield_query);
		foreach ($getScreeningAnswerfield_query  as $screeningAnswerfieldObj) :
			$answerfieldResponse = $screeningAnswerfieldObj["RESPONSE"];
			$answerfieldValidation = 'vtest';
		endforeach;
		return $answerfieldResponse;
		
  }
  


  function getScreeningAnswerfieldValidation($soapClient, $answerfieldID,$screeningID,$responseType){
		$answerfieldResponse = '';
		$answerfieldValidation = '';
	  	//$bcudb = new wpdb(DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU,DB_HOST_BCU);
		if ($responseType == 1) {

		$getScreeningAnswerfield_query = $soapClient->getScreeningAnswerfieldValidation1($screeningID, $answerfieldID);
		}
		elseif ($responseType == 2) {

		$getScreeningAnswerfield_query = $soapClient->getScreeningAnswerfieldValidation2($screeningID, $answerfieldID);

		}
		else {

		$getScreeningAnswerfield_query = $soapClient->getScreeningAnswerfieldValidation3($screeningID, $answerfieldID);

		}

		//$getScreeningAnswerfield_query = restructureWSArray ($getScreeningAnswerfield_query);
//echo '<pre> AFV';
//print_r ($getScreeningAnswerfield_query);

		foreach ($getScreeningAnswerfield_query  as $screeningAnswerfieldObj) :
			$answerfieldResponse = $screeningAnswerfieldObj["RESPONSE"];
			$answerfieldValidation =  $screeningAnswerfieldObj["VALIDATION_RESPONSE"];
		endforeach;
		return $answerfieldValidation;
		
  }

  function getValidationMessage($answerfieldValidation){
		$validationMessage = '';
	  	$getValidationMessage_query = $soapClient->getValidationMessage($answerfieldValidation);
	  	//$getValidationMessage_query = restructureWSArray($getValidationMessage_query);

		foreach ($getValidationMessage_query as $validationMessagObj) :
			$validationMessage = $validationMessagObj["DISPLAY_TEXT"];
		endforeach;
		return $validationMessage;
		
  }
   function getAFValidationShort($answerfield) {
		$validationMessage = '';
		$getAFShortText_query = $soapClient->getAFValidationShort($answerfield);
		//$getAFShortText_query = restructureWSArray($getAFShortText_query);
		foreach ($getAFShortText_query as $validationMessagObj) :
			$validationMessage = $validationMessagObj["DISPLAY_TEXT"];
		endforeach;
		return $validationMessage;

  }
?>
