<?php
/**
 * The Template for displaying "Learn More" single posts.
 *
 * @package WordPress
 * @subpackage Boilerplate
 * @since Boilerplate 1.0
 */

get_header(); ?>
HELLOOOOOO
<?php 
	$current_user = wp_get_current_user();
	if ($current_user->ID != 0  || true) {
?>
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

			<!-- Breadcrumb -->
			<?php
				echo shebang_get_breadcrumb();
			?>
			
			<!-- Column 1: Header Text -->
			
			<hgroup class="article-hgroup col-1">
				<h1 class="article-hdr-h1">HIIIIII<?php the_title(); ?> POO!</h1>
				
				<div class="article-subheader-group">
					<div class="article-page-icon-container">
						<img class="article-page-icon" src="<?php echo getPostImageSrc(get_the_ID()); ?>" />
					</div> 
					<h3 class="article-h1-subheader"><a class="subheader-tag learn-more-tag" href="<?php echo home_url( '/' ).get_post_type(get_the_ID()); ?>"><?php echo get_post_type_singular_name(get_the_ID()); ?></a>
					<?php echo get_the_content(get_the_ID()); ?></h3>
				</div> <!-- /.article-subheader-group -->
			
			</hgroup> <!-- /.article-hgroup -->

			
			<!-- Column 2: Action Button -->
			<?php
			
			if ($pi->post_type != 'calculators'){
				echo '<div class="article-hdr-action-col col-2">
				<a href="#" class="print-btn article-hdr-print-btn trigger-print"><span class="print-btn-icon"></span>Print</a></div> <!-- /article-hdr-action-col -->';
			}
			?>
		
<!--		<div class="article-hdr-action-col col-2 tip-trigger">
				<a class="article-hdr-action-btn" href="#">Add to Action Plan</a>
				<p class="article-hdr-action-text tooltip">Add "php the_title(); /php" to your Action Plan</p>
			</div> <!-- /article-hdr-action-col -->

		
		</header> <!-- /.article-page-header -->



		<!-- ================================= --> 
		
		<!-- ! Article Container & Body		   --> 
		
		<!-- ================================= -->

		<section class="article-container">
			
			<section class="article-body">
				
				<div class="article-body-col-group">

					<!-- Column 1: Article Navigation -->
					<div class="article-body-nav-col col-1">
						<ul id="fixed-article-body-nav" class="article-body-nav">
							<?php 
							/* --------------- Menu Parent Loop ---------------- */
							
							$link_args = array('showposts' => 20, 'post_parent' => get_the_ID(), 'post_type' => $pi->post_type, 'orderby' => 'menu_order', 'order' => 'ASC');
							$link_query = new WP_Query($link_args);
							$linknum = 1;
							while ($link_query->have_posts()) : $link_query->the_post(); ?>
							<li id="<?php echo 'article-body-nav-item-'.$linknum; ?>" class="article-body-nav-item <?php if ($linknum==1) {echo 'item-active';} ?>">
								<a href="#block-<?php echo get_the_ID(); ?>"><?php the_title(); ?></a></li>
								<?php $linknum++; ?>
							<?php 
							endwhile;
							wp_reset_postdata();
							?>
							
						</ul> <!-- /.article-body-nav -->			 		
					</div> <!-- /.col-1 /.article-body-nav-col -->
	
	
					<!-- Column 2: Article Content -->
					<div class="article-content-col col-2">
						
					<?php
					/* --------------- Parent Loop ---------------- */
					
					$parent_args = array('showposts' => 20, 'post_parent' => get_the_ID(), 'orderby' => 'menu_order', 'order' => 'ASC', 'post_type' => $pi->post_type);
					$parent_query = new WP_Query($parent_args);
					$linknum = 1;
					if(!$parent_query->post_count){
						echo '<article id="post-0" class="construction-group not-found" role="main">';
						echo '<h1 class="construction-h">'.get_editable_title(1265).'</h1>';
						echo '<p class="construction-sub">'.get_editable_furniture(1265).'</p>';
						echo '</article>';
					}
					$i = 0;
					while ($parent_query->have_posts()) : $parent_query->the_post(); ?>
					
						<!-- Article Block -->
						<article class="ui-article-block" id="block-<?php echo get_the_ID(); ?>">
							<?php 
							$bigheading = get_post_meta(get_the_ID(), 'big-heading', true);
							if ($bigheading != '') {
								echo '<h2 class="article-h1">'.$bigheading.'</h2>';
							}
							$smallheading = get_post_meta(get_the_ID(), 'small-heading', true);
							if ($smallheading != '') {
								echo '<h3 class="article-h2">'.$smallheading.'</h3>';
							}
							?>
							<div class="article-text"><?php 
								the_content();
								shebang_edit_link();
							?></div>
							
							<?php
							/* --------------- Child Loop ---------------- */
							
							$child_args = array('showposts' => 20, 'post_parent' => get_the_ID(), 'orderby' => 'menu_order', 'order' => 'ASC', 'post_type' => $pi->post_type);
							$child_query = new WP_Query($child_args);
							$linknum = 1;
							while ($child_query->have_posts()) : $child_query->the_post();
								$img = getPostImageSrc(get_the_ID());
								$video = get_post_meta(get_the_ID(), 'video-url', true);
								$displaystyle = get_post_meta(get_the_ID(), 'img-display-style', true);
								$vidid = '';
								if ($video != '') {
									$pos = strpos($video, 'youtube');
									if ($pos !== false) {
										$vidid = substr($video, 31, 11);
									}
								}
								if ($vidid != '') { ?>
									<!-- UI Pattern: Art Caption -->
									<div class="ui-pattern-art-caption">					
										<div class="article-large-art-container col-1">
											<div class="article-large-img">
												<iframe width="400" height="205" src="http://www.youtube.com/embed/<?php echo $vidid; ?>" frameborder="0"></iframe>
											</div>
										</div> <!-- /.article-small-art-container -->
										
										<div class="article-caption-col col-2">
											<p><strong><?php the_title(); ?></strong></p>
											<?php the_content(); ?>
											<?php shebang_edit_link() ?>
										</div> <!-- /.article-text /.col-2-->
			
									</div> <!-- /.ui-pattern-art-caption -->
								<?php } else if ($img != '') { ?>
									<?php if ($displaystyle == 'Large Image') { ?>
										<!-- UI Pattern: Art Caption -->
										<div class="ui-pattern-art-caption">					
											<div class="article-large-art-container col-1">
												<img class="article-large-img" src="<?php echo getPostImageSrc(get_the_ID()); ?>" />
											</div> <!-- /.article-small-art-container -->
											
											<div class="article-caption-col col-2">
												<p><strong><?php the_title(); ?></strong></p>
												<?php the_content(); ?>
												<?php shebang_edit_link() ?>
											</div> <!-- /.article-text /.col-2-->
				
										</div> <!-- /.ui-pattern-art-caption -->
									<?php } else { ?>
										<!-- UI Pattern: Small Art -->
										<div class="ui-pattern-small-art">					
											<div class="article-small-art-container col-1">
												<img class="article-small-img" src="<?php echo getPostImageSrc(get_the_ID()); ?>" />
											</div> <!-- /.article-small-art-container -->
											
											<div class="article-text col-2">
												<h4 class="article-h3"><?php the_title(); ?></h4>
												<?php the_content(); ?>
												<?php shebang_edit_link() ?>
											</div> <!-- /.article-text /.col-2-->
				
										</div> <!-- /.ui-pattern-small-img -->
									<?php } ?>
								<?php } else { ?>
									<!-- UI Pattern: Simple Text -->
									<div class="ui-pattern-simple-text">					
										<h4 class="article-h3"><?php the_title(); ?></h4>
										<?php the_content(); ?>
										<?php shebang_edit_link() ?>
									</div> <!-- /.ui-pattern-simple-text -->
								<?php } 
							endwhile;
							wp_reset_postdata();
							$i++;
							if ($i == $parent_query->post_count && $pi->post_type != 'calculators'){
								echo '<a href="#" class="print-btn article-body-print-btn trigger-print"><span class="print-btn-icon"></span>Print</a>';
							}
							
							?>
							
						</article> <!-- /.ui-article-block -->
						
					<?php endwhile;
					wp_reset_postdata();
					?>
						<?php
							if ($pi->post_type != 'calculators'){
								
							}
						?>

					</div> <!-- /.article-content-col -->
				
				</div> <!-- /.article-body-col-group -->
			
			</section> <!-- article-body -->
			
		</section> <!-- article-container -->
	
	</div> <!-- /#main -->
	
<?php 
get_sidebar();
get_footer(); ?>
<?php endwhile; // end of the loop. 
} else {
	echo '<hgroup class="frame-hgroup">
					<h1 class="frame-h1">Please Login</h1>
					<h2 class="frame-h2">To use '.get_the_title().', please <a href="/wp-login.php">login to your account</a>.</h2>
				</hgroup>';
}
?>