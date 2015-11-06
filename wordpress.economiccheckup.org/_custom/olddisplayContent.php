<?php
 
    function getDisplayTextbyID($DisplayId){
		$bcudb = new wpdb('esidtc','W6ApuXec','esidtc','172.31.33.35');
		$bcudb->show_errors();
		$query_getDisplayTextbyID = "
		select dl.display_text
					from display_language dl, language l
					where dl.display_id=".$DisplayId."
						and dl.language_id in ('EN')
						and dl.language_id=l.language_id
						and l.active = 1
					order by l.default_flag
		";
		$getDisplayTextbyID_query = $bcudb->get_results($query_getDisplayTextbyID);
		//$displayText = $bcudb->get_row();
		$rowCount = 0;
		foreach ($getDisplayTextbyID_query  as $textObj) :
			$displayText = $textObj->display_text;
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


    function getIconTextByCode($sectionCode){
	
	$bcudb = new wpdb('esidtc','W6ApuXec','esidtc','172.31.33.35');
	$bcudb->show_errors();
	$query_getIconTextByCode = "
	select icon_code from section where section_code = '".$sectionCode."'
	";
	$getIconTextByCode_query = $bcudb->get_results($query_getIconTextByCode);
	$rowCount = 0;
	foreach ($getIconTextByCode_query  as $iconObj) :
	$iconText = $iconObj->icon_code;
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


    function getHelpDisplayTextbyCode($helpCode){
			
	$bcudb = new wpdb('esidtc','W6ApuXec','esidtc','172.31.33.35');
	$bcudb->show_errors();
	$query_getHelpDisplayTextbyCode = "
	SELECT
	display_language.display_id,
	display_language.display_text,
	display_language.language_id
	FROM
	`help`
	INNER JOIN display_language ON `help`.display_id = display_language.display_id
	WHERE `help`.keyword  = '".$helpCode."'
	and display_language.language_id = 'EN'
	";
	$getHelpDisplayTextbyCode_query = $bcudb->get_results($query_getHelpDisplayTextbyCode);
	//$displayText = $bcudb->get_row();
	$rowCount = 0;
	foreach ($getHelpDisplayTextbyCode_query  as $textObj) :
	$displayText = $textObj->display_text;
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

function findHelpDefinition($displayText){
	$line = $displayText;
	$line = preg_replace_callback(
        '/\[\[[^\]]*\]\]/' // / is a delimiter denoting start and end of expression
,
        function ($matches) {

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
			$defContent = htmlentities(getHelpDisplayTextbyCode($theKey));
			$printLink =  '<a title="'.$cleanedLinkTitle.'" html="true" data-content="'.$defContent.'"  data-placement="top" data-toggle="popover" href="#" data-original-title="'.$cleanedLinkTitle.'">'.$cleanedLinkTitle.'</a>';
 			return $printLink;

        },
        $displayText
    );

return $line ;
  }
  
  function getScreeningAnswerfield($answerfieldID,$screeningID,$responseType){
		$answerfieldResponse = '';
		$answerfieldValidation = '';
	  	$bcudb = new wpdb('esidtc','W6ApuXec','esidtc','172.31.33.35');
		if ($responseType == 1) {
		$query_getScreeningAnswerfield = "
		SELECT
		screening_answerfield.answerfield_id,
		screening_answerfield.screening_id,
		screening_answerfield.responsetype,
		screening_answerfield.response,
		screening_answerfield.option_id,
		screening_answerfield.validation_response
		FROM
		screening_answerfield
		WHERE
		screening_answerfield.screening_id = ".$screeningID." AND
		screening_answerfield.answerfield_id = ".$answerfieldID;
		}
		elseif ($responseType == 2) {
		$query_getScreeningAnswerfield = "
		SELECT
		screening_answerfield.answerfield_id,
		screening_answerfield.screening_id,
		screening_answerfield.responsetype,
		screening_answerfield.validation_response,
		`option`.option_id,
		`option`.option_code as response,
		`option`.display_id,
		`option`.include_flag
		FROM
		screening_answerfield
		INNER JOIN `option` ON screening_answerfield.option_id = `option`.option_id
		WHERE
		screening_answerfield.screening_id = ".$screeningID." AND
		screening_answerfield.answerfield_id = ".$answerfieldID;
		}
		else {
		$query_getScreeningAnswerfield = "
		SELECT
		screening_answerfield.answerfield_id,
		screening_answerfield.screening_id,
		screening_answerfield.responsetype,
		screening_answerfield.validation_response,
		screening_answerfield.option_id,
		'checked' as response,
		`option`.display_id,
		`option`.include_flag
		FROM
		screening_answerfield
		INNER JOIN `option` ON screening_answerfield.option_id = `option`.option_id
		WHERE
		screening_answerfield.screening_id = ".$screeningID." AND
		screening_answerfield.answerfield_id = ".$answerfieldID;
		}
		$getScreeningAnswerfield_query = $bcudb->get_results($query_getScreeningAnswerfield);
		foreach ($getScreeningAnswerfield_query  as $screeningAnswerfieldObj) :
			$answerfieldResponse = $screeningAnswerfieldObj->response;
			$answerfieldValidation = 'vtest';
		endforeach;
		return $answerfieldResponse;
		
  }
  


  function getScreeningAnswerfieldValidation($answerfieldID,$screeningID,$responseType){
		$answerfieldResponse = '';
		$answerfieldValidation = '';
	  	$bcudb = new wpdb('esidtc','W6ApuXec','esidtc','172.31.33.35');
		if ($responseType == 1) {
		$query_getScreeningAnswerfield = "
		SELECT
		screening_answerfield.answerfield_id,
		screening_answerfield.screening_id,
		screening_answerfield.responsetype,
		screening_answerfield.response,
		screening_answerfield.option_id,
		screening_answerfield.validation_response
		FROM
		screening_answerfield
		WHERE
		screening_answerfield.screening_id = ".$screeningID." AND
		screening_answerfield.answerfield_id = ".$answerfieldID;
		}
		elseif ($responseType == 2) {
		$query_getScreeningAnswerfield = "
		SELECT
		screening_answerfield.answerfield_id,
		screening_answerfield.screening_id,
		screening_answerfield.responsetype,
		screening_answerfield.validation_response,
		`option`.option_id,
		`option`.option_code as response,
		`option`.display_id,
		`option`.include_flag
		FROM
		screening_answerfield
		INNER JOIN `option` ON screening_answerfield.option_id = `option`.option_id
		WHERE
		screening_answerfield.screening_id = ".$screeningID." AND
		screening_answerfield.answerfield_id = ".$answerfieldID;
		}
		else {
		$query_getScreeningAnswerfield = "
		SELECT
		screening_answerfield.answerfield_id,
		screening_answerfield.screening_id,
		screening_answerfield.responsetype,
		screening_answerfield.response,
		screening_answerfield.validation_response,
		`option`.option_id,
		'checked' as response,
		`option`.display_id,
		`option`.include_flag
		FROM
		screening_answerfield
		INNER JOIN `option` ON screening_answerfield.option_id = `option`.option_id
		WHERE
		screening_answerfield.screening_id = ".$screeningID." AND
		screening_answerfield.answerfield_id = ".$answerfieldID;
		}
		$getScreeningAnswerfield_query = $bcudb->get_results($query_getScreeningAnswerfield);
		foreach ($getScreeningAnswerfield_query  as $screeningAnswerfieldObj) :
			$answerfieldResponse = $screeningAnswerfieldObj->response;
			$answerfieldValidation =  $screeningAnswerfieldObj->validation_response;
		endforeach;
		return $answerfieldValidation;
		
  }

  function getValidationMessage($answerfieldValidation){
		$validationMessage = '';
	  	$bcudb = new wpdb('esidtc','W6ApuXec','esidtc','172.31.33.35');
		$query_getValidationMessage = "
		SELECT
		display.display_id,
		display.displaygroup_id,
		display.display_code,
		display.display_name,
		display_language.display_text
		FROM
		display
		INNER JOIN displaygroup ON display.displaygroup_id = displaygroup.displaygroup_id
		INNER JOIN display_language ON display_language.display_id = display.display_id
		WHERE
		display.displaygroup_id = 15
		and display_code = '".$answerfieldValidation."'
		and language_id = 'EN'";
		$getValidationMessage_query = $bcudb->get_results($query_getValidationMessage);
		foreach ($getValidationMessage_query as $validationMessagObj) :
			$validationMessage = $validationMessagObj->display_text;
		endforeach;
		return $validationMessage;
		
  }
   function getAFValidationShort($answerfield) {
		$validationMessage = '';
	  	$bcudb = new wpdb('esidtc','W6ApuXec','esidtc','172.31.33.35');
		$query_getAFShortText = "
		SELECT
		display.display_id,
		display.displaygroup_id,
		display.display_code,
		display.display_name,
		display_language.display_text
		FROM
		display
		INNER JOIN displaygroup ON display.displaygroup_id = displaygroup.displaygroup_id
		INNER JOIN display_language ON display_language.display_id = display.display_id
		WHERE
		display.displaygroup_id = 14
		and display_code = 'afshort_".$answerfield."'
		and language_id = 'EN'
		";
		$getAFShortText_query = $bcudb->get_results($query_getAFShortText);
		foreach ($getAFShortText_query as $validationMessagObj) :
			$validationMessage = $validationMessagObj->display_text;
		endforeach;
		return $validationMessage;

  }
?>