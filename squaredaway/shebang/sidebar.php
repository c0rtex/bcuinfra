<!-- <section class="square-tease-strip"> -->
		<?php
/*
			wp_reset_query();
			$tags = get_the_tags();
			$pi = get_post_info();
			if (is_array($tags) || strlen($pi->related_posts)){
				$sidebar_title = 'Related Programs';
			} else {
				//echo 'no tags';
				$sidebar_title = 'Popular Programs';
			}
			echo '<h2 class="site-section-h square-tease-strip-h">'.$sidebar_title.'</h2>';
			$posts = get_top_level_posts('any', 4);
			
			if ($pi->related_posts){
				$related = explode(',', $pi->related_posts);
				$rps = array();
				foreach($related as $r){
					if (strlen(trim($r))){
						$rel = get_post_info(trim($r));
						$rps[] = $rel;
					}	
				}
				$posts = array_merge($rps, $posts);
				array_splice($posts, 4);
				
			}
			foreach($posts as $post){
				$pi = get_post_info($post->ID);
				include('template-types.php');
			}
*/
		?>
		
		
	
	<!--</section>  /.square-tease-strip -->
