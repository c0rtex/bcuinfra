<li class="search-result">
	<?php
	//print_r($pi);
	
		echo '<img class="search-result-img" src="'.$pi->thumb_src.'" />';
		echo '<a class="search-result-h" href="'.$pi->permalink.'">'.$pi->post_title.'</a>';
	?>
	
	 <a class="subheader-tag <?=$pi->post_type?>-tag"><?= $pi->post_type_info->labels->singular_name ?></a>
		
	
	
	<?php
		echo '<p class="search-result-description">';
		
		echo truncate_simple(strip_tags($pi->post_content), 145);
		if (get_current_user_id() == 1){
			echo ' <a href="/wp-admin/post.php?post='.$pi->ID.'&action=edit">Edit</a> <strong>'.$pi->post_name.'</strong>';
		}
		echo '</p>';
	?>
</li>
	
    