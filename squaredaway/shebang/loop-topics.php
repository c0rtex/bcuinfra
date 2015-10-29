<?php 
	echo '<div class="qs-sort-container"></div> <!-- /.qs-sort-container -->';
	
	$tag = $wp_query->query_vars['tag'];
	$types = array('any', 'planners', 'calculators', 'how-to', 'learn-more');
	$stag = $tag;
	foreach($types as $type){
		$posts = get_taxonomy_posts($stag, 'post_tag', $type);
		echo '<div class="topic-sort-'.$type.' qs-sorter home-sort-hidden">';	
		foreach($posts as $post){
			$pi = get_post_info($post->ID);
			include('template-types.php');
		}
		echo '</div>';
	}
		
	?>



