<?php
	
	echo '<a class="square-tease gsa" href="'.$pi->permalink.'" data-id="'.$pi->ID.'" data-status="'.$pi->post_status.'">';
	$post_type = get_post_type_object($pi->post_type);
		echo '<img class="square-tease-img" src="'.getPostImageSrc($pi->ID).'" />';
		echo '<h4 class="square-tease-label content-type '.$pi->post_type.'-tag">'.$post_type->labels->singular_name.'</h4>';
		echo '<div class="square-tease-sub"><p>'.truncate_simple($pi->post_content, 145).'</p></div>';
		echo '<h3 class="square-tease-h">'.$pi->post_title.'</h3>';
	echo '</a> <!-- /.square-tease -->';
	
?>
