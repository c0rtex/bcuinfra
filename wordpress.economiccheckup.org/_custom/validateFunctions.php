<?php 

function validateEmail ($email, $confirmemail){

//echo "<br/>";
//echo "<br/>";
//echo $email;
//echo "<br/>";
//echo "<br/>";
//echo $confirmemail;
if ($email == $confirmemail){
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

if(!$db->real_connect('172.31.33.35','esidtcssl','heDruca6','esidtc')){
        die("Failed to connect to db: " . mysqli_error());
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



?>
