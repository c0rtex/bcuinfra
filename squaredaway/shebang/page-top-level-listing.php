<?php
/*
Template Name: Top-Level Listing
*/
get_header(); ?>


<section class="listing-page">

	<header class="page-hdr listing-page-header">

		<!-- Breadcrumb -->
		<ul class="article-breadcrumb">
			<li class="article-bc-item"><a href="/">Home</a></li>
		</ul> <!-- /.article-breadcrumb -->
	
		<hgroup class="page-hgroup listing-page-hgroup">
			<h1 class="page-h listing-page-h">
				<?php the_title(); ?></h1>
		</hgroup>

	</header> <!-- /.page-hdr -->


	<section class="listing-page-body">
		<?php
			global $query_string;
			parse_str($query_string, $args);
			$t = get_taxonomies();
			$taxonomy = $args['pagename'];
			if ($args['pagename'] == 'topics'){
				$taxonomy = 'post_tag';
			}
			if ($taxonomy == 'tools'){
				$types = array('calculators', 'how-to', 'learn-more');
				foreach($types as $type){
					$term = get_post_type_object($type);
					$term->type = $term->name;
					$term->name = $term->labels->name;
					$terms[] = $term;
				}
			} else {
				$terms = get_terms($taxonomy);
			}
			foreach($terms as $term){
				if ($term->slug){
					$term->link = $args['pagename'].'/'.$term->slug;
				} else {
					$term->link = $term->type;
				}
				echo '<section class="listing-group">';
				echo '<article class="listing-title-group col-1">
				<h2 class="listing-title-h"><a href="/'.$term->link.'">'.$term->name.'</a></h2>
				<p class="listing-description">'.$term->description.'</p>
				<a class="listing-title-link" href="/'.$term->link.'">See All &raquo;</a>
				</article> <!-- /.listing-page-body -->';
				echo '<article class="listing-square-group col-2">';
				$tags = get_the_tags();
				$type = 'any';
				if ($args['pagename'] == 'tools'){
					$type = $term->type;
				}
				if ($term->slug){
					$posts = get_taxonomy_posts($term->slug, $taxonomy, $type, 3);
				} else {
					$posts = get_top_level_posts($type, 3);
				}
					foreach($posts as $post){
						$pi = get_post_info($post->ID);
						include('template-types.php');
					}
				echo '</article> <!-- /.listing-square-group -->';
				echo '</section> <!-- /.listing-group -->';
			}
			
		?>
	</section> <!-- /.listing-page-body -->
	
			
		
			
				
		

		
<?php get_footer(); ?>