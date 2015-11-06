
<?php

echo 'Test';

/*
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
*/


$zip = '06824';
$fName        = 'Test';
$lName        = 'Test2';
$mName        = 'TestM'
$phone        = '111-111-1111';
$confirmphone        = '111-111-1111';
$email          = 'test_dbmqc@test.com';
$confirmemail          = 'test_dbmqc@test.com';
$dob          = '03/21/1965';
$address          = 'Test st';
$city          = 'Test c';
$state          = 'NY';
$screeningId  = '5039689';
$submitted = 'true';
$consent = 'true';



$formlUrl = 'https://redesign.benefitscheckup.org/screening-contact';

$postfields = array('profile_id'=>'ncoa-api','shared_lead'=>'2', 'username'=>$curlUser, 'password'=>$curlPass, 'first_name'=>$fName, 'last_name'=>$lName, 'birthdate'=>$dobV, 'address_1'=>$address, 'city'=>$city, 'state_province'=>$stateV, 'zip_postal_code'=>$zipV, 'phone_number'=>$phoneV,'custom_1'=>$api_cid);

echo (http_build_query($postfields));


$curlResponse = getCurlResponse ($postfields, $formUrl);

if ($curlResponse != false){
 echo "CURL response success";
 echo "<br/>";
echo "<br/>";
echo $curlResponse;

}

else {
 echo "CURL response error";
 echo "<br/>";
echo "<br/>";
echo $curlResponse;


}




?>
