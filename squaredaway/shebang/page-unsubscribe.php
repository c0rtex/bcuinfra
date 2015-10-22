<?php
	$email = $_GET['mail'];
	if ($email){
		include("_ajax/wp-connect.php");
		$query = "DELETE FROM shebang_emails WHERE email = '$email'";
		mysql_query($query);
		mysql_close();
	}
	include_once('page.php');