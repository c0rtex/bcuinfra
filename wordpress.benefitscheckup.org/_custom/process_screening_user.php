<?php

 

$fName        = $_POST['first_name'];
$lName        = $_POST['last_name'];    
$mName        = $_POST['middle_name'];
$phone        = $_POST['phone_number'];    
$email          = $_POST['email'];
$dob          = $_POST['dob'];
$zip          = $_POST['zip_code'];
$screeningId  - $_POST['screeniningId'];

$_SESSION['screening_first_name'] = $_POST['first_name'];
$_SESSION['screening_last_name'] = $_POST['last_name'];
$_SESSION['screening_middle_name'] = $_POST['middle_name'];
$_SESSION['screening_phone_number'] = $_POST['phone_number'];
$_SESSION['screening_email'] = $_POST['email'];
$_SESSION['screening_dob'] = $_POST['dob'];
$_SESSION['screening_zip_code'] = $_POST['zip_code'];


echo $dob;

$date_arr  = explode('/', $dob);
echo $date_arr;
echo count($date_arr);
if (count($date_arr) == 3) {
    if (checkdate($date_arr[0], $date_arr[1], $date_arr[2])) {
echo 'date';
        // valid date ...
$dob = date("Y-m-d H:i:s",strtotime($dob));
echo $dob;
    } else {
        // problem with dates ...
echo 'invalid date';
    }
} else {
    // problem with input ...
echo 'invalid input';
}



/// Connect to server.
$db_server = mysql_connect('172.31.33.35', 'esidtc', 'W6ApuXec')
    or die("Unable to connect to MySQL: " . mysql_error());

// Select the database.
mysql_select_db('esidtc')
    or die("Unable to select database: " . mysql_error());

// Insert data into mysql
$sql="INSERT INTO screening_contact (firstname, lastname, email, phone, datetime, middlename, dob, zip)
VALUES ('$fName', '$lName', '$email', '$phone', NOW(), '$mName', '$dob', '$zip')";
echo $sql;
$result = mysql_query($sql);

if($result){
//header('Location: ../thankyou.php');
echo "SUCCESS";
}
else {
echo "ERROR";
}

mysql_close();


header('Location: ' . $_SERVER['HTTP_REFERER']);

?>
