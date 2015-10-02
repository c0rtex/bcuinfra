
<?php
$screeningId  = '5039689';
$screeningId  = $_GET['screeningId'];
require_once "util/curlContactForm.php";

/*
$zip = '06824';
$fName        = 'Test';
$lName        = 'Test2';
$mName        = 'TestM';
$phone        = '111-111-1111';
$email          = 'test_dbmqc@test.com';
$dob          = '03/21/1965';
$address          = 'Test st';
$city          = 'Test c';
$state          = 'NY';
*/

$zip = '';
$fName        = '';
$lName        = '';
$mName        = '';
$phone        = '';
$email          = '';
$dob          = '';
$address          = 'ncoa_address';
$city          = 'ncoa city';
$state          = 'AK';

$be_clnt_phnarea = '';
$be_clnt_phnexch = '';
$be_clnt_phnnum = '';

$mqc_birth_month = '';
$mqc_birth_day = '';
$mqc_birth_year = '';




$bcudb = new wpdb(DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU,DB_HOST_BCU);
echo 'testing';
$query_getScreening = "select a.answerfield answer, 
                                ifnull(sa.response, ifnull(o.option_code, '#nullstring#')) response, sa.submit_datetime submit
                        from screening_answerfield sa inner join answerfield a
                                        on sa.answerfield_id = a.answerfield_id
                                left outer join `option` o 
                                        on sa.option_id = o.option_id
                        where sa.screening_id= ".$screeningId;
$result = mysql_query($query_getScreening);

if (!$result) {
    $message  = 'Invalid query: ' . mysql_error() . "\n";
    $message .= 'Whole query: ' . $query;
    die($message);
}

while($row = mysql_fetch_assoc($result)){
	/* Inside while loop */
//echo "<pre>";
//print_r ($row);

if ($row['answer'] == 'be_clnt_fnm'){
$fName        = $row['response'];
}
else if ($row['answer'] == 'be_clnt_mim'){
$mName        = $row['response'];
}
else if ($row['answer'] == 'be_clnt_lnm'){
$lName        = $row['response'];
}
else if ($row['answer'] == 'be_clnt_phnarea'){
$be_clnt_phnarea        = $row['response'];
}
else if ($row['answer'] == 'be_clnt_phnexch'){
$be_clnt_phnexch        = $row['response'];
}
else if ($row['answer'] == 'be_clnt_phnnum'){
$be_clnt_phnnum        = $row['response'];
}
else if ($row['answer'] == 'email_address'){
$email        = $row['response'];
}
else if ($row['answer'] == 'mqc_birth_month'){
$mqc_birth_month        = $row['response'];
}
else if ($row['answer'] == 'mqc_birth_day'){
$mqc_birth_day        = $row['response'];
}
else if ($row['answer'] == 'mqc_birth_year'){
$mqc_birth_year        = $row['response'];
}
else if ($row['answer'] == 'mqc_zipcode'){
$zip        = $row['response'];
}





}

$phone = $be_clnt_phnarea."-".$be_clnt_phnexch."-".$be_clnt_phnnum;
$dob = "01/01/".$mqc_birth_year;



//echo $query_getScreening;

//Lynna Cekova: not sending address, since the contact form doesn't care



$submitted = 'true';
$consent = 'true';

$formUrl = 'https://medicarequickcheck.benefitscheckup.org/screening-contact';
//$formlUrl = 'https://ahnleads-qc.aon.com/create';

$postfields = array('first_name'=>$fName, 'last_name'=>$lName, 'middle_name'=>$mName,'dob'=>$dob, 'address_1'=>'ncoa address', 'city'=>'ncoa city', 'state_province'=>'AK', 'zip_code'=>$zip, 'phone_number'=>$phone, 'confirm_phone'=>$phone, 'email'=>$email, 'confirmemail'=>$email, 'screeningId'=>$screeningId, 'submitted'=>'true', 'consent'=>'true');

echo ("<br/>");
echo ("Sending these parameters to our contact form:");

echo ("<br/>");
echo (http_build_query($postfields));

echo ("<br/>");
echo ("<br/>");

$curlResponse = getCurlResponse ($postfields, $formUrl);

if ($curlResponse != false){
 echo "CURL response success";
 echo "<br/>";
echo "pass<br/>";
echo $curlResponse;

}

else {
 echo "CURL response error";
echo "fail<br/>";
echo $curlResponse;


}




?>
