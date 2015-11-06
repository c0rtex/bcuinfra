<?php 
$url_cid = '';
$_SESSION['click_id'] = 0;
//log affinity data and add to api data transfer
require_once('util/affinity_track_contact.php');

//end affinity tracking

//author Lynna Cekova
$mqc_date_birth = '';
$mqc_zip = '';
// GET DOB and ZIP FROM Screening answer table
function searchForId($id, $array){
	foreach ($array as $key => $val){
		if ($val["answerfield"] === $id){
			return $key;
		}
	}
	return null;
}
$bcudb = new wpdb(DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU,DB_HOST_BCU);

if(isset($_GET['shadowID']) and ($_GET['shadowID'] != '')){
$screeningID = $_GET['shadowID'];
//echo "s:".$screeningID;
$query_getSAF = "SELECT a.answerfield, o.option_id, o.option_code, sa.response 
FROM answerfield a INNER JOIN screening_answerfield sa ON sa.answerfield_id = a.answerfield_id 
LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id 
WHERE sa.screening_id= ".$screeningID." 
ORDER BY sa.pagenum, a.answerfield, sa.submit_datetime";

$result = mysql_query($query_getSAF);
while($AFrow = mysql_fetch_assoc($result)){
	/* Inside while loop */
    $AF_array[] = $AFrow;
}
$AFrow_index = searchForId('mqc_zipcode', $AF_array);
	if (isset($AF_array[$AFrow_index]["response"])){
		$mqc_zipcode = $AF_array[$AFrow_index]["response"];
	}
//echo "zip:".$mqc_zipcode;
$AFrow_index = searchForId('mqc_birth_day', $AF_array);
$birthday = $AF_array[$AFrow_index]["response"];
$AFrow_index = searchForId('mqc_birth_month', $AF_array);
$birthmonth = $AF_array[$AFrow_index]["response"];
$AFrow_index = searchForId('mqc_birth_year', $AF_array);
$birthyear = $AF_array[$AFrow_index]["response"];
$birthday_padded = sprintf("%02s", $birthday);
$birthmonth_padded = sprintf("%02s", $birthmonth);
$mqc_date_birth = $birthmonth_padded.'/'.$birthday_padded .'/'.$birthyear;
//echo $mqc_date_birth;
}
//END GET DOB and ZIP


require_once "util/encryptDecrypt.php";
require_once "util/curlContactForm.php";
require_once "util/xmlParse.php";
require_once "util/encryptionInfo.php";
$encPass = '34SC+7|e8_RIy;,nt[C54n#7+ejGI~';
$encKey = 'y35#5188*U=?_c$ysvy|O1I@2=9JRB';
$zip = $mqc_zipcode;
$fName        = $_POST['first_name'];
$lName        = $_POST['last_name'];    
$mName        = $_POST['middle_name'];
$phone        = $_POST['phone_number'];  
$confirmphone        = $_POST['confirm_phone'];    
$email          = $_POST['email'];
$confirmemail          = $_POST['confirmemail'];
$dob          = $_POST['dob'];
$address          = $_POST['address_1'];
$city          = $_POST['city'];
$state          = $_POST['state_province'];
$zip          = $_POST['zip_code'];
$screeningId  = $_POST['screeniningId'];
$submitted = $_POST['submitted'];
$consent = $_POST['consent'];
//user session zip value for default
if ($zip == ''){
$zip = $mqc_zipcode;
}
//echo $address;
//echo $city;
//echo $state;
//echo $zip.$SESSION_['zipcode'];


if ($submitted != 'true'){
}

else { //the form has been submitted

$screeningContactId = false; // it will store the screening_contact_id from the db once the information is inserted
$aonStatus = false;
$aonId = false;


//echo "<br/>";
//echo "<br/>";
//echo "original sccid ";
//echo $screeningContactId;




$dobV = validateBirthDate ($dob);
$phoneV = validateUSPhone ($phone);
$confirmphoneV = confirmPhone($phone,$confirmphone);
$emailV = validateEmail ($email, $confirmemail);
$zipStateV = validateZip ($zip);

if ($zipStateV != false){ //returns an array
$zipV = $zipStateV['zip'];
$stateV = $zipStateV['state'];

}

else {
$zipV = false;
$stateV = false;

}


//echo "<br/>";
//echo "<br/>";
//echo $emailV;
if ($dobV != false && $phoneV != false && $emailV != false && $emailV != "emailMismatch" && $zipV != false && $stateV != false && $_POST["first_name"] != "" && $_POST["last_name"] != "" && $confirmphoneV != false){ 

$saveResult = saveContactInfo ($fName, $lName, $emailV, $phoneV, $mName, $dobV, $zipV, $address, $city, $stateV);

//echo "<br/>";
//echo "<br/>";
//echo "saveResult is $saveResult";

if ($saveResult['status'] == 'true'){ //do the curl request
$screeningContactId = $saveResult['id'];

//echo "<br/>";
//echo "<br/>";
//echo "if save result true ";
//echo $screeningContactId;

//From Jason's email: Password: 95wndflkfhJajaia$Z8
//Username: ncoa_prod
//url https://ahnleads-prod.aon.com/create

// qa $curlUrl = 'https://ahnleads-qc.aon.com/create';

//live settings
//oasis
//mha
$curlUrl = 'https://ahnleads-prod.aon.com/create';
$api_val = 'ncoa-api';
if(isset($_POST['api_val']) and ($_POST['api_val'] != '')){
$api_val = $_POST['api_val'];
}
$postfields = array('profile_id'=>$api_val,'shared_lead'=>'2', 'username'=>'ncoa_prod', 'password'=>'95wndflkfhJajaia$Z8', 'first_name'=>$fName, 'last_name'=>$lName, 'birthdate'=>$dobV, 'address_1'=>$address, 'city'=>$city, 'state_province'=>$stateV, 'zip_postal_code'=>$zipV, 'phone_number'=>$phoneV, 'electronic_address'=>$emailV);
//$poststfields = array('profile_id'=>'ncoa-api','shared_lead'=>'2', 'username'=>'ncoa1', 'password'=>'ncoapswd');
//echo "<br/>";
//echo "<br/>";
//echo (http_build_query($postfields));

//$curlResponse = "test";
$curlResponse = getCurlResponse ($postfields, $curlUrl);

if ($curlResponse != false){


//echo "<br/>";
//echo "<br/>";
//echo "CURL response";
//echo $curlResponse;

$parsed = parseIt ($curlResponse);


if ($parsed['status'] == "success"){
$aonStatus = "success";
$aonId = $parsed['id'];
//echo "<br/>";
//echo "<br/>";
//echo "Success response id: ";
//echo $parsed['id'];
//echo "<br/>";
//echo $curlResponse;
//echo htmlentities($curlResponse);
echo "Successful response";
storeAonInfo($aonStatus, $aonId, $screeningContactId);
$link = "https://medicarequickcheck.benefitscheckup.org/screening-contact-success/?CID=".$url_cid;
header ("Location: https://medicarequickcheck.benefitscheckup.org/screening-contact-success/?CID=".$url_cid);
echo '<META 
     HTTP-EQUIV="Refresh"
     CONTENT="0; URL='.$link.'">';
}

else if ($parsed['status'] == "error"){
$aonStatus = "failure";
//echo "<br/>";
//echo "<br/>";
//echo "Error response: ";
//echo "<br/>";
//echo $curlResponse;
echo (http_build_query($postfields));
echo htmlentities($curlResponse);
echo "Fail response 1";
storeAonInfo($aonStatus, $aonId, $screeningContactId);
$link = "https://medicarequickcheck.benefitscheckup.org/screening-contact-error/?CID=".$url_cid;
//header ("Location: https://medicarequickcheck.benefitscheckup.org/screening-contact-error/?CID=".$url_cid);
//echo '<META 
//     HTTP-EQUIV="Refresh"
//     CONTENT="0; URL='.$link.'">';
//echo "Location: https://medicarequickcheck.benefitscheckup.org/screening-contact-error/?CID=".$url_cid;
}

else {
$aonStatus = "failure";
//echo "<br/>";
//echo "<br/>";
echo "Some other error with parsing";
//echo "<br/>";
//echo "Start CURL response";
//echo "<br/>";
//echo $curlResponse;
echo htmlentities($curlResponse);
//echo "<br/>";
//echo "End CURL response";
//echo "Fail response";
storeAonInfo($aonStatus, $aonId);
if (isset($_SESSION['click_id']) && ( $_SESSION['click_id'] !== 0)){
require_once('util/affinity_client.php');
	//log to click table...partner_id,partner_session_id,url_id,campaign_id,internal_flag,ahn_contact_flag,screening_id,click_id
$ws_click_id = $affinityClient->logAffinityClick(0,'',0,0,0,1,0,$_SESSION['click_id']);
}
//header ("Location: https://medicarequickcheck.benefitscheckup.org/screening-contact-error/?CID=".$url_cid);

}

}

else {
 echo "CURL response error - unable to receive valid response.";
echo "<br/>";
echo "<br/>";
echo "System Unable to make valid connection to AHN server.";
echo "Response Content:".$curlResponse;

//TODO take care that this is is an error message without parsing (it didn't get to parsing)
//header ("Location: https://medicarequickcheck.benefitscheckup.org/screening-contact-error/");

}





}

else {

echo "There was an error with saving data to the database."; //TODO: better error handling
//header ("Location: https://medicarequickcheck.benefitscheckup.org/screening-contact-error/");
}



}

else { //return to the form with the correct errors.

$formErrors = "<div class='alert alert-danger'><strong>Please correct the following fields.</strong></div>";

if ($dobV == false){
  $dobError = "<div class='alert alert-danger'>Please enter a valid date of birth.</div>";
}

if ($phoneV == false){
  $phoneError = "<div class='alert alert-danger'>Please enter a valid phone number.</div>";
}
if ($confirmphoneV == false){
  $confirmphoneError = "<div class='alert alert-danger'>Phone Number must match the confirm phone field.</div>";
}
if ($emailV == false){

  $emailError = "<div class='alert alert-danger'>Please enter a valid E-mail address (email@example.com). </div>";
}

if ($emailV == "emailMismatch"){
  $emailError = "<div class='alert alert-danger'>Emails don't match.</div>";
}

if ($zipV == false){

  $zipError = "<div class='alert alert-danger'>Please enter a valid zip code.</div>";
}


//echo "date error";

}
}


function confirmPhone($phone,$confirmphone){
if ($phone == $confirmphone){
return $phone;
}
else {
return false;
}

}




function validateEmail ($email, $confirmemail){
if (empty($_POST['email']) && empty($_POST['confirmemail'])){
$email = "dummyemail@dummydomain.dum";
$confirmemail = "dummyemail@dummydomain.dum";
  return $email;
}

//echo "<br/>";
//echo "<br/>";
//echo $email;
//echo "<br/>";
//echo "<br/>";
//echo $confirmemail;

else  if ($email == $confirmemail){
if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
  return $email;
}
else {
  return false;
}
}
else {
 return "emailMismatch";
}
}


function validateUSPhone ($phone){

if (preg_match("/^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$/", $phone) > 0){// / delimiter to note start and end of expression needed

//This RegEx requires a US phone number WITH area code. It is written to all users to enter whatever delimiters they want or no delimiters at all (i.e. 111-222-3333, or 111.222.3333, or (111) 222-3333, or 1112223333, etc...). By Laurence OsDonnell, http://regexlib.com/Search.aspx?k=phone

//if (preg_match("/((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}/", $phone)){
//US Phone Number -- doesn't check to see if first digit is legal (not a 0 or 1). by Stephen Smith

    $numberOfDigitsOnly = ereg_replace("[^0-9]", "", $phone);
    $numberOfDigits = strlen($numberOfDigitsOnly);
//echo "nD $numberOfDigitsOnly";
    if ($numberOfDigits == 10) {
        //echo $numbersOnly;
//echo "<br/>";
        
       $phoneFormatted = "(".substr($numberOfDigitsOnly, 0, 3).")".substr ($numberOfDigitsOnly, 3, 3)."-".substr ($numberOfDigitsOnly, 6, 4);
       //echo "Phone formatted $phoneFormatted";
       return $phoneFormatted;

    } else {
        //echo 'Invalid Phone Number';
        return false;
    }



}
else {
return false;
}


}

function validateBirthDate ($dob){ //mm/dd/yyyy
	
$date_arr  = explode('/', $dob);
//echo $date_arr;
//echo count($date_arr);
if (count($date_arr) == 3) {
if (strlen($date_arr[0])==2 && ctype_digit($date_arr[0]) && strlen($date_arr[1])==2 && ctype_digit($date_arr[1]) && strlen($date_arr[2])==4 && ctype_digit($date_arr[2])   ){
    if (checkdate($date_arr[0], $date_arr[1], $date_arr[2])) {
$dob = date("Y-m-d",strtotime($dob));
if ($dob > date ("Y-m-d") || $dob < date("Y-m-d", mktime(0, 0, 0, 1, 1, 1900))){ //checkdate passes but the date is in the future and is not earlier than 01/01/1900
//echo "future or early date";
  return false;
}

else {
//echo 'date ';
        // valid date ...
//echo $dob;
return $dob;
}
    } 



else {

        // problem with dates ...
//echo 'invalid date';
return false;
    }
}
else {

 return false;
}
} else {
    // problem with input ...
//echo 'invalid input';
return false;
}


}

function checkZipState ($zip){

//echo "gets to checkZipState at all";

$db = mysqli_init();

if (!$db) {
    die("mysqli_init failed");
}

if(!$db->ssl_set('/opt/bcu/etc/ssl/mysql/client-key.pem','/opt/bcu/etc/ssl/mysql/client-cert.pem', '/opt/bcu/etc/ssl/mysql/ca-cert.pem',NULL,NULL)){
        die("Setting up ssl failed");
}

if(!$db->real_connect(DB_HOST_BCU,DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU)){
//if(!$db->real_connect('192.168.10.16','esidtcssl','heDruca6','bcumigration')){
        die("Failed to connect to db 1: " . mysqli_error());
}

$sql="select zipcode, state_id from zip where zipcode='$zip' and valid='1';";
//echo $sql;
//$result = mysqli_query($sql);



  $checkZip    =    $db->prepare($sql);

    $checkZip->execute();
    $checkZip->store_result();

 if ( $checkZip->num_rows() > 0 )
    {
        $checkZip->bind_result($zipCodeDb, $stateDb);
        $checkZip->fetch();
        //{
         //   printf ("Zip: %s, State: %s", $zipCodeDb, $stateDb);
        //}

return array('zip'=>$zipCodeDb,'state'=>$stateDb);

    }
    else
    {
        //printf ("Zero forms found.");
       return false;
    }




}



function saveContactInfo ($fName, $lName, $email, $phone,$mName, $dob, $zip, $address, $city, $state){

/// Connect to server securely.

$db = mysqli_init();

if (!$db) {
    die("mysqli_init failed");
}

if(!$db->ssl_set('/opt/bcu/etc/ssl/mysql/client-key.pem','/opt/bcu/etc/ssl/mysql/client-cert.pem', '/opt/bcu/etc/ssl/mysql/ca-cert.pem',NULL,NULL)){
        die("Setting up ssl failed");
}
if(!$db->real_connect(DB_HOST_BCU,DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU)){
//if(!$db->real_connect('192.168.10.16','esidtcssl','heDruca6','bcumigration')){
        die("Failed to connect to db 2: " . mysqli_error());
}


//$db_server = mysql_connect('172.31.33.35', 'esidtc', 'W6ApuXec')
    //or die("Unable to connect to MySQL: " . mysql_error());

// Select the database.
//mysqli_select_db('esidtc')
    //or die("Unable to select database: " . mysqli_error());

//TODO: get the password and hash from elsewhere

$fName = encrypt ($fName, $encPass, $encKey);
$lName = encrypt ($lName, $encPass, $encKey);
$email = encrypt ($email, $encPass, $encKey);
$phone = encrypt ($phone, $encPass, $encKey);
$mName = encrypt ($mName, $encPass, $encKey);
$dob = encrypt ($dob, $encPass, $encKey);
$zip = encrypt ($zip, $encPass, $encKey);
$address = encrypt ($address, $encPass, $encKey);
$city = encrypt ($city, $encPass, $encKey);
$stateRaw = $state;
$state = encrypt ($state, $encPass, $encKey);

$sqlScreeningTable = "INSERT INTO screening (subset_id, start_datetime, end_datetime, prev_screening_id, source_id, partner_id, preset_state_id) VALUES ('73', NOW(), NOW(), '0', '1', '114', '$stateRaw')";


$insertContactInfo    =    $db->prepare($sqlScreeningTable);

$result = $insertContactInfo->execute();
$screeningTableContactId = $db->insert_id; //get the auto generated id of the row


if($result != 1){

//echo "ERROR";
//return false;
return array('status'=>'false');
}




// Insert data into the screening_contact table
$sql="INSERT INTO screening_contact (screening_id, firstname, lastname, email, phone, datetime, middlename, dob, zip, address_1, city, state)
VALUES ('$screeningTableContactId', '$fName', '$lName', '$email', '$phone', NOW(), '$mName', '$dob', '$zip', '$address', '$city', '$state')";
//echo $sql;
//$result = mysqli_query($sql);


  $insertContactInfo    =    $db->prepare($sql);

    $result = $insertContactInfo->execute();
$screeningContactId = $db->insert_id; //get the auto generated id of the row
//echo "Screening contact id in the func";
//echo $screeningContactId;





//$mysqli->close();



if($result == 1){
//echo "SUCCESS";
//return true;
return array('status'=>'true','id'=>$screeningContactId);
}

else {
//echo "ERROR";
//return false;
return array('status'=>'false');
}



}

function storeAonInfo ($status, $id, $screeningContactId){

//echo "<br/>";
//echo "<br/>";
//echo "Gets to storeAonInfo at all";
//echo "<br/>";
//echo "the id is: ";
//echo $screeningContactId;


$statusE = encrypt ($status, $encPass, $encKey);

if ($status == "success"){
$sql = "UPDATE screening_contact SET aon_status = '$statusE', aon_id = '$id', aon_response_datetime= NOW() WHERE screening_contact_id='$screeningContactId';";
}

else if ($status == "failure"){
$sql = "UPDATE screening_contact SET aon_status = '$statusE', aon_response_datetime= NOW() WHERE screening_contact_id='$screeningContactId';";

//echo "<br/>";
//echo "sql is: ";
//echo $sql;


}


$db = mysqli_init();

if (!$db) {
    die("mysqli_init failed");
}

if(!$db->ssl_set('/opt/bcu/etc/ssl/mysql/client-key.pem','/opt/bcu/etc/ssl/mysql/client-cert.pem', '/opt/bcu/etc/ssl/mysql/ca-cert.pem',NULL,NULL)){
        die("Setting up ssl failed");
}

if(!$db->real_connect(DB_HOST_BCU,DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU)){
//if(!$db->real_connect('192.168.10.16','esidtcssl','heDruca6','bcumigration')){
        die("Failed to connect to db 3: " . mysqli_error());
}

//TODO: get the password and hash from elsewhere

//$fName = encrypt ($fName, $encPass);
//$lName = encrypt ($lName, $encPass);
// Insert data into mysql

  $insertContactInfo    =    $db->prepare($sql);

    $result = $insertContactInfo->execute();

}

function validateZip ($zip){
if(strlen($zip)==5 && ctype_digit($zip)) { //check if 5 digits inputed
// get data from the zip table
//$sql="SELECT * FROM zip WHERE zipcode='$zip' AND valid='1';";
//echo $sql;

  //$selectZip    =    $db->prepare($sql);

    //$result = $selectZip->execute();
//echo "<br/>";
//echo "SQL result is $result";

    $zipStateArray = checkZipState ($zip);
   if (
    $zipStateArray != false){
    //valid
    return $zipStateArray;
}
    else {
   return false;

}
} else {
  return false;
}


}



?>

<div class="whitewell"><?php echo $formErrors; ?>
<form  name="esiForm" id="esiForm" action="" method="post" > 
<fieldset>

<div  class=" "><?php if ($submitted == 'true'){ echo ($_POST["first_name"] == "") ? " This field is required." : "";} ?></div>
<div><?php echo $fNameError; ?></div>
        <label>First Name (Medicare Beneficiary):</label>
        <input name="first_name" required="required"  type="text" value="<?php echo $_POST['first_name']; ?>">
  
  
  <div>
        <label>Middle Name (Medicare Beneficiary):</label>
        <input name="middle_name" type="text" value="<?php echo $mName; ?>">

  </div>
 
  <div>
<div  class=" "><?php if ($submitted == 'true'){ echo ($_POST["last_name"] == "") ? " This field is required." : "";} ?></div>
        <label>Last Name (Medicare Beneficiary): </label>
        <input name="last_name" required="required"  type="text" value="<?php echo $lName; ?>">
  </div>
  <div>
<div  class=" "><?php if ($submitted == 'true'){ echo ($_POST["dob"] == "") ? " This field is required." : "";} ?></div>
<div><?php  echo $dobError;?></div>
        <label>Date of Birth (MM/DD/YYYY):</label>
        <input name="dob" required="required"  type="text" value="<?php if ($dob == '' ){ echo $mqc_date_birth;} else { echo $dob;} ?>">
  </div>

  <div>
<input name="address_1" required="required"  type="hidden" value="ncoa address">
        <input name="city" required="required"  type="hidden" value="ncoa city">
	<input name="state_province" required="required"  type="hidden" value="AK">
<div><?php if ($submitted == 'true'){ echo ($_POST["zip_code"] == "") ? " This field is required." : "";} ?></div>
<div class=" "><?php echo $zipError; ?></div>
        <label>Your Zip Code:</label>
        <input name="zip_code" required="required" pattern="[0-9]*"  type="text"  value="<?php if ($dob == '' ){ echo $mqc_zipcode;} else { echo $zip;}  ?>">
  </div>
  <div>
 
<div  class=" "><?php if ($submitted == 'true'){ echo ($_POST["phone_number"] == "") ? " This field is required." : "";} ?></div>
<div><?php echo $phoneError; ?></div>
        <label>Phone Number  (XXX) XXX-XXXX (Medicare Beneficiary or Form Completer):</label>
        <input name="phone_number" required="required"   type="text" value="<?php echo $phone; ?>">
  </div>
<div  class=" "><?php if ($submitted == 'true'){ echo ($_POST["confirm_phone"] == "") ? " This field is required." : "";} ?></div>
<div>
<div><?php echo $confirmphoneError ?></div>
        <label>Confirm Phone (XXX) XXX-XXXX (Medicare Beneficiary or Form Completer):</label>
        <input name="confirm_phone" required="required"   type="text" value="<?php echo $confirmphone; ?>">
  </div>
 <div>
<div  class=" "><?php echo $emailError; ?></div>
        <label> E-mail address (Medicare Beneficiary or Form Completer):</label>
        <input name="email" type="email" value="<?php echo $email; ?>">
 </div>
<div  class=" "><?php echo $emailError; ?></div>
        <label> Re-enter E-mail address (Medicare Beneficiary or Form Completer):</label>
        <input name="confirmemail" type="email" value="<?php echo $confirmemail; ?>">
<div  class=" "><?php if ($submitted == 'true'){ echo ($_POST["consent"]== "") ? " This field is required. " : "";} ?></div>

<div class="well" id="disclaimer" >
<legend><i class='icon-ok '></i> Terms & Conditions</legend> 
<p>By submitting my contact details in this form, I agree to allow a licensed
insurance agent of Aon Retiree Health Exchange&#0153; to call me back to discuss my
Medicare coverage options. I have read and understand the Privacy Policy and
know that my information will not be sold to any outside parties, nor will I be
required to purchase any coverage unless I choose to do so.</p>
</div>
<a id="consent" consent></a><input name="consent" required="required" type="checkbox"> I agree to the terms and conditions described above.</input>
<br/>
<br/>








<?php
if (isset($_GET['screeningID'])) {
echo '<input type="hidden" name="screeningID" value="'.$_GET['screeningID'].'">';
}

echo '<input type="hidden" name="submitted" value="true">';

?>
<input class="btnbtn-large" value="Submit" type="submit" onClick="if(!startForm) { ga('send', 'event', 'mqc', 'MQC Thank You Page* (completion)', 'tracksubmit'); ga('mmm.send', 'event', 'mqc', 'MQC Thank You Page* (completion)', 'tracksubmit'); startForm=true; }">

</div>
  </fieldset>
</form>



