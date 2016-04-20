<?php
//set screening id to session value passed via url
$screeningID = 1.0;
if (isset($_GET['screeningID'])) {
    $screeningID = $_GET['screeningID'];
}
//echo $screeningID;
$displayID = 0;
$displayID = $questionAnswerfieldObj->display_id;
$answerfieldText = getDisplayTextbyID($displayID);
$answerfieldID = $questionAnswerfieldObj->answerfield_id;
$answerfieldText = findHelpDefinition($answerfieldText);
//$answerfieldValue  = getScreeningAnswerfield(6527,5019848,3);
//$answerfieldValidation  = getScreeningAnswerfieldValidation(6527,5019848,3);
//echo '<label>code:'.$answerfieldCode.'</label>';
switch ($answerfieldCode) {
    case 'currency':
        $responseType = 1;
        $answerfieldValue = getScreeningAnswerfield($answerfieldID, $screeningID, $responseType);
        $answerfieldValidation = getScreeningAnswerfieldValidation($answerfieldID, $screeningID, $responseType);
        // Check if a validation error should be shown.
        if (isset($_GET['badresponselist'])) {
            $mystring = $_GET['badresponselist'];
            $findme = $answerfield;
            $pos = strpos($mystring, $findme);
            // if error found, show validation message.
            if ($pos !== false) {
                $alertText = "You must enter a response.";
                $afShortText = "Please Correct";
                if ($answerfieldValidation !== '') {
                    $validationCode = 'valid_' . $answerfieldValidation;
                    $alertText = getValidationMessage($validationCode);
                    $afShortText = getAFValidationShort($answerfield);
                }
                echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>' . $afShortText . ': </strong> ' . $alertText . '</p></div>';
            }
        }

        // echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
        // echo '<label>prefill:'.$answerfieldValue.'validation:'.$answerfieldValidation.'</label>';
        //set definitions replace text code with link
        echo '
		<div class="clearfix" id="cf_' . $answerfield . '">
        	<div class="row-fluid" id="row_' . $answerfield . '">
            <div class="span6 input">
				<div id="tr_' . $answerfield . '" class="input-prepend input-append">
					<label for="normalText" id="label_' . $answerfield . '">
					<span class="add-on">$</span><input type="text" maxwidth="' . $maxLength . '" id="' . $answerfield . '" name="' . $answerfield . '" value="' . $answerfieldValue . '" maxlength="8" size="20" onblur="chkDollar(this,value);"';
        if ($answerfield == 'receive_snap_amount') {
            echo 'class="fdstmp_receive_class" ';
        }

        if ($answerfield == 'receive_liheap_amount') {
            echo 'class="liheap_receive_class" ';
        }

        if ($answerfield == 'receive_medicaid_amount') {
            echo 'class="med_receive_class" ';
        }

        if ($answerfield == 'receive_property_tax_amount') {
            echo 'class="receive_propertytax_class" ';
        }


        echo '><span class="add-on">.00</span>
					</label>
				</div>
            </div>
            <div class="span6">
                 <label id="label_' . $answerfield . '_2" for="normalText">' . $answerfieldText . '</label>
            </div>
         </div>
		</div>
		';
        break;

    case 'checkbox':
        //set definitions replace text code with link
        $responseType = 3;
        $answerfieldValue = getScreeningAnswerfield($answerfieldID, $screeningID, $responseType);
        //$answerfieldValue = 'y';
        $answerfieldValidation = getScreeningAnswerfieldValidation($answerfieldID, $screeningID, $responseType);
        // Check if a validation error should be shown.
        if (isset($_GET['badresponselist'])) {
            $mystring = $_GET['badresponselist'];
            $findme = $answerfield;
            $pos = strpos($mystring, $findme);
            // if error found, show validation message.
            if ($pos !== false) {
                $alertText = "You must enter a response.";
                $afShortText = "Please Correct";
                if ($answerfieldValidation !== '') {
                    $validationCode = 'valid_' . $answerfieldValidation;
                    $alertText = getValidationMessage($validationCode);
                    $afShortText = getAFValidationShort($answerfield);
                }
                if ($answerfieldValidation !== '') {
                    echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i></i> <strong>' . $afShortText . ': </strong> ' . $alertText . '</p></div>';
                }
            }
        }

        // echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
        // echo '<label>prefill:'.$answerfieldValue.' validation:'.$answerfieldValidation.'</label>';
        $checked = '';
        if ($answerfieldValue == 'checked') {
            $checked = 'checked';
        }
        $checkboxV = 'y'; //Lynna Cekova: use this for value below when report is fixed
        echo '
		  <div id="tr_' . $answerfield . '" class="checkbox">
                <label class="checkbox" id="label_' . $answerfield . '"><input type="checkbox" ' . $checked . ' name="' . $answerfield . '" id="' . $answerfield . '" value="' . $checkboxV . '"';
//QUESTIONS 11 and 12

        if ($answerfield == 'fdstmp_receive' || $answerfield == 'liheap_receive' || $answerfield == 'med_receive' || $answerfield == 'receive_propertytax') { //the first two don't get the class because they use an alt js function for showing/hiding QUESTION 12

            echo ' class="benefitsCheckbox"';//.$answerfield.;

        }

        echo '>' . $answerfieldText . '</label>
          	 </div>
		';
        break;

    case 'yn':
        $responseType = 2;
        $answerfieldValue = getScreeningAnswerfield($answerfieldID, $screeningID, $responseType);
        $answerfieldValidation = getScreeningAnswerfieldValidation($answerfieldID, $screeningID, $responseType);
        //echo 'value:'.$answerfieldValue;
        // Check if a validation error should be shown.
        if (isset($_GET['badresponselist'])) {
            $mystring = $_GET['badresponselist'];
            $findme = $answerfield;
            $pos = strpos($mystring, $findme);
            // if error found, show validation message.
            if ($pos !== false) {
                $alertText = "You must enter a response.";
                $afShortText = "Please Correct";
                if ($answerfieldValidation !== '') {
                    $validationCode = 'valid_' . $answerfieldValidation;
                    $alertText = getValidationMessage($validationCode);
                    $afShortText = getAFValidationShort($answerfield);
                }
                echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>' . $afShortText . ': </strong> ' . $alertText . '</p></div>';
            }
        }

        // echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
        // echo '<label>prefill:'.$answerfieldValue.' validation:'.$answerfieldValidation.'</label>';
        $yes = '';
        $no = '';
        if ($answerfieldValue == 'y') {
            $yes = 'checked';
        }
        if ($answerfieldValue == 'n') {
            $no = 'checked';
        }
        if ($answerfieldText !== '') {
            //show break before text label
            echo '<p></p>';
        }
        echo '
		<div class="radio">
           <div data-toggle="buttons-radio" id="tr_' . $answerfield . '" class="btn-group"><label id="label_' . $answerfield . '">' . $answerfieldText . '</label>
               <label class="radio inline" id="label_radio_yes_' . $answerfield . '">
			   		<input id="radio_yes_' . $answerfield . '" ' . $yes . ' type="radio" name="' . $answerfield . '" value="y">Yes</label>
               <label class="radio inline" id="label_radio_no_' . $answerfield . '">
			   		<input id="radio_no_' . $answerfield . '" ' . $no . ' type="radio" name="' . $answerfield . '" value="n">No</label>
           </div>
        </div>		
		';
        break;

    case 'ny':
        $responseType = 2;
        $answerfieldValue = getScreeningAnswerfield($answerfieldID, $screeningID, $responseType);
        //echo 'value:'.$answerfieldValue;
        $answerfieldValidation = getScreeningAnswerfieldValidation($answerfieldID, $screeningID, $responseType);
        // Check if a validation error should be shown.
        if (isset($_GET['badresponselist'])) {
            $mystring = $_GET['badresponselist'];
            $findme = $answerfield;
            $pos = strpos($mystring, $findme);
            // if error found, show validation message.
            if ($pos !== false) {
                $alertText = "You must enter a response.";
                $afShortText = "Please Correct";
                if ($answerfieldValidation !== '') {
                    $validationCode = 'valid_' . $answerfieldValidation;
                    $alertText = getValidationMessage($validationCode);
                    $afShortText = getAFValidationShort($answerfield);
                }
                echo '<div class="alert alert-danger" ><i class="icon-warning-sign"></i><p><strong>' . $afShortText . ': </strong> ' . $alertText . '</p></div>';
            }
        }
        // echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
        // echo '<label>prefill:'.$answerfieldValue.' validation:'.$answerfieldValidation.'</label>';
        $yes = '';
        $no = '';
        if ($answerfieldValue == 'y') {
            $yes = 'checked';
        }
        if ($answerfieldValue == 'n') {
            $no = 'checked';
        }
        echo '
		<div class="radio">
           <div data-toggle="buttons-radio" id="tr_' . $answerfield . '" class="btn-group"><label id="label_' . $answerfield . '">' . $answerfieldText . '</label>
               <label class="radio inline" id="label_radio_no_' . $answerfield . '">
			   		<input id="radio_no_' . $answerfield . '" ' . $no . ' type="radio" name="' . $answerfield . '" value="n">No</label>
               <label class="radio inline" id="label_radio_yes_' . $answerfield . '">
			   		<input id="radio_yes_' . $answerfield . '" ' . $yes . ' type="radio" name="' . $answerfield . '" value="y">Yes</label>
           </div>
         </div>		
		';
        break;

    case 'select':
        $responseType = 2;
        $answerfieldValue = getScreeningAnswerfield($answerfieldID, $screeningID, $responseType);
        $answerfieldValidation = getScreeningAnswerfieldValidation($answerfieldID, $screeningID, $responseType);
        // Check if a validation error should be shown.
        if (isset($_GET['badresponselist'])) {
            $mystring = $_GET['badresponselist'];
            $findme = $answerfield;
            $pos = strpos($mystring, $findme);
            // if error found, show validation message.
            if ($pos !== false) {
                $alertText = "You must enter a response.";
                $afShortText = "Please Correct";
                if ($answerfieldValidation !== '') {
                    $validationCode = 'valid_' . $answerfieldValidation;
                    $alertText = getValidationMessage($validationCode);
                    $afShortText = getAFValidationShort($findme);
                }
                echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>' . $afShortText . ': </strong> ' . $alertText . '</p></div>';
            }
        }
        //echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
        //echo '<label>prefill:'.$answerfieldValue.'validation:'.$answerfieldValidation.'</label>';
        if ($answerfieldText !== 'Client') {
            echo '<label id="label_' . $answerfield . '" >' . $answerfieldText . '</label>';
        }
        echo '
			<div class="input" id="tr_' . $answerfield . '">
				<select id="select_' . $answerfield . '" name="' . $answerfield . '" class="medium"
						>
					   	<option value="">-- Select --</option>';
        require('answerfieldoption.php');
        echo '</select>
		</div>
		';

        break;

    case 'text':
        $responseType = 1;
        $answerfieldValue = getScreeningAnswerfield($answerfieldID, $screeningID, $responseType);
        $answerfieldValidation = getScreeningAnswerfieldValidation($answerfieldID, $screeningID, $responseType);
        // Check if a validation error should be shown.
        if (isset($_GET['badresponselist'])) {
            $mystring = $_GET['badresponselist'];
            $findme = $answerfield;
            $pos = strpos($mystring, $findme);
            // if error found, show validation message.
            if ($pos !== false) {
                $alertText = "You must enter a response.";
                $afShortText = "Please Correct";
                if ($answerfieldValidation !== '') {
                    $validationCode = 'valid_' . $answerfieldValidation;
                    $alertText = getValidationMessage($validationCode);
                    $afShortText = getAFValidationShort($answerfield);
                }
                echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>' . $afShortText . ': </strong> ' . $alertText . '</p></div>';
            }
        }
        echo '<label>
        <div class="input" id="tr_' . $answerfield . '"';
        if ($answerfield == 'esi_other_specify') {
            echo 'style="display: none;"';
            $answerfieldValue = "Other";
        }
        echo '>	<input type="text" maxwidth="' . $maxLength . '" id="' . $answerfield . '"  class="required" name="' . $answerfield . '" value="' . $answerfieldValue . '" class="required" >&nbsp;' . $answerfieldText . '
		</label></div>';

        break;

    case 'zipcode':
        $responseType = 1;
        $answerfieldValue = getScreeningAnswerfield($answerfieldID, $screeningID, $responseType);
        $answerfieldValidation = getScreeningAnswerfieldValidation($answerfieldID, $screeningID, $responseType);
        // Check if a validation error should be shown.
        if (isset($_GET['badresponselist'])) {
            $mystring = $_GET['badresponselist'];
            $findme = $answerfield;
            $pos = strpos($mystring, $findme);
            // if error found, show validation message.
            if ($pos !== false) {
                $alertText = "You must enter a response.";
                $afShortText = "Please Correct";
                $afShortText = 'Zip Code';
                if ($answerfieldValidation !== '') {
                    $validationCode = 'valid_' . $answerfieldValidation;
                    $alertText = getValidationMessage($validationCode);
                    $afShortText = getAFValidationShort($answerfield);
                }
                echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>' . $afShortText . ':</strong> ' . $alertText . '</p></div>';
            }
        }

        echo '
        <div class="input" id="tr_' . $answerfield . '">
		<input type="text" maxwidth="5" id="' . $answerfield . '" size="6" autocomplete="off" minlength="5"  maxlength="5" name="' . $answerfield . '" value="' . $answerfieldValue . '" class="required">
		<input type="text" name="zyxzip_zip_abbrev" id="zyxzip_zip_abbrev" size="1" value="" disabled="" style="font-size: 7pt; font-weight: bold; color: rgb(102, 102, 102); background-color: rgb(221, 221, 221); border: 1px dotted black; background-position: initial initial; background-repeat: initial initial;">
		</div>
		';
        break;
    case 'month':
        $responseType = 1;
        $answerfieldValue = getScreeningAnswerfield($answerfieldID, $screeningID, $responseType);
        $answerfieldValidation = getScreeningAnswerfieldValidation($answerfieldID, $screeningID, $responseType);
        // Check if a validation error should be shown.
        if (isset($_GET['badresponselist'])) {
            $mystring = $_GET['badresponselist'];
            $findme = $answerfield;
            $pos = strpos($mystring, $findme);
            // if error found, show validation message.
            if ($pos !== false) {
                $alertText = "You must enter a response.";
                $afShortText = "Please Correct";
                if ($answerfieldValidation !== '') {
                    $validationCode = 'valid_' . $answerfieldValidation;
                    $alertText = getValidationMessage($validationCode);
                    $afShortText = getAFValidationShort($answerfield);
                }
                echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>' . $afShortText . ': </strong> ' . $alertText . '</p></div>';
            }
        }
        //echo '<label>'.$answerfieldID.','.$screeningID.','.$responseType.'</label>';
        //echo '<label>prefill:'.$answerfieldValue.'validation:'.$answerfieldValidation.'</label>';
        echo '<div class="input" id="tr_' . $answerfield . '"><label id="label_' . $answerfield . '">
                               	<select id="' . $answerfield . '" name="' . $answerfield . '">
                               	 <option value="">-- month --</option>';
        echo '<option value="1" ';
        if ($answerfieldValue == 1) {
            echo 'selected';
        }
        echo '> Jan </option>';
        echo '<option value="2" ';
        if ($answerfieldValue == 2) {
            echo 'selected';
        }
        echo '> Feb </option>';
        echo '<option value="3" ';
        if ($answerfieldValue == 3) {
            echo 'selected';
        }
        echo '> Mar </option>';
        echo '<option value="4" ';
        if ($answerfieldValue == 4) {
            echo 'selected';
        }
        echo '> Apr </option>';
        echo '<option value="5" ';
        if ($answerfieldValue == 5) {
            echo 'selected';
        }
        echo '> May </option>';
        echo '<option value="6" ';
        if ($answerfieldValue == 6) {
            echo 'selected';
        }
        echo '> Jun </option>';
        echo '<option value="7" ';
        if ($answerfieldValue == 7) {
            echo 'selected';
        }
        echo '> Jul </option>';
        echo '<option value="8" ';
        if ($answerfieldValue == 8) {
            echo 'selected';
        }
        echo '> Aug </option>';
        echo '<option value="9" ';
        if ($answerfieldValue == 9) {
            echo 'selected';
        }
        echo '> Sep </option>';
        echo '<option value="10" ';
        if ($answerfieldValue == 10) {
            echo 'selected';
        }
        echo '> Oct </option>';
        echo '<option value="11" ';
        if ($answerfieldValue == 11) {
            echo 'selected';
        }
        echo '> Nov </option>';
        echo '<option value="12" ';
        if ($answerfieldValue == 12) {
            echo 'selected';
        }
        echo '> Dec </option>';
        echo '</select>
		</label>';
        break;
    case 'year':
        $responseType = 1;
        $answerfieldValue = getScreeningAnswerfield($answerfieldID, $screeningID, $responseType);
        $answerfieldValidation = getScreeningAnswerfieldValidation($answerfieldID, $screeningID, $responseType);
        // Check if a validation error should be shown.
        if (isset($_GET['badresponselist'])) {
            $mystring = $_GET['badresponselist'];
            $findme = $answerfield;
            $pos = strpos($mystring, $findme);
            // if error found, show validation message.
            if ($pos !== false) {
                $alertText = "You must enter a response.";
                $afShortText = "Please Correct";
                if ($answerfieldValidation !== '') {
                    $validationCode = 'valid_' . $answerfieldValidation;
                    $alertText = getValidationMessage($validationCode);
                    $afShortText = getAFValidationShort($answerfield);
                }
                echo '<div class="alert alert-danger" ><p><i class="icon-warning-sign"></i> <strong>' . $afShortText . ': </strong> ' . $alertText . '</p></div>';
            }
        }
        echo '<label id="label_' . $answerfield . '">
					<select id="' . $answerfield . '" name="' . $answerfield . '">
                               	 <option value="">-- year --</option>';
        echo '<option value="1900" ';
        if ($answerfieldValue == 1900) {
            echo 'selected';
        }
        echo '> 1900 </option>';
        echo '<option value="1901" ';
        if ($answerfieldValue == 1901) {
            echo 'selected';
        }
        echo '> 1901 </option>';
        echo '<option value="1902" ';
        if ($answerfieldValue == 1902) {
            echo 'selected';
        }
        echo '> 1902 </option>';
        echo '<option value="1903" ';
        if ($answerfieldValue == 1903) {
            echo 'selected';
        }
        echo '> 1903 </option>';
        echo '<option value="1904" ';
        if ($answerfieldValue == 1904) {
            echo 'selected';
        }
        echo '> 1904 </option>';
        echo '<option value="1905" ';
        if ($answerfieldValue == 1905) {
            echo 'selected';
        }
        echo '> 1905 </option>';
        echo '<option value="1906" ';
        if ($answerfieldValue == 1906) {
            echo 'selected';
        }
        echo '> 1906 </option>';
        echo '<option value="1907" ';
        if ($answerfieldValue == 1907) {
            echo 'selected';
        }
        echo '> 1907 </option>';
        echo '<option value="1908" ';
        if ($answerfieldValue == 1908) {
            echo 'selected';
        }
        echo '> 1908 </option>';
        echo '<option value="1909" ';
        if ($answerfieldValue == 1909) {
            echo 'selected';
        }
        echo '> 1909 </option>';
        echo '<option value="1910" ';
        if ($answerfieldValue == 1910) {
            echo 'selected';
        }
        echo '> 1910 </option>';
        echo '<option value="1911" ';
        if ($answerfieldValue == 1911) {
            echo 'selected';
        }
        echo '> 1911 </option>';
        echo '<option value="1912" ';
        if ($answerfieldValue == 1912) {
            echo 'selected';
        }
        echo '> 1912 </option>';
        echo '<option value="1913" ';
        if ($answerfieldValue == 1913) {
            echo 'selected';
        }
        echo '> 1913 </option>';
        echo '<option value="1914" ';
        if ($answerfieldValue == 1914) {
            echo 'selected';
        }
        echo '> 1914 </option>';
        echo '<option value="1915" ';
        if ($answerfieldValue == 1915) {
            echo 'selected';
        }
        echo '> 1915 </option>';
        echo '<option value="1916" ';
        if ($answerfieldValue == 1916) {
            echo 'selected';
        }
        echo '> 1916 </option>';
        echo '<option value="1917" ';
        if ($answerfieldValue == 1917) {
            echo 'selected';
        }
        echo '> 1917 </option>';
        echo '<option value="1918" ';
        if ($answerfieldValue == 1918) {
            echo 'selected';
        }
        echo '> 1918 </option>';
        echo '<option value="1919" ';
        if ($answerfieldValue == 1919) {
            echo 'selected';
        }
        echo '> 1919 </option>';
        echo '<option value="1920" ';
        if ($answerfieldValue == 1920) {
            echo 'selected';
        }
        echo '> 1920 </option>';
        echo '<option value="1921" ';
        if ($answerfieldValue == 1921) {
            echo 'selected';
        }
        echo '> 1921 </option>';
        echo '<option value="1922" ';
        if ($answerfieldValue == 1922) {
            echo 'selected';
        }
        echo '> 1922 </option>';
        echo '<option value="1923" ';
        if ($answerfieldValue == 1923) {
            echo 'selected';
        }
        echo '> 1923 </option>';
        echo '<option value="1924" ';
        if ($answerfieldValue == 1924) {
            echo 'selected';
        }
        echo '> 1924 </option>';
        echo '<option value="1925" ';
        if ($answerfieldValue == 1925) {
            echo 'selected';
        }
        echo '> 1925 </option>';
        echo '<option value="1926" ';
        if ($answerfieldValue == 1926) {
            echo 'selected';
        }
        echo '> 1926 </option>';
        echo '<option value="1927" ';
        if ($answerfieldValue == 1927) {
            echo 'selected';
        }
        echo '> 1927 </option>';
        echo '<option value="1928" ';
        if ($answerfieldValue == 1928) {
            echo 'selected';
        }
        echo '> 1928 </option>';
        echo '<option value="1929" ';
        if ($answerfieldValue == 1929) {
            echo 'selected';
        }
        echo '> 1929 </option>';
        echo '<option value="1930" ';
        if ($answerfieldValue == 1930) {
            echo 'selected';
        }
        echo '> 1930 </option>';
        echo '<option value="1931" ';
        if ($answerfieldValue == 1931) {
            echo 'selected';
        }
        echo '> 1931 </option>';
        echo '<option value="1932" ';
        if ($answerfieldValue == 1932) {
            echo 'selected';
        }
        echo '> 1932 </option>';
        echo '<option value="1933" ';
        if ($answerfieldValue == 1933) {
            echo 'selected';
        }
        echo '> 1933 </option>';
        echo '<option value="1934" ';
        if ($answerfieldValue == 1934) {
            echo 'selected';
        }
        echo '> 1934 </option>';
        echo '<option value="1935" ';
        if ($answerfieldValue == 1935) {
            echo 'selected';
        }
        echo '> 1935 </option>';
        echo '<option value="1936" ';
        if ($answerfieldValue == 1936) {
            echo 'selected';
        }
        echo '> 1936 </option>';
        echo '<option value="1937" ';
        if ($answerfieldValue == 1937) {
            echo 'selected';
        }
        echo '> 1937 </option>';
        echo '<option value="1938" ';
        if ($answerfieldValue == 1938) {
            echo 'selected';
        }
        echo '> 1938 </option>';
        echo '<option value="1939" ';
        if ($answerfieldValue == 1939) {
            echo 'selected';
        }
        echo '> 1939 </option>';
        echo '<option value="1940" ';
        if ($answerfieldValue == 1940) {
            echo 'selected';
        }
        echo '> 1940 </option>';
        echo '<option value="1941" ';
        if ($answerfieldValue == 1941) {
            echo 'selected';
        }
        echo '> 1941 </option>';
        echo '<option value="1942" ';
        if ($answerfieldValue == 1942) {
            echo 'selected';
        }
        echo '> 1942 </option>';
        echo '<option value="1943" ';
        if ($answerfieldValue == 1943) {
            echo 'selected';
        }
        echo '> 1943 </option>';
        echo '<option value="1944" ';
        if ($answerfieldValue == 1944) {
            echo 'selected';
        }
        echo '> 1944 </option>';
        echo '<option value="1945" ';
        if ($answerfieldValue == 1945) {
            echo 'selected';
        }
        echo '> 1945 </option>';
        echo '<option value="1946" ';
        if ($answerfieldValue == 1946) {
            echo 'selected';
        }
        echo '> 1946 </option>';
        echo '<option value="1947" ';
        if ($answerfieldValue == 1947) {
            echo 'selected';
        }
        echo '> 1947 </option>';
        echo '<option value="1948" ';
        if ($answerfieldValue == 1948) {
            echo 'selected';
        }
        echo '> 1948 </option>';
        echo '<option value="1949" ';
        if ($answerfieldValue == 1949) {
            echo 'selected';
        }
        echo '> 1949 </option>';
        echo '<option value="1950" ';
        if ($answerfieldValue == 1950) {
            echo 'selected';
        }
        echo '> 1950 </option>';
        echo '<option value="1951" ';
        if ($answerfieldValue == 1951) {
            echo 'selected';
        }
        echo '> 1951 </option>';
        echo '<option value="1952" ';
        if ($answerfieldValue == 1952) {
            echo 'selected';
        }
        echo '> 1952 </option>';
        echo '<option value="1953" ';
        if ($answerfieldValue == 1953) {
            echo 'selected';
        }
        echo '> 1953 </option>';
        echo '<option value="1954" ';
        if ($answerfieldValue == 1954) {
            echo 'selected';
        }
        echo '> 1954 </option>';
        echo '<option value="1955" ';
        if ($answerfieldValue == 1955) {
            echo 'selected';
        }
        echo '> 1955 </option>';
        echo '<option value="1956" ';
        if ($answerfieldValue == 1956) {
            echo 'selected';
        }
        echo '> 1956 </option>';
        echo '<option value="1957" ';
        if ($answerfieldValue == 1957) {
            echo 'selected';
        }
        echo '> 1957 </option>';
        echo '<option value="1958" ';
        if ($answerfieldValue == 1958) {
            echo 'selected';
        }
        echo '> 1958 </option>';
        echo '<option value="1959" ';
        if ($answerfieldValue == 1959) {
            echo 'selected';
        }
        echo '> 1959 </option>';
        echo '<option value="1960" ';
        if ($answerfieldValue == 1960) {
            echo 'selected';
        }
        echo '> 1960 </option>';
        echo '<option value="1961" ';
        if ($answerfieldValue == 1961) {
            echo 'selected';
        }
        echo '> 1961 </option>';
        echo '<option value="1962" ';
        if ($answerfieldValue == 1962) {
            echo 'selected';
        }
        echo '> 1962 </option>';
        echo '<option value="1963" ';
        if ($answerfieldValue == 1963) {
            echo 'selected';
        }
        echo '> 1963 </option>';
        echo '<option value="1964" ';
        if ($answerfieldValue == 1964) {
            echo 'selected';
        }
        echo '> 1964 </option>';
        echo '<option value="1965" ';
        if ($answerfieldValue == 1965) {
            echo 'selected';
        }
        echo '> 1965 </option>';
        echo '<option value="1966" ';
        if ($answerfieldValue == 1966) {
            echo 'selected';
        }
        echo '> 1966 </option>';
        echo '<option value="1967" ';
        if ($answerfieldValue == 1967) {
            echo 'selected';
        }
        echo '> 1967 </option>';
        echo '<option value="1968" ';
        if ($answerfieldValue == 1968) {
            echo 'selected';
        }
        echo '> 1968 </option>';
        echo '<option value="1969" ';
        if ($answerfieldValue == 1969) {
            echo 'selected';
        }
        echo '> 1969 </option>';
        echo '<option value="1970" ';
        if ($answerfieldValue == 1970) {
            echo 'selected';
        }
        echo '> 1970 </option>';
        echo '<option value="1971" ';
        if ($answerfieldValue == 1971) {
            echo 'selected';
        }
        echo '> 1971 </option>';
        echo '<option value="1972" ';
        if ($answerfieldValue == 1972) {
            echo 'selected';
        }
        echo '> 1972 </option>';
        echo '<option value="1973" ';
        if ($answerfieldValue == 1973) {
            echo 'selected';
        }
        echo '> 1973 </option>';
        echo '<option value="1974" ';
        if ($answerfieldValue == 1974) {
            echo 'selected';
        }
        echo '> 1974 </option>';
        echo '<option value="1975" ';
        if ($answerfieldValue == 1975) {
            echo 'selected';
        }
        echo '> 1975 </option>';
        echo '<option value="1976" ';
        if ($answerfieldValue == 1976) {
            echo 'selected';
        }
        echo '> 1976 </option>';
        echo '<option value="1977" ';
        if ($answerfieldValue == 1977) {
            echo 'selected';
        }
        echo '> 1977 </option>';
        echo '<option value="1978" ';
        if ($answerfieldValue == 1978) {
            echo 'selected';
        }
        echo '> 1978 </option>';
        echo '<option value="1979" ';
        if ($answerfieldValue == 1979) {
            echo 'selected';
        }
        echo '> 1979 </option>';
        echo '<option value="1980" ';
        if ($answerfieldValue == 1980) {
            echo 'selected';
        }
        echo '> 1980 </option>';
        echo '<option value="1981" ';
        if ($answerfieldValue == 1981) {
            echo 'selected';
        }
        echo '> 1981 </option>';
        echo '<option value="1982" ';
        if ($answerfieldValue == 1982) {
            echo 'selected';
        }
        echo '> 1982 </option>';
        echo '<option value="1983" ';
        if ($answerfieldValue == 1983) {
            echo 'selected';
        }
        echo '> 1983 </option>';
        echo '<option value="1984" ';
        if ($answerfieldValue == 1984) {
            echo 'selected';
        }
        echo '> 1984 </option>';
        echo '<option value="1985" ';
        if ($answerfieldValue == 1985) {
            echo 'selected';
        }
        echo '> 1985 </option>';
        echo '<option value="1986" ';
        if ($answerfieldValue == 1986) {
            echo 'selected';
        }
        echo '> 1986 </option>';
        echo '<option value="1987" ';
        if ($answerfieldValue == 1987) {
            echo 'selected';
        }
        echo '> 1987 </option>';
        echo '<option value="1988" ';
        if ($answerfieldValue == 1988) {
            echo 'selected';
        }
        echo '> 1988 </option>';
        echo '<option value="1989" ';
        if ($answerfieldValue == 1989) {
            echo 'selected';
        }
        echo '> 1989 </option>';
        echo '<option value="1990" ';
        if ($answerfieldValue == 1990) {
            echo 'selected';
        }
        echo '> 1990 </option>';
        echo '<option value="1991" ';
        if ($answerfieldValue == 1991) {
            echo 'selected';
        }
        echo '> 1991 </option>';
        echo '<option value="1992" ';
        if ($answerfieldValue == 1992) {
            echo 'selected';
        }
        echo '> 1992 </option>';
        echo '<option value="1993" ';
        if ($answerfieldValue == 1993) {
            echo 'selected';
        }
        echo '> 1993 </option>';
        echo '<option value="1994" ';
        if ($answerfieldValue == 1994) {
            echo 'selected';
        }
        echo '> 1994 </option>';
        echo '<option value="1995" ';
        if ($answerfieldValue == 1995) {
            echo 'selected';
        }
        echo '> 1995 </option>';
        echo '<option value="1996" ';
        if ($answerfieldValue == 1996) {
            echo 'selected';
        }
        echo '> 1996 </option>';
        echo '<option value="1997" ';
        if ($answerfieldValue == 1997) {
            echo 'selected';
        }
        echo '> 1997 </option>';
        echo '<option value="1998" ';
        if ($answerfieldValue == 1998) {
            echo 'selected';
        }
        echo '> 1998 </option>';
        echo '<option value="1999" ';
        if ($answerfieldValue == 1999) {
            echo 'selected';
        }
        echo '> 1999 </option>';
        echo '<option value="2000" ';
        if ($answerfieldValue == 2000) {
            echo 'selected';
        }
        echo '> 2000 </option>';
        echo '<option value="2001" ';
        if ($answerfieldValue == 2001) {
            echo 'selected';
        }
        echo '> 2001 </option>';
        echo '<option value="2002" ';
        if ($answerfieldValue == 2002) {
            echo 'selected';
        }
        echo '> 2002 </option>';
        echo '<option value="2003" ';
        if ($answerfieldValue == 2003) {
            echo 'selected';
        }
        echo '> 2003 </option>';
        echo '<option value="2004" ';
        if ($answerfieldValue == 2004) {
            echo 'selected';
        }
        echo '> 2004 </option>';
        echo '<option value="2005" ';
        if ($answerfieldValue == 2005) {
            echo 'selected';
        }
        echo '> 2005 </option>';
        echo '<option value="2006" ';
        if ($answerfieldValue == 2006) {
            echo 'selected';
        }
        echo '> 2006 </option>';
        echo '<option value="2007" ';
        if ($answerfieldValue == 2007) {
            echo 'selected';
        }
        echo '> 2007 </option>';
        echo '<option value="2008" ';
        if ($answerfieldValue == 2008) {
            echo 'selected';
        }
        echo '> 2008 </option>';
        echo '<option value="2009" ';
        if ($answerfieldValue == 2009) {
            echo 'selected';
        }
        echo '> 2009 </option>';
        echo '<option value="2010" ';
        if ($answerfieldValue == 2010) {
            echo 'selected';
        }
        echo '> 2010 </option>';
        echo '<option value="2011" ';
        if ($answerfieldValue == 2011) {
            echo 'selected';
        }
        echo '> 2011 </option>';
        echo '<option value="2012" ';
        if ($answerfieldValue == 2012) {
            echo 'selected';
        }
        echo '> 2012 </option>';
        echo '<option value="2013" ';
        if ($answerfieldValue == 2013) {
            echo 'selected';
        }
        echo '> 2013 </option>';
        echo '</select>
		</label></div>';
        break;
    default:
        echo '<div class="alert alert-error">Error: No Anwerfield Type!</div>';
}
?>
