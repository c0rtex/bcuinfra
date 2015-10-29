<?php
	include('wp-connect.php');
	
	if (is_user_logged_in()){
		get_currentuserinfo();
		$uid = $current_user->ID;
		$field = $_POST['field'];
		$value = $_POST['value'];
		$res = update_user_meta($uid, $field, $value);
		echo "update $field to $value";
		return $res;
	} else {
		$_SESSION[$field] = $value;
	}
?>