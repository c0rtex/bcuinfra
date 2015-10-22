<?php

	include("connect.php");
	$v = $_POST['val'];
	$uid = intval($_POST["uid"]);
	$field = mysql_real_escape_string($_POST["field"]);
	
	include('../_includes/cys-functions.php');
	
	cys_update_usermeta($uid, $field, $v);
	
	mysql_close();
	
?>