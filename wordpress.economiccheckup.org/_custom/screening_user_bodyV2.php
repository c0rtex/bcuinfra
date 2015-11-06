<?php 

//author Lynna Cekova


require_once "util/encryptDecrypt.php";
require_once "util/curlContactForm.php";
require_once "util/xmlParse.php";



$fName        = $_POST['first_name'];
$lName        = $_POST['last_name'];    
$mName        = $_POST['middle_name'];
$phone        = $_POST['phone_number'];    
$email          = $_POST['email'];
$dob          = $_POST['dob'];
$address          = $_POST['address_1'];
$city          = $_POST['city'];
$state          = $_POST['state_province'];
$zip          = $_POST['zip_code'];
$screeningId  = $_POST['screeniningId'];
$submitted = $_POST['submitted'];

//echo $address;
//echo $city;
//echo $state;


if ($submitted != 'true'){
 // echo 'submitted';
}

else { //the form has been submitted


$dobV = validateDate ($dob);
$phoneV = validateUSPhone ($phone);
$emailV = validateEmail ($email);
$zipV = validateZip ($zip);

if ($dobV != false && $phoneV != false && $emailV != false && $zipV != false){ 

$saveResult = saveContactInfo ($fName, $lName, $emailV, $phoneV, $mName, $dobV, $zipV, $address, $city, $state);

//echo "<br/>";
//echo "<br/>";
//echo "saveResult is $saveResult";

if ($saveResult == true){ //do the curl request

$curlUrl = 'https://ahnleads-qc.aon.com/create';
$postfields = array('profile_id'=>'ncoa-api','shared_lead'=>'2', 'username'=>'ncoa1', 'password'=>'ncoapswd', 'first_name'=>$fName, 'last_name'=>$lName, 'birthdate'=>$dobV, 'address_1'=>$address, 'city'=>$city, 'state_province'=>$state, 'zip_postal_code'=>$zipV, 'phone_number'=>$phoneV);
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


if ($parsed == "success"){
echo "<br/>";
echo "<br/>";
echo "Success response";
echo "<br/>";
//echo $curlResponse;
echo htmlentities($curlResponse);
//echo "Successful response";

//header ("Location: https://esidtc.benefitscheckup.org/screening-contact-success/");

}

else if ($parsed == "error"){
echo "<br/>";
echo "<br/>";
echo "Error response: ";
echo "<br/>";
//echo $curlResponse;
echo htmlentities($curlResponse);

//header ("Location: https://esidtc.benefitscheckup.org/screening-contact-error/");
}

else {
echo "<br/>";
echo "<br/>";
echo "Some other error with parsing";
echo "<br/>";
echo "Start CURL response";
echo "<br/>";
//echo $curlResponse;
echo htmlentities($curlResponse);
echo "<br/>";
echo "End CURL response";

header ("Location: https://esidtc.benefitscheckup.org/screening-contact-error/");


}

}

else {
 echo "CURL response error";
 echo "<br/>";
echo "<br/>";
echo $curlResponse;

//TODO take care that this is is an error message without parsing (it didn't get to parsing)
header ("Location: https://esidtc.benefitscheckup.org/screening-contact-error/");

}





}

else {

//echo "There was an error with saving data to the db."; //TODO: better error handling
header ("Location: https://esidtc.benefitscheckup.org/screening-contact-error/");
}



}

else { //return to the form with the correct errors.

$formErrors = "There were errors in your data. Please correct them and submit again.";

if ($dobV == false){
  $dobError = "Invalid date";
}

if ($phoneV == false){
  $phoneError = "Invalid phone";
}

if ($emailV == false){

  $emailError = "Invalid email";
}

if ($zipV == false){

  $zipError = "Invalid zip code";
}


//echo "date error";

}
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


    return $zip;
    //valid
} else {
  return false;
}


}

function validateEmail ($email){

if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
  return $email;
}
else {
  return false;
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

function validateDate ($dob){ //mm/dd/yyyy
	
$date_arr  = explode('/', $dob);
//echo $date_arr;
//echo count($date_arr);
if (count($date_arr) == 3) {
    if (checkdate($date_arr[0], $date_arr[1], $date_arr[2])) {
$dob = date("Y-m-d",strtotime($dob));
if ($dob > date ("Y-m-d")){ //checkdate passes but the date is in the future
  return false;
}

else {
//echo 'date ';
        // valid date ...
echo $dob;
return $dob;
}
    } 



else {

        // problem with dates ...
//echo 'invalid date';
return false;
    }
} else {
    // problem with input ...
//echo 'invalid input';
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

if(!$db->real_connect('172.31.33.35','esidtcssl','heDruca6','esidtc')){
        die("Failed to connect to db: " . mysqli_error());
}


//$db_server = mysql_connect('172.31.33.35', 'esidtc', 'W6ApuXec')
    //or die("Unable to connect to MySQL: " . mysql_error());

// Select the database.
//mysqli_select_db('esidtc')
    //or die("Unable to select database: " . mysqli_error());

//TODO: get the password and hash from elsewhere

$fName = encrypt ($fName, 'somePassword');
$lName = encrypt ($lName, 'somePassword');
$email = encrypt ($email, 'somePassword');
$phone = encrypt ($phone, 'somePassword');
$mName = encrypt ($mName, 'somePassword');
$dob = encrypt ($dob, 'somePassword');
$zip = encrypt ($zip, 'somePassword');
$address = encrypt ($address, 'somePassword');
$city = encrypt ($city, 'somePassword');
$state = encrypt ($state, 'somePassword');

// Insert data into mysql
$sql="INSERT INTO screening_contact (firstname, lastname, email, phone, datetime, middlename, dob, zip, address_1, city, state)
VALUES ('$fName', '$lName', '$email', '$phone', NOW(), '$mName', '$dob', '$zip', '$address', '$city', '$state')";
//echo $sql;
//$result = mysqli_query($sql);



  $insertContactInfo    =    $db->prepare($sql);

    $result = $insertContactInfo->execute();



//$mysqli->close();





if($result == 1){
//echo "SUCCESS";
return true;
}

else {
//echo "ERROR";
return false;
}



}

?>

<div><?php echo $formErrors; ?></div>
<div class="span8">  
<form name="esiForm" id="esiForm" action="" method="post" > 
  <div>
<div><?php if ($submitted == 'true'){ echo ($_POST["first_name"] == "") ? " This field is required." : "";} ?></div>
<div><?php echo $fNameError; ?></div>
        <label>First Name:</label>
        <input name="first_name" required="required"  type="text" value="<?php echo $_POST['first_name']; ?>">
  </div>
  <div>
<div><?php if ($submitted == 'true'){ echo ($_POST["middle_name"] == "") ? " This field is required." : "";} ?></div>
        <label>Middle Name:</label>
        <input name="middle_name" required="required"  type="text" value="<?php echo $mName; ?>">

  </div>
 
  <div>
<div><?php if ($submitted == 'true'){ echo ($_POST["last_name"] == "") ? " This field is required." : "";} ?></div>
        <label>Last Name:</label>
        <input name="last_name" required="required"  type="text" value="<?php echo $lName; ?>">
  </div>
  <div>
<div><?php if ($submitted == 'true'){ echo ($_POST["dob"] == "") ? " This field is required." : "";} ?></div>
<div><?php echo $dobError; ?></div>
        <label>Date of Birth (MM/DD/YYYY):</label>
        <input name="dob" required="required"  type="text" value="<?php echo $dob; ?>">
  </div>

        <input name="address_1" required="required"  type="hidden" value="ncoa address">
        <input name="city" required="required"  type="hidden" value="ncoa city">
	<input name="state_province" required="required"  type="hidden" value="AK">



  <div>
<div><?php if ($submitted == 'true'){ echo ($_POST["zip_code"] == "") ? " This field is required." : "";} ?></div>
<div><?php echo $zipError; ?></div>
        <label>Zip / Postal Code:</label>
        <input name="zip_code" required="required"  type="text" value="<?php echo $zip; ?>">
  </div>
  <div>
 
<div><?php if ($submitted == 'true'){ echo ($_POST["phone_number"] == "") ? " This field is required." : "";} ?></div>
<div><?php echo $phoneError; ?></div>
        <label>Phone (XXX)XXX-XXXX:</label>
        <input name="phone_number" required="required"  type="text" value="<?php echo $phone; ?>">
  </div>
  <div>
<div><?php if ($submitted == 'true'){ echo ($_POST["email"]== "") ? " This field is required." : "";} ?></div>
<div><?php echo $emailError; ?></div>
        <label> Your email:</label>
        <input name="email" required="required" type="email" value="<?php echo $email; ?>">
  </div>
<div>
  <input class="btn btn-large" value="Submit" type="submit"> 
</div>


<?php


if (isset($_GET['screeningID'])) {
echo '<input type="hidden" name="screeningID" value="'.$_GET['screeningID'].'">';
}

echo '<input type="hidden" name="submitted" value="true">';

?>


</form>



