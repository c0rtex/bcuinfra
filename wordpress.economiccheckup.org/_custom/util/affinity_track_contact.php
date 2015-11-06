<?php
//log affinity data and add to api data transfer
//default api campaign id or cid from affinity click urls
if (isset($_GET['click_id'])) {
	$_SESSION['click_id'] = $_GET['click_id'];
}
if (isset($_GET['CID'])) {
	$_SESSION['CID'] = $_GET['CID'];
}
$api_cid = 'ncoa-api';
if (isset($_SESSION['click_id']) && ( $_SESSION['click_id'] !== 0)){
$affinity_debug =0;
if ( $affinity_debug == 1){
	echo 'Testing Affinity Data- click_id:'.$_SESSION['click_id'].' CID:'.$_SESSION['CID'].' PID:'.$_SESSION['PID'];
}

if (isset($_SESSION['CID']) && ($_SESSION['CID'] != '')){
$url_cid = $_SESSION['CID'];
//send over the camaign id instead of default ncoa id for these campaigns
if ( ($_SESSION['CID'] == 381 ) || ($_SESSION['CID'] == 27 ) ) {
$api_cid = $_SESSION['CID'];
}
}

}
if ( $affinity_debug == 1){ 
echo 'API key Custom1:'.$api_cid;
}
?>