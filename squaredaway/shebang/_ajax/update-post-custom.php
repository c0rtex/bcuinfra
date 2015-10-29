<?php

	include($_SERVER['DOCUMENT_ROOT'].'/wp-load.php');

	$pid = $_POST['pid'];
	$content = $_POST['content'];
	$key = $_POST['key'];
	if (strlen(get_shebang_edit_link($pid))){
		return update_post_meta($pid, $key, $content);
	}
	return false;
?>