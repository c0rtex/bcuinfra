<?php

	echo '<div class="qs-sort-container"></div>';

	$posts = get_taxonomy_posts('everyday-money', 'post_tag', 'any', 8);
	echo '<div class="home-sort-everyday-money qs-sorter home-sort-hidden">';
	foreach($posts as $post){
		$pi = get_post_info($post->ID);
		include('template-types.php');
	}
	echo '</div>';
	
	/* Retirement */
	$posts = get_taxonomy_posts('retirement', 'life-stages', 'any', 8);
	echo '<div class="home-sort-retirement home-sort-hidden qs-sorter">';
	foreach($posts as $post){
		$pi = get_post_info($post->ID);
		include('template-types.php');
	}
	echo '</div>';
	
	/* Housing */
	$posts = get_taxonomy_posts('housing', 'post_tag', 'any', 8);
	echo '<div class="home-sort-housing home-sort-hidden qs-sorter">';
	foreach($posts as $post){
		$pi = get_post_info($post->ID);
		include('template-types.php');
	}
	echo '</div>';
	
	/* Reserves & Insurance */
	$posts = get_taxonomy_posts('reserves-insurance', 'post_tag', 'any', 8);
	echo '<div class="home-sort-reserves-insurance home-sort-hidden qs-sorter">';
	foreach($posts as $post){
		$pi = get_post_info($post->ID);
		include('template-types.php');
	}
	echo '</div>';
	
	
	
	
	/* Investments & Debt */
	$posts = get_taxonomy_posts('savings-and-debt', 'post_tag', 'any', 8);
	echo '<div class="home-sort-investments-debt home-sort-hidden qs-sorter">';
	foreach($posts as $post){
		$pi = get_post_info($post->ID);
		include('template-types.php');
	}
	echo '</div>';

//learn-more

?>