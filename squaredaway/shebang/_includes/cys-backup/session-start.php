<?php
	if ($_COOKIE['uid']){
		$_SESSION['uid'] = $_COOKIE['uid'];
	} else {
		$ip = $_SERVER['REMOTE_ADDR'];
		include_once('connect.php');
		$network = gethostbyaddr($ip);
		$query = "INSERT INTO demo_sessions (ip, time, network) VALUES ('$ip', NOW(), '$network')";
		$r = mysql_query($query) or die(mysql_error());
		$uid = mysql_insert_id();
		$_SESSION['uid'] = $uid;
		setcookie('uid', $uid);
	}
?>