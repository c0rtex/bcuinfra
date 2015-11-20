<?php 
require_once "/opt/bcu/etc/encryptionInfo.php";
require_once "util/encryptDecrypt.php";

$county = "";
$agency = "";
$phone = "";
$email = "";
$name = "";
$emailC = "";
$screeningID = "";

if (isset($_GET['county'])) {
$county = $_GET['county'];
}
if (isset($_GET['screeningID'])) {
$screeningID = $_GET['screeningID'];
}

if (isset($_GET['shadowID'])) 
{
$shadowID = $_GET['shadowID'];
}

$availPar = true;

//protect the page
if (!isset($screeningID) || trim($screeningID)===''){ //no screening ID, form accessed not through a screening
header ("Location: /esi-home");
$availPar = false;
}

if (!isset($shadowID) || trim($shadowID)===''){ //no screening ID, form accessed not through a screening
header ("Location: /esi-home");
$availPar = false;
}

if (!isset($county) || trim($county)===''){ //no screening ID, form accessed not through a screening
header ("Location: /esi-home");
$availPar = false;
}




if ($county == '24510'){
$agency = "Baltimore City Commission on Aging and Retirement
Education";
$phone = "(410) 396-2273";
//redesign
//$email = "support@benefitscheckup.org";
//$email = "support@benefitscheckup.org, kiryl.hakhovich@gmail.com";
$email = "map.bchd@baltimorecity.gov";
}

else if ($county == '24043'){
$agency = "Washington County Commission on Aging";
$phone="(301) 790-0275";
//redesign
//$email = "support@benefitscheckup.org";
//$email = "support@benefitscheckup.org, kiryl.hakhovich@gmail.com";
$email = "bcorbett@wccoaging.org, lchurch@wccoaging.org";
}

else if ($county == '24031'){
$agency = "Jewish Social Service Agency of Montgomery County";
$phone= "(301) 816-2633";
$email = "kprice@jssa.org";
//redesign
//$email = "support@benefitscheckup.org";
//$email = "support@benefitscheckup.org, kiryl.hakhovich@gmail.com";

}
else if($county == '24027') {
$agency = "Howard County Office on Aging";
$phone="(410) 313-5980";
$email = "map@howardcountymd.gov";
//redesign
//$email = "support@benefitscheckup.org";
//$email = "support@benefitscheckup.org, kiryl.hakhovich@gmail.com";

}

else if ($county == '24019'|| $county == '24039' || $county == '24045' || $county == '24047'){
$agency = "Maintaining Active Citizens";
$phone = "(410) 742-0505 (ext. 109)";
//redesign
//$email = "support@benefitscheckup.org";
//$email = "support@benefitscheckup.org, kiryl.hakhovich@gmail.com";
$email = "tld@macinc.org";

}


$db = mysqli_init();

if (!$db) {
    die("mysqli_init failed");
}

if(!$db->ssl_set('/opt/bcu/etc/ssl/mysql/new/client-key.pem','/opt/bcu/etc/ssl/mysql/new/client-cert.pem', NULL,NULL,NULL)){
        die("Setting up ssl failed");
}

//if(!$db->real_connect('172.31.33.35','bcuuser','ChasaDusputUf2Ec','bcumigration')){
if(!$db->real_connect(DB_HOST_BCU,DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU)){
        die("Failed to connect to db: " . mysqli_error());
}




$sql = "select subset_id from screening where screening_id=".$screeningID;



  $insertContactInfo    =    $db->prepare($sql);

    $result = $db->query($sql);


$record = mysqli_fetch_assoc(mysqli_query($db, $sql));



//echo 'Subset id:'. $record["subset_id"].';

$reportPage = '';

if ($record["subset_id"] == "83") {
$reportPage = "/esi-quickcheck-report";
}

else if ($record["subset_id"] == "63") {
$reportPage = "/esi-quickcheck-report";
}

echo '



<h1>Thank You</h1>
<br/>

<p>Thank you for submitting your contact information. </p>
<p>
A representative of '.$agency.' should be reaching out to you within the next 3 business days to help you achieve your financial needs and goals.
</p>
<p>
 If you do not hear from them <b>after 3 business days</b>, you can contact the organization by calling: '.$phone.'.
</p>


<div class="printButton">
<form>
<a class="btn btn-large" onclick="window.open(\''.$reportPage.'?screeningID='.$screeningID.'&shadowID='.$shadowID.'\')" href="#" role="button" data-toggle="modal">
Back to Your Report
</a>
</form>


';


//send email to the agency

$to = $email;
$subject = "A consumer in your area has requested help with their EconomicCheckUp report";

$message = '
<html>
<head>
<title></title>
</head>
<body>

<p>Dear '.$agency.',</p>


<p>Please note, a consumer in your area has asked for help with their EconomicCheckUp report.</p>

<p>You can access the consumer’s contact information, EconomicCheckUp report, and answers to the EconomicCheckUp assessment online through your <a href="https://oe.economiccheckup.org/oe/?partner_id=77">login</a>. Please review this information, and contact them within the next 3 business days. </p>

<p>Please do not reply to this email. If you have any questions, please feel free to contact us
at EconomicCheckUp@ncoa.org.</p>

<p>Best Regards,<br/>
The EconomicCheckUp Team</p>

<p>
<b>National Council on Aging</b>
<br/>
<i>Improving the lives of millions of older adults, especially those who are struggling</i>
<br/>
251 18th Street South, Suite 500
<br/>
Arlington, VA 22202
<br/>
ncoa.org | @NCOAging
<br/>
www.EconomicCheckUp.org
</p>



</body>
</html>
';

// Always set content-type when sending HTML email
$headers = "MIME-Version: 1.0" . "\r\n";
$headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";


// More headers
//$headers .= 'From: economiccheckup<do-not-reply>@ncoa.org>' . "\r\n";
$headers .= 'Return-Path: EconomicCheckUp  <donotreply@economiccheckup.org>' . "\r\n";
$headers .= 'From: EconomicCheckUp <donotreply@economiccheckup.org>' . "\r\n";
$headers .= 'Bcc: support@benefitscheckup.org' . "\r\n";


if ($availPar == true) {

mail($to,$subject,$message,$headers);

}

//email to consumer


$db = mysqli_init();

if (!$db) {
    die("mysqli_init failed");
}

if(!$db->ssl_set('/opt/bcu/etc/ssl/mysql/new/client-key.pem','/opt/bcu/etc/ssl/mysql/new/client-cert.pem', NULL,NULL,NULL)){
        die("Setting up ssl failed");
}

//if(!$db->real_connect('172.31.33.35','bcuuser','ChasaDusputUf2Ec','bcumigration')){
if(!$db->real_connect(DB_HOST_BCU,DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU)){
        die("Failed to connect to db: " . mysqli_error());
}




$sql = "select screening_id, screening_id_report, firstname, lastname, email, phone, zip from screening_contact  where screening_id_report =".$screeningID." order by screening_id desc";

  $insertContactInfo    =    $db->prepare($sql);

    $result = $db->query($sql);


$record = mysqli_fetch_assoc(mysqli_query($db, $sql));

$fName = decrypt($record["firstname"], $encPass, $encKey);
$lName = decrypt($record["lastname"], $encPass, $encKey);

$name = $fName." ".$lName;
//echo "<br/>";
//echo $name;

$emailC = decrypt($record["email"], $encPass, $encKey);
//echo "<br/>";
//echo $emailC;
//$emailC = $emailC.", kiryl.hakhovich@gmail.com";



$to2 = $emailC;
$subject2 = "An organization in your area will contact you to help you with your EconomicCheckUp report";

$message2 = '
<html>
<head>
<title></title>
</head>
<body>


<p>Dear '.$fName.',</p>

<p>Thank you for submitting your EconomicCheckUp contact information. A representative of '.$agency.' should be reaching out to you within the next 3 business days to help you achieve your financial needs and goals. </p>

<p>If you do not hear from them <b>after 3 business days</b>, you can contact the organization by calling: '.$phone.'.</p>

<p>Please do not reply to this email as we are unable to respond from this address.</p>

<p>Kindest Regards,</br>
The EconomicCheckUp Team</p>

<p>
<b>National Council on Aging</b>
<br/>
<i>Improving the lives of millions of older adults, especially those who are struggling</i>
<br/>
251 18th Street South, Suite 500
<br/>
Arlington, VA 22202
<br/>
ncoa.org | @NCOAging
<br/>
www.EconomicCheckUp.org
</p>
';

if ($availPar == true) {
mail($to2,$subject2,$message2,$headers);
}
?>
