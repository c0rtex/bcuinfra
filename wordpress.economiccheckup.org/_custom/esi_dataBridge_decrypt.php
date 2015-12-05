<?php 
require_once "/opt/bcu/etc/encryptionInfo.php";
require_once "util/encryptDecrypt.php";

$dataBridge = "false";
if (isset($_GET['databridge'])) {
$dataBridge = $_GET['databridge'];
}

if ($dataBridge == "true") {

$screeningID = $_GET['screeningID'];
echo "<br/>";
echo "<b>Unique ID: ".$screeningID."</b>";
echo "<br/>";
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




$sql = "select screening_id, screening_id_report, firstname, lastname, email, phone, zip from screening_contact  where screening_id_report =".$screeningID." order by screening_id desc";



  $insertContactInfo    =    $db->prepare($sql);

    $result = $db->query($sql);


$record = mysqli_fetch_assoc(mysqli_query($db, $sql));

/*
echo "<br/>Record: ";
echo "<pre>";
print_r ($record);
echo "<br/>Record decrypted: ";
echo "<br/>";
echo $record["screening_id"];
echo "<br/>";
echo decrypt($record["firstname"], $encPass, $encKey);
echo "<br/>";
echo decrypt ($record["lastname"], $encPass, $encKey);
echo "<br/>";
echo decrypt ($record["email"], $encPass, $encKey);
echo "<br/>";
echo decrypt ($record["phone"], $encPass, $encKey);
echo "<br/>";
echo $record["datetime"];
echo "<br/>";
echo decrypt ($record["zip"], $encPass, $encKey);
echo "<br/>";


*/


?>


<div class="whitewell"><?php echo $formErrors; ?>
<?php
//echo "<br/>";
//echo "<b>Unique Subset 82 ID: ".$record["screening_id"]."</b>";
//echo "<br/>";
?>

<form  name="esiForm" id="esiForm" action="" method="post" > 
<h1>Get Help in Your Community</h1>
<div>
<p>
Complete this form to authorize an agency in your community to receive a copy of your assessment and contact information.  Your information will remain secure at all times. It will NOT be made public or used for any purpose other than to contact you to discuss resources that may be available to help you meet your financial needs. There is no fee for this service.
</p>
</div>
<fieldset>

<table>
<tr class="dataBridge">
<td>
        <label>First Name:</label>
        <input name="first_name" disabled required="required"  type="text" value="<?php echo decrypt($record["firstname"], $encPass, $encKey); ?>">

</td>
  
<td>
        <label>Last Name:</label>
        <input name="last_name" disabled required="required"  type="text" value="<?php echo decrypt($record["lastname"], $encPass, $encKey); ?>">
</td>
</tr>
<tr class="dataBridge">
<td>
<?php
$phone = explode(")", decrypt($record["phone"], $encPass, $encKey));
?>
        <label>Phone Number  (XXX) XXX-XXXX:</label>
        <input name="phone_number" disabled required="required"  type="text" value="<?php if (trim($phone[0]) != "") {echo $phone[0].") ".$phone[1];} ?>">
</td>
<td>
        <label>Confirm Phone (XXX) XXX-XXXX:</label>
        <input name="confirm_phone" disabled required="required"  type="text" value="<?php if (trim($phone[0]) != "") {echo $phone[0].") ".$phone[1];} ?>">
</td>
</tr>
<tr class="dataBridge">
<td>
        <label> E-mail address:</label>
        <input name="email" disabled type="email" value="<?php echo decrypt($record["email"], $encPass, $encKey); ?>">
 </div>
</td>
<td>
        <label> Re-enter E-mail address:</label>
        <input name="confirmemail" disabled type="email" value="<?php echo decrypt($record["email"], $encPass, $encKey); ?>">
</td>
</tr>
</table>
<br>
     
<div class="well" id="disclaimer" >
<legend><i class='icon-ok '></i> Terms & Conditions</legend> 
<p>
By submitting my contact details in this form, I agree to allow a professional in the field of aging to electronically access my contact information and contact me to discuss my EconomicCheckUp report as well as other available community resources.  I have read and understand the Privacy Policy and know that NCOA will not sell or share my personal data to outside parties without my consent.
</p>
</div>
<br/>
<br/>





</div>
  </fieldset>
</form>
</div>
