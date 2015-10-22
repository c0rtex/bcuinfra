<?php 
	echo '<div class="qs-sort-container"></div> <!-- /.qs-sort-container -->';
	
	$term = $wp_query->query_vars['term'];
	$tax = $wp_query->query_vars['taxonomy'];
	
	$types = array('any', 'planners', 'calculators', 'how-to', 'learn-more');
	foreach($types as $type){
		
		$posts = get_taxonomy_posts($term, $tax, $type);
		echo '<div class="topic-sort-'.$type.' qs-sorter home-sort-hidden">';	
		foreach($posts as $post){
			$pi = get_post_info($post->ID);
			include('template-types.php');
		}
		echo '</div>';
	}
		
	?>



