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

<section class="tool-page">

	<header class="page-hdr tool-page-header">

		<!-- Breadcrumb -->
		<ul class="article-breadcrumb">
			<li class="article-bc-item"><a href="/">Home</a></li>
		</ul> <!-- /.article-breadcrumb -->
		
		<hgroup class="page-hgroup tool-page-hgroup">
			<h1 class="page-h tool-page-h"><?php
				if ( is_day() ) :
					printf( __( 'Daily Archives: %s', 'boilerplate' ), get_the_date() );
				elseif ( is_month() ) :
					printf( __( 'Monthly Archives: %s', 'boilerplate' ), get_the_date('F Y') );
				elseif ( is_year() ) :
					printf( __( 'Yearly Archives: %s', 'boilerplate' ), get_the_date('Y') 
					);
				elseif (is_post_type_archive()):
					printf( __('%s', 'boilerplate'), post_type_archive_title()
					);
				else :
					_e( 'Baaalog Archives', 'boilerplate' );
				endif;
			?></h1>
			<!-- Show this headline only if they've written it -->				
			<h2 class="page-h2 tool-page-h2">
			<?php
				$post_type = $wp_query->query_vars['post_type'];
				$obj = get_post_type_object($post_type);
				echo $obj->description;
			?>
			</h2>
		</hgroup>
	
	</header> <!-- /.page-hdr -->
	<section class="tool-page-body">
		<section class="tool-page-square-group col-1">
			<?php
			/* Run the loop for the tag archive to output the posts
			 * If you want to overload this in a child theme then include a file
			 * called loop-tag.php and that will be used instead.
			 */
			 get_template_part( 'loop', 'archive' );
			?>
		</section> <!-- /.tool-page-square-group -->
	
	
		<aside class="tool-page-aside col-2">

			<!-- For now, don't show filters on Planner page. Do show for Learn More / How-To / Calcs. -->
			<section class="aside-filter aside-section">
				<h3 class="aside-h">Show</h3>
				<ul class="square-filters tag-page-square-filters">
					<li class="square-filter-item tag-page-square-filter-item filter-active"><a class="trigger-qs" data-target="topic-sort-all">All</a></li>
					<?php
						$tags = get_terms('post_tag');
						foreach ($tags as $tag){
							echo '<li class="square-filter-item tag-page-square-filter-item"><a class="trigger-qs-'.$tag->slug.' trigger-qs" data-target="topic-sort-'.$tag->slug.'">'.$tag->name.'</a></li>';
						}	
					?>
					<!--
					<li class="square-filter-item tag-page-square-filter-item filter-active"><a class="trigger-qs" data-target="topic-sort-all">All</a></li>
					<li class="square-filter-item tag-page-square-filter-item"><a class="trigger-qs-everyday-money trigger-qs" data-target="topic-sort-everyday-spending">Everyday Spending</a></li>
					<li class="square-filter-item tag-page-square-filter-item"><a class="trigger-qs-retirement trigger-qs" data-target="topic-sort-retirement">Retirement</a></li>
					<li class="square-filter-item tag-page-square-filter-item"><a class="trigger-qs-housing trigger-qs" data-target="topic-sort-housing">Housing</a></li>
					<li class="square-filter-item tag-page-square-filter-item"><a class="trigger-qs-reserves trigger-qs" data-target="topic-sort-reserves-insurance">Reserves &amp; Insurance</a></li>
					<li class="square-filter-item tag-page-square-filter-item"><a class="trigger-qs-wills trigger-qs" data-target="topic-sort-wills-records">Wills &amp; Records</a></li>
					
					<li class="square-filter-item tag-page-square-filter-item"><a class="trigger-qs-loans trigger-qs" data-target="topic-sort-loans">Loans</a></li>-->
				</ul>
			</section> <!-- /.aside-filter -->	
		</aside> <!-- /.tool-page-aside -->
		
	</section> <!-- /.tool-page-body -->

</section> <!-- /.tool-page -->


<?php //get_sidebar(); ?>
<?php get_footer(); ?>