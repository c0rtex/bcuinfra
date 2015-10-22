<?php 
	//print_r();
	
	echo '<div class="qs-sort-container"></div>';
	
	
	$type = trim($wp_query->query_vars['post_type']);
	if ($type == 'planners'){
		$type = array('planners', 'calculators');
	}
	$query = array('posts_per_page' => -1, 'post_type' => $type, 'post_parent' => 0, 'orderby' => 'title', 'order' => 'ASC');

	$posts = get_posts($query);
	echo '<div class="topic-sort-all qs-sorter home-sort-hidden">';
	foreach($posts as $post){
		$pi = get_post_info($post->ID);
		include('template-types.php');
	}
	echo '</div>';
	
	
	/* Retirement */
	$posts = get_taxonomy_posts('retirement', 'life-stages', $type);
	
	echo '<div class="topic-sort-retirement home-sort-hidden qs-sorter">';
	foreach($posts as $post){
		$pi = get_post_info($post->ID);
		include('template-types.php');
	}
	echo '</div>';

	$tags = get_terms('post_tag');
	foreach($tags as $tag){
		$posts = get_taxonomy_posts($tag->slug, 'post_tag', $type);
		echo '<div class="topic-sort-'.$tag->slug.' home-sort-hidden qs-sorter">';
		foreach($posts as $post){
			$pi = get_post_info($post->ID);
			include('template-types.php');
		}
		echo '</div>';
	}
	?>



