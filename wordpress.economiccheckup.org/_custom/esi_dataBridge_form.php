<?php 
require_once "/opt/bcu/etc/encryptionInfo.php";
require_once "util/encryptDecrypt.php";

$screeningID          = $_POST['screeningID']; //form submitted
if (isset($_GET['screeningID'])) //form not submitted; screeningID required as a URL parameter
{
//echo "ScreeningID from questionnaire:".$_GET['screeningID'];
$screeningID = $_GET['screeningID'];
}

//protect the page
if (!isset($screeningID) || trim($screeningID)===''){ //no screening ID, form accessed not through a screening
header ("Location: /esi-home");
}

if (isset($_GET['shadowID'])) //form not submitted; screeningID required as a URL parameter
{
$shadowID = $_GET['shadowID'];
}

//protect the page
if (!isset($shadowID) || trim($shadowID)===''){ //no screening ID, form accessed not through a screening
header ("Location: /esi-home");
}





$url_cid = '';
//require_once('util/affinity_track_contact.php');
//end affinity tracking


require_once "util/validateFunctions.php";
require_once "util/encryptDecrypt.php";
require_once "util/curlContactForm.php";
require_once "util/xmlParse.php";
require_once "/opt/bcu/etc/encryptionInfo.php";
//echo "<br/>";
//echo "TEST";
//echo "<br/>";
//echo $screeningID;
//echo "<br/>";
/*
echo $_POST['test'];
echo $test;
echo "<br/>";
echo "POST";
echo "<br/>";
print_r ($_POST);
*/
$fName        = $_POST['first_name'];
$lName        = $_POST['last_name'];    
$phone        = $_POST['phone_number'];  
$confirmphone        = $_POST['confirm_phone'];    
$email          = trim($_POST['email']);
$confirmemail          = trim($_POST['confirmemail']);
$zip          = $_POST['zip'];
$county          = $_POST['county'];
$submitted = $_POST['submitted'];
$consent = $_POST['consent'];


if ($submitted != 'true'){
}

else { //the form has been submitted


//echo "<br/>";
//echo "<br/>";
//echo "original sccid ";
//echo $screeningContactId;




$phoneV = validateUSPhone ($phone);
$confirmphoneV = confirmPhone($phone,$confirmphone);

//echo "EMAIL".$email."end";
//echo "C EMAIL ".$confirmemail;

$email = preg_replace('/\s+/', '', $email);
$confirmemail = preg_replace('/\s+/', '', $confirmemail);

/*
if (!empty($email)){
echo "emailnotempty";
}
else echo "emailempty";
if (!empty($confirmemail)){
echo "cemailnotempty";
}
else echo "cemailempty";
*/
//if (empty($email) && empty($confirmemail)){
//echo "bothempty";
//$emailV = "no email"; //no email at all; empty
//echo "<br/>emailV ".$emailV;
//}
//else {
$emailV = validateEmail ($email, $confirmemail);
//}

//echo "<br/>emailV2 ".$emailV;


//echo "<br/>";
//echo "<br/>";
//echo $emailV;
if ((($phoneV != false && $confirmphoneV != false) || ($emailV != false && $emailV != "emailMismatch")) && trim($_POST["first_name"]) != "" && trim($_POST["last_name"]) != "" ){ 

//echo "HERE <br/>emailV ".$emailV;
$saveResult = saveContactInfo ($fName, $lName, $emailV, $phoneV, $zip, $encPass, $encKey, $screeningID);

//echo "<br/>";
//echo "<br/>";
//echo "saveResult is $saveResult";

if ($saveResult['status'] == 'true'){ //do the curl request

//TODO: Lynna, provide thank you language
//echo "Saving successful."; //TODO: better error handling
header ("Location: /esi-data-bridge-submitted/?county=".$county."&screeningID=".$screeningID."&shadowID=".$shadowID);

}

else {

//TODO: error message
//echo "There was an error with saving data to the db."; //TODO: better error handling
$formErrors = "<div class='alert alert-danger'><strong>There was a problem with your submission. Please try again.</strong></div>";
//header ("Location: https://redesign.benefitscheckup.org/screening-contact-error/");
}



}

else { //return to the form with the correct errors.

//echo "THERE <br/>emailV ".$emailV;
$formErrors = "<div class='alert alert-danger'><strong>Please correct the following fields.</strong></div>";

if (trim($_POST["first_name"]) == ""){
  $firstNameError = "<div class='alert alert-danger'>Please enter a first name.</div>";
}

if (trim($_POST["last_name"]) == ""){
  $lastNameError = "<div class='alert alert-danger'>Please enter a last name.</div>";
}

if (($phoneV == false || $confirmphoneV == false) && ($emailV == false || $emailV == "emailMismatch")){ //only phone or email required

if ($phoneV == false){
  //$phoneError = "<div class='alert alert-danger'>Please enter a valid phone number.</div>";
  $phoneError = "<div class='alert alert-danger'>You must enter either a valid phone number or email address.</div>";
}
if ($confirmphoneV == false){
//  $confirmphoneError = "<div class='alert alert-danger'>Phone numbers must match.</div>";
  $phoneError = "<div class='alert alert-danger'>You must enter either a valid phone number or email address.</div>";
}
if ($emailV == false){

  //$emailError = "<div class='alert alert-danger'>Please enter a valid E-mail address. </div>";
  $phoneError = "<div class='alert alert-danger'>You must enter either a valid phone number or email address.</div>";
}

//echo "THERE AGAIN <br/>emailV ".$emailV;
if ($emailV == "emailMismatch"){
 // $emailError = "<div class='alert alert-danger'>Emails don't match.</div>";
  $phoneError = "<div class='alert alert-danger'>You must enter either a valid phone number or email address.</div>";
}
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

function saveContactInfo ($fName, $lName, $email, $phone, $zip, $encPass, $encKey, $screeningID){

/// Connect to server securely.
$db = new mysqli();
$db->init();

if (!$db) {
    die("mysqli_init failed");
}
//if(!$db->ssl_set('/opt/bcu/etc/ssl/mysql/client-key.pem','/opt/bcu/etc/ssl/mysql/client-cert.pem', '/opt/bcu/etc/ssl/mysql/ca-cert.pem',NULL,NULL)){
if(!$db->ssl_set('/opt/bcu/etc/ssl/mysql/new/client-key.pem','/opt/bcu/etc/ssl/mysql/new/client-cert.pem',NULL,NULL,NULL)){
        die("Setting up ssl failed");
}

//if(!$db->real_connect('172.31.33.35','bcuuser','ChasaDusputUf2Ec','bcumigration')){
if(!$db->real_connect(DB_HOST_BCU,DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU)){
        die("Failed to connect to db: " . mysqli_error());
}


//$db_server = mysql_connect('172.31.33.35', 'esidtc', 'W6ApuXec')
    //or die("Unable to connect to MySQL: " . mysql_error());

// Select the database.
//mysqli_select_db('esidtc')
    //or die("Unable to select database: " . mysqli_error());

//TODO: get the password and hash from elsewhere

/*
echo "<br/>";
echo $fName;
echo "<br/>";
echo $lName;
echo "<br/>";
echo $email;
echo "<br/>";
*/


$fName = encrypt ($fName, $encPass, $encKey);
$lName = encrypt ($lName, $encPass, $encKey);
$email = encrypt ($email, $encPass, $encKey);
$phone = encrypt ($phone, $encPass, $encKey);
$zip = encrypt ($zip, $encPass, $encKey);

$sqlScreeningTable = "INSERT INTO screening (subset_id, start_datetime, end_datetime, prev_screening_id, source_id, partner_id, preset_state_id) VALUES (82, NOW(), NOW(), '0', '1', '77', 'MD')";
//state MD based on zip for the data bridge; TODO, Lynna Cekova; if extended to other states, get dynamically
//echo $sqlScreeningTable;
//echo "<br/>";


 if ($insertContactInfo = $db->prepare($sqlScreeningTable))
 {

 //$echo "Debug: $insertContactInfo";
 $result = $insertContactInfo->execute();
// echo "Debug: $insertContactInfo->error";

 $screeningTableContactId = $db->insert_id; //get the auto generated id of the row
 file_put_contents('/tmp/crazy.log', $result);
 
	if($result != TRUE ){
		return array('status'=>'false');
	}
#$insertContactInfo->fetch();
$insertContactInfo->store_result();
#$insertContactInfo->close();
#$insertContactInfo->free_result();
}
file_put_contents ('/tmp/crazy.log',$db->error);
// Insert data into the screening_contact table
$sql="INSERT INTO screening_contact (screening_id, screening_id_report, firstname, lastname, email, phone, datetime, zip) VALUES ('$screeningTableContactId', '$screeningID', '$fName', '$lName', '$email', '$phone', NOW(), '$zip')";
//screeningTableContactId is the new 82 ID of the data bridge form, while screeningID is the old 63 ID of the ESI screening
//echo $sql;

/*
echo "<br/>";
echo "82 id ";
echo $screeningTableContactId;
echo "<br/>";
echo "Again";
echo "<br/>";
echo $fName;
echo "<br/>";
echo $lName;
echo "<br/>";
echo $email;
echo "<br/>";
*/

if ($insertContactInfo =$db->prepare($sql))
 {

    $result = $insertContactInfo->execute();
$screeningContactId = $db->insert_id; //get the auto generated id of the row
//echo "Screening contact id in the func";
//echo $screeningContactId;


if($result == TRUE){
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

}





?>

<div class="whitewell"><?php echo $formErrors; ?>


<form  name="esiForm" id="esiForm" action="" method="post" > 
<h1>Get Help in Your Community</h1>
<div>
<p>
Complete this form to authorize an agency in your community to receive a copy of your assessment and contact information.  Your information will remain secure at all times. It will NOT be made public or used for any purpose other than to contact you to discuss resources that may be available to help you meet your financial needs. There is no fee for this service.
</p>
<p>
<div><?php echo $firstNameError; ?></div>
<div  class=" "><?php if ($submitted == 'true'){ echo ($_POST["first_name"] == "") ? " First Name is required." : "";} ?></div>
<div><?php echo $lastNameError; ?></div>
<div  class=" "><?php if ($submitted == 'true'){ echo ($_POST["last_name"] == "") ? " Last Name is required." : "";} ?></div>
<div  class=" "><?php if ($submitted == 'true'){ echo ($_POST["phone_number"] == "") ? " Phone is required." : "";} ?></div>
<div><?php echo $phoneError; ?></div>
<div  class=" "><?php if ($submitted == 'true'){ echo ($_POST["confirm_phone"] == "") ? " Confirm Phone is required." : "";} ?></div>
<div><?php echo $confirmphoneError ?></div>
<div  class=" "><?php echo $emailError; ?></div>
</p>

</div>
<fieldset>

<table>
<tr class="dataBridge" id="name">
<td>
        <label>First Name:</label>
        <input name="first_name" required="required"  type="text" value="<?php echo $_POST['first_name']; ?>">
  
<td>
        <label>Last Name:</label>
        <input name="last_name" required="required"  type="text" value="<?php echo $lName; ?>">
</td>
</tr>
<tr class="dataBridge" id="phone">
<td>
        <label>Phone Number  (XXX) XXX-XXXX:</label>
        <input name="phone_number" type="text" value="<?php echo $phone; ?>">
</td>
<td>
        <label>Confirm Phone (XXX) XXX-XXXX:</label>
        <input name="confirm_phone" type="text" value="<?php echo $confirmphone; ?>">
</td>
</tr>
<tr class="dataBridge" id="email">
<td>
        <label> E-mail address:</label>
        <input name="email" type="email" value="<?php echo $email; ?>">
</td>
<td>
        <label> Re-enter E-mail address:</label>
        <input name="confirmemail" type="email" value="<?php echo $confirmemail; ?>">
</td>
</tr>
</table>
<br>
     
<div class="well" id="disclaimer" >
<legend><i class='icon-ok '></i> Terms & Conditions</legend> 
<p>
By submitting my contact details in this form, I agree to allow a professional in the field of aging to electronically access my contact information and contact me to discuss my EconomicCheckUp report as well as other available community resources.  I have read and understand the <a href="/esi-privacy-policy" target="_blank">Privacy Policy</a> and know that NCOA will not sell or share my personal data to outside parties without my consent.
</p>
</div>
<div  class=" "><?php if ($submitted == 'true'){ echo ($_POST["consent"]== "") ? " This field is required. " : "";} ?></div>
<div class="checkbox">
            	<label class="checkbox">
<a id="consent" consent></a><input name="consent" required="required" type="checkbox"> I agree to the terms and conditions described above.</input>
</label> 
         	</div>
<br/>
<br/>








<?php
if (isset($_GET['screeningID'])) {
echo '<input type="hidden" name="screeningID" value="'.$_GET['screeningID'].'">';
}
if (isset($_GET['zip'])) {
echo '<input type="hidden" name="zip" value="'.$_GET['zip'].'">';
}
if (isset($_GET['county'])) {
echo '<input type="hidden" name="county" value="'.$_GET['county'].'">';
}
echo '<input type="hidden" name="submitted" value="true">';

?>
<div class="printButton">
<input class="btn btn-large" value="Submit" type="submit">
</div>

</div>
  </fieldset>
</form>



