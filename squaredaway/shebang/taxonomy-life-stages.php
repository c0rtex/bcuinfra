<?php
/**
 * The template for displaying Archive pages.
 *
 * Used to display archive-type pages if nothing more specific matches a query.
 * For example, puts together date-based pages if no date.php file exists.
 *
 * Learn more: http://codex.wordpress.org/Template_Hierarchy
 *
 * @package WordPress
 * @subpackage Boilerplate
 * @since Boilerplate 1.0
 */

get_header(); ?>

<?php
	/* Queue the first post, that way we know
	 * what date we're dealing with (if that is the case).
	 *
	 * We reset this later so we can run the loop
	 * properly with a call to rewind_posts().
	 */
	if ( have_posts() )
		the_post();
?>

<section class="tag-page">
	
	<header class="page-hdr tag-page-header">

		<!-- Breadcrumb -->
			<ul class="article-breadcrumb">
				<li class="article-bc-item"><a href="/">Home</a></li>
				<li class="article-bc-item"><a href="/life-stages/">Life Stages</a></li>
			</ul> <!-- /.article-breadcrumb -->
		<?php
			//print_r($wp_query);
			$qo = $wp_query->queried_object;
			$term = $qo;
		?>
		<hgroup class="page-hgroup tag-page-hgroup">
			<h1 class="page-h tag-page-h"><?php
				echo $term->name;
			?></h1>
			<!-- Show this headline only if they've written it -->	
			<h2 class="page-h2 tag-page-h2"><?php
				echo $term->description;
			?></h2>			
		</hgroup>
	
	</header> <!-- /.page-hdr -->
	
	<section class="tag-page-body">
			
			<aside class="tag-page-aside col-1">

			<section class="aside-filter aside-section">
				<h3 class="aside-h">Show</h3>
				<ul class="square-filters tag-page-square-filters">
					<li class="square-filter-item tag-page-square-filter-item filter-active"><a class="trigger-qs" data-target="topic-sort-any">All</a></li>
					<li class="square-filter-item tag-page-square-filter-item"><a class="trigger-qs-planners trigger-qs" data-target="topic-sort-planners">Planners</a></li>
					<li class="square-filter-item tag-page-square-filter-item"><a class="trigger-qs-calculators trigger-qs" data-target="topic-sort-calculators">Calculators</a></li>
					<li class="square-filter-item tag-page-square-filter-item"><a class="trigger-qs-how-tos trigger-qs" data-target="topic-sort-how-to">How-Tos</a></li>
					<li class="square-filter-item tag-page-square-filter-item"><a class="trigger-qs-learn-more trigger-qs" data-target="topic-sort-learn-more">Learn Mores</a></li>
				</ul>
			</section> <!-- /.aside-filter -->

			<!-- Should only show this section only if they've written the corresponding topic-rail text -->	
			<section class="aside-text aside-section">

				<h3 class="aside-h">
					More About <?php printf( __( '%s', 'boilerplate' ), '' . single_tag_title( '', false ) . '' ); ?>
				</h3>

				<section class="aside-text">
				<?php
					$post = get_posts(array(
						'post_type' => 'furniture', 
						'tax_query' => array(
							'relation' => 'AND',
							array(
								'taxonomy' => 'furniture-types',
								'field' => 'slug',
								'terms' => array('topic-rail')
							),
							array(
								'taxonomy' => 'life-stages',
								'field' => 'slug',
								'terms' => array($term->slug),
							)
						)
					));
					$post = $post[0];
					if ($post->post_content){
						echo $post->post_content;
						echo '<p>';
						shebang_edit_link($post->ID);
						echo '</p>';
					} else {
						echo $term->description;
						echo '<p><a href="/wp-admin/edit-tags.php?action=edit&taxonomy=life-stages&tag_ID='.$term->term_id.'&post_type=how-to">Edit</a></p>';
					}
				?>
				</section> <!-- /.aside-text -->
			</aside> <!-- /.tag-page-aside -->

			<section class="tag-page-square-group col-2">
				<?php
				/* Run the loop for the tag archive to output the posts
				 * If you want to overload this in a child theme then include a file
				 * called loop-tag.php and that will be used instead.
				 */
				 get_template_part( 'loop', 'taxonomy' );
				?>
			</section> <!-- /.tag-page-square-group -->
		
	</section> <!-- /.tag-page-body -->

</section> <!-- /.tag-page -->


<?php //get_sidebar(); ?>
<?php get_footer(); ?>