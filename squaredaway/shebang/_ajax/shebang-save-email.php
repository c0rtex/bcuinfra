<?php

	include('wp-connect.php');

	$uemail = strtolower($_POST['uemail']);
	$ufreq = strtolower($_POST['ufreq']);
	$treatment = strtolower($_POST['treatment']);
	$content = mysql_real_escape_string(trim($_POST['content']));	
	$query = "UPDATE shebang_emails SET freq = '$ufreq' AND content = '$content' WHERE email = '$uemail' AND treatment = '$treatment'";
	$r = mysql_query($query);
	$query = "SELECT * FROM shebang_emails WHERE email = '$uemail' AND treatment = '$treatment'";
	$r = mysql_query($query);
	$r = mysql_num_rows($r);
	if (!$r || $r < 0){
		$query = "INSERT INTO shebang_emails (email, freq, treatment) VALUES ('$uemail', '$ufreq', '$treatment')";
		echo $query;
		mysql_query($query);
	}
	mysql_close();


?>