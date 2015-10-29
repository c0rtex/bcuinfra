<?php

	include("connect.php");
	$amount = intval($_POST['amount']);
	$uid = intval($_POST["uid"]);
	$name = mysql_real_escape_string($_POST["name"]);
	$type = mysql_real_escape_string($_POST['type']);
	$status = mysql_real_escape_string($_POST['status']);
	include('../_includes/cys-functions.php');
	
	$tdid = cys_update_todo($uid, $name, $amount, $status, $type);
	echo $tdid;
	mysql_close();
	
?>