<?php

	include('wp-connect.php');
	include('connect.php');
	$key = mysql_real_escape_string($_POST['key']);
	$val = mysql_real_escape_string($_POST['val']);
	$msg = mysql_real_escape_string($_POST['msg']);
	
	$user = wp_get_current_user();
	$query = "INSERT INTO shebang_logs (uid, log_key, log_value, message) VALUES ($user->ID, '$key', '$val', '$msg')";
	echo $query;
	mysql_query($query) or die(mysql_error());
	mysql_close();
	