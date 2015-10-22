<?php

	include($_SERVER['DOCUMENT_ROOT'].'/wp-load.php');

	$pid = $_POST['pid'];
	$content = $_POST['content'];
	$title = $_POST['title'];
	
	$post = array();
	$post['ID'] = $pid;
	if (strlen(get_shebang_edit_link($pid))){
		if (strlen($content)){
			$post['post_content'] = $content;
		} else if (strlen($title)){
			$post['post_title'] = $title;
		}
		return wp_update_post($post);
	}
	

?>