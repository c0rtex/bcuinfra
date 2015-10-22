<?php

	$pi = get_post_info();
	if (isset($pi->template)){
		if ($pi->template == 'Planner'){
			include_once('single-planners.php');
			return;
		}
	}
	if ($pi->post_parent){
		$parent = get_post_info($pi->post_parent);
		if ($parent->template == 'Planner'){
			include_once('single-planners.php');
			return;
		}
	}
/**
 * The Template for displaying "Learn More" single posts.
 *
 * @package WordPress
 * @subpackage Boilerplate
 * @since Boilerplate 1.0
 */

get_header(); ?>


<?php 
/* --------------- Grandparent Loop ---------------- */

if ( have_posts() ) while ( have_posts() ) : the_post(); ?>

	<?php
		$pi = get_post_info();
	?>
				
	<!-- ================================= --> 
	<!-- ! Start #main div container	   --> 
	<!-- ================================= -->

	<div id="main" class="main-article" role="main">

		<!-- ================================= --> 
		
		<!-- ! Article Page Header			   --> 
		
		<!-- ================================= -->
		
		<header class="article-page-hdr">


			<!-- Share Tools -->
			<article id="generic-addthis" class="article-page-hdr-share">  
				<?php include('_includes/share-tools.php'); ?>
			</article>			

			<!-- Breadcrumb -->
			<?php
				echo shebang_get_breadcrumb();
			?>
			
			<!-- Column 1: Header Text -->
			 
			<hgroup class="article-hgroup col-1">
				<h1 class="article-hdr-h1"><?php the_title(); ?></h1>
				
				<div class="article-subheader-group">
					<div class="article-page-icon-container">
						<img class="article-page-icon" src="<?php echo getPostImageSrc(get_the_ID()); ?>" />
					</div> 
					<?php 
						echo '<h3 class="article-h1-subheader">';
						//echo '<a class="subheader-tag '.$pi->post_type.'-tag" href="'.home_url( '/' ).get_post_type(get_the_ID()) .'">'.get_post_type_singular_name(get_the_ID()).'</a>' 
					?>
					<?php echo get_the_content(get_the_ID()); ?></h3>
					<?php
						shebang_edit_link($pi->ID, 'Edit '.$pi->post_type_info->labels->singular_name);
					?>
				</div> <!-- /.article-subheader-group -->
			
			</hgroup> <!-- /.article-hgroup -->

			
			<!-- Column 2: Action Button -->
			<?php
			
			if ($pi->post_type != 'calculators'){
				echo '<div class="article-hdr-action-col col-2">
				<a href="#" class="print-btn article-hdr-print-btn trigger-print"><span class="print-btn-icon"></span>Print</a></div> <!-- /article-hdr-action-col -->';
			}
			?>


		
		</header> <!-- /.article-page-header -->

	<?php
	
		if ($pi->include){
			include_once('_includes/'.$pi->include);
		} else {
			include_once('loop-single.php');
		}
	?>
	
	</div> <!-- /#main -->
	
<?php 
get_sidebar();
get_footer(); ?>
<?php endwhile; // end of the loop. 