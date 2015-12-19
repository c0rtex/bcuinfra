<?php
//set screening id to session value passed via url
$screeningID = 1.0;
if (isset($_GET['screeningID'])) {
  $screeningID = $_GET['screeningID'];
}
if (isset($_GET['prevID'])) {
  $screeningID = $_GET['prevID'];
}
//echo $screeningID;
$displayID = 0;
$displayID = $questionAnswerfieldObj["DISPLAY_ID"];
$answerfieldText = getDisplayTextbyID($displayID, $soapClient);
//echo "answerfieldText: ";
//echo $answerfieldText;
$answerfieldID = $questionAnswerfieldObj["ANSWERFIELD_ID"];
$answerfieldText = findHelpDefinition($answerfieldText, $soapClient);
//$answerfieldText = "testA";
//$answerfieldValue  = getScreeningAnswerfield($soapClient,6527,5019848,3);
//$answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,6527,5019848,3);
//echo '<label>code:'.$answerfieldCode.'</label>';
//echo "questionTypeCode: ";
//echo $questionTypeCode;
//echo " answerfieldCode: ";
//echo $answerfieldCode ;
switch ($answerfieldCode) {
  case 'currency':
    $responseType = 1;
    $answerfieldValue  = getScreeningAnswerfield($soapClient,$answerfieldID,$screeningID,$responseType);
    $answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,$answerfieldID,$screeningID,$responseType);
    // Check if a validation error should be shown.
    if ( isset($_GET['badresponselist'])) {
      $mystring = $_GET['badresponselist'];
      $findme   = $answerfield;
      $pos = strpos($mystring, $findme);
      // if error found, show validation message.
      if ($pos !== false) {
        $alertText = "You must enter a response.";
        $afShortText = "Please Correct";
        if ($answerfieldValidation !== '') {
          $validationCode = 'valid_'.$answerfieldValidation;
          $alertText = getValidationMessage($soapClient,$validationCode);
          $afShortText = getAFValidationShort($soapClient,$answerfield);
        }
        echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>'.$afShortText.': </strong> '.$alertText.'</p></div>';
      }
    }

    // echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
    // echo '<label>prefill:'.$answerfieldValue.'validation:'.$answerfieldValidation.'</label>';
    //set definitions replace text code with link
    echo '
		<div class="clearfix" id="cf_'.$answerfield.'">
        	<div class="row-fluid" id="row_'.$answerfield.'">
            <div class="span6 input">
				<div id="tr_'.$answerfield.'" class="input-prepend input-append">
					<label for="normalText" id="label_'.$answerfield.'">
					<span class="add-on">$</span><input type="text" maxwidth="'.$maxLength.'" id="'.$answerfield.'" name="'.$answerfield.'" value="'.$answerfieldValue.'" maxlength="8" size="20" onblur="chkDollar(this,value);"';

    if ($answerfield=='receive_snap_amount'){
      echo 'class="fdstmp_receive_class"';
    }

    if ($answerfield=='receive_liheap_amount'){
      echo 'class="liheap_receive_class"';
    }

    if ($answerfield=='receive_medicaid_amount'){
      echo 'class="med_receive_class"';
    }

    if ($answerfield=='receive_property_tax_amount'){
      echo 'class="receive_propertytax_class"';
    }


    echo '><span class="add-on">.00</span>
					</label>
				</div>
            </div>
            <div class="span6">
                 <label id="label_'.$answerfield.'_2" for="normalText">'.$answerfieldText.'</label>
            </div>
         </div>
		</div>
		';
    break;

  case 'checkbox':
    //set definitions replace text code with link
    $responseType = 3;
    $answerfieldValue  = getScreeningAnswerfield($soapClient,$answerfieldID,$screeningID,$responseType);
    $answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,$answerfieldID,$screeningID,$responseType);
    // Check if a validation error should be shown.
    if ( isset($_GET['badresponselist'])) {
      $mystring = $_GET['badresponselist'];
      $findme   = $answerfield;
      $pos = strpos($mystring, $findme);
      // if error found, show validation message.
      if ($pos !== false) {
        $alertText = "You must enter a response.";
        $afShortText = "Please Correct";
        if ($answerfieldValidation !== '') {
          $validationCode = 'valid_'.$answerfieldValidation;
          $alertText = getValidationMessage($soapClient,$validationCode);
          $afShortText = getAFValidationShort($soapClient,$answerfield);
        }
        if ($answerfieldValidation !== '') {
          echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i></i> <strong>'.$afShortText.': </strong> '.$alertText.'</p></div>';
        }
      }
    }

    //echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
    //echo '<label>prefill:'.$answerfieldValue.' validation:'.$answerfieldValidation.'</label>';
    $checked = '';
    if ($answerfieldValue == 'checked') {
      $checked = 'checked';
    }
    if ($questionTypeCode !== 'radio') {
      echo '
		  <div id="tr_'.$answerfield.'" class="checkbox">
                <label class="checkbox" id="label_'.$answerfield.'"><input type="checkbox" '.$checked.' name="'.$answerfield.'" id="'.$answerfield.'" value="y"';
    }
    elseif (1 == 1) {

      echo '
		  <div id="tr_'.$answerfield.'" class="radio">
                <label class="radio-inline" id="label_'.$answerfield.'"><input type="radio" '.$checked.' name="'.$questionCode.'" id="'.$answerfield.'" value="'.$answerfield.'"';
    }

//QUESTIONS 11 and 12
//if ($answerfield == 'fdstmp_receive' || $answerfield == 'liheap_receive' || $answerfield == 'med_receive' || $answerfield == 'receive_propertytax'){ //the first two don't get the class because they use an alt js function for showing/hiding QUESTION 12
//
//echo ' class="benefitsCheckbox"';//.$answerfield.;
//}
    if (1 == 1) {
      echo '>'.$answerfieldText.'</label>
          	 </div>
		';
    }
    break;

  case 'yn':
    $responseType = 2;
    $answerfieldValue  = getScreeningAnswerfield($soapClient,$answerfieldID,$screeningID,$responseType);
    $answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,$answerfieldID,$screeningID,$responseType);
    // Check if a validation error should be shown.
    if ( isset($_GET['badresponselist'])) {
      $mystring = $_GET['badresponselist'];
      $findme   = $answerfield;
      $pos = strpos($mystring, $findme);
      // if error found, show validation message.
      if ($pos !== false) {
        $alertText = "You must enter a response.";
        $afShortText = "Please Correct";
        if ($answerfieldValidation !== '') {
          $validationCode = 'valid_'.$answerfieldValidation;
          $alertText = getValidationMessage($soapClient,$validationCode);
          $afShortText = getAFValidationShort($soapClient,$answerfield);
        }
        echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>'.$afShortText.': </strong> '.$alertText.'</p></div>';
      }
    }

    //echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
    //echo '<label>prefill:'.$answerfieldValue.':validation:'.$answerfieldValidation.'</label>';
    $yes = '';
    $no = '';
    if ($answerfieldValue == 'y') {
      $yes = 'checked';
    }
    else {
      $no = 'checked';
    }
    echo '
		<div class="radio">
           <div data-toggle="buttons-radio" id="tr_'.$answerfield.'" class="btn-group"><label id="label_'.$answerfield.'">'.$answerfieldText.'</label>
               <label class="radio inline" id="label_radio_yes_'.$answerfield.'">
			   		<input id="radio_yes_'.$answerfield.'" '.$yes.' type="radio" name="'.$answerfield.'" value="y">Yes</label>
               <label class="radio inline" id="label_radio_no_'.$answerfield.'">
			   		<input id="radio_no_'.$answerfield.'" '.$no.' type="radio" name="'.$answerfield.'" value="n">No</label> 
           </div>
        </div>		
		';
    break;
  case 'ynd':
    $responseType = 2;
    $answerfieldValue  = getScreeningAnswerfield($soapClient,$answerfieldID,$screeningID,$responseType);
    $answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,$answerfieldID,$screeningID,$responseType);
    // Check if a validation error should be shown.
    if ( isset($_GET['badresponselist'])) {
      $mystring = $_GET['badresponselist'];
      $findme   = $answerfield;
      $pos = strpos($mystring, $findme);
      // if error found, show validation message.
      if ($pos !== false) {
        $alertText = "You must enter a response.";
        $afShortText = "Please Correct";
        if ($answerfieldValidation !== '') {
          $validationCode = 'valid_'.$answerfieldValidation;
          $alertText = getValidationMessage($soapClient,$validationCode);
          $afShortText = getAFValidationShort($soapClient,$answerfield);
        }
        echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>'.$afShortText.': </strong> '.$alertText.'</p></div>';
      }
    }

    //echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
    //echo '<label>prefill:'.$answerfieldValue.':validation:'.$answerfieldValidation.'</label>';
    $yes = '';
    $no = '';
    $dontknow = '';
    if ($answerfieldValue == 'y') {
      $yes = 'checked';
    }
    elseif ($answerfieldValue == 'n') {
      $no = 'checked';
    }
    elseif ($answerfieldValue == 'dontknow') {
      $dontknow = 'checked';
    }
    elseif  ($answerfield == 'mqc_receive_hsa') {
      $no = 'checked';
    }
    elseif  ($answerfield == 'mqc_health_insurance') {
      $no = 'checked';
    }
    else {
      $yes = 'checked';
    }
    echo '
		<div class="radio">
           <div data-toggle="buttons-radio" id="tr_'.$answerfield.'" class="btn-group"><label id="label_'.$answerfield.'">'.$answerfieldText.'</label>
               <label class="radio inline" id="label_radio_yes_'.$answerfield.'">
			   		<input id="radio_yes_'.$answerfield.'" '.$yes.' type="radio" name="'.$answerfield.'" value="y">Yes</label>
               <label class="radio inline" id="label_radio_no_'.$answerfield.'">
			   		<input id="radio_no_'.$answerfield.'" '.$no.' type="radio" name="'.$answerfield.'" value="n">No</label> 
		<label class="radio inline" id="label_radio_dontknow_'.$answerfield.'">
			   		<input id="radio_no_'.$answerfield.'" '.$dontknow.' type="radio" name="'.$answerfield.'" value="dontknow">Don'."'".'t Know</label> 
           </div>
        </div>		
		';
    break;
  case 'nyd':
    $responseType = 2;
    $answerfieldValue  = getScreeningAnswerfield($soapClient,$answerfieldID,$screeningID,$responseType);
    $answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,$answerfieldID,$screeningID,$responseType);
    // Check if a validation error should be shown.
    if ( isset($_GET['badresponselist'])) {
      $mystring = $_GET['badresponselist'];
      $findme   = $answerfield;
      $pos = strpos($mystring, $findme);
      // if error found, show validation message.
      if ($pos !== false) {
        $alertText = "You must enter a response.";
        $afShortText = "Please Correct";
        if ($answerfieldValidation !== '') {
          $validationCode = 'valid_'.$answerfieldValidation;
          $alertText = getValidationMessage($soapClient,$validationCode);
          $afShortText = getAFValidationShort($soapClient,$answerfield);
        }
        echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>'.$afShortText.': </strong> '.$alertText.'</p></div>';
      }
    }

    //echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
    //echo '<label>prefill:'.$answerfieldValue.':validation:'.$answerfieldValidation.'</label>';
    $yes = '';
    $no = '';
    $dontknow = '';
    if ($answerfieldValue == 'y') {
      $yes = 'checked';
    }
    elseif ($answerfieldValue == 'n') {
      $no = 'checked';
    }
    elseif ($answerfieldValue == 'dontknow') {
      $dontknow = 'checked';
    }

    echo '
		<div class="radio">
           <div data-toggle="buttons-radio" id="tr_'.$answerfield.'" class="btn-group"><label id="label_'.$answerfield.'">'.$answerfieldText.'</label>
		<label class="radio inline" id="label_radio_no_'.$answerfield.'">
			   		<input id="radio_no_'.$answerfield.'" '.$no.' type="radio" name="'.$answerfield.'" value="n">No</label>
               <label class="radio inline" id="label_radio_yes_'.$answerfield.'">
			   		<input id="radio_yes_'.$answerfield.'" '.$yes.' type="radio" name="'.$answerfield.'" value="y">Yes</label> 
		<label class="radio inline" id="label_radio_dontknow_'.$answerfield.'">
			   		<input id="radio_no_'.$answerfield.'" '.$dontknow.' type="radio" name="'.$answerfield.'" value="dontknow">Don'."'".'t Know</label> 
           </div>
        </div>		
		';
    break;
  case 'ny':
    $responseType = 2;
    $answerfieldValue  = getScreeningAnswerfield($soapClient,$answerfieldID,$screeningID,$responseType);
    $answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,$answerfieldID,$screeningID,$responseType);
    // Check if a validation error should be shown.
    if ( isset($_GET['badresponselist'])) {
      $mystring = $_GET['badresponselist'];
      $findme   = $answerfield;
      $pos = strpos($mystring, $findme);
      // if error found, show validation message.
      if ($pos !== false) {
        $alertText = "You must enter a response.";
        $afShortText = "Please Correct";
        if ($answerfieldValidation !== '') {
          $validationCode = 'valid_'.$answerfieldValidation;
          $alertText = getValidationMessage($soapClient,$validationCode);
          $afShortText = getAFValidationShort($soapClient,$answerfield);
        }
        echo '<div class="alert alert-danger" ><i class="icon-warning-sign"></i><p><strong>'.$afShortText.': </strong> '.$alertText.'</p></div>';
      }
    }
    //echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
    //echo '<label>prefill:'.$answerfieldValue.':validation:'.$answerfieldValidation.'</label>';
    $yes = '';
    $no = '';
    if ($answerfieldValue == 'y') {
      $yes = 'checked';
    }
    else {
      $no = 'checked';
    }
    echo '
		<div class="radio">
           <div data-toggle="buttons-radio" id="tr_'.$answerfield.'" class="btn-group"><label id="label_'.$answerfield.'">'.$answerfieldText.'</label>
               <label class="radio inline" id="label_radio_no_'.$answerfield.'">
			   		<input id="radio_no_'.$answerfield.'" '.$no.' type="radio" name="'.$answerfield.'" value="n">No</label>
               <label class="radio inline" id="label_radio_yes_'.$answerfield.'">
			   		<input id="radio_yes_'.$answerfield.'" '.$yes.' type="radio" name="'.$answerfield.'" value="y">Yes</label> 
           </div>
         </div>		
		';
    break;

  case 'select':

    $responseType = 2;
    $answerfieldValue  = getScreeningAnswerfield($soapClient,$answerfieldID,$screeningID,$responseType);
    $answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,$answerfieldID,$screeningID,$responseType);
    // Check if a validation error should be shown.
    if ( isset($_GET['badresponselist'])) {
      $mystring = $_GET['badresponselist'];
      $findme   = $answerfield;
      $pos = strpos($mystring, $findme);
      // if error found, show validation message.
      if ($pos !== false) {
        $alertText = "You must enter a response.";
        $afShortText = "Please Correct";
        if ($answerfieldValidation !== '') {
          $validationCode = 'valid_'.$answerfieldValidation;
          $alertText = getValidationMessage($soapClient,$validationCode);
          $afShortText = getAFValidationShort($soapClient,$findme);
        }
        echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>'.$afShortText.': </strong> '.$alertText.'</p></div>';
      }
    }
    //echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
    //echo '<label>prefill:'.$answerfieldValue.'validation:'.$answerfieldValidation.'</label>';
    if ($answerfieldText !== 'Client' ){
      echo '<label id="label_'.$answerfield.'" >'.$answerfieldText.'</label>';
    }
    echo '
			<div class="input" id="tr_'.$answerfield.'">
				<select id="select_'.$answerfield.'" name="'.$answerfield.'" class="medium" ';
    if ($answerfield == 'mqc_client'){
      echo '
onChange="if(!startForm) { ga(\'send\', \'event\', \'mqc\', \'MQC Tool Start\', \'startquickcheck\'); ga(\'mmm.send\', \'event\', \'mqc\', \'MQC Tool Start\', \'startquickcheck\'); startForm=true; }"
';

    }
    if ($answerfieldText == 'Client' ){
      echo '
						onChange="var objrow = document.getElementById(\'tr_bcu_other_specify\'); 
						if (this.selectedIndex == this.options.length - 1) objrow.style.display = \'\'; 
						else {this.form.esi_other_specify.value = \'\';
						 objrow.style.display = \'none\';}">';
    }
    else {
      echo '>';
    }
    echo '			   	<option value="">-- Select --</option>';
    require('answerfieldoption_bcu_quickcheck.php');
    echo		'</select>
		</div>
		';
    if ($answerfield == 'mqc_client') {

      echo '<strong>Please note:</strong> If you are completing this for someone else, please answer all questions as if you are that person.';
    }
    break;

  case 'text':
    $responseType = 1;
    $answerfieldValue  = getScreeningAnswerfield($soapClient,$answerfieldID,$screeningID,$responseType);
    $answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,$answerfieldID,$screeningID,$responseType);
    // Check if a validation error should be shown.
    if ( isset($_GET['badresponselist'])) {
      $mystring = $_GET['badresponselist'];
      $findme   = $answerfield;
      $pos = strpos($mystring, $findme);
      // if error found, show validation message.
      if ($pos !== false) {
        $alertText = "You must enter a response.";
        $afShortText = "Please Correct";
        if ($answerfieldValidation !== '') {
          $validationCode = 'valid_'.$answerfieldValidation;
          $alertText = getValidationMessage($soapClient,$validationCode);
          $afShortText = getAFValidationShort($soapClient,$answerfield);
        }
        echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>'.$afShortText.': </strong> '.$alertText.'</p></div>';
      }
    }
    echo '<label>
        <div class="input" id="tr_'.$answerfield.'"'; if  ($answerfield == 'esi_other_specify') { echo 'style="display: none;"'; }
    echo '>	<input type="text" maxwidth="'.$maxLength.'" id="'.$answerfield.'"  class="required" name="'.$answerfield.'" value="'.$answerfieldValue.'" k>&nbsp;'.$answerfieldText.'
		</label></div>';

    break;

  case 'zipcode':
    $responseType = 1;
    $answerfieldValue = getScreeningAnswerfield($soapClient,$answerfieldID,$screeningID,$responseType);
    $answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,$answerfieldID,$screeningID,$responseType);
    //echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.',Value:'.$answerfieldValue.'</label>';
    // Check if a validation error should be shown.
    if ( isset($_GET['badresponselist'])) {
      $mystring = $_GET['badresponselist'];
      $findme   = $answerfield;
      $pos = strpos($mystring, $findme);
      // if error found, show validation message.
      if ($pos !== false) {
        $alertText = "You must enter a response.";
        $afShortText = "Please Correct";
        $afShortText = 'Zip Code';
        if ($answerfieldValidation !== '') {
          $validationCode = 'valid_'.$answerfieldValidation;
          $alertText = getValidationMessage($soapClient,$validationCode);
          $afShortText = getAFValidationShort($soapClient,$answerfield);
        }
        echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>'.$afShortText.':</strong> '.$alertText.'</p></div>';
      }
    }

    echo '
        <div class="input" id="tr_'.$answerfield.'">									
		<input type="text" pattern="[0-9]*"  maxwidth="5" id="'.$answerfield.'" size="6" autocomplete="off" minlength="5"  maxlength="5" name="'.$answerfield.'" class="required">';
    //zip state js check

    echo "
	

	";

    echo '
    	<input type="text" name="zyxzip_zip_abbrev" id="zyxzip_zip_abbrev" size="1" value="" disabled="" style="font-size: 7pt; font-weight: bold; color: rgb(102, 102, 102); background-color: rgb(221, 221, 221); border: 1px dotted black;">
    ';
    break;
  case 'day':
    $responseType = 1;
    $answerfieldValue  = getScreeningAnswerfield($soapClient,$answerfieldID,$screeningID,$responseType);
    $answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,$answerfieldID,$screeningID,$responseType);
    // Check if a validation error should be shown.
    if ( isset($_GET['badresponselist'])) {
      $mystring = $_GET['badresponselist'];
      $findme   = $answerfield;
      $pos = strpos($mystring, $findme);
      // if error found, show validation message.
      if ($pos !== false) {
        $alertText = "You must enter a response.";
        $afShortText = "Please Correct";
        if ($answerfieldValidation !== '') {
          $validationCode = 'valid_'.$answerfieldValidation;
          $alertText = getValidationMessage($soapClient,$validationCode);
          $afShortText = getAFValidationShort($soapClient,$answerfield);
        }
        echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>'.$afShortText.': </strong> '.$alertText.'</p></div>';
      }
    }
    //echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
    //echo '<label>prefill:'.$answerfieldValue.'validation:'.$answerfieldValidation.'</label>';
    echo '<div class="input" id="tr_'.$answerfield.'"><label id="label_'.$answerfield.'">
                               	<select id="'.$answerfield.'" name="'.$answerfield.'">
                               	 <option value="">-- Day --</option>';
    echo '<option value="1" '; if ($answerfieldValue == 1){ echo 'selected'; } echo '> 1 </option>';
    echo '<option value="2" '; if ($answerfieldValue == 2){ echo 'selected'; } echo '> 2 </option>';
    echo '<option value="3" '; if ($answerfieldValue == 3){ echo 'selected'; } echo '> 3 </option>';
    echo '<option value="4" '; if ($answerfieldValue == 4){ echo 'selected'; } echo '> 4 </option>';
    echo '<option value="5" '; if ($answerfieldValue == 5){ echo 'selected'; } echo '> 5 </option>';
    echo '<option value="6" '; if ($answerfieldValue == 6){ echo 'selected'; } echo '> 6 </option>';
    echo '<option value="7" '; if ($answerfieldValue == 7){ echo 'selected'; } echo '> 7 </option>';
    echo '<option value="8" '; if ($answerfieldValue == 8){ echo 'selected'; } echo '> 8 </option>';
    echo '<option value="9" '; if ($answerfieldValue == 9){ echo 'selected'; } echo '> 9 </option>';
    echo '<option value="10" '; if ($answerfieldValue == 10){ echo 'selected'; } echo '> 10 </option>';
    echo '<option value="11" '; if ($answerfieldValue == 11){ echo 'selected'; } echo '> 11 </option>';
    echo '<option value="12" '; if ($answerfieldValue == 12){ echo 'selected'; } echo '> 12 </option>';
    echo '<option value="13" '; if ($answerfieldValue == 13){ echo 'selected'; } echo '> 13 </option>';
    echo '<option value="14" '; if ($answerfieldValue == 14){ echo 'selected'; } echo '> 14 </option>';
    echo '<option value="15" '; if ($answerfieldValue == 15){ echo 'selected'; } echo '> 15 </option>';
    echo '<option value="16" '; if ($answerfieldValue == 16){ echo 'selected'; } echo '> 16 </option>';
    echo '<option value="17" '; if ($answerfieldValue == 17){ echo 'selected'; } echo '> 17 </option>';
    echo '<option value="18" '; if ($answerfieldValue == 18){ echo 'selected'; } echo '> 18 </option>';
    echo '<option value="19" '; if ($answerfieldValue == 19){ echo 'selected'; } echo '> 19 </option>';
    echo '<option value="20" '; if ($answerfieldValue == 20){ echo 'selected'; } echo '> 20 </option>';
    echo '<option value="21" '; if ($answerfieldValue == 21){ echo 'selected'; } echo '> 21 </option>';
    echo '<option value="22" '; if ($answerfieldValue == 22){ echo 'selected'; } echo '> 22 </option>';
    echo '<option value="23" '; if ($answerfieldValue == 23){ echo 'selected'; } echo '> 23 </option>';
    echo '<option value="24" '; if ($answerfieldValue == 24){ echo 'selected'; } echo '> 24 </option>';
    echo '<option value="25" '; if ($answerfieldValue == 25){ echo 'selected'; } echo '> 25 </option>';
    echo '<option value="26" '; if ($answerfieldValue == 26){ echo 'selected'; } echo '> 26 </option>';
    echo '<option value="27" '; if ($answerfieldValue == 27){ echo 'selected'; } echo '> 27 </option>';
    echo '<option value="28" '; if ($answerfieldValue == 28){ echo 'selected'; } echo '> 28 </option>';
    echo '<option value="29" '; if ($answerfieldValue == 29){ echo 'selected'; } echo '> 29 </option>';
    echo '<option value="30" '; if ($answerfieldValue == 30){ echo 'selected'; } echo '> 30 </option>';
    echo '<option value="31" '; if ($answerfieldValue == 31){ echo 'selected'; } echo '> 31 </option>';
    echo '</select>
		</label>';
    break;

  case 'month':
    $responseType = 1;
    //$answerfieldValue  = getScreeningAnswerfield($soapClient,$answerfieldID,$screeningID,$responseType);
    $answerfieldValue = '';
    $answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,$answerfieldID,$screeningID,$responseType);
    // Check if a validation error should be shown.
    if ( isset($_GET['badresponselist'])) {
      $mystring = $_GET['badresponselist'];
      $findme   = $answerfield;
      $pos = strpos($mystring, $findme);
      // if error found, show validation message.
      if ($pos !== false) {
        $alertText = "You must enter a response.";
        $afShortText = "Please Correct";
        if ($answerfieldValidation !== '') {
          $validationCode = 'valid_'.$answerfieldValidation;
          $alertText = getValidationMessage($soapClient,$validationCode);
          $afShortText = getAFValidationShort($soapClient,$answerfield);
        }
        echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>'.$afShortText.': </strong> '.$alertText.'</p></div>';
      }
    }
    //echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
    //echo '<label>prefill:'.$answerfieldValue.'validation:'.$answerfieldValidation.'</label>';
    echo '<div class="input" id="tr_'.$answerfield.'"><label id="label_'.$answerfield.'">
                               	<select id="'.$answerfield.'" name="'.$answerfield.'">
                               	 <option value="">-- Month --</option>';
    echo '<option value="1" '; if ($answerfieldValue == 1){ echo 'selected'; } echo '> January </option>';
    echo '<option value="2" '; if ($answerfieldValue == 2){ echo 'selected'; } echo '> February </option>';
    echo '<option value="3" '; if ($answerfieldValue == 3){ echo 'selected'; } echo '> March </option>';
    echo '<option value="4" '; if ($answerfieldValue == 4){ echo 'selected'; } echo '> April </option>';
    echo '<option value="5" '; if ($answerfieldValue == 5){ echo 'selected'; } echo '> May </option>';
    echo '<option value="6" '; if ($answerfieldValue == 6){ echo 'selected'; } echo '> June </option>';
    echo '<option value="7" '; if ($answerfieldValue == 7){ echo 'selected'; } echo '> July </option>';
    echo '<option value="8" '; if ($answerfieldValue == 8){ echo 'selected'; } echo '> August </option>';
    echo '<option value="9" '; if ($answerfieldValue == 9){ echo 'selected'; } echo '> September </option>';
    echo '<option value="10" '; if ($answerfieldValue == 10){ echo 'selected'; } echo '> October </option>';
    echo '<option value="11" '; if ($answerfieldValue == 11){ echo 'selected'; } echo '> November </option>';
    echo '<option value="12" '; if ($answerfieldValue == 12){ echo 'selected'; } echo '> December </option>';
    echo '</select>
		</label>';
    break;
  case 'year':
    $responseType = 1;
    //$answerfieldValue  = getScreeningAnswerfield($soapClient,$answerfieldID,$screeningID,$responseType);
    $answerfieldValue = '';
    $answerfieldValidation  = getScreeningAnswerfieldValidation($soapClient,$answerfieldID,$screeningID,$responseType);
    // Check if a validation error should be shown.
    if ( isset($_GET['badresponselist'])) {
      $mystring = $_GET['badresponselist'];
      $findme   = $answerfield;
      $pos = strpos($mystring, $findme);
      // if error found, show validation message.
      if ($pos !== false) {
        $alertText = "You must enter a response.";
        $afShortText = "Please Correct";
        if ($answerfieldValidation !== '') {
          $validationCode = 'valid_'.$answerfieldValidation;
          $alertText = getValidationMessage($soapClient,$validationCode);
          $afShortText = getAFValidationShort($soapClient,$answerfield);
        }
        echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>'.$afShortText.': </strong> '.$alertText.'</p></div>';
      }
    }
    echo '<label id="label_'.$answerfield.'">
					<select id="'.$answerfield.'" name="'.$answerfield.'">	          			
                               	 <option value="">-- Year --</option>';
    $displayyear = 1900;
    if ($answerfieldValue == '' ) {
      $answerfieldValue = 1950;
    }
    while ($displayyear <= 2015 ){
      echo '<option value="'.$displayyear.'" '; if ($answerfieldValue == $displayyear){ echo 'selected'; } echo '> '.$displayyear.' </option>';
      $displayyear ++;
    }

    echo '</select>
		</label></div>';
    break;
  default:
    echo '<div class="alert alert-error">Error: No Anwerfield Type!</div>';
}