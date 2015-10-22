<?php

	include_once("connect.php");
	$tdid = intval($_POST['tdid']);
	$status = mysql_real_escape_string($_POST["status"]);
	$ret = array();
	$action = mysql_real_escape_string($_POST["action"]);	
	include('../_includes/cys-functions.php');
	if (trim(strtolower($action)) == 'delete'){
		$ret['tdid'] = cys_delete_todo($tdid);
	} else {
		$tdid = cys_update_todo_status($tdid, $status);
		$ret['tdid'] = $tdid;
	}
	echo json_encode($ret);
	mysql_close();
	
?>