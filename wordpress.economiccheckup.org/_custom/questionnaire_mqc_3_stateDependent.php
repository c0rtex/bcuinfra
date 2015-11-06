<?php 

require_once "util/validateFunctions.php";


$zip= $_POST['zip']; 

$zipStateV = validateZip ($zip);

if ($zipStateV != false){ //returns an array
$zipV = $zipStateV['zip'];
$stateV = $zipStateV['state'];
echo $stateV;

}

else {
$zipV = false;
$stateV = false;

}

?>
