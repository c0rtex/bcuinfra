<?php 
$tty = 'Dial 711';
$phone = '1-800-975-9655';
if (isset($_SESSION['CID'])) {

//
if ($_SESSION['CID'] == '27') {
$tty = '888 555 OUCH';
$phone = '800 555 OUCH';
}

//
if ($_SESSION['CID'] == '381') {
$tty = '888 555 1212';
$phone = '800 555 1212';
}


//
if ($_SESSION['CID'] == '111111-1') {
$tty = '888 111 1111';
$phone = '877 111 1111';
}

}
else {
$tty = 'Dial 711';
$phone = '1-800-975-9655';
}
echo 'Testing phone....'.$tty.$phone;
 ?>