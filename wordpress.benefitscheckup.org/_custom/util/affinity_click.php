<?php

require_once('affinity_client.php');


//Log Affinity Partner Data   such as PID=44&CID=1232&IET=1&SID=6638295
$affinity_debug = 0;
$PID = 0;
$CID = 0;
$SID = "";
$IET = 0;
$_SESSION['click_id'] = 0;

if (isset($_GET['PID']))
{
$PID = $_GET['PID'];
if ($affinity_debug == 1){
echo "Debug Affinity PID:".$PID."<br>";
}
}
if (isset($_GET['CID']))
{
$CID = $_GET['CID'];
if ($affinity_debug == 1){
echo "Debug Affinity CID:".$CID."<br>";
}
}

if (isset($_GET['SID']))
{
$SID = $_GET['SID'];
if ($affinity_debug == 1){
echo "Debug Affinity SID:".$SID."<br>";
}
}
if (isset($_GET['IET']))
{
$IET = $_GET['IET'];
if ($affinity_debug == 1){
echo "Debug Affinity IET:".$IET."<br>";
}
}

if ($PID > 0 || $SID > 0 || $SID != ''){

/*
partner_id,partner_session_id,url_id,campaign_id,internal_flag,ahn_contact_flag,screening_id,click_id
 */
$ws_click_id = 1;
$ws_click_id = $affinityClient->logAffinityClick($PID,$SID,64,$CID,$IET,0,0,0);
$_SESSION['click_id'] = $ws_click_id;
if ($affinity_debug == 1){
echo 'click_id:'.$_SESSION['click_id'];
}
}

$_SESSION['PID'] = $PID;
$_SESSION['CID'] = $CID;

?>