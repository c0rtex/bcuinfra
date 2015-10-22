<?php

	$tt = 'a';
	if (isset($tag_type)){
		$tt = $tag_type;
	}
	
	echo '<'.$tt.' class="square-tease" href="'.$pi->permalink.'" data-id="'.$pi->ID.'" data-status="'.$pi->post_status.'"';
	$tags = wp_get_post_tags($pi->ID);
	
	foreach($tags as $tag){
		echo ' data-issue-'.$tag->slug.'="1" ';
	}
	echo '>';
	$post_type = get_post_type_object($pi->post_type);
		echo '<img class="square-tease-img" src="'.getPostImageSrc($pi->ID).'" />';
		echo '<h4 class="square-tease-label content-type '.$pi->post_type.'-tag">'.$post_type->labels->singular_name.'</h4>';
		echo '<div class="square-tease-sub"><p>'.truncate_simple(strip_tags($pi->post_content), 145).'</p></div>';
		echo '<h3 class="square-tease-h">'.$pi->post_title.'</h3>';
	echo '</'.$tt.'> <!-- /.square-tease -->';
	
?>
